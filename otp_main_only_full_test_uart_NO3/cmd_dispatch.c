#include "cmd_dispatch.h"
#include "cmd_uart.h"
#include "asm_swint.h"
#include "otp_patch.h"
#include "ls_hal_otp_ctrl.h"
#include "ls_hal_sm4.h"
#include "ls_soc_gpio.h"
#include <string.h>
#include <stdbool.h>
#include <stddef.h>

#define CRYPTO_BUSY_GPIO    PA05

typedef int8_t (*cmd_handler_t)(const uint8_t *in, uint16_t in_len,
                                uint8_t *out, uint16_t *out_len);

static bool s_authed;
static char s_pwd[33];
static uint32_t s_busy_depth;

/* ---------- PA05 运算状态 ----------
 * 只在 Invoke_* 接口调用期间拉高（由 asm_swint.c 和各 handler 调用），
 * 不包含参数校验、鉴权判断、应答组包和串口收发时间。 */
void crypto_busy_enter(void)
{
    if (s_busy_depth++ == 0) {
        io_set_pin(CRYPTO_BUSY_GPIO);
    }
}

void crypto_busy_exit(void)
{
    if (s_busy_depth && --s_busy_depth == 0) {
        io_clr_pin(CRYPTO_BUSY_GPIO);
    }
}

/* ---------- 工具 ---------- */
static int8_t map_status(int ret)
{
    if (ret == 2) {                     /* GenerateKey 非法 id 返回 +2 */
        return ACK_ERR_INVALID_ID;
    }
    return (int8_t)ret;
}

static void session_clear(void)
{
    memset(s_pwd, 0, sizeof(s_pwd));
    s_authed = false;
}

/* 请求里的口令不带 '\0'，这里拷贝并补上 */
static int8_t copy_password(const uint8_t *in, uint16_t in_len, char *pwd)
{
    if (in_len < 12 || in_len > 32) {
        return ACK_ERR_INVALID_ID;
    }
    memcpy(pwd, in, in_len);
    pwd[in_len] = '\0';
    return ACK_SUCCESS;
}

/*
 * 统一取口令规则（所有需要鉴权的命令共用）：
 *   in_len == fixed_len              → 命令没带口令：必须已 AUTH，使用会话口令 s_pwd
 *   in_len == fixed_len + 12~32      → 命令尾随临时口令：仅本次使用，不改变会话
 *   其它长度                          → 参数非法
 * 同时存在时以请求里的临时口令为准，不与会话口令比较。
 * 返回 ACK_SUCCESS 时 *pwd 指向有效口令字符串。
 */
static char s_req_pwd[33];

static int8_t take_password(const uint8_t *in, uint16_t in_len, uint16_t fixed_len,
                            const char **pwd)
{
    uint16_t pwd_len;

    if (in_len < fixed_len) {
        return ACK_ERR_INVALID_ID;
    }

    if (in_len == fixed_len) {
        if (!s_authed) {
            return ACK_ERR_NO_PERMISSION;   /* 既没会话也没口令 → 拒绝执行 */
        }
        *pwd = s_pwd;
        return ACK_SUCCESS;
    }

    pwd_len = (uint16_t)(in_len - fixed_len);
    if (pwd_len < 12 || pwd_len > 32) {
        return ACK_ERR_INVALID_ID;
    }
    memcpy(s_req_pwd, in + fixed_len, pwd_len);
    s_req_pwd[pwd_len] = '\0';
    *pwd = s_req_pwd;
    return ACK_SUCCESS;
}

/* ---------- 0x01 PING ---------- */
static int8_t h_ping(const uint8_t *in, uint16_t in_len,
                     uint8_t *out, uint16_t *out_len)
{
    (void)in; (void)in_len; (void)out;
    *out_len = 0;
    return ACK_SUCCESS;
}

/* ---------- 0x02 AUTH ---------- */
static int8_t h_auth(const uint8_t *in, uint16_t in_len,
                     uint8_t *out, uint16_t *out_len)
{
    char pwd[33];
    int8_t st;
    int ret;

    (void)out;
    *out_len = 0;

    st = copy_password(in, in_len, pwd);
    if (st != ACK_SUCCESS) {
        return st;
    }

    ret = Invoke_Check_password(pwd);
    if (ret != ACK_SUCCESS) {
        return map_status(ret);
    }

    memcpy(s_pwd, pwd, sizeof(s_pwd));
    s_authed = true;
    return ACK_SUCCESS;
}

/* ---------- 0x03 LOGOUT ---------- */
static int8_t h_logout(const uint8_t *in, uint16_t in_len,
                       uint8_t *out, uint16_t *out_len)
{
    (void)in; (void)in_len; (void)out;
    session_clear();
    *out_len = 0;
    return ACK_SUCCESS;
}

/* ---------- 0x04 GET_INFO ---------- */
static int8_t h_get_info(const uint8_t *in, uint16_t in_len,
                         uint8_t *out, uint16_t *out_len)
{
    (void)in; (void)in_len;
    out[0] = 1;                        /* 协议版本 */
    out[1] = s_authed ? 1 : 0;         /* 会话状态 */
    out[2] = 0;
    out[3] = 0;
    *out_len = 4;
    return ACK_SUCCESS;
}

/* ---------- 0x05 SET_PASSWORD（产线专用） ---------- */
#if CMD_ENABLE_SET_PASSWORD
static int8_t h_set_password(const uint8_t *in, uint16_t in_len,
                             uint8_t *out, uint16_t *out_len)
{
    char pwd[33];
    int8_t st;

    (void)out;
    *out_len = 0;

    st = copy_password(in, in_len, pwd);
    if (st != ACK_SUCCESS) {
        return st;
    }
    return map_status(Invoke_Set_password(pwd));
}
#endif

/* ---------- 0x06 CHECK_PASSWORD ---------- */
static int8_t h_check_password(const uint8_t *in, uint16_t in_len,
                               uint8_t *out, uint16_t *out_len)
{
    char pwd[33];
    int8_t st;

    (void)out;
    *out_len = 0;

    st = copy_password(in, in_len, pwd);
    if (st != ACK_SUCCESS) {
        return st;
    }
    return map_status(Invoke_Check_password(pwd));
}

/* ---------- 0x10 SM3 ---------- */
static int8_t h_sm3(const uint8_t *in, uint16_t in_len,
                    uint8_t *out, uint16_t *out_len)
{
    Invoke_SM3_cal(in, in_len, out);
    *out_len = 32;
    return ACK_SUCCESS;
}

/* ---------- 0x11 GENKEY ---------- */
static int8_t h_genkey(const uint8_t *in, uint16_t in_len,
                       uint8_t *out, uint16_t *out_len)
{
    key_id_x id;
    int ret;

    (void)out;
    *out_len = 0;

    if (in_len != 1) {
        return ACK_ERR_INVALID_ID;
    }

    id = (key_id_x)in[0];
    if (id != IDx_TMP_SM2_DEC &&
        id != IDx_TMP_SM2_SIGN &&
        id != IDx_TMP_SM4) {
        return ACK_ERR_INVALID_ID;
    }

    ret = Invoke_GenerateKey(id);
    return map_status(ret);
}

/* ---------- 0x12 GETPUBKEY ---------- */
static int8_t h_getpubkey(const uint8_t *in, uint16_t in_len,
                          uint8_t *out, uint16_t *out_len)
{
    key_id_x id;
    int ret;

    if (in_len != 1) {
        return ACK_ERR_INVALID_ID;
    }

    id = (key_id_x)in[0];
    if (id != IDx_OTP_SM2_DEC &&
        id != IDx_OTP_SM2_SIGN &&
        id != IDx_TMP_SM2_DEC &&
        id != IDx_TMP_SM2_SIGN) {
        return ACK_ERR_INVALID_ID;
    }

    ret = Invoke_GetPubKey(id, out);
    if (ret != ACK_SUCCESS) {
        return map_status(ret);
    }

    *out_len = 64;
    return ACK_SUCCESS;
}

/* ---------- 0x13 SM4_EXPORT ---------- */
static int8_t h_sm4_export(const uint8_t *in, uint16_t in_len,
                           uint8_t *out, uint16_t *out_len)
{
    key_id_x id;
    bool std;
    uint32_t key_len;
    uint32_t ct_len;
    int ret;

    if (in_len != 2) {
        return ACK_ERR_INVALID_ID;
    }

    id = (key_id_x)in[0];
    std = (in[1] != 0);
    if (id < IDx_OTP_SM4 || id > IDx_TMP_SM4) {
        return ACK_ERR_INVALID_ID;
    }

    key_len = (id == IDx_OTP_SM4 || id == IDx_TMP_SM4) ? 16 : 32;
    ct_len = 0x40 + 0x20 + key_len;
    if (ct_len > CMD_MAX_DATA) {
        return CMD_ERR_TOO_LONG;
    }

    ret = Invoke_ExportKey(id, out, std);
    if (ret != ACK_SUCCESS) {
        return map_status(ret);
    }

    *out_len = ct_len;
    return ACK_SUCCESS;
}

/* ---------- 0x14 KEY_IMPORT ---------- */
static int8_t h_key_import(const uint8_t *in, uint16_t in_len,
                           uint8_t *out, uint16_t *out_len)
{
    key_id_x target;
    key_id_x dec_id;
    bool std;
    uint32_t key_len;
    uint32_t ct_len;
    int ret;

    (void)out;
    *out_len = 0;

    if (in_len < 3) {
        return ACK_ERR_INVALID_ID;
    }

    target = (key_id_x)in[0];
    dec_id = (key_id_x)in[1];
    std = (in[2] != 0);

    if (target < IDx_TMP_SM2_DEC || target > IDx_TMP_SM4) {
        return ACK_ERR_INVALID_ID;
    }
    if (dec_id < IDx_OTP_SM2_DEC || dec_id > IDx_OTP_SM2_SIGN) {
        return ACK_ERR_INVALID_ID;
    }

    key_len = (target == IDx_TMP_SM4) ? 16 : 32;
    ct_len = 0x40 + 0x20 + key_len;
    if (in_len != 3 + ct_len) {
        return ACK_ERR_INVALID_ID;
    }

    ret = Invoke_ImportKey(target, dec_id, (uint8_t *)in + 3, std);
    return map_status(ret);
}

/* ---------- 0x15 LOAD_PUBKEY ---------- */
static int8_t h_load_pubkey(const uint8_t *in, uint16_t in_len,
                            uint8_t *out, uint16_t *out_len)
{
    int ret;

    (void)out;
    *out_len = 0;

    if (in_len != 64) {
        return ACK_ERR_INVALID_ID;
    }

    /* 可在此增加 SM2 曲线点合法性校验 */
    ret = Invoke_LoadPublicKey((uint8_t *)in);
    return map_status(ret);
}

/* ---------- 0x16 KEY_STORE ---------- */
static int8_t h_key_store(const uint8_t *in, uint16_t in_len,
                          uint8_t *out, uint16_t *out_len)
{
    key_id_x id;
    const char *pwd;
    int ret;

    (void)out;
    *out_len = 0;

    if (in_len < 1) {
        return ACK_ERR_INVALID_ID;
    }

    id = (key_id_x)in[0];
    if (id < IDx_TMP_SM2_DEC || id > IDx_TMP_SM4) {
        return ACK_ERR_INVALID_ID;
    }

    /* [id] 用会话口令；[id][口令] 用临时口令 */
    ret = take_password(in, in_len, 1, &pwd);
    if (ret != ACK_SUCCESS) {
        return ret;
    }

    ret = Invoke_StoreKey(id, pwd);
    return map_status(ret);
}

/* ---------- 0x17 KEY_LOAD ---------- */
static int8_t h_key_load(const uint8_t *in, uint16_t in_len,
                         uint8_t *out, uint16_t *out_len)
{
    key_id_x id;
    const char *pwd;
    int ret;

    (void)out;
    *out_len = 0;

    if (in_len < 1) {
        return ACK_ERR_INVALID_ID;
    }

    id = (key_id_x)in[0];
    if (id > IDx_OTP_SM4) {
        return ACK_ERR_INVALID_ID;
    }

    /* [id] 用会话口令；[id][口令] 用临时口令 */
    ret = take_password(in, in_len, 1, &pwd);
    if (ret != ACK_SUCCESS) {
        return ret;
    }

    ret = Invoke_Load_sram_otp(id, pwd);
    return map_status(ret);
}

/* ---------- 0x18 KEY_DESTROY ---------- */
static int8_t h_key_destroy(const uint8_t *in, uint16_t in_len,
                            uint8_t *out, uint16_t *out_len)
{
    key_id_x id;
    const char *pwd;
    int ret;

    (void)out;
    *out_len = 0;

    if (in_len < 1) {
        return ACK_ERR_INVALID_ID;
    }

    id = (key_id_x)in[0];
    if (id > IDx_TMP_SM4) {          /* 驱动只支持 0~5 */
        return ACK_ERR_INVALID_ID;
    }

    /* [id] 用会话口令；[id][口令] 用临时口令 */
    ret = take_password(in, in_len, 1, &pwd);
    if (ret != ACK_SUCCESS) {
        return ret;
    }

    ret = Invoke_DestroyKey(id, pwd);
    return map_status(ret);
}

/* ---------- 0x20/0x40 共用的 SM4 参数解析与调用 ----------
 * 0x20 和 0x40 的 PAYLOAD 完全一样，只是长度上限不同：
 *   - 0x20：2B 帧长度，max_data = CMD_MAX_DATA
 *   - 0x40：4B 帧长度，max_data = CMD_BULK_MAX_DATA
 * 鉴权、临时口令、CBC IV、OTP 只读加载、Invoke 都只在这里实现一次。
 */
static int8_t sm4_crypt_common(const uint8_t *in, uint32_t in_len,
                               uint8_t *out, uint32_t *out_len,
                               uint32_t max_data)
{
    key_id_x id;
    sm4_mode_t mode;
    sm4_op_t op;
    uint8_t *iv = NULL;
    const char *pwd = NULL;
    uint32_t hdr = 3;
    uint32_t data_len;
    uint8_t mode_raw;
    uint8_t pwd_len = 0;
    bool has_pwd;
    int ret;

    *out_len = 0;

    if (in_len < 3) {
        return ACK_ERR_INVALID_ID;
    }

    id = (key_id_x)in[0];
    mode_raw = in[1];
    op = (sm4_op_t)in[2];

    /* mode bit7=1 表示后面紧跟 [pwd_len][口令 12~32B]（临时口令扩展） */
    has_pwd = (mode_raw & 0x80) != 0;
    mode = (sm4_mode_t)(mode_raw & 0x7F);

    if (id != IDx_OTP_SM4 && id != IDx_TMP_SM4) {
        return ACK_ERR_INVALID_ID;
    }
    if (mode != SM4_MODE_ECB && mode != SM4_MODE_CBC) {
        return ACK_ERR_INVALID_ID;
    }
    if (op != SM4_OP_ENCRYPT && op != SM4_OP_DECRYPT) {
        return ACK_ERR_INVALID_ID;
    }

    if (has_pwd) {
        if (in_len < 4) {
            return ACK_ERR_INVALID_ID;
        }
        pwd_len = in[3];
        if (pwd_len < 12 || pwd_len > 32 || in_len < 4 + pwd_len) {
            return ACK_ERR_INVALID_ID;
        }
        memcpy(s_req_pwd, in + 4, pwd_len);
        s_req_pwd[pwd_len] = '\0';
        pwd = s_req_pwd;
        hdr = 4 + pwd_len;
    }

    if (mode == SM4_MODE_CBC) {
        if (in_len < hdr + 16) {
            return ACK_ERR_INVALID_ID;
        }
        iv = (uint8_t *)in + hdr;
        hdr += 16;
    }

    data_len = in_len - hdr;
    if (data_len == 0 || (data_len % 16) != 0 ||
        data_len > max_data) {
        return ACK_ERR_INVALID_ID;
    }

    if (id == IDx_OTP_SM4) {
        if (!has_pwd) {
            /* 没带临时口令 → 必须已 AUTH，用会话口令 */
            if (!s_authed) {
                return ACK_ERR_NO_PERMISSION;
            }
            pwd = s_pwd;
        }
        ret = Invoke_Load_sram_otp(id, pwd);
        if (ret != ACK_SUCCESS) {
            return map_status(ret);
        }
    }

    ret = Invoke_SM4_enc_dec_process(id, mode, op, iv,
                                     (uint8_t *)in + hdr, out, data_len);
    if (ret != ACK_SUCCESS) {
        return map_status(ret);
    }

    *out_len = data_len;
    return ACK_SUCCESS;
}

/* ---------- 0x20 SM4_CRYPT（ECB/CBC，小数据） ---------- */
static int8_t h_sm4_crypt(const uint8_t *in, uint16_t in_len,
                          uint8_t *out, uint16_t *out_len)
{
    uint32_t out32 = 0;
    int8_t status = sm4_crypt_common(in, in_len, out, &out32, CMD_MAX_DATA);

    if (status == ACK_SUCCESS && out32 <= 0xFFFFu) {
        *out_len = (uint16_t)out32;
    } else {
        *out_len = 0;
        if (status == ACK_SUCCESS) {
            status = CMD_ERR_TOO_LONG;
        }
    }
    return status;
}

/* ---------- 0x23 SM2_ENC ---------- */
static int8_t h_sm2_enc(const uint8_t *in, uint16_t in_len,
                        uint8_t *out, uint16_t *out_len)
{
    bool std;
    const uint8_t *pub;
    const uint8_t *k;
    const uint8_t *pt;
    uint32_t pt_len;
    uint32_t ct_len;
    int ret;

    if (in_len < 1 + 64 + 32 + 1) {
        return ACK_ERR_INVALID_ID;
    }

    std = (in[0] != 0);
    pub = in + 1;
    k = in + 65;
    pt = in + 97;
    pt_len = in_len - 97;
    ct_len = 0x40 + 0x20 + pt_len;

    if (ct_len > CMD_MAX_DATA) {
        return CMD_ERR_TOO_LONG;
    }

    ret = Invoke_SM2_encrypt(pub, pt, pt_len, out, ct_len, (uint8_t *)k, std);
    if (ret != ACK_SUCCESS) {
        return map_status(ret);
    }

    *out_len = ct_len;
    return ACK_SUCCESS;
}

/* ---------- 0x24 SM2_DEC ---------- */
static int8_t h_sm2_dec(const uint8_t *in, uint16_t in_len,
                        uint8_t *out, uint16_t *out_len)
{
    key_id_x id;
    bool std;
    uint32_t pt_len;
    uint32_t ct_len;
    uint32_t fixed_len;
    const char *pwd;
    int ret;

    if (in_len < 4) {
        return ACK_ERR_INVALID_ID;
    }

    id = (key_id_x)in[0];
    std = (in[1] != 0);
    pt_len = ((uint32_t)in[2] << 8) | in[3];

    if (id != IDx_OTP_SM2_DEC && id != IDx_TMP_SM2_DEC) {
        return ACK_ERR_INVALID_ID;
    }
    /* ROM boot_sm2_decrypt 使用固定 352B 栈帧，明文缓冲区在 sp+288，
     * 最多只能放 64B；pt_len > 64 会写穿栈帧导致死机，这里提前拒绝 */
    if (pt_len == 0 || pt_len > 64) {
        return ACK_ERR_INVALID_ID;
    }

    ct_len = 0x40 + 0x20 + pt_len;
    fixed_len = 4 + ct_len;

    if (id == IDx_OTP_SM2_DEC) {
        /* 基本帧后用会话口令；尾部再加 12~32B 口令则用临时口令 */
        ret = take_password(in, in_len, (uint16_t)fixed_len, &pwd);
        if (ret != ACK_SUCCESS) {
            return ret;
        }
        ret = Invoke_Load_sram_otp(id, pwd);
        if (ret != ACK_SUCCESS) {
            return map_status(ret);
        }
    } else if (in_len != fixed_len) {
        return ACK_ERR_INVALID_ID;
    }

    ret = Invoke_SM2_decrypt(id, in + 4, ct_len, out, pt_len, std);
    if (ret != ACK_SUCCESS) {
        return map_status(ret);
    }

    *out_len = pt_len;
    return ACK_SUCCESS;
}

/* ---------- 0x30 SM2_SIGN ---------- */
static int8_t h_sm2_sign(const uint8_t *in, uint16_t in_len,
                         uint8_t *out, uint16_t *out_len)
{
    key_id_x id;
    const char *pwd;
    int ret;

    if (in_len < 1 + 32 + 32) {
        return ACK_ERR_INVALID_ID;
    }

    id = (key_id_x)in[0];
    if (id != IDx_OTP_SM2_SIGN && id != IDx_TMP_SM2_SIGN) {
        return ACK_ERR_INVALID_ID;
    }

    if (id == IDx_OTP_SM2_SIGN) {
        /* 基本帧后用会话口令；尾部再加 12~32B 口令则用临时口令 */
        ret = take_password(in, in_len, 65, &pwd);
        if (ret != ACK_SUCCESS) {
            return ret;
        }
        ret = Invoke_Load_sram_otp(id, pwd);
        if (ret != ACK_SUCCESS) {
            return map_status(ret);
        }
    } else if (in_len != 65) {
        return ACK_ERR_INVALID_ID;
    }

    ret = Invoke_SM2_sign(id, in + 1, in + 33, out);
    if (ret != ACK_SUCCESS) {
        return map_status(ret);
    }

    *out_len = 64;
    return ACK_SUCCESS;
}

/* ---------- 0x31 SM2_VERIFY ---------- */
static int8_t h_sm2_verify(const uint8_t *in, uint16_t in_len,
                           uint8_t *out, uint16_t *out_len)
{
    int ret;

    if (in_len != 64 + 32 + 64) {
        return ACK_ERR_INVALID_ID;
    }

    ret = Invoke_SM2_verify(in, in + 64, in + 96, 64);
    out[0] = (ret == ACK_SUCCESS) ? 1 : 0;
    *out_len = 1;
    return ACK_SUCCESS;       /* 验签失败由结果字节体现 */
}

/* ---------- 0x50 SELFTEST ---------- */
static int sm3_kat(void)
{
    static const uint8_t msg[] = "abc";
    static const uint8_t exp[32] = {
        0x66,0xC7,0xF0,0xF4,0x62,0xEE,0xED,0xD9,
        0xD1,0xF2,0xD4,0x6B,0xDC,0x10,0xE4,0xE2,
        0x41,0x67,0xC4,0x87,0x5C,0xF2,0xF7,0xA2,
        0x29,0x7D,0xA0,0x2B,0x8F,0x4B,0xA8,0xE0
    };
    uint8_t out[32];

    Invoke_SM3_cal(msg, 3, out);
    return (memcmp(out, exp, 32) == 0) ? 0 : -1;
}

static int sm4_kat(void)
{
    static const uint8_t key[16] = {
        0x01,0x23,0x45,0x67,0x89,0xAB,0xCD,0xEF,
        0xFE,0xDC,0xBA,0x98,0x76,0x54,0x32,0x10
    };
    static const uint8_t exp[16] = {
        0x68,0x1E,0xDF,0x34,0xD2,0x06,0x96,0x5E,
        0x86,0xB3,0xE9,0x4F,0x53,0x6E,0x42,0x46
    };
    uint8_t out[16];

    /* KAT 需要用标准原始密钥，不能用密钥槽接口 SM4_enc_dec_process；
     * 本地 HAL 的 MSP init 访问 CLIC，因此走 Invoke 的 M 模式调用门 */
    Invoke_SM4_KAT(key, out, 16);

    return (memcmp(out, exp, 16) == 0) ? 0 : -1;
}

static int sm2_kat(void)
{
    uint8_t pub[64];
    uint8_t sig[64];
    static const uint8_t digest[32] = {0};
    static const uint8_t k[32] = {
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
    };
    int ret;

    ret = Invoke_GenerateKey(IDx_TMP_SM2_SIGN);
    if (ret != ACK_SUCCESS) return ret;
    ret = Invoke_GetPubKey(IDx_TMP_SM2_SIGN, pub);
    if (ret != ACK_SUCCESS) return ret;
    ret = Invoke_SM2_sign(IDx_TMP_SM2_SIGN, digest, k, sig);
    if (ret != ACK_SUCCESS) return ret;
    ret = Invoke_SM2_verify(pub, digest, sig, 64);
    return (ret == ACK_SUCCESS) ? 0 : -1;
}

static int8_t h_selftest(const uint8_t *in, uint16_t in_len,
                         uint8_t *out, uint16_t *out_len)
{
    uint32_t result = 0;
    uint32_t mask = 0xFFFF;

    if (in_len >= 2) {
        mask = ((uint32_t)in[0] << 8) | in[1];
    }

    if ((mask & (1u << 0)) && Invoke_Security_TRNG_SelfTest() != 0) result |= (1u << 0);
    if ((mask & (1u << 1)) && sm3_kat() != 0)                       result |= (1u << 1);
    if ((mask & (1u << 2)) && sm4_kat() != 0)                       result |= (1u << 2);
    if ((mask & (1u << 3)) && sm2_kat() != 0)                       result |= (1u << 3);

    out[0] = (uint8_t)(result >> 24);
    out[1] = (uint8_t)(result >> 16);
    out[2] = (uint8_t)(result >> 8);
    out[3] = (uint8_t)result;
    *out_len = 4;
    return ACK_SUCCESS;
}

/* ---------- 0x60 GET_UID ---------- */
static int8_t h_get_uid(const uint8_t *in, uint16_t in_len,
                        uint8_t *out, uint16_t *out_len)
{
    uint8_t type = (in_len >= 1) ? in[0] : 0;

    if (type == 0) {
        /* type 0：OTP 0x170 起始 8 字节唯一标识
         * 用户模式不能直接访问 OTP 控制器，走 M 模式 Invoke 调用门 */
        if (Invoke_HAL_OTP_Read(0x170, out, 8) != HAL_OK) {
            return ACK_ERR_GENERIC;
        }
    } else if (type == 1) {
        /* type 1：OTP 0x00 起始 8 字节生产信息（LotID + waferid） */
        if (Invoke_HAL_OTP_Read(0x00, out, 8) != HAL_OK) {
            return ACK_ERR_GENERIC;
        }
    } else {
        return ACK_ERR_INVALID_ID;
    }

    *out_len = 8;
    return ACK_SUCCESS;
}

/* ---------- 0x40 SM4_BULK（一个逻辑帧，最大 128KB） ----------
 * PAYLOAD 与原 0x20 相同：[id, mode, op] + 可选口令 + CBC IV + data。
 * 上位机可把整个请求拆成任意 n 次串口 write；固件收齐 LEN 后只
 * 调用一次 Invoke_SM4_enc_dec_process，收齐后只回一帧。
 */
int8_t cmd_bulk_dispatch(const uint8_t *in, uint32_t in_len,
                         uint8_t *out, uint32_t *out_len)
{
    return sm4_crypt_common(in, in_len, out, out_len, CMD_BULK_MAX_DATA);
}

/* ---------- 0x41 SM3_BULK（一个逻辑帧，最大 128KB） ----------
 * PAYLOAD 就是 SM3 原始数据，没有额外头；收齐后调用一次
 * Invoke_SM3_cal，应答 32B 摘要。允许 0B（空消息摘要）。
 */
int8_t cmd_sm3_bulk_dispatch(const uint8_t *in, uint32_t in_len,
                             uint8_t *out, uint32_t *out_len)
{
    if (in_len > CMD_BULK_MAX_DATA) {
        return ACK_ERR_INVALID_ID;
    }

    Invoke_SM3_cal(in, in_len, out);
    *out_len = 32;
    return ACK_SUCCESS;
}

/* ---------- 命令表 ----------
 * 注意：0x40 SM4_BULK / 0x41 SM3_BULK 不在这里。
 * 它们使用 4 字节 LEN 和 128KB 缓冲，由 cmd_uart.c 的 bulk 状态机
 * 直接调用 cmd_bulk_dispatch() / cmd_sm3_bulk_dispatch()。
 * 本表的 handler 只接受 uint16 长度和 <=512B 输出。
 */
static const struct {
    uint8_t cmd;
    cmd_handler_t fn;
} s_cmd_table[] = {
    { CMD_PING,           h_ping           },
    { CMD_AUTH,           h_auth           },
    { CMD_LOGOUT,         h_logout         },
    { CMD_GET_INFO,       h_get_info       },
#if CMD_ENABLE_SET_PASSWORD
    { CMD_SET_PASSWORD,   h_set_password   },
#endif
    { CMD_CHECK_PASSWORD, h_check_password },
    { CMD_SM3,            h_sm3            },
    { CMD_GENKEY,         h_genkey         },
    { CMD_GETPUBKEY,      h_getpubkey      },
    { CMD_SM4_EXPORT,     h_sm4_export     },
    { CMD_KEY_IMPORT,     h_key_import     },
    { CMD_LOAD_PUBKEY,    h_load_pubkey    },
    { CMD_KEY_STORE,      h_key_store      },
    { CMD_KEY_LOAD,       h_key_load       },
    { CMD_KEY_DESTROY,    h_key_destroy    },
    { CMD_SM4_CRYPT,      h_sm4_crypt      },
    { CMD_SM2_ENC,        h_sm2_enc        },
    { CMD_SM2_DEC,        h_sm2_dec        },
    { CMD_SM2_SIGN,       h_sm2_sign       },
    { CMD_SM2_VERIFY,     h_sm2_verify     },
    { CMD_SELFTEST,       h_selftest       },
    { CMD_GET_UID,        h_get_uid        },
};

int8_t cmd_dispatch(uint8_t cmd,
                    const uint8_t *in, uint16_t in_len,
                    uint8_t *out, uint16_t *out_len)
{
    for (unsigned i = 0; i < sizeof(s_cmd_table) / sizeof(s_cmd_table[0]); i++) {
        if (s_cmd_table[i].cmd == cmd) {
            int8_t status;
            /* PA05 由 Invoke_* 接口内部拉高，这里只负责分发 */
            status = s_cmd_table[i].fn(in, in_len, out, out_len);
            return status;
        }
    }
    return CMD_ERR_UNKNOWN;
}

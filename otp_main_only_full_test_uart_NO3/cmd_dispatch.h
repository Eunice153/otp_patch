#ifndef CMD_DISPATCH_H
#define CMD_DISPATCH_H

#include <stdint.h>

/* 与 otp_patch.c 中的 ACK 定义保持一致 */
#define ACK_SUCCESS              0
#define ACK_ERR_GENERIC         -1
#define ACK_ERR_INVALID_ID      -2
#define ACK_ERR_NO_PERMISSION   -3
#define ACK_ERR_DECRYPT_FAIL    -4
/* -5 ACK_ERR_NO_PUBKEY 保留 */
#define ACK_ERR_OTP             -6
#define ACK_SLOT_EXISTED        -7
#define ACK_SLOT_NO_SET         -8

/* 协议层错误码（正值） */
#define CMD_ERR_FRAME           0x01
#define CMD_ERR_UNKNOWN         0x02
#define CMD_ERR_TOO_LONG        0x03

/* PA05 运算状态指示：只在 Invoke_* 实际运算期间拉高（cmd_dispatch.c 实现） */
void crypto_busy_enter(void);
void crypto_busy_exit(void);

/* 命令码：可按需修改，只要上位机与固件一致 */
#define CMD_PING            0x01
#define CMD_AUTH            0x02
#define CMD_LOGOUT          0x03
#define CMD_GET_INFO        0x04
#define CMD_SET_PASSWORD    0x05
#define CMD_CHECK_PASSWORD  0x06

#define CMD_SM3             0x10
#define CMD_GENKEY          0x11
#define CMD_GETPUBKEY       0x12
#define CMD_SM4_EXPORT      0x13
#define CMD_KEY_IMPORT      0x14
#define CMD_LOAD_PUBKEY     0x15
#define CMD_KEY_STORE       0x16
#define CMD_KEY_LOAD        0x17
#define CMD_KEY_DESTROY     0x18

#define CMD_SM4_CRYPT       0x20
#define CMD_SM4_GCM_ENC     0x21
#define CMD_SM4_GCM_DEC     0x22
#define CMD_SM2_ENC         0x23
#define CMD_SM2_DEC         0x24
#define CMD_SM2_SIGN        0x30
#define CMD_SM2_VERIFY      0x31

#define CMD_SELFTEST        0x50
#define CMD_GET_UID         0x60

/* 0x40：大数据 SM4；0x41：大数据 SM3。
 *
 * 这两个命令是“一个逻辑大帧”，不是每 512B 一个协议帧：
 *   请求: 5A CMD LEN0 LEN1 LEN2 LEN3 PAYLOAD[LEN]
 *   应答: 5A CMD STATUS LEN0 LEN1 LEN2 LEN3 DATA[LEN]
 *
 * 上位机可以把整个请求拆成任意 n 次串口 write；固件按 LEN 连续
 * 收齐后只处理一次，收齐后只回一帧。上位机也可以分 n 次 read
 * 接收应答。中间没有帧头、偏移和 ACK。
 *
 * 0x40 PAYLOAD 和原 0x20 一致，只是 data 可到 128KB：
 *   [0] id        5=临时槽, 2=OTP 槽（需先 AUTH）
 *   [1] mode      0=ECB, 1=CBC；bit7=1 表示后面跟 [pwd_len][pwd]
 *   [2] op        0=加密, 1=解密
 *   [3..]         可选 [pwd_len][口令 12~32B]
 *   [..]          CBC 时 16B IV
 *   [..]          data（16 的正整数倍，最大 131072B）
 *
 * 0x41 PAYLOAD 就是 SM3 原始数据（0..131072B），没有额外头。
 *
 * 0x40/0x41 都不写 OTP；0x40 的 id=2 只做只读加载。 */
#define CMD_SM4_BULK        0x40
#define CMD_SM3_BULK        0x41
/* 3B 基本头 + 1B pwd_len + 32B 口令 + 16B IV */
#define CMD_BULK_MAX_EXTRA  (3u + 1u + 32u + 16u)
#define CMD_BULK_MAX_DATA   131072u

int8_t cmd_bulk_dispatch(const uint8_t *in, uint32_t in_len,
                         uint8_t *out, uint32_t *out_len);
int8_t cmd_sm3_bulk_dispatch(const uint8_t *in, uint32_t in_len,
                             uint8_t *out, uint32_t *out_len);

/* SET_PASSWORD 为一次性写 OTP，开启后空片可被任意串口认领。
 * 当前测试固件设为 1 便于验证；正式/产线版本建议改为 0。 */
#ifndef CMD_ENABLE_SET_PASSWORD
#define CMD_ENABLE_SET_PASSWORD 1
#endif

#endif

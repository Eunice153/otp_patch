#include <string.h>
#include <stdlib.h>
#include "ls_hal_sm4.h"
#include "platform.h"
#include "ls_soc_gpio.h"
#include "log.h"
#include "otp_patch.h"
#include "ls_hal_sha.h"

#include <stddef.h>//null
#include "log.h"
#include "ls_hal_sm4.h"
#include "ls_msp_sm4.h"

#include "ls_hal_sha.h"
#include "ls_msp_sha.h"
#include"reg_sha_type.h"
#include "field_manipulate.h"
#include "ls_dbg.h"
#include "compile_flag.h"

#include "ls_hal_otbn_sm2.h"
#include "ls_hal_otbn_sha.h"
#include "ls_hal_otbn_ecc256.h"
#include "ls_hal_otbn_ecc384.h"
#include "boot.h"
#include "ls_otbn_ecc.h"
#include "ls_hal_iwdgv2.h"
#include "ls_hal_trng.h"
#include "platform.h"
#include "reg_sec_pmu_rg.h"

/*new_include*/
#include "ls_hal_otp_ctrl.h"
#include "ls_msp_otp_ctrl.h"

#include "ls_hal_otbn_sha.h"

#include "otp_patch.h"

#define SM2_DECRYPT_C1C3C2_STANDARD_MODE        (true)
const uint8_t SM2_G[] = {
    0x32, 0xc4, 0xae, 0x2c, 0x1f, 0x19, 0x81, 0x19, 0x5f, 0x99, 0x04, 0x46, 0x6a, 0x39, 0xc9, 0x94,
    0x8f, 0xe3, 0x0b, 0xbf, 0xf2, 0x66, 0x0b, 0xe1, 0x71, 0x5a, 0x45, 0x89, 0x33, 0x4c, 0x74, 0xc7,
    0xbc, 0x37, 0x36, 0xa2, 0xf4, 0xf6, 0x77, 0x9c, 0x59, 0xbd, 0xce, 0xe3, 0x6b, 0x69, 0x21, 0x53,
    0xd0, 0xa9, 0x87, 0x7c, 0xc6, 0x2a, 0x47, 0x40, 0x02, 0xdf, 0x32, 0xe5, 0x21, 0x39, 0xf0, 0xa0,
};

static void copy_reverse(uint8_t *dest, uint8_t *src, uint32_t length)
{
    for (uint32_t i = 0; i < length; i++)
    {
        dest[i] = src[length - i - 1];
    }
}

static void arr_reverse(uint8_t *idx, uint32_t length)
{
    uint8_t temp;
    for (uint32_t i = 0; i < length / 2; i++)
    {
        temp = idx[i];
        idx[i] = idx[length - 1 - i];
        idx[length - 1 - i] = temp;
    }
}


bool HAL_OTBN_SM3_KDF(uint8_t *Z, uint32_t Zlen, uint8_t *out, uint32_t out_len)
{
    uint32_t ct = 0x1;
    uint8_t Data[4];
	uint32_t digest_len = 0x20;
	uint8_t digest[0x20];
	uint32_t index = (out_len + 0x1f) / 0x20;

    if (Z == NULL || out_len == 0 || Zlen == 0 || out == NULL)
        return false;

    for (uint32_t i = 0; i < index; i++)
    {
        Data[0] = (ct >> 24) & 0xFF;
        Data[1] = (ct >> 16) & 0xFF;
        Data[2] = (ct >> 8) & 0xFF;
        Data[3] = (ct >> 0) & 0xFF;
        HAL_OTBN_SM3_Init();
        HAL_OTBN_SM3_Update(Z, Zlen);
        HAL_OTBN_SM3_Update(Data, 4);
        HAL_OTBN_SM3_Final(digest);
        if ((i == index - 1) && (out_len % 0x20 != 0))
                digest_len = (out_len) % 0x20;
        memcpy(out + 0x20 * i, digest, digest_len);
        ct++;
    }
    return true;
}

bool boot_sm2_encrypt(uint8_t *plaintext, uint8_t *ciphertext, uint32_t klen, uint8_t *random_num, uint8_t *public_key, bool standard_mode)
{
    HAL_OTBN_Init();
    struct HAL_OTBN_ECC256_ScalarMult_Param scalar_p;
    uint8_t k[0x20];
    uint8_t C1[0x40];
    uint8_t Gx[0x20];
    uint8_t Gy[0x20];
    uint8_t xy[0x40];
    uint8_t pub_x[0x20];
    uint8_t pub_y[0x20];
    uint8_t t[klen];
    uint8_t is_zero_number = 0;
    uint8_t C2[klen];
    uint8_t C3[0x20];

    // kG:
    copy_reverse(k, random_num, 0x20);
    memcpy(Gx, SM2_G, 0x20);
    memcpy(Gy, SM2_G + 0x20, 0x20);
    arr_reverse(Gx, 0x20);
    arr_reverse(Gy, 0x20);
    scalar_p.scalar = (uint32_t *)k;
    scalar_p.point_x = (uint32_t *)Gx;
    scalar_p.point_y = (uint32_t *)Gy;
    scalar_p.result_x = (uint32_t *)&C1[0x00];
    scalar_p.result_y = (uint32_t *)&C1[0x20];
    HAL_OTBN_ECC256_ScalarMult_Polling(HAL_OTBN_ECC256_CURVE_SM2, &scalar_p);
    arr_reverse(&C1[0x00], 0x20);
    arr_reverse(&C1[0x20], 0x20);

    // kP:
    copy_reverse(pub_x, public_key, 0x20);
    copy_reverse(pub_y, public_key + 0x20, 0x20);
    scalar_p.scalar = (uint32_t *)k;
    scalar_p.point_x = (uint32_t *)pub_x;
    scalar_p.point_y = (uint32_t *)pub_y;
    scalar_p.result_x = (uint32_t *)&xy[0x00];
    scalar_p.result_y = (uint32_t *)&xy[0x20];
    HAL_OTBN_ECC256_ScalarMult_Polling(HAL_OTBN_ECC256_CURVE_SM2, &scalar_p);
    arr_reverse(&xy[0x00], 0x20);
    arr_reverse(&xy[0x20], 0x20);

    // KDF
    HAL_OTBN_SM3_KDF(xy, 0x40, t, klen);
    for(uint8_t i = 0; i < klen; i++)
    {
        if(t[i] == 0x00)
            is_zero_number++;
    }
    if(is_zero_number == klen)
        return false;

    // C2=M⊕t
    for (uint8_t i = 0; i < klen; i++)
    {
        C2[i] = t[i] ^ plaintext[i];
    }

    // C3 = Hash(x2||M||y2)
    HAL_OTBN_SM3_Init();
    HAL_OTBN_SM3_Update(&xy[0x00], 0x20);
    HAL_OTBN_SM3_Update(plaintext, klen);
    HAL_OTBN_SM3_Update(&xy[0x20], 0x20);
    HAL_OTBN_SM3_Final(C3);

    if (standard_mode)
    {
        memcpy(ciphertext, C1, 0x40);
        memcpy(ciphertext + 0x40, C3, 0x20);
        memcpy(ciphertext + 0x60, C2, klen);
    }
    else
    {
        memcpy(ciphertext, C1, 0x40);
        memcpy(ciphertext + 0x40, C2, klen);
        memcpy(ciphertext + 0x40 + klen, C3, 0x20);
    }
    return true;
}


bool boot_sm2_decrypt(uint8_t *ciphertext, uint8_t *plaintext, uint32_t klen, uint8_t *private_key, bool standard_mode)
{
    uint8_t pri_key[0x20];
    uint8_t rG_x[0x20];
    uint8_t rG_y[0x20];
    uint8_t result[0x40];
    uint8_t sm3_hash_val[0x20];
    uint8_t t[SM2_DECRYPT_MESSAGE_MAXLENGTH];
    uint8_t Message[SM2_DECRYPT_MESSAGE_MAXLENGTH];
    uint8_t *C1,*C2,*C3;

    C1 = ciphertext;
    if (standard_mode)
    {
        C3 = C1 + 0x40;
        C2 = C3 + 0x20;
    }
    else
    {
        C2 = C1 + 0x40;
        C3 = C2 + klen;
    }

    copy_reverse(pri_key, private_key, 0x20);
    copy_reverse(rG_x, C1, 0x20);
    copy_reverse(rG_y, C1 + 0x20, 0x20);
    if (!HAL_OTBN_SM2_ValidPoint_Polling(rG_x, rG_y))
        return false;

    struct HAL_OTBN_ECC256_ScalarMult_Param scalar_p;
    scalar_p.scalar = (uint32_t *)pri_key;
    scalar_p.point_x = (uint32_t *)rG_x;
    scalar_p.point_y = (uint32_t *)rG_y;
    scalar_p.result_x = (uint32_t *)&result[0x00];
    scalar_p.result_y = (uint32_t *)&result[0x20];
    HAL_OTBN_ECC256_ScalarMult_Polling(HAL_OTBN_ECC256_CURVE_SM2, &scalar_p);

    arr_reverse(&result[0x00], 0x20);
    arr_reverse(&result[0x20], 0x20);
    HAL_OTBN_SM3_KDF(result, 0x40, t, klen);

    for (uint8_t i = 0; i < klen; i++)
    {
        Message[i] = t[i] ^ *C2++;
    }

    HAL_OTBN_SM3_Init();
    HAL_OTBN_SM3_Update(&result[0x00], 0x20);
    HAL_OTBN_SM3_Update(Message, klen);
    HAL_OTBN_SM3_Update(&result[0x20], 0x20);
    HAL_OTBN_SM3_Final(sm3_hash_val);

    if (!memcmp(sm3_hash_val, C3, 0x20))
    {
        memcpy(plaintext, Message, klen);
        return true;
    }
    return false;
}

static void ls_otbn_fireware_init()
{
    HAL_OTBN_Checksum_Clear();
    HAL_OTBN_DMEM_Set(0, 0, LS_OTBN_SM2_DMEM_END);
    HAL_OTBN_IMEM_Write(0, (uint32_t *)sm2_imem, LS_OTBN_SM2_IMEM_SIZE);
    HAL_OTBN_DMEM_Write(0, (uint32_t *)sm2_dmem, LS_OTBN_SM2_DMEM_SIZE);
}

bool boot_sm2_sign(uint8_t *private_key, uint8_t *msg, uint8_t *random_num, uint8_t *sign)
{
    uint8_t pri_key[32];
    uint32_t remote_random_addr;
    uint32_t remote_mode_addr;
    uint32_t mode;
    uint32_t remote_addr_d0;
    uint32_t remote_addr_d1;
    uint32_t remote_addr_r;
    uint32_t remote_addr_s;
    uint32_t remote_addr_msg;
    uint8_t rev_msg[32];
    uint8_t random[32];

    // The length of the message must be 32 bytes
    copy_reverse(rev_msg, msg, 32);
    copy_reverse(pri_key, private_key, 32);
    copy_reverse(random, random_num, 32);

    ls_otbn_fireware_init();

    remote_mode_addr = LS_OTBN_SM2_MODE_OFFSET;
    remote_random_addr = LS_OTBN_SM2_RANDOM_SEED_OFFSET;
    mode = LS_OTBN_SM2_MODE_SIGN;
    remote_addr_d0 = LS_OTBN_SM2_D0_OFFSET;
    remote_addr_r = LS_OTBN_SM2_R_OFFSET;
    remote_addr_s = LS_OTBN_SM2_S_OFFSET;
    remote_addr_msg = LS_OTBN_SM2_MSG_OFFSET;
    remote_addr_d1 = LS_OTBN_SM2_D1_OFFSET;

    if(HAL_OTBN_DMEM_Write(remote_random_addr, (uint32_t *)random, 32))
        return false;

    if(HAL_OTBN_DMEM_Write(remote_mode_addr, (uint32_t *)&mode, 4))
        return false;

    if(HAL_OTBN_DMEM_Set(remote_addr_d1, 0, 32))
        return false;

    if(HAL_OTBN_DMEM_Write(remote_addr_d0, (uint32_t *)pri_key, 32))
        return false;

    if(HAL_OTBN_DMEM_Write(remote_addr_msg, (uint32_t *)rev_msg, 32))
        return false;

    HAL_OTBN_CMD_Write_Polling(HAL_OTBN_CMD_EXECUTE);

    if(HAL_OTBN_Error_Bit_Get())
        return false;

    HAL_OTBN_DMEM_Read(remote_addr_r, (uint32_t *)sign, 32);
    HAL_OTBN_DMEM_Read(remote_addr_s, (uint32_t *)(sign + 32), 32);
    arr_reverse(sign, 32);
    arr_reverse(sign + 32, 32);
    return true;
}

/* ECC Function */
bool boot_ecc_verify(enum BOOT_ECC_CURVE_TYPE curve, uint8_t *pubkey_x, uint8_t *pubkey_y, uint8_t *msg, uint8_t *sign)
{
    uint8_t _msg[0x30], _pubkey_x[0x30], _pubkey_y[0x30], _sign_r[0x30], _sign_s[0x30];
    uint32_t length = curve == BOOT_ECC_Curve_P384 ? 0x30 : 0x20;
    copy_reverse(_msg, msg, length);
    copy_reverse(_pubkey_x, pubkey_x, length);
    copy_reverse(_pubkey_y, pubkey_y, length);
    copy_reverse(_sign_r, sign, length);
    copy_reverse(_sign_s, sign + length, length);
    struct HAL_OTBN_SM2_Verify_Param param;
    param.msg = (uint32_t *)_msg;
    param.r = (uint32_t *)_sign_r;
    param.s = (uint32_t *)_sign_s;
    param.x = (uint32_t *)_pubkey_x;
    param.y = (uint32_t *)_pubkey_y;
    switch (curve)
    {
    case BOOT_ECC_Curve_P384:
        return HAL_OTBN_ECC384_ECDSA_Verify_Polling(HAL_OTBN_ECC384_CURVE_P384, (void *)&param);
    case BOOT_ECC_Curve_SM2:
        return HAL_OTBN_SM2_Verify_Polling(&param);
    default:
        return false;
    }
}

/*asm接口*/
#include "ls_hal_flash.h"
#include "ls_soc_gpio.h"
#include "platform.h"
// #include "sleep.h"
#include "log.h"
#include <stdio.h>
#include <string.h>
#include "hal_flash_int.h"
#include "otp_patch.h"
#include "swint_call_asm.h"
#include "asm_swint.h"

#define DERIVED_KEY_LEN 32
#define SESSION_KEY_LEN 32
#define SALT_LEN 32

// 定义一个全局变量来记录抓取到的中断号
volatile uint32_t trapped_irq = 0;
volatile uint32_t final_irq = 0;

// 分开写两个处理函数
void handler_26(void) {
    final_irq = 26;
    cpu_intr_sec_clr(); // 清除 0x40022028
}

void handler_27(void) {
    final_irq = 27;
    cpu_intr_sec_clr(); // 清除 0x40022028
}


void debug_verify_irq_number(void) {
	rv_set_int_isr(26, handler_26);
	rv_set_int_isr(27, handler_27);

	// 使用字节指针，操作偏移为 1 的使能位
	uint32_t ids[] = {26,27};
	for(int i=0; i<2; i++) {
		uint32_t base = 0xE0801000 + ids[i] * 4;
		*(volatile uint8_t *)(base + 1) = 0x1;    // IE: 使能
		*(volatile uint8_t *)(base + 2) = 0x03;    // ATTR: 电平触发, M-Mode
		// *(volatile uint8_t *)(base + 3) = 0xEE;   // CTL: 设置较高优先级
	}
	cpu_intr_sec_unmask();

	enable_global_irq();

	LOG_I("Triggering...");
	cpu_intr_sec_activate();

	for(volatile int i=0; i<1000; i++) __asm("nop");

	int found_any = 0;
	for(int i = 16; i < IRQN_MAX; i++) {
		// 读取 CLICINTIP (Pending 寄存器)
		uint8_t pending = *(volatile uint8_t *)(0xE0801000 + i * 4);
		if(pending& 0x1) {
		LOG_I("!!! SUCCESS: Found Active IRQ ID: %d !!!", i);
		found_any = 1;
		}
	}

	if(!found_any) {
		LOG_E("Even with full scan, no Pending bit found. The trigger signal might not be reaching CLIC.");
	}

	if (final_irq != 0) {
		LOG_I("Verified! Target IRQ is %d", final_irq);
		trapped_irq = final_irq; // 传回全局变量
	}
}

#include "field_manipulate.h"//reg

/*设置密码（预期结果）
 1.OTP未初始化密码直接密码校验返回未设置密码错误码
 2.第一次设置密码
 3.再次设置同样密码，返回密码已经存在错误码
 4.用正确密码校验
 5.用错误密码校验，返回权限不足错误码
 */
int Varify_Set_password_or_check()
{
	const char *ok_pwd    = "Abcd1234Efghijkm";   // 12字节，满足 12~32
	const char *wrong_pwd = "Wrong1234Abc";
	int ret;

	//如果 OTP 未初始化密码，直接校验
	ret=Invoke_Check_password(ok_pwd);
	if (ret!=(-8)) {
		LOG_I("init Check_password failed = %d", ret);
		while(1);
	}

	ret = Invoke_Set_password(ok_pwd);
	if (ret!=0) {
		LOG_I("init password failed = %d", ret);
		while (1);
	}

	//再次调用同一密码：报错密码已经设置
	ret = Invoke_Set_password(ok_pwd);
	if (ret!=(-7)) {
		LOG_I("Varify1 password failed = %d", ret);
		while (1);
	}

	//校验密码密码正确
	ret=Invoke_Check_password(ok_pwd);
	if (ret!=0) {
		LOG_I("Varify1 Check_password failed = %d", ret);
		while(1);
	}

	// 错误密码：应返回 -3 (ACK_ERR_NO_PERMISSION)
	ret = Invoke_Check_password(wrong_pwd);
	if (ret !=-3) {
		LOG_I("Varify2 Check_password failed = %d", ret);
		while (1);
	}
	LOG_I("====Set_password、Check_password PASS ====");
	return 0;
}


int Verify_Key_Lifecycle_Flow(void)
{
	const char *ok_pwd    = "Abcd1234Efghijkm";
	const char *wrong_pwd = "Wrong1234Abc";
	int ret;

	/* 选一个完整流程 ID：TMP_SM4 <-> OTP_SM4 */
	key_id_x tmp_id = IDx_TMP_SM4;   // 5
	key_id_x otp_id = IDx_OTP_SM4;   // 2


	/* 生成 TMP key */
	ret = Invoke_GenerateKey(tmp_id);
	if (ret != 0) {
		LOG_I("GenerateKey failed = %d", ret);
		while (1);
	}

	/* 错误密码销毁 OTP，拒绝（槽位已空则先返回 SLOT_NO_SET） */
	ret = Invoke_DestroyKey(otp_id, ok_pwd);
	if (ret != -8) {
		LOG_I("DestroyKey(otp ok_pwd1) failed = %d", ret);
		while (1);
	}

	/* 用错误密码 StoreKey，拒绝 */
	ret = Invoke_StoreKey(tmp_id, wrong_pwd);
	if (ret != -3) {
		LOG_I("StoreKey(wrong pwd) failed = %d", ret);
		while (1);
	}

	/* 将 TMP key 存入 OTP（首次应成功） */
	ret = Invoke_StoreKey(tmp_id, ok_pwd);
	if (ret != 0) {
		LOG_I("StoreKey(ok pwd1) failed = %d", ret);
		while (1);
	}

	/* 将 TMP key 存入 OTP（重复 ACK_SLOT_EXISTED） */
	ret = Invoke_StoreKey(tmp_id, ok_pwd);
	if (ret != -7) {
		LOG_I("StoreKey(ok pwd2) failed = %d", ret);
		while (1);
	}

	/* 错误密码加载拒绝 */
	ret = Invoke_Load_sram_otp(otp_id, wrong_pwd);
	if (ret != -3) {
		LOG_I("Load_sram_otp(wrong pwd) failed = %d", ret);
		while (1);
	}

	/* 从 OTP 槽加载到 SRAM（正确密码） */
	ret = Invoke_Load_sram_otp(otp_id, ok_pwd);
	if (ret != 0) {
		LOG_I("Load_sram_otp failed = %d", ret);
		while (1);
	}


	/* 先销毁 TMP key（不需要密码） */
	ret = Invoke_DestroyKey(tmp_id, ok_pwd);   // 参数会被忽略（TMP 分支）
	if (ret != 0) {
		LOG_I("DestroyKey(tmp) failed = %d", ret);
		while (1);
	}

	/* 错误密码销毁 OTP，拒绝 */
	ret = Invoke_DestroyKey(otp_id, wrong_pwd);
	if (ret != -3) {
		LOG_I("DestroyKey(otp wrong pwd) failed = %d", ret);
		while (1);
	}

	/* 销毁 OTP key（需要正确密码） */
	ret = Invoke_DestroyKey(otp_id, ok_pwd);
	if (ret != 0) {
		LOG_I("DestroyKey(otp ok_pwd2) failed = %d", ret);
		while (1);
	}

	LOG_I("====SM4 GenerateKey、StoreKey、Load_sram_otp、DestroyKey PASS ====");
	return 0;
}

int Verify_All_Key_Slots_Flow(void)
{
	const char *ok_pwd = "Abcd1234Efghijkm";
	int ret;

	key_id_x tmp_ids[3] = {IDx_TMP_SM2_DEC, IDx_TMP_SM2_SIGN, IDx_TMP_SM4};
	key_id_x otp_ids[3] = {IDx_OTP_SM2_DEC, IDx_OTP_SM2_SIGN, IDx_OTP_SM4};

	// ret = Invoke_Set_password(ok_pwd);
	// if (ret != ACK_SUCCESS && ret != ACK_SLOT_EXISTED) {
	// 	LOG_I("Set_password failed = %d", ret);
	// 	while (1);
	// }

	for (int i = 0; i < 3; i++) {
		ret = Invoke_GenerateKey(tmp_ids[i]);
		if (ret != 0) {
			LOG_I("GenerateKey[%d] failed = %d", i, ret);
			while (1);
		}

		ret = Invoke_StoreKey(tmp_ids[i], ok_pwd);
		if (ret != 0 && ret != -7) {
			LOG_I("StoreKey[%d] failed = %d", i, ret);
			while (1);
		}

		ret = Invoke_Load_sram_otp(otp_ids[i], ok_pwd);
		if (ret != 0) {
			LOG_I("Load_sram_otp[%d] failed = %d", i, ret);
			while (1);
		}
		// ret = Invoke_DestroyKey(otp_ids[i], ok_pwd);
		// if (ret != 0) {
		// 	LOG_I("DestroyKey(otp ok) failed = %d", ret);
		// 	while (1);
		// }
	}

	LOG_I("====All_key GenerateKey、StoreKey、Load_sram_otp PASS ====");
	return 0;
}
// 辅助函数：打印 64 字节 Hex 数据并换行
void dump_pubkey_raw(const char *header, uint8_t *data)
{
	LOG_I("%s: ", header);
	for (int i = 0; i < 64; i++) {
		LOG_RAW("%02X ", data[i]);
		if (i == 31) LOG_RAW("\r\n"); // X 和 Y 之间加个空格
	}
	LOG_RAW("\r\n"); // 换行
}
#if 0
int Verify_Driver_Integrity_Loopback(void)
{
	int ret;
	uint8_t pubkey_otp[64] = {0};
	uint8_t ciphertext[128] = {0};
	uint8_t pubkey_final[64] = {0};

	//  确保 OTP 槽位 0 有密钥，并导出它的公钥作为加密基准
	// 已经运行过 Invoke_GenerateKey(IDx_OTP_SM2_DEC)
	ret = Invoke_GetPubKey(0, pubkey_otp);
	if (ret != 0){
		LOG_I("Invoke_GetPubKey0-0 failed = %d",ret);
		while (1);
	}

	// 将这个公钥加载到 IDx_LOAD_PUBKEY (槽位 6)
	ret = Invoke_LoadPublicKey(pubkey_otp);
	if (ret != 0){
		LOG_I("Invoke_LoadPublicKey0-0 failed = %d",ret);
		while (1);
	}

	// 将 OTP 槽位 0 的私钥，用它自己的公钥加密，导出成密文包
	ret = Invoke_ExportKey(0, ciphertext, 1);
	if (ret != 0){
		LOG_I("Invoke_ExportKey0-0 failed = %d",ret);
		while (1);
	}

	// 解密并导入
	// 使用 OTP 槽位 0 的私钥，解密刚才生成的密文包，存入临时槽位 IDx_TMP_SM2_SIGN (槽位 4)
	// 如果一切正常，槽位 4 里的内容应该变得和槽位 0 一模一样
	ret = Invoke_ImportKey(4, 0, ciphertext, 1);
	if (ret != 0){
		LOG_I("Invoke_ImportKey0-0 failed = %d",ret);
		while (1);
	}

	// 导出槽位 4 的公钥进行最终比对
	ret = Invoke_GetPubKey(4, pubkey_final);
	if (ret != 0){
		LOG_I("Invoke_GetPubKey0-1 failed = %d",ret);
		while (1);
	}

	// 比较 pubkey_otp 和 pubkey_final 是否一致
	for (int i = 0; i < 64; i++) {
		if (pubkey_otp[i] != pubkey_final[i]) {
			LOG_I("memcopy0-0 failed = %d",ret);
			while (1);
		}
	}
	LOG_I("==== GetPubKey、LoadPublicKey、ExportKey、ImportKey、 PASS ====");
	return 0;
}
#else
int Verify_Driver_Integrity_Loopback(void)
{
	int ret;
	uint8_t pubkey_ref[64] = {0};   // 参考公钥 (来自 ID 3)
	uint8_t pubkey_otp[64] = {0};   // 根公钥 (来自 ID 0)
	uint8_t ciphertext[128] = {0};
	uint8_t pubkey_final[64] = {0}; // 最终解密后的公钥 (来自 ID 4)

	// 获取 ID 0 的公钥，加载到 ID 6，作为后续解密包的“加密者”
	ret = Invoke_GetPubKey(0, pubkey_otp);
	if (ret != 0) { LOG_I("Get ID0 PubKey fail: %d", ret); while(1); }

	ret = Invoke_LoadPublicKey(pubkey_otp);
	if (ret != 0) { LOG_I("Load ID6 PubKey fail: %d", ret); while(1); }

	// 在临时槽位 ID 3 生成一个新密钥（驱动允许导出 ID 3）
	ret = Invoke_GenerateKey(3);
	if (ret != 0) { LOG_I("Gen ID3 Key fail: %d", ret); while(1); }

	// 记录 ID 3 的公钥，用于最后比对
	ret = Invoke_GetPubKey(3, pubkey_ref);
	if (ret != 0) { LOG_I("Get ID3 PubKey fail: %d", ret); while(1); }

	//  导出 ID 3：用 ID 6 的公钥加密 ID 3 的私钥
	ret = Invoke_ExportKey(3, ciphertext, 1);
	if (ret != 0) {
		LOG_I("Invoke_ExportKey ID3 failed = %d", ret);
		while (1);
	}

	// 解密导入：使用 ID 0 的私钥解密刚才的包，存入 ID 4
	// decryption_id=0, target_id=4，符合驱动 ImportKey 逻辑
	ret = Invoke_ImportKey(4, 0, ciphertext, 1);
	if (ret != 0) {
		LOG_I("Invoke_ImportKey failed = %d", ret);
		while (1);
	}

	// 导出 ID 4 的公钥，看它是否等于 ID 3 的公钥
	ret = Invoke_GetPubKey(4, pubkey_final);
	if (ret != 0) {
		LOG_I("Get ID4 PubKey failed = %d", ret);
		while (1);
	}

	// 最终比对
	dump_pubkey_raw("pubkey_ref", pubkey_ref);
	dump_pubkey_raw("pubkey_final", pubkey_final);
	for (int i = 0; i < 64; i++) {
		if (pubkey_ref[i] != pubkey_final[i]) {
			LOG_I("Data mismatch! Decryption failed to restore key.");
			while (1);
		}

	}

	LOG_I("==== GetPubKey、LoadPublicKey、ExportKey、ImportKey PASS ====");
	return 0;
}
#endif
/**
 * @brief 自动化验证 SM2 加解密、签名验签以及 SM4 ECB/CBC 链路
 * 验证逻辑：
 * 1. SM2: 使用 ID 0 公钥加密 -> 使用 ID 0 私钥解密 -> 比对明文
 * 2. SM2: 使用 ID 1 私钥签名 -> 使用 ID 0 公钥验签 -> 校验结果
 * 3. SM4: 使用 ID 2 (OTP) 密钥进行 ECB/CBC 加解密 -> 比对明文
 */
int Verify_Crypto_Full_Path(void)
{
	int ret;
	uint8_t i;

	uint8_t test_plain[16] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF};
	uint8_t cipher_buf[128] = {0};
	uint8_t recover_buf[128] = {0};
	uint8_t pubkey_otp0[64] = {0};
	uint8_t pubkey_otp1[64] = {0};
	uint8_t signature[64] = {0};
	uint8_t rnd_k[32]={
		0x0e, 0xdb, 0xf1, 0xc8, 0x27, 0x5b, 0xac, 0xeb, 0x0c, 0x56, 0x35, 0x63, 0xdc, 0xbf, 0xe1, 0xd0,
		0x99, 0xca, 0x62, 0xba, 0xdb, 0x69, 0x1c, 0x2e, 0x5c, 0xee, 0x77, 0xf2, 0xac, 0x5c, 0x03, 0x97,
	};
	// static uint8_t iv[16] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};
	uint8_t sm4_iv[16] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};

	// 获取 ID 0 的公钥用于加密
	ret = Invoke_GetPubKey(0, pubkey_otp0);
	if (ret != 0) { LOG_E("GetPubKey Fail: %d\n", ret); while(1); }

	// 加密：使用公钥加密 test_plain
	ret = Invoke_SM2_encrypt(pubkey_otp0, test_plain, 16, cipher_buf, 128, rnd_k, 1);
	if (ret != 0) { LOG_E("SM2_Enc Fail: %d\n", ret); while(1); }

	// 解密：使用 ID 0 私钥解密
	ret = Invoke_SM2_decrypt(0, cipher_buf, 128, recover_buf, 16, 1);
	if (ret != 0) { LOG_E("SM2_Dec Fail: %d\n", ret); while(1); }

	// 验证数据
	for (i = 0; i < 16; i++) {
		if (test_plain[i] != recover_buf[i]) {
			LOG_E("SM2 Data Mismatch at %d! (Ref:%02X, Fin:%02X)\n", i, test_plain[i], recover_buf[i]);
			while(1);
		}
	}

	// 签名：使用 ID 1 私钥对 test_plain 进行签名
	ret = Invoke_SM2_sign(1, test_plain, rnd_k, signature);
	if (ret != 0) { LOG_E("SM2_Sign Fail: %d\n", ret); while(1); }

	// 验签：使用 ID 0 的公钥验签
	// 获取 ID 1 的公钥用于
	ret = Invoke_GetPubKey(1, pubkey_otp1);
	if (ret != 0) { LOG_E("GetPubKey Fail: %d\n", ret); while(1); }
	ret = Invoke_SM2_verify(pubkey_otp1, test_plain, signature, 64);
	if (ret != 0) { LOG_E("SM2_Verify Fail: %d\n", ret); while(1); }

	/*模拟错误签名验签*/
	signature[0] ^= 0xFF;
	ret = Invoke_SM2_verify(pubkey_otp1,test_plain,signature,sizeof(signature));

	if(ret!=-1) {
		LOG_E("Failed! correct signature");
		while (1);
	}

	memset(recover_buf, 0, 16);
	// SM4 ECB 加密
	ret = Invoke_SM4_enc_dec_process(IDx_OTP_SM4, SM4_MODE_ECB, SM4_OP_ENCRYPT, NULL, test_plain, cipher_buf, 16);
	if (ret != 0) { LOG_E("SM4_ECB_Enc Fail: %d\n", ret); while(1); }

	// SM4 ECB 解密
	ret = Invoke_SM4_enc_dec_process(IDx_OTP_SM4, SM4_MODE_ECB, SM4_OP_DECRYPT, NULL, cipher_buf, recover_buf, 16);
	if (ret != 0) { LOG_E("SM4_ECB_Dec Fail: %d\n", ret); while(1); }

	// 验证
	for (i = 0; i < 16; i++) {
		if (test_plain[i] != recover_buf[i]) {
			LOG_E("SM4_ECB Mismatch at %d!\n", i);
			while(1);
		}
	}

	memset(recover_buf, 0, 16);

	// SM4 CBC 加密
	ret = Invoke_SM4_enc_dec_process(IDx_OTP_SM4, SM4_MODE_CBC, SM4_OP_ENCRYPT, sm4_iv, test_plain, cipher_buf, 16);
	if (ret != 0) { LOG_E("SM4_CBC_Enc Fail: %d\n", ret); while(1); }

	// SM4 CBC 解密 (注意：IV 在加密后会被更新，解密前需重置为初始状态)
	// memset(sm4_iv, 0, 16);
	ret = Invoke_SM4_enc_dec_process(IDx_OTP_SM4, SM4_MODE_CBC, SM4_OP_DECRYPT, sm4_iv, cipher_buf, recover_buf, 16);
	if (ret != 0) { LOG_E("SM4_CBC_Dec Fail: %d\n", ret); while(1); }

	//验证
	for (i = 0; i < 16; i++) {
		if (test_plain[i] != recover_buf[i]) {
			LOG_E("SM4_CBC Mismatch at %d!\n", i);
			while(1);
		}
	}
	ret = Invoke_SM4_enc_dec_process(IDx_OTP_SM4, SM4_MODE_CBC, SM4_OP_ENCRYPT, NULL, test_plain, cipher_buf, 16);
	if (ret != -2) { LOG_E("SM4_CBC_Enc INVALID_ID Fail: %d\n", ret); while(1); }
	ret = Invoke_SM4_enc_dec_process(IDx_OTP_SM4, SM4_MODE_CBC, SM4_OP_DECRYPT, NULL, cipher_buf, recover_buf, 16);
	if (ret != -2) { LOG_E("SM4_CBC_Dec INVALID_ID Fail: %d\n", ret); while(1); }
	LOG_I("==== SM2、SM4 PASS ====");
	return 0;
}
/**
 * @brief SM3 标准向量测试 (字符串 "abc")
 */
void Verify_SM3_Standard_Vector(void)
{
	//定义输入数据 "abc" (十六进制: 61 62 63)
	const uint8_t test_data[] = "abc";
	uint32_t test_len = 3;

	// 定义国标预期的 32 字节哈希值
	const uint8_t expected_hash[32] = {
		0x66, 0xC7, 0xF0, 0xF4, 0x62, 0xEE, 0xED, 0xD9,
		0xD1, 0xF2, 0xD4, 0x6B, 0xDC, 0x10, 0xE4, 0xE2,
		0x41, 0x67, 0xC4, 0x87, 0x5C, 0xF2, 0xF7, 0xA2,
		0x29, 0x7D, 0xA0, 0x2B, 0x8F, 0x4B, 0xA8, 0xE0
	};

	uint8_t out_hash[32] = {0};
	int mismatch = 0;

	Invoke_SM3_cal(test_data, test_len, out_hash);
	dump_pubkey_raw("SM3 CAL",out_hash);
	// 比对逻辑
	for (int i = 0; i < 32; i++) {
		if (out_hash[i] != expected_hash[i]) {
		mismatch = 1;
		LOG_E("Mismatch found at index [%d]: Expected 0x%02X, Got 0x%02X\n", i, expected_hash[i], out_hash[i]);
		while (1);
		}
	}

	// 最终结论输出
	if (mismatch == 0) {
		LOG_I("==== SM3 PASS ====");
	} else {
		LOG_E("!!!! SM3 FAIL !!!!");
		while(1);
	}
}
int main()
{
	// sys_init_none();
	// otp_patch_init();
	log_en = true;
	LOG_INIT();
	LOG_I("enter_main");
	io_cfg_output(PC07);//fpga pin
	io_clr_pin(PC07);//fpga pin
	io_cfg_output(PA12);//fpga pin
	io_clr_pin(PA12);//fpga pin
	io_toggle_pin(PA12);//fpga pin
	// HAL_OTP_CTRL_Init();
	// HAL_OTBN_Init();
	// HAL_OTBN_SM3_Init();
	// HAL_SM4_Init();
	LOG_I("init finished");
/*isr_num*/
	// debug_verify_irq_number();
	//// 如果 trapped_irq 拿到了值，说明中断成功触发
	// if(trapped_irq == 0) {
	// 	LOG_E("No IRQ trapped! Check CLIC or Trigger Source.");
	// } else {
	// 	LOG_I("Verified! IRQ Number is: %d", trapped_irq);
	// }

	int value;
	value =Varify_Set_password_or_check();
	if (value!=0) {
		LOG_E("Varify_Set_password_or_check failed = %d", value);
	}
	// value =Verify_Key_Lifecycle_Flow();//SM4生成随机数、
	// if (value!=0) {
	// 	LOG_E("Varify_Set_password_or_check failed = %d", value);
	// }
	value =Verify_All_Key_Slots_Flow();
	if (value!=0) {
		LOG_E("Verify_All_Key_Slots_Flow failed = %d", value);
	}
	value =Verify_Driver_Integrity_Loopback();
	if (value!=0) {
		LOG_E("Verify_Driver_Integrity_Loopback failed = %d", value);
	}
	value =Verify_Crypto_Full_Path();
	if (value!=0) {
		LOG_E("Verify_Crypto_Full_Path failed = %d", value);
	}
	Verify_SM3_Standard_Vector();

	/*跑完代码后让看门狗不复位*/
	uint32_t before = READ_REG(*(volatile uint32_t *)0x400A7C00);//0x400A7C00:wdg clk
	WRITE_REG(*(volatile uint32_t *)0x400A7C00, 0x2000);
	uint32_t after = READ_REG(*(volatile uint32_t *)0x400A7C00);
	if (before == after) {
	// 如果值没变，说明在用户模式下没有写权限！
		LOG_E("Write 0x400A7C00 Failed: Unprivileged Access\n");
	} else {
		LOG_I("Write 0x400A7C00 Success!\n");
	}
	before = READ_REG(*(volatile uint32_t *)0x400A7C10);//0x400A7C10:wdg reset
	WRITE_REG(*(volatile uint32_t *)0x400A7C10, 0x2000);
	after = READ_REG(*(volatile uint32_t *)0x400A7C10);
	if (before == after) {
	// 如果值没变，说明在用户模式下没有写权限！
		LOG_E("Write 0x400A7C10 Failed: Unprivileged Access\n");
	} else {
		LOG_I("Write 0x400A7C10 Success!\n");
	}
	return 0;
}

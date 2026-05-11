#include "otp_patch.h"
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
// #include <stdint.h>//伪随机数
// #include <string.h>//str伪随机数
#include "qsh.h"
#include "cpu.h"
#include "log.h"
#include "boot.h"
#include "ls_dbg.h"
#include "csi_rv32_gcc.h"
#include "core_rv32.h"

#include "ls_hal_sm4.h"
#include "ls_msp_sm4.h"
#include"reg_sha_type.h"
#include "field_manipulate.h"

#include "compile_flag.h"
#include "ls_hal_otbn_sm2.h"
#include "ls_hal_otbn_sha.h"
#include "ls_hal_otbn_ecc256.h"

#include "ls_hal_iwdgv2.h"
#include "ls_hal_trng.h"
#include "platform.h"
#include "reg_sec_pmu_rg.h"
#include "ls_hal_otp_ctrl.h"
#include "ls_msp_otp_ctrl.h"

#include "ls_msp_dwtrng.h"     /* 包含 DWTRNG 寄存器定义 */
#include "reg_sysc_sec_cpu.h"  /* 包含 SYSC_SEC_CPU 寄存器定义 */

#include "swint_call_asm.h"


// static bool password_status = false;

#define ACK_SUCCESS 0 //操作成功完成
#define ACK_ERR_GENERIC -1//通用错误（如硬件超时、TRNG 失败）
#define ACK_ERR_INVALID_ID -2//密钥 ID 越界或该 ID 不支持此操作
#define ACK_ERR_NO_PERMISSION -3//权限不足（密码未校验或校验失败)
#define ACK_ERR_DECRYPT_FAIL -4//解密失败（密文损坏或私钥不匹配）
// #define ACK_ERR_NO_PUBKEY -5//外部公钥未加载（针对导出操作）
#define ACK_ERR_OTP -6//OTP被破坏
#define ACK_SLOT_EXISTED -7//密码或密钥已经存在
#define ACK_SLOT_NO_SET -8//密码或密钥未设置、没有有效数据

#define SM4_BLOCK_SIZE     (0x10)
#define OTP_BASE_1K        0x200//0x400
#define OTP_PWD_ADDR       (OTP_BASE_1K + 0x00)//0X400-0X420
#define OTP_SM2_DEC_ADDR   (OTP_PWD_ADDR + 33) // 0x400 + 32 + 1 = 0x421
#define OTP_SM2_SIGN_ADDR  (OTP_SM2_DEC_ADDR + 37)// 0x421+32+4+1 = 0x446
#define OTP_SM4_KEY_ADDR   (OTP_SM2_SIGN_ADDR + 37)// 0x446+32+4+1 = 0x46B
/*otp代码放在0x280起始，文件最大3298*/
/*otp代码放在0x480起始*/
/* 物理存储空间：根据 ID 分配 */
static uint8_t OTP_SM2_DEC_KEY_DATA[32];   // ID 0 0x421-0x445
static uint8_t OTP_SM2_SIGN_KEY_DATA[32];  // ID 1 0x446-0x46A
static uint8_t OTP_SM4_KEY_DATA[16];       // ID 2 0x46B-0x47F
static uint8_t TMP_SM2_DEC_KEY_DATA[32];   // ID 3
static uint8_t TMP_SM2_SIGN_KEY_DATA[32];  // ID 4
static uint8_t TMP_SM4_KEY_DATA[16];       // ID 5
static uint8_t LOAD_PUBKEY_DATA[64];       // ID 6

/* 密钥映射表：将 key_id_x 映射到物理地址 */
uint8_t * const key_data_table[IDx_MAX] = {
	[IDx_OTP_SM2_DEC]  = OTP_SM2_DEC_KEY_DATA,
	[IDx_OTP_SM2_SIGN] = OTP_SM2_SIGN_KEY_DATA,
	[IDx_OTP_SM4]      = OTP_SM4_KEY_DATA,
	[IDx_TMP_SM2_DEC]  = TMP_SM2_DEC_KEY_DATA,
	[IDx_TMP_SM2_SIGN] = TMP_SM2_SIGN_KEY_DATA,
	[IDx_TMP_SM4]      = TMP_SM4_KEY_DATA,
	[IDx_LOAD_PUBKEY]  = LOAD_PUBKEY_DATA,
};

/**
 * @brief 通用 SM3 哈希封装函数
 * @param data 输入数据指针
 * @param len  数据长度
 * @param out_hash 输出 32 字节哈希值
 */
void SM3_cal(const uint8_t *data, uint32_t len, uint8_t *out_hash)
{
    HAL_OTBN_SM3_Init(); // 确保每次计算从初始向量开始
    HAL_OTBN_SM3_Update((uint8_t *)data, len);
    HAL_OTBN_SM3_Final(out_hash);
}

#ifndef CO_BIT
#define CO_BIT(pos) (1UL << (pos))
#endif

#define CMD_GEN_NOISE    0x1/* 采熵/自播种 */
#define CMD_CREATE_STATE 0x3/* 实例化状态 */
#define CMD_GEN_RANDOM   0x6/* 生成 128 bit 到 RANDx */
#define CMD_ADVANCE_STATE 0x7/* 收尾推进状态（结束一次 Generate ） */

void HAL_TRNG_MSP_Init(void)
{
	SYSC_SEC_CPU->PD_CPU_CLKG[1] = SYSC_SEC_CPU_CLKG_CLR_NIST_TRNG_MASK;
	SYSC_SEC_CPU->PD_CPU_SRST[1] = SYSC_SEC_CPU_SRST_CLR_NIST_TRNG_MASK;
	SYSC_SEC_CPU->PD_CPU_SRST[1] = SYSC_SEC_CPU_SRST_SET_NIST_TRNG_MASK;
	SYSC_SEC_CPU->PD_CPU_CLKG[1] = SYSC_SEC_CPU_CLKG_SET_NIST_TRNG_MASK;
}

static void send_cmd(uint8_t cmd) {
	while ((DWTRNG->STAT & CO_BIT(31)));
	DWTRNG->CTRL = cmd;
	while ((DWTRNG->ISTAT & CO_BIT(4)) == 0);
	DWTRNG->ISTAT = CO_BIT(4);
}


int trng_derive_key(uint8_t *derived_key, size_t key_len)
{
	if (derived_key == NULL || key_len == 0) {
		return ACK_ERR_INVALID_ID;
	}
	if (key_len!=32 && key_len!=16)
	{
		return ACK_ERR_INVALID_ID;
	}
	// 使能 TRNG 时钟并复位
	HAL_TRNG_MSP_Init();
	// 初始化 TRNG 状态机
	send_cmd(CMD_GEN_NOISE);
	send_cmd(CMD_CREATE_STATE);
	send_cmd(CMD_GEN_RANDOM);
	uint32_t rand[4];
	rand[0] = DWTRNG->RAND[0];
	rand[1] = DWTRNG->RAND[1];
	rand[2] = DWTRNG->RAND[2];
	rand[3] = DWTRNG->RAND[3];
	send_cmd(CMD_ADVANCE_STATE);

	// 将 rand 数据转换并存入 derived_key
	for (size_t i = 0; i < 16; i++) {
		derived_key[i] = ((uint8_t *)rand)[i];
	}

	/* -------- 如果需要 32 byte，再生成一次 -------- */
	if (key_len == 32) {
		send_cmd(CMD_GEN_RANDOM);
		rand[0] = DWTRNG->RAND[0];
		rand[1] = DWTRNG->RAND[1];
		rand[2] = DWTRNG->RAND[2];
		rand[3] = DWTRNG->RAND[3];
		send_cmd(CMD_ADVANCE_STATE);

		// 将第二次的 rand 数据转换并填充到 derived_key
		for (size_t i = 0; i < 16; i++) {
		derived_key[16 + i] = ((uint8_t *)rand)[i];
		}
	}

	// 关闭 TRNG 时钟
	SYSC_SEC_CPU->PD_CPU_CLKG[1] = SYSC_SEC_CPU_CLKG_CLR_NIST_TRNG_MASK;
	return 0;
}

unsigned int strlen(const char *s)
{
	unsigned int len = 0;
	while (*s++) len++;
	return len;
}

typedef enum {
	PWD_OP_SET = 0,
	PWD_OP_CHECK = 1,
} pwd_op_t;

/**
 * @brief 内部统一处理：设置密码 / 校验密码
 * @param input_password_str 输入密码字符串
 * @param op PWD_OP_SET 或 PWD_OP_CHECK
 * @return
 */
static int Password_op(const char *input_password_str, pwd_op_t op)
{
	uint8_t output_hash[32] = {0};
	uint8_t stored_hash[32] = {0};
	uint8_t lock_flag = 0xFF;

	uint32_t pwd_len = strlen(input_password_str);
	if (pwd_len < 12 || pwd_len > 32) {return ACK_ERR_INVALID_ID;}

	/*读取第 33 字节判断是否已设置过初始密码 */
	/*如果此位为 0，表示已初始化，不再允许写入*/
	if (HAL_OTP_Read(OTP_PWD_ADDR + 32, &lock_flag, 1) != 0) {return ACK_ERR_GENERIC;}
	// 统一先算输入密码哈希
	SM3_cal((const uint8_t *)input_password_str, pwd_len, output_hash);
	if (op == PWD_OP_SET) {
		// SET: 已存在 -> ACK_SLOT_EXISTED；未设置(0xFF) -> 写入
		if (lock_flag == 0x00) {return ACK_SLOT_EXISTED;}
		else if (lock_flag == 0xFF) {
			uint8_t init_done_flag = 0x00;
			if (HAL_OTP_Write(OTP_PWD_ADDR, output_hash, 32) != 0) {return ACK_ERR_GENERIC;}
			if (HAL_OTP_Write(OTP_PWD_ADDR + 32, &init_done_flag, 1) != 0) {return ACK_ERR_GENERIC;}
			return ACK_SUCCESS;
		}
		return ACK_ERR_OTP;
	}
	// CHECK: 未设置 -> ACK_SLOT_NO_SET；已设置(0) -> 比较
	if (lock_flag == 0xFF) {return ACK_SLOT_NO_SET;}
	else if (lock_flag == 0x00) {
		if (HAL_OTP_Read(OTP_PWD_ADDR, stored_hash, 32) != 0) {return ACK_ERR_GENERIC;}
		if (memcmp(output_hash, stored_hash, 32) == 0) {return ACK_SUCCESS;}
		return ACK_ERR_NO_PERMISSION;
	}
	return ACK_ERR_OTP;
}

/**
 * @brief Set_password: 设置用户密码
 */
int Set_password(const char *input_password_str)
{
	return Password_op(input_password_str, PWD_OP_SET);
}

/**
 * @brief Check_password: 校验用户密码
 */
int Check_password(const char *input_password_str)
{
	return Password_op(input_password_str, PWD_OP_CHECK);
}

/**
 * @brief GenerateKey: 通过随机数生成密钥并填充到相应的逻辑数组中
 * @param id 目标 ID (支持IDx_TMP_SM2_DEC、IDx_TMP_SM2_SIGN、IDx_TMP_SM4)
 * @return
 */
int GenerateKey(key_id_x id)
{
	// 范围校验：GenerateKey 仅允许生成临时密钥 (3, 4, 5)
	// OTP 固化密钥 (0, 1, 2) 只能由系统初始化加载，不能被随机数覆盖
	if (id < IDx_TMP_SM2_DEC || id > IDx_TMP_SM4) {
		return -ACK_ERR_INVALID_ID;
	}

	// 长度判定
	// ID 5 (TMP_SM4_KEY) 为 16 字节
	// ID 3/4 (TMP_SM2_DEC/SIGN) 为 32 字节私钥
	size_t key_len = (id == IDx_TMP_SM4) ? 16 : 32;

	// 直接填充对应的数组
	// key_data_table[id] 指的是 TMP_SM2_DEC_KEY_DATA 这样的
	int32_t ret = trng_derive_key(key_data_table[id], key_len);

	// if (ret == 0) {
	// 	LOG_I("Success! Key ID %d (Array: %s) generated successfully.",
	// 	id, (id == 5) ? "TMP_SM4_KEY" : "TMP_SM2_KEY");
	// }else {
	// 	LOG_E("Failed! Key ID %d generation failed (array: %s).",
	// 	id, (id == 5) ? "TMP_SM4_KEY" : "TMP_SM2_KEY");
	// }

	return ret;
}

/**
 * @brief StoreKey: 将 TMP 数组下载到otp
 * @param id 源 ID (必须是 IDx_TMP_SM2_DEC, IDx_TMP_SM2_SIGN, 或 IDx_TMP_SM4)
 *	  input_password 传入的密码
 * @return
 */
int StoreKey(key_id_x id, const char *input_password_str)
{

	// 调用现有检查函数，拦截未授权访问
	if (Check_password(input_password_str) != ACK_SUCCESS) {
		return ACK_ERR_NO_PERMISSION;
	}

	// 校验：只有 TMP 密钥（ID 3, 4, 5）可以执行 Store 动作
	uint32_t otp_addr = 0;
	uint32_t key_len = 0;
	uint8_t output_hash[32] = {0};
	uint8_t lock_flag = 0xFF;
	switch (id) {
		case IDx_TMP_SM2_DEC:
			otp_addr = OTP_SM2_DEC_ADDR;//0x421
			key_len = 32;
		break;
		case IDx_TMP_SM2_SIGN:
			otp_addr =OTP_SM2_SIGN_ADDR;//0x446
			key_len = 32;
		break;
		case IDx_TMP_SM4:
			otp_addr = OTP_SM4_KEY_ADDR;//0x46B
			key_len = 16;
		break;
		default:
		return ACK_ERR_INVALID_ID; // 不支持的 ID
	}
	if (HAL_OTP_Read(otp_addr + key_len + 4, &lock_flag, 1) != 0) {return ACK_ERR_GENERIC;}
	if (lock_flag == 0) {return ACK_SLOT_EXISTED; }
	else if ((lock_flag!=0)&&(lock_flag!=0xFF)) {return ACK_ERR_OTP;}
	SM3_cal(key_data_table[id], key_len, output_hash);
	if (HAL_OTP_Write(otp_addr, key_data_table[id], key_len) != 0) {return ACK_ERR_GENERIC;}
	if (HAL_OTP_Write(otp_addr + key_len, output_hash, 4) != 0) {return ACK_ERR_GENERIC;}
	uint8_t init_done_flag = 0x00;
	if (HAL_OTP_Write(otp_addr + key_len + 4, &init_done_flag, 1) != 0) {return ACK_ERR_GENERIC;}
	return ACK_SUCCESS;
}

/**
 * @brief : 将 OTP密钥加载到sram_otp
 * @param id  ID (必须是 IDx_OTP_SM2_DEC, IDx_OTP_SM2_SIGN, 或 IDx_OTP_SM4)
 *	  input_password_str 传入的密码
 * @return
 */
int Load_sram_otp(key_id_x id, const char *input_password_str)
{

	// 调用现有检查函数，拦截未授权访问
	if (Check_password(input_password_str) != ACK_SUCCESS) {
		return ACK_ERR_NO_PERMISSION;
	}

	// 校验：只有 TMP 密钥（ID 3, 4, 5）可以执行 Store 动作
	uint32_t otp_addr = 0;
	uint32_t key_len = 0;
	uint8_t output_hash[32] = {0};
	uint8_t stored_hash[4];
	uint8_t lock_flag = 0xFF;
	switch (id) {
		case IDx_OTP_SM2_DEC:
			otp_addr = OTP_SM2_DEC_ADDR;//0x421
			key_len = 32;
		break;
		case IDx_OTP_SM2_SIGN:
			otp_addr =OTP_SM2_SIGN_ADDR;//0x446
			key_len = 32;
		break;
		case IDx_OTP_SM4:
			otp_addr = OTP_SM4_KEY_ADDR;//0x46B
			key_len = 16;
		break;
		default:
		return ACK_ERR_INVALID_ID; // 不支持的 ID
	}
	if (HAL_OTP_Read(otp_addr + key_len + 4, &lock_flag, 1) != 0) {return ACK_ERR_GENERIC;}
	if (lock_flag == 0xFF) {return ACK_SLOT_NO_SET; }
	else if ((lock_flag!=0)&&(lock_flag!=0xFF)) {return ACK_ERR_OTP;}
	if (HAL_OTP_Read(otp_addr + key_len, stored_hash, 4) != 0) {return ACK_ERR_GENERIC;}
	if (HAL_OTP_Read(otp_addr,key_data_table[id], key_len) != 0) {return ACK_ERR_GENERIC;}
	SM3_cal(key_data_table[id], key_len, output_hash);
	if (memcmp(output_hash, stored_hash, 4) != 0){
		memset(key_data_table[id], 0, key_len);
		return ACK_ERR_OTP;
	}

	return ACK_SUCCESS;
}

/**
 * @brief DestroyKey: 支持删除TMP数组相应数据、OTP数组对应的数据以及OTP内容
 * @param id  ID (必须是 IDx_OTP_SM2_DEC IDx_OTP_SM2_SIGN ，IDx_OTP_SM4，IDx_TMP_SM2_DEC, IDx_TMP_SM2_SIGN, 或 IDx_TMP_SM4)
 *	  input_password_str 传入的密码(仅销毁 OTP 密钥时校验)
 * @return
 */
int DestroyKey(key_id_x id, const char *input_password_str)
{
	uint32_t otp_addr = 0;
	uint32_t key_len = 0;
	uint8_t zero_buf[32] = {0};
	uint8_t lock_flag = 0xFF;

	if (id < IDx_OTP_SM2_DEC || id > IDx_TMP_SM4) {return ACK_ERR_INVALID_ID;}

	if (id >= IDx_OTP_SM2_DEC && id <= IDx_OTP_SM4) {
		if (Check_password(input_password_str) != ACK_SUCCESS) {return ACK_ERR_NO_PERMISSION;}
		if (id == IDx_OTP_SM2_DEC) {otp_addr = OTP_SM2_DEC_ADDR;key_len = 32;}
		else if (id == IDx_OTP_SM2_SIGN) {otp_addr = OTP_SM2_SIGN_ADDR;key_len = 32;}
		else{otp_addr = OTP_SM4_KEY_ADDR;key_len = 16;}

		if (HAL_OTP_Read(otp_addr + key_len + 4, &lock_flag, 1) != 0) {return ACK_ERR_GENERIC;}
		if (lock_flag == 0xFF) {return ACK_SLOT_NO_SET;}
		if (HAL_OTP_Write(otp_addr, zero_buf, key_len) != 0) return ACK_ERR_GENERIC;
		if (HAL_OTP_Write(otp_addr + key_len, zero_buf, 4) != 0) return ACK_ERR_GENERIC;
	}else {key_len = (id == IDx_TMP_SM4) ? 16 : 32;}

	if (key_data_table[id] != NULL) {memset(key_data_table[id], 0, key_len);}
	return ACK_SUCCESS;
}

/* --- 局部辅助函数，绕过 ROM static 限制 --- */
static void copy_reverse(uint8_t *dest, const uint8_t *src, uint32_t length)
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
		idx[i] = idx[length - i - 1];
		idx[length - i - 1] = temp;
	}
}

/**
 * @brief 检查 key_data_table[id] 指向的数组是否已填充有效数据
 */
static int is_key_empty(const uint8_t *key, uint32_t len)
{
	// 检查 len 长度
	for (uint32_t i = 0; i < len; i++) {
		if ((key[i] != 0)&&(key[i] != 0xFF)) return ACK_SUCCESS; // 不为空
	}
	return ACK_SLOT_NO_SET; // 全为空
}

/**
 * @brief GetPubKey: 根据相应槽位的私钥导出对应的公钥。
 * @param id 源 ID (必须是 IDx_OTP_SM2_DEC, IDx_OTP_SM2_SIGN, 或 IDx_TMP_SM2_DEC，IDx_TMP_SM2_SIGN)
 *	pubkey 输出的公钥结果
 * @return
 */
int GetPubKey(key_id_x id, uint8_t *pubkey)
{
	uint8_t *src_priv_key = NULL;
	uint8_t priv_reversed[32];
	//定义局部变量存储处理后的基点坐标
	uint8_t Gx[32], Gy[32];
	struct HAL_OTBN_ECC256_ScalarMult_Param scalar_p;

	switch (id) {
		case IDx_OTP_SM2_DEC:
		case IDx_OTP_SM2_SIGN:
		case IDx_TMP_SM2_DEC:
		case IDx_TMP_SM2_SIGN:  src_priv_key = key_data_table[id];    break;
		default: return ACK_ERR_INVALID_ID;
	}
	if((is_key_empty(src_priv_key,32))!=ACK_SUCCESS)   return ACK_SLOT_NO_SET;

	// HAL_OTBN_Init();
	// 反转私钥 (大端 -> 小端)
	copy_reverse(priv_reversed, src_priv_key, 32);

	//从 SM2_G 提取基点并处理 (参考 boot_sm2_encrypt 逻辑)
	memcpy(Gx, SM2_G, 32);
	memcpy(Gy, SM2_G + 32, 32);
	arr_reverse(Gx, 32); // OTBN 硬件需要小端基点
	arr_reverse(Gy, 32);

	//设置硬件参数
	scalar_p.scalar   = (uint32_t *)priv_reversed;
	scalar_p.point_x  = (uint32_t *)Gx;
	scalar_p.point_y  = (uint32_t *)Gy;
	scalar_p.result_x = (uint32_t *)&pubkey[0];
	scalar_p.result_y = (uint32_t *)&pubkey[32];

	//执行计算
	HAL_OTBN_ECC256_ScalarMult_Polling(HAL_OTBN_ECC256_CURVE_SM2, &scalar_p);

	//将结果反转回标准大端格式给应用层
	arr_reverse(&pubkey[0], 32);
	arr_reverse(&pubkey[32], 32);

	return ACK_SUCCESS;
}

/**
 * @brief LoadPublicKey: 加载外部公钥到指定的存储区域
 * @param pubkey 指向 64 字节外部公钥的指针 (X 32字节 + Y 32字节)
 * @return
 */
int LoadPublicKey(uint8_t *pubkey)
{
	if (pubkey == NULL) {
		return ACK_ERR_INVALID_ID;
	}

	//获取存储公钥的物理地址 (IDx_LOAD_PUBKEY)
	uint8_t *dest = key_data_table[IDx_LOAD_PUBKEY];

	// 拷贝公钥数据 (SM2 公钥固定为 64 字节)
	memcpy(dest, pubkey, 64);


	return ACK_SUCCESS;
}


/**
 * @brief ExportKey:     使用ID6外部公钥加密导出内部 TMP 密钥即将TMP_KEY用LOAD_PUBKEY加密导出
 * @param id             待导出的 ID (支持 IDx_OTP_SM4,IDx_TMP_SM2_DEC, IDx_TMP_SM2_SIGN, IDx_TMP_SM4)
 * @param input_password 调用者传入的 4 字节口令
 * @param ciphertext     输出密文
 * @param standard_mode     0旧国标；1新国标
 * @return 0: 成功; -2: ID 非法; -3: 密码错误; -5: 公钥未加载; -1: 硬件/TRNG 错误
 */
int ExportKey(key_id_x id, uint8_t *ciphertext,bool standard_mode)
{
	//导出策略与长度判定
	if (id < IDx_OTP_SM4 || id > IDx_TMP_SM4) {
		return ACK_ERR_INVALID_ID;
	}

	uint32_t key_len = (id == IDx_TMP_SM4 || id == IDx_OTP_SM4) ? 16 : 32;
	// uint32_t klen = (id == IDx_TMP_SM4) ? 16 : 32;

	// 准备资源
	uint8_t *plain_key_source = key_data_table[id];
	uint8_t *wrap_pub_key = key_data_table[IDx_LOAD_PUBKEY];

	// 检查 ID 6 槽位是否加载了外部公钥
	if((is_key_empty(plain_key_source, key_len))!=ACK_SUCCESS)return ACK_SLOT_NO_SET;
	if((is_key_empty(wrap_pub_key, 64))!=ACK_SUCCESS)return ACK_SLOT_NO_SET;

	//生成随机数 k
	uint8_t random_k[32];
	int ret = trng_derive_key(random_k, 32);
	if (ret != 0) {return ACK_ERR_GENERIC;}

	// 调用 SM2 算法接口
	ret = (int32_t)boot_sm2_encrypt(plain_key_source, ciphertext, key_len, random_k, wrap_pub_key, standard_mode);

	if (ret == 1) {
		ret = ACK_SUCCESS;
	} else {
		ret = ACK_ERR_GENERIC;
	}

	// 清理现场
	memset(random_k, 0, 32);     // 抹除敏感随机数

	return ret;
}

/**
 * @brief ImportKey: 使用内部 ID 0/1 私钥解密外部密文包，并存入指定 TMP 槽位
 * @param target_id      解密数据注入目标槽位 ID (IDx_TMP_SM2_DEC, IDx_TMP_SM2_SIGN, IDx_TMP_SM4)
 * @param decryption_id  使用ID解密 (IDx_OTP_SM2_DEC,IDx_OTP_SM2_SIGN)
 * @param ciphertext     输入的加密密钥包
 * @param standard_mode  旧国标0，新国标1
 * @return 0: 成功; -2: 目标 ID 非法; -3: 密码错误; -4: 解密失败;
 */
int ImportKey(key_id_x target_id,key_id_x decryption_id, uint8_t *ciphertext, bool standard_mode)
{
	//目标槽位合法性检查 ---
	// 仅允许导入到临时槽位 3, 4, 5
	if (target_id < IDx_TMP_SM2_DEC || target_id > IDx_TMP_SM4) {return ACK_ERR_INVALID_ID;}
	// 仅允许槽位 0,1解密
	if (decryption_id < IDx_OTP_SM2_DEC || decryption_id > IDx_OTP_SM2_SIGN) {return ACK_ERR_INVALID_ID;}

	//确定预期解密长度 ---
	// SM4 槽位需要 16 字节明文，SM2 槽位需要 32 字节明文
	uint32_t key_len = (target_id == IDx_TMP_SM4) ? 16 : 32;

	// 准备解密密钥 ---
	// 根据设计，统一使用 ID 0/1 (OTP_SM2_DEC_KEY/IDx_OTP_SM2_SIGN) 进行拆包
	uint8_t *root_dec_prikey = key_data_table[decryption_id];
	if((is_key_empty(root_dec_prikey, 32))!=ACK_SUCCESS)return ACK_SLOT_NO_SET;

	// 临时缓冲区，解密成功后再写入槽位
	uint8_t decrypted_plain[32] = {0};

	int ret = boot_sm2_decrypt(ciphertext, decrypted_plain, key_len, root_dec_prikey, standard_mode);

	if (ret) {
		// 注入槽位
		// 将解密出的明文密钥存入对应的物理存储空间
		memcpy(key_data_table[target_id], decrypted_plain, key_len);
		ret = ACK_SUCCESS;
	} else {
		ret = ACK_ERR_INVALID_ID;
	}

	//清理现场
	memset(decrypted_plain, 0, 32); // 抹除栈上的明文碎片

	return ret;
}

/**
 * @brief sm2_encrypt: SM2加密
 * @param public_key     公钥
 * @param plaintext      明文
 * @param pt_len         明文长度
 * @param ciphertext     密文
 * @param ct_len         密文长度
 * @param random_num         随机数
 * @param standard_mode  旧国标0，新国标1
 * @return
 */
int SM2_encrypt(const uint8_t *public_key,const uint8_t *plaintext, size_t pt_len,
		uint8_t *ciphertext,size_t ct_len,uint8_t *random_num,bool standard_mode)
{
	if (public_key == NULL || plaintext == NULL || ciphertext == NULL||random_num==NULL){return ACK_ERR_INVALID_ID;}
	if (!boot_sm2_encrypt((uint8_t *)plaintext, ciphertext, pt_len, random_num, (uint8_t *)public_key, standard_mode))
	{
		return ACK_ERR_GENERIC;
	}
	return ACK_SUCCESS;
	// bool boot_sm2_encrypt(uint8_t *plaintext, uint8_t *ciphertext, uint32_t klen,
	// 	 uint8_t *random_num, uint8_t *public_key, standard_mode);
}

/**
 * @brief SM2 非对称解密接口
 * * @param key_id        密钥索引：仅支持 KEYID_0 (OTP_SM2_DEC_KEY) 或 KEYID_3 (TMP_SM2_DEC_KEY)
 * @param ciphertext    指向待解密的密文缓冲区指针
 * @param ct_len        密文数据的字节长度
 * @param plaintext     指向存储解密后明文的结果缓冲区
 * @param pt_len        期望输出的明文长度（或明文缓冲区大小）
 * @param standard_mode 旧国标0，新国标1
 * * @return int          0: 成功; -1: 无效的 KEYID或 参数; -2: 硬件解密执行失败
 */
int SM2_decrypt(key_id_x id, const uint8_t *ciphertext, size_t ct_len,
            uint8_t *plaintext, size_t pt_len, bool standard_mode)
{

	if (id != IDx_OTP_SM2_DEC && id != IDx_TMP_SM2_DEC) {return ACK_ERR_INVALID_ID;}

	// 参数基础校验
	if (ciphertext == NULL || plaintext == NULL || pt_len == 0) {return ACK_ERR_INVALID_ID;}

	// 直接从指针数组获取地址
	uint8_t *pri_key = key_data_table[id];
	if((is_key_empty(pri_key, 32))!=ACK_SUCCESS)return ACK_SLOT_NO_SET;

	//调用底层硬件解密
	if (!boot_sm2_decrypt((uint8_t *)ciphertext, plaintext, (uint32_t)pt_len,pri_key, standard_mode))
	{
		return ACK_ERR_GENERIC;
	}

	return ACK_SUCCESS;
}

/**
 * @brief SM2 签名接口
 * * @param id               密钥索引：仅支持 IDx_OTP_SM2_SIGN (1) 或 IDx_TMP_SM2_SIGN (4)
 * @param message_digest   待签名的消息摘要
 * @param k                签名随机数 (32 字节)
 * @param signature        输出缓冲区：存储签名结果 (通常为 64 字节，含 r, s)
 * * @return int             0: 成功; -1: 无效的 KEYID 或参数; -2: 硬件签名执行失败
 */
int SM2_sign(key_id_x id, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature)
{
	//权限校验：根据规范，仅 ID 1 和 ID 4 具备签名功能
	if (id != IDx_OTP_SM2_SIGN && id != IDx_TMP_SM2_SIGN) {
		return ACK_ERR_INVALID_ID;
	}

	// 基础参数校验
	if (message_digest == NULL || k == NULL || signature == NULL) {
		return ACK_ERR_INVALID_ID;
	}

	// 从映射表获取私钥物理地址
	uint8_t *pri_key = key_data_table[id];
	if((is_key_empty(pri_key, 32))!=ACK_SUCCESS)return ACK_SLOT_NO_SET;

	//调用底层硬件驱动函数
	if (!boot_sm2_sign(pri_key, (uint8_t *)message_digest, (uint8_t *)k, signature)) {
		return ACK_ERR_GENERIC;
	}

	return ACK_SUCCESS;
}

/**
 * @brief SM2 验签接口
 * @param id               公钥索引：通常使用 IDx_LOAD_PUBKEY (6)
 * @param message_digest   消息摘要 (32 字节)
 * @param signature        签名值 (64 字节，r + s)
 * @param sig_len          签名长度
 * @return int             0: 成功; -2: 验签失败; -1: 参数错误
 */
int SM2_verify(const uint8_t *public_key, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len)
{

	if (public_key == NULL || message_digest == NULL || signature == NULL) {
		return ACK_ERR_INVALID_ID;
	}

	// 提供的底层验签逻辑
	// public_key + 0x20 分离出 X 和 Y 分量
	if (!(boot_ecc_verify(BOOT_ECC_Curve_SM2, (uint8_t *)public_key, (uint8_t *)(public_key + 0x20),
				(uint8_t *)message_digest, (uint8_t *)signature)))
	{
		return ACK_ERR_GENERIC;
	}

	return ACK_SUCCESS;
}

void SM3_init()
{
	// HAL_OTBN_Init();
	HAL_OTBN_SM3_Init();
}
void SM3_update(const uint8_t *data, size_t data_len)
{
	// HAL_OTBN_SM3_Update(data,data_len);
	HAL_OTBN_SM3_Update((uint8_t *)data, (uint32_t)data_len);
}
void SM3_final(uint8_t *digest)
{
	HAL_OTBN_SM3_Final(digest);
}


/**
 * @brief SM4-CBC 加密函数
 */
int SM4_CBC_encrypt_process(key_id_x id, uint8_t *iv, uint8_t *plaintext, uint8_t *ciphertext, uint32_t length)
{
	// 安全校验：对 iv 指针的检查
	if (iv == NULL || plaintext == NULL || ciphertext == NULL||length == 0 || length % 16 != 0) {
		return ACK_ERR_INVALID_ID; // 指针不能为空
	}

	// 长度校验：SM4 分组大小必须是 16 字节对齐
	// if (length == 0 || length % 16 != 0) {
	// 	return ACK_ERR_INVALID_ID;
	// }

	// ID 范围校验
	if ((id !=IDx_OTP_SM4)&&(id !=IDx_TMP_SM4)) {return ACK_ERR_INVALID_ID;}

	// 获取密钥数据
	uint8_t *key = key_data_table[id];
	if((is_key_empty(key, 16))!=ACK_SUCCESS)return ACK_SLOT_NO_SET;

	HAL_SM4_KeyExpansion(key);

	uint32_t feedback[4];
	uint32_t current_block[4];

	// 将 16 字节 IV 载入反馈向量
	// 这里强制读取 16 字节。如果 iv 实际指向空间小于 16，memcpy 会发生越界******!!!!!!
	memcpy(feedback, iv, 16);

	for (uint32_t i = 0; i < length; i += 16) {
		memcpy(current_block, &plaintext[i], 16);

		// CBC 异或
		current_block[0] ^= feedback[0];
		current_block[1] ^= feedback[1];
		current_block[2] ^= feedback[2];
		current_block[3] ^= feedback[3];

		// 硬件加密
		HAL_SM4_Encrypt((uint8_t *)current_block, &ciphertext[i], 16);

		// 更新反馈链
		memcpy(feedback, &ciphertext[i], 16);
	}

	return ACK_SUCCESS;
}

int SM4_CBC_decrypt_process(key_id_x id, uint8_t *iv, uint8_t *ciphertext, uint8_t *plaintext, uint32_t length)
{
	if (iv == NULL || ciphertext == NULL || plaintext == NULL || length % 16 != 0) return ACK_ERR_INVALID_ID;
	if ((id !=IDx_OTP_SM4)&&(id !=IDx_TMP_SM4)) {return ACK_ERR_INVALID_ID;}
	uint8_t *key = key_data_table[id];
	if((is_key_empty(key, 16))!=ACK_SUCCESS)return ACK_SLOT_NO_SET;

	HAL_SM4_KeyExpansion(key);

	uint32_t last_cipher_block[4];
	uint32_t current_cipher_block[4];
	uint32_t tmp_out[4];

	// 第一个块解密后要和 IV 异或
	memcpy(last_cipher_block, iv, 16);

	for (uint32_t i = 0; i < length; i += 16) {
		// 暂存当前密文块，因为异或后它将作为下一块的“上块密文”
		memcpy(current_cipher_block, &ciphertext[i], 16);

		// 硬件解密 (注意：这里需要自己确保 HAL_SM4_Decrypt 配置了 DEC=1)
		HAL_SM4_Decrypt(&ciphertext[i], (uint8_t *)tmp_out, 16);

		// XOR 逻辑
		((uint32_t *)&plaintext[i])[0] = tmp_out[0] ^ last_cipher_block[0];
		((uint32_t *)&plaintext[i])[1] = tmp_out[1] ^ last_cipher_block[1];
		((uint32_t *)&plaintext[i])[2] = tmp_out[2] ^ last_cipher_block[2];
		((uint32_t *)&plaintext[i])[3] = tmp_out[3] ^ last_cipher_block[3];

		// 更新上一块密文记录
		memcpy(last_cipher_block, current_cipher_block, 16);
	}
	return ACK_SUCCESS;
}

/**
 * @brief SM4 通用加解密接口 (支持 ECB/CBC, 支持 KeyID 映射)
 * * @param id      密钥索引 (如 IDx_OTP_SM4=2, IDx_TMP_SM4=5)
 * @param mode    加密模式 (SM4_MODE_ECB 或 SM4_MODE_CBC)
 * @param op      操作类型 (SM4_OP_ENCRYPT 或 SM4_OP_DECRYPT)
 * @param iv      初始向量 (仅 CBC 模式需要，16字节；ECB可传NULL)
 * @param input   输入数据缓冲区
 * @param output  输出数据缓冲区
 * @param length  数据长度 (必须是 16 的倍数)
 * @return int    0: 成功, -1: 参数错误/ID无效
 */
int SM4_enc_dec_process(key_id_x id, sm4_mode_t mode, sm4_op_t op,
                        uint8_t *iv, uint8_t *input, uint8_t *output, uint32_t length)
{
	// 基础校验
	if (input == NULL || output == NULL || length == 0 || length % 16 != 0) return ACK_ERR_INVALID_ID;
	if ((id !=IDx_OTP_SM4)&&(id !=IDx_TMP_SM4)) {return ACK_ERR_INVALID_ID;}
	if (mode == SM4_MODE_CBC && iv == NULL) return ACK_ERR_INVALID_ID; // CBC 必须有 IV

	// 获取并注入密钥
	uint8_t *key = key_data_table[id];
	if (key == NULL) return ACK_ERR_INVALID_ID;

	// 执行计算
	if (mode == SM4_MODE_ECB) {
		HAL_SM4_KeyExpansion(key);
		// ECB 模式：直接调用硬件接口
		if (op == SM4_OP_ENCRYPT) {
			return HAL_SM4_Encrypt(input, output, length) == 0 ? 0 : ACK_ERR_GENERIC;
		} else {
			return HAL_SM4_Decrypt(input, output, length) == 0 ? 0 : ACK_ERR_GENERIC;
		}
	}else {
		// CBC 模式：软件链条 + 硬件块运算
		if (op == SM4_OP_ENCRYPT) {
			return SM4_CBC_encrypt_process(id, iv, input, output, length);
		} else {
			return SM4_CBC_decrypt_process(id, iv, input, output, length);
		}
	}
}

/**
 * @brief 随机数发生器自检 (外部实现)
 * 满足要求：数据量 256-bit，包含单比特、扑克、游程测试
 * @return 0: 自检通过; 其他: 错误码
 */
int Security_TRNG_SelfTest(void)
{
	uint8_t test_buf[32]; // 32字节 = 256比特
	int ret;

	// 调用原函数获取 32 字节原始随机数
	ret = trng_derive_key(test_buf, 32);
	if (ret != 0) return ret;

	// 定义统计变量
	int n1 = 0;                // 单比特统计
	int f[16] = {0};           // 扑克统计 (4-bit 块频数)
	int max_run = 0, curr_run = 1, last_bit = -1;

	// 执行三项统计分析
	for (int i = 0; i < 32; i++) {
		uint8_t b = test_buf[i];

		// 统计单比特和游程
		for (int j = 0; j < 8; j++) {
		int bit = (b >> j) & 1;

		// --- 单比特计数 ---
		n1 += bit;

		// --- 游程统计 ---
		if (bit == last_bit) {
			curr_run++;
		} else {
			if (curr_run > max_run) max_run = curr_run;
			curr_run = 1;
		}
		last_bit = bit;
		}

		// --- 扑克测试统计 (将字节拆分为两个4-bit块) ---
		f[b & 0x0F]++;
		f[(b >> 4) & 0x0F]++;
	}
	if (curr_run > max_run) max_run = curr_run;

	// 计算扑克测试平方和 (用于评估均匀性)
	uint32_t sum_sq = 0;
	for (int i = 0; i < 16; i++) sum_sq += f[i] * f[i];

	// 结果判定
	int status = 0;
	// 单比特理想值 128 (允许波动); 游程禁止过长; 扑克分布需均匀
	if ((n1 <= 103 || n1 >= 153) || (max_run >= 32) || (sum_sq > 450)) {
		status = -1; // 自检不合格
	}

	// 物理清理：按照安全要求，自检产生的临时数据必须清零
	memset(test_buf, 0, 32);

	return status;
}
#define SYSC_SEC_CPU_IRQN    26

#define PMP_R   (1 << 0)
#define PMP_W   (1 << 1)
#define PMP_X   (1 << 2)
#define PMP_A_NAPOT (3 << 3)   /* A=11 */
#define PMP_L   (1 << 7)
#define RAM_PMPADDR_4M  0x0407FFFF //ram起始地址0x10000000，4MB NAPOT
#define RAM_PMPADDR_2M  0x0403FFFF
#define RAM_PMPADDR_1M  0x0401FFFF
#define RAM_PMPADDR_64K  0x04001FFF //ram起始地址0x10000000，64KB NAPOT
#define Peri_PMPADDR_256M 0x11FFFFFF //外设起始地址0x40000000，256MB NAPOT
#define ISR_PMPADDR_E000  0x383FFFFF//中断覆盖 0xE000000(NAPOT)

void otp_patch_init(void)
{
	memset(OTP_SM2_DEC_KEY_DATA, 0, sizeof(OTP_SM2_DEC_KEY_DATA));
	memset(OTP_SM2_SIGN_KEY_DATA, 0, sizeof(OTP_SM2_SIGN_KEY_DATA));
	memset(OTP_SM4_KEY_DATA, 0, sizeof(OTP_SM4_KEY_DATA));
	memset(TMP_SM2_DEC_KEY_DATA, 0, sizeof(TMP_SM2_DEC_KEY_DATA));
	memset(TMP_SM2_SIGN_KEY_DATA, 0, sizeof(TMP_SM2_SIGN_KEY_DATA));
	memset(TMP_SM4_KEY_DATA, 0, sizeof(TMP_SM4_KEY_DATA));
	memset(LOAD_PUBKEY_DATA, 0, sizeof(LOAD_PUBKEY_DATA));
	// password_status = false;
	// next_random = 1;

	__set_PMPADDRx(0, RAM_PMPADDR_1M);
	__set_PMPADDRx(1, Peri_PMPADDR_256M);//外设pmp地址设置
	__set_PMPADDRx(2, ISR_PMPADDR_E000);//中断pmp地址设置

	//__set_PMPADDRx(0, RAM_PMPADDR_64K);
	uint8_t pmp0_cfg =PMP_R | PMP_W | PMP_X | PMP_A_NAPOT;//RWX NAPOT
	uint8_t pmp1_cfg =PMP_R | PMP_W | PMP_A_NAPOT;//RW  NAPOT
	uint8_t pmp2_cfg =PMP_R | PMP_W | PMP_A_NAPOT;//RW  NAPOT
	__set_PMPxCFG(0, pmp0_cfg);
	__set_PMPxCFG(1, pmp1_cfg);
	__set_PMPxCFG(2, pmp2_cfg);

	rv_set_int_isr(SYSC_SEC_CPU_IRQN, SWINT_Handler_ASM);//中断注册

	// rv_set_int_isr(SYSC_SEC_CPU_IRQN, SWINT_FUNC_CALL_INLINE_ASM_ADDR);//中断注册
	uint32_t clic_base = 0xE0801000 + SYSC_SEC_CPU_IRQN * 4;
	*(volatile uint8_t *)(clic_base + 1) = 0x1; // IE = 1
	*(volatile uint8_t *)(clic_base + 2) = 0x02; // 上升沿触发

	uint32_t otbn_base =0xE0801000+55*4;
	*(volatile uint8_t *)(otbn_base + 3) = 0x2F;
	cpu_intr_sec_unmask();
	// enable_global_irq(); // 确保 mstatus.MIE = 1
	__enable_irq();// 确保 mstatus.MIE = 1

	if(Security_TRNG_SelfTest()!=0){while(1);}

	goto_next_mstatus.mpp = 0;

	// uint32_t mstatus = __get_MSTATUS();
	// MODIFY_REG(mstatus, 3<<11, 0);
	// __set_MSTATUS(mstatus);
}


// #include <stdlib.h>
// #include <stdint.h>
// #include <string.h>
// #include <time.h>

// /* 简易线性同余随机数生成器 (LCG) */
// static uint32_t next_random ; // 默认种子

// void patch_srand(uint32_t seed) {
// 	next_random = seed;
// }

// static int patch_rand(void) {
// 	// 经典 LCG 算法参数（类似 glibc）
// 	next_random = next_random * 1103515245 + 12345;
// 	return (uint32_t)(next_random / 65536) % 32768;
// }

// /**
//  * @brief 软件模拟随机数生成（仅用于测试，不可用于正式生产环境的密钥生成）
//  */
// int trng_derive_key(uint8_t *derived_key, size_t key_len)
// {

// 	// 1. 参数校验
// 	if (derived_key == NULL || key_len == 0) {
// 		return -1;
// 	}

// 	// 根据你之前的逻辑，只支持 16 或 32 字节
// 	if (key_len != 32 && key_len != 16) {
// 		return -1;
// 	}

// 	/* * 2. 设置随机数种子 (Seed)
// 	* 在嵌入式测试中，建议传入一个变化的值（如 uptime 滴答数）。
// 	* 如果种子固定，每次重启后生成的“随机数”序列将完全一致。
// 	*/
// 	// static bool seeded = false;
// 	// if (!seeded) {
// 	//     srand(some_system_tick); // 建议取消注释并接入实际时钟
// 	//     seeded = true;
// 	// }

// 	// 3. 循环生成伪随机字节
// 	for (size_t i = 0; i < key_len; i++) {
// 		// rand() 通常返回 0 到 RAND_MAX 之间的 int
// 		// 取低 8 位填充到 key 中
// 		derived_key[i] = (uint8_t)(patch_rand() & 0xFF);
// 	}

// 	return 0;
// }


// /**
//  * @brief Set_password: 校验用户密码
//  * @param input_password_str 传入密码
//  * @note 如果密码存在则无法设置，如果密码不存在则设置密码
//  */
// int Set_password(const char *input_password_str)
// {
// 	// password_status = false;
// 	/* "null" 表示立即锁权限，防止提权窗口 */
// 	// if (input_password_str == NULL) {return ACK_SUCCESS;}

// 	// uint32_t otp_pwd = 0;
// 	uint8_t output_hash[32] = {0};
// 	// uint8_t stored_hash[32] = {0};
// 	uint8_t lock_flag = 0xFF;

// 	/*读取第 33 字节判断是否已设置过初始密码 */
// 	// 如果此位为 0，表示已初始化，不再允许写入
// 	if (HAL_OTP_Read(OTP_PWD_ADDR + 32, &lock_flag, 1) != 0) {LOG_E("Read OTP flag failed.");return ACK_ERR_GENERIC;}
// 	if (lock_flag==0){
// 		return ACK_SLOT_EXISTED;
// 	}else if (lock_flag==0xff) {
// 		uint32_t pwd_len = strlen(input_password_str);
// 		if (pwd_len < 12||pwd_len > 32) {return ACK_ERR_INVALID_ID;}
// 		SM3_cal((const uint8_t *)input_password_str, pwd_len, output_hash);
// 		uint8_t init_done_flag = 0x00;
// 		// SM3_cal((const uint8_t *)input_password_str, pwd_len, output_hash);
// 		if (HAL_OTP_Write(OTP_PWD_ADDR, output_hash, 32) != 0) {LOG_E("Write OTP hash failed.");return ACK_ERR_GENERIC;}
// 		if (HAL_OTP_Write(OTP_PWD_ADDR + 32, &init_done_flag, 1) != 0) {LOG_E("Write OTP lock flag failed.");return ACK_ERR_GENERIC;}
// 		// password_status = false;
// 		return ACK_SUCCESS;
// 	}
// 	return ACK_ERR_OTP;
// }

// /**
//  * @brief Check_password: 校验用户密码
//  * @param input_password_str 传入密码
//  * @note 逻辑：读取 硬件密码进行比对；错误密码将锁定权限。
//  */
// int Check_password(const char *input_password_str)
// {
// 	// uint32_t otp_pwd = 0;
// 	uint8_t output_hash[32] = {0};
// 	uint8_t stored_hash[32] = {0};
// 	uint8_t lock_flag = 0xFF;
// 	if (HAL_OTP_Read(OTP_PWD_ADDR + 32, &lock_flag, 1) != 0) {LOG_E("Read OTP flag failed.");return ACK_ERR_GENERIC;}
// 	if (lock_flag==0){
// 		// password_status = false;
// 		uint32_t pwd_len = strlen(input_password_str);
// 		SM3_cal((const uint8_t *)input_password_str, pwd_len, output_hash);
// 		if (HAL_OTP_Read(OTP_PWD_ADDR, stored_hash, 32) != 0) {LOG_E("Read stored hash failed.");return ACK_ERR_GENERIC;}
// 		if (memcmp(output_hash, stored_hash, 32) == 0) {
// 			// password_status = true;
// 			return ACK_SUCCESS;
// 		} else {
// 			return ACK_ERR_NO_PERMISSION;
// 		}
// 	}else if (lock_flag==0xFF) {
// 		return ACK_SLOT_NO_SET;
// 	}
// 	return ACK_ERR_OTP;
// }

// /**
//  * @brief 内部权限检查工具函数
//  */
// int check_password_status(void)
// {
// 	if (!password_status) {
// 		LOG_I("locked status!");
// 		return -3;
// 	}
// 	return 0;
// }


// /**
//  * @brief StoreKey: 将 TMP 数组下载到otp
//  * @param id 源 ID (必须是 IDx_TMP_SM2_DEC, IDx_TMP_SM2_SIGN, 或 IDx_TMP_SM4)
//  *	  input_password 传入的 4 字节密码
//  * @return int 0: 成功; -2: 源 ID 非法；-3 密码错误没有权限
//  */
// int StoreKey(key_id_x id, uint32_t input_password)
// {
// 	// set_password(input_password);

// 	// 调用现有检查函数，拦截未授权访问
// 	if (check_password_status() != 0) {
// 		return -3;
// 	}

// 	// 校验：只有 TMP 密钥（ID 3, 4, 5）可以执行 Store 动作
// 	if (id < IDx_TMP_SM2_DEC || id > IDx_TMP_SM4) {
// 		return -2;
// 	}

// 	// 自动计算目标 OTP ID
// 	// 映射逻辑：3->0 (DEC), 4->1 (SIGN), 5->2 (SM4)
// 	key_id_x target_id = (key_id_x)(id - 3);

// 	// 确定拷贝长度
// 	// 只有 SM4 (ID 5) 是 16 字节，其余 (ID 3, 4) 是 32 字节
// 	uint32_t key_len = (id == IDx_TMP_SM4) ? 16 : 32;

// 	// 执行同步：从 TMP 数组拷贝到 OTP 镜像数组
// 	// 使用已经定义的 key_data_table
// 	memcpy(key_data_table[target_id], key_data_table[id], key_len);


// 	//生成完整性保护字段 (基于 OTBN SM3)
// 	//3 * 16Byte (48字节填充区) + 4Byte Password = 52字节输入
// 	uint8_t hash_input[52];
// 	uint8_t hash_output[32];
// 	memset(hash_input, 0, 52);

// 	// 拷贝原始密钥到输入缓冲区
// 	memcpy(hash_input, key_data_table[id], key_len);

// 	// 再次从 OTP_PWD_ADDR 读取硬件密码用于哈希绑定
// 	uint32_t hardware_pwd = 0;
// 	HAL_OTP_CTRL_Init();
// 	HAL_OTP_Read(OTP_PWD_ADDR, (uint8_t *)&hardware_pwd, 4);
// 	memcpy(hash_input + 48, &hardware_pwd, 4);

// 	//哈希输入 (52字节) ---
// 	// LOG_I("--- SM3 Hash Input (Key + Padding + Pwd) ---");
// 	// // 打印前 48 字节密钥区
// 	// LOG_I("Key+Pad Area (48B):");
// 	// LOG_HEX(hash_input, 32);
// 	// LOG_RAW("\r\n");
// 	// // 打印最后 4 字节密码区
// 	// LOG_RAW("Hardware Pwd Area (+48): %02X %02X %02X %02X",
// 	// 	hash_input[48], hash_input[49], hash_input[50], hash_input[51]);
// 	// LOG_RAW("\r\n");

// 	// 调用已验证成功的 OTBN SM3 流程
// 	// HAL_OTBN_Init();
// 	HAL_OTBN_SM3_Init();
// 	HAL_OTBN_SM3_Update(hash_input, 52);
// 	HAL_OTBN_SM3_Final(hash_output);

// 	LOG_I("--- SM3 Hash Output (Full 32B) ---");
// 	LOG_HEX(hash_output, 32);
// 	LOG_RAW("\r\n");
// 	//物理存储 (写入完整性保护后的内容)
// 	/* 计算新槽位地址：每个 Slot 预留 40 字节偏移 (32B MaxKey + 4B Tag + 4B Align)*/
// 	uint32_t phys_addr = OTP_NEW_SLOT_START + (target_id * 0x28);
// 	LOG_I("Calculated OTP Address: Key at 0x%X, Tag at 0x%X",
// 		phys_addr, phys_addr + key_len);

// 	// 写入密钥原始数据 (16B 或 32B)
// 	if (HAL_OTP_Write(phys_addr, key_data_table[id], key_len) != 0) {
// 		return -1;
// 	}

// 	// LOG_I("[Write 1/2] Key Data to Address: 0x%08X (Len: %d)", phys_addr, key_len);
// 	// LOG_HEX(key_data_table[id], key_len);
// 	// LOG_RAW("\r\n");

// 	//密钥数据后存入 4 字节 SM3 Tag
// 	if (HAL_OTP_Write(phys_addr + key_len, hash_output, 4) != 0) {
// 		return -1;
// 	}

// 	// uint32_t tag_addr = phys_addr + key_len;
// 	LOG_I("SM3 Tag to Address: 0x%08X (Len: 4)", phys_addr + key_len);
// 	LOG_RAW("Tag Content: %02X %02X %02X %02X",
// 		hash_output[0], hash_output[1], hash_output[2], hash_output[3]);
// 	LOG_RAW("\r\n");
// 	// LOG_I("StoreKey: ID %d synced and stored at 0x%X with Tag.", id, phys_addr);
// 	// set_password(0);              // 执行完后立即重新锁定权限，确保安全
// 	return 0;
// }

// /**
//  * @brief DestroyKey: 仅仅支持删除TMP 数组相应数据
//  * @param id 源 ID (必须是 IDx_TMP_SM2_DEC, IDx_TMP_SM2_SIGN, 或 IDx_TMP_SM4)
//  *	  input_password 传入的 4 字节密码
//  * @return int 0: 成功; -2: 源 ID 非法；-3 密码错误没有权限
//  */
// int DestroyKey(key_id_x id, uint32_t input_password)
// {
// 	// set_password(input_password);
// 	// 权限检查：如果不匹配则返回 -3
// 	// if (check_password_status() != 0) return -3;

// 	// 仅支持销毁 TMP 密钥 (ID 3/4/5)
// 	if (id < IDx_TMP_SM2_DEC || id > IDx_TMP_SM4) {
// 		LOG_E("Failed! DestroyKey: ID %d is OTP-based or invalid.", id);
// 		return -2;
// 	}

// 	uint32_t wipe_len = (id == IDx_TMP_SM4) ? 16 : 32;
// 	memset(key_data_table[id], 0, wipe_len);
// 	LOG_I("Success! DestroyKey: Key %d wiped.", id);
// 	// set_password(0);              // 执行完后立即重新锁定权限，确保安全
// 	return 0;
// }
// /**
//  * @brief GetPubKey: 根据相应槽位的私钥导出对应的公钥。
//  * @param id 源 ID (必须是 IDx_OTP_SM2_DEC, IDx_OTP_SM2_SIGN, 或 IDx_TMP_SM2_DEC，IDx_TMP_SM2_SIGN)
//  *	pubkey 输出的公钥结果
//  * @return int 0: 成功; -2: 源 ID 非法
//  */
// int GetPubKey(key_id_x id, uint8_t *pubkey)
// {
// 	uint8_t *src_priv_key = NULL;
// 	uint8_t priv_reversed[32];
// 	// 关键修复：定义局部变量存储处理后的基点坐标
// 	uint8_t Gx[32], Gy[32];
// 	struct HAL_OTBN_ECC256_ScalarMult_Param scalar_p;

// 	// if (check_password_status() != 0) return -3;

// 	switch (id) {
// 		case IDx_OTP_SM2_DEC:   src_priv_key = OTP_SM2_DEC_KEY_DATA;  break;
// 		case IDx_OTP_SM2_SIGN:  src_priv_key = OTP_SM2_SIGN_KEY_DATA; break;
// 		case IDx_TMP_SM2_DEC:
// 		case IDx_TMP_SM2_SIGN:  src_priv_key = key_data_table[id];    break;
// 		default: return -2;
// 	}

// 	if (src_priv_key == NULL) return -4;//在初始化的时候填过了数组为0这里应该需要修改一下吧？？？？？

// 	// HAL_OTBN_Init();

// 	// 反转私钥 (大端 -> 小端)
// 	copy_reverse(priv_reversed, src_priv_key, 32);

// 	//从 SM2_G 提取基点并处理 (参考 boot_sm2_encrypt 逻辑)
// 	memcpy(Gx, SM2_G, 32);
// 	memcpy(Gy, SM2_G + 32, 32);
// 	arr_reverse(Gx, 32); // OTBN 硬件需要小端基点
// 	arr_reverse(Gy, 32);

// 	//设置硬件参数
// 	scalar_p.scalar   = (uint32_t *)priv_reversed;
// 	scalar_p.point_x  = (uint32_t *)Gx;
// 	scalar_p.point_y  = (uint32_t *)Gy;
// 	scalar_p.result_x = (uint32_t *)&pubkey[0];
// 	scalar_p.result_y = (uint32_t *)&pubkey[32];

// 	//执行计算
// 	HAL_OTBN_ECC256_ScalarMult_Polling(HAL_OTBN_ECC256_CURVE_SM2, &scalar_p);

// 	//将结果反转回标准大端格式给应用层
// 	arr_reverse(&pubkey[0], 32);
// 	arr_reverse(&pubkey[32], 32);

// 	LOG_I("Success! GetPubKey: Success using SM2_G for ID %d", id);
// 	return 0;
// }

// /**
//  * @brief LoadPublicKey: 加载外部公钥到指定的存储区域
//  * @param pubkey 指向 64 字节外部公钥的指针 (X 32字节 + Y 32字节)
//  * @return 0: 成功; -4: 存储公钥物理地址缓冲区无效
//  */
// int LoadPublicKey(uint8_t *pubkey)
// {
// 	//获取存储公钥的物理地址 (IDx_LOAD_PUBKEY)
// 	uint8_t *dest = key_data_table[IDx_LOAD_PUBKEY];

// 	if (dest == NULL) {
// 		return -4;
// 	}

// 	// 拷贝公钥数据 (SM2 公钥固定为 64 字节)
// 	//直接存储
// 	memcpy(dest, pubkey, 64);

// 	LOG_I("Success! LoadPublicKey: External Public Key loaded into slot ID %d", IDx_LOAD_PUBKEY);

// 	//打印加载的公钥前 4 字节用于确认
// 	// LOG_I("Pubkey Load Prefix: %02X %02X %02X %02X", dest[0], dest[1], dest[2], dest[3]);

// 	return 0;
// }

// /**
//  * @brief ExportKey:     使用ID6外部公钥加密导出内部 TMP 密钥即将TMP_KEY用LOAD_PUBKEY加密导出
//  * @param id             待导出的 ID (支持 3, 4, 5)
//  * @param input_password 调用者传入的 4 字节口令
//  * @param ciphertext     输出密文
//  * @param standard_mode     0旧国标；1新国标
//  * @return 0: 成功; -2: ID 非法; -3: 密码错误; -5: 公钥未加载; -1: 硬件/TRNG 错误
//  */
// int ExportKey(key_id_x id, uint32_t input_password, uint8_t *ciphertext,bool standard_mode)
// {

// 	//使用现有接口进行鉴权
// 	// 每次调用 ExportKey 都会尝试解锁，如果 input_password 不对，status 就会被置为 false
// 	// set_password(input_password);

// 	// 调用现有检查函数，拦截未授权访问
// 	// if (check_password_status() != 0) {
// 	// 	return -3;
// 	// }

// 	//导出策略与长度判定
// 	if (id < IDx_TMP_SM2_DEC || id > IDx_TMP_SM4) {
// 		LOG_E("Failed! ExportKey: Restricted ID %d.", id);
// 		// set_password(0);//执行完需要清理状态（password_status = false;）
// 		return -2;
// 	}

// 	uint32_t klen = (id == IDx_TMP_SM4) ? 16 : 32;

// 	// 准备资源
// 	uint8_t *plain_key_source = key_data_table[id];
// 	uint8_t *wrap_pub_key = key_data_table[IDx_LOAD_PUBKEY];

// 	// 检查 ID 6 槽位是否加载了外部公钥
// 	if (wrap_pub_key[0] == 0 && wrap_pub_key[32] == 0) {
// 		// set_password(0);//执行完需要清理状态（password_status = false;）
// 		LOG_E("Failed! ExportKey: External public key not loaded.");
// 		return -5;
// 	}

// 	//生成随机数 k
// 	uint8_t random_k[32];
// 	int ret = trng_derive_key(random_k, 32);
// 	if (ret != 0) {
// 		// set_password(0);//执行完需要清理状态（password_status = false;）
// 		LOG_E("Failed! ExportKey: TRNG failed.");
// 		return -1;
// 	}

// 	//执行 SM2 加密导出
// 	LOG_I("ExportKey: Encrypting TMP Key ID %d...", id);

// 	// 调用 SM2 算法接口
// 	ret = (int32_t)boot_sm2_encrypt(plain_key_source, ciphertext, klen, random_k, wrap_pub_key, standard_mode);

// 	if (ret == 1) {
// 		ret = 0;
// 		LOG_I("Success! ExportKey: Export success.");
// 	} else {
// 		ret = -1;
// 		// set_password(0);//执行完需要清理状态（password_status = false;）
// 		LOG_E("Failed! ExportKey: Encryption failed.");
// 	}

// 	// 清理现场
// 	memset(random_k, 0, 32);     // 抹除敏感随机数
// 	// set_password(0);              // 执行完后立即重新锁定权限，确保安全

// 	return ret;
// }














// /**
//  * @brief 将外部数据安全拷贝至内部密钥槽位
//  * @param id 目标槽位 ID (0-6)
//  * @param src 外部数据源指针 (来自 main 的 buffer)
//  * @param len 拷贝字节数
//  * @return 0: 成功; -1: ID 越界; -2: 指针为空
//  */
// int memcopy_patch(key_id_x id, const uint8_t *src, uint32_t len)
// {
// 	// 1. 边界与空指针检查
// 	if (id >= IDx_MAX) return -1;
// 	if (src == NULL) return -2;

// 	// 2. 获取目标内部地址
// 	uint8_t *dest = key_data_table[id];

// 	// 3. 执行拷贝 (在机器模式下，使用简单的 for 循环最稳妥)
// 	for (uint32_t i = 0; i < len; i++) {
// 		dest[i] = src[i];
// 	}

// 	return 0;
// }

// /**
//  * @brief 将内部密钥槽位数据提取至外部缓冲区 (反向拷贝)
//  * @param id 来源槽位 ID (0-6)
//  * @param dest 外部目标缓冲区指针 (用于接收数据)
//  * @param len 拷贝字节数
//  * @return 0: 成功; -1: ID 越界; -2: 指针为空
//  */
// int get_key_data_table_patch(key_id_x id, uint8_t *dest, uint32_t len)
// {
// 	// 边界与空指针检查
// 	if (id >= IDx_MAX) return -1;
// 	if (dest == NULL) return -2;

// 	// 获取内部源地址
// 	uint8_t *src = key_data_table[id];

// 	// 执行拷贝 (从内部 table 拷贝到外部 dest)
// 	// 使用 for 循环可以规避库函数 memcpy 可能存在的地址对齐或重定位问题
// 	for (uint32_t i = 0; i < len; i++) {
// 		dest[i] = src[i];
// 	}

// 	return 0;
// }
// void* patch_get_key_ptr(key_id_x id)
// {
// 	if (id >= IDx_MAX) return NULL;
// 	return (void*)key_data_table[id];
// }

// int export_key_to_user_wrapper(key_id_x id, uint8_t *user_buf, uint32_t len)
// {
// 	// 1. 基础安全检查
// 	if (id >= IDx_MAX) return -1;
// 	if (user_buf == NULL) return -2;

// 	// 2. 动态获取该 ID 的最大允许长度
// 	uint32_t max_len = 0;
// 	if (id == IDx_LOAD_PUBKEY) {
// 		max_len = 64;
// 	} else if (id == IDx_OTP_SM4 || id == IDx_TMP_SM4) {
// 		max_len = 16;
// 	} else {
// 		max_len = 32; // 其余 SM2 相关的都是 32 字节
// 	}

// 	// 3. 长度卫兵：如果外部传的 len 太大，直接报错
// 	if (len > max_len) {
// 		return -3;
// 	}

// 	// 4. 执行搬运
// 	uint8_t *internal_src = key_data_table[id];
// 	for (uint32_t i = 0; i < len; i++) {
// 		user_buf[i] = internal_src[i];
// 	}

// 	return 0;
// }










// /* 用于存储不同key_id对应的密钥 */
// static const uint8_t *key_table[KEY_ID_MAX];
// // 用于存储不同的密钥
// static const uint8_t key_0[16] = {
//     0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
//     0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10
// };

// static const uint8_t key_1[16] = {
//     0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
//     0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff, 0x00
// };

// static const uint8_t pri_key[] = {
//         0xA9, 0x61, 0x9A, 0xD2, 0xAD, 0x5D, 0xFE, 0x26, 0x76, 0xC6, 0x46, 0xE3, 0x66, 0x1F, 0xDD, 0x8B,
//         0x53, 0x8F, 0xE4, 0xAE, 0x82, 0xFC, 0xAF, 0xA6, 0x70, 0xAC, 0xBF, 0x03, 0x92, 0xAE, 0x4D, 0xC1,
//     };

// static const uint8_t *key_table[KEY_ID_MAX] = {
//     [KEY_ID_0] = key_0,
//     [KEY_ID_1] = key_1,
//     [KEY_ID_2] = pri_key,
// };


// // 根据 key_id 获取对应的密钥地址
// static const uint8_t *get_key_by_id(key_id_t key_id)
// {
//     if (key_id >= KEY_ID_MAX) {
//         return NULL;  // 错误：无效的 key_id
//     }

//     return key_table[key_id];  // 返回密钥地址
// }


// /* SM4单块加密函数，使用指定的key_id进行ECB模式加密 */
// int sm4_encrypt_block(key_id_t key_id, const uint8_t *plaintext, uint8_t *ciphertext)
// {
//     int ret;

//     const uint8_t *key = get_key_by_id(key_id);  // 获取密钥
//     if (key == NULL) {
//         return -1;  // 无效的 key_id
//     }

//     HAL_SM4_KeyExpansion(key);

//     ret=HAL_SM4_Encrypt(plaintext, ciphertext, SM4_BLOCK_SIZE);
//     if (ret != HAL_OK) {
//         return -4;  // 加密失败
//     }

//     return 0;  // 加密成功
// }

// int sm4_decrypt_block(key_id_t key_id,const uint8_t *ciphertext,uint8_t *plaintext)
// {
//     int ret;

//     if (ciphertext == NULL || plaintext == NULL) {
//         return -1;
//     }

//     const uint8_t *key = get_key_by_id(key_id);  // 获取密钥
//     if (key == NULL) {
//         return -1;  // 无效的 key_id
//     }

//     /* 2. 装载密钥到 SM4 硬件 */
//     HAL_SM4_KeyExpansion(key);

//     /* 3. ECB 单块解密（16 字节） */
//     ret = HAL_SM4_Decrypt(ciphertext, plaintext, SM4_BLOCK_SIZE);
//     if (ret != HAL_OK) {
//         return -4;
//     }

//     return 0;
// }

// int sm3_init(sm3_ctx_t *ctx)
// {
// 	HAL_LSSHA_SM3_Init();
// 	return 0;
// }
// int sm3_update(sm3_ctx_t *ctx, const uint8_t *data, size_t data_len)
// {
// 	HAL_LSSHA_Update(data,data_len);
// 	return 0;
// }
// int sm3_final(sm3_ctx_t *ctx, uint8_t *digest){
// 	HAL_LSSHA_Final(digest);
// 	return 0;
// }

/*sm2*/
// int sm2_encrypt(const uint8_t *public_key,const uint8_t *plaintext, size_t pt_len,
// 		uint8_t *ciphertext,size_t ct_len,uint8_t *random_num,bool standard_mode)
// {
// 	if (public_key == NULL || plaintext == NULL || ciphertext == NULL)
// 	{
// 		return -1; // 错误：参数无效
// 	}
// 	if (!boot_sm2_encrypt((uint8_t *)plaintext, ciphertext, pt_len, random_num, (uint8_t *)public_key, standard_mode)) {
// 		 return -2;
// 	}
// 	return 0;
// 	// bool boot_sm2_encrypt(uint8_t *plaintext, uint8_t *ciphertext, uint32_t klen,
// 	// 	 uint8_t *random_num, uint8_t *public_key, standard_mode);
// }

// int sm2_decrypt(key_id_t key_id,const uint8_t *ciphertext,size_t ct_len,uint8_t *plaintext, size_t pt_len, bool standard_mode)
// {
// 	const uint8_t *pri_key = get_key_by_id(key_id);
// 	if (pri_key == NULL) {
// 		return -1;  // 错误：无效的 key_id
// 	}

// 	if (!boot_sm2_decrypt((uint8_t *)ciphertext, plaintext, pt_len, (uint8_t *)pri_key, standard_mode)) {
// 		return -2;  // 错误：解密失败
// 	}
// 	return 0;
// 	// bool boot_sm2_decrypt(uint8_t *ciphertext, uint8_t *plaintext, uint32_t klen, uint8_t *private_key, bool standard_mode);
// }

// int sm2_sign(uint8_t *private_key, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature)
// {
// 	if(!(boot_sm2_sign(private_key,message_digest, k,signature)))
// 	{
// 		return -2;
// 	}
// 	return 0;
// 	//  boot_sm2_sign(uint8_t *private_key, uint8_t *msg, uint8_t *random_num, uint8_t *sign);
// }
// int sm2_verify_digest(const uint8_t *public_key,const uint8_t *message_digest,const uint8_t *signature,size_t sig_len)
// {
// 	if (!(boot_ecc_verify(BOOT_ECC_Curve_SM2, public_key,public_key+0x20,message_digest,signature))) {
// 		return -2;
// 	}

// 	return 0;
// // boot_ecc_verify(enum BOOT_ECC_CURVE_TYPE curve, uint8_t *pubkey_x, uint8_t *pubkey_y, uint8_t *msg, uint8_t *sign);
// }


// int trng_get_128bit(uint32_t out[4])
// {
//     if (out == NULL) {
//         return -1;
//     }

//     HAL_TRNG_MSP_Init();

//     send_cmd(CMD_GEN_NOISE);
//     send_cmd(CMD_CREATE_STATE);
//     send_cmd(CMD_GEN_RANDOM);
//     out[0] = DWTRNG->RAND[0];
//     out[1] = DWTRNG->RAND[1];
//     out[2] = DWTRNG->RAND[2];
//     out[3] = DWTRNG->RAND[3];

//     send_cmd(CMD_ADVANCE_STATE);

//     SYSC_SEC_CPU->PD_CPU_CLKG[1] =
//         SYSC_SEC_CPU_CLKG_CLR_NIST_TRNG_MASK;

//     return 0;
// }
// #if 0/**
//  * @brief 随机数密钥；key_len：bytes
//  */
// #define WORD_BITS 32U
// int32_t Get_Derived_Key(uint8_t *derived_key, size_t key_len)
// {
//     if (derived_key == NULL || key_len == 0|| key_len % 4 != 0) {
//         return -1;
//     }

//     HAL_IWDG_DeInit(SEC_IWDG);
//     SEC_PMU->SFT_CTRL[2] &= ~0xf;

//     HAL_StatusTypeDef res = HAL_TRNG_Init();
//     if (res != HAL_OK) {
//         LOG_I("TRNG init failed!");
//         return -1;
//     }else {
//         LOG_I("TRNG init success!");
//     }
//     uint32_t target_words = key_len *4/ WORD_BITS;  // 每次生成 4 字节，总共生成多少个随机数
//     uint32_t random32bit;

//     for (uint32_t i = 0; i < target_words; ++i) {
//         if (HAL_TRNG_GenerateRandomNumber(&random32bit) != HAL_OK) {
//             LOG_I("TRNG gen error at i=%u", i);
//             break;
//         }
//        *((uint32_t *)(derived_key + i * 4)) = random32bit;
//         LOG_I("0x%08x", random32bit);
//     }

//     HAL_TRNG_DeInit();
//     LOG_I("TRNG deinitialized.");
//     return 0;
// }
// #endif

// /**
//  * @brief 生成会话密钥，使用 SM3 算法进行完整性保护
//  使用外部提供的盐值和盐值长度生成会话密钥，并通过 SM3 算法进行哈希处理
//  session_key 是输出的会话密钥，session_key_len 是会话密钥的长度
//  */

// int32_t Generate_Session_Key(const uint8_t *external_salt, size_t salt_len, uint8_t *session_key, size_t session_key_len)
// {
//     if (external_salt == NULL || session_key == NULL || salt_len == 0 || session_key_len == 0) {
//         return ERROR;
//     }
//     // 使用 SM3 算法生成会话密钥
//     sm3_ctx_t sm3_ctx;
//     sm3_init(&sm3_ctx);
//     sm3_update(&sm3_ctx, external_salt, salt_len);  // 添加盐值
//     sm3_final(&sm3_ctx, session_key);  // 完成 SM3 哈希计算，输出会话密钥
//     return 0;
// }

// void otp_patch_init()
// {
	// mpu_region_attr_t attr;
	// attr.r = 1;              // 可读
	// attr.w = 1;              // 可写
	// attr.x = 1;              // 可执行
	// attr.a = ADDRESS_MATCHING_NAPOT; // 使用 NAPOT 模式
	// attr.l = 0;              // 不锁定
	// csi_mpu_config_region(0,0x10000000,REGION_SIZE_64KB,attr, 1);
// 	goto_next_mstatus.mpp=0;
// }

/* 128KB NAPOT, base = 0x10000000
 * size = 128KB = 0x20000
 * pmpaddr = (base >> 2) | ((size/2 - 1) >> 2)
 *          = (0x10000000 >> 2) | (0x10000 - 1 >> 2)
 *          = 0x04000000 | 0x00003FFF
 *          = 0x04003FFF
 */


// 定义一个全局标志或直接在这里操作
// 注意：使用 interrupt 属性，编译器会自动生成保存/恢复寄存器以及 mret 指令
// void My_Handler(func,addr,bit_mask)
// {
// 	SWINT_FUNC_CALL_INLINE_ASM_ADDR(func, 0x40022028,1);
// 	cpu_intr_sec_clr();
// }
// void My_Handler(void)
// {
// 	// 1. 获取 a4 寄存器里的函数地址（即 sm4_encrypt_block）
// 	register void (*target_func)(uint32_t, const uint8_t*, uint8_t*) __asm__("a4");
// 	register uint32_t arg0 __asm__("a0");
// 	register uint8_t *arg1 __asm__("a1");
// 	register uint8_t *arg2 __asm__("a2");

// 	// 2. 执行真正的函数
// 	if (target_func) {
// 		target_func(arg0, arg1, arg2); // a0, a1, a2 会由硬件透传
// 	}

// 	// 3. 清除中断信号，放行 main.c 里的宏
// 	// 这样 main.c 里的 bnez 循环才会结束
// 	//     *(volatile uint32_t *)0x40022028 = 0;
// 	cpu_intr_sec_clr(); // 清除 0x40022028
// }


// int32_t Get_Derived_Key(uint8_t *derived_key, size_t key_len)
// {
//     if (derived_key == NULL || key_len == 0) {
//         return -1;
//     }
//     if (key_len!=32 && key_len!=16)
//     {
// 	return -1;
//     }
//      // 使能 TRNG 时钟并复位
//     HAL_TRNG_MSP_Init();
//     // 初始化 TRNG 状态机
//     send_cmd(CMD_GEN_NOISE);
//     send_cmd(CMD_CREATE_STATE);
//     send_cmd(CMD_GEN_RANDOM);
//     uint32_t rand[4];
//     rand[0] = DWTRNG->RAND[0];
//     rand[1] = DWTRNG->RAND[1];
//     rand[2] = DWTRNG->RAND[2];
//     rand[3] = DWTRNG->RAND[3];
//     send_cmd(CMD_ADVANCE_STATE);

//     // 将 rand 数据转换并存入 derived_key
//     for (size_t i = 0; i < 16; i++) {
//         derived_key[i] = ((uint8_t *)rand)[i];
//     }

//     /* -------- 如果需要 32 byte，再生成一次 -------- */
//     if (key_len == 32) {
//         send_cmd(CMD_GEN_RANDOM);
//         rand[0] = DWTRNG->RAND[0];
//         rand[1] = DWTRNG->RAND[1];
//         rand[2] = DWTRNG->RAND[2];
//         rand[3] = DWTRNG->RAND[3];
//         send_cmd(CMD_ADVANCE_STATE);

//         // 将第二次的 rand 数据转换并填充到 derived_key
//         for (size_t i = 0; i < 16; i++) {
//             derived_key[16 + i] = ((uint8_t *)rand)[i];
//         }
//     }

//     // 关闭 TRNG 时钟
//     SYSC_SEC_CPU->PD_CPU_CLKG[1] = SYSC_SEC_CPU_CLKG_CLR_NIST_TRNG_MASK;
//     return 0;
// }
#include "ls_hal_flash.h"
#include "ls_soc_gpio.h"
#include "platform.h"
#include "log.h"
#include <stdio.h>
#include <string.h>
#include "hal_flash_int.h"
#include "otp_patch.h"
#include "swint_call_asm.h"
#include "asm_swint.h"
#include "otp_patch.h"


// --- Set_password(Set_password_ADDR) ---
// typedef int (*set_pwd_ptr_t)(const char *input_password_str);
typedef int (*set_pwd_ptr_t)(const char *);
int Set_password_wrapper(const char *input_password_str)
{
	int ret = ((set_pwd_ptr_t)Set_password_ADDR)(input_password_str);
	// volatile uint8_t *real_password_status = (volatile uint8_t *)Password_status_ADDR;
	// uint8_t password_status_val = *real_password_status;
	// if (password_status_val==1) {
	// 	LOG_I("TEST pwd UNLOCK!");
	// }else {
	// 	LOG_I("TEST pwd LOCK! val=%d",password_status_val);
	// }

	cpu_intr_sec_clr();
	return ret;
}

NOINLINE int ASM_Set_password(const char *input_password_str)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(Set_password_wrapper, 0x40022028, 1);
}
int Invoke_Set_password(const char *input_password_str)
{
	int ret = ASM_Set_password(input_password_str);
	return ret;
}

// --- Check_password(Check_password_ADDR) ---
// typedef int (*check_pwd_ptr_t)(const char *input_password_str);
typedef int (*check_pwd_ptr_t)(const char *);
int Check_password_wrapper(const char *input_password_str)
{
	int ret = ((check_pwd_ptr_t)Check_password_ADDR)(input_password_str);

	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_Check_password(const char *input_password_str)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(Check_password_wrapper, 0x40022028, 1);
}
int Invoke_Check_password(const char *input_password_str)
{
	int ret = ASM_Check_password(input_password_str);
	return ret;
}

// --- GenerateKey(GenerateKey_ADDR) ---
// typedef int (*GenerateKey_ptr_t)(key_id_x id);
typedef int (*GenerateKey_ptr_t)(key_id_x);
int GenerateKey_wrapper(key_id_x id)
{
	int ret = ((GenerateKey_ptr_t)GenerateKey_ADDR)(id);

	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_GenerateKey(key_id_x id)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(GenerateKey_wrapper, 0x40022028, 1);
}
int Invoke_GenerateKey(key_id_x id)
{
	int ret = ASM_GenerateKey(id);
	return ret;
}

// --- StoreKey(StoreKey_ADDR) ---
// typedef int (*StoreKey_ptr_t)(key_id_x id,const char *input_password_str);
typedef int (*StoreKey_ptr_t)(key_id_x,const char *);
int StoreKey_wrapper(key_id_x id,const char *input_password_str)
{
	int ret = ((StoreKey_ptr_t)StoreKey_ADDR)(id,input_password_str);

	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_StoreKey(key_id_x id,const char *input_password_str)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(StoreKey_wrapper, 0x40022028, 1);
}
int Invoke_StoreKey(key_id_x id,const char *input_password_str)
{
	int ret = ASM_StoreKey(id,input_password_str);
	return ret;
}

//---Load_sram_otp(Load_sram_otp_ADDR) ---
// typedef int (*Load_sram_otp_ptr_t)(key_id_x id,const char *input_password_str);
typedef int (*Load_sram_otp_ptr_t)(key_id_x,const char *);
int Load_sram_otp_wrapper(key_id_x id,const char *input_password_str)
{
	int ret = ((Load_sram_otp_ptr_t)Load_sram_otp_ADDR)(id,input_password_str);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_Load_sram_otp(key_id_x id,const char *input_password_str)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(Load_sram_otp_wrapper, 0x40022028, 1);
}
int Invoke_Load_sram_otp(key_id_x id,const char *input_password_str)
{
	int ret = ASM_Load_sram_otp(id,input_password_str);
	return ret;
}

// --- DestroyKey(DestroyKey_ADDR) ---
// typedef int (*DestroyKey_ptr_t)(key_id_x id，const char *input_password_str);
typedef int (*DestroyKey_ptr_t)(key_id_x,const char *);
int DestroyKey_wrapper(key_id_x id,const char *input_password_str)
{
	int ret = ((DestroyKey_ptr_t)DestroyKey_ADDR)(id,input_password_str);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_DestroyKey(key_id_x id,const char *input_password_str)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(DestroyKey_wrapper, 0x40022028, 1);
}
int Invoke_DestroyKey(key_id_x id,const char *input_password_str)
{
	int ret = ASM_DestroyKey(id,input_password_str);
	return ret;
}

// --- GetPubKey(GetPubKey_ADDR) ---
// typedef int (*GetPubKey_ptr_t)(key_id_x id, uint8_t *pubkey);
typedef int (*GetPubKey_ptr_t)(key_id_x,uint8_t *);
int GetPubKey_wrapper(key_id_x id, uint8_t *pubkey)
{
	int ret = ((GetPubKey_ptr_t)GetPubKey_ADDR)(id,pubkey);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_GetPubKey(key_id_x id, uint8_t *pubkey)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(GetPubKey_wrapper, 0x40022028, 1);
}
int Invoke_GetPubKey(key_id_x id, uint8_t *pubkey)
{
	int ret = ASM_GetPubKey(id,pubkey);
	return ret;
}

// --- LoadPublicKey(LoadPublicKey_ADDR) ---
// typedef int (*LoadPublicKey_ptr_t)(uint8_t *pubkey);
typedef int (*LoadPublicKey_ptr_t)(uint8_t *);
int LoadPublicKey_wrapper(uint8_t *pubkey)
{
	int ret = ((LoadPublicKey_ptr_t)LoadPublicKey_ADDR)(pubkey);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_LoadPublicKey(uint8_t *pubkey)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(LoadPublicKey_wrapper, 0x40022028, 1);
}
int Invoke_LoadPublicKey(uint8_t *pubkey)
{
	int ret = ASM_LoadPublicKey(pubkey);
	return ret;
}

// --- ExportKey(ExportKey_ADDR) ---
// typedef int (*ExportKey_ptr_t)(key_id_x id, uint8_t *ciphertext,bool standard_mode);
typedef int (*ExportKey_ptr_t)(key_id_x,uint8_t *,bool);
int ExportKey_wrapper(key_id_x id, uint8_t *ciphertext,bool standard_mode)
{
	int ret = ((ExportKey_ptr_t)ExportKey_ADDR)(id,ciphertext,standard_mode);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_ExportKey(key_id_x id, uint8_t *ciphertext,bool standard_mode)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(ExportKey_wrapper, 0x40022028, 1);
}
int Invoke_ExportKey(key_id_x id, uint8_t *ciphertext,bool standard_mode)
{
	int ret = ASM_ExportKey(id,ciphertext,standard_mode);
	return ret;
}

// --- ImportKey(ImportKey_ADDR) ---
// typedef int (*ImportKey_ptr_t)(key_id_x target_id,key_id_x decryption_id, uint8_t *ciphertext, bool standard_mode);
typedef int (*ImportKey_ptr_t)(key_id_x,key_id_x, uint8_t *,bool);
int ImportKey_wrapper(key_id_x target_id,key_id_x decryption_id, uint8_t *ciphertext, bool standard_mode)
{
	int ret = ((ImportKey_ptr_t)ImportKey_ADDR)(target_id,decryption_id,ciphertext,standard_mode);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_ImportKey(key_id_x target_id,key_id_x decryption_id, uint8_t *ciphertext, bool standard_mode)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(ImportKey_wrapper, 0x40022028, 1);
}
int Invoke_ImportKey(key_id_x target_id,key_id_x decryption_id, uint8_t *ciphertext, bool standard_mode)
{
	int ret = ASM_ImportKey(target_id,decryption_id,ciphertext,standard_mode);
	return ret;
}


//---SM2_encrypt (SM2_encrypt_ADDR) ---
// typedef struct {
// 	const uint8_t *public_key;
// 	const uint8_t *plaintext;
// 	size_t pt_len;
// 	uint8_t *ciphertext;
// 	size_t ct_len;
// 	uint8_t *random_num;
// 	bool standard_mode;
// } sm2_enc_args_t;

typedef int (*sm2_enc_ptr_t)(sm2_enc_args_t *);
int SM2_encrypt_wrapper(sm2_enc_args_t *args)
{

	typedef int (*rom_sm2_func_t)(const uint8_t *, const uint8_t *,size_t, uint8_t *,size_t,uint8_t *,bool);
	rom_sm2_func_t sm2_enc_func = (rom_sm2_func_t)SM2_encrypt_ADDR;
	int ret = sm2_enc_func(
		args->public_key,
		args->plaintext,
		args->pt_len,
		args->ciphertext,
		args->ct_len,
		args->random_num,
		args->standard_mode
	);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_SM2_encrypt(sm2_enc_args_t *arg)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(SM2_encrypt_wrapper, 0x40022028, 1);
}
int Invoke_SM2_encrypt(const uint8_t *public_key,const uint8_t *plaintext, size_t pt_len,
		uint8_t *ciphertext,size_t ct_len,uint8_t *random_num,bool standard_mode)
{

	static sm2_enc_args_t args;

	args.public_key   = public_key;
	args.plaintext    = plaintext;
	args.pt_len       = pt_len;
	args.ciphertext   = ciphertext;
	args.ct_len       = ct_len;
	args.random_num    = random_num;
	args.standard_mode =standard_mode;

	int ret = ASM_SM2_encrypt(&args);
	return ret;
}

// --- SM2_decrypt (SM2_decrypt_ADDR) ---
// typedef struct {
// 	key_id_x id;
// 	const uint8_t *ciphertext;
// 	size_t ct_len;
// 	uint8_t *plaintext;
// 	size_t pt_len;
// 	bool standard_mode;
// } sm2_dec_args_t;
typedef int (*rom_sm2_dec_func_t)(key_id_x,const uint8_t *,size_t, uint8_t *,size_t,bool);
int SM2_decrypt_wrapper(sm2_dec_args_t *args) {

	rom_sm2_dec_func_t sm2_dec_func = (rom_sm2_dec_func_t)SM2_decrypt_ADDR;
	int ret = sm2_dec_func(
		args->id,
		args->ciphertext,
		args->ct_len,
		args->plaintext,
		args->pt_len,
		args->standard_mode
	);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_SM2_decrypt_Process(sm2_dec_args_t *arg)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(SM2_decrypt_wrapper, 0x40022028, 1);
}
int Invoke_SM2_decrypt(key_id_x id, const uint8_t *ciphertext, size_t ct_len,
		uint8_t *plaintext, size_t pt_len, bool standard_mode)
{

	static sm2_dec_args_t args;

	args.id   = id;
	args.ciphertext    = ciphertext;
	args.ct_len       = ct_len;
	args.plaintext   = plaintext;
	args.pt_len       = pt_len;
	args.standard_mode    = standard_mode;

	int ret = ASM_SM2_decrypt_Process(&args);
	return ret;
}


// --- SM2_sign (SM2_sign_ADDR) ---
typedef int (*sm2_sign_ptr_t)(key_id_x id, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature);
int SM2_sign_wrapper(key_id_x id, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature)
{
	int ret;
	ret = ((sm2_sign_ptr_t)SM2_sign_ADDR)(id, message_digest, k, signature);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_SM2_sign(key_id_x id, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature)
{
	SWINT_FUNC_CALL_INLINE_ASM_ADDR(SM2_sign_wrapper, 0x40022028, 1);
}
int Invoke_SM2_sign(key_id_x id, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature)
{
	int ret;
	ret = ASM_SM2_sign(id, message_digest, k, signature);
	return ret;
}
// --- SM2_verify (SM2_verify_ADDR) ---
typedef int (*sm2_verify_ptr_t)(const uint8_t *public_key, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len);
int SM2_verify_wrapper(const uint8_t *public_key, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len)
{
	int ret;
	ret = ((sm2_verify_ptr_t)SM2_verify_ADDR)(public_key, message_digest, signature, sig_len);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_SM2_verify(const uint8_t *public_key, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len)
{

	SWINT_FUNC_CALL_INLINE_ASM_ADDR(SM2_verify_wrapper, 0x40022028, 1);
}
int Invoke_SM2_verify(const uint8_t *public_key, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len)
{
	int ret;
	ret = ASM_SM2_verify(public_key, message_digest, signature, sig_len);
	return ret;
}

// --- SM3_cal (SM3_cal_ADDR) ---
typedef void (*SM3_cal_ptr_t)(const uint8_t *, uint32_t, uint8_t *);
void SM3_cal_wrapper(const uint8_t *data, uint32_t len, uint8_t *out_hash)
{
	((SM3_cal_ptr_t)SM3_cal_ADDR)(data, len,out_hash);
	cpu_intr_sec_clr();
}

NOINLINE void ASM_SM3_cal(const uint8_t *data, uint32_t len, uint8_t *out_hash)
{

	SWINT_FUNC_CALL_INLINE_ASM_ADDR(SM3_cal_wrapper, 0x40022028, 1);
}

void Invoke_SM3_cal(const uint8_t *data, uint32_t len, uint8_t *out_hash)
{
	ASM_SM3_cal(data, len, out_hash);
}

// ---SM4_enc_dec_process (SM4_enc_dec_process_ADDR) ---
// typedef struct {
// 	key_id_x id;
// 	sm4_mode_t mode;
// 	sm4_op_t op;
// 	uint8_t *iv;
// 	uint8_t *input;
// 	uint8_t *output;
// 	uint32_t length;
// } sm4_args_t;
typedef int (*sm4_process_ptr_t)(sm4_args_t *);
int SM4_enc_dec_process_wrapper(sm4_args_t *args)
{
	// int ret = ((sm4_process_ptr_t)0x1013f812)(args);
	typedef int (*rom_sm4_func_t)(uint32_t, uint32_t, uint32_t, uint8_t*, uint8_t*, uint8_t*, uint32_t);
	rom_sm4_func_t rom_func = (rom_sm4_func_t)SM4_enc_dec_process_ADDR;
	// 将结构体成员解包，显式通过寄存器传递
	int ret = rom_func(
		args->id,
		args->mode,
		args->op,
		args->iv,
		args->input,
		args->output,
		args->length
	);
	cpu_intr_sec_clr();
	return ret;
}
NOINLINE int ASM_SM4_enc_dec_process(sm4_args_t *arg)
{

	SWINT_FUNC_CALL_INLINE_ASM_ADDR(SM4_enc_dec_process_wrapper, 0x40022028, 1);
}
int Invoke_SM4_enc_dec_process(key_id_x id, sm4_mode_t mode, sm4_op_t op,
                                          uint8_t *iv, uint8_t *input, uint8_t *output, uint32_t length)
{
	static sm4_args_t args;

	args.id     = id;
	args.mode   = mode;
	args.op     = op;
	args.iv     = iv;
	args.input  = input;
	args.output = output;
	args.length = length;

	int ret = ASM_SM4_enc_dec_process(&args);

	return ret;
}



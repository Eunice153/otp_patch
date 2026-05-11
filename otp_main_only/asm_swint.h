#ifndef ASM_SWINT_H_
#define ASM_SWINT_H_
#include <stdbool.h>
#include <stdint.h>
#include "HAL_def.h"
#include <stddef.h>

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
#ifdef __cplusplus
extern "C" {
#endif

#define NOINLINE __attribute__((noinline))

#define Set_password_ADDR 0x1013f2cc //Set_password
#define Check_password_ADDR 0x1013f2d2 //Check_password
#define GenerateKey_ADDR 0x1013f2d8 //GenerateKey
#define StoreKey_ADDR 0x1013f302 //StoreKey
#define Load_sram_otp_ADDR 0x1013f3dc //Load_sram_otp
#define DestroyKey_ADDR 0x1013f4be //DestroyKey
#define GetPubKey_ADDR 0x1013f648 //GetPubKey
#define LoadPublicKey_ADDR 0x1013f702 //LoadPublicKey
#define ExportKey_ADDR 0x1013f730 //ExportKey
#define ImportKey_ADDR 0x1013f7ba //ImportKey
#define SM2_encrypt_ADDR 0x1013fb5e //SM2_encrypt
#define SM2_decrypt_ADDR 0x1013f846 //SM2_decrypt
#define SM2_sign_ADDR 0x1013f8ac //SM2_sign
#define SM2_verify_ADDR 0x1013f90a //SM2_verify
#define SM3_cal_ADDR 0x1013f294 //SM3_cal
#define SM4_enc_dec_process_ADDR 0x1013f940 //SM4_enc_dec_process

NOINLINE int ASM_Set_password(const char *input_password_str);
int Invoke_Set_password(const char *input_password_str);
NOINLINE int ASM_Check_password(const char *input_password_str);
int Invoke_Check_password(const char *input_password_str);
NOINLINE int ASM_GenerateKey(key_id_x id);
int Invoke_GenerateKey(key_id_x id);
NOINLINE int ASM_StoreKey(key_id_x id,const char *input_password_str);
int Invoke_StoreKey(key_id_x id,const char *input_password_str);
NOINLINE int ASM_Load_sram_otp(key_id_x id,const char *input_password_str);
int Invoke_Load_sram_otp(key_id_x id,const char *input_password_str);
NOINLINE int ASM_DestroyKey(key_id_x id,const char *input_password_str);
int Invoke_DestroyKey(key_id_x id,const char *input_password_str);
NOINLINE int ASM_GetPubKey(key_id_x id, uint8_t *pubkey);
int Invoke_GetPubKey(key_id_x id, uint8_t *pubkey);
NOINLINE int ASM_LoadPublicKey(uint8_t *pubkey);
int Invoke_LoadPublicKey(uint8_t *pubkey);
NOINLINE int ASM_ExportKey(key_id_x id, uint8_t *ciphertext,bool standard_mode);
int Invoke_ExportKey(key_id_x id, uint8_t *ciphertext,bool standard_mode);
NOINLINE int ASM_ImportKey(key_id_x target_id,key_id_x decryption_id, uint8_t *ciphertext, bool standard_mode);
int Invoke_ImportKey(key_id_x target_id,key_id_x decryption_id, uint8_t *ciphertext, bool standard_mode);
typedef struct {
	const uint8_t *public_key;
	const uint8_t *plaintext;
	size_t pt_len;
	uint8_t *ciphertext;
	size_t ct_len;
	uint8_t *random_num;
	bool standard_mode;
} sm2_enc_args_t;
NOINLINE int ASM_SM2_encrypt(sm2_enc_args_t *arg);
int Invoke_SM2_encrypt(const uint8_t *public_key,const uint8_t *plaintext, size_t pt_len,
		uint8_t *ciphertext,size_t ct_len,uint8_t *random_num,bool standard_mode);
typedef struct {
	key_id_x id;
	const uint8_t *ciphertext;
	size_t ct_len;
	uint8_t *plaintext;
	size_t pt_len;
	bool standard_mode;
} sm2_dec_args_t;
NOINLINE int ASM_SM2_decrypt_Process(sm2_dec_args_t *arg);
int Invoke_SM2_decrypt(key_id_x id, const uint8_t *ciphertext, size_t ct_len,
		uint8_t *plaintext, size_t pt_len, bool standard_mode);
NOINLINE int ASM_SM2_sign(key_id_x id, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature);
int Invoke_SM2_sign(key_id_x id, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature);
NOINLINE int ASM_SM2_verify(const uint8_t *public_key, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len);
int Invoke_SM2_verify(const uint8_t *public_key, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len);
// NOINLINE int ASM_SM2_verify(key_id_x id, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len);
// int Invoke_SM2_verify(key_id_x id, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len);
NOINLINE void ASM_SM3_cal(const uint8_t *data, uint32_t len, uint8_t *out_hash);
void Invoke_SM3_cal(const uint8_t *data, uint32_t len, uint8_t *out_hash);
typedef struct {
	key_id_x id;
	sm4_mode_t mode;
	sm4_op_t op;
	uint8_t *iv;
	uint8_t *input;
	uint8_t *output;
	uint32_t length;
} sm4_args_t;
NOINLINE int ASM_SM4_enc_dec_process(sm4_args_t *arg);
int Invoke_SM4_enc_dec_process(key_id_x id, sm4_mode_t mode, sm4_op_t op,
                                          uint8_t *iv, uint8_t *input, uint8_t *output, uint32_t length);

#ifdef __cplusplus
}
#endif

#endif
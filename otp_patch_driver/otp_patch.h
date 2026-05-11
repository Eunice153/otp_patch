#ifndef OTP_PATCH_H_
#define OTP_PATCH_H_
#include <stdbool.h>
#include <stdint.h>
#include "HAL_def.h"
#include <stddef.h>
// #include "swint_call_asm.h"
#ifdef __cplusplus
extern "C" {
#endif
/**
 * @brief 密钥ID枚举
 */
typedef enum {
    KEY_ID_0 = 0,
    KEY_ID_1,
    KEY_ID_2,
    KEY_ID_MAX
} key_id_t;

/**
 * @brief 安全模块密钥索引枚举
 * * 按照存储介质和用途划分为三类：
 * 1. OTP 固化密钥 (Index 0-2)
 * 2. 临时存储密钥 (Index 3-5)
 * 3. 外部公钥缓存 (Index 6)
 */
typedef enum {
    IDx_OTP_SM2_DEC  = 0,
    IDx_OTP_SM2_SIGN = 1,
    IDx_OTP_SM4      = 2,
    IDx_TMP_SM2_DEC  = 3,
    IDx_TMP_SM2_SIGN = 4,
    IDx_TMP_SM4      = 5,
    IDx_LOAD_PUBKEY  = 6,
    IDx_MAX
} key_id_x;

typedef enum {
    SM4_MODE_ECB = 0,
    SM4_MODE_CBC = 1
} sm4_mode_t;

typedef enum {
    SM4_OP_ENCRYPT = 0,
    SM4_OP_DECRYPT = 1
} sm4_op_t;

extern struct mpp_mpie{
    uint8_t mpp;
    uint8_t mpie;
}goto_next_mstatus;
// extern uint8_t *key_data_table[];
extern uint8_t * const key_data_table[];
// extern void copy_reverse(uint8_t *dest, const uint8_t *src, uint32_t len);
// extern void arr_reverse(uint8_t *arr, uint32_t len);
extern const uint8_t SM2_G[];

// typedef struct {
// //     uint64_t total_length;        // 记录已处理的总字节数，单位是比特
// // //     uint8_t buffer[SHA_BLOCK_SIZE]; // 用于存储数据的缓冲区，每次处理一个块（64 字节）
// // //     uint8_t buffer_index;         // 缓冲区中的当前字节位置
// //     bool first_update;            // 标志是否是第一次更新
// //     uint32_t current_word;        // 当前正在处理的 32 位字
// //     uint8_t current_block_bytes;  // 当前缓冲区填充的字节数
// } sm3_ctx_t;
/*第二版start*/
void otp_patch_init(void);
void SM3_cal(const uint8_t *data, uint32_t len, uint8_t *out_hash);
int trng_derive_key(uint8_t *derived_key, size_t key_len);
int GenerateKey(key_id_x id);
int Set_password(const char *input_password_str);
int Check_password(const char *input_password_str);//可以不用对外暴露
int StoreKey(key_id_x id, const char *input_password_str);
int Load_sram_otp(key_id_x id, const char *input_password_str);
int DestroyKey(key_id_x id, const char *input_password_str);
int GetPubKey(key_id_x id, uint8_t *pubkey);
int LoadPublicKey(uint8_t *pubkey);
// int ExportKey(key_id_x id, uint32_t input_password, uint8_t *ciphertext,bool standard_mode);
int ExportKey(key_id_x id, uint8_t *ciphertext,bool standard_mode);
int ImportKey(key_id_x target_id,key_id_x decryption_id, uint8_t *ciphertext, bool standard_mode);
int SM2_encrypt(const uint8_t *public_key,const uint8_t *plaintext, size_t pt_len,
		uint8_t *ciphertext,size_t ct_len,uint8_t *random_num,bool standard_mode);
int SM2_decrypt(key_id_x id, const uint8_t *ciphertext, size_t ct_len,
            uint8_t *plaintext, size_t pt_len, bool standard_mode);
int SM2_sign(key_id_x id, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature);
int SM2_verify(const uint8_t *public_key, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len);
void SM3_init();
void SM3_update(const uint8_t *data, size_t data_len);
void SM3_final(uint8_t *digest);
int SM4_enc_dec_process(key_id_x id, sm4_mode_t mode, sm4_op_t op,
                        uint8_t *iv, uint8_t *input, uint8_t *output, uint32_t length);

/*第二版end*/

// void set_password(uint32_t input_password);

// int StoreKey(key_id_x id);
// int StoreKey(key_id_x id, uint32_t input_password);

// int check_password_status(void);
// // int DestroyKey(key_id_x id);
// // int DestroyKey(key_id_x id, uint32_t input_password);
// int GetPubKey(key_id_x id, uint8_t *pubkey);
// int LoadPublicKey(uint8_t *pubkey);
// int ExportKey(key_id_x id, uint32_t input_password, uint8_t *ciphertext,bool standard_mode);
// int ImportKey(key_id_x target_id, uint32_t input_password, uint8_t *ciphertext, bool standard_mode);

// int sm2_encrypt(const uint8_t *public_key,const uint8_t *plaintext, size_t pt_len,uint8_t *ciphertext,size_t ct_len,uint8_t *random_num,bool standard_mode);
// //
// int SM2_DEC(key_id_x id, const uint8_t *ciphertext, size_t ct_len,uint8_t *plaintext, size_t pt_len, bool standard_mode);
// //
// int SM2_SIGN(key_id_x id, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature);
// int SM2_VERIFY(key_id_x id, const uint8_t *message_digest, const uint8_t *signature, size_t sig_len);
// int sm3_init(sm3_ctx_t *ctx);
// int sm3_update(sm3_ctx_t *ctx, const uint8_t *data, size_t data_len);
// int sm3_final(sm3_ctx_t *ctx, uint8_t *digest);
// int SM4_CBC_Encrypt_Process(key_id_x id, uint8_t *iv, uint8_t *plaintext, uint8_t *ciphertext, uint32_t length);
// int SM4_CBC_Decrypt_Process(key_id_x id, uint8_t *iv, uint8_t *ciphertext, uint8_t *plaintext, uint32_t length);
// int trng_derive_key(uint8_t *derived_key, size_t key_len);
// int SM4_ENC_DEC_Process(key_id_x id, sm4_mode_t mode, sm4_op_t op,uint8_t *iv, uint8_t *input, uint8_t *output, uint32_t length);
// //
// int memcopy_patch(key_id_x id, const uint8_t *src, uint32_t len);
// void* patch_get_key_ptr(key_id_x id);
// int export_key_to_user_wrapper(key_id_x id, uint8_t *user_buf, uint32_t len);
// int get_key_data_table_patch(key_id_x id, uint8_t *dest, uint32_t len);

// int sm4_encrypt_block(key_id_t key_id, const uint8_t *plaintext, uint8_t *ciphertext);

// int sm4_decrypt_block(key_id_t key_id,const uint8_t *ciphertext,uint8_t *plaintext);


// /**
//  * @brief 初始化 SM3 上下文
//  *
//  * @param ctx 指向 SM3 上下文的指针
//  */
// int sm3_init(sm3_ctx_t *ctx);

// /**
//  * @brief 更新 SM3 摘要计算
//  *
//  * @param ctx 指向 SM3 上下文的指针
//  * @param data 指向待计算数据的指针
//  * @param data_len 数据长度
//  */
// int sm3_update(sm3_ctx_t *ctx, const uint8_t *data, size_t data_len);

// /**
//  * @brief 完成 SM3 摘要计算，输出最终的摘要值
//  *
//  * @param ctx 指向 SM3 上下文的指针
//  * @param digest 输出摘要值（32 字节）
//  */
// int sm3_final(sm3_ctx_t *ctx, uint8_t *digest);
bool boot_sm2_encrypt(uint8_t *plaintext, uint8_t *ciphertext, uint32_t klen, uint8_t *random_num, uint8_t *public_key, bool standard_mode);
// int sm2_encrypt(const uint8_t *public_key,const uint8_t *plaintext, size_t pt_len,uint8_t *ciphertext,size_t ct_len,uint8_t *random_num,bool standard_mode);
// int sm2_decrypt(key_id_t key_id,const uint8_t *ciphertext,size_t ct_len,uint8_t *plaintext, size_t pt_len, bool standard_mode);
bool boot_sm2_sign(uint8_t *private_key, uint8_t *msg, uint8_t *random_num, uint8_t *sign);
// int sm2_sign(uint8_t *private_key, const uint8_t *message_digest, const uint8_t *k, uint8_t *signature);
// int sm2_verify_digest(const uint8_t *public_key,const uint8_t *message_digest,const uint8_t *signature,size_t sig_len);
// bool boot_ecc_verify(enum BOOT_ECC_CURVE_TYPE curve, uint8_t *pubkey_x, uint8_t *pubkey_y, uint8_t *msg, uint8_t *sign);
// int32_t Get_Derived_Key(uint8_t *derived_key, size_t key_len);
// int32_t Generate_Session_Key(const uint8_t *external_salt, size_t salt_len, uint8_t *session_key, size_t session_key_len);
#ifdef __cplusplus
}
#endif

#endif
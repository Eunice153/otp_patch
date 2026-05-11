__riscv_restore_2 = 0x0100ba36;
__riscv_save_2 = 0x0100ba12;
__riscv_save_3 = 0x0100ba12;
__riscv_restore_3 = 0x0100ba36;
__riscv_restore_0 = 0x0100ba36;
boot_ecc_verify = 0x0100ab56;
__riscv_save_0 = 0x0100ba12;
boot_sm2_decrypt = 0x100a04c;
__riscv_restore_1 = 0x0100ba36;
HAL_SM4_KeyExpansion = 0x010054ce;
__riscv_save_1 = 0x0100ba12;
HAL_SM4_Encrypt = 0x010054ec;

/* HAL_TRNG_DeInit = 0x01234567;
HAL_TRNG_GenerateRandomNumber = 0x01234567;
HAL_TRNG_Init = 0x01234567;
HAL_IWDG_DeInit = 0x01234567; */
boot_sm2_sign = 0x0100a140;
boot_sm2_encrypt = 0x01009e30;
HAL_SM4_Decrypt = 0x0100550e;
goto_next_mstatus = 0x10138fc8;

/*new add*/
__riscv_save_4 = 0x0100b9f8;
__riscv_restore_4 = 0x0100ba2c;

SWINT_Handler_ASM = 0x010000c8;
rv_set_int_isr = 0x1000952;
/*no use*/
HAL_LSSHA_Final = 0x010048b6;
HAL_LSSHA_Update = 0x01004862;
HAL_LSSHA_SM3_Init = 0x01004848;
HAL_LSSHA_Final = 0x010048b6;
HAL_LSSHA_Update = 0x1004862;
HAL_LSSHA_SM3_Init = 0x01004848;
/*new func*/
HAL_OTP_Read = 0x010080be;
HAL_OTP_CTRL_Init = 0x01008070;
HAL_OTBN_SM3_Init = 0x01003796;
HAL_OTBN_SM3_Update = 0x010037ea;
HAL_OTBN_SM3_Final = 0x0100388e;
__riscv_save_5 = 0x0100b9f8;
__riscv_restore_5 = 0x0100ba2c;
SM2_G = 0x0100b888;
HAL_OTBN_ECC256_ScalarMult_Polling = 0x01004cc8;
__riscv_save_6 = 0x0100b9f8;
__riscv_restore_6 = 0x0100ba2c;
HAL_OTBN_Init = 0x01007e84;
memset = 0x0100bb2c;
memcpy = 0x100bb14;
__riscv_save_9 = 0x0100b9ea;
__riscv_restore_9 = 0x0100ba22;
HAL_OTP_Write = 0x1008230;
memcmp = 0x100baee;
__riscv_save_10 = 0x100b9ea;
__riscv_restore_10 = 0x100ba22;

/*hidden*/
__riscv_save_7 = 0x0100b9f8;
__riscv_restore_7 = 0x0100ba2c;
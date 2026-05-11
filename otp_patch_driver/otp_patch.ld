ENTRY(otp_patch_init)
SECTIONS
{
	.text 0x1013f14e :
	{
		KEEP(*(.text.otp_patch_init))
		/*KEEP(*(.text.sm4_encrypt_block))
		KEEP(*(.text.sm4_decrypt_block))
		KEEP(*(.text.sm3_init))
		KEEP(*(.text.sm3_update))
		KEEP(*(.text.sm3_final))
		KEEP(*(.text.sm2_encrypt))
		KEEP(*(.text.sm2_decrypt))
		KEEP(*(.text.sm2_sign))
		KEEP(*(.text.sm2_verify_digest))
		KEEP(*(.text.Get_Derived_Key))
		KEEP(*(.text.Generate_Session_Key))*/
		KEEP(*(.text.SM3_cal))
		KEEP(*(.text.Set_password))
		KEEP(*(.text.Check_password))
		KEEP(*(.text.GenerateKey))
		KEEP(*(.text.StoreKey))
		KEEP(*(.text.Load_sram_otp))
		KEEP(*(.text.DestroyKey))
		KEEP(*(.text.trng_derive_key))
		KEEP(*(.text.GetPubKey))
		KEEP(*(.text.LoadPublicKey))
		KEEP(*(.text.ExportKey))
		KEEP(*(.text.ImportKey))
		KEEP(*(.text.sm2_encrypt))
		KEEP(*(.text.SM2_decrypt))
		KEEP(*(.text.SM2_sign))
		KEEP(*(.text.SM2_verify))
		KEEP(*(.text.sm3_init))
		KEEP(*(.text.sm3_update))
		KEEP(*(.text.sm3_final))
		KEEP(*(.text.SM4_enc_dec_process))
		*(.text* .rodata*)
	}
	.bss : ALIGN(4)/* 确保整个段从 4 字节对齐的地址开始 */
	{
		. = ALIGN(4);
		_bss_start = .;
		*(.bss*)         /* 核心：这一行会将所有 .bss.xxx 整合进一个大的 .bss 段 */
		*(COMMON)        /* 收集未初始化的全局变量 */
		. = ALIGN(4);   /* 确保结束地址也是对齐的，方便 memset 按字清零 */
		_bss_end = .;
	}
}
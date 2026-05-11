
otp_patch.elf:     file format elf32-littleriscv
otp_patch.elf
architecture: riscv:rv32, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x1013f14e

Program Header:
0x70000003 off    0x0000931d vaddr 0x00000000 paddr 0x00000000 align 2**0
         filesz 0x000000e4 memsz 0x00000000 flags r--
    LOAD off    0x00000000 vaddr 0x1013f000 paddr 0x1013f000 align 2**12
         filesz 0x00000e30 memsz 0x00000f10 flags rwx
   STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**4
         filesz 0x00000000 memsz 0x00000000 flags rw-

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00000ce2  1013f14e  1013f14e  0000014e  2**1
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .bss          000000e0  1013fe30  1013fe30  00000e30  2**2
                  ALLOC
  2 .debug_info   00002c04  00000000  00000000  00000e30  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  3 .debug_abbrev 000005b5  00000000  00000000  00003a34  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  4 .debug_loclists 00001019  00000000  00000000  00003fe9  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  5 .debug_aranges 00000108  00000000  00000000  00005002  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  6 .debug_rnglists 00000165  00000000  00000000  0000510a  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  7 .debug_line   00002078  00000000  00000000  0000526f  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  8 .debug_str    00001bec  00000000  00000000  000072e7  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  9 .debug_line_str 000003fc  00000000  00000000  00008ed3  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
 10 .comment      0000004e  00000000  00000000  000092cf  2**0
                  CONTENTS, READONLY
 11 .riscv.attributes 000000e4  00000000  00000000  0000931d  2**0
                  CONTENTS, READONLY
 12 .debug_frame  00000400  00000000  00000000  00009404  2**2
                  CONTENTS, READONLY, DEBUGGING, OCTETS
SYMBOL TABLE:
1013f14e l    d  .text	00000000 .text
1013fe30 l    d  .bss	00000000 .bss
00000000 l    d  .debug_info	00000000 .debug_info
00000000 l    d  .debug_abbrev	00000000 .debug_abbrev
00000000 l    d  .debug_loclists	00000000 .debug_loclists
00000000 l    d  .debug_aranges	00000000 .debug_aranges
00000000 l    d  .debug_rnglists	00000000 .debug_rnglists
00000000 l    d  .debug_line	00000000 .debug_line
00000000 l    d  .debug_str	00000000 .debug_str
00000000 l    d  .debug_line_str	00000000 .debug_line_str
00000000 l    d  .comment	00000000 .comment
00000000 l    d  .riscv.attributes	00000000 .riscv.attributes
00000000 l    d  .debug_frame	00000000 .debug_frame
00000000 l    df *ABS*	00000000 otp_patch.c
1013f9e0 l     F .text	0000001c send_cmd
1013f9fc l     F .text	00000022 is_key_empty
1013fa1e l     F .text	00000020 arr_reverse.constprop.0
1013fa64 l     F .text	000000fa Password_op
1013fe0e l     O .text	00000003 CSWTCH.58
1013fe0e l     O .text	00000003 CSWTCH.60
1013fe30 l     O .bss	00000040 LOAD_PUBKEY_DATA
1013fef0 l     O .bss	00000020 OTP_SM2_DEC_KEY_DATA
1013fed0 l     O .bss	00000020 OTP_SM2_SIGN_KEY_DATA
1013fec0 l     O .bss	00000010 OTP_SM4_KEY_DATA
1013fea0 l     O .bss	00000020 TMP_SM2_DEC_KEY_DATA
1013fe80 l     O .bss	00000020 TMP_SM2_SIGN_KEY_DATA
1013fe70 l     O .bss	00000010 TMP_SM4_KEY_DATA
1013f648 g     F .text	000000ba GetPubKey
1013f14e g     F .text	00000146 otp_patch_init
0100ba36 g       *ABS*	00000000 __riscv_restore_3
01007e84 g       *ABS*	00000000 HAL_OTBN_Init
0100ba22 g       *ABS*	00000000 __riscv_restore_10
1013fb96 g     F .text	00000008 SM3_init
01000952 g       *ABS*	00000000 rv_set_int_isr
0100ba36 g       *ABS*	00000000 __riscv_restore_2
0100bb14 g       *ABS*	00000000 memcpy
1013fe30 g       .bss	00000000 _bss_start
01004848 g       *ABS*	00000000 HAL_LSSHA_SM3_Init
0100ba12 g       *ABS*	00000000 __riscv_save_1
0100550e g       *ABS*	00000000 HAL_SM4_Decrypt
0100ba36 g       *ABS*	00000000 __riscv_restore_0
0100b9f8 g       *ABS*	00000000 __riscv_save_7
0100a140 g       *ABS*	00000000 boot_sm2_sign
1013f294 g     F .text	00000038 SM3_cal
0100ba2c g       *ABS*	00000000 __riscv_restore_5
010048b6 g       *ABS*	00000000 HAL_LSSHA_Final
010000c8 g       *ABS*	00000000 SWINT_Handler_ASM
1013f7ba g     F .text	0000008c ImportKey
0100ba2c g       *ABS*	00000000 __riscv_restore_6
1013fd40 g     F .text	000000ce Security_TRNG_SelfTest
1013ff10 g       .bss	00000000 _bss_end
0100b888 g       *ABS*	00000000 SM2_G
1013f2d8 g     F .text	0000002a GenerateKey
10138fc8 g       *ABS*	00000000 goto_next_mstatus
1013f2cc g     F .text	00000006 Set_password
01008070 g       *ABS*	00000000 HAL_OTP_CTRL_Init
0100b9ea g       *ABS*	00000000 __riscv_save_9
0100b9f8 g       *ABS*	00000000 __riscv_save_4
1013f8ac g     F .text	0000005e SM2_sign
01004862 g       *ABS*	00000000 HAL_LSSHA_Update
0100ba12 g       *ABS*	00000000 __riscv_save_3
1013f3dc g     F .text	000000e2 Load_sram_otp
01008230 g       *ABS*	00000000 HAL_OTP_Write
1013f2d2 g     F .text	00000006 Check_password
1013f5a2 g     F .text	000000a6 trng_derive_key
1013f846 g     F .text	00000066 SM2_decrypt
1013fbae g     F .text	000000c8 SM4_CBC_encrypt_process
010037ea g       *ABS*	00000000 HAL_OTBN_SM3_Update
1013fc76 g     F .text	000000ca SM4_CBC_decrypt_process
0100a04c g       *ABS*	00000000 boot_sm2_decrypt
0100baee g       *ABS*	00000000 memcmp
01009e30 g       *ABS*	00000000 boot_sm2_encrypt
0100b9ea g       *ABS*	00000000 __riscv_save_10
01003796 g       *ABS*	00000000 HAL_OTBN_SM3_Init
0100ba2c g       *ABS*	00000000 __riscv_restore_4
0100b9f8 g       *ABS*	00000000 __riscv_save_6
0100bb2c g       *ABS*	00000000 memset
0100ba22 g       *ABS*	00000000 __riscv_restore_9
0100ba2c g       *ABS*	00000000 __riscv_restore_7
1013f702 g     F .text	0000002e LoadPublicKey
01004cc8 g       *ABS*	00000000 HAL_OTBN_ECC256_ScalarMult_Polling
010054ec g       *ABS*	00000000 HAL_SM4_Encrypt
1013fe14 g     O .text	0000001c key_data_table
1013fa3e g     F .text	00000016 HAL_TRNG_MSP_Init
0100ba12 g       *ABS*	00000000 __riscv_save_2
1013f730 g     F .text	0000008a ExportKey
0100b9f8 g       *ABS*	00000000 __riscv_save_5
010080be g       *ABS*	00000000 HAL_OTP_Read
0100ab56 g       *ABS*	00000000 boot_ecc_verify
1013fb5e g     F .text	00000038 SM2_encrypt
1013fba6 g     F .text	00000008 SM3_final
1013fb9e g     F .text	00000008 SM3_update
0100ba12 g       *ABS*	00000000 __riscv_save_0
1013f4be g     F .text	000000e4 DestroyKey
1013fa54 g     F .text	00000010 strlen
1013f90a g     F .text	00000036 SM2_verify
1013f940 g     F .text	000000a0 SM4_enc_dec_process
0100ba36 g       *ABS*	00000000 __riscv_restore_1
1013f302 g     F .text	000000da StoreKey
010054ce g       *ABS*	00000000 HAL_SM4_KeyExpansion
0100388e g       *ABS*	00000000 HAL_OTBN_SM3_Final



Disassembly of section .text:

1013f14e <otp_patch_init>:
1013f14e:	f0ecd317          	auipc	t1,0xf0ecd
1013f152:	8c4302e7          	jalr	t0,-1852(t1) # 100ba12 <__riscv_save_0>
1013f156:	10140537          	lui	a0,0x10140
1013f15a:	02000613          	li	a2,32
1013f15e:	4581                	li	a1,0
1013f160:	ef050513          	addi	a0,a0,-272 # 1013fef0 <OTP_SM2_DEC_KEY_DATA>
1013f164:	f0ecd097          	auipc	ra,0xf0ecd
1013f168:	9c8080e7          	jalr	-1592(ra) # 100bb2c <memset>
1013f16c:	10140537          	lui	a0,0x10140
1013f170:	02000613          	li	a2,32
1013f174:	4581                	li	a1,0
1013f176:	ed050513          	addi	a0,a0,-304 # 1013fed0 <OTP_SM2_SIGN_KEY_DATA>
1013f17a:	f0ecd097          	auipc	ra,0xf0ecd
1013f17e:	9b2080e7          	jalr	-1614(ra) # 100bb2c <memset>
1013f182:	10140537          	lui	a0,0x10140
1013f186:	4641                	li	a2,16
1013f188:	4581                	li	a1,0
1013f18a:	ec050513          	addi	a0,a0,-320 # 1013fec0 <OTP_SM4_KEY_DATA>
1013f18e:	f0ecd097          	auipc	ra,0xf0ecd
1013f192:	99e080e7          	jalr	-1634(ra) # 100bb2c <memset>
1013f196:	10140537          	lui	a0,0x10140
1013f19a:	02000613          	li	a2,32
1013f19e:	4581                	li	a1,0
1013f1a0:	ea050513          	addi	a0,a0,-352 # 1013fea0 <TMP_SM2_DEC_KEY_DATA>
1013f1a4:	f0ecd097          	auipc	ra,0xf0ecd
1013f1a8:	988080e7          	jalr	-1656(ra) # 100bb2c <memset>
1013f1ac:	10140537          	lui	a0,0x10140
1013f1b0:	02000613          	li	a2,32
1013f1b4:	4581                	li	a1,0
1013f1b6:	e8050513          	addi	a0,a0,-384 # 1013fe80 <TMP_SM2_SIGN_KEY_DATA>
1013f1ba:	f0ecd097          	auipc	ra,0xf0ecd
1013f1be:	972080e7          	jalr	-1678(ra) # 100bb2c <memset>
1013f1c2:	10140537          	lui	a0,0x10140
1013f1c6:	4641                	li	a2,16
1013f1c8:	4581                	li	a1,0
1013f1ca:	e7050513          	addi	a0,a0,-400 # 1013fe70 <TMP_SM4_KEY_DATA>
1013f1ce:	f0ecd097          	auipc	ra,0xf0ecd
1013f1d2:	95e080e7          	jalr	-1698(ra) # 100bb2c <memset>
1013f1d6:	10140537          	lui	a0,0x10140
1013f1da:	04000613          	li	a2,64
1013f1de:	4581                	li	a1,0
1013f1e0:	e3050513          	addi	a0,a0,-464 # 1013fe30 <LOAD_PUBKEY_DATA>
1013f1e4:	f0ecd097          	auipc	ra,0xf0ecd
1013f1e8:	948080e7          	jalr	-1720(ra) # 100bb2c <memset>
1013f1ec:	040207b7          	lui	a5,0x4020
1013f1f0:	17fd                	addi	a5,a5,-1 # 401ffff <memset+0x30144d3>
1013f1f2:	3b079073          	csrw	pmpaddr0,a5
1013f1f6:	120007b7          	lui	a5,0x12000
1013f1fa:	17fd                	addi	a5,a5,-1 # 11ffffff <_bss_end+0x1ec00ef>
1013f1fc:	3b179073          	csrw	pmpaddr1,a5
1013f200:	384007b7          	lui	a5,0x38400
1013f204:	17fd                	addi	a5,a5,-1 # 383fffff <_bss_end+0x282c00ef>
1013f206:	3b279073          	csrw	pmpaddr2,a5
1013f20a:	3a0027f3          	csrr	a5,pmpcfg0
1013f20e:	f007f793          	andi	a5,a5,-256
1013f212:	01f7e793          	ori	a5,a5,31
1013f216:	3a079073          	csrw	pmpcfg0,a5
1013f21a:	3a0027f3          	csrr	a5,pmpcfg0
1013f21e:	7741                	lui	a4,0xffff0
1013f220:	0ff70713          	addi	a4,a4,255 # ffff00ff <_bss_end+0xefeb01ef>
1013f224:	8ff9                	and	a5,a5,a4
1013f226:	6709                	lui	a4,0x2
1013f228:	b0070713          	addi	a4,a4,-1280 # 1b00 <SWINT_Handler_ASM-0xffe5c8>
1013f22c:	8fd9                	or	a5,a5,a4
1013f22e:	3a079073          	csrw	pmpcfg0,a5
1013f232:	3a0027f3          	csrr	a5,pmpcfg0
1013f236:	ff010737          	lui	a4,0xff010
1013f23a:	177d                	addi	a4,a4,-1 # ff00ffff <_bss_end+0xeeed00ef>
1013f23c:	8ff9                	and	a5,a5,a4
1013f23e:	001b0737          	lui	a4,0x1b0
1013f242:	8fd9                	or	a5,a5,a4
1013f244:	3a079073          	csrw	pmpcfg0,a5
1013f248:	010005b7          	lui	a1,0x1000
1013f24c:	0c858593          	addi	a1,a1,200 # 10000c8 <SWINT_Handler_ASM>
1013f250:	4569                	li	a0,26
1013f252:	f0ec1097          	auipc	ra,0xf0ec1
1013f256:	700080e7          	jalr	1792(ra) # 1000952 <rv_set_int_isr>
1013f25a:	e08017b7          	lui	a5,0xe0801
1013f25e:	4705                	li	a4,1
1013f260:	06e784a3          	sb	a4,105(a5) # e0801069 <_bss_end+0xd06c1159>
1013f264:	4689                	li	a3,2
1013f266:	06d78523          	sb	a3,106(a5)
1013f26a:	02f00693          	li	a3,47
1013f26e:	0cd78fa3          	sb	a3,223(a5)
1013f272:	400227b7          	lui	a5,0x40022
1013f276:	d7d8                	sw	a4,44(a5)
1013f278:	30046073          	csrsi	mstatus,8
1013f27c:	2c5000ef          	jal	1013fd40 <Security_TRNG_SelfTest>
1013f280:	c111                	beqz	a0,1013f284 <otp_patch_init+0x136>
1013f282:	a001                	j	1013f282 <otp_patch_init+0x134>
1013f284:	101397b7          	lui	a5,0x10139
1013f288:	fc078423          	sb	zero,-56(a5) # 10138fc8 <goto_next_mstatus>
1013f28c:	f0ecc317          	auipc	t1,0xf0ecc
1013f290:	7aa30067          	jr	1962(t1) # 100ba36 <__riscv_restore_0>

1013f294 <SM3_cal>:
1013f294:	f0ecc317          	auipc	t1,0xf0ecc
1013f298:	77e302e7          	jalr	t0,1918(t1) # 100ba12 <__riscv_save_0>
1013f29c:	1141                	addi	sp,sp,-16
1013f29e:	8432                	mv	s0,a2
1013f2a0:	c62a                	sw	a0,12(sp)
1013f2a2:	c42e                	sw	a1,8(sp)
1013f2a4:	f0ec4097          	auipc	ra,0xf0ec4
1013f2a8:	4f2080e7          	jalr	1266(ra) # 1003796 <HAL_OTBN_SM3_Init>
1013f2ac:	45a2                	lw	a1,8(sp)
1013f2ae:	4532                	lw	a0,12(sp)
1013f2b0:	f0ec4097          	auipc	ra,0xf0ec4
1013f2b4:	53a080e7          	jalr	1338(ra) # 10037ea <HAL_OTBN_SM3_Update>
1013f2b8:	8522                	mv	a0,s0
1013f2ba:	f0ec4097          	auipc	ra,0xf0ec4
1013f2be:	5d4080e7          	jalr	1492(ra) # 100388e <HAL_OTBN_SM3_Final>
1013f2c2:	0141                	addi	sp,sp,16
1013f2c4:	f0ecc317          	auipc	t1,0xf0ecc
1013f2c8:	77230067          	jr	1906(t1) # 100ba36 <__riscv_restore_0>

1013f2cc <Set_password>:
1013f2cc:	4581                	li	a1,0
1013f2ce:	7960006f          	j	1013fa64 <Password_op>

1013f2d2 <Check_password>:
1013f2d2:	4585                	li	a1,1
1013f2d4:	7900006f          	j	1013fa64 <Password_op>

1013f2d8 <GenerateKey>:
1013f2d8:	87aa                	mv	a5,a0
1013f2da:	ffd50713          	addi	a4,a0,-3
1013f2de:	4509                	li	a0,2
1013f2e0:	02e56063          	bltu	a0,a4,1013f300 <GenerateKey+0x28>
1013f2e4:	10140737          	lui	a4,0x10140
1013f2e8:	e1470713          	addi	a4,a4,-492 # 1013fe14 <key_data_table>
1013f2ec:	44f7450b          	th.lrw	a0,a4,a5,2
1013f2f0:	ffb78693          	addi	a3,a5,-5
1013f2f4:	02000613          	li	a2,32
1013f2f8:	45c1                	li	a1,16
1013f2fa:	42d6158b          	th.mvnez	a1,a2,a3
1013f2fe:	a455                	j	1013f5a2 <trng_derive_key>
1013f300:	8082                	ret

1013f302 <StoreKey>:
1013f302:	f0ecc317          	auipc	t1,0xf0ecc
1013f306:	6f6302e7          	jalr	t0,1782(t1) # 100b9f8 <__riscv_save_4>
1013f30a:	7179                	addi	sp,sp,-48
1013f30c:	892a                	mv	s2,a0
1013f30e:	852e                	mv	a0,a1
1013f310:	37c9                	jal	1013f2d2 <Check_password>
1013f312:	e179                	bnez	a0,1013f3d8 <StoreKey+0xd6>
1013f314:	02000613          	li	a2,32
1013f318:	4581                	li	a1,0
1013f31a:	0808                	addi	a0,sp,16
1013f31c:	f0ecd097          	auipc	ra,0xf0ecd
1013f320:	810080e7          	jalr	-2032(ra) # 100bb2c <memset>
1013f324:	57fd                	li	a5,-1
1013f326:	00f10723          	sb	a5,14(sp)
1013f32a:	ffd90713          	addi	a4,s2,-3
1013f32e:	4789                	li	a5,2
1013f330:	5579                	li	a0,-2
1013f332:	02e7ec63          	bltu	a5,a4,1013f36a <StoreKey+0x68>
1013f336:	02500413          	li	s0,37
1013f33a:	02890433          	mul	s0,s2,s0
1013f33e:	101407b7          	lui	a5,0x10140
1013f342:	e0e78793          	addi	a5,a5,-498 # 1013fe0e <CSWTCH.58>
1013f346:	80e7c48b          	th.lrbu	s1,a5,a4,0
1013f34a:	4605                	li	a2,1
1013f34c:	00e10593          	addi	a1,sp,14
1013f350:	1b240413          	addi	s0,s0,434
1013f354:	00940a33          	add	s4,s0,s1
1013f358:	004a0993          	addi	s3,s4,4
1013f35c:	854e                	mv	a0,s3
1013f35e:	f0ec9097          	auipc	ra,0xf0ec9
1013f362:	d60080e7          	jalr	-672(ra) # 10080be <HAL_OTP_Read>
1013f366:	c519                	beqz	a0,1013f374 <StoreKey+0x72>
1013f368:	557d                	li	a0,-1
1013f36a:	6145                	addi	sp,sp,48
1013f36c:	f0ecc317          	auipc	t1,0xf0ecc
1013f370:	6c030067          	jr	1728(t1) # 100ba2c <__riscv_restore_4>
1013f374:	00e14783          	lbu	a5,14(sp)
1013f378:	5565                	li	a0,-7
1013f37a:	dbe5                	beqz	a5,1013f36a <StoreKey+0x68>
1013f37c:	0ff00713          	li	a4,255
1013f380:	5569                	li	a0,-6
1013f382:	fee794e3          	bne	a5,a4,1013f36a <StoreKey+0x68>
1013f386:	101407b7          	lui	a5,0x10140
1013f38a:	e1478793          	addi	a5,a5,-492 # 1013fe14 <key_data_table>
1013f38e:	4527c90b          	th.lrw	s2,a5,s2,2
1013f392:	0810                	addi	a2,sp,16
1013f394:	85a6                	mv	a1,s1
1013f396:	854a                	mv	a0,s2
1013f398:	3df5                	jal	1013f294 <SM3_cal>
1013f39a:	8626                	mv	a2,s1
1013f39c:	85ca                	mv	a1,s2
1013f39e:	8522                	mv	a0,s0
1013f3a0:	f0ec9097          	auipc	ra,0xf0ec9
1013f3a4:	e90080e7          	jalr	-368(ra) # 1008230 <HAL_OTP_Write>
1013f3a8:	f161                	bnez	a0,1013f368 <StoreKey+0x66>
1013f3aa:	4611                	li	a2,4
1013f3ac:	080c                	addi	a1,sp,16
1013f3ae:	8552                	mv	a0,s4
1013f3b0:	f0ec9097          	auipc	ra,0xf0ec9
1013f3b4:	e80080e7          	jalr	-384(ra) # 1008230 <HAL_OTP_Write>
1013f3b8:	f945                	bnez	a0,1013f368 <StoreKey+0x66>
1013f3ba:	4605                	li	a2,1
1013f3bc:	00f10593          	addi	a1,sp,15
1013f3c0:	854e                	mv	a0,s3
1013f3c2:	000107a3          	sb	zero,15(sp)
1013f3c6:	f0ec9097          	auipc	ra,0xf0ec9
1013f3ca:	e6a080e7          	jalr	-406(ra) # 1008230 <HAL_OTP_Write>
1013f3ce:	00a03533          	snez	a0,a0
1013f3d2:	40a00533          	neg	a0,a0
1013f3d6:	bf51                	j	1013f36a <StoreKey+0x68>
1013f3d8:	5575                	li	a0,-3
1013f3da:	bf41                	j	1013f36a <StoreKey+0x68>

1013f3dc <Load_sram_otp>:
1013f3dc:	f0ecc317          	auipc	t1,0xf0ecc
1013f3e0:	61c302e7          	jalr	t0,1564(t1) # 100b9f8 <__riscv_save_4>
1013f3e4:	7179                	addi	sp,sp,-48
1013f3e6:	892a                	mv	s2,a0
1013f3e8:	852e                	mv	a0,a1
1013f3ea:	35e5                	jal	1013f2d2 <Check_password>
1013f3ec:	e579                	bnez	a0,1013f4ba <Load_sram_otp+0xde>
1013f3ee:	02000613          	li	a2,32
1013f3f2:	4581                	li	a1,0
1013f3f4:	0808                	addi	a0,sp,16
1013f3f6:	f0ecc097          	auipc	ra,0xf0ecc
1013f3fa:	736080e7          	jalr	1846(ra) # 100bb2c <memset>
1013f3fe:	57fd                	li	a5,-1
1013f400:	00f105a3          	sb	a5,11(sp)
1013f404:	4789                	li	a5,2
1013f406:	5579                	li	a0,-2
1013f408:	0327eb63          	bltu	a5,s2,1013f43e <Load_sram_otp+0x62>
1013f40c:	02500413          	li	s0,37
1013f410:	02890433          	mul	s0,s2,s0
1013f414:	101407b7          	lui	a5,0x10140
1013f418:	e0e78793          	addi	a5,a5,-498 # 1013fe0e <CSWTCH.58>
1013f41c:	8127c48b          	th.lrbu	s1,a5,s2,0
1013f420:	4605                	li	a2,1
1013f422:	00b10593          	addi	a1,sp,11
1013f426:	22140413          	addi	s0,s0,545
1013f42a:	008489b3          	add	s3,s1,s0
1013f42e:	00498513          	addi	a0,s3,4
1013f432:	f0ec9097          	auipc	ra,0xf0ec9
1013f436:	c8c080e7          	jalr	-884(ra) # 10080be <HAL_OTP_Read>
1013f43a:	c519                	beqz	a0,1013f448 <Load_sram_otp+0x6c>
1013f43c:	557d                	li	a0,-1
1013f43e:	6145                	addi	sp,sp,48
1013f440:	f0ecc317          	auipc	t1,0xf0ecc
1013f444:	5ec30067          	jr	1516(t1) # 100ba2c <__riscv_restore_4>
1013f448:	00b14783          	lbu	a5,11(sp)
1013f44c:	0ff00713          	li	a4,255
1013f450:	5561                	li	a0,-8
1013f452:	fee786e3          	beq	a5,a4,1013f43e <Load_sram_otp+0x62>
1013f456:	17fd                	addi	a5,a5,-1
1013f458:	0ff7f793          	zext.b	a5,a5
1013f45c:	0fd00713          	li	a4,253
1013f460:	04f77b63          	bgeu	a4,a5,1013f4b6 <Load_sram_otp+0xda>
1013f464:	4611                	li	a2,4
1013f466:	006c                	addi	a1,sp,12
1013f468:	854e                	mv	a0,s3
1013f46a:	f0ec9097          	auipc	ra,0xf0ec9
1013f46e:	c54080e7          	jalr	-940(ra) # 10080be <HAL_OTP_Read>
1013f472:	f569                	bnez	a0,1013f43c <Load_sram_otp+0x60>
1013f474:	101407b7          	lui	a5,0x10140
1013f478:	e1478793          	addi	a5,a5,-492 # 1013fe14 <key_data_table>
1013f47c:	4527c90b          	th.lrw	s2,a5,s2,2
1013f480:	8626                	mv	a2,s1
1013f482:	8522                	mv	a0,s0
1013f484:	85ca                	mv	a1,s2
1013f486:	f0ec9097          	auipc	ra,0xf0ec9
1013f48a:	c38080e7          	jalr	-968(ra) # 10080be <HAL_OTP_Read>
1013f48e:	f55d                	bnez	a0,1013f43c <Load_sram_otp+0x60>
1013f490:	0810                	addi	a2,sp,16
1013f492:	85a6                	mv	a1,s1
1013f494:	854a                	mv	a0,s2
1013f496:	3bfd                	jal	1013f294 <SM3_cal>
1013f498:	4611                	li	a2,4
1013f49a:	006c                	addi	a1,sp,12
1013f49c:	0808                	addi	a0,sp,16
1013f49e:	f0ecc097          	auipc	ra,0xf0ecc
1013f4a2:	650080e7          	jalr	1616(ra) # 100baee <memcmp>
1013f4a6:	dd41                	beqz	a0,1013f43e <Load_sram_otp+0x62>
1013f4a8:	8626                	mv	a2,s1
1013f4aa:	4581                	li	a1,0
1013f4ac:	854a                	mv	a0,s2
1013f4ae:	f0ecc097          	auipc	ra,0xf0ecc
1013f4b2:	67e080e7          	jalr	1662(ra) # 100bb2c <memset>
1013f4b6:	5569                	li	a0,-6
1013f4b8:	b759                	j	1013f43e <Load_sram_otp+0x62>
1013f4ba:	5575                	li	a0,-3
1013f4bc:	b749                	j	1013f43e <Load_sram_otp+0x62>

1013f4be <DestroyKey>:
1013f4be:	f0ecc317          	auipc	t1,0xf0ecc
1013f4c2:	53a302e7          	jalr	t0,1338(t1) # 100b9f8 <__riscv_save_4>
1013f4c6:	7179                	addi	sp,sp,-48
1013f4c8:	89aa                	mv	s3,a0
1013f4ca:	842e                	mv	s0,a1
1013f4cc:	02000613          	li	a2,32
1013f4d0:	4581                	li	a1,0
1013f4d2:	0808                	addi	a0,sp,16
1013f4d4:	f0ecc097          	auipc	ra,0xf0ecc
1013f4d8:	658080e7          	jalr	1624(ra) # 100bb2c <memset>
1013f4dc:	57fd                	li	a5,-1
1013f4de:	00f107a3          	sb	a5,15(sp)
1013f4e2:	4795                	li	a5,5
1013f4e4:	0b37ed63          	bltu	a5,s3,1013f59e <DestroyKey+0xe0>
1013f4e8:	4789                	li	a5,2
1013f4ea:	0937eb63          	bltu	a5,s3,1013f580 <DestroyKey+0xc2>
1013f4ee:	8522                	mv	a0,s0
1013f4f0:	33cd                	jal	1013f2d2 <Check_password>
1013f4f2:	57f5                	li	a5,-3
1013f4f4:	e51d                	bnez	a0,1013f522 <DestroyKey+0x64>
1013f4f6:	02098c63          	beqz	s3,1013f52e <DestroyKey+0x70>
1013f4fa:	4785                	li	a5,1
1013f4fc:	02f99e63          	bne	s3,a5,1013f538 <DestroyKey+0x7a>
1013f500:	02000413          	li	s0,32
1013f504:	24600493          	li	s1,582
1013f508:	00848933          	add	s2,s1,s0
1013f50c:	4605                	li	a2,1
1013f50e:	00f10593          	addi	a1,sp,15
1013f512:	00490513          	addi	a0,s2,4
1013f516:	f0ec9097          	auipc	ra,0xf0ec9
1013f51a:	ba8080e7          	jalr	-1112(ra) # 10080be <HAL_OTP_Read>
1013f51e:	c10d                	beqz	a0,1013f540 <DestroyKey+0x82>
1013f520:	57fd                	li	a5,-1
1013f522:	853e                	mv	a0,a5
1013f524:	6145                	addi	sp,sp,48
1013f526:	f0ecc317          	auipc	t1,0xf0ecc
1013f52a:	50630067          	jr	1286(t1) # 100ba2c <__riscv_restore_4>
1013f52e:	02000413          	li	s0,32
1013f532:	22100493          	li	s1,545
1013f536:	bfc9                	j	1013f508 <DestroyKey+0x4a>
1013f538:	4441                	li	s0,16
1013f53a:	26b00493          	li	s1,619
1013f53e:	b7e9                	j	1013f508 <DestroyKey+0x4a>
1013f540:	00f14683          	lbu	a3,15(sp)
1013f544:	0ff00713          	li	a4,255
1013f548:	57e1                	li	a5,-8
1013f54a:	fce68ce3          	beq	a3,a4,1013f522 <DestroyKey+0x64>
1013f54e:	8622                	mv	a2,s0
1013f550:	080c                	addi	a1,sp,16
1013f552:	8526                	mv	a0,s1
1013f554:	f0ec9097          	auipc	ra,0xf0ec9
1013f558:	cdc080e7          	jalr	-804(ra) # 1008230 <HAL_OTP_Write>
1013f55c:	f171                	bnez	a0,1013f520 <DestroyKey+0x62>
1013f55e:	4611                	li	a2,4
1013f560:	080c                	addi	a1,sp,16
1013f562:	854a                	mv	a0,s2
1013f564:	f0ec9097          	auipc	ra,0xf0ec9
1013f568:	ccc080e7          	jalr	-820(ra) # 1008230 <HAL_OTP_Write>
1013f56c:	f955                	bnez	a0,1013f520 <DestroyKey+0x62>
1013f56e:	101407b7          	lui	a5,0x10140
1013f572:	e1478793          	addi	a5,a5,-492 # 1013fe14 <key_data_table>
1013f576:	4537c50b          	th.lrw	a0,a5,s3,2
1013f57a:	e919                	bnez	a0,1013f590 <DestroyKey+0xd2>
1013f57c:	4781                	li	a5,0
1013f57e:	b755                	j	1013f522 <DestroyKey+0x64>
1013f580:	ffb98713          	addi	a4,s3,-5
1013f584:	02000413          	li	s0,32
1013f588:	47c1                	li	a5,16
1013f58a:	40e7940b          	th.mveqz	s0,a5,a4
1013f58e:	b7c5                	j	1013f56e <DestroyKey+0xb0>
1013f590:	8622                	mv	a2,s0
1013f592:	4581                	li	a1,0
1013f594:	f0ecc097          	auipc	ra,0xf0ecc
1013f598:	598080e7          	jalr	1432(ra) # 100bb2c <memset>
1013f59c:	b7c5                	j	1013f57c <DestroyKey+0xbe>
1013f59e:	57f9                	li	a5,-2
1013f5a0:	b749                	j	1013f522 <DestroyKey+0x64>

1013f5a2 <trng_derive_key>:
1013f5a2:	c14d                	beqz	a0,1013f644 <trng_derive_key+0xa2>
1013f5a4:	f0ecc317          	auipc	t1,0xf0ecc
1013f5a8:	454302e7          	jalr	t0,1108(t1) # 100b9f8 <__riscv_save_4>
1013f5ac:	84aa                	mv	s1,a0
1013f5ae:	1141                	addi	sp,sp,-16
1013f5b0:	892e                	mv	s2,a1
1013f5b2:	5579                	li	a0,-2
1013f5b4:	c1d9                	beqz	a1,1013f63a <trng_derive_key+0x98>
1013f5b6:	ff058413          	addi	s0,a1,-16
1013f5ba:	983d                	andi	s0,s0,-17
1013f5bc:	ec3d                	bnez	s0,1013f63a <trng_derive_key+0x98>
1013f5be:	2141                	jal	1013fa3e <HAL_TRNG_MSP_Init>
1013f5c0:	4505                	li	a0,1
1013f5c2:	2939                	jal	1013f9e0 <send_cmd>
1013f5c4:	450d                	li	a0,3
1013f5c6:	2929                	jal	1013f9e0 <send_cmd>
1013f5c8:	4519                	li	a0,6
1013f5ca:	2919                	jal	1013f9e0 <send_cmd>
1013f5cc:	40004737          	lui	a4,0x40004
1013f5d0:	5354                	lw	a3,36(a4)
1013f5d2:	451d                	li	a0,7
1013f5d4:	898a                	mv	s3,sp
1013f5d6:	c036                	sw	a3,0(sp)
1013f5d8:	5714                	lw	a3,40(a4)
1013f5da:	c236                	sw	a3,4(sp)
1013f5dc:	5754                	lw	a3,44(a4)
1013f5de:	c436                	sw	a3,8(sp)
1013f5e0:	5b18                	lw	a4,48(a4)
1013f5e2:	c63a                	sw	a4,12(sp)
1013f5e4:	2ef5                	jal	1013f9e0 <send_cmd>
1013f5e6:	4781                	li	a5,0
1013f5e8:	4741                	li	a4,16
1013f5ea:	8137c68b          	th.lrbu	a3,a5,s3,0
1013f5ee:	00f4d68b          	th.srb	a3,s1,a5,0
1013f5f2:	0785                	addi	a5,a5,1
1013f5f4:	fee79be3          	bne	a5,a4,1013f5ea <trng_derive_key+0x48>
1013f5f8:	02000793          	li	a5,32
1013f5fc:	02f91963          	bne	s2,a5,1013f62e <trng_derive_key+0x8c>
1013f600:	4519                	li	a0,6
1013f602:	2ef9                	jal	1013f9e0 <send_cmd>
1013f604:	40004737          	lui	a4,0x40004
1013f608:	5354                	lw	a3,36(a4)
1013f60a:	451d                	li	a0,7
1013f60c:	04c1                	addi	s1,s1,16
1013f60e:	c036                	sw	a3,0(sp)
1013f610:	5714                	lw	a3,40(a4)
1013f612:	c236                	sw	a3,4(sp)
1013f614:	5754                	lw	a3,44(a4)
1013f616:	c436                	sw	a3,8(sp)
1013f618:	5b18                	lw	a4,48(a4)
1013f61a:	c63a                	sw	a4,12(sp)
1013f61c:	26d1                	jal	1013f9e0 <send_cmd>
1013f61e:	47c1                	li	a5,16
1013f620:	8089c70b          	th.lrbu	a4,s3,s0,0
1013f624:	0084d70b          	th.srb	a4,s1,s0,0
1013f628:	0405                	addi	s0,s0,1
1013f62a:	fef41be3          	bne	s0,a5,1013f620 <trng_derive_key+0x7e>
1013f62e:	400227b7          	lui	a5,0x40022
1013f632:	80000737          	lui	a4,0x80000
1013f636:	cbd8                	sw	a4,20(a5)
1013f638:	4501                	li	a0,0
1013f63a:	0141                	addi	sp,sp,16
1013f63c:	f0ecc317          	auipc	t1,0xf0ecc
1013f640:	3f030067          	jr	1008(t1) # 100ba2c <__riscv_restore_4>
1013f644:	5579                	li	a0,-2
1013f646:	8082                	ret

1013f648 <GetPubKey>:
1013f648:	f0ecc317          	auipc	t1,0xf0ecc
1013f64c:	3b0302e7          	jalr	t0,944(t1) # 100b9f8 <__riscv_save_4>
1013f650:	4705                	li	a4,1
1013f652:	7175                	addi	sp,sp,-144
1013f654:	84ae                	mv	s1,a1
1013f656:	00a77763          	bgeu	a4,a0,1013f664 <GetPubKey+0x1c>
1013f65a:	ffd50793          	addi	a5,a0,-3
1013f65e:	5479                	li	s0,-2
1013f660:	08f76963          	bltu	a4,a5,1013f6f2 <GetPubKey+0xaa>
1013f664:	101407b7          	lui	a5,0x10140
1013f668:	e1478793          	addi	a5,a5,-492 # 1013fe14 <key_data_table>
1013f66c:	44a7c90b          	th.lrw	s2,a5,a0,2
1013f670:	02000593          	li	a1,32
1013f674:	854a                	mv	a0,s2
1013f676:	2659                	jal	1013f9fc <is_key_empty>
1013f678:	842a                	mv	s0,a0
1013f67a:	e151                	bnez	a0,1013f6fe <GetPubKey+0xb6>
1013f67c:	4601                	li	a2,0
1013f67e:	097d                	addi	s2,s2,31
1013f680:	03010a93          	addi	s5,sp,48
1013f684:	02000793          	li	a5,32
1013f688:	40c00733          	neg	a4,a2
1013f68c:	80e9470b          	th.lrbu	a4,s2,a4,0
1013f690:	0156570b          	th.srb	a4,a2,s5,0
1013f694:	0605                	addi	a2,a2,1
1013f696:	fef619e3          	bne	a2,a5,1013f688 <GetPubKey+0x40>
1013f69a:	0100c937          	lui	s2,0x100c
1013f69e:	88890913          	addi	s2,s2,-1912 # 100b888 <SM2_G>
1013f6a2:	05010a13          	addi	s4,sp,80
1013f6a6:	85ca                	mv	a1,s2
1013f6a8:	8552                	mv	a0,s4
1013f6aa:	c632                	sw	a2,12(sp)
1013f6ac:	f0ecc097          	auipc	ra,0xf0ecc
1013f6b0:	468080e7          	jalr	1128(ra) # 100bb14 <memcpy>
1013f6b4:	4632                	lw	a2,12(sp)
1013f6b6:	07010993          	addi	s3,sp,112
1013f6ba:	02090593          	addi	a1,s2,32
1013f6be:	854e                	mv	a0,s3
1013f6c0:	f0ecc097          	auipc	ra,0xf0ecc
1013f6c4:	454080e7          	jalr	1108(ra) # 100bb14 <memcpy>
1013f6c8:	8552                	mv	a0,s4
1013f6ca:	2e91                	jal	1013fa1e <arr_reverse.constprop.0>
1013f6cc:	854e                	mv	a0,s3
1013f6ce:	2e81                	jal	1013fa1e <arr_reverse.constprop.0>
1013f6d0:	02048913          	addi	s2,s1,32
1013f6d4:	086c                	addi	a1,sp,28
1013f6d6:	4505                	li	a0,1
1013f6d8:	ce56                	sw	s5,28(sp)
1013f6da:	d052                	sw	s4,32(sp)
1013f6dc:	d24e                	sw	s3,36(sp)
1013f6de:	d426                	sw	s1,40(sp)
1013f6e0:	d64a                	sw	s2,44(sp)
1013f6e2:	f0ec5097          	auipc	ra,0xf0ec5
1013f6e6:	5e6080e7          	jalr	1510(ra) # 1004cc8 <HAL_OTBN_ECC256_ScalarMult_Polling>
1013f6ea:	8526                	mv	a0,s1
1013f6ec:	2e0d                	jal	1013fa1e <arr_reverse.constprop.0>
1013f6ee:	854a                	mv	a0,s2
1013f6f0:	263d                	jal	1013fa1e <arr_reverse.constprop.0>
1013f6f2:	8522                	mv	a0,s0
1013f6f4:	6149                	addi	sp,sp,144
1013f6f6:	f0ecc317          	auipc	t1,0xf0ecc
1013f6fa:	33630067          	jr	822(t1) # 100ba2c <__riscv_restore_4>
1013f6fe:	5461                	li	s0,-8
1013f700:	bfcd                	j	1013f6f2 <GetPubKey+0xaa>

1013f702 <LoadPublicKey>:
1013f702:	c50d                	beqz	a0,1013f72c <LoadPublicKey+0x2a>
1013f704:	f0ecc317          	auipc	t1,0xf0ecc
1013f708:	30e302e7          	jalr	t0,782(t1) # 100ba12 <__riscv_save_0>
1013f70c:	85aa                	mv	a1,a0
1013f70e:	10140537          	lui	a0,0x10140
1013f712:	04000613          	li	a2,64
1013f716:	e3050513          	addi	a0,a0,-464 # 1013fe30 <LOAD_PUBKEY_DATA>
1013f71a:	f0ecc097          	auipc	ra,0xf0ecc
1013f71e:	3fa080e7          	jalr	1018(ra) # 100bb14 <memcpy>
1013f722:	4501                	li	a0,0
1013f724:	f0ecc317          	auipc	t1,0xf0ecc
1013f728:	31230067          	jr	786(t1) # 100ba36 <__riscv_restore_0>
1013f72c:	5579                	li	a0,-2
1013f72e:	8082                	ret

1013f730 <ExportKey>:
1013f730:	ffe50713          	addi	a4,a0,-2
1013f734:	478d                	li	a5,3
1013f736:	06e7ef63          	bltu	a5,a4,1013f7b4 <ExportKey+0x84>
1013f73a:	f0ecc317          	auipc	t1,0xf0ecc
1013f73e:	2be302e7          	jalr	t0,702(t1) # 100b9f8 <__riscv_save_4>
1013f742:	02000a93          	li	s5,32
1013f746:	47c1                	li	a5,16
1013f748:	8456                	mv	s0,s5
1013f74a:	40e7940b          	th.mveqz	s0,a5,a4
1013f74e:	ffb50713          	addi	a4,a0,-5
1013f752:	40e7940b          	th.mveqz	s0,a5,a4
1013f756:	101407b7          	lui	a5,0x10140
1013f75a:	e1478793          	addi	a5,a5,-492 # 1013fe14 <key_data_table>
1013f75e:	44a7c98b          	th.lrw	s3,a5,a0,2
1013f762:	1101                	addi	sp,sp,-32
1013f764:	84ae                	mv	s1,a1
1013f766:	854e                	mv	a0,s3
1013f768:	85a2                	mv	a1,s0
1013f76a:	8932                	mv	s2,a2
1013f76c:	2c41                	jal	1013f9fc <is_key_empty>
1013f76e:	5761                	li	a4,-8
1013f770:	ed05                	bnez	a0,1013f7a8 <ExportKey+0x78>
1013f772:	10140a37          	lui	s4,0x10140
1013f776:	04000593          	li	a1,64
1013f77a:	e30a0513          	addi	a0,s4,-464 # 1013fe30 <LOAD_PUBKEY_DATA>
1013f77e:	2cbd                	jal	1013f9fc <is_key_empty>
1013f780:	5761                	li	a4,-8
1013f782:	e11d                	bnez	a0,1013f7a8 <ExportKey+0x78>
1013f784:	85d6                	mv	a1,s5
1013f786:	850a                	mv	a0,sp
1013f788:	3d29                	jal	1013f5a2 <trng_derive_key>
1013f78a:	577d                	li	a4,-1
1013f78c:	ed11                	bnez	a0,1013f7a8 <ExportKey+0x78>
1013f78e:	e30a0713          	addi	a4,s4,-464
1013f792:	87ca                	mv	a5,s2
1013f794:	868a                	mv	a3,sp
1013f796:	8622                	mv	a2,s0
1013f798:	85a6                	mv	a1,s1
1013f79a:	854e                	mv	a0,s3
1013f79c:	f0eca097          	auipc	ra,0xf0eca
1013f7a0:	694080e7          	jalr	1684(ra) # 1009e30 <boot_sm2_encrypt>
1013f7a4:	fff50713          	addi	a4,a0,-1
1013f7a8:	853a                	mv	a0,a4
1013f7aa:	6105                	addi	sp,sp,32
1013f7ac:	f0ecc317          	auipc	t1,0xf0ecc
1013f7b0:	28030067          	jr	640(t1) # 100ba2c <__riscv_restore_4>
1013f7b4:	5779                	li	a4,-2
1013f7b6:	853a                	mv	a0,a4
1013f7b8:	8082                	ret

1013f7ba <ImportKey>:
1013f7ba:	f0ecc317          	auipc	t1,0xf0ecc
1013f7be:	23e302e7          	jalr	t0,574(t1) # 100b9f8 <__riscv_save_4>
1013f7c2:	ffd50713          	addi	a4,a0,-3
1013f7c6:	4789                	li	a5,2
1013f7c8:	1101                	addi	sp,sp,-32
1013f7ca:	00e7f963          	bgeu	a5,a4,1013f7dc <ImportKey+0x22>
1013f7ce:	5479                	li	s0,-2
1013f7d0:	8522                	mv	a0,s0
1013f7d2:	6105                	addi	sp,sp,32
1013f7d4:	f0ecc317          	auipc	t1,0xf0ecc
1013f7d8:	25830067          	jr	600(t1) # 100ba2c <__riscv_restore_4>
1013f7dc:	4785                	li	a5,1
1013f7de:	feb7e8e3          	bltu	a5,a1,1013f7ce <ImportKey+0x14>
1013f7e2:	10140937          	lui	s2,0x10140
1013f7e6:	e1490913          	addi	s2,s2,-492 # 1013fe14 <key_data_table>
1013f7ea:	44b94b0b          	th.lrw	s6,s2,a1,2
1013f7ee:	02000713          	li	a4,32
1013f7f2:	ffb50793          	addi	a5,a0,-5
1013f7f6:	84aa                	mv	s1,a0
1013f7f8:	49c1                	li	s3,16
1013f7fa:	85ba                	mv	a1,a4
1013f7fc:	855a                	mv	a0,s6
1013f7fe:	8a32                	mv	s4,a2
1013f800:	8ab6                	mv	s5,a3
1013f802:	42f7198b          	th.mvnez	s3,a4,a5
1013f806:	2add                	jal	1013f9fc <is_key_empty>
1013f808:	842a                	mv	s0,a0
1013f80a:	ed05                	bnez	a0,1013f842 <ImportKey+0x88>
1013f80c:	02000613          	li	a2,32
1013f810:	4581                	li	a1,0
1013f812:	850a                	mv	a0,sp
1013f814:	f0ecc097          	auipc	ra,0xf0ecc
1013f818:	318080e7          	jalr	792(ra) # 100bb2c <memset>
1013f81c:	8756                	mv	a4,s5
1013f81e:	86da                	mv	a3,s6
1013f820:	864e                	mv	a2,s3
1013f822:	858a                	mv	a1,sp
1013f824:	8552                	mv	a0,s4
1013f826:	f0ecb097          	auipc	ra,0xf0ecb
1013f82a:	826080e7          	jalr	-2010(ra) # 100a04c <boot_sm2_decrypt>
1013f82e:	d145                	beqz	a0,1013f7ce <ImportKey+0x14>
1013f830:	4499450b          	th.lrw	a0,s2,s1,2
1013f834:	864e                	mv	a2,s3
1013f836:	858a                	mv	a1,sp
1013f838:	f0ecc097          	auipc	ra,0xf0ecc
1013f83c:	2dc080e7          	jalr	732(ra) # 100bb14 <memcpy>
1013f840:	bf41                	j	1013f7d0 <ImportKey+0x16>
1013f842:	5461                	li	s0,-8
1013f844:	b771                	j	1013f7d0 <ImportKey+0x16>

1013f846 <SM2_decrypt>:
1013f846:	f0ecc317          	auipc	t1,0xf0ecc
1013f84a:	1cc302e7          	jalr	t0,460(t1) # 100ba12 <__riscv_save_0>
1013f84e:	863a                	mv	a2,a4
1013f850:	1141                	addi	sp,sp,-16
1013f852:	842e                	mv	s0,a1
1013f854:	84b6                	mv	s1,a3
1013f856:	873e                	mv	a4,a5
1013f858:	c509                	beqz	a0,1013f862 <SM2_decrypt+0x1c>
1013f85a:	478d                	li	a5,3
1013f85c:	5879                	li	a6,-2
1013f85e:	04f51163          	bne	a0,a5,1013f8a0 <SM2_decrypt+0x5a>
1013f862:	c63a                	sw	a4,12(sp)
1013f864:	5879                	li	a6,-2
1013f866:	cc0d                	beqz	s0,1013f8a0 <SM2_decrypt+0x5a>
1013f868:	02048c63          	beqz	s1,1013f8a0 <SM2_decrypt+0x5a>
1013f86c:	c432                	sw	a2,8(sp)
1013f86e:	ca0d                	beqz	a2,1013f8a0 <SM2_decrypt+0x5a>
1013f870:	101407b7          	lui	a5,0x10140
1013f874:	e1478793          	addi	a5,a5,-492 # 1013fe14 <key_data_table>
1013f878:	44a7c68b          	th.lrw	a3,a5,a0,2
1013f87c:	02000593          	li	a1,32
1013f880:	8536                	mv	a0,a3
1013f882:	c236                	sw	a3,4(sp)
1013f884:	2aa5                	jal	1013f9fc <is_key_empty>
1013f886:	5861                	li	a6,-8
1013f888:	ed01                	bnez	a0,1013f8a0 <SM2_decrypt+0x5a>
1013f88a:	4732                	lw	a4,12(sp)
1013f88c:	4692                	lw	a3,4(sp)
1013f88e:	4622                	lw	a2,8(sp)
1013f890:	85a6                	mv	a1,s1
1013f892:	8522                	mv	a0,s0
1013f894:	f0eca097          	auipc	ra,0xf0eca
1013f898:	7b8080e7          	jalr	1976(ra) # 100a04c <boot_sm2_decrypt>
1013f89c:	fff50813          	addi	a6,a0,-1
1013f8a0:	8542                	mv	a0,a6
1013f8a2:	0141                	addi	sp,sp,16
1013f8a4:	f0ecc317          	auipc	t1,0xf0ecc
1013f8a8:	19230067          	jr	402(t1) # 100ba36 <__riscv_restore_0>

1013f8ac <SM2_sign>:
1013f8ac:	f0ecc317          	auipc	t1,0xf0ecc
1013f8b0:	166302e7          	jalr	t0,358(t1) # 100ba12 <__riscv_save_0>
1013f8b4:	4785                	li	a5,1
1013f8b6:	1141                	addi	sp,sp,-16
1013f8b8:	842e                	mv	s0,a1
1013f8ba:	00f50663          	beq	a0,a5,1013f8c6 <SM2_sign+0x1a>
1013f8be:	4711                	li	a4,4
1013f8c0:	57f9                	li	a5,-2
1013f8c2:	02e51e63          	bne	a0,a4,1013f8fe <SM2_sign+0x52>
1013f8c6:	57f9                	li	a5,-2
1013f8c8:	c81d                	beqz	s0,1013f8fe <SM2_sign+0x52>
1013f8ca:	c632                	sw	a2,12(sp)
1013f8cc:	ca0d                	beqz	a2,1013f8fe <SM2_sign+0x52>
1013f8ce:	c436                	sw	a3,8(sp)
1013f8d0:	c69d                	beqz	a3,1013f8fe <SM2_sign+0x52>
1013f8d2:	101407b7          	lui	a5,0x10140
1013f8d6:	e1478793          	addi	a5,a5,-492 # 1013fe14 <key_data_table>
1013f8da:	44a7c48b          	th.lrw	s1,a5,a0,2
1013f8de:	02000593          	li	a1,32
1013f8e2:	8526                	mv	a0,s1
1013f8e4:	2a21                	jal	1013f9fc <is_key_empty>
1013f8e6:	57e1                	li	a5,-8
1013f8e8:	e919                	bnez	a0,1013f8fe <SM2_sign+0x52>
1013f8ea:	46a2                	lw	a3,8(sp)
1013f8ec:	4632                	lw	a2,12(sp)
1013f8ee:	85a2                	mv	a1,s0
1013f8f0:	8526                	mv	a0,s1
1013f8f2:	f0ecb097          	auipc	ra,0xf0ecb
1013f8f6:	84e080e7          	jalr	-1970(ra) # 100a140 <boot_sm2_sign>
1013f8fa:	fff50793          	addi	a5,a0,-1
1013f8fe:	853e                	mv	a0,a5
1013f900:	0141                	addi	sp,sp,16
1013f902:	f0ecc317          	auipc	t1,0xf0ecc
1013f906:	13430067          	jr	308(t1) # 100ba36 <__riscv_restore_0>

1013f90a <SM2_verify>:
1013f90a:	c905                	beqz	a0,1013f93a <SM2_verify+0x30>
1013f90c:	87aa                	mv	a5,a0
1013f90e:	86ae                	mv	a3,a1
1013f910:	5579                	li	a0,-2
1013f912:	c595                	beqz	a1,1013f93e <SM2_verify+0x34>
1013f914:	8732                	mv	a4,a2
1013f916:	c605                	beqz	a2,1013f93e <SM2_verify+0x34>
1013f918:	f0ecc317          	auipc	t1,0xf0ecc
1013f91c:	0fa302e7          	jalr	t0,250(t1) # 100ba12 <__riscv_save_0>
1013f920:	02078613          	addi	a2,a5,32
1013f924:	85be                	mv	a1,a5
1013f926:	4519                	li	a0,6
1013f928:	f0ecb097          	auipc	ra,0xf0ecb
1013f92c:	22e080e7          	jalr	558(ra) # 100ab56 <boot_ecc_verify>
1013f930:	157d                	addi	a0,a0,-1
1013f932:	f0ecc317          	auipc	t1,0xf0ecc
1013f936:	10430067          	jr	260(t1) # 100ba36 <__riscv_restore_0>
1013f93a:	5579                	li	a0,-2
1013f93c:	8082                	ret
1013f93e:	8082                	ret

1013f940 <SM4_enc_dec_process>:
1013f940:	f0ecc317          	auipc	t1,0xf0ecc
1013f944:	0d2302e7          	jalr	t0,210(t1) # 100ba12 <__riscv_save_0>
1013f948:	1141                	addi	sp,sp,-16
1013f94a:	843a                	mv	s0,a4
1013f94c:	58f9                	li	a7,-2
1013f94e:	c73d                	beqz	a4,1013f9bc <SM4_enc_dec_process+0x7c>
1013f950:	832e                	mv	t1,a1
1013f952:	58f9                	li	a7,-2
1013f954:	85b6                	mv	a1,a3
1013f956:	86be                	mv	a3,a5
1013f958:	c3b5                	beqz	a5,1013f9bc <SM4_enc_dec_process+0x7c>
1013f95a:	8742                	mv	a4,a6
1013f95c:	06080063          	beqz	a6,1013f9bc <SM4_enc_dec_process+0x7c>
1013f960:	00f87793          	andi	a5,a6,15
1013f964:	efa1                	bnez	a5,1013f9bc <SM4_enc_dec_process+0x7c>
1013f966:	4789                	li	a5,2
1013f968:	84b2                	mv	s1,a2
1013f96a:	00f50563          	beq	a0,a5,1013f974 <SM4_enc_dec_process+0x34>
1013f96e:	4795                	li	a5,5
1013f970:	04f51663          	bne	a0,a5,1013f9bc <SM4_enc_dec_process+0x7c>
1013f974:	4785                	li	a5,1
1013f976:	00f31463          	bne	t1,a5,1013f97e <SM4_enc_dec_process+0x3e>
1013f97a:	58f9                	li	a7,-2
1013f97c:	c1a1                	beqz	a1,1013f9bc <SM4_enc_dec_process+0x7c>
1013f97e:	101407b7          	lui	a5,0x10140
1013f982:	e1478793          	addi	a5,a5,-492 # 1013fe14 <key_data_table>
1013f986:	44a7c78b          	th.lrw	a5,a5,a0,2
1013f98a:	58f9                	li	a7,-2
1013f98c:	cb85                	beqz	a5,1013f9bc <SM4_enc_dec_process+0x7c>
1013f98e:	04031263          	bnez	t1,1013f9d2 <SM4_enc_dec_process+0x92>
1013f992:	853e                	mv	a0,a5
1013f994:	c63a                	sw	a4,12(sp)
1013f996:	c436                	sw	a3,8(sp)
1013f998:	f0ec6097          	auipc	ra,0xf0ec6
1013f99c:	b36080e7          	jalr	-1226(ra) # 10054ce <HAL_SM4_KeyExpansion>
1013f9a0:	46a2                	lw	a3,8(sp)
1013f9a2:	4732                	lw	a4,12(sp)
1013f9a4:	8522                	mv	a0,s0
1013f9a6:	85b6                	mv	a1,a3
1013f9a8:	863a                	mv	a2,a4
1013f9aa:	ec99                	bnez	s1,1013f9c8 <SM4_enc_dec_process+0x88>
1013f9ac:	f0ec6097          	auipc	ra,0xf0ec6
1013f9b0:	b40080e7          	jalr	-1216(ra) # 10054ec <HAL_SM4_Encrypt>
1013f9b4:	00a03533          	snez	a0,a0
1013f9b8:	40a008b3          	neg	a7,a0
1013f9bc:	8546                	mv	a0,a7
1013f9be:	0141                	addi	sp,sp,16
1013f9c0:	f0ecc317          	auipc	t1,0xf0ecc
1013f9c4:	07630067          	jr	118(t1) # 100ba36 <__riscv_restore_0>
1013f9c8:	f0ec6097          	auipc	ra,0xf0ec6
1013f9cc:	b46080e7          	jalr	-1210(ra) # 100550e <HAL_SM4_Decrypt>
1013f9d0:	b7d5                	j	1013f9b4 <SM4_enc_dec_process+0x74>
1013f9d2:	8622                	mv	a2,s0
1013f9d4:	e481                	bnez	s1,1013f9dc <SM4_enc_dec_process+0x9c>
1013f9d6:	2ae1                	jal	1013fbae <SM4_CBC_encrypt_process>
1013f9d8:	88aa                	mv	a7,a0
1013f9da:	b7cd                	j	1013f9bc <SM4_enc_dec_process+0x7c>
1013f9dc:	2c69                	jal	1013fc76 <SM4_CBC_decrypt_process>
1013f9de:	bfed                	j	1013f9d8 <SM4_enc_dec_process+0x98>

1013f9e0 <send_cmd>:
1013f9e0:	400047b7          	lui	a5,0x40004
1013f9e4:	47d8                	lw	a4,12(a5)
1013f9e6:	fe074fe3          	bltz	a4,1013f9e4 <send_cmd+0x4>
1013f9ea:	c388                	sw	a0,0(a5)
1013f9ec:	40004737          	lui	a4,0x40004
1013f9f0:	4b5c                	lw	a5,20(a4)
1013f9f2:	8bc1                	andi	a5,a5,16
1013f9f4:	dff5                	beqz	a5,1013f9f0 <send_cmd+0x10>
1013f9f6:	47c1                	li	a5,16
1013f9f8:	cb5c                	sw	a5,20(a4)
1013f9fa:	8082                	ret

1013f9fc <is_key_empty>:
1013f9fc:	4701                	li	a4,0
1013f9fe:	0fd00693          	li	a3,253
1013fa02:	80e5478b          	th.lrbu	a5,a0,a4,0
1013fa06:	17fd                	addi	a5,a5,-1 # 40003fff <_bss_end+0x2fec40ef>
1013fa08:	0ff7f793          	zext.b	a5,a5
1013fa0c:	00f6f763          	bgeu	a3,a5,1013fa1a <is_key_empty+0x1e>
1013fa10:	0705                	addi	a4,a4,1 # 40004001 <_bss_end+0x2fec40f1>
1013fa12:	fee598e3          	bne	a1,a4,1013fa02 <is_key_empty+0x6>
1013fa16:	5561                	li	a0,-8
1013fa18:	8082                	ret
1013fa1a:	4501                	li	a0,0
1013fa1c:	8082                	ret

1013fa1e <arr_reverse.constprop.0>:
1013fa1e:	01f50713          	addi	a4,a0,31
1013fa22:	4781                	li	a5,0
1013fa24:	46c1                	li	a3,16
1013fa26:	00074583          	lbu	a1,0(a4)
1013fa2a:	80f5460b          	th.lrbu	a2,a0,a5,0
1013fa2e:	00f5558b          	th.srb	a1,a0,a5,0
1013fa32:	19f7560b          	th.sbia	a2,(a4),-1,0
1013fa36:	0785                	addi	a5,a5,1
1013fa38:	fed797e3          	bne	a5,a3,1013fa26 <arr_reverse.constprop.0+0x8>
1013fa3c:	8082                	ret

1013fa3e <HAL_TRNG_MSP_Init>:
1013fa3e:	400227b7          	lui	a5,0x40022
1013fa42:	80000737          	lui	a4,0x80000
1013fa46:	cbd8                	sw	a4,20(a5)
1013fa48:	cfd8                	sw	a4,28(a5)
1013fa4a:	40000737          	lui	a4,0x40000
1013fa4e:	cfd8                	sw	a4,28(a5)
1013fa50:	cbd8                	sw	a4,20(a5)
1013fa52:	8082                	ret

1013fa54 <strlen>:
1013fa54:	87aa                	mv	a5,a0
1013fa56:	4501                	li	a0,0
1013fa58:	80a7c70b          	th.lrbu	a4,a5,a0,0
1013fa5c:	e311                	bnez	a4,1013fa60 <strlen+0xc>
1013fa5e:	8082                	ret
1013fa60:	0505                	addi	a0,a0,1
1013fa62:	bfdd                	j	1013fa58 <strlen+0x4>

1013fa64 <Password_op>:
1013fa64:	f0ecc317          	auipc	t1,0xf0ecc
1013fa68:	f94302e7          	jalr	t0,-108(t1) # 100b9f8 <__riscv_save_4>
1013fa6c:	715d                	addi	sp,sp,-80
1013fa6e:	842a                	mv	s0,a0
1013fa70:	02000613          	li	a2,32
1013fa74:	892e                	mv	s2,a1
1013fa76:	0808                	addi	a0,sp,16
1013fa78:	4581                	li	a1,0
1013fa7a:	f0ecc097          	auipc	ra,0xf0ecc
1013fa7e:	0b2080e7          	jalr	178(ra) # 100bb2c <memset>
1013fa82:	02000613          	li	a2,32
1013fa86:	4581                	li	a1,0
1013fa88:	1808                	addi	a0,sp,48
1013fa8a:	f0ecc097          	auipc	ra,0xf0ecc
1013fa8e:	0a2080e7          	jalr	162(ra) # 100bb2c <memset>
1013fa92:	59fd                	li	s3,-1
1013fa94:	8522                	mv	a0,s0
1013fa96:	01310723          	sb	s3,14(sp)
1013fa9a:	3f6d                	jal	1013fa54 <strlen>
1013fa9c:	ff450713          	addi	a4,a0,-12
1013faa0:	47d1                	li	a5,20
1013faa2:	0ae7ec63          	bltu	a5,a4,1013fb5a <Password_op+0xf6>
1013faa6:	84aa                	mv	s1,a0
1013faa8:	4605                	li	a2,1
1013faaa:	00e10593          	addi	a1,sp,14
1013faae:	22000513          	li	a0,544
1013fab2:	f0ec8097          	auipc	ra,0xf0ec8
1013fab6:	60c080e7          	jalr	1548(ra) # 10080be <HAL_OTP_Read>
1013faba:	c901                	beqz	a0,1013faca <Password_op+0x66>
1013fabc:	57fd                	li	a5,-1
1013fabe:	853e                	mv	a0,a5
1013fac0:	6161                	addi	sp,sp,80
1013fac2:	f0ecc317          	auipc	t1,0xf0ecc
1013fac6:	f6a30067          	jr	-150(t1) # 100ba2c <__riscv_restore_4>
1013faca:	0810                	addi	a2,sp,16
1013facc:	85a6                	mv	a1,s1
1013face:	8522                	mv	a0,s0
1013fad0:	fc4ff0ef          	jal	1013f294 <SM3_cal>
1013fad4:	00e14703          	lbu	a4,14(sp)
1013fad8:	04091463          	bnez	s2,1013fb20 <Password_op+0xbc>
1013fadc:	57e5                	li	a5,-7
1013fade:	d365                	beqz	a4,1013fabe <Password_op+0x5a>
1013fae0:	0ff00693          	li	a3,255
1013fae4:	57e9                	li	a5,-6
1013fae6:	fcd71ce3          	bne	a4,a3,1013fabe <Password_op+0x5a>
1013faea:	02000613          	li	a2,32
1013faee:	080c                	addi	a1,sp,16
1013faf0:	20000513          	li	a0,512
1013faf4:	000107a3          	sb	zero,15(sp)
1013faf8:	f0ec8097          	auipc	ra,0xf0ec8
1013fafc:	738080e7          	jalr	1848(ra) # 1008230 <HAL_OTP_Write>
1013fb00:	87ce                	mv	a5,s3
1013fb02:	fd55                	bnez	a0,1013fabe <Password_op+0x5a>
1013fb04:	4605                	li	a2,1
1013fb06:	00f10593          	addi	a1,sp,15
1013fb0a:	22000513          	li	a0,544
1013fb0e:	f0ec8097          	auipc	ra,0xf0ec8
1013fb12:	722080e7          	jalr	1826(ra) # 1008230 <HAL_OTP_Write>
1013fb16:	00a037b3          	snez	a5,a0
1013fb1a:	40f007b3          	neg	a5,a5
1013fb1e:	b745                	j	1013fabe <Password_op+0x5a>
1013fb20:	0ff00693          	li	a3,255
1013fb24:	57e1                	li	a5,-8
1013fb26:	f8d70ce3          	beq	a4,a3,1013fabe <Password_op+0x5a>
1013fb2a:	57e9                	li	a5,-6
1013fb2c:	fb49                	bnez	a4,1013fabe <Password_op+0x5a>
1013fb2e:	02000613          	li	a2,32
1013fb32:	180c                	addi	a1,sp,48
1013fb34:	20000513          	li	a0,512
1013fb38:	f0ec8097          	auipc	ra,0xf0ec8
1013fb3c:	586080e7          	jalr	1414(ra) # 10080be <HAL_OTP_Read>
1013fb40:	fd35                	bnez	a0,1013fabc <Password_op+0x58>
1013fb42:	02000613          	li	a2,32
1013fb46:	180c                	addi	a1,sp,48
1013fb48:	0808                	addi	a0,sp,16
1013fb4a:	f0ecc097          	auipc	ra,0xf0ecc
1013fb4e:	fa4080e7          	jalr	-92(ra) # 100baee <memcmp>
1013fb52:	57f5                	li	a5,-3
1013fb54:	40a0178b          	th.mveqz	a5,zero,a0
1013fb58:	b79d                	j	1013fabe <Password_op+0x5a>
1013fb5a:	57f9                	li	a5,-2
1013fb5c:	b78d                	j	1013fabe <Password_op+0x5a>

1013fb5e <SM2_encrypt>:
1013fb5e:	872a                	mv	a4,a0
1013fb60:	c905                	beqz	a0,1013fb90 <SM2_encrypt+0x32>
1013fb62:	852e                	mv	a0,a1
1013fb64:	58f9                	li	a7,-2
1013fb66:	c595                	beqz	a1,1013fb92 <SM2_encrypt+0x34>
1013fb68:	85b6                	mv	a1,a3
1013fb6a:	c685                	beqz	a3,1013fb92 <SM2_encrypt+0x34>
1013fb6c:	86be                	mv	a3,a5
1013fb6e:	c395                	beqz	a5,1013fb92 <SM2_encrypt+0x34>
1013fb70:	f0ecc317          	auipc	t1,0xf0ecc
1013fb74:	ea2302e7          	jalr	t0,-350(t1) # 100ba12 <__riscv_save_0>
1013fb78:	87c2                	mv	a5,a6
1013fb7a:	f0eca097          	auipc	ra,0xf0eca
1013fb7e:	2b6080e7          	jalr	694(ra) # 1009e30 <boot_sm2_encrypt>
1013fb82:	fff50893          	addi	a7,a0,-1
1013fb86:	8546                	mv	a0,a7
1013fb88:	f0ecc317          	auipc	t1,0xf0ecc
1013fb8c:	eae30067          	jr	-338(t1) # 100ba36 <__riscv_restore_0>
1013fb90:	58f9                	li	a7,-2
1013fb92:	8546                	mv	a0,a7
1013fb94:	8082                	ret

1013fb96 <SM3_init>:
1013fb96:	f0ec4317          	auipc	t1,0xf0ec4
1013fb9a:	c0030067          	jr	-1024(t1) # 1003796 <HAL_OTBN_SM3_Init>

1013fb9e <SM3_update>:
1013fb9e:	f0ec4317          	auipc	t1,0xf0ec4
1013fba2:	c4c30067          	jr	-948(t1) # 10037ea <HAL_OTBN_SM3_Update>

1013fba6 <SM3_final>:
1013fba6:	f0ec4317          	auipc	t1,0xf0ec4
1013fbaa:	ce830067          	jr	-792(t1) # 100388e <HAL_OTBN_SM3_Final>

1013fbae <SM4_CBC_encrypt_process>:
1013fbae:	f0ecc317          	auipc	t1,0xf0ecc
1013fbb2:	e4a302e7          	jalr	t0,-438(t1) # 100b9f8 <__riscv_save_4>
1013fbb6:	7179                	addi	sp,sp,-48
1013fbb8:	5479                	li	s0,-2
1013fbba:	c5d5                	beqz	a1,1013fc66 <SM4_CBC_encrypt_process+0xb8>
1013fbbc:	8a32                	mv	s4,a2
1013fbbe:	5479                	li	s0,-2
1013fbc0:	c25d                	beqz	a2,1013fc66 <SM4_CBC_encrypt_process+0xb8>
1013fbc2:	89b6                	mv	s3,a3
1013fbc4:	c2cd                	beqz	a3,1013fc66 <SM4_CBC_encrypt_process+0xb8>
1013fbc6:	893a                	mv	s2,a4
1013fbc8:	cf59                	beqz	a4,1013fc66 <SM4_CBC_encrypt_process+0xb8>
1013fbca:	00f77493          	andi	s1,a4,15
1013fbce:	ecc1                	bnez	s1,1013fc66 <SM4_CBC_encrypt_process+0xb8>
1013fbd0:	4789                	li	a5,2
1013fbd2:	8aae                	mv	s5,a1
1013fbd4:	00f50563          	beq	a0,a5,1013fbde <SM4_CBC_encrypt_process+0x30>
1013fbd8:	4795                	li	a5,5
1013fbda:	08f51663          	bne	a0,a5,1013fc66 <SM4_CBC_encrypt_process+0xb8>
1013fbde:	101407b7          	lui	a5,0x10140
1013fbe2:	e1478793          	addi	a5,a5,-492 # 1013fe14 <key_data_table>
1013fbe6:	44a7cb0b          	th.lrw	s6,a5,a0,2
1013fbea:	45c1                	li	a1,16
1013fbec:	855a                	mv	a0,s6
1013fbee:	3539                	jal	1013f9fc <is_key_empty>
1013fbf0:	842a                	mv	s0,a0
1013fbf2:	e141                	bnez	a0,1013fc72 <SM4_CBC_encrypt_process+0xc4>
1013fbf4:	855a                	mv	a0,s6
1013fbf6:	f0ec6097          	auipc	ra,0xf0ec6
1013fbfa:	8d8080e7          	jalr	-1832(ra) # 10054ce <HAL_SM4_KeyExpansion>
1013fbfe:	4641                	li	a2,16
1013fc00:	85d6                	mv	a1,s5
1013fc02:	00c10533          	add	a0,sp,a2
1013fc06:	f0ecc097          	auipc	ra,0xf0ecc
1013fc0a:	f0e080e7          	jalr	-242(ra) # 100bb14 <memcpy>
1013fc0e:	009a05b3          	add	a1,s4,s1
1013fc12:	4641                	li	a2,16
1013fc14:	1008                	addi	a0,sp,32
1013fc16:	f0ecc097          	auipc	ra,0xf0ecc
1013fc1a:	efe080e7          	jalr	-258(ra) # 100bb14 <memcpy>
1013fc1e:	5702                	lw	a4,32(sp)
1013fc20:	46c2                	lw	a3,16(sp)
1013fc22:	009985b3          	add	a1,s3,s1
1013fc26:	4641                	li	a2,16
1013fc28:	8f35                	xor	a4,a4,a3
1013fc2a:	d03a                	sw	a4,32(sp)
1013fc2c:	46d2                	lw	a3,20(sp)
1013fc2e:	5712                	lw	a4,36(sp)
1013fc30:	1008                	addi	a0,sp,32
1013fc32:	c62e                	sw	a1,12(sp)
1013fc34:	8f35                	xor	a4,a4,a3
1013fc36:	d23a                	sw	a4,36(sp)
1013fc38:	46e2                	lw	a3,24(sp)
1013fc3a:	5722                	lw	a4,40(sp)
1013fc3c:	04c1                	addi	s1,s1,16
1013fc3e:	8f35                	xor	a4,a4,a3
1013fc40:	d43a                	sw	a4,40(sp)
1013fc42:	46f2                	lw	a3,28(sp)
1013fc44:	5732                	lw	a4,44(sp)
1013fc46:	8f35                	xor	a4,a4,a3
1013fc48:	d63a                	sw	a4,44(sp)
1013fc4a:	f0ec6097          	auipc	ra,0xf0ec6
1013fc4e:	8a2080e7          	jalr	-1886(ra) # 10054ec <HAL_SM4_Encrypt>
1013fc52:	45b2                	lw	a1,12(sp)
1013fc54:	4641                	li	a2,16
1013fc56:	00c10533          	add	a0,sp,a2
1013fc5a:	f0ecc097          	auipc	ra,0xf0ecc
1013fc5e:	eba080e7          	jalr	-326(ra) # 100bb14 <memcpy>
1013fc62:	fb24e6e3          	bltu	s1,s2,1013fc0e <SM4_CBC_encrypt_process+0x60>
1013fc66:	8522                	mv	a0,s0
1013fc68:	6145                	addi	sp,sp,48
1013fc6a:	f0ecc317          	auipc	t1,0xf0ecc
1013fc6e:	dc230067          	jr	-574(t1) # 100ba2c <__riscv_restore_4>
1013fc72:	5461                	li	s0,-8
1013fc74:	bfcd                	j	1013fc66 <SM4_CBC_encrypt_process+0xb8>

1013fc76 <SM4_CBC_decrypt_process>:
1013fc76:	f0ecc317          	auipc	t1,0xf0ecc
1013fc7a:	d74302e7          	jalr	t0,-652(t1) # 100b9ea <__riscv_save_10>
1013fc7e:	7179                	addi	sp,sp,-48
1013fc80:	5479                	li	s0,-2
1013fc82:	cdb9                	beqz	a1,1013fce0 <SM4_CBC_decrypt_process+0x6a>
1013fc84:	8a32                	mv	s4,a2
1013fc86:	5479                	li	s0,-2
1013fc88:	ce21                	beqz	a2,1013fce0 <SM4_CBC_decrypt_process+0x6a>
1013fc8a:	84b6                	mv	s1,a3
1013fc8c:	cab1                	beqz	a3,1013fce0 <SM4_CBC_decrypt_process+0x6a>
1013fc8e:	00f77913          	andi	s2,a4,15
1013fc92:	89ba                	mv	s3,a4
1013fc94:	04091663          	bnez	s2,1013fce0 <SM4_CBC_decrypt_process+0x6a>
1013fc98:	4789                	li	a5,2
1013fc9a:	8aae                	mv	s5,a1
1013fc9c:	00f50563          	beq	a0,a5,1013fca6 <SM4_CBC_decrypt_process+0x30>
1013fca0:	4795                	li	a5,5
1013fca2:	02f51f63          	bne	a0,a5,1013fce0 <SM4_CBC_decrypt_process+0x6a>
1013fca6:	101407b7          	lui	a5,0x10140
1013fcaa:	e1478793          	addi	a5,a5,-492 # 1013fe14 <key_data_table>
1013fcae:	44a7cb0b          	th.lrw	s6,a5,a0,2
1013fcb2:	45c1                	li	a1,16
1013fcb4:	855a                	mv	a0,s6
1013fcb6:	3399                	jal	1013f9fc <is_key_empty>
1013fcb8:	842a                	mv	s0,a0
1013fcba:	e149                	bnez	a0,1013fd3c <SM4_CBC_decrypt_process+0xc6>
1013fcbc:	855a                	mv	a0,s6
1013fcbe:	f0ec6097          	auipc	ra,0xf0ec6
1013fcc2:	810080e7          	jalr	-2032(ra) # 10054ce <HAL_SM4_KeyExpansion>
1013fcc6:	85d6                	mv	a1,s5
1013fcc8:	4641                	li	a2,16
1013fcca:	850a                	mv	a0,sp
1013fccc:	f0ecc097          	auipc	ra,0xf0ecc
1013fcd0:	e48080e7          	jalr	-440(ra) # 100bb14 <memcpy>
1013fcd4:	4a82                	lw	s5,0(sp)
1013fcd6:	4b12                	lw	s6,4(sp)
1013fcd8:	4ba2                	lw	s7,8(sp)
1013fcda:	4c32                	lw	s8,12(sp)
1013fcdc:	01396863          	bltu	s2,s3,1013fcec <SM4_CBC_decrypt_process+0x76>
1013fce0:	8522                	mv	a0,s0
1013fce2:	6145                	addi	sp,sp,48
1013fce4:	f0ecc317          	auipc	t1,0xf0ecc
1013fce8:	d3e30067          	jr	-706(t1) # 100ba22 <__riscv_restore_10>
1013fcec:	012a0cb3          	add	s9,s4,s2
1013fcf0:	4641                	li	a2,16
1013fcf2:	85e6                	mv	a1,s9
1013fcf4:	00c10533          	add	a0,sp,a2
1013fcf8:	f0ecc097          	auipc	ra,0xf0ecc
1013fcfc:	e1c080e7          	jalr	-484(ra) # 100bb14 <memcpy>
1013fd00:	4641                	li	a2,16
1013fd02:	100c                	addi	a1,sp,32
1013fd04:	8566                	mv	a0,s9
1013fd06:	f0ec6097          	auipc	ra,0xf0ec6
1013fd0a:	808080e7          	jalr	-2040(ra) # 100550e <HAL_SM4_Decrypt>
1013fd0e:	5702                	lw	a4,32(sp)
1013fd10:	0941                	addi	s2,s2,16
1013fd12:	01574733          	xor	a4,a4,s5
1013fd16:	c098                	sw	a4,0(s1)
1013fd18:	5712                	lw	a4,36(sp)
1013fd1a:	4ac2                	lw	s5,16(sp)
1013fd1c:	01674733          	xor	a4,a4,s6
1013fd20:	c0d8                	sw	a4,4(s1)
1013fd22:	5722                	lw	a4,40(sp)
1013fd24:	4b52                	lw	s6,20(sp)
1013fd26:	01774733          	xor	a4,a4,s7
1013fd2a:	c498                	sw	a4,8(s1)
1013fd2c:	5732                	lw	a4,44(sp)
1013fd2e:	4be2                	lw	s7,24(sp)
1013fd30:	01874733          	xor	a4,a4,s8
1013fd34:	c4d8                	sw	a4,12(s1)
1013fd36:	4c72                	lw	s8,28(sp)
1013fd38:	04c1                	addi	s1,s1,16
1013fd3a:	b74d                	j	1013fcdc <SM4_CBC_decrypt_process+0x66>
1013fd3c:	5461                	li	s0,-8
1013fd3e:	b74d                	j	1013fce0 <SM4_CBC_decrypt_process+0x6a>

1013fd40 <Security_TRNG_SelfTest>:
1013fd40:	f0ecc317          	auipc	t1,0xf0ecc
1013fd44:	cd2302e7          	jalr	t0,-814(t1) # 100ba12 <__riscv_save_0>
1013fd48:	711d                	addi	sp,sp,-96
1013fd4a:	02000593          	li	a1,32
1013fd4e:	850a                	mv	a0,sp
1013fd50:	3889                	jal	1013f5a2 <trng_derive_key>
1013fd52:	842a                	mv	s0,a0
1013fd54:	5579                	li	a0,-2
1013fd56:	e04d                	bnez	s0,1013fdf8 <Security_TRNG_SelfTest+0xb8>
1013fd58:	02010813          	addi	a6,sp,32
1013fd5c:	04000613          	li	a2,64
1013fd60:	4581                	li	a1,0
1013fd62:	8542                	mv	a0,a6
1013fd64:	f0ecc097          	auipc	ra,0xf0ecc
1013fd68:	dc8080e7          	jalr	-568(ra) # 100bb2c <memset>
1013fd6c:	882a                	mv	a6,a0
1013fd6e:	848a                	mv	s1,sp
1013fd70:	4501                	li	a0,0
1013fd72:	4701                	li	a4,0
1013fd74:	4681                	li	a3,0
1013fd76:	55fd                	li	a1,-1
1013fd78:	4605                	li	a2,1
1013fd7a:	4ea1                	li	t4,8
1013fd7c:	02000e13          	li	t3,32
1013fd80:	80a4c78b          	th.lrbu	a5,s1,a0,0
1013fd84:	4881                	li	a7,0
1013fd86:	832e                	mv	t1,a1
1013fd88:	4117d5b3          	sra	a1,a5,a7
1013fd8c:	8985                	andi	a1,a1,1
1013fd8e:	96ae                	add	a3,a3,a1
1013fd90:	06659963          	bne	a1,t1,1013fe02 <Security_TRNG_SelfTest+0xc2>
1013fd94:	0605                	addi	a2,a2,1
1013fd96:	0885                	addi	a7,a7,1
1013fd98:	ffd897e3          	bne	a7,t4,1013fd86 <Security_TRNG_SelfTest+0x46>
1013fd9c:	00f7f313          	andi	t1,a5,15
1013fda0:	4468488b          	th.lrw	a7,a6,t1,2
1013fda4:	8391                	srli	a5,a5,0x4
1013fda6:	0505                	addi	a0,a0,1
1013fda8:	0885                	addi	a7,a7,1
1013fdaa:	4468588b          	th.srw	a7,a6,t1,2
1013fdae:	44f8488b          	th.lrw	a7,a6,a5,2
1013fdb2:	0885                	addi	a7,a7,1
1013fdb4:	44f8588b          	th.srw	a7,a6,a5,2
1013fdb8:	fdc514e3          	bne	a0,t3,1013fd80 <Security_TRNG_SelfTest+0x40>
1013fdbc:	4781                	li	a5,0
1013fdbe:	4541                	li	a0,16
1013fdc0:	4488458b          	th.lrw	a1,a6,s0,2
1013fdc4:	0405                	addi	s0,s0,1
1013fdc6:	20b5978b          	th.mula	a5,a1,a1
1013fdca:	fea41be3          	bne	s0,a0,1013fdc0 <Security_TRNG_SelfTest+0x80>
1013fdce:	00c72533          	slt	a0,a4,a2
1013fdd2:	55fd                	li	a1,-1
1013fdd4:	42a6170b          	th.mvnez	a4,a2,a0
1013fdd8:	1c37b513          	sltiu	a0,a5,451
1013fddc:	47fd                	li	a5,31
1013fdde:	00e7a733          	slt	a4,a5,a4
1013fde2:	f9868693          	addi	a3,a3,-104
1013fde6:	952e                	add	a0,a0,a1
1013fde8:	03000793          	li	a5,48
1013fdec:	42e5950b          	th.mvnez	a0,a1,a4
1013fdf0:	00d7b6b3          	sltu	a3,a5,a3
1013fdf4:	42d5950b          	th.mvnez	a0,a1,a3
1013fdf8:	6125                	addi	sp,sp,96
1013fdfa:	f0ecc317          	auipc	t1,0xf0ecc
1013fdfe:	c3c30067          	jr	-964(t1) # 100ba36 <__riscv_restore_0>
1013fe02:	00c72333          	slt	t1,a4,a2
1013fe06:	4266170b          	th.mvnez	a4,a2,t1
1013fe0a:	4605                	li	a2,1
1013fe0c:	b769                	j	1013fd96 <Security_TRNG_SelfTest+0x56>

1013fe0e <CSWTCH.58>:
1013fe0e:	2020 0010 0000                                ....

1013fe14 <key_data_table>:
1013fe14:	fef0 1013 fed0 1013 fec0 1013 fea0 1013     ................
1013fe24:	fe80 1013 fe70 1013 fe30 1013               ....p...0...

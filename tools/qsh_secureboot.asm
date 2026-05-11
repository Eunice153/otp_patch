
build\qsh\qsh_secureboot.elf:     file format elf32-littleriscv
build\qsh\qsh_secureboot.elf
architecture: riscv:rv32, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x01000000

Program Header:
0x70000003 off    0x000771ca vaddr 0x00000000 paddr 0x00000000 align 2**0
         filesz 0x000000eb memsz 0x00000000 flags r--
    LOAD off    0x00001000 vaddr 0x01000000 paddr 0x01000000 align 2**12
         filesz 0x0000bb40 memsz 0x0000bb40 flags r-x
    LOAD off    0x00000000 vaddr 0x10138000 paddr 0x0100bb40 align 2**12
         filesz 0x00000000 memsz 0x00000fcc flags rw-
    LOAD off    0x00000000 vaddr 0x1013e000 paddr 0x1013e000 align 2**12
         filesz 0x00000000 memsz 0x00002000 flags rw-
   STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**4
         filesz 0x00000000 memsz 0x00000000 flags rw-

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .share        00002000  1013e000  1013e000  0000d000  2**1
                  ALLOC
  1 .text         0000bb40  01000000  01000000  00001000  2**6
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  2 .data         00000000  10138000  10138000  0000cb40  2**0
                  CONTENTS, ALLOC, LOAD, DATA
  3 .bss          00000fcc  10138000  0100bb40  0000d000  2**6
                  ALLOC
  4 .debug_info   00026fbc  00000000  00000000  0000cb40  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  5 .debug_abbrev 000076a0  00000000  00000000  00033afc  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  6 .debug_loclists 0000b1e1  00000000  00000000  0003b19c  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  7 .debug_aranges 00001660  00000000  00000000  00046380  2**3
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  8 .debug_rnglists 0000202c  00000000  00000000  000479e0  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
  9 .debug_line   0001b03e  00000000  00000000  00049a0c  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
 10 .debug_str    0001175d  00000000  00000000  00064a4a  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
 11 .debug_line_str 00000fd5  00000000  00000000  000761a7  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
 12 .comment      0000004e  00000000  00000000  0007717c  2**0
                  CONTENTS, READONLY
 13 .riscv.attributes 000000eb  00000000  00000000  000771ca  2**0
                  CONTENTS, READONLY
 14 .debug_frame  0000400c  00000000  00000000  000772b8  2**2
                  CONTENTS, READONLY, DEBUGGING, OCTETS
SYMBOL TABLE:
1013e000 l    d  .share	00000000 .share
01000000 l    d  .text	00000000 .text
10138000 l    d  .data	00000000 .data
10138000 l    d  .bss	00000000 .bss
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
00000000 l    df *ABS*	00000000 reset_handler.c
00000000 l    df *ABS*	00000000 systick.c
10138000 l     O .bss	00000004 total_ticks
00000000 l    df *ABS*	00000000 int_call_asm.o
00000000 l    df *ABS*	00000000 cpu.c
00000000 l    df *ABS*	00000000 exception_entry.o
0100013a l       .text	00000000 int_call
0100014e l       .text	00000000 exception_exit
00000000 l    df *ABS*	00000000 delay_asm.o
00000000 l    df *ABS*	00000000 ls_msp_qspiv2.c
00000000 l    df *ABS*	00000000 ls_msp_uart.c
1013800c l     O .bss	00000008 UART_inst_env
00000000 l    df *ABS*	00000000 ls_msp_crc.c
00000000 l    df *ABS*	00000000 ls_msp_sm4.c
00000000 l    df *ABS*	00000000 ls_msp_crypt.c
00000000 l    df *ABS*	00000000 ls_msp_iwdg.c
00000000 l    df *ABS*	00000000 ls_msp_ltpi.c
00000000 l    df *ABS*	00000000 ls_msp_otbn.c
10138014 l     O .bss	00000004 EDN_URND_BUS_IN
00000000 l    df *ABS*	00000000 ls_msp_otp_ctrl.c
00000000 l    df *ABS*	00000000 ls_soc_gpio.c
010007ac l     F .text	0000001c uart_io_cfg
10138018 l     O .bss	00000001 uart1_rxd
10138019 l     O .bss	00000001 uart1_txd
00000000 l    df *ABS*	00000000 sys_stat.c
00000000 l    df *ABS*	00000000 platform.c
00000000 l    df *ABS*	00000000 ls_msp_cache.c
00000000 l    df *ABS*	00000000 ecc256_scalar_mult_text.c
00000000 l    df *ABS*	00000000 ecc384_ecdsa_verify_text.c
00000000 l    df *ABS*	00000000 sha256_text.c
00000000 l    df *ABS*	00000000 sha512_text.c
00000000 l    df *ABS*	00000000 sm3_text.c
00000000 l    df *ABS*	00000000 otbn_text.c
00000000 l    df *ABS*	00000000 ls_hal_otbn_sm2.c
00000000 l    df *ABS*	00000000 ls_hal_otbn_sm3.c
01003742 l     F .text	00000054 sm3_msg_write
10138348 l     O .bss	00000020 currnt_state
10138344 l     O .bss	00000004 totash_sm3_msg_total_len
10138340 l     O .bss	00000004 remain_len
01003aa8 l     O .text	00000020 state_init
10138300 l     O .bss	00000040 remain_data
00000000 l    df *ABS*	00000000 ls_hal_otbn_hash.c
01003ac8 l     F .text	0000001a get_hash_outLength
01003c6a l     O .text	00000004 CSWTCH.11
00000000 l    df *ABS*	00000000 ls_hal_otbn_sha256.c
01003c6e l     F .text	0000003c sha256_msg_write
101383b0 l     O .bss	00000004 index
101383ac l     O .bss	00000004 totasha256_hmac_cnt
101383a8 l     O .bss	00000004 remain_len
01003ff4 l     O .text	00000020 state_init
01003fd4 l     O .text	00000020 bswap32_mask
01003ed4 l     O .text	00000100 K
10138368 l     O .bss	00000040 remain_data
00000000 l    df *ABS*	00000000 ls_hal_otbn_sha384.c
01004014 l     F .text	00000096 SHA384_msg_write
1013843c l     O .bss	00000004 index
10138438 l     O .bss	00000004 total_cnt
10138434 l     O .bss	00000004 remain_len
01004570 l     O .text	00000100 state_init
010042f0 l     O .text	00000280 K
101383b4 l     O .bss	00000080 remain_data
00000000 l    df *ABS*	00000000 ls_hal_otbn_sha512.c
01004670 l     F .text	00000096 msg_write
101384c8 l     O .bss	00000004 index
101384c4 l     O .bss	00000004 total_cnt
101384c0 l     O .bss	00000004 remain_len
01004bc8 l     O .text	00000100 state_init
01004948 l     O .text	00000280 K
10138440 l     O .bss	00000080 remain_data
00000000 l    df *ABS*	00000000 ls_hal_otbn_ecc256.c
01004d94 l     O .text	000000e0 SM2
01004e74 l     O .text	000000e0 P256
00000000 l    df *ABS*	00000000 ls_hal_otbn_ecc384.c
01005008 l     O .text	00000140 P384
00000000 l    df *ABS*	00000000 ls_hal_flash_swint.c
0100515e l       .text	00000000 label_line54
01005196 l       .text	00000000 label_line59
010051ce l       .text	00000000 label_line64
01005206 l       .text	00000000 label_line69
0100523e l       .text	00000000 label_line74
00000000 l    df *ABS*	00000000 ls_hal_sm4.c
01005260 l     F .text	0000000e u8tou32
0100526e l     F .text	00000032 sm4_start
101384d4 l     O .bss	00000004 crypt_in
010052a0 l     F .text	000000b4 gmult
01005354 l     F .text	00000014 inc_ctr
01005368 l     F .text	00000036 sm4_data_length_inout_config
101384cc l     O .bss	00000001 writeflag
101384d0 l     O .bss	00000004 crypt_out
0100539e l     F .text	0000008e sm4_end
0100542c l     F .text	00000042 sm4_calculate
0100546e l     F .text	00000020 block_crypt
00000000 l    df *ABS*	00000000 ls_hal_crc.c
00000000 l    df *ABS*	00000000 ls_hal_crypt.c
01005ec0 l     F .text	00000012 get_uint32_t
01005ed2 l     F .text	0000001e set_uint32_t
01005ef0 l     F .text	00000016 crypt_in_out_length_set
101384f0 l     O .bss	00000004 current_in
101384ec l     O .bss	00000004 current_out
101384e8 l     O .bss	00000004 length_in
101384e4 l     O .bss	00000004 length_out
101384e0 l     O .bss	00000004 length_residue
01005f06 l     F .text	000000b4 gmult
01005fba l     F .text	00000014 inc_ctr
01005fce l     F .text	0000003a block_data_in
101384f4 l     O .bss	00000001 BLOCK_SIZE
01006008 l     F .text	00000194 crypt_start
101384dc l     O .bss	00000004 crypt_padding_mode
101384d8 l     O .bss	00000004 crypt_rand_func
0100619c l     F .text	00000044 block_data_out
010061e0 l     F .text	00000026 block_crypt
01006206 l     F .text	00000166 crypt_end
0100636c l     F .text	0000002e length_check.part.0
0100639a l     F .text	00000060 aes_enc_dec
00000000 l    df *ABS*	00000000 ls_hal_qspiv2.c
00000000 l    df *ABS*	00000000 ls_hal_flash_qspiv2.c
01006f38 l     F .text	0000005c hal_flash_read_loop.constprop.0
00000000 l    df *ABS*	00000000 ls_hal_flash.c
010072a4 l     F .text	00000002 xip_dummy
00000000 l    df *ABS*	00000000 ls_hal_cache.c
00000000 l    df *ABS*	00000000 ls_hal_uart.c
010074b0 l     F .text	00000012 uart_flag_poll
010074c2 l     F .text	0000001c UART_AutoBaudRate_Detect_Start.isra.0
00000000 l    df *ABS*	00000000 ls_hal_iwdgv2.c
00000000 l    df *ABS*	00000000 ls_hal_otbn.c
10138508 l     O .bss	00000004 callback_func
10138504 l     O .bss	00000004 callback_param
00000000 l    df *ABS*	00000000 ls_hal_otp_ctrl.c
01007fc0 l     F .text	00000014 otp_check_power_ready
01007fd4 l     F .text	0000009c otp_single_wirte
010081ce l     F .text	00000062 otp_block_write
00000000 l    df *ABS*	00000000 common.c
00000000 l    df *ABS*	00000000 log.c
01008294 l     F .text	0000001e uart_log_tx
010082c0 l     F .text	0000003a uart_log_init
010083dd l     O .text	00000001 linefeed_value
00000000 l    df *ABS*	00000000 mini-printf.c
010083de l     F .text	0000007c mini_pad
0100845a l     F .text	0000003e _puts
01008498 l     F .text	00000096 mini_itoa.part.0
00000000 l    df *ABS*	00000000 boot.c
010086c4 l     F .text	0000006a goto_uart
10138518 l     O .bss	00000004 uart_stage
0100872e l     F .text	0000010e boot_verify_flow
0100883c l     F .text	0000006c boot_nonsecure
010088a8 l     F .text	0000011a boot_decryptFlow
010089c2 l     F .text	00000034 ali_image_hash_generate
1013851c l     O .bss	00000001 uart_rx_offset
1013851d l     O .bss	00000001 uart_rx_byte
01008dc0 l     O .text	00000004 uart_rx_magic_word
01008dbc l     O .text	00000004 uart_tx_magic_word
00000000 l    df *ABS*	00000000 ali_boot.c
01008dc4 l     F .text	0000003c get_entry_number
01008e1a l     F .text	0000004e aliboot_ecdsa_hash
00000000 l    df *ABS*	00000000 uart_boot_parser.c
01009592 l     F .text	00000014 uart_read_word
010095a6 l     F .text	00000018 uart_read_byte
010095c4 l     F .text	00000018 uart_write_byte
010098de l     F .text	00000044 life_cycle_update
1013ff80 l     O .share	00000080 bitmap
01009b30 l     O .text	0000007c cmd_handler
00000000 l    df *ABS*	00000000 bsp.c
01009bac l     F .text	00000014 copy_reverse
01009bc0 l     F .text	00000044 ls_otbn_fireware_init
01009c04 l     F .text	00000020 arr_reverse.constprop.0
01009e0c l     F .text	00000024 open_dpll
0100b8c8 l     O .text	00000090 sm2_with_sm3_predata
10138f94 l     O .bss	00000034 uart_inst
0100b7d8 l     O .text	00000010 token_invaild.4
0100b7c8 l     O .text	00000010 token_zeros.3
1013f14e l     O .share	00000e32 otp_code
0100b998 l     O .text	00000020 test_key
0100b988 l     O .text	00000010 sm4_result
0100b968 l     O .text	00000020 sha_result
0100b958 l     O .text	00000010 aes_result
0100b808 l     O .text	00000040 g_pub_key
0100b848 l     O .text	00000020 g_random
10138f24 l     O .bss	00000070 ciphertext.2
0100b868 l     O .text	00000020 g_plaintext
0100b7e8 l     O .text	00000020 g_pri_key
10138f04 l     O .bss	00000020 plaintext_result.1
10138ec4 l     O .bss	00000040 sign.0
00000000 l    df *ABS*	00000000 libgcc2.c
00000000 l    df *ABS*	00000000 save-restore.o
00000000 l    df *ABS*	00000000 unaligned-libcall.c
00000000 l    df *ABS*	00000000 memcmp.c
00000000 l    df *ABS*	00000000 lib_a-memcpy-asm.o
00000000 l    df *ABS*	00000000 lib_a-memset.o
01007036 g     F .text	00000042 hal_flash_quad_page_program
0100b256 g     F .text	00000570 platform_init
01009c7e g     F .text	0000013e boot_hkdf
01005a2c g     F .text	00000226 HAL_SM4_GCM_Decrypt_Update
010036a0 g     F .text	000000a2 HAL_OTBN_SM2_ValidPoint_Polling_v2
01000810 g     F .text	00000022 per_func0_enable
010073cc g     F .text	00000018 hal_flash_write_in_process
0100a7b2 g     F .text	00000004 HAL_UART_TxCpltCallback
01007350 g     F .text	0000000e do_hal_flash_read_reg
01009994 g     F .text	00000032 flash_fast_read_handler
01007342 g     F .text	0000000e do_hal_flash_read
0100093e g     F .text	00000014 uart2_status_set
010095dc g     F .text	00000018 mem32_write_cmd_handler
010007ea g     F .text	00000026 per_func_disable
1013e000 g     O .share	0000114d shareMemory
0100741c g     F .text	0000000e do_hal_flash_program
10138800 g       .bss	00000000 __global_pointer$
0100a34e g     F .text	00000074 boot_flash_start_xip
0100b9ea g     F .text	00000028 .hidden __riscv_save_8
01007c30 g     F .text	0000021e HAL_UARTx_IRQHandler
0100548e g     F .text	0000000e HAL_SM4_Init
0100021a g     F .text	0000000e UART2_Handler
01004138 g     F .text	00000090 HAL_OTBN_SHA384_Update
01007246 g     F .text	0000004a hal_flash_read_security_area
010005fe g     F .text	0000003a io_cfg_input
01000422 g     F .text	00000016 HAL_MSP_LTPI_HPM_Init
101384f8 g     O .bss	00000004 hal_flash_xip_start_fn
0100a2ae g     F .text	0000003a boot_open_wdg
01007c2c  w    F .text	00000002 HAL_UART_RxToIdleCpltCallback
01009a38 g     F .text	00000038 flash_read_security_area_handler
01009672 g     F .text	00000022 flash_read_status_reg_1_handler
010003c8 g     F .text	00000044 HAL_IWDG_MSP_Init
0100ba36 g     F .text	0000000c .hidden __riscv_restore_3
010096ba g     F .text	00000038 flash_quad_page_program_handler
01007e84 g     F .text	00000004 HAL_OTBN_Init
01008d16 g     F .text	00000028 boot_uart_buaddetect_cb
01009a70 g     F .text	00000032 flash_dual_io_read_handler
01007e88 g     F .text	00000036 HAL_OTBN_IMEM_Write
0100ba22 g     F .text	00000020 .hidden __riscv_restore_10
010005c8 g     F .text	00000016 HAL_MSP_OTP_CTRL_Init
0100b9ea g     F .text	00000028 .hidden __riscv_save_11
01008d3e g     F .text	00000024 boot_uart_tx_cb
01007438 g     F .text	0000000e do_hal_flash_chip_erase
01007e6c g     F .text	00000018 HAL_IWDG_Init
0100b1ee g     F .text	00000068 lvds_process
01007290 g     F .text	00000014 hal_flash_software_reset
0100ba60 g     F .text	0000001c .hidden __thead_uwrite4
01007480 g     F .text	00000030 lscache_cache_enable
0100395c g     F .text	0000008e HAL_OTBN_SM3_KDF
010083cc g     O .text	00000011 hex_num_tab
010001e4 g     F .text	00000028 lsqspiv2_msp_init
01000952 g     F .text	0000000e rv_set_int_isr
01006fcc g     F .text	00000034 hal_flash_dual_xip_mode_enter
01000228 g     F .text	000000b6 HAL_UART_MSP_Init
01000382 g     F .text	00000044 HAL_LSCRYPT_MSP_Init
1013850c  w    O .bss	00000004 log_hex_output_fn
0100713c g     F .text	00000038 hal_flash_dual_io_read
01004706 g     F .text	0000008e HAL_OTBN_SHA512_Init
0100962e g     F .text	00000022 flash_chip_erase_cmd_handler
010095be g     F .text	00000006 uart_write
01009768 g     F .text	00000016 flash_erase_security_area_handler
0100a4f2 g     F .text	0000007a boot_sha384_flash
0100ba36 g     F .text	0000000c .hidden __riscv_restore_2
01009942 g     F .text	00000020 mem_bulk_read_cmd_handler
01002ac8 g     O .text	00000004 sm2_dmem_size
01005210 g     F .text	00000018 hal_flash_read_reg_operation
0100bb14 g     F .text	00000016 memcpy
01005d58 g     F .text	00000004 HAL_LSCRC_Init
10138ec0 g     O .bss	00000004 algo_select
01009612 g     F .text	0000001c program_go_cmd_handler
01003b0e g     F .text	00000032 HAL_OTBN_HASH_Update
010051d8 g     F .text	00000018 hal_flash_read_operation
0100a34a g     F .text	00000004 boot_otp_read
010099f8 g     F .text	00000020 flash_read_jedec_id_handler
01006f00 g     F .text	00000038 lsqspiv2_stg_write_register
01007bd8 g     F .text	00000054 HAL_UART_Receive_IT
01008d62 g     F .text	0000005a boot_uart_rx_cb
01000000 g       .text	00000000 __boot_rom_text_start__
0100b9e2 g     F .text	00000030 .hidden __riscv_save_12
0100092c g     F .text	00000012 uart1_status_set
010083b0 g     F .text	0000001c ls_log_init
010072a6 g     F .text	0000000e hal_flash_drv_var_init
0100add0 g     F .text	00000042 boot_set_otp_premission
01006580 g     F .text	000003ee HAL_LSCRYPT_AES_GCM_Decrypt
01007f9e g     F .text	0000000a HAL_OTBN_Checksum_Clear
01007310 g     F .text	00000032 hal_flash_sector_erase
0100ba22 g     F .text	00000020 .hidden __riscv_restore_11
0100a84e g     F .text	00000084 boot_sm4_kek_decrypt
01006eaa g     F .text	0000001c lsqspiv2_stg_send_command
01007100 g     F .text	00000004 do_hal_flash_read_func
0100a7b6 g     F .text	00000004 HAL_UART_RxCpltCallback
0100ba12 g     F .text	0000000c .hidden __riscv_save_1
01009c24 g     F .text	0000004e goto_next
0100550e g     F .text	00000024 HAL_SM4_Decrypt
0100737a g     F .text	0000001c hal_flash_read_status_register_0
010080a8 g     F .text	00000016 HAL_OTP_SET_RD_Addr
0100ba36 g     F .text	0000000c .hidden __riscv_restore_0
0100b9f8 g     F .text	0000001a .hidden __riscv_save_7
0100a140 g     F .text	000000c6 boot_sm2_sign
01000072 g     F .text	0000000a systick_get_value
010072ec g     F .text	00000024 hal_flash_write_status_register
01006ce0  w    F .text	00000002 HAL_LSCRYPT_DES_Complete_Callback
01005228 g     F .text	00000020 do_hal_flash_chip_erase_swint
01001f6a g     O .text	00000634 sha512_text
0100a42c g     F .text	00000010 boot_crc32
01007f32 g     F .text	0000003e HAL_OTBN_DMEM_Read
0100ba2c g     F .text	00000016 .hidden __riscv_restore_5
0100a478 g     F .text	0000007a boot_sha256_flash
10138000 g       .bss	00000000 __boot_rom_bss_start__
010000c8 g     F .text	00000006 SWINT_Handler_ASM
0100ba42 g     F .text	0000001e .hidden __thead_uread4
01008270 g     F .text	00000014 memcpy32
010070f8 g     F .text	00000008 do_hal_flash_chip_erase_func
01008336 g     F .text	0000007a log_hex_output
0100a56c g     F .text	0000006e boot_sm3_flash
010005de g     F .text	00000020 io_cfg_output
010059a4 g     F .text	00000088 HAL_SM4_GCM_Decrypt_Init
0100020e g     F .text	0000000c UART1_Handler
0100ba2c g     F .text	00000016 .hidden __riscv_restore_6
01006c46 g     F .text	0000009a HAL_LSCRYPT_AES_GCM_Decrypt_Final
01007fa8 g     F .text	00000018 HAL_OTBN_IRQHandler
01003b40 g     F .text	00000030 HAL_OTBN_HASH_Final
01007610 g     F .text	000000b4 HAL_UART_Receive
01003dc2 g     F .text	00000112 HAL_OTBN_SHA256_Final
01003ae2 g     F .text	0000002c HAL_OTBN_HASH_Init
0100b888 g     O .text	00000040 SM2_G
0100020c  w    F .text	00000002 LL_UART1_Handler
01007f70 g     F .text	00000022 HAL_OTBN_CMD_Write_Polling
01000000 g     F .text	00000072 Reset_Handler
01008284 g     F .text	00000010 memset32
10138fc8 g     O .bss	00000002 goto_next_mstatus
0100018c g     F .text	00000000 trap_handler
01000438 g     F .text	000000da HAL_OTBN_SYSC_IRQHandler
010091dc g     F .text	00000318 aliBoot_decryptFlow
0100a3c2 g     F .text	00000066 boot_flash_sm4_realtime_decrypt
01009af8 g     F .text	00000036 parser_loop
0100742a g     F .text	0000000e do_hal_flash_write_reg
01007ef8 g     F .text	0000003a HAL_OTBN_DMEM_Write
01008070 g     F .text	00000022 HAL_OTP_CTRL_Init
0100b9b8 g     F .text	0000002a .hidden __lshrdi3
01005602 g     F .text	000003a2 HAL_SM4_GCM_Decrypt
0100b9ea g     F .text	00000028 .hidden __riscv_save_9
1013801c g     O .bss	00000004 peri_stat
0100a8d2 g     F .text	0000009c boot_aes_ctr_decrypt
01005d5c g     F .text	00000024 HAL_LSCRC_Bit_Reverse
0100b9f8 g     F .text	0000001a .hidden __riscv_save_4
01006ec6 g     F .text	0000003a lsqspiv2_stg_read_register
0100a75a g     F .text	0000002a boot_uart_read
10138fcc g       .bss	00000000 end
010099c6 g     F .text	00000032 flash_read_sfdp_handler
01007174 g     F .text	00000038 hal_flash_read_24bit_addr_8bit_dummy
01009aea g     F .text	0000000e feature_disabled_rsp_send
01009650 g     F .text	00000022 flash_read_status_reg_0_handler
010096f2 g     F .text	00000038 flash_page_program_handler
0100a708 g     F .text	00000052 boot_uart_init
0100a784 g     F .text	0000002a boot_uart_write
01006d68 g     F .text	00000020 lsqspiv2_init
010041c8 g     F .text	00000122 HAL_OTBN_SHA384_Final
01005148 g     F .text	00000020 do_hal_flash_program_swint
01007006 g     F .text	0000001e hal_flash_xip_mode_reset
10138fcc g       .bss	00000000 __boot_rom_bss_end__
0100ba12 g     F .text	0000000c .hidden __riscv_save_3
01003b70 g     F .text	00000024 HAL_OTBN_HASH
01003b94 g     F .text	000000d6 HAL_OTBN_HASH_HMAC
01009dbc g     F .text	00000050 rom_delay
010094f4 g     F .text	00000098 aliBoot_nonsecure
01005532 g     F .text	000000d0 HAL_SM4_CTR_Crypt
10138000 g       .data	00000000 __boot_rom_data_end__
0100a698 g     F .text	00000070 boot_sm3_ecdsa
01008230 g     F .text	00000040 HAL_OTP_Write
0100a428 g     F .text	00000004 boot_flash_read
0100bb40 g       .text	00000000 __boot_rom_text_end__
01007028 g     F .text	0000000e do_hal_flash_write_reg_func
0100007c g     F .text	0000004c systick_poll_timeout
01006414 g     F .text	0000003e HAL_LSCRYPT_AES_Key_Config
0100696e g     F .text	00000096 HAL_LSCRYPT_AES_GCM_Decrypt_Init
01008e00 g     F .text	00000010 gm_algo_check
01009740 g     F .text	00000014 flash_deep_power_down_handler
101384fc g     O .bss	00000004 hal_flash_xip_stop_fn
01006d88 g     F .text	00000122 lsqspiv2_stg_read_write
010001c8 g     F .text	00000002 qspiv2_global_int_dummy
01006f98 g     F .text	00000034 hal_flash_quad_xip_mode_enter
010063fa g     F .text	00000012 HAL_LSCRYPT_Init
0100640c g     F .text	00000008 HAL_LSCRYPT_Block_Padding_Mode_Set
010026de g     O .text	000003e8 sm3_text
0100a96e g     F .text	000000bc boot_aes_gcm_decrypt
01005c52 g     F .text	0000009a HAL_SM4_GCM_Decrypt_Final
01007104 g     F .text	00000038 hal_flash_quad_io_read
010037ea g     F .text	000000a4 HAL_OTBN_SM3_Update
0100a04c g     F .text	000000f4 boot_sm2_decrypt
10138500 g     O .bss	00000002 flash_stat
0100baee g     F .text	00000026 memcmp
01009a18 g     F .text	00000020 flash_read_unique_id_handler
01004f54 g     F .text	000000b4 HAL_OTBN_ECC384_ECDSA_Verify_Polling
010097bc g     F .text	00000014 flash_software_reset_handler
0100735e g     F .text	0000001c hal_flash_read_id
0100098a g     O .text	00000758 ecc256_scalar_mult_text
010040aa g     F .text	0000008e HAL_OTBN_SHA384_Init
01005cee  w    F .text	00000002 HAL_SM4_KeyExpansion_Complete_Callback
01007532 g     F .text	000000de HAL_UART_Transmit
010070ba g     F .text	0000003e hal_flash_page_program
01009922 g     F .text	00000020 mem32_read_cmd_handler
10138000 g       .data	00000000 __boot_rom_data_start__
01007000 g     F .text	00000006 hal_flash_write_enable
01009e30 g     F .text	0000021c boot_sm2_encrypt
01002bc0 g     O .text	00000ae0 sm2_imem
0100987e g     F .text	0000002a flash_init_handler
0100b9ea g     F .text	00000028 .hidden __riscv_save_10
010097d0 g     F .text	00000076 mem32_write_multi_cmd_handler
010003c6 g     F .text	00000002 HAL_LSCRYPT_MSP_Busy_Set
01003796 g     F .text	00000054 HAL_OTBN_SM3_Init
0100549c g     F .text	00000032 sm4_key_start
0100ba2c g     F .text	00000016 .hidden __riscv_restore_4
0100ba22 g     F .text	00000020 .hidden __riscv_restore_8
010051f0 g     F .text	00000020 do_hal_flash_read_reg_swint
0100b9f8 g     F .text	0000001a .hidden __riscv_save_6
0100852e g     F .text	00000196 mini_vpprintf
010001ca g     F .text	0000001a qspiv2_global_int_ctrl_fn_init
010082fa g     F .text	0000003c log_output
01000914 g     F .text	00000018 pinmux_cjtag_deinit
0100bb2c g     F .text	00000010 memset
0100ba22 g     F .text	00000020 .hidden __riscv_restore_9
0100ba2c g     F .text	00000016 .hidden __riscv_restore_7
010089f6 g     F .text	00000320 main
010000d8 g     F .text	0000000a exit_critical
0100a43c g     F .text	0000003c boot_hash
010071b4 g     F .text	00000008 hal_flash_release_from_deep_power_down
010071ac g     F .text	00000008 hal_flash_deep_power_down
01000512 g     F .text	000000b6 HAL_LSOTBN_MSP_Init
0100085c g     F .text	00000040 pinmux_hal_flash_init
0100089c g     F .text	00000054 pinmux_hal_flash_quad_init
01009962 g     F .text	00000032 flash_quad_io_read_handler
01007396 g     F .text	0000001c hal_flash_read_status_register_1
010072b4 g     F .text	00000012 hal_flash_xip_func_ptr_dummy
010071bc g     F .text	0000000e do_hal_flash_read_reg_func
01007446 g     F .text	0000002c hal_flash_erase_security_area
01009ad8 g     F .text	00000012 unknown_cmd_handler
01008e92 g     F .text	0000034a aliBoot_verifyFlow
01008e68 g     F .text	0000002a algo_select_set
01007ebe g     F .text	0000003a HAL_OTBN_DMEM_Set
01007478 g     F .text	00000008 hal_flash_read_sfdp
10138040 g     O .bss	000002c0 interrupt_vector
010001c2 g     F .text	00000006 rv32_delay_asm
0100a7ae g     F .text	00000004 HAL_UART_BaudRateDetectCpltCallback
01002acc g     O .text	00000004 sm2_imem_size
0100aab6 g     F .text	000000a0 boot_sm4_gcm_decrypt
01000832 g     F .text	0000002a pinmux_uart1_init
01006484 g     F .text	000000fc HAL_LSCRYPT_AES_CTR_Crypt
01008e10 g     F .text	0000000a gj_algo_check
10138d20 g     O .bss	000001a0 otp_cfg
0100abea g     F .text	00000044 boot_life_cycle_update_request
01005168 g     F .text	00000018 hal_flash_program_operation
01007e4e g     F .text	0000001e HAL_UART_AutoBaudRate_Detect_IT
01004cc8 g     F .text	000000ca HAL_OTBN_ECC256_ScalarMult_Polling
010082b2 g     F .text	0000000e mini_puts
010008f0 g     F .text	00000024 pinmux_cjtag_init
0100033a g     F .text	00000048 HAL_LSSM4_MSP_Init
01007472 g     F .text	00000006 hal_flash_fast_read
10138510  w    O .bss	00000004 log_output_fn
010054ec g     F .text	00000022 HAL_SM4_Encrypt
1013e000 g       .bss	00000000 __StackTop
01009754 g     F .text	00000014 flash_release_from_deep_power_down
010095f4 g     F .text	0000001e mem_bulk_write_cmd_handler
010010e2 g     O .text	00000c6c ecc384_ecdsa_verify_text
0100bab8 g     F .text	00000036 .hidden __thead_uwrite8
0100bb40 g       .text	00000000 __boot_rom_data_lma__
01005eb0 g     O .text	00000010 CRC32_PARAM
010007c8 g     F .text	00000022 per_func_enable
0100040c g     F .text	00000016 HAL_MSP_LTPI_PHY_Init
10138008 g     O .bss	00000004 qspiv2_global_int_disable_fn
01009694 g     F .text	00000026 flash_write_status_reg_handler
01006a04 g     F .text	00000242 HAL_LSCRYPT_AES_GCM_Decrypt_Update
0100ad3a g     F .text	00000096 boot_life_cycle_check
0100ba12 g     F .text	0000000c .hidden __riscv_save_2
0100aa2a g     F .text	0000008c boot_sm4_ctr_decrypt
0100972a g     F .text	00000016 flash_sector_erase_handler
01006452 g     F .text	00000032 HAL_LSCRYPT_AES_ECB_Encrypt
01007024 g     F .text	00000004 do_hal_flash_prog_func
010073b2 g     F .text	0000001a hal_flash_read_status_register_0_ram
0100ac2e g     F .text	0000010c life_cycle_update
0100ba7c g     F .text	0000003c .hidden __thead_uread8
01000638 g     F .text	0000001c io_set_pin
01007f92 g     F .text	0000000c HAL_OTBN_Error_Bit_Get
010051a0 g     F .text	00000018 hal_flash_write_reg_operation
01004824 g     F .text	00000122 HAL_OTBN_SHA512_Final
01006ce2  w    F .text	00000002 HAL_LSCRYPT_AES_Complete_Callback
01003d32 g     F .text	00000090 HAL_OTBN_SHA256_Update
0100b9f8 g     F .text	0000001a .hidden __riscv_save_5
01009c72 g     F .text	0000000c clr_startup_part_flag
010072c6 g     F .text	00000020 flash_reading_critical
010080be g     F .text	00000110 HAL_OTP_Read
01005d80 g     F .text	0000012e HAL_LSCRC_CRC_CALC
01009846 g     F .text	00000038 flash_dual_page_program_handler
01005180 g     F .text	00000020 do_hal_flash_write_reg_swint
0100ab56 g     F .text	00000094 boot_ecc_verify
0100259e g     O .text	00000140 sm3_dmem
01000654 g     F .text	0000013a io_pull_write
010000ce g     F .text	0000000a enter_critical
0100ae12 g     F .text	0000007a boot_otp_code_check
010002de g     F .text	00000028 HAL_UART_MSP_Busy_Set
0100977e g     F .text	0000003e flash_program_security_area_handler
0100958c g     F .text	00000006 uart_read
10138520 g     O .bss	00000800 temp_buf
01000960 g     F .text	00000018 SWINT_Handler_C
010071ca g     F .text	0000003a hal_flash_read_unique_id
01008092 g     F .text	00000016 HAL_OTP_SET_WR_Addr
0100a5da g     F .text	000000be boot_sm3_ecdsa_flash
10138004 g     O .bss	00000004 qspiv2_global_int_restore_fn
010039ea g     F .text	000000be HAL_OTBN_SM3_HMAC
01006ce4 g     F .text	00000084 HAL_LSCRYPT_IRQHandler
01007204 g     F .text	00000042 hal_flash_program_security_area
01000978 g     F .text	00000012 lscache_msp_init
0100ba1e g     F .text	00000024 .hidden __riscv_restore_12
01007c2e  w    F .text	00000002 UART_Transmit_IT_DMA
01007078 g     F .text	00000042 hal_flash_dual_page_program
0100ba12 g     F .text	0000000c .hidden __riscv_save_0
01000328 g     F .text	00000012 HAL_LSCRC_MSP_Init
01009aa2 g     F .text	00000036 otp_read_handler
01005cf0 g     F .text	00000068 HAL_SM4_IRQHandler
0100a33a g     F .text	00000010 boot_io_read
0100a2e8 g     F .text	00000052 boot_flow_get
01001d4e g     O .text	0000021c sha256_text
010073e4 g     F .text	00000038 flash_writing_critical
0100ae8c g     F .text	00000362 lvds_cfg
01003caa g     F .text	00000088 HAL_OTBN_SHA256_Init
01000100 g     F .text	0000008c exception_entry
010074de g     F .text	00000054 HAL_UART_Init
01006f94 g     F .text	00000004 hal_flash_init
010098a8 g     F .text	00000036 otp_write_handler
01005cec  w    F .text	00000002 HAL_SM4_Calculation_Complete_Callback
10138514 g     O .bss	00000001 log_en
010072e6 g     F .text	00000006 hal_flash_chip_erase
0100ba36 g     F .text	0000000c .hidden __riscv_restore_1
0100a7ba g     F .text	00000094 boot_aes_kek_decrypt
010051b8 g     F .text	00000020 do_hal_flash_read_swint
01000306 g     F .text	00000022 LL_UART1_MSP_Init
01007b68 g     F .text	00000070 HAL_UART_Transmit_IT
010054ce g     F .text	0000001e HAL_SM4_KeyExpansion
0100a206 g     F .text	000000a8 boot_sm2_verify
01005248 g     F .text	00000018 hal_flash_chip_erase_operation
0100388e g     F .text	000000ce HAL_OTBN_SM3_Final
01004794 g     F .text	00000090 HAL_OTBN_SHA512_Update
01002ad0 g     O .text	000000f0 sm2_dmem



Disassembly of section .text:

01000000 <Reset_Handler>:
 1000000:	0f139197          	auipc	gp,0xf139
 1000004:	80018193          	addi	gp,gp,-2048 # 10138800 <__global_pointer$>
 1000008:	4002f7b7          	lui	a5,0x4002f
 100000c:	47fc                	lw	a5,76(a5)
 100000e:	c391                	beqz	a5,1000012 <Reset_Handler+0x12>
 1000010:	9782                	jalr	a5
 1000012:	010007b7          	lui	a5,0x1000
 1000016:	10078793          	addi	a5,a5,256 # 1000100 <exception_entry>
 100001a:	30579073          	csrw	mtvec,a5
 100001e:	101387b7          	lui	a5,0x10138
 1000022:	04078793          	addi	a5,a5,64 # 10138040 <interrupt_vector>
 1000026:	30779073          	csrw	mtvt,a5
 100002a:	1013e7b7          	lui	a5,0x1013e
 100002e:	00078793          	mv	a5,a5
 1000032:	813e                	mv	sp,a5
 1000034:	10138537          	lui	a0,0x10138
 1000038:	10138637          	lui	a2,0x10138
 100003c:	00050513          	mv	a0,a0
 1000040:	00060613          	mv	a2,a2
 1000044:	8e09                	sub	a2,a2,a0
 1000046:	0100c5b7          	lui	a1,0x100c
 100004a:	8609                	srai	a2,a2,0x2
 100004c:	b4058593          	addi	a1,a1,-1216 # 100bb40 <__boot_rom_data_lma__>
 1000050:	220080ef          	jal	1008270 <memcpy32>
 1000054:	10138537          	lui	a0,0x10138
 1000058:	10139637          	lui	a2,0x10139
 100005c:	00050513          	mv	a0,a0
 1000060:	fcc60613          	addi	a2,a2,-52 # 10138fcc <__boot_rom_bss_end__>
 1000064:	8e09                	sub	a2,a2,a0
 1000066:	8609                	srai	a2,a2,0x2
 1000068:	4581                	li	a1,0
 100006a:	21a080ef          	jal	1008284 <memset32>
 100006e:	189080ef          	jal	10089f6 <main>

01000072 <systick_get_value>:
 1000072:	101387b7          	lui	a5,0x10138
 1000076:	0007a503          	lw	a0,0(a5) # 10138000 <total_ticks>
 100007a:	8082                	ret

0100007c <systick_poll_timeout>:
 100007c:	715d                	addi	sp,sp,-80
 100007e:	d422                	sw	s0,40(sp)
 1000080:	d226                	sw	s1,36(sp)
 1000082:	d04a                	sw	s2,32(sp)
 1000084:	ce4e                	sw	s3,28(sp)
 1000086:	d606                	sw	ra,44(sp)
 1000088:	8432                	mv	s0,a2
 100008a:	de36                	sw	a3,60(sp)
 100008c:	c0ba                	sw	a4,64(sp)
 100008e:	c2be                	sw	a5,68(sp)
 1000090:	c4c2                	sw	a6,72(sp)
 1000092:	c6c6                	sw	a7,76(sp)
 1000094:	00b504b3          	add	s1,a0,a1
 1000098:	03c10913          	addi	s2,sp,60
 100009c:	101389b7          	lui	s3,0x10138
 10000a0:	ec11                	bnez	s0,10000bc <systick_poll_timeout+0x40>
 10000a2:	0009a783          	lw	a5,0(s3) # 10138000 <total_ticks>
 10000a6:	8f85                	sub	a5,a5,s1
 10000a8:	fe07cce3          	bltz	a5,10000a0 <systick_poll_timeout+0x24>
 10000ac:	4505                	li	a0,1
 10000ae:	50b2                	lw	ra,44(sp)
 10000b0:	5422                	lw	s0,40(sp)
 10000b2:	5492                	lw	s1,36(sp)
 10000b4:	5902                	lw	s2,32(sp)
 10000b6:	49f2                	lw	s3,28(sp)
 10000b8:	6161                	addi	sp,sp,80
 10000ba:	8082                	ret
 10000bc:	854a                	mv	a0,s2
 10000be:	c64a                	sw	s2,12(sp)
 10000c0:	9402                	jalr	s0
 10000c2:	d165                	beqz	a0,10000a2 <systick_poll_timeout+0x26>
 10000c4:	4501                	li	a0,0
 10000c6:	b7e5                	j	10000ae <systick_poll_timeout+0x32>

010000c8 <SWINT_Handler_ASM>:
 10000c8:	850a                	mv	a0,sp
 10000ca:	0970006f          	j	1000960 <SWINT_Handler_C>

010000ce <enter_critical>:
 10000ce:	30002573          	csrr	a0,mstatus
 10000d2:	30047073          	csrci	mstatus,8
 10000d6:	8082                	ret

010000d8 <exit_critical>:
 10000d8:	8921                	andi	a0,a0,8
 10000da:	c119                	beqz	a0,10000e0 <exit_critical+0x8>
 10000dc:	30046073          	csrsi	mstatus,8
 10000e0:	8082                	ret
 10000e2:	0000                	unimp
 10000e4:	0000                	unimp
 10000e6:	0000                	unimp
 10000e8:	0000                	unimp
 10000ea:	0000                	unimp
 10000ec:	0000                	unimp
 10000ee:	0000                	unimp
 10000f0:	0000                	unimp
 10000f2:	0000                	unimp
 10000f4:	0000                	unimp
 10000f6:	0000                	unimp
 10000f8:	0000                	unimp
 10000fa:	0000                	unimp
 10000fc:	0000                	unimp
 10000fe:	0000                	unimp

01000100 <exception_entry>:
 1000100:	fb410113          	addi	sp,sp,-76
 1000104:	de2a                	sw	a0,60(sp)
 1000106:	dc2e                	sw	a1,56(sp)
 1000108:	da32                	sw	a2,52(sp)
 100010a:	d836                	sw	a3,48(sp)
 100010c:	d63a                	sw	a4,44(sp)
 100010e:	d43e                	sw	a5,40(sp)
 1000110:	d242                	sw	a6,36(sp)
 1000112:	d046                	sw	a7,32(sp)
 1000114:	ce16                	sw	t0,28(sp)
 1000116:	cc1a                	sw	t1,24(sp)
 1000118:	ca1e                	sw	t2,20(sp)
 100011a:	c872                	sw	t3,16(sp)
 100011c:	c676                	sw	t4,12(sp)
 100011e:	c47a                	sw	t5,8(sp)
 1000120:	c27e                	sw	t6,4(sp)
 1000122:	c006                	sw	ra,0(sp)
 1000124:	341022f3          	csrr	t0,mepc
 1000128:	c496                	sw	t0,72(sp)
 100012a:	34202373          	csrr	t1,mcause
 100012e:	c29a                	sw	t1,68(sp)
 1000130:	300023f3          	csrr	t2,mstatus
 1000134:	c09e                	sw	t2,64(sp)
 1000136:	04604b63          	bgtz	t1,100018c <trap_handler>

0100013a <int_call>:
 100013a:	345462f3          	csrrsi	t0,mnxti,8
 100013e:	00028863          	beqz	t0,100014e <exception_exit>
 1000142:	0002a283          	lw	t0,0(t0)
 1000146:	9282                	jalr	t0
 1000148:	30047073          	csrci	mstatus,8
 100014c:	b7fd                	j	100013a <int_call>

0100014e <exception_exit>:
 100014e:	30047073          	csrci	mstatus,8
 1000152:	4082                	lw	ra,0(sp)
 1000154:	4f92                	lw	t6,4(sp)
 1000156:	4f22                	lw	t5,8(sp)
 1000158:	4eb2                	lw	t4,12(sp)
 100015a:	4e42                	lw	t3,16(sp)
 100015c:	43d2                	lw	t2,20(sp)
 100015e:	4362                	lw	t1,24(sp)
 1000160:	42f2                	lw	t0,28(sp)
 1000162:	5882                	lw	a7,32(sp)
 1000164:	5812                	lw	a6,36(sp)
 1000166:	57a2                	lw	a5,40(sp)
 1000168:	5732                	lw	a4,44(sp)
 100016a:	56c2                	lw	a3,48(sp)
 100016c:	5652                	lw	a2,52(sp)
 100016e:	55e2                	lw	a1,56(sp)
 1000170:	4506                	lw	a0,64(sp)
 1000172:	30051073          	csrw	mstatus,a0
 1000176:	4516                	lw	a0,68(sp)
 1000178:	34251073          	csrw	mcause,a0
 100017c:	4526                	lw	a0,72(sp)
 100017e:	34151073          	csrw	mepc,a0
 1000182:	5572                	lw	a0,60(sp)
 1000184:	04c10113          	addi	sp,sp,76
 1000188:	30200073          	mret

0100018c <trap_handler>:
 100018c:	a001                	j	100018c <trap_handler>
 100018e:	0000                	unimp
 1000190:	0000                	unimp
 1000192:	0000                	unimp
 1000194:	0000                	unimp
 1000196:	0000                	unimp
 1000198:	0000                	unimp
 100019a:	0000                	unimp
 100019c:	0000                	unimp
 100019e:	0000                	unimp
 10001a0:	0000                	unimp
 10001a2:	0000                	unimp
 10001a4:	0000                	unimp
 10001a6:	0000                	unimp
 10001a8:	0000                	unimp
 10001aa:	0000                	unimp
 10001ac:	0000                	unimp
 10001ae:	0000                	unimp
 10001b0:	0000                	unimp
 10001b2:	0000                	unimp
 10001b4:	0000                	unimp
 10001b6:	0000                	unimp
 10001b8:	0000                	unimp
 10001ba:	0000                	unimp
 10001bc:	0000                	unimp
 10001be:	0000                	unimp
 10001c0:	0000                	unimp

010001c2 <rv32_delay_asm>:
 10001c2:	8d0d                	sub	a0,a0,a1
 10001c4:	fd7d                	bnez	a0,10001c2 <rv32_delay_asm>
 10001c6:	8082                	ret

010001c8 <qspiv2_global_int_dummy>:
 10001c8:	8082                	ret

010001ca <qspiv2_global_int_ctrl_fn_init>:
 10001ca:	010007b7          	lui	a5,0x1000
 10001ce:	1c878793          	addi	a5,a5,456 # 10001c8 <qspiv2_global_int_dummy>
 10001d2:	10138737          	lui	a4,0x10138
 10001d6:	00f72423          	sw	a5,8(a4) # 10138008 <qspiv2_global_int_disable_fn>
 10001da:	10138737          	lui	a4,0x10138
 10001de:	00f72223          	sw	a5,4(a4) # 10138004 <qspiv2_global_int_restore_fn>
 10001e2:	8082                	ret

010001e4 <lsqspiv2_msp_init>:
 10001e4:	400227b7          	lui	a5,0x40022
 10001e8:	04000713          	li	a4,64
 10001ec:	cb98                	sw	a4,16(a5)
 10001ee:	0001                	nop
 10001f0:	0001                	nop
 10001f2:	08000693          	li	a3,128
 10001f6:	cb94                	sw	a3,16(a5)
 10001f8:	0001                	nop
 10001fa:	0001                	nop
 10001fc:	cf94                	sw	a3,24(a5)
 10001fe:	0001                	nop
 1000200:	0001                	nop
 1000202:	cf98                	sw	a4,24(a5)
 1000204:	0001                	nop
 1000206:	0001                	nop
 1000208:	cb98                	sw	a4,16(a5)
 100020a:	b7c1                	j	10001ca <qspiv2_global_int_ctrl_fn_init>

0100020c <LL_UART1_Handler>:
 100020c:	8082                	ret

0100020e <UART1_Handler>:
 100020e:	101387b7          	lui	a5,0x10138
 1000212:	00c7a503          	lw	a0,12(a5) # 1013800c <UART_inst_env>
 1000216:	21b0706f          	j	1007c30 <HAL_UARTx_IRQHandler>

0100021a <UART2_Handler>:
 100021a:	101387b7          	lui	a5,0x10138
 100021e:	00c78793          	addi	a5,a5,12 # 1013800c <UART_inst_env>
 1000222:	43c8                	lw	a0,4(a5)
 1000224:	20d0706f          	j	1007c30 <HAL_UARTx_IRQHandler>

01000228 <HAL_UART_MSP_Init>:
 1000228:	7ea0b2ef          	jal	t0,100ba12 <__riscv_save_0>
 100022c:	4118                	lw	a4,0(a0)
 100022e:	400877b7          	lui	a5,0x40087
 1000232:	40078793          	addi	a5,a5,1024 # 40087400 <bitmap+0x2ff47480>
 1000236:	842a                	mv	s0,a0
 1000238:	04f70d63          	beq	a4,a5,1000292 <HAL_UART_MSP_Init+0x6a>
 100023c:	400a17b7          	lui	a5,0x400a1
 1000240:	04f71763          	bne	a4,a5,100028e <HAL_UART_MSP_Init+0x66>
 1000244:	400a87b7          	lui	a5,0x400a8
 1000248:	c0078793          	addi	a5,a5,-1024 # 400a7c00 <bitmap+0x2ff67c80>
 100024c:	20000713          	li	a4,512
 1000250:	c398                	sw	a4,0(a5)
 1000252:	cb98                	sw	a4,16(a5)
 1000254:	10000713          	li	a4,256
 1000258:	cb98                	sw	a4,16(a5)
 100025a:	010005b7          	lui	a1,0x1000
 100025e:	c398                	sw	a4,0(a5)
 1000260:	20e58593          	addi	a1,a1,526 # 100020e <UART1_Handler>
 1000264:	07e00513          	li	a0,126
 1000268:	25ed                	jal	1000952 <rv_set_int_isr>
 100026a:	e08017b7          	lui	a5,0xe0801
 100026e:	1f87c703          	lbu	a4,504(a5) # e08011f8 <bitmap+0xd06c1278>
 1000272:	0fe77713          	andi	a4,a4,254
 1000276:	1ee78c23          	sb	a4,504(a5)
 100027a:	1f97c703          	lbu	a4,505(a5)
 100027e:	00176713          	ori	a4,a4,1
 1000282:	1ee78ca3          	sb	a4,505(a5)
 1000286:	101387b7          	lui	a5,0x10138
 100028a:	0087a623          	sw	s0,12(a5) # 1013800c <UART_inst_env>
 100028e:	7a80b06f          	j	100ba36 <__riscv_restore_0>
 1000292:	400907b7          	lui	a5,0x40090
 1000296:	c0078793          	addi	a5,a5,-1024 # 4008fc00 <bitmap+0x2ff4fc80>
 100029a:	00080737          	lui	a4,0x80
 100029e:	c3d8                	sw	a4,4(a5)
 10002a0:	cbd8                	sw	a4,20(a5)
 10002a2:	00040737          	lui	a4,0x40
 10002a6:	cbd8                	sw	a4,20(a5)
 10002a8:	010005b7          	lui	a1,0x1000
 10002ac:	c3d8                	sw	a4,4(a5)
 10002ae:	21a58593          	addi	a1,a1,538 # 100021a <UART2_Handler>
 10002b2:	07f00513          	li	a0,127
 10002b6:	2d71                	jal	1000952 <rv_set_int_isr>
 10002b8:	e08017b7          	lui	a5,0xe0801
 10002bc:	1fc7c703          	lbu	a4,508(a5) # e08011fc <bitmap+0xd06c127c>
 10002c0:	0fe77713          	andi	a4,a4,254
 10002c4:	1ee78e23          	sb	a4,508(a5)
 10002c8:	1fd7c703          	lbu	a4,509(a5)
 10002cc:	00176713          	ori	a4,a4,1
 10002d0:	1ee78ea3          	sb	a4,509(a5)
 10002d4:	101387b7          	lui	a5,0x10138
 10002d8:	0087a823          	sw	s0,16(a5) # 10138010 <UART_inst_env+0x4>
 10002dc:	bf4d                	j	100028e <HAL_UART_MSP_Init+0x66>

010002de <HAL_UART_MSP_Busy_Set>:
 10002de:	7340b2ef          	jal	t0,100ba12 <__riscv_save_0>
 10002e2:	4118                	lw	a4,0(a0)
 10002e4:	400877b7          	lui	a5,0x40087
 10002e8:	40078793          	addi	a5,a5,1024 # 40087400 <bitmap+0x2ff47480>
 10002ec:	00f70a63          	beq	a4,a5,1000300 <HAL_UART_MSP_Busy_Set+0x22>
 10002f0:	400a17b7          	lui	a5,0x400a1
 10002f4:	00f71463          	bne	a4,a5,10002fc <HAL_UART_MSP_Busy_Set+0x1e>
 10002f8:	4505                	li	a0,1
 10002fa:	2d0d                	jal	100092c <uart1_status_set>
 10002fc:	73a0b06f          	j	100ba36 <__riscv_restore_0>
 1000300:	4505                	li	a0,1
 1000302:	2d35                	jal	100093e <uart2_status_set>
 1000304:	bfe5                	j	10002fc <HAL_UART_MSP_Busy_Set+0x1e>

01000306 <LL_UART1_MSP_Init>:
 1000306:	70c0b2ef          	jal	t0,100ba12 <__riscv_save_0>
 100030a:	010005b7          	lui	a1,0x1000
 100030e:	20c58593          	addi	a1,a1,524 # 100020c <LL_UART1_Handler>
 1000312:	07e00513          	li	a0,126
 1000316:	2d35                	jal	1000952 <rv_set_int_isr>
 1000318:	400a87b7          	lui	a5,0x400a8
 100031c:	10000713          	li	a4,256
 1000320:	c0e7a023          	sw	a4,-1024(a5) # 400a7c00 <bitmap+0x2ff67c80>
 1000324:	7120b06f          	j	100ba36 <__riscv_restore_0>

01000328 <HAL_LSCRC_MSP_Init>:
 1000328:	400227b7          	lui	a5,0x40022
 100032c:	4709                	li	a4,2
 100032e:	cbd8                	sw	a4,20(a5)
 1000330:	cfd8                	sw	a4,28(a5)
 1000332:	4705                	li	a4,1
 1000334:	cfd8                	sw	a4,28(a5)
 1000336:	cbd8                	sw	a4,20(a5)
 1000338:	8082                	ret

0100033a <HAL_LSSM4_MSP_Init>:
 100033a:	6d80b2ef          	jal	t0,100ba12 <__riscv_save_0>
 100033e:	6705                	lui	a4,0x1
 1000340:	400227b7          	lui	a5,0x40022
 1000344:	80070713          	addi	a4,a4,-2048 # 800 <Reset_Handler-0xfff800>
 1000348:	cbd8                	sw	a4,20(a5)
 100034a:	cfd8                	sw	a4,28(a5)
 100034c:	40000713          	li	a4,1024
 1000350:	cfd8                	sw	a4,28(a5)
 1000352:	010065b7          	lui	a1,0x1006
 1000356:	cbd8                	sw	a4,20(a5)
 1000358:	cf058593          	addi	a1,a1,-784 # 1005cf0 <HAL_SM4_IRQHandler>
 100035c:	03400513          	li	a0,52
 1000360:	2bcd                	jal	1000952 <rv_set_int_isr>
 1000362:	e08017b7          	lui	a5,0xe0801
 1000366:	0d07c703          	lbu	a4,208(a5) # e08010d0 <bitmap+0xd06c1150>
 100036a:	0fe77713          	andi	a4,a4,254
 100036e:	0ce78823          	sb	a4,208(a5)
 1000372:	0d17c703          	lbu	a4,209(a5)
 1000376:	00176713          	ori	a4,a4,1
 100037a:	0ce788a3          	sb	a4,209(a5)
 100037e:	6b80b06f          	j	100ba36 <__riscv_restore_0>

01000382 <HAL_LSCRYPT_MSP_Init>:
 1000382:	6900b2ef          	jal	t0,100ba12 <__riscv_save_0>
 1000386:	400227b7          	lui	a5,0x40022
 100038a:	02000713          	li	a4,32
 100038e:	cbd8                	sw	a4,20(a5)
 1000390:	cfd8                	sw	a4,28(a5)
 1000392:	4741                	li	a4,16
 1000394:	cfd8                	sw	a4,28(a5)
 1000396:	010075b7          	lui	a1,0x1007
 100039a:	cbd8                	sw	a4,20(a5)
 100039c:	ce458593          	addi	a1,a1,-796 # 1006ce4 <HAL_LSCRYPT_IRQHandler>
 10003a0:	03200513          	li	a0,50
 10003a4:	237d                	jal	1000952 <rv_set_int_isr>
 10003a6:	e08017b7          	lui	a5,0xe0801
 10003aa:	0c87c703          	lbu	a4,200(a5) # e08010c8 <bitmap+0xd06c1148>
 10003ae:	0fe77713          	andi	a4,a4,254
 10003b2:	0ce78423          	sb	a4,200(a5)
 10003b6:	0c97c703          	lbu	a4,201(a5)
 10003ba:	00176713          	ori	a4,a4,1
 10003be:	0ce784a3          	sb	a4,201(a5)
 10003c2:	6740b06f          	j	100ba36 <__riscv_restore_0>

010003c6 <HAL_LSCRYPT_MSP_Busy_Set>:
 10003c6:	8082                	ret

010003c8 <HAL_IWDG_MSP_Init>:
 10003c8:	400997b7          	lui	a5,0x40099
 10003cc:	02f50363          	beq	a0,a5,10003f2 <HAL_IWDG_MSP_Init+0x2a>
 10003d0:	400a27b7          	lui	a5,0x400a2
 10003d4:	80078793          	addi	a5,a5,-2048 # 400a1800 <bitmap+0x2ff61880>
 10003d8:	02f51963          	bne	a0,a5,100040a <HAL_IWDG_MSP_Init+0x42>
 10003dc:	400a87b7          	lui	a5,0x400a8
 10003e0:	c0078793          	addi	a5,a5,-1024 # 400a7c00 <bitmap+0x2ff67c80>
 10003e4:	6709                	lui	a4,0x2
 10003e6:	c398                	sw	a4,0(a5)
 10003e8:	cb98                	sw	a4,16(a5)
 10003ea:	6705                	lui	a4,0x1
 10003ec:	cb98                	sw	a4,16(a5)
 10003ee:	c398                	sw	a4,0(a5)
 10003f0:	8082                	ret
 10003f2:	400907b7          	lui	a5,0x40090
 10003f6:	c0078793          	addi	a5,a5,-1024 # 4008fc00 <bitmap+0x2ff4fc80>
 10003fa:	80000737          	lui	a4,0x80000
 10003fe:	c798                	sw	a4,8(a5)
 1000400:	cf98                	sw	a4,24(a5)
 1000402:	40000737          	lui	a4,0x40000
 1000406:	cf98                	sw	a4,24(a5)
 1000408:	c798                	sw	a4,8(a5)
 100040a:	8082                	ret

0100040c <HAL_MSP_LTPI_PHY_Init>:
 100040c:	400627b7          	lui	a5,0x40062
 1000410:	20000737          	lui	a4,0x20000
 1000414:	cbd8                	sw	a4,20(a5)
 1000416:	cfd8                	sw	a4,28(a5)
 1000418:	10000737          	lui	a4,0x10000
 100041c:	cfd8                	sw	a4,28(a5)
 100041e:	cbd8                	sw	a4,20(a5)
 1000420:	8082                	ret

01000422 <HAL_MSP_LTPI_HPM_Init>:
 1000422:	400627b7          	lui	a5,0x40062
 1000426:	08000737          	lui	a4,0x8000
 100042a:	cbd8                	sw	a4,20(a5)
 100042c:	cfd8                	sw	a4,28(a5)
 100042e:	04000737          	lui	a4,0x4000
 1000432:	cfd8                	sw	a4,28(a5)
 1000434:	cbd8                	sw	a4,20(a5)
 1000436:	8082                	ret

01000438 <HAL_OTBN_SYSC_IRQHandler>:
 1000438:	40022737          	lui	a4,0x40022
 100043c:	573c                	lw	a5,104(a4)
 100043e:	0017f693          	andi	a3,a5,1
 1000442:	c299                	beqz	a3,1000448 <HAL_OTBN_SYSC_IRQHandler+0x10>
 1000444:	4685                	li	a3,1
 1000446:	d374                	sw	a3,100(a4)
 1000448:	0027f713          	andi	a4,a5,2
 100044c:	c709                	beqz	a4,1000456 <HAL_OTBN_SYSC_IRQHandler+0x1e>
 100044e:	40022737          	lui	a4,0x40022
 1000452:	4689                	li	a3,2
 1000454:	d374                	sw	a3,100(a4)
 1000456:	0047f713          	andi	a4,a5,4
 100045a:	c709                	beqz	a4,1000464 <HAL_OTBN_SYSC_IRQHandler+0x2c>
 100045c:	40022737          	lui	a4,0x40022
 1000460:	4691                	li	a3,4
 1000462:	d374                	sw	a3,100(a4)
 1000464:	0087f713          	andi	a4,a5,8
 1000468:	c709                	beqz	a4,1000472 <HAL_OTBN_SYSC_IRQHandler+0x3a>
 100046a:	40022737          	lui	a4,0x40022
 100046e:	46a1                	li	a3,8
 1000470:	d374                	sw	a3,100(a4)
 1000472:	0f07f713          	andi	a4,a5,240
 1000476:	c711                	beqz	a4,1000482 <HAL_OTBN_SYSC_IRQHandler+0x4a>
 1000478:	40022737          	lui	a4,0x40022
 100047c:	0f000693          	li	a3,240
 1000480:	d374                	sw	a3,100(a4)
 1000482:	1007f713          	andi	a4,a5,256
 1000486:	c315                	beqz	a4,10004aa <HAL_OTBN_SYSC_IRQHandler+0x72>
 1000488:	10138737          	lui	a4,0x10138
 100048c:	01472683          	lw	a3,20(a4) # 10138014 <EDN_URND_BUS_IN>
 1000490:	0685                	addi	a3,a3,1
 1000492:	00d72a23          	sw	a3,20(a4)
 1000496:	40022737          	lui	a4,0x40022
 100049a:	df34                	sw	a3,120(a4)
 100049c:	5b74                	lw	a3,116(a4)
 100049e:	1006e693          	ori	a3,a3,256
 10004a2:	db74                	sw	a3,116(a4)
 10004a4:	10000693          	li	a3,256
 10004a8:	d374                	sw	a3,100(a4)
 10004aa:	2007f713          	andi	a4,a5,512
 10004ae:	c315                	beqz	a4,10004d2 <HAL_OTBN_SYSC_IRQHandler+0x9a>
 10004b0:	10138737          	lui	a4,0x10138
 10004b4:	01472683          	lw	a3,20(a4) # 10138014 <EDN_URND_BUS_IN>
 10004b8:	0685                	addi	a3,a3,1
 10004ba:	00d72a23          	sw	a3,20(a4)
 10004be:	40022737          	lui	a4,0x40022
 10004c2:	df74                	sw	a3,124(a4)
 10004c4:	5b74                	lw	a3,116(a4)
 10004c6:	4006e693          	ori	a3,a3,1024
 10004ca:	db74                	sw	a3,116(a4)
 10004cc:	20000693          	li	a3,512
 10004d0:	d374                	sw	a3,100(a4)
 10004d2:	4007f793          	andi	a5,a5,1024
 10004d6:	cf8d                	beqz	a5,1000510 <HAL_OTBN_SYSC_IRQHandler+0xd8>
 10004d8:	10138637          	lui	a2,0x10138
 10004dc:	01462783          	lw	a5,20(a2) # 10138014 <EDN_URND_BUS_IN>
 10004e0:	400226b7          	lui	a3,0x40022
 10004e4:	08068713          	addi	a4,a3,128 # 40022080 <bitmap+0x2fee2100>
 10004e8:	00178593          	addi	a1,a5,1 # 40062001 <bitmap+0x2ff22081>
 10004ec:	c70c                	sw	a1,8(a4)
 10004ee:	00278593          	addi	a1,a5,2
 10004f2:	c74c                	sw	a1,12(a4)
 10004f4:	00378593          	addi	a1,a5,3
 10004f8:	cb0c                	sw	a1,16(a4)
 10004fa:	0791                	addi	a5,a5,4
 10004fc:	00f62a23          	sw	a5,20(a2)
 1000500:	cb5c                	sw	a5,20(a4)
 1000502:	5afc                	lw	a5,116(a3)
 1000504:	6705                	lui	a4,0x1
 1000506:	8fd9                	or	a5,a5,a4
 1000508:	dafc                	sw	a5,116(a3)
 100050a:	40000793          	li	a5,1024
 100050e:	d2fc                	sw	a5,100(a3)
 1000510:	8082                	ret

01000512 <HAL_LSOTBN_MSP_Init>:
 1000512:	5000b2ef          	jal	t0,100ba12 <__riscv_save_0>
 1000516:	400227b7          	lui	a5,0x40022
 100051a:	53b8                	lw	a4,96(a5)
 100051c:	101385b7          	lui	a1,0x10138
 1000520:	20000813          	li	a6,512
 1000524:	dff77713          	andi	a4,a4,-513
 1000528:	d3b8                	sw	a4,96(a5)
 100052a:	6709                	lui	a4,0x2
 100052c:	cbd8                	sw	a4,20(a5)
 100052e:	cfd8                	sw	a4,28(a5)
 1000530:	6705                	lui	a4,0x1
 1000532:	cfd8                	sw	a4,28(a5)
 1000534:	cbd8                	sw	a4,20(a5)
 1000536:	0145a703          	lw	a4,20(a1) # 10138014 <EDN_URND_BUS_IN>
 100053a:	00170693          	addi	a3,a4,1 # 1001 <Reset_Handler-0xffefff>
 100053e:	01170513          	addi	a0,a4,17
 1000542:	57f0                	lw	a2,108(a5)
 1000544:	20067613          	andi	a2,a2,512
 1000548:	de6d                	beqz	a2,1000542 <HAL_LSOTBN_MSP_Init+0x30>
 100054a:	dff4                	sw	a3,124(a5)
 100054c:	5bf0                	lw	a2,116(a5)
 100054e:	0685                	addi	a3,a3,1
 1000550:	40066613          	ori	a2,a2,1024
 1000554:	dbf0                	sw	a2,116(a5)
 1000556:	5bf0                	lw	a2,116(a5)
 1000558:	bff67613          	andi	a2,a2,-1025
 100055c:	dbf0                	sw	a2,116(a5)
 100055e:	0707a223          	sw	a6,100(a5) # 40022064 <bitmap+0x2fee20e4>
 1000562:	fea690e3          	bne	a3,a0,1000542 <HAL_LSOTBN_MSP_Init+0x30>
 1000566:	0741                	addi	a4,a4,16
 1000568:	00e5aa23          	sw	a4,20(a1)
 100056c:	70000713          	li	a4,1792
 1000570:	d3f8                	sw	a4,100(a5)
 1000572:	010085b7          	lui	a1,0x1008
 1000576:	d3b8                	sw	a4,96(a5)
 1000578:	fa858593          	addi	a1,a1,-88 # 1007fa8 <HAL_OTBN_IRQHandler>
 100057c:	03600513          	li	a0,54
 1000580:	e0801437          	lui	s0,0xe0801
 1000584:	26f9                	jal	1000952 <rv_set_int_isr>
 1000586:	0d844783          	lbu	a5,216(s0) # e08010d8 <bitmap+0xd06c1158>
 100058a:	010005b7          	lui	a1,0x1000
 100058e:	43858593          	addi	a1,a1,1080 # 1000438 <HAL_OTBN_SYSC_IRQHandler>
 1000592:	0fe7f793          	andi	a5,a5,254
 1000596:	0cf40c23          	sb	a5,216(s0)
 100059a:	0d944783          	lbu	a5,217(s0)
 100059e:	03700513          	li	a0,55
 10005a2:	0017e793          	ori	a5,a5,1
 10005a6:	0cf40ca3          	sb	a5,217(s0)
 10005aa:	2665                	jal	1000952 <rv_set_int_isr>
 10005ac:	0dc44783          	lbu	a5,220(s0)
 10005b0:	0fe7f793          	andi	a5,a5,254
 10005b4:	0cf40e23          	sb	a5,220(s0)
 10005b8:	0dd44783          	lbu	a5,221(s0)
 10005bc:	0017e793          	ori	a5,a5,1
 10005c0:	0cf40ea3          	sb	a5,221(s0)
 10005c4:	4720b06f          	j	100ba36 <__riscv_restore_0>

010005c8 <HAL_MSP_OTP_CTRL_Init>:
 10005c8:	400227b7          	lui	a5,0x40022
 10005cc:	08000713          	li	a4,128
 10005d0:	cbd8                	sw	a4,20(a5)
 10005d2:	cfd8                	sw	a4,28(a5)
 10005d4:	04000713          	li	a4,64
 10005d8:	cfd8                	sw	a4,28(a5)
 10005da:	cbd8                	sw	a4,20(a5)
 10005dc:	8082                	ret

010005de <io_cfg_output>:
 10005de:	00455713          	srli	a4,a0,0x4
 10005e2:	4006f7b7          	lui	a5,0x4006f
 10005e6:	06e7970b          	th.addsl	a4,a5,a4,3
 10005ea:	36072683          	lw	a3,864(a4)
 10005ee:	893d                	andi	a0,a0,15
 10005f0:	67c1                	lui	a5,0x10
 10005f2:	00a797b3          	sll	a5,a5,a0
 10005f6:	8fd5                	or	a5,a5,a3
 10005f8:	36f72023          	sw	a5,864(a4)
 10005fc:	8082                	ret

010005fe <io_cfg_input>:
 10005fe:	00455793          	srli	a5,a0,0x4
 1000602:	4006f5b7          	lui	a1,0x4006f
 1000606:	06f5980b          	th.addsl	a6,a1,a5,3
 100060a:	36082603          	lw	a2,864(a6)
 100060e:	893d                	andi	a0,a0,15
 1000610:	4705                	li	a4,1
 1000612:	00a71733          	sll	a4,a4,a0
 1000616:	fff74693          	not	a3,a4
 100061a:	0796                	slli	a5,a5,0x5
 100061c:	8e75                	and	a2,a2,a3
 100061e:	97ae                	add	a5,a5,a1
 1000620:	36c82023          	sw	a2,864(a6)
 1000624:	18078793          	addi	a5,a5,384 # 10180 <Reset_Handler-0xfefe80>
 1000628:	47d0                	lw	a2,12(a5)
 100062a:	0742                	slli	a4,a4,0x10
 100062c:	8ef1                	and	a3,a3,a2
 100062e:	c7d4                	sw	a3,12(a5)
 1000630:	47d4                	lw	a3,12(a5)
 1000632:	8f55                	or	a4,a4,a3
 1000634:	c7d8                	sw	a4,12(a5)
 1000636:	8082                	ret

01000638 <io_set_pin>:
 1000638:	00455793          	srli	a5,a0,0x4
 100063c:	4705                	li	a4,1
 100063e:	893d                	andi	a0,a0,15
 1000640:	06c78793          	addi	a5,a5,108
 1000644:	4006f6b7          	lui	a3,0x4006f
 1000648:	00a71733          	sll	a4,a4,a0
 100064c:	06f6978b          	th.addsl	a5,a3,a5,3
 1000650:	c3d8                	sw	a4,4(a5)
 1000652:	8082                	ret

01000654 <io_pull_write>:
 1000654:	4799                	li	a5,6
 1000656:	06b7eb63          	bltu	a5,a1,10006cc <io_pull_write+0x78>
 100065a:	010007b7          	lui	a5,0x1000
 100065e:	79078793          	addi	a5,a5,1936 # 1000790 <io_pull_write+0x13c>
 1000662:	44b7c68b          	th.lrw	a3,a5,a1,2
 1000666:	00f57793          	andi	a5,a0,15
 100066a:	8111                	srli	a0,a0,0x4
 100066c:	4006f737          	lui	a4,0x4006f
 1000670:	0516                	slli	a0,a0,0x5
 1000672:	953a                	add	a0,a0,a4
 1000674:	18050513          	addi	a0,a0,384 # 10138180 <interrupt_vector+0x140>
 1000678:	8682                	jr	a3
 100067a:	4154                	lw	a3,4(a0)
 100067c:	4705                	li	a4,1
 100067e:	00f717b3          	sll	a5,a4,a5
 1000682:	fff7c713          	not	a4,a5
 1000686:	8ef9                	and	a3,a3,a4
 1000688:	c154                	sw	a3,4(a0)
 100068a:	4154                	lw	a3,4(a0)
 100068c:	07c2                	slli	a5,a5,0x10
 100068e:	fff7c793          	not	a5,a5
 1000692:	8efd                	and	a3,a3,a5
 1000694:	c154                	sw	a3,4(a0)
 1000696:	4514                	lw	a3,8(a0)
 1000698:	8f75                	and	a4,a4,a3
 100069a:	c518                	sw	a4,8(a0)
 100069c:	4518                	lw	a4,8(a0)
 100069e:	8ff9                	and	a5,a5,a4
 10006a0:	c51c                	sw	a5,8(a0)
 10006a2:	8082                	ret
 10006a4:	4154                	lw	a3,4(a0)
 10006a6:	4705                	li	a4,1
 10006a8:	00f717b3          	sll	a5,a4,a5
 10006ac:	00f6e733          	or	a4,a3,a5
 10006b0:	c158                	sw	a4,4(a0)
 10006b2:	4154                	lw	a3,4(a0)
 10006b4:	01079713          	slli	a4,a5,0x10
 10006b8:	8ed9                	or	a3,a3,a4
 10006ba:	c154                	sw	a3,4(a0)
 10006bc:	4514                	lw	a3,8(a0)
 10006be:	fff74713          	not	a4,a4
 10006c2:	8fd5                	or	a5,a5,a3
 10006c4:	c51c                	sw	a5,8(a0)
 10006c6:	451c                	lw	a5,8(a0)
 10006c8:	8f7d                	and	a4,a4,a5
 10006ca:	c518                	sw	a4,8(a0)
 10006cc:	8082                	ret
 10006ce:	4154                	lw	a3,4(a0)
 10006d0:	4705                	li	a4,1
 10006d2:	00f717b3          	sll	a5,a4,a5
 10006d6:	00d7e733          	or	a4,a5,a3
 10006da:	c158                	sw	a4,4(a0)
 10006dc:	4154                	lw	a3,4(a0)
 10006de:	01079713          	slli	a4,a5,0x10
 10006e2:	fff74713          	not	a4,a4
 10006e6:	8ef9                	and	a3,a3,a4
 10006e8:	c154                	sw	a3,4(a0)
 10006ea:	4514                	lw	a3,8(a0)
 10006ec:	fff7c793          	not	a5,a5
 10006f0:	8ff5                	and	a5,a5,a3
 10006f2:	c51c                	sw	a5,8(a0)
 10006f4:	451c                	lw	a5,8(a0)
 10006f6:	bfc9                	j	10006c8 <io_pull_write+0x74>
 10006f8:	4154                	lw	a3,4(a0)
 10006fa:	4705                	li	a4,1
 10006fc:	00f717b3          	sll	a5,a4,a5
 1000700:	fff7c713          	not	a4,a5
 1000704:	8ef9                	and	a3,a3,a4
 1000706:	c154                	sw	a3,4(a0)
 1000708:	4154                	lw	a3,4(a0)
 100070a:	07c2                	slli	a5,a5,0x10
 100070c:	8edd                	or	a3,a3,a5
 100070e:	c154                	sw	a3,4(a0)
 1000710:	4514                	lw	a3,8(a0)
 1000712:	fff7c793          	not	a5,a5
 1000716:	8f75                	and	a4,a4,a3
 1000718:	c518                	sw	a4,8(a0)
 100071a:	4518                	lw	a4,8(a0)
 100071c:	b749                	j	100069e <io_pull_write+0x4a>
 100071e:	4154                	lw	a3,4(a0)
 1000720:	4705                	li	a4,1
 1000722:	00f717b3          	sll	a5,a4,a5
 1000726:	fff7c713          	not	a4,a5
 100072a:	8f75                	and	a4,a4,a3
 100072c:	c158                	sw	a4,4(a0)
 100072e:	4154                	lw	a3,4(a0)
 1000730:	01079713          	slli	a4,a5,0x10
 1000734:	fff74713          	not	a4,a4
 1000738:	8ef9                	and	a3,a3,a4
 100073a:	c154                	sw	a3,4(a0)
 100073c:	4514                	lw	a3,8(a0)
 100073e:	8fd5                	or	a5,a5,a3
 1000740:	bf4d                	j	10006f2 <io_pull_write+0x9e>
 1000742:	4154                	lw	a3,4(a0)
 1000744:	4705                	li	a4,1
 1000746:	00f717b3          	sll	a5,a4,a5
 100074a:	fff7c713          	not	a4,a5
 100074e:	8ef9                	and	a3,a3,a4
 1000750:	c154                	sw	a3,4(a0)
 1000752:	4150                	lw	a2,4(a0)
 1000754:	07c2                	slli	a5,a5,0x10
 1000756:	fff7c693          	not	a3,a5
 100075a:	8ef1                	and	a3,a3,a2
 100075c:	c154                	sw	a3,4(a0)
 100075e:	4514                	lw	a3,8(a0)
 1000760:	8f75                	and	a4,a4,a3
 1000762:	c518                	sw	a4,8(a0)
 1000764:	4518                	lw	a4,8(a0)
 1000766:	8fd9                	or	a5,a5,a4
 1000768:	bf25                	j	10006a0 <io_pull_write+0x4c>
 100076a:	4154                	lw	a3,4(a0)
 100076c:	4705                	li	a4,1
 100076e:	00f717b3          	sll	a5,a4,a5
 1000772:	00f6e733          	or	a4,a3,a5
 1000776:	c158                	sw	a4,4(a0)
 1000778:	4154                	lw	a3,4(a0)
 100077a:	01079713          	slli	a4,a5,0x10
 100077e:	8ed9                	or	a3,a3,a4
 1000780:	c154                	sw	a3,4(a0)
 1000782:	4514                	lw	a3,8(a0)
 1000784:	8fd5                	or	a5,a5,a3
 1000786:	c51c                	sw	a5,8(a0)
 1000788:	451c                	lw	a5,8(a0)
 100078a:	8f5d                	or	a4,a4,a5
 100078c:	bf3d                	j	10006ca <io_pull_write+0x76>
 100078e:	0000                	unimp
 1000790:	067a                	slli	a2,a2,0x1e
 1000792:	0100                	addi	s0,sp,128
 1000794:	06ce                	slli	a3,a3,0x13
 1000796:	0100                	addi	s0,sp,128
 1000798:	06f8                	addi	a4,sp,844
 100079a:	0100                	addi	s0,sp,128
 100079c:	071e                	slli	a4,a4,0x7
 100079e:	0100                	addi	s0,sp,128
 10007a0:	0742                	slli	a4,a4,0x10
 10007a2:	0100                	addi	s0,sp,128
 10007a4:	06a4                	addi	s1,sp,840
 10007a6:	0100                	addi	s0,sp,128
 10007a8:	076a                	slli	a4,a4,0x1a
 10007aa:	0100                	addi	s0,sp,128

010007ac <uart_io_cfg>:
 10007ac:	2660b2ef          	jal	t0,100ba12 <__riscv_save_0>
 10007b0:	842e                	mv	s0,a1
 10007b2:	84aa                	mv	s1,a0
 10007b4:	3551                	jal	1000638 <io_set_pin>
 10007b6:	8526                	mv	a0,s1
 10007b8:	351d                	jal	10005de <io_cfg_output>
 10007ba:	8522                	mv	a0,s0
 10007bc:	3589                	jal	10005fe <io_cfg_input>
 10007be:	4595                	li	a1,5
 10007c0:	8522                	mv	a0,s0
 10007c2:	3d49                	jal	1000654 <io_pull_write>
 10007c4:	2720b06f          	j	100ba36 <__riscv_restore_0>

010007c8 <per_func_enable>:
 10007c8:	00555793          	srli	a5,a0,0x5
 10007cc:	06b7958b          	th.addsl	a1,a5,a1,3
 10007d0:	400617b7          	lui	a5,0x40061
 10007d4:	04b7958b          	th.addsl	a1,a5,a1,2
 10007d8:	0805a703          	lw	a4,128(a1) # 4006f080 <bitmap+0x2ff2f100>
 10007dc:	4785                	li	a5,1
 10007de:	00a79533          	sll	a0,a5,a0
 10007e2:	8d59                	or	a0,a0,a4
 10007e4:	08a5a023          	sw	a0,128(a1)
 10007e8:	8082                	ret

010007ea <per_func_disable>:
 10007ea:	00555793          	srli	a5,a0,0x5
 10007ee:	06b7958b          	th.addsl	a1,a5,a1,3
 10007f2:	400617b7          	lui	a5,0x40061
 10007f6:	04b7958b          	th.addsl	a1,a5,a1,2
 10007fa:	0805a703          	lw	a4,128(a1)
 10007fe:	4785                	li	a5,1
 1000800:	00a797b3          	sll	a5,a5,a0
 1000804:	fff7c793          	not	a5,a5
 1000808:	8ff9                	and	a5,a5,a4
 100080a:	08f5a023          	sw	a5,128(a1)
 100080e:	8082                	ret

01000810 <per_func0_enable>:
 1000810:	400906b7          	lui	a3,0x40090
 1000814:	0fc57713          	andi	a4,a0,252
 1000818:	c0068693          	addi	a3,a3,-1024 # 4008fc00 <bitmap+0x2ff4fc80>
 100081c:	9736                	add	a4,a4,a3
 100081e:	4334                	lw	a3,64(a4)
 1000820:	00357793          	andi	a5,a0,3
 1000824:	078e                	slli	a5,a5,0x3
 1000826:	00f595b3          	sll	a1,a1,a5
 100082a:	8dd5                	or	a1,a1,a3
 100082c:	c32c                	sw	a1,64(a4)
 100082e:	4581                	li	a1,0
 1000830:	bf61                	j	10007c8 <per_func_enable>

01000832 <pinmux_uart1_init>:
 1000832:	1e00b2ef          	jal	t0,100ba12 <__riscv_save_0>
 1000836:	10138437          	lui	s0,0x10138
 100083a:	101384b7          	lui	s1,0x10138
 100083e:	00a48ca3          	sb	a0,25(s1) # 10138019 <uart1_txd>
 1000842:	00b40c23          	sb	a1,24(s0) # 10138018 <uart1_rxd>
 1000846:	379d                	jal	10007ac <uart_io_cfg>
 1000848:	0194c503          	lbu	a0,25(s1)
 100084c:	45c1                	li	a1,16
 100084e:	37c9                	jal	1000810 <per_func0_enable>
 1000850:	01844503          	lbu	a0,24(s0)
 1000854:	45c5                	li	a1,17
 1000856:	3f6d                	jal	1000810 <per_func0_enable>
 1000858:	1de0b06f          	j	100ba36 <__riscv_restore_0>

0100085c <pinmux_hal_flash_init>:
 100085c:	1b60b2ef          	jal	t0,100ba12 <__riscv_save_0>
 1000860:	4585                	li	a1,1
 1000862:	0f100513          	li	a0,241
 1000866:	378d                	jal	10007c8 <per_func_enable>
 1000868:	4585                	li	a1,1
 100086a:	0f000513          	li	a0,240
 100086e:	3fa9                	jal	10007c8 <per_func_enable>
 1000870:	4585                	li	a1,1
 1000872:	0f200513          	li	a0,242
 1000876:	3f89                	jal	10007c8 <per_func_enable>
 1000878:	4585                	li	a1,1
 100087a:	0f300513          	li	a0,243
 100087e:	37a9                	jal	10007c8 <per_func_enable>
 1000880:	4006f7b7          	lui	a5,0x4006f
 1000884:	38078693          	addi	a3,a5,896 # 4006f380 <bitmap+0x2ff2f400>
 1000888:	4eb8                	lw	a4,88(a3)
 100088a:	000f0637          	lui	a2,0xf0
 100088e:	8f51                	or	a4,a4,a2
 1000890:	ceb8                	sw	a4,88(a3)
 1000892:	57f8                	lw	a4,108(a5)
 1000894:	9b41                	andi	a4,a4,-16
 1000896:	d7f8                	sw	a4,108(a5)
 1000898:	19e0b06f          	j	100ba36 <__riscv_restore_0>

0100089c <pinmux_hal_flash_quad_init>:
 100089c:	1760b2ef          	jal	t0,100ba12 <__riscv_save_0>
 10008a0:	4585                	li	a1,1
 10008a2:	0f100513          	li	a0,241
 10008a6:	370d                	jal	10007c8 <per_func_enable>
 10008a8:	4585                	li	a1,1
 10008aa:	0f000513          	li	a0,240
 10008ae:	3f29                	jal	10007c8 <per_func_enable>
 10008b0:	4585                	li	a1,1
 10008b2:	0f200513          	li	a0,242
 10008b6:	3f09                	jal	10007c8 <per_func_enable>
 10008b8:	4585                	li	a1,1
 10008ba:	0f300513          	li	a0,243
 10008be:	3729                	jal	10007c8 <per_func_enable>
 10008c0:	4585                	li	a1,1
 10008c2:	0f400513          	li	a0,244
 10008c6:	3709                	jal	10007c8 <per_func_enable>
 10008c8:	4585                	li	a1,1
 10008ca:	0f500513          	li	a0,245
 10008ce:	3ded                	jal	10007c8 <per_func_enable>
 10008d0:	4006f7b7          	lui	a5,0x4006f
 10008d4:	53f8                	lw	a4,100(a5)
 10008d6:	ffd006b7          	lui	a3,0xffd00
 10008da:	16fd                	addi	a3,a3,-1 # ffcfffff <bitmap+0xefbc007f>
 10008dc:	03076713          	ori	a4,a4,48
 10008e0:	d3f8                	sw	a4,100(a5)
 10008e2:	57b8                	lw	a4,104(a5)
 10008e4:	8f75                	and	a4,a4,a3
 10008e6:	d7b8                	sw	a4,104(a5)
 10008e8:	0607a623          	sw	zero,108(a5) # 4006f06c <bitmap+0x2ff2f0ec>
 10008ec:	14a0b06f          	j	100ba36 <__riscv_restore_0>

010008f0 <pinmux_cjtag_init>:
 10008f0:	1220b2ef          	jal	t0,100ba12 <__riscv_save_0>
 10008f4:	458d                	li	a1,3
 10008f6:	04500513          	li	a0,69
 10008fa:	35f9                	jal	10007c8 <per_func_enable>
 10008fc:	458d                	li	a1,3
 10008fe:	04400513          	li	a0,68
 1000902:	35d9                	jal	10007c8 <per_func_enable>
 1000904:	04500513          	li	a0,69
 1000908:	39dd                	jal	10005fe <io_cfg_input>
 100090a:	04400513          	li	a0,68
 100090e:	39c5                	jal	10005fe <io_cfg_input>
 1000910:	1260b06f          	j	100ba36 <__riscv_restore_0>

01000914 <pinmux_cjtag_deinit>:
 1000914:	0fe0b2ef          	jal	t0,100ba12 <__riscv_save_0>
 1000918:	458d                	li	a1,3
 100091a:	04500513          	li	a0,69
 100091e:	35f1                	jal	10007ea <per_func_disable>
 1000920:	458d                	li	a1,3
 1000922:	04400513          	li	a0,68
 1000926:	35d1                	jal	10007ea <per_func_disable>
 1000928:	10e0b06f          	j	100ba36 <__riscv_restore_0>

0100092c <uart1_status_set>:
 100092c:	10138737          	lui	a4,0x10138
 1000930:	01c72783          	lw	a5,28(a4) # 1013801c <peri_stat>
 1000934:	9bf9                	andi	a5,a5,-2
 1000936:	8fc9                	or	a5,a5,a0
 1000938:	00f72e23          	sw	a5,28(a4)
 100093c:	8082                	ret

0100093e <uart2_status_set>:
 100093e:	10138737          	lui	a4,0x10138
 1000942:	01c72783          	lw	a5,28(a4) # 1013801c <peri_stat>
 1000946:	0506                	slli	a0,a0,0x1
 1000948:	9bf5                	andi	a5,a5,-3
 100094a:	8fc9                	or	a5,a5,a0
 100094c:	00f72e23          	sw	a5,28(a4)
 1000950:	8082                	ret

01000952 <rv_set_int_isr>:
 1000952:	101387b7          	lui	a5,0x10138
 1000956:	04078793          	addi	a5,a5,64 # 10138040 <interrupt_vector>
 100095a:	44a7d58b          	th.srw	a1,a5,a0,2
 100095e:	8082                	ret

01000960 <SWINT_Handler_C>:
 1000960:	0b20b2ef          	jal	t0,100ba12 <__riscv_save_0>
 1000964:	842a                	mv	s0,a0
 1000966:	555c                	lw	a5,44(a0)
 1000968:	5914                	lw	a3,48(a0)
 100096a:	5950                	lw	a2,52(a0)
 100096c:	5d0c                	lw	a1,56(a0)
 100096e:	5d48                	lw	a0,60(a0)
 1000970:	9782                	jalr	a5
 1000972:	dc48                	sw	a0,60(s0)
 1000974:	0c20b06f          	j	100ba36 <__riscv_restore_0>

01000978 <lscache_msp_init>:
 1000978:	400227b7          	lui	a5,0x40022
 100097c:	4721                	li	a4,8
 100097e:	cb98                	sw	a4,16(a5)
 1000980:	cf98                	sw	a4,24(a5)
 1000982:	4711                	li	a4,4
 1000984:	cf98                	sw	a4,24(a5)
 1000986:	cb98                	sw	a4,16(a5)
 1000988:	8082                	ret

0100098a <ecc256_scalar_mult_text>:
 100098a:	effb 01ff 0837 0000 0813 0008 0113 0000     ....7...........
 100099a:	410b 0028 0113 0010 400b 0028 0837 0000     .A(......@(.7...
 10009aa:	0813 0408 0113 0020 410b 0028 0113 0030     ...... ..A(...0.
 10009ba:	400b 0028 0ab7 0000 8a93 080a 0b37 0000     .@(.........7...
 10009ca:	0b13 0a0b 00ef 3800 00ef 2c00 0113 00b0     .......8...,....
 10009da:	0ab7 0000 8a93 0c0a d08b 002a 0b37 0000     ..........*.7...
 10009ea:	0b13 0e0b 500b 002b 0073 0000 1173 7c00     .....P+.s...s..|
 10009fa:	7113 0081 5113 0031 0133 4020 0193 01f0     .q...Q1.3. @....
 1000a0a:	400b 0031 effb 01ff 8067 0000 7afb ff3a     .@1.....g....z:.
 1000a1a:	903b 01ca a03b 03ca abbb 49ca 803b 05ca     ;...;......I;...
 1000a2a:	803b 0bca 803b 11ca a03b 07ca a03b 0dca     ;...;...;...;...
 1000a3a:	a03b 13ca abbb 79ca 803b 0fca 803b 15ca     ;......y;...;...
 1000a4a:	803b 1bca a03b 17ca ac3b 5dca 8c3b 7fca     ;...;...;..];...
 1000a5a:	0a2b 01fa fcfb ff4f 0c2b 015c acab 01fc     +.....O.+.\.....
 1000a6a:	0c2b 016c acab 01fc fafb 018c 903b 015e     +.l.........;.^.
 1000a7a:	a03b 035e ab3b 495e 803b 055e 803b 0b5e     ;.^.;.^I;.^.;.^.
 1000a8a:	803b 115e a03b 075e a03b 0d5e a03b 135e     ;.^.;.^.;.^.;.^.
 1000a9a:	ab3b 795e 803b 0f5e 803b 155e 803b 1b5e     ;.^y;.^.;.^.;.^.
 1000aaa:	a03b 175e abbb 5d5e 8bbb 7f5e 8bab 01fb     ;.^...^]..^.....
 1000aba:	9b2b 0169 3a2b 017a 8a8b 05fe 1aab 015b     +.i.+:z.......[.
 1000aca:	d9ab 01fa 8067 0000 103b 019c 203b 039c     ....g...;...; ..
 1000ada:	29bb 499c 003b 059c 003b 0b9c 003b 119c     .).I;...;...;...
 1000aea:	203b 079c 203b 0d9c 203b 139c 29bb 799c     ; ..; ..; ...).y
 1000afa:	003b 0f9c 003b 159c 003b 1b9c 203b 179c     ;...;...;...; ..
 1000b0a:	2a3b 5d9c 0a3b 7f9c 0b0b 03fe f0ef f01f     ;*.];...........
 1000b1a:	8067 0000 103b 01ac 203b 09ac 29bb 43ac     g...;...; ...).C
 1000b2a:	003b 0bac 003b 05ac 203b 0dac 29bb 67ac     ;...;...; ...).g
 1000b3a:	003b 0fac 803b 01ac aa3b 29ac 0b0b 03fe     ;...;...;..)....
 1000b4a:	f0ef ecdf 8067 0000 ec0b 0005 6c8b 0004     ....g........l..
 1000b5a:	f0ef f79f e70b 0009 6c0b 0006 ec8b 0004     .........l......
 1000b6a:	f0ef f69f e78b 0009 ec0b 0006 6c8b 0005     .............l..
 1000b7a:	f0ef f59f e80b 0009 d8ab 00c5 592b 0094     ............+Y..
 1000b8a:	ec0b 0008 6c8b 0009 f0ef f41f 592b 00f7     .....l......+Y..
 1000b9a:	d8ab 4129 592b 00d6 d9ab 00a4 6c0b 0009     ..)A+Y.......l..
 1000baa:	ec8b 0009 f0ef f25f e90b 0009 d9ab 0107     ......_.........
 1000bba:	592b 4139 d9ab 00d5 562b 00a4 ec0b 0009     +Y9A....+V......
 1000bca:	6c8b 0006 f0ef f05f e58b 0009 562b 0107     .l...._.....+V..
 1000bda:	d62b 40c5 ec0b 000d 6c8b 0008 f0ef eedf     +..@.....l......
 1000bea:	55ab 4136 d6ab 00b5 d5ab 00d5 d6ab 40b7     .U6A...........@
 1000bfa:	d5ab 00b7 ec0b 000d 6c8b 0006 f0ef ecdf     .........l......
 1000c0a:	57ab 0108 d82b 0107 d62b 4109 562b 40e6     .W..+...+..A+V.@
 1000c1a:	57ab 00c6 d62b 00c7 57ab 00e7 d72b 00e7     .W..+....W..+...
 1000c2a:	572b 4107 6c0b 0009 6c8b 0006 f0ef e9df     +W.A.l...l......
 1000c3a:	e78b 0009 6c0b 0007 6c8b 0006 f0ef e8df     .....l...l......
 1000c4a:	e80b 0009 ec0b 0005 ec8b 0006 f0ef e7df     ................
 1000c5a:	d62b 0109 ec0b 0008 ec8b 0005 f0ef e6df     +...............
 1000c6a:	d5ab 40f9 6c0b 0009 ec8b 0006 f0ef e5df     ...@.l..........
 1000c7a:	e68b 0009 ec0b 0008 6c8b 0007 f0ef e4df     .........l......
 1000c8a:	d6ab 0136 8067 0000 600b 0005 00ef 02c0     ..6.g....`......
 1000c9a:	e70b 0000 6c0b 0007 6c8b 0004 f0ef e2df     .....l...l......
 1000caa:	e58b 0009 6c0b 0007 ec8b 0004 f0ef e1df     .....l..........
 1000cba:	e60b 0009 8067 0000 710b 0000 412b 4021     ....g....q..+A!@
 1000cca:	c0ab 001f 107b 00d4 ec0b 0000 ec8b 0000     ....{...........
 1000cda:	f0ef df9f e18b 0009 012b 0021 808b 0030     ........+.!...0.
 1000cea:	2173 7c00 7113 0011 0a63 0001 ec0b 0001     s!.|.q..c.......
 1000cfa:	6c8b 0000 f0ef dd5f e08b 0009 0013 0000     .l...._.........
 1000d0a:	8067 0000 780b 0020 582b 01f8 c00b 00aa     g....x .+X......
 1000d1a:	6c8b 0008 f0ef db5f e70b 0009 400b 00ab     .l...._......@..
 1000d2a:	6c8b 0008 f0ef da5f e78b 0009 8067 0000     .l...._.....g...
 1000d3a:	658b 0004 e60b 0004 668b 0005 f0ef e0df     .e.......f......
 1000d4a:	8067 0000 0113 01d0 01b7 0000 8193 1201     g...............
 1000d5a:	c00b 0021 f00b 800e 0113 01c0 01b7 0000     ..!.............
 1000d6a:	8193 1401 c00b 0021 0113 01b0 01b7 0000     ......!.........
 1000d7a:	8193 1001 c00b 0021 0513 0180 f0ef f89f     ......!.........
 1000d8a:	640b 0007 e48b 0007 650b 0008 f0ef fa5f     .d.......e...._.
 1000d9a:	e20b 0005 628b 0006 e30b 0006 e40b 000f     .....b..........
 1000daa:	c4ab 001f e50b 000f b0fb 4000 307b 41f0     ...........@{0.A
 1000dba:	b1fb 4021 317b 41f1 107b 0215 f0ef f75f     ..!@{1.A{....._.
 1000dca:	f0ef f45f ea7b 0030 040b 0247 848b 0257     .._.{.0...G...W.
 1000dda:	050b 0268 e38b 0005 6d0b 0006 ef0b 0006     ..h......m......
 1000dea:	f0ef d69f ca7b 0030 840b 0275 048b 03a6     ....{.0...u.....
 1000dfa:	850b 03e6 f0fb fe00 707b fff0 f1fb fe21     ........{p....!.
 1000e0a:	717b fff1 758b 0020 760b 0020 768b 0020     {q...u ..v ..v .
 1000e1a:	738b 0020 6c0b 0002 ec8b 0003 f0ef cadf     .s ..l..........
 1000e2a:	e20b 0009 ec0b 0002 ec8b 0003 f0ef c9df     ................
 1000e3a:	e28b 0009 6c0b 0003 ec8b 0003 f0ef c8df     .....l..........
 1000e4a:	e30b 0009 100b 01f5 f0ef ba5f 8067 0000     .........._.g...
 1000e5a:	effb 01ff 0837 0000 0813 3008 0113 0000     ....7......0....
 1000e6a:	410b 0028 0113 0010 400b 0028 0837 0000     .A(......@(.7...
 1000e7a:	0813 3408 0113 0020 410b 0028 0113 0030     ...4.. ..A(...0.
 1000e8a:	400b 0028 0ab7 0000 8a93 1a0a 0b37 0000     .@(.........7...
 1000e9a:	0b13 1c0b f0ef eb1f f0ef df1f 0113 00b0     ................
 1000eaa:	0ab7 0000 8a93 080a d08b 002a 0b37 0000     ..........*.7...
 1000eba:	0b13 0a0b 500b 002b 8067 0000 0113 01d0     .....P+.g.......
 1000eca:	01b7 0000 8193 1601 c00b 0021 f00b 800e     ..........!.....
 1000eda:	0113 01c0 01b7 0000 8193 1801 c00b 0021     ..............!.
 1000eea:	778b 0010 780b 0010 788b 0010 7a0b 0020     .w...x...x...z .
 1000efa:	e7fb 0147 7a0b 0020 687b 0148 7a0b 0020     ..G..z .{hH..z .
 1000f0a:	e8fb 0148 b97b c10f 3a7b 41f8 387b c1fa     ..H.{...{:.A{8..
 1000f1a:	770b 0020 472b 0017 ec0b 0007 6c8b 0008     .w .+G.......l..
 1000f2a:	6d0b 0007 f0ef bf1f e60b 0009 ec0b 0008     .m..............
 1000f3a:	6c8b 0009 6d0b 0007 f0ef bddf e68b 0009     .l...m..........
 1000f4a:	562b 00d6 100b 01f6 1173 7c00 7113 0081     +V......s..|.q..
 1000f5a:	18e3 f801 8067 0000 effb 01ff f0ef f61f     ....g...........
 1000f6a:	0a37 0000 0a13 300a 0113 00f0 510b 002a     7......0.....Q*.
 1000f7a:	0113 0100 500b 002a 0a37 0000 0a13 340a     .....P*.7......4
 1000f8a:	0113 0110 510b 002a 0113 0120 500b 002a     .....Q*... ..P*.
 1000f9a:	8067 0000 effb 01ff f0ef f25f 0a37 0000     g........._.7...
 1000faa:	0a13 000a 0113 00f0 510b 002a 0113 0100     .........Q*.....
 1000fba:	500b 002a 0a37 0000 0a13 040a 0113 0110     .P*.7...........
 1000fca:	510b 002a 0113 0120 500b 002a 8067 0000     .Q*... ..P*.g...
 1000fda:	bafb 41fa bafb c15f bffb c1ff b5fb 41f5     ...A.._........A
 1000fea:	b5fb c0bf 708b 0020 710b 0020 f17b be2f     .....p ..q .{./.
 1000ffa:	61fb 001a e27b 002a 91ab 0011 322b 0022     .a..{.*.....+2".
 100100a:	9fab 01ff 727b 41f2 f27b be4f e1fb 0141     ....{r.A{.O...A.
 100101a:	627b 0152 e0fb 00a0 617b 00b1 6a7b 001a     {bR.....{a..{j..
 100102a:	eafb 002a 1a2b 001a baab 002a 9fab 01ff     ..*.+.....*.....
 100103a:	fafb 41fa fafb bf5f 7e0b 0010 7e8b 0010     ...A.._..~...~..
 100104a:	6a7b 014e eafb 015e 6a7b 003a eafb 004a     {jN...^.{j:...J.
 100105a:	6a7b 014e eafb 015e 8067 0000 f0ef f75f     {jN...^.g....._.
 100106a:	0113 01d0 01b7 0000 8193 1601 c00b 0021     ..............!.
 100107a:	be7b c1fe befb c1df 1c2b 01c5 bcab 01d5     {.......+.......
 100108a:	050b 0185 858b 0195 bcfb 415f bcfb c1fc     .........._A....
 100109a:	eafb 019a 1d2b 01ca bdab 01da 0a0b 01aa     ....+...........
 10010aa:	8a8b 01ba 9d2b 01cf bdab 01dc 8c0b 01af     ....+...........
 10010ba:	8c8b 01bc 0a2b 01ca aaab 01da 1a2b 018a     ....+.......+...
 10010ca:	baab 019a 1d2b 01ca bdab 01da 0a0b 01aa     ....+...........
 10010da:	8a8b 01ba 8067 0000                         ....g...

010010e2 <ecc384_ecdsa_verify_text>:
 10010e2:	00ef 17d0 0113 0000 01b7 0000 8193 1401     ................
 10010f2:	c08b 0021 c00b 0221 0073 0000 103b 0105     ..!...!.s...;...
 1001102:	203b 0905 293b 4305 003b 1105 003b 0b05     ; ..;).C;...;...
 1001112:	003b 0505 203b 1905 203b 1305 203b 0d05     ;...; ..; ..; ..
 1001122:	293b 6705 003b 0115 003b 1b05 003b 1505     ;).g;...;...;...
 1001132:	003b 0f05 803b 0105 203b 0915 203b 0315     ;...;...; ..; ..
 1001142:	203b 1d05 203b 1705 a03b 0905 a9bb 4305     ; ..; ..;......C
 1001152:	003b 0b15 003b 0515 003b 1f05 803b 1105     ;...;...;...;...
 1001162:	803b 0b05 203b 0d15 203b 0715 a03b 1905     ;...; ..; ..;...
 1001172:	a9bb 7305 003b 0f15 803b 0115 803b 1b05     ...s;...;...;...
 1001182:	a03b 0915 aa3b 4315 8a3b 6b15 8067 0000     ;...;..C;..kg...
 1001192:	103b 0105 203b 0905 293b 4305 003b 0b05     ;...; ..;).C;...
 10011a2:	003b 0505 203b 0d05 293b 6705 003b 0f05     ;...; ..;).g;...
 10011b2:	803b 0105 a03b 0305 a9bb 4905 803b 0505     ;...;......I;...
 10011c2:	803b 0b05 a9bb 6d05 8a3b 21ff 8067 0000     ;......m;..!g...
 10011d2:	3afb 813a 8bab 215a ac2b 615f 8bab 195b     .::...Z!+._a..[.
 10011e2:	2c2b 695c 9bab 095b 3c2b 795c 5b7b 01f0     +,\i..[.+<\y{[..
 10011f2:	a9fb 6169 092b 0179 a9ab 0189 bafb 814f     ..ia+.y.......O.
 1001202:	8bab 215a ac2b 615f 8bab 195b 2c2b 695c     ..Z!+._a..[.+,\i
 1001212:	9bab 095b 3c2b 795c 89ab 0179 aa2b 018f     ..[.+<\y..y.+...
 1001222:	3afb 813a 8bab 215a ac2b 615f 8bab 195b     .::...Z!+._a..[.
 1001232:	2c2b 695c 9bab 095b 3c2b 795c a9fb 6169     +,\i..[.+<\y..ia
 1001242:	092b 0179 a9ab 0189 182b 00c9 b8ab 00d9     +.y.....+.......
 1001252:	080b 0109 888b 0119 8067 0000 3afb 813a     ........g....::.
 1001262:	903b 00ea a03b 08ea abbb 42ea 803b 10ea     ;...;......B;...
 1001272:	803b 0aea 803b 04ea a03b 12ea a03b 0cea     ;...;...;...;...
 1001282:	abbb 66ea 803b 14ea 803b 0eea ac3b 36ea     ...f;...;...;..6
 1001292:	5b7b 01f0 a9fb 6169 092b 0179 a9ab 0189     {[....ia+.y.....
 10012a2:	bafb 814f 903b 00ea a03b 08ea abbb 42ea     ..O.;...;......B
 10012b2:	803b 10ea 803b 0aea abbb 72ea 8c3b 21ff     ;...;......r;..!
 10012c2:	89ab 0179 aa2b 018f 3afb 813a 903b 00ea     ..y.+....::.;...
 10012d2:	a03b 08ea abbb 42ea 803b 10ea 803b 0aea     ;......B;...;...
 10012e2:	803b 04ea a03b 12ea abbb 6cea 8c3b 34ea     ;...;......l;..4
 10012f2:	a9fb 6169 092b 0179 a9ab 0189 182b 00c9     ..ia+.y.....+...
 1001302:	b8ab 00d9 080b 0109 888b 0119 8067 0000     ............g...
 1001312:	f0ef dedf f06f ebdf f0ef de5f f06f f41f     ....o....._.o...
 1001322:	f0ef e71f f06f f39f 400b 016d 400b 037d     ....o....@m..@}.
 1001332:	c00b 018d c00b 039d f0ef fd9f 600b 0008     .............`..
 1001342:	e08b 0008 400b 056d 400b 077d c00b 058d     .....@m..@}.....
 1001352:	c00b 079d f0ef fbdf 610b 0008 e18b 0008     .........a......
 1001362:	400b 096d 400b 0b7d c00b 098d c00b 0b9d     .@m..@}.........
 1001372:	f0ef fa1f 620b 0008 e28b 0008 400b 016d     .....b.......@m.
 1001382:	400b 037d 400b 058d 400b 079d 082b 0105     .@}..@...@..+...
 1001392:	a8ab 0115 152b 00c8 b5ab 00d8 030b 00a8     ....+...........
 10013a2:	838b 00b8 c00b 016d c00b 037d c00b 058d     ......m...}.....
 10013b2:	c00b 079d 082b 0105 a8ab 0115 152b 00c8     ....+.......+...
 10013c2:	b5ab 00d8 040b 00a8 848b 00b8 650b 0003     .............e..
 10013d2:	e58b 0003 680b 0004 e88b 0004 f0ef f35f     .....h........_.
 10013e2:	630b 0008 e38b 0008 082b 0020 a8ab 0030     .c......+. ...0.
 10013f2:	152b 00c8 b5ab 00d8 040b 00a8 848b 00b8     +...............
 1001402:	182b 0083 b8ab 0093 052b 00c8 a5ab 00d8     +.......+.......
 1001412:	030b 0105 838b 0115 400b 056d 400b 077d     .........@m..@}.
 1001422:	400b 098d 400b 0b9d 082b 0105 a8ab 0115     .@...@..+.......
 1001432:	152b 00c8 b5ab 00d8 040b 00a8 848b 00b8     +...............
 1001442:	c00b 056d c00b 077d c00b 098d c00b 0b9d     ..m...}.........
 1001452:	082b 0105 a8ab 0115 152b 00c8 b5ab 00d8     +.......+.......
 1001462:	0c8b 00a8 8d0b 00b8 650b 0004 e58b 0004     .........e......
 1001472:	e80b 000c 688b 000d f0ef e99f 640b 0008     .....h.......d..
 1001482:	e48b 0008 082b 0041 a8ab 0051 152b 00c8     ....+.A...Q.+...
 1001492:	b5ab 00d8 0c8b 00a8 8d0b 00b8 182b 0194     ............+...
 10014a2:	b8ab 01a4 052b 00c8 a5ab 00d8 040b 0105     ....+...........
 10014b2:	848b 0115 400b 016d 400b 037d 400b 098d     .....@m..@}..@..
 10014c2:	400b 0b9d 082b 0105 a8ab 0115 152b 00c8     .@..+.......+...
 10014d2:	b5ab 00d8 0c8b 00a8 8d0b 00b8 c00b 016d     ..............m.
 10014e2:	c00b 037d c00b 098d c00b 0b9d 082b 0105     ..}.........+...
 10014f2:	a8ab 0115 152b 00c8 b5ab 00d8 0d8b 00a8     ....+...........
 1001502:	8e0b 00b8 e50b 000c 658b 000d e80b 000d     .........e......
 1001512:	688b 000e f0ef dfdf 6c8b 0008 ed0b 0008     .h.......l......
 1001522:	082b 0040 a8ab 0050 152b 00c8 b5ab 00d8     +.@...P.+.......
 1001532:	0d8b 00a8 8e0b 00b8 982b 01bc 38ab 01cd     ........+....8..
 1001542:	052b 00c8 a5ab 00d8 0d8b 0105 8e0b 0115     +...............
 1001552:	400b 016e 400b 037e 680b 0002 e88b 0002     .@n..@~..h......
 1001562:	f0ef db1f 6e8b 0008 ef0b 0008 982b 01dd     .....n......+...
 1001572:	38ab 01ee 052b 00c8 a5ab 00d8 0c8b 0105     .8..+...........
 1001582:	8d0b 0115 882b 019c 28ab 01ad 152b 00c8     ....+....(..+...
 1001592:	b5ab 00d8 0e8b 00a8 8f0b 00b8 882b 01dc     ............+...
 10015a2:	28ab 01ed 152b 00c8 b5ab 00d8 0c8b 00a8     .(..+...........
 10015b2:	8d0b 00b8 182b 0191 b8ab 01a1 052b 00c8     ....+.......+...
 10015c2:	a5ab 00d8 0e8b 0105 8f0b 0115 082b 0191     ............+...
 10015d2:	a8ab 01a1 152b 00c8 b5ab 00d8 0c8b 00a8     ....+...........
 10015e2:	8d0b 00b8 400b 016e 400b 037e e80b 000d     .....@n..@~.....
 10015f2:	688b 000e f0ef d1df 6d8b 0008 ee0b 0008     .h.......m......
 1001602:	082b 0042 a8ab 0052 152b 00c8 b5ab 00d8     +.B...R.+.......
 1001612:	010b 00a8 818b 00b8 082b 0041 a8ab 0051     ........+.A...Q.
 1001622:	152b 00c8 b5ab 00d8 020b 00a8 828b 00b8     +...............
 1001632:	982b 004d 38ab 005e 052b 00c8 a5ab 00d8     +.M..8^.+.......
 1001642:	0d8b 0105 8e0b 0115 982b 000d 38ab 001e     ........+....8..
 1001652:	052b 00c8 a5ab 00d8 0d8b 0105 8e0b 0115     +...............
 1001662:	882b 01bd 28ab 01ce 152b 00c8 b5ab 00d8     +....(..+.......
 1001672:	010b 00a8 818b 00b8 082b 01b1 a8ab 01c1     ........+.......
 1001682:	152b 00c8 b5ab 00d8 0d8b 00a8 8e0b 00b8     +...............
 1001692:	082b 0000 a8ab 0010 152b 00c8 b5ab 00d8     +.......+.......
 10016a2:	010b 00a8 818b 00b8 082b 0001 a8ab 0011     ........+.......
 10016b2:	152b 00c8 b5ab 00d8 000b 00a8 808b 00b8     +...............
 10016c2:	182b 0040 b8ab 0050 052b 00c8 a5ab 00d8     +.@...P.+.......
 10016d2:	000b 0105 808b 0115 650b 0004 e58b 0004     .........e......
 10016e2:	e80b 000d 688b 000e f0ef c29f 610b 0008     .....h.......a..
 10016f2:	e18b 0008 650b 0000 e58b 0000 e80b 000d     .....e..........
 1001702:	688b 000e f0ef c0df 620b 0008 e28b 0008     .h.......b......
 1001712:	e50b 000c 658b 000d e80b 000e 688b 000f     .....e.......h..
 1001722:	f0ef bf1f 6d8b 0008 ee0b 0008 882b 004d     .....m......+.M.
 1001732:	28ab 005e 152b 00c8 b5ab 00d8 0d8b 00a8     .(^.+...........
 1001742:	8e0b 00b8 650b 0003 e58b 0003 e80b 000c     .....e..........
 1001752:	688b 000d f0ef bbdf 6c8b 0008 ed0b 0008     .h.......l......
 1001762:	982b 002c 38ab 003d 052b 00c8 a5ab 00d8     +.,..8=.+.......
 1001772:	0c8b 0105 8d0b 0115 650b 0004 e58b 0004     .........e......
 1001782:	e80b 000e 688b 000f f0ef b89f 6e8b 0008     .....h.......n..
 1001792:	ef0b 0008 650b 0003 e58b 0003 680b 0000     .....e.......h..
 10017a2:	e88b 0000 f0ef b6df 610b 0008 e18b 0008     .........a......
 10017b2:	882b 002e 28ab 003f 152b 00c8 b5ab 00d8     +....(?.+.......
 10017c2:	0e8b 00a8 8f0b 00b8 8067 0000 e50b 000e     ........g.......
 10017d2:	658b 000f e80b 000e 688b 000f f0ef b35f     .e.......h...._.
 10017e2:	e50b 000e 658b 000f f0ef b29f 650b 0008     .....e.......e..
 10017f2:	e58b 0008 f0ef b1df e50b 000e 658b 000f     .............e..
 1001802:	f0ef b11f 600b 0008 e08b 0008 11fb 0030     .....`........0.
 1001812:	650b 0008 e58b 0008 f0ef af9f 0013 0000     .e..............
 1001822:	650b 0000 e58b 0000 f0ef ae9f 610b 0008     .e...........a..
 1001832:	e18b 0008 137b 0030 650b 0008 e58b 0008     ....{.0..e......
 1001842:	f0ef ad1f 0013 0000 650b 0001 e58b 0001     .........e......
 1001852:	f0ef ac1f 620b 0008 e28b 0008 167b 0030     .....b......{.0.
 1001862:	650b 0008 e58b 0008 f0ef aa9f 0013 0000     .e..............
 1001872:	650b 0002 e58b 0002 f0ef a99f 137b 0030     .e..........{.0.
 1001882:	650b 0008 e58b 0008 f0ef a89f 0013 0000     .e..............
 1001892:	650b 0001 e58b 0001 f0ef a79f 610b 0008     .e...........a..
 10018a2:	e18b 0008 650b 0008 e58b 0008 f0ef a65f     .....e........_.
 10018b2:	e50b 000e 658b 000f f0ef a59f 630b 0008     .....e.......c..
 10018c2:	e38b 0008 650b 0008 e58b 0008 f0ef a45f     .....e........_.
 10018d2:	e50b 000e 658b 000f f0ef a39f 648b 0008     .....e.......d..
 10018e2:	e40b 0008 1ffb 0030 650b 0008 e58b 0008     ......0..e......
 10018f2:	f0ef a21f 0013 0000 650b 0003 e58b 0003     .........e......
 1001902:	f0ef a11f 630b 0008 e38b 0008 9ffb 0030     .....c........0.
 1001912:	650b 0008 e58b 0008 f0ef 9f9f 0013 0000     .e..............
 1001922:	650b 0003 e58b 0003 f0ef 9e9f 630b 0008     .e...........c..
 1001932:	e38b 0008 9f7b 0031 650b 0008 e58b 0008     ....{.1..e......
 1001942:	f0ef 9d1f 0013 0000 650b 0003 e58b 0003     .........e......
 1001952:	f0ef 9c1f 11fb 0030 650b 0008 e58b 0008     ......0..e......
 1001962:	f0ef 9b1f 0013 0000 650b 0000 e58b 0000     .........e......
 1001972:	f0ef 9a1f 90fb 0030 650b 0008 e58b 0008     ......0..e......
 1001982:	f0ef 991f 0013 0000 e50b 0004 658b 0004     .............e..
 1001992:	f0ef 981f 1f7b 0031 650b 0008 e58b 0008     ....{.1..e......
 10019a2:	f0ef 971f 0013 0000 650b 0001 e58b 0001     .........e......
 10019b2:	f0ef 961f 117b 0030 650b 0008 e58b 0008     ....{.0..e......
 10019c2:	f0ef 951f 0013 0000 e50b 000e 658b 000f     .............e..
 10019d2:	f0ef 941f 600b 0008 e08b 0008 e50b 000c     .....`..........
 10019e2:	658b 000d f0ef 92df 6c8b 0008 ed0b 0008     .e.......l......
 10019f2:	e50b 000d 658b 000e 680b 0000 e88b 0000     .....e...h......
 1001a02:	f0ef 911f 6d8b 0008 ee0b 0008 8067 0000     .....m......g...
 1001a12:	0113 0060 408b 0025 408b 0225 c08b 0025     ..`..@%..@%...%.
 1001a22:	c08b 0225 c52b 001f e5fb 00b5 0113 0060     ..%.+.........`.
 1001a32:	137b 0010 510b 0026 0113 0011 0013 0000     {....Q&.........
 1001a42:	8067 0000 0113 0190 137b 0010 510b 0026     g.......{....Q&.
 1001a52:	0113 0011 0013 0000 8067 0000 effb 01ff     ........g.......
 1001a62:	0337 0000 0313 0403 03b7 0000 8393 0803     7...............
 1001a72:	0437 0000 0413 1404 04b7 0000 8493 0004     7...............
 1001a82:	06b7 0000 8693 0c06 0737 0000 0713 1007     ........7.......
 1001a92:	0113 00c0 01b7 0000 8193 2001 c08b 0021     ........... ..!.
 1001aa2:	c08b 0221 0113 01d0 c08b 0023 c08b 0223     ..!.......#...#.
 1001ab2:	900b 01df b00b 01ef 2173 7c00 7113 0011     ........s!.|.q..
 1001ac2:	0863 2201 900b 00ce 300b 00df 2173 7c00     c..".....0..s!.|
 1001ad2:	7113 0011 0e63 2001 972b 00cf 00ef 2200     .q..c.. +......"
 1001ae2:	640b 0008 e48b 0008 0b13 00a0 0b93 00b0     .d..............
 1001af2:	0c13 0100 0c93 0110 0113 00a0 408b 0023     .............@#.
 1001b02:	408b 0223 900b 00af b00b 00bf 2173 7c00     .@#.........s!.|
 1001b12:	7113 0011 0e63 1c01 100b 00c5 b00b 00d5     .q..c...........
 1001b22:	2173 7c00 7113 0011 0463 1c01 f0ef fecf     s!.|.q..c.......
 1001b32:	610b 0008 e18b 0008 b1fb 8021 317b 81f1     .a........!.{1..
 1001b42:	0113 00a0 c08b 0024 c08b 0224 680b 0004     ......$...$..h..
 1001b52:	e88b 0004 f0ef fc4f 600b 0008 e08b 0008     ......O..`......
 1001b62:	b0fb 8000 307b 81f0 0113 0000 0d37 0000     ....{0......7...
 1001b72:	0d13 440d 508b 302d 508b 322d 508b 342d     ...D.P-0.P-2.P-4
 1001b82:	508b 362d 0113 00c0 01b7 0000 8193 1c01     .P-6............
 1001b92:	c08b 0021 c08b 0221 0e37 0000 0e13 180e     ..!...!.7.......
 1001ba2:	ecfb 019c 6d7b 01ad cdab 001f 6e7b 01ce     ....{m......{n..
 1001bb2:	eefb 01de 6f7b 01ef 0637 0000 0613 4406     ....{o..7......D
 1001bc2:	f0ef e85f 0537 0000 0513 2405 05b7 0000     .._.7......$....
 1001bd2:	8593 2805 f0ef e3df 8533 0006 05b3 0007     ...(....3.......
 1001be2:	f0ef e31f 0d37 0000 0d13 440d 0d93 180d     ....7......D....
 1001bf2:	0d13 0c0d f0ef f34f f0ef e4df 0d37 0000     ......O.....7...
 1001c02:	0d13 440d 107b 0226 0113 0000 408b 302d     ...D{.&......@-0
 1001c12:	408b 322d 408b 342d 408b 362d 002b 0000     .@-2.@-4.@-6+...
 1001c22:	a0ab 0010 21f3 7c00 f193 0011 012b 0021     .....!.|....+.!.
 1001c32:	a1ab 0031 2273 7c00 7213 0012 0113 0000     ..1.s".|.r......
 1001c42:	508b 302d 508b 322d 508b 342d 508b 362d     .P-0.P-2.P-4.P-6
 1001c52:	62b3 0032 0db3 000d 8663 0202 f0ef eccf     .b2.....c.......
 1001c62:	0613 000d f0ef de1f 9663 0001 0d93 180d     ........c.......
 1001c72:	006f 0140 1663 0002 0d93 0c0d 006f 0080     o.@.c.......o...
 1001c82:	0d93 240d f0ef ea4f 0613 000d f0ef db9f     ...$..O.........
 1001c92:	0013 0000 0113 00c0 01b7 0000 8193 1c01     ................
 1001ca2:	c08b 0021 c08b 0221 972b 00cf 00ef 0500     ..!...!.+.......
 1001cb2:	e50b 000c 658b 000d f0ef e58f 0113 00c0     .....e..........
 1001cc2:	01b7 0000 8193 2001 c08b 0021 c08b 0221     ....... ..!...!.
 1001cd2:	122b 00c8 b2ab 00d8 020b 0048 828b 0058     +.........H...X.
 1001ce2:	0113 0040 508b 0024 508b 0224 8067 0000     ..@..P$..P$.g...
 1001cf2:	1073 c000 1073 c000 1073 c000 412b 4026     s...s...s...+A&@
 1001d02:	b1ab 01f6 b1fb 8021 317b 81f1 c82b 001f     ......!.{1..+...
 1001d12:	e88b 000f 107b 00b6 650b 0008 e58b 0008     ....{....e......
 1001d22:	f0ef df8f 012b 0021 a1ab 0031 2173 7c00     ....+.!...1.s!.|
 1001d32:	7113 0011 0863 0001 e50b 000e 658b 000f     .q..c........e..
 1001d42:	f0ef dd8f 0013 0000 8067 0000               ........g...

01001d4e <sha256_text>:
 1001d4e:	0f13 0200 0537 0000 0513 1405 00ef 0140     ....7.........@.
 1001d5e:	0137 0000 0113 0001 400b 0001 0073 0000     7........@..s...
 1001d6e:	effb 01ff 5a7b 01f0 ba7b e14f 0a93 0150     ....{Z..{.O...P.
 1001d7e:	0b13 0160 0b93 0170 0113 01e0 01b7 0000     ..`...p.........
 1001d8e:	8193 0001 c00b 0021 0137 0000 0113 0201     ......!.7.......
 1001d9e:	0193 01d0 400b 0031 007b 007f 410b 0175     .....@1.{....Au.
 1001dae:	00ef 0300 e00b 815b 410b 0175 00ef 0240     ......[..Au...@.
 1001dbe:	e00b 816b 00ef 03c0 0013 0000 0113 01e0     ..k.............
 1001dce:	01b7 0000 8193 0001 d00b 0021 8067 0000     ..........!.g...
 1001dde:	ac7b 017e acfb 437e ad7b 457e adfb 477e     {.~...~C{.~E..~G
 1001dee:	cbfb 038c 4bfb 037d cbfb 037d 8067 0000     .....K}...}.g...
 1001dfe:	15b7 0000 8593 c005 d10b 0155 d10b 0165     ..........U...e.
 1001e0e:	11fb 0150 187b 0120 2bfb 716a bc7b 21fb     ..P.{. ..+jq{..!
 1001e1e:	fcfb 118b fd7b 138b bc7b 0b7f 6dfb 799c     ....{...{....m.y
 1001e2e:	edfb 79ad 2bfb 495a bc7b 21fb fcfb 078b     ...y.+ZI{..!....
 1001e3e:	bd7b 138b fc7b 037f 6e7b 799c 6e7b 79ae     {...{...{n.y{n.y
 1001e4e:	8c2b 496d 0c2b 01cc 0c2b 015c 3afb 215b     +.mI+...+.\..:[!
 1001e5e:	3b7b 216c d10b 0155 d10b 0165 6b8b 000f     {;l!..U...e..k..
 1001e6e:	15b7 0000 8593 c005 0637 0000 0613 0406     ........7.......
 1001e7e:	147b 0280 c10b 0155 410b 0166 147b 0240     {.....U..Af.{.@.
 1001e8e:	2c7b 597a 3cfb 21fc 3d7b 079c 7dfb 0b9c     {,zY.<.!{=...}..
 1001e9e:	7e7b 199c 6e7b 01ae 6e7b 01be 2d7b 517c     {~..{n..{n..{-|Q
 1001eae:	5c7b 0180 2dfb 497c 6d7b 01bd 8cab 79cb     {\...-|I{m.....y
 1001ebe:	8cab 01ac 8cab 016c 8cab 015c 2c7b 797a     ......l...\.{,zy
 1001ece:	3d7b 037c 7dfb 0d7c 3e7b 177c 6e7b 01ae     {=|..}|.{>|.{n..
 1001ede:	6e7b 01be 2d7b 717c 2dfb 697c 6d7b 01bd     {n..{-|q.-|i{m..
 1001eee:	adfb 497b 2dfb 69ba 6d7b 01bd 0d2b 79cd     ..{I.-.i{m..+..y
 1001efe:	8d2b 01ac 3bfb 217d ac7b 194b ebfb 018b     +....;}!{.K.....
 1001f0e:	8c2b 598c 2c7b 014c cbfb 198b bafb 215f     +..Y{,L......._!
 1001f1e:	bb7b 216f 0013 0000 0c2b 017f 3f7b 21ec     {.o!....+...{?.!
 1001f2e:	0c2b 497f 3f7b 21ec 0c2b 517f 3f7b 21ec     +..I{?.!+..Q{?.!
 1001f3e:	0c2b 597f 3f7b 21ec 0c2b 617f 3f7b 21ec     +..Y{?.!+..a{?.!
 1001f4e:	0c2b 697f 3f7b 21ec 0c2b 717f 3f7b 21ec     +..i{?.!+..q{?.!
 1001f5e:	0c2b 797f 3f7b 21ec 8067 0000               +..y{?.!g...

01001f6a <sha512_text>:
 1001f6a:	00ef 0240 11b7 0000 8193 9041 a183 0001     ..@.......A.....
 1001f7a:	0113 0000 1a7b 0010 c10b 0021 0113 0011     ....{.....!.....
 1001f8a:	0073 0000 effb 01ff 1a37 0000 0a13 900a     s.......7.......
 1001f9a:	2a03 000a 18b7 0000 8893 9048 a883 0008     .*........H.....
 1001faa:	1737 0000 0713 9087 2703 0007 0513 00a0     7........'......
 1001fba:	0593 00b0 0993 0160 16b7 0000 8693 c006     ......`.........
 1001fca:	1837 0000 0813 9208 007b 170a 8613 0006     7.......{.......
 1001fda:	0113 0130 127b 0020 410b 0027 510b 0026     ..0.{. ..A'..Q&.
 1001fea:	0113 0011 187b 0490 b97b 81f9 b8fb 413f     ....{...{.....?A
 1001ffa:	f7fb 0128 b87b 0928 e7fb 0107 f87b 072f     ..(.{.(.....{./.
 100200a:	e7fb 0107 8bab 70f9 8bab 515b 397b c1fb     .......p..[Q{9..
 100201a:	b8fb 816f f7fb 1328 f87b 3d28 e7fb 0107     ..o...(.{.(=....
 100202a:	b87b 072f e7fb 0107 8bab 70fb b97b c1f9     {./........p{...
 100203a:	b8fb 813f f7fb 0128 b87b 0928 e7fb 0107     ..?...(.{.(.....
 100204a:	f87b 072f e7fb 0107 8c2b 513f 0c2b 70fc     {./.....+.?Q+..p
 100205a:	0c2b 615c b8fb c16f f7fb 1368 f87b 3d68     +.\a..o...h.{.h=
 100206a:	e7fb 0107 b87b 076f e7fb 0107 0c2b 70fc     ....{.o.....+..p
 100207a:	b8fb c13f f7fb 0138 b87b 0938 e7fb 0107     ..?...8.{.8.....
 100208a:	f87b 073f e7fb 0107 8cab 613f 8cab 70fc     {.?.......?a...p
 100209a:	8cab 715c b97b 41fb f7fb 132b f87b 3d2b     ..\q{..A..+.{.+=
 10020aa:	e7fb 0107 b87b 072f e7fb 0107 8cab 70fc     ....{./........p
 10020ba:	397b 41fa 77fb 012a 387b 092a e7fb 0107     {9.A.w*.{8*.....
 10020ca:	f87b 072f e7fb 0107 8d2b 713f 0d2b 70fd     {./.....+.?q+..p
 10020da:	0d2b 016d 397b 41fc 77fb 132c 787b 3d2c     +.m.{9.A.w,.{x,=
 10020ea:	e7fb 0107 b87b 072f e7fb 0107 0d2b 70fd     ....{./.....+..p
 10020fa:	698b 000a ea0b 000a 6a8b 000b bb7b 416b     .i.......j..{.kA
 100210a:	3b7b 416c bb7b 416c 3b7b 416d 510b 0136     {;lA{.lA{;mA.Q6.
 100211a:	0113 0000 c08b 0028 c08b 0228 c08b 0428     ......(...(...(.
 100212a:	c08b 0628 c08b 0828 c08b 0a28 c08b 0c28     ..(...(...(...(.
 100213a:	c08b 0e28 8613 0006 0793 0008 157b 0fc0     ..(.........{...
 100214a:	c10b 00a7 410b 00b6 3b7b 41f0 37fb 1d60     .....A..{;.A.7`.
 100215a:	3afb 2360 e7fb 0157 7afb 2760 e7fb 0157     .:`#..W..z`'..W.
 100216a:	287b 0010 2afb 0020 687b 0158 aafb 0020     {(...* .{hX... .
 100217a:	687b 0158 b8fb c0ff 88ab 0108 3b7b 41f2     {hX.........{;.A
 100218a:	397b 0f62 3afb 1362 697b 0159 79fb 2962     {9b..:b.{iY..yb)
 100219a:	697b 0139 29fb 0052 5afb 0040 aafb 006a     {i9..)R..Z@...j.
 10021aa:	e9fb 0159 ba7b c12f 0a2b 007a 0a2b 00aa     ..Y.{./.+.z.+...
 10021ba:	8aab 0135 0a2b 015a 81ab 0141 03ab 011a     ..5.+.Z...A.....
 10021ca:	bb7b 41f3 b7fb 1d63 bafb 2363 e7fb 0157     {..A..c...c#..W.
 10021da:	fafb 2763 e7fb 0157 a87b 0003 aafb 0013     ..c'..W.{.......
 10021ea:	687b 0158 2afb 0010 687b 0158 b8fb c0ff     {hX..*..{hX.....
 10021fa:	88ab 0108 bb7b 41f1 b97b 0f61 bafb 1361     ....{..A{.a...a.
 100220a:	697b 0159 f9fb 2961 697b 0139 a9fb 0041     {iY...a){i9...A.
 100221a:	5afb 0030 aafb 005a e9fb 0159 ba7b c12f     .Z0...Z...Y.{./.
 100222a:	0a2b 006a 0a2b 50aa bafb 40bf 8aab 013a     +.j.+..P...@..:.
 100223a:	0a2b 015a 012b 0141 032b 011a 3b7b 41f3     +.Z.+.A.+...{;.A
 100224a:	37fb 1d63 3afb 2363 e7fb 0157 7afb 2763     .7c..:c#..W..zc'
 100225a:	e7fb 0157 287b 0073 2afb 0003 687b 0158     ..W.{(s..*..{hX.
 100226a:	aafb 0003 687b 0158 b8fb c0ff 88ab 0108     ....{hX.........
 100227a:	3b7b 41f1 397b 0f61 3afb 1361 697b 0159     {;.A{9a..:a.{iY.
 100228a:	79fb 2961 697b 0139 29fb 0031 5afb 0020     .ya){i9..)1..Z .
 100229a:	aafb 004a e9fb 0159 ba7b c12f 0a2b 005a     ..J...Y.{./.+.Z.
 10022aa:	0a2b 60aa bafb 80bf 8aab 013a 0a2b 015a     +..`......:.+.Z.
 10022ba:	80ab 0140 02ab 011a bb7b 41f2 b7fb 1d62     ..@.....{..A..b.
 10022ca:	bafb 2362 e7fb 0157 fafb 2762 e7fb 0157     ..b#..W...b'..W.
 10022da:	a87b 0062 aafb 0072 687b 0158 2afb 0073     {.b...r.{hX..*s.
 10022ea:	687b 0158 b8fb c0ff 88ab 0108 bb7b 41f0     {hX.........{..A
 10022fa:	b97b 0f60 bafb 1360 697b 0159 f9fb 2960     {.`...`.{iY...`)
 100230a:	697b 0139 a9fb 0020 5afb 0010 aafb 003a     {i9... ..Z....:.
 100231a:	e9fb 0159 ba7b c12f 0a2b 004a 0a2b 70aa     ..Y.{./.+.J.+..p
 100232a:	bafb c0bf 8aab 013a 0a2b 015a 002b 0140     ......:.+.Z.+.@.
 100233a:	022b 011a c10b 00a7 410b 00b6 3b7b 41f2     +........A..{;.A
 100234a:	37fb 1d62 3afb 2362 e7fb 0157 7afb 2762     .7b..:b#..W..zb'
 100235a:	e7fb 0157 287b 0052 2afb 0062 687b 0158     ..W.{(R..*b.{hX.
 100236a:	aafb 0062 687b 0158 b8fb c0ff 88ab 0108     ..b.{hX.........
 100237a:	3b7b 41f0 397b 0f60 3afb 1360 697b 0159     {;.A{9`..:`.{iY.
 100238a:	79fb 2960 697b 0139 29fb 0010 5afb 0000     .y`){i9..)...Z..
 100239a:	aafb 002a e9fb 0159 ba7b c12f 0a2b 003a     ..*...Y.{./.+.:.
 10023aa:	0a2b 40aa bafb 00bf 8aab 013a 0a2b 015a     +..@......:.+.Z.
 10023ba:	83ab 0143 01ab 011a bb7b 41f1 b7fb 1d61     ..C.....{..A..a.
 10023ca:	bafb 2361 e7fb 0157 fafb 2761 e7fb 0157     ..a#..W...a'..W.
 10023da:	a87b 0041 aafb 0051 687b 0158 2afb 0052     {.A...Q.{hX..*R.
 10023ea:	687b 0158 b8fb c0ff 88ab 0108 bb7b 41f3     {hX.........{..A
 10023fa:	b97b 0f63 bafb 1363 697b 0159 f9fb 2963     {.c...c.{iY...c)
 100240a:	697b 0139 a9fb 0003 5afb 0070 aafb 001a     {i9......Zp.....
 100241a:	e9fb 0159 ba7b c12f 0a2b 002a 0a2b 50aa     ..Y.{./.+.*.+..P
 100242a:	bafb 40bf 8aab 013a 0a2b 015a 032b 0143     ...@..:.+.Z.+.C.
 100243a:	012b 011a 3b7b 41f1 37fb 1d61 3afb 2361     +...{;.A.7a..:a#
 100244a:	e7fb 0157 7afb 2761 e7fb 0157 287b 0031     ..W..za'..W.{(1.
 100245a:	2afb 0041 687b 0158 aafb 0041 687b 0158     .*A.{hX...A.{hX.
 100246a:	b8fb c0ff 88ab 0108 3b7b 41f3 397b 0f63     ........{;.A{9c.
 100247a:	3afb 1363 697b 0159 79fb 2963 697b 0139     .:c.{iY..yc){i9.
 100248a:	29fb 0073 5afb 0060 aafb 000a e9fb 0159     .)s..Z`.......Y.
 100249a:	ba7b c12f 0a2b 001a 0a2b 60aa bafb 80bf     {./.+...+..`....
 10024aa:	8aab 013a 0a2b 015a 82ab 0142 00ab 011a     ..:.+.Z...B.....
 10024ba:	bb7b 41f0 b7fb 1d60 bafb 2360 e7fb 0157     {..A..`...`#..W.
 10024ca:	fafb 2760 e7fb 0157 a87b 0020 aafb 0030     ..`'..W.{. ...0.
 10024da:	687b 0158 2afb 0031 687b 0158 b8fb c0ff     {hX..*1.{hX.....
 10024ea:	88ab 0108 bb7b 41f2 b97b 0f62 bafb 1362     ....{..A{.b...b.
 10024fa:	697b 0159 f9fb 2962 697b 0139 a9fb 0062     {iY...b){i9...b.
 100250a:	5afb 0050 aafb 007a e9fb 0159 ba7b c12f     .ZP...z...Y.{./.
 100251a:	0a2b 000a 0a2b 70aa bafb c0bf 8aab 013a     +...+..p......:.
 100252a:	0a2b 015a 022b 0142 002b 011a 0113 00f0     +.Z.+.B.+.......
 100253a:	c00b 0028 07ab 00f0 d00b 0028 c00b 0228     ..(.......(...(.
 100254a:	87ab 00f0 d00b 0228 c00b 0428 07ab 00f1     ......(...(.....
 100255a:	d00b 0428 c00b 0628 87ab 00f1 d00b 0628     ..(...(.......(.
 100256a:	c00b 0828 07ab 00f2 d00b 0828 c00b 0a28     ..(.......(...(.
 100257a:	87ab 00f2 d00b 0a28 c00b 0c28 07ab 00f3     ......(...(.....
 100258a:	d00b 0c28 c00b 0e28 87ab 00f3 d00b 0e28     ..(...(.......(.
 100259a:	8067 0000                                   g...

0100259e <sm3_dmem>:
 100259e:	00ff 0000 00ff 0000 00ff 0000 00ff 0000     ................
 10025ae:	00ff 0000 00ff 0000 00ff 0000 00ff 0000     ................
 10025be:	4519 79cc 8a32 f398 1465 e731 28cb ce62     .E.y2...e.1..(b.
 10025ce:	5197 9cc4 a32f 3988 465e 7311 8cbc e622     .Q../..9^F.s..".
 10025de:	1979 cc45 32f3 988a 65e7 3114 cbce 6228     y.E..2...e.1..(b
 10025ee:	979c c451 2f39 88a3 5e73 1146 bce6 228c     ..Q.9/..s^F...."
 10025fe:	7a87 9d8a f50f 3b14 ea1e 7629 d43c ec53     .z.....;..)v<.S.
 100260e:	a879 d8a7 50f3 b14f a1e7 629e 43ce c53d     y....PO....b.C=.
 100261e:	879d 8a7a 0f3b 14f5 1e76 29ea 3cec 53d4     ..z.;...v..).<.S
 100262e:	79d8 a7a8 f3b1 4f50 e762 9ea1 cec5 3d43     .y....POb.....C=
 100263e:	9d8a 7a87 3b14 f50f 7629 ea1e ec53 d43c     ...z.;..)v..S.<.
 100264e:	d8a7 a879 b14f 50f3 629e a1e7 c53d 43ce     ..y.O..P.b..=..C
 100265e:	8a7a 879d 14f5 0f3b 29ea 1e76 53d4 3cec     z.....;..)v..S.<
 100266e:	a7a8 79d8 4f50 f3b1 9ea1 e762 3d43 cec5     ...yPO....b.C=..
 100267e:	7a87 9d8a f50f 3b14 ea1e 7629 d43c ec53     .z.....;..)v<.S.
 100268e:	a879 d8a7 50f3 b14f a1e7 629e 43ce c53d     y....PO....b.C=.
 100269e:	879d 8a7a 0f3b 14f5 1e76 29ea 3cec 53d4     ..z.;...v..).<.S
 10026ae:	79d8 a7a8 f3b1 4f50 e762 9ea1 cec5 3d43     .y....POb.....C=
 10026be:	166f 7380 b2b9 4914 42d7 1724 0600 da8a     o..s...I.B$.....
 10026ce:	30bc a96f 38aa 1631 ee4d e38d 0e4e b0fb     .0o..81.M...N...

010026de <sm3_text>:
 10026de:	1137 0000 0113 bc01 2f03 0001 0537 0000     7......../..7...
 10026ee:	0513 3805 00ef 0080 0073 0000 effb 01ff     ...8....s.......
 10026fe:	5a7b 01f0 ba7b e14f 0113 01e0 01b7 0000     {Z..{.O.........
 100270e:	8193 1201 c00b 0021 01b7 0000 8193 1401     ......!.........
 100271e:	d00b 0021 007b 015f 0a93 0150 0b13 0160     ..!.{._...P...`.
 100272e:	0b93 0170 0137 0000 0113 0001 0193 01d0     ..p.7...........
 100273e:	400b 0031 410b 0175 00ef 03c0 e00b 815b     .@1..Au.......[.
 100274e:	410b 0175 00ef 0300 e00b 816b 00ef 0480     .Au.......k.....
 100275e:	0113 01e0 01b7 0000 8193 1401 d00b 0021     ..............!.
 100276e:	0237 0000 0213 1202 500b 0022 0013 0000     7........P".....
 100277e:	8067 0000 ac7b 017e acfb 437e ad7b 457e     g...{.~...~C{.~E
 100278e:	adfb 477e cbfb 038c 4bfb 037d cbfb 037d     ..~G.....K}...}.
 100279e:	8067 0000 05b7 0000 8593 1605 d10b 0155     g.............U.
 10027ae:	d10b 0165 13fb 0200 147b 01d0 2bfb 015a     ..e.....{....+Z.
 10027be:	bc7b e15f 2c7b 018a bcfb a16f 2cfb 019a     {._.{,....o..,..
 10027ce:	bd7b 615f 2d7b 01aa bdfb 416f 2dfb 01ba     {._a{-....oA.-..
 10027de:	fe7b f1fc fefb 119f 4cfb 01de 2cfb 019a     {........L...,..
 10027ee:	ee7b 018b 6e7b 019e 7efb f1fe ff7b 11cf     {...{n...~..{...
 10027fe:	cefb 01ee 7f7b e9fe fc7b 09cf 4c7b 018f     ....{...{...{L..
 100280e:	6e7b 01de 6e7b 018e 7efb f9fd ff7b 19af     {n..{n...~..{...
 100281e:	cd7b 01ee 6e7b 01ae 6bfb 01be 3afb 215b     {...{n...k...:[!
 100282e:	bb7b 216b d00b 0165 8593 0205 0637 0000     {.k!..e.....7...
 100283e:	0613 2806 06b7 0000 8693 1606 14fb 0050     ...(..........P.
 100284e:	c10b 0156 c00b 0166 bafb 815f 3b7b 81fb     ..V...f..._.{;..
 100285e:	cafb 016a 510b 0156 0637 0000 0613 2806     ..j..QV.7......(
 100286e:	06b7 0000 8693 1606 147b 0030 400b 0156     ........{.0..@V.
 100287e:	c10b 0166 eafb 016a 510b 0156 0113 0170     ..f...j..QV...p.
 100288e:	01b7 0000 8193 1401 c00b 0021 05b7 0000     ..........!.....
 100289e:	8593 2805 0637 0000 0613 0206 06b7 0000     ...(7...........
 10028ae:	8693 1606 0793 00d0 0713 0000 c10b 0155     ..............U.
 10028be:	c10b 0166 410b 00f6 147b 0780 147b 0740     ..f..A..{...{.@.
 10028ce:	2c7b 017a b7fb 158f 387b f5fc 287b 010a     {,z.....{8..{(..
 10028de:	c7fb 0107 e70b 0007 2cfb 617a 87ab 0197     .........,za....
 10028ee:	27fb 00fa 2dfb 00da b6fb 20df 87ab 01b7     .'...-..... ....
 10028fe:	27fb 00fa f87b f9f7 f7fb 18ff 47fb 00f8     .'..{........G..
 100290e:	27fb 00fa e77b 00e7 2c7b 417a bcfb 217f     .'..{...{,zA...!
 100291e:	2cfb 019a bd7b 417f 2d7b 01aa 0813 0100     .,..{..A{-......
 100292e:	0833 4107 5813 01f8 0863 0208 6c7b 019c     3..A.X..c...{l..
 100293e:	6c7b 01ac bdfb 817f 2dfb 01ba bcfb a17f     {l.......-......
 100294e:	2cfb 019a bd7b c17f 2d7b 01aa edfb 019d     .,..{...{-......
 100295e:	ecfb 01ad 1063 0408 2dfb 019c 2e7b 01ac     ....c....-..{...
 100296e:	aefb 01ac cdfb 01cd cc7b 01dd bdfb 817f     ........{.......
 100297e:	2dfb 01ba bcfb a17f 2cfb 019a bd7b c17f     .-.......,..{...
 100298e:	2d7b 01aa ae7b 019d 5dfb 01b0 aefb 01ad     {-..{....]......
 100299e:	ccfb 01ce bd7b 617f 2d7b 01aa 2dfb 015a     ....{..a{-...-Z.
 10029ae:	bafb 215f 8dab 00ed 8dab 01ad 872b 018d     .._!........+...
 10029be:	277b 00ea bd7b e17f 2d7b 01aa 2dfb 016a     {'..{...{-...-j.
 10029ce:	bb7b 216f 0d2b 00fd 0d2b 01bd 07ab 019d     {.o!+...+.......
 10029de:	27fb 00fa bc7b e1fb 3cfb 41fa 5cfb 0190     .'..{....<.A.\..
 10029ee:	2c7b 019c 3cfb 81fa 5cfb 0190 2c7b 019c     {,...<...\..{,..
 10029fe:	3cfb c1fa 5cfb 0190 2c7b 019c 5cfb 0140     .<...\..{,...\@.
 1002a0e:	2c7b 019c bcfb 217f 2cfb 019a fd7b 179f     {,.....!.,..{...
 1002a1e:	fdfb f7fc 4d7b 01bd 2d7b 01aa 3d7b c1fd     ....{M..{-..{=..
 1002a2e:	4c7b 01ac bcfb a17f 2cfb 019a fd7b 0d9f     {L.......,..{...
 1002a3e:	fdfb edfc 4d7b 01bd 2d7b 01aa 3d7b 41fd     ....{M..{-..{=.A
 1002a4e:	4c7b 01ac 277b 00ea 4c7b 00ec ed8b 0007     {L..{'..{L......
 1002a5e:	fcfb 16ff fd7b f7f7 ccfb 01ac 2cfb 019a     ....{........,..
 1002a6e:	edfb 01bc fcfb 0eff fd7b eff7 ccfb 01ac     ........{.......
 1002a7e:	2cfb 019a edfb 01bc bdfb 81fd 4bfb 01bc     .,...........K..
 1002a8e:	0113 0170 01b7 0000 8193 1401 d00b 0021     ..p...........!.
 1002a9e:	0713 0017 c10b 0155 c10b 0166 410b 00f6     ......U...f..A..
 1002aae:	0113 0180 01b7 0000 8193 1201 c00b 0021     ..............!.
 1002abe:	ef7b 018b 8067 0000 0000                    {...g.....

01002ac8 <sm2_dmem_size>:
 1002ac8:	00f0 0000                                   ....

01002acc <sm2_imem_size>:
 1002acc:	0ae0 0000                                   ....

01002ad0 <sm2_dmem>:
 1002ad0:	0e93 4d94 bd41 ddbc 8f92 15ab 89f5 f397     ...MA...........
 1002ae0:	09a7 cf65 9e4b 4d5a 5e34 9d9f fa9e 28e9     ..e.K.ZM4^.....(
 1002af0:	ffff ffff ffff ffff 0000 0000 ffff ffff     ................
 1002b00:	ffff ffff ffff ffff ffff ffff fffe ffff     ................
 1002b10:	0003 0000 0002 0000 0002 0000 0002 0000     ................
 1002b20:	0001 0000 0001 0000 0001 0000 0001 0000     ................
 1002b30:	4123 39d5 f409 53bb 052b 21c6 df6b 7203     #A.9...S+..!k..r
 1002b40:	ffff ffff ffff ffff ffff ffff fffe ffff     ................
 1002b50:	49a0 f151 6361 12ac 3c01 fa32 2096 8dfc     .IQ.ac...<2.. ..
 1002b60:	0001 0000 0001 0000 0001 0000 0001 0000     ................
 1002b70:	74c7 334c 4589 715a 0be1 f266 0bbf 8fe3     .tL3.EZq..f.....
 1002b80:	c994 6a39 0446 5f99 8119 1f19 ae2c 32c4     ..9jF.._....,..2
 1002b90:	f0a0 2139 32e5 02df 4740 c62a 877c d0a9     ..9!.2..@G*.|...
 1002ba0:	2153 6b69 cee3 59bd 779c f4f6 36a2 bc37     S!ik...Y.w...67.
 1002bb0:	0468 1105 0000 0000 0000 0000 0000 0000     h...............

01002bc0 <sm2_imem>:
 1002bc0:	0137 0000 0113 1401 2103 0001 0193 3d40     7........!....@=
 1002bd0:	0863 0231 0193 15b0 0a63 0431 0193 7270     c.1.....c.1...pr
 1002be0:	0a63 0431 0193 5ec0 0e63 0831 0193 5e80     c.1....^c.1....^
 1002bf0:	0663 0631 1073 c000 1073 c000 1073 c000     c.1.s...s...s...
 1002c00:	effb 01ff 00ef 0b10 0113 0140 0a37 0000     ..........@.7...
 1002c10:	0a13 0e0a 400b 002a 0a37 0000 0a13 160a     .....@*.7.......
 1002c20:	500b 002a 00ef 4b80 0073 0000 00ef 7380     .P*....Ks......s
 1002c30:	0073 0000 0ab7 0000 8a93 240a 0b37 0000     s..........$7...
 1002c40:	0b13 260b 00ef 5280 1663 0005 006f 4f80     ...&...Rc...o..O
 1002c50:	1073 c000 00ef 0d50 0073 0000 0ab7 0000     s.....P.s.......
 1002c60:	8a93 240a 0b37 0000 0b13 260b 00ef 5000     ...$7......&...P
 1002c70:	1663 0005 006f 4d00 1073 c000 006f 4dc0     c...o..Ms...o..M
 1002c80:	0073 0000 0ab7 0000 8a93 240a 0b37 0000     s..........$7...
 1002c90:	0b13 260b 00ef 4d80 1663 0005 006f 4a80     ...&...Mc...o..J
 1002ca0:	1073 c000 00ef 5480 0073 0000 1173 7c00     s......Ts...s..|
 1002cb0:	7113 0081 5113 0031 0133 4020 0193 01f0     .q...Q1.3. @....
 1002cc0:	400b 0031 effb 01ff 8067 0000 7afb ff3a     .@1.....g....z:.
 1002cd0:	903b 01ca a03b 03ca abbb 49ca 803b 05ca     ;...;......I;...
 1002ce0:	803b 0bca 803b 11ca a03b 07ca a03b 0dca     ;...;...;...;...
 1002cf0:	a03b 13ca abbb 79ca 803b 0fca 803b 15ca     ;......y;...;...
 1002d00:	803b 1bca a03b 17ca ac3b 5dca 8c3b 7fca     ;...;...;..];...
 1002d10:	0a2b 01fa fcfb ff4f 0c2b 015c acab 01fc     +.....O.+.\.....
 1002d20:	0c2b 016c acab 01fc fafb 018c 903b 015e     +.l.........;.^.
 1002d30:	a03b 035e ab3b 495e 803b 055e 803b 0b5e     ;.^.;.^I;.^.;.^.
 1002d40:	803b 115e a03b 075e a03b 0d5e a03b 135e     ;.^.;.^.;.^.;.^.
 1002d50:	ab3b 795e 803b 0f5e 803b 155e 803b 1b5e     ;.^y;.^.;.^.;.^.
 1002d60:	a03b 175e abbb 5d5e 8bbb 7f5e 8bab 01fb     ;.^...^]..^.....
 1002d70:	9b2b 0169 3a2b 017a 8a8b 05fe 1aab 015b     +.i.+:z.......[.
 1002d80:	d9ab 01fa 8067 0000 103b 019c 203b 039c     ....g...;...; ..
 1002d90:	29bb 499c 003b 059c 003b 0b9c 003b 119c     .).I;...;...;...
 1002da0:	203b 079c 203b 0d9c 203b 139c 29bb 799c     ; ..; ..; ...).y
 1002db0:	003b 0f9c 003b 159c 003b 1b9c 203b 179c     ;...;...;...; ..
 1002dc0:	2a3b 5d9c 0a3b 7f9c 0b0b 03fe f0ef f01f     ;*.];...........
 1002dd0:	8067 0000 ec0b 0005 6c8b 0004 f0ef fadf     g........l......
 1002de0:	e70b 0009 6c0b 0006 ec8b 0004 f0ef f9df     .....l..........
 1002df0:	e78b 0009 ec0b 0006 6c8b 0005 f0ef f8df     .........l......
 1002e00:	e80b 0009 d8ab 00c5 592b 0094 ec0b 0008     ........+Y......
 1002e10:	6c8b 0009 f0ef f75f 592b 00f7 d8ab 4129     .l...._.+Y....)A
 1002e20:	592b 00d6 d9ab 00a4 6c0b 0009 ec8b 0009     +Y.......l......
 1002e30:	f0ef f59f e90b 0009 d9ab 0107 592b 4139     ............+Y9A
 1002e40:	d9ab 00d5 562b 00a4 ec0b 0009 6c8b 0006     ....+V.......l..
 1002e50:	f0ef f39f e58b 0009 562b 0107 d62b 40c5     ........+V..+..@
 1002e60:	ec0b 000d 6c8b 0008 f0ef f21f 55ab 4136     .....l.......U6A
 1002e70:	d6ab 00b5 d5ab 00d5 d6ab 40b7 d5ab 00b7     ...........@....
 1002e80:	ec0b 000d 6c8b 0006 f0ef f01f 57ab 0108     .....l.......W..
 1002e90:	d82b 0107 d62b 4109 562b 40e6 57ab 00c6     +...+..A+V.@.W..
 1002ea0:	d62b 00c7 57ab 00e7 d72b 00e7 572b 4107     +....W..+...+W.A
 1002eb0:	6c0b 0009 6c8b 0006 f0ef ed1f e78b 0009     .l...l..........
 1002ec0:	6c0b 0007 6c8b 0006 f0ef ec1f e80b 0009     .l...l..........
 1002ed0:	ec0b 0005 ec8b 0006 f0ef eb1f d62b 0109     ............+...
 1002ee0:	ec0b 0008 ec8b 0005 f0ef ea1f d5ab 40f9     ...............@
 1002ef0:	6c0b 0009 ec8b 0006 f0ef e91f e68b 0009     .l..............
 1002f00:	ec0b 0008 6c8b 0007 f0ef e81f d6ab 0136     .....l........6.
 1002f10:	8067 0000 600b 0005 00ef 02c0 e70b 0000     g....`..........
 1002f20:	6c0b 0007 6c8b 0004 f0ef e61f e58b 0009     .l...l..........
 1002f30:	6c0b 0007 ec8b 0004 f0ef e51f e60b 0009     .l..............
 1002f40:	8067 0000 710b 0000 412b 4021 c0ab 001f     g....q..+A!@....
 1002f50:	107b 00d4 ec0b 0000 ec8b 0000 f0ef e2df     {...............
 1002f60:	e18b 0009 012b 0021 808b 0030 2173 7c00     ....+.!...0.s!.|
 1002f70:	7113 0011 0a63 0001 ec0b 0001 6c8b 0000     .q..c........l..
 1002f80:	f0ef e09f e08b 0009 0013 0000 8067 0000     ............g...
 1002f90:	c82b 001f c00b 00aa 6c8b 0008 f0ef dedf     +........l......
 1002fa0:	e70b 0009 400b 00ab 6c8b 0008 f0ef dddf     .....@...l......
 1002fb0:	e78b 0009 8067 0000 658b 0004 e60b 0004     ....g....e......
 1002fc0:	668b 0005 f0ef e11f 8067 0000 effb 01ff     .f......g.......
 1002fd0:	0113 01d0 01b7 0000 8193 0201 c00b 0021     ..............!.
 1002fe0:	f00b 800e 0113 01c0 01b7 0000 8193 0401     ................
 1002ff0:	c00b 0021 0113 01b0 01b7 0000 8193 0001     ..!.............
 1003000:	c00b 0021 0513 0180 f0ef f89f 640b 0007     ..!..........d..
 1003010:	e48b 0007 650b 0008 f0ef fa1f e20b 0005     .....e..........
 1003020:	628b 0006 e30b 0006 e40b 000f c4ab 001f     .b..............
 1003030:	e50b 000f b0fb 4000 307b 41f0 b1fb 4021     .......@{0.A..!@
 1003040:	317b 41f1 107b 0215 f0ef f71f f0ef f45f     {1.A{........._.
 1003050:	ea7b 0030 040b 0247 848b 0257 050b 0268     {.0...G...W...h.
 1003060:	e38b 0005 6d0b 0006 ef0b 0006 f0ef d69f     .....m..........
 1003070:	ca7b 0030 840b 0275 048b 03a6 850b 03e6     {.0...u.........
 1003080:	f0fb fe00 707b fff0 f1fb fe21 717b fff1     ....{p....!.{q..
 1003090:	e58b 000f e60b 000f e68b 000f e38b 000f     ................
 10030a0:	6c0b 0002 ec8b 0003 f0ef ce1f e20b 0009     .l..............
 10030b0:	ec0b 0002 ec8b 0003 f0ef cd1f e28b 0009     ................
 10030c0:	6c0b 0003 ec8b 0003 f0ef cc1f e30b 0009     .l..............
 10030d0:	100b 01f5 f0ef bd9f 8067 0000 0837 0000     ........g...7...
 10030e0:	0813 1608 0113 0000 410b 0028 0113 0010     .........A(.....
 10030f0:	400b 0028 0837 0000 0813 1a08 0113 0020     .@(.7......... .
 1003100:	410b 0028 0113 0030 400b 0028 0ab7 0000     .A(...0..@(.....
 1003110:	8a93 0a0a 0b37 0000 0b13 0c0b f0ef eb1f     ....7...........
 1003120:	f0ef df5f 0113 00b0 0ab7 0000 8a93 240a     .._............$
 1003130:	d08b 002a 0b37 0000 0b13 260b 500b 002b     ..*.7......&.P+.
 1003140:	8067 0000 0137 0000 0113 3201 0193 1d40     g...7......2..@.
 1003150:	2023 0031 0073 0000 0137 0000 0113 3201     # 1.s...7......2
 1003160:	0193 7390 2023 0031 0073 0000 effb 01ff     ...s# 1.s.......
 1003170:	0113 01d0 01b7 0000 8193 0201 c00b 0021     ..............!.
 1003180:	f00b 800e 0113 01c0 01b7 0000 8193 0401     ................
 1003190:	c00b 0021 0113 01b0 01b7 0000 8193 0001     ..!.............
 10031a0:	c00b 0021 0513 01a0 c00b 00aa 6c0b 000d     ..!..........l..
 10031b0:	6c8b 000d f0ef bd5f cc2b 003f dc2b 4189     .l...._.+.?.+..A
 10031c0:	6c8b 000d f0ef bc5f dd2b 01b9 0513 0180     .l...._.+.......
 10031d0:	400b 00ab 6c8b 000c f0ef bb1f 900b 01a9     .@...l..........
 10031e0:	1573 7c00 7513 0085 8067 0000 effb 01ff     s..|.u..g.......
 10031f0:	0837 0000 0813 1608 0113 0000 410b 0028     7............A(.
 1003200:	0113 0010 400b 0028 0837 0000 0813 1a08     .....@(.7.......
 1003210:	0113 0020 410b 0028 0113 0030 400b 0028     .. ..A(...0..@(.
 1003220:	0ab7 0000 8a93 240a 0b37 0000 0b13 260b     .......$7......&
 1003230:	f0ef d9df c12b 000f 542b 4024 f0ef cd9f     ....+...+T$@....
 1003240:	0113 01f0 0237 0000 0213 2602 500b 0022     ....7......&.P".
 1003250:	0193 00b0 0237 0000 0213 2402 500b 0032     ....7......$.P2.
 1003260:	8067 0000 ec0b 0009 ec8b 0005 e90b 0009     g...............
 1003270:	e98b 000f e60b 000f 00ef 0400 6d0b 000a     .............m..
 1003280:	ed8b 000a 690b 000c e98b 000f e58b 000c     .....i..........
 1003290:	e60b 000f 7e8b 0000 462b 0026 95ab 01d5     .....~..+F&.....
 10032a0:	362b 01f6 00ef 0140 698b 000c 900b 01fa     +6....@..i......
 10032b0:	0a0b 07aa 8067 0000 f9fb 01f9 f9fb ff3f     ....g.........?.
 10032c0:	767b 01f6 f67b fecf c0ab 001f c12b 001f     {v..{.......+...
 10032d0:	f17b fe2f 81ab 0010 222b 0021 727b 01f2     {./.....+"!.{r..
 10032e0:	f27b fe4f ea7b 0120 6afb 0131 a2fb 0140     {.O.{. ..j1...@.
 10032f0:	237b 0151 ea7b 00b1 6afb 00c2 e0fb 0140     {#Q.{....j....@.
 1003300:	617b 0151 a0fb 0120 217b 0131 e2fb 0012     {aQ... .{!1.....
 1003310:	637b 0023 a0fb 00b1 217b 00c2 e2fb 0012     {c#.....{!......
 1003320:	637b 0023 107b 00b4 a0fb 0121 217b 0132     {c#.{.....!.{!2.
 1003330:	e0fb 0050 617b 0061 a1fb 00b1 227b 00c2     ..P.{aa.....{"..
 1003340:	e0fb 0030 617b 0041 81ab 0010 222b 0021     ..0.{aA.....+"!.
 1003350:	727b 01f2 f27b fe4f 6a7b 003a eafb 004a     {r..{.O.{j:...J.
 1003360:	8067 0000 effb 01ff 00ef 14c0 0113 0140     g.............@.
 1003370:	01b7 0000 8193 0e01 c00b 0021 600b 000a     ..........!..`..
 1003380:	e08b 000f e10b 000f e18b 000f 0ab7 0000     ................
 1003390:	8a93 0a0a 0b37 0000 0b13 0c0b f0ef c31f     ....7...........
 10033a0:	f0ef b75f 0113 0180 01b7 0000 8193 1e01     .._.............
 10033b0:	c00b 0021 ec8b 0005 0113 01d0 01b7 0000     ..!.............
 10033c0:	8193 0601 c00b 0021 f00b 800e 0113 01c0     ......!.........
 10033d0:	01b7 0000 8193 0801 c00b 0021 532b 019c     ..........!.+S..
 10033e0:	0113 0050 01b7 0000 8193 1601 c00b 0021     ..P...........!.
 10033f0:	c02b 0012 f0ef b51f 0113 0010 0a37 0000     +...........7...
 1003400:	0a13 3a0a 500b 002a 6c0b 0003 ec8b 0002     ...:.P*..l......
 1003410:	00ef 0d40 e98b 000d 6a0b 000d 0113 01d0     ..@......j......
 1003420:	01b7 0000 8193 0601 c00b 0021 0113 01c0     ..........!.....
 1003430:	01b7 0000 8193 0801 c00b 0021 0b0b 03fe     ..........!.....
 1003440:	f0ef 88df 0113 0140 01b7 0000 8193 0e01     ......@.........
 1003450:	c00b 0021 5c2b 413a 0113 0190 01b7 0000     ..!.+\:A........
 1003460:	8193 3a01 c00b 0021 0113 01d0 01b7 0000     ...:..!.........
 1003470:	8193 0601 c00b 0021 0113 01c0 01b7 0000     ......!.........
 1003480:	8193 0801 c00b 0021 f00b 800e f0ef 8fdf     ......!.........
 1003490:	0a37 0000 0a13 220a 0113 0130 500b 002a     7......"..0..P*.
 10034a0:	0a37 0000 0a13 200a 0113 0060 500b 002a     7...... ..`..P*.
 10034b0:	8067 0000 0113 01d0 01b7 0000 8193 0601     g...............
 10034c0:	c00b 0021 f00b 800e 0113 0140 0a37 0000     ..!.......@.7...
 10034d0:	0a13 0e0a 400b 002a 5a2b 01fa 500b 002a     .....@*.+Z...P*.
 10034e0:	8067 0000 103b 019c 203b 039c 2dbb 499c     g...;...; ...-.I
 10034f0:	003b 059c 003b 0b9c 003b 119c 203b 079c     ;...;...;...; ..
 1003500:	203b 0d9c 203b 139c 2dbb 799c 003b 0f9c     ; ..; ...-.y;...
 1003510:	003b 159c 003b 1b9c 203b 179c 2d3b 5d9c     ;...;...; ..;-.]
 1003520:	0d3b 7f9c 8067 0000 effb 01ff 0113 01b0     ;...g...........
 1003530:	01b7 0000 8193 0001 c00b 0021 0a37 0000     ..........!.7...
 1003540:	0a13 220a 400b 000a 0113 01d0 01b7 0000     ...".@..........
 1003550:	8193 0201 c00b 0021 f00b 800e 0113 01c0     ......!.........
 1003560:	01b7 0000 8193 0401 c00b 0021 0837 0000     ..........!.7...
 1003570:	0813 1208 0113 0010 400b 0028 0113 0020     .........@(... .
 1003580:	400b 0028 0113 0030 400b 0028 0ab7 0000     .@(...0..@(.....
 1003590:	8a93 0a0a 0b37 0000 0b13 0c0b f0ef a31f     ....7...........
 10035a0:	01b7 0000 8193 4201 0113 0080 d10b 0021     .......B......!.
 10035b0:	0113 0090 d10b 0021 0113 00a0 d10b 0021     ......!.......!.
 10035c0:	09b7 0000 8993 2009 0113 0180 c00b 0029     ....... ......).
 10035d0:	0a37 0000 0a13 220a 400b 000a 0113 0190     7......".@......
 10035e0:	01b7 0000 8193 0601 c00b 0021 f00b 800c     ..........!.....
 10035f0:	502b 0180 f00b 800e 0113 0010 400b 0028     +P...........@(.
 1003600:	0113 0020 400b 0028 0113 0030 400b 0028     .. ..@(...0..@(.
 1003610:	0ab7 0000 8a93 240a 0b37 0000 0b13 260b     .......$7......&
 1003620:	f0ef 9adf 01b7 0000 8193 4201 0113 00b0     ...........B....
 1003630:	c10b 0021 0113 00c0 c10b 0021 0113 00d0     ..!.......!.....
 1003640:	c10b 0021 f0ef f90f e40b 0005 648b 0006     ..!..........d..
 1003650:	e50b 0006 f0ef 8c1f 0113 01d0 01b7 0000     ................
 1003660:	8193 0601 c00b 0021 f00b 800e 0113 01c0     ......!.........
 1003670:	01b7 0000 8193 0801 c00b 0021 0113 0180     ..........!.....
 1003680:	01b7 0000 8193 1e01 c00b 0021 5c2b 00bc     ..........!.+\..
 1003690:	01b7 0000 8193 2801 d00b 0021 8067 0000     .......(..!.g...

010036a0 <HAL_OTBN_SM2_ValidPoint_Polling_v2>:
 10036a0:	372082ef          	jal	t0,100ba12 <__riscv_save_0>
 10036a4:	1141                	addi	sp,sp,-16
 10036a6:	5e800793          	li	a5,1512
 10036aa:	c63e                	sw	a5,12(sp)
 10036ac:	010037b7          	lui	a5,0x1003
 10036b0:	acc7a603          	lw	a2,-1332(a5) # 1002acc <sm2_imem_size>
 10036b4:	842e                	mv	s0,a1
 10036b6:	010035b7          	lui	a1,0x1003
 10036ba:	84aa                	mv	s1,a0
 10036bc:	bc058593          	addi	a1,a1,-1088 # 1002bc0 <sm2_imem>
 10036c0:	4501                	li	a0,0
 10036c2:	c402                	sw	zero,8(sp)
 10036c4:	7c4040ef          	jal	1007e88 <HAL_OTBN_IMEM_Write>
 10036c8:	48000613          	li	a2,1152
 10036cc:	4581                	li	a1,0
 10036ce:	4501                	li	a0,0
 10036d0:	7ee040ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 10036d4:	010037b7          	lui	a5,0x1003
 10036d8:	ac87a603          	lw	a2,-1336(a5) # 1002ac8 <sm2_dmem_size>
 10036dc:	010035b7          	lui	a1,0x1003
 10036e0:	ad058593          	addi	a1,a1,-1328 # 1002ad0 <sm2_dmem>
 10036e4:	4501                	li	a0,0
 10036e6:	013040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 10036ea:	006c                	addi	a1,sp,12
 10036ec:	4611                	li	a2,4
 10036ee:	14000513          	li	a0,320
 10036f2:	007040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 10036f6:	85a6                	mv	a1,s1
 10036f8:	02000613          	li	a2,32
 10036fc:	24000513          	li	a0,576
 1003700:	7f8040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1003704:	85a2                	mv	a1,s0
 1003706:	02000613          	li	a2,32
 100370a:	26000513          	li	a0,608
 100370e:	7ea040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1003712:	002c                	addi	a1,sp,8
 1003714:	4611                	li	a2,4
 1003716:	32000513          	li	a0,800
 100371a:	7de040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100371e:	0d800513          	li	a0,216
 1003722:	04f040ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 1003726:	002c                	addi	a1,sp,8
 1003728:	4611                	li	a2,4
 100372a:	32000513          	li	a0,800
 100372e:	005040ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 1003732:	4522                	lw	a0,8(sp)
 1003734:	0141                	addi	sp,sp,16
 1003736:	8c750513          	addi	a0,a0,-1849
 100373a:	00153513          	seqz	a0,a0
 100373e:	2f80806f          	j	100ba36 <__riscv_restore_0>

01003742 <sm3_msg_write>:
 1003742:	2d0082ef          	jal	t0,100ba12 <__riscv_save_0>
 1003746:	1141                	addi	sp,sp,-16
 1003748:	842a                	mv	s0,a0
 100374a:	c62e                	sw	a1,12(sp)
 100374c:	02000613          	li	a2,32
 1003750:	b4818593          	addi	a1,gp,-1208 # 10138348 <currnt_state>
 1003754:	12000513          	li	a0,288
 1003758:	7a0040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100375c:	6505                	lui	a0,0x1
 100375e:	006c                	addi	a1,sp,12
 1003760:	4611                	li	a2,4
 1003762:	bc050513          	addi	a0,a0,-1088 # bc0 <Reset_Handler-0xfff440>
 1003766:	792040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100376a:	4632                	lw	a2,12(sp)
 100376c:	85a2                	mv	a1,s0
 100376e:	38000513          	li	a0,896
 1003772:	061a                	slli	a2,a2,0x6
 1003774:	784040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1003778:	0d800513          	li	a0,216
 100377c:	7f4040ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 1003780:	02000613          	li	a2,32
 1003784:	b4818593          	addi	a1,gp,-1208 # 10138348 <currnt_state>
 1003788:	12000513          	li	a0,288
 100378c:	7a6040ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 1003790:	0141                	addi	sp,sp,16
 1003792:	2a40806f          	j	100ba36 <__riscv_restore_0>

01003796 <HAL_OTBN_SM3_Init>:
 1003796:	27c082ef          	jal	t0,100ba12 <__riscv_save_0>
 100379a:	6605                	lui	a2,0x1
 100379c:	b401a223          	sw	zero,-1212(gp) # 10138344 <totash_sm3_msg_total_len>
 10037a0:	c0060613          	addi	a2,a2,-1024 # c00 <Reset_Handler-0xfff400>
 10037a4:	4581                	li	a1,0
 10037a6:	4501                	li	a0,0
 10037a8:	b401a023          	sw	zero,-1216(gp) # 10138340 <remain_len>
 10037ac:	712040ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 10037b0:	010025b7          	lui	a1,0x1002
 10037b4:	3e800613          	li	a2,1000
 10037b8:	6de58593          	addi	a1,a1,1758 # 10026de <sm3_text>
 10037bc:	4501                	li	a0,0
 10037be:	6ca040ef          	jal	1007e88 <HAL_OTBN_IMEM_Write>
 10037c2:	010025b7          	lui	a1,0x1002
 10037c6:	14000613          	li	a2,320
 10037ca:	59e58593          	addi	a1,a1,1438 # 100259e <sm3_dmem>
 10037ce:	4501                	li	a0,0
 10037d0:	728040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 10037d4:	010045b7          	lui	a1,0x1004
 10037d8:	4621                	li	a2,8
 10037da:	aa858593          	addi	a1,a1,-1368 # 1003aa8 <state_init>
 10037de:	b4818513          	addi	a0,gp,-1208 # 10138348 <currnt_state>
 10037e2:	28f040ef          	jal	1008270 <memcpy32>
 10037e6:	2500806f          	j	100ba36 <__riscv_restore_0>

010037ea <HAL_OTBN_SM3_Update>:
 10037ea:	20e082ef          	jal	t0,100b9f8 <__riscv_save_4>
 10037ee:	b441a703          	lw	a4,-1212(gp) # 10138344 <totash_sm3_msg_total_len>
 10037f2:	b401a783          	lw	a5,-1216(gp) # 10138340 <remain_len>
 10037f6:	972e                	add	a4,a4,a1
 10037f8:	b4e1a223          	sw	a4,-1212(gp) # 10138344 <totash_sm3_msg_total_len>
 10037fc:	00b78933          	add	s2,a5,a1
 1003800:	842a                	mv	s0,a0
 1003802:	00695493          	srli	s1,s2,0x6
 1003806:	03f97a93          	andi	s5,s2,63
 100380a:	c3b1                	beqz	a5,100384e <HAL_OTBN_SM3_Update+0x64>
 100380c:	b0018a13          	addi	s4,gp,-1280 # 10138300 <remain_data>
 1003810:	03f00713          	li	a4,63
 1003814:	01478533          	add	a0,a5,s4
 1003818:	01276a63          	bltu	a4,s2,100382c <HAL_OTBN_SM3_Update+0x42>
 100381c:	862e                	mv	a2,a1
 100381e:	85a2                	mv	a1,s0
 1003820:	2f4080ef          	jal	100bb14 <memcpy>
 1003824:	b521a023          	sw	s2,-1216(gp) # 10138340 <remain_len>
 1003828:	2040806f          	j	100ba2c <__riscv_restore_4>
 100382c:	04000913          	li	s2,64
 1003830:	40f90933          	sub	s2,s2,a5
 1003834:	3c09390b          	th.extu	s2,s2,15,0
 1003838:	85a2                	mv	a1,s0
 100383a:	864a                	mv	a2,s2
 100383c:	2d8080ef          	jal	100bb14 <memcpy>
 1003840:	4585                	li	a1,1
 1003842:	8552                	mv	a0,s4
 1003844:	b401a023          	sw	zero,-1216(gp) # 10138340 <remain_len>
 1003848:	944a                	add	s0,s0,s2
 100384a:	3de5                	jal	1003742 <sm3_msg_write>
 100384c:	14fd                	addi	s1,s1,-1
 100384e:	6905                	lui	s2,0x1
 1003850:	02000a13          	li	s4,32
 1003854:	84090913          	addi	s2,s2,-1984 # 840 <Reset_Handler-0xfff7c0>
 1003858:	c085                	beqz	s1,1003878 <HAL_OTBN_SM3_Update+0x8e>
 100385a:	009a7a63          	bgeu	s4,s1,100386e <HAL_OTBN_SM3_Update+0x84>
 100385e:	8522                	mv	a0,s0
 1003860:	02100593          	li	a1,33
 1003864:	3df9                	jal	1003742 <sm3_msg_write>
 1003866:	fdf48493          	addi	s1,s1,-33
 100386a:	944a                	add	s0,s0,s2
 100386c:	b7f5                	j	1003858 <HAL_OTBN_SM3_Update+0x6e>
 100386e:	85a6                	mv	a1,s1
 1003870:	8522                	mv	a0,s0
 1003872:	049a                	slli	s1,s1,0x6
 1003874:	35f9                	jal	1003742 <sm3_msg_write>
 1003876:	9426                	add	s0,s0,s1
 1003878:	fa0a88e3          	beqz	s5,1003828 <HAL_OTBN_SM3_Update+0x3e>
 100387c:	8656                	mv	a2,s5
 100387e:	85a2                	mv	a1,s0
 1003880:	b0018513          	addi	a0,gp,-1280 # 10138300 <remain_data>
 1003884:	290080ef          	jal	100bb14 <memcpy>
 1003888:	b551a023          	sw	s5,-1216(gp) # 10138340 <remain_len>
 100388c:	bf71                	j	1003828 <HAL_OTBN_SM3_Update+0x3e>

0100388e <HAL_OTBN_SM3_Final>:
 100388e:	15c082ef          	jal	t0,100b9ea <__riscv_save_10>
 1003892:	b401a703          	lw	a4,-1216(gp) # 10138340 <remain_len>
 1003896:	b441ab03          	lw	s6,-1212(gp) # 10138344 <totash_sm3_msg_total_len>
 100389a:	00170793          	addi	a5,a4,1
 100389e:	842a                	mv	s0,a0
 10038a0:	f8000693          	li	a3,-128
 10038a4:	b0018513          	addi	a0,gp,-1280 # 10138300 <remain_data>
 10038a8:	00e5568b          	th.srb	a3,a0,a4,0
 10038ac:	b4f1a023          	sw	a5,-1216(gp) # 10138340 <remain_len>
 10038b0:	04000713          	li	a4,64
 10038b4:	0b0e                	slli	s6,s6,0x3
 10038b6:	00e79763          	bne	a5,a4,10038c4 <HAL_OTBN_SM3_Final+0x36>
 10038ba:	4585                	li	a1,1
 10038bc:	3559                	jal	1003742 <sm3_msg_write>
 10038be:	4781                	li	a5,0
 10038c0:	b401a023          	sw	zero,-1216(gp) # 10138340 <remain_len>
 10038c4:	03800a13          	li	s4,56
 10038c8:	aff18913          	addi	s2,gp,-1281 # 101382ff <interrupt_vector+0x2bf>
 10038cc:	04000b93          	li	s7,64
 10038d0:	4581                	li	a1,0
 10038d2:	07479663          	bne	a5,s4,100393e <HAL_OTBN_SM3_Final+0xb0>
 10038d6:	00058463          	beqz	a1,10038de <HAL_OTBN_SM3_Final+0x50>
 10038da:	b4f1a023          	sw	a5,-1216(gp) # 10138340 <remain_len>
 10038de:	4901                	li	s2,0
 10038e0:	b3f18a13          	addi	s4,gp,-1217 # 1013833f <remain_data+0x3f>
 10038e4:	5be1                	li	s7,-8
 10038e6:	03790633          	mul	a2,s2,s7
 10038ea:	855a                	mv	a0,s6
 10038ec:	4581                	li	a1,0
 10038ee:	0ca080ef          	jal	100b9b8 <__lshrdi3>
 10038f2:	012a550b          	th.srb	a0,s4,s2,0
 10038f6:	197d                	addi	s2,s2,-1
 10038f8:	ff7917e3          	bne	s2,s7,10038e6 <HAL_OTBN_SM3_Final+0x58>
 10038fc:	4585                	li	a1,1
 10038fe:	b0018513          	addi	a0,gp,-1280 # 10138300 <remain_data>
 1003902:	3581                	jal	1003742 <sm3_msg_write>
 1003904:	b4818793          	addi	a5,gp,-1208 # 10138348 <currnt_state>
 1003908:	02040693          	addi	a3,s0,32
 100390c:	0037c703          	lbu	a4,3(a5)
 1003910:	0411                	addi	s0,s0,4
 1003912:	fee40e23          	sb	a4,-4(s0)
 1003916:	0027d703          	lhu	a4,2(a5)
 100391a:	fee40ea3          	sb	a4,-3(s0)
 100391e:	4398                	lw	a4,0(a5)
 1003920:	8321                	srli	a4,a4,0x8
 1003922:	fee40f23          	sb	a4,-2(s0)
 1003926:	5847c70b          	th.lwia	a4,(a5),4,0
 100392a:	fee40fa3          	sb	a4,-1(s0)
 100392e:	fcd41fe3          	bne	s0,a3,100390c <HAL_OTBN_SM3_Final+0x7e>
 1003932:	b401a223          	sw	zero,-1212(gp) # 10138344 <totash_sm3_msg_total_len>
 1003936:	b401a023          	sw	zero,-1216(gp) # 10138340 <remain_len>
 100393a:	0e80806f          	j	100ba22 <__riscv_restore_10>
 100393e:	0785                	addi	a5,a5,1
 1003940:	00f9500b          	th.srb	zero,s2,a5,0
 1003944:	4585                	li	a1,1
 1003946:	f97796e3          	bne	a5,s7,10038d2 <HAL_OTBN_SM3_Final+0x44>
 100394a:	b0018513          	addi	a0,gp,-1280 # 10138300 <remain_data>
 100394e:	b4f1a023          	sw	a5,-1216(gp) # 10138340 <remain_len>
 1003952:	3bc5                	jal	1003742 <sm3_msg_write>
 1003954:	4781                	li	a5,0
 1003956:	b401a023          	sw	zero,-1216(gp) # 10138340 <remain_len>
 100395a:	bf9d                	j	10038d0 <HAL_OTBN_SM3_Final+0x42>

0100395c <HAL_OTBN_SM3_KDF>:
 100395c:	c549                	beqz	a0,10039e6 <HAL_OTBN_SM3_KDF+0x8a>
 100395e:	08c082ef          	jal	t0,100b9ea <__riscv_save_10>
 1003962:	8a2a                	mv	s4,a0
 1003964:	7179                	addi	sp,sp,-48
 1003966:	4501                	li	a0,0
 1003968:	c68d                	beqz	a3,1003992 <HAL_OTBN_SM3_KDF+0x36>
 100396a:	8aae                	mv	s5,a1
 100396c:	c19d                	beqz	a1,1003992 <HAL_OTBN_SM3_KDF+0x36>
 100396e:	8b32                	mv	s6,a2
 1003970:	c20d                	beqz	a2,1003992 <HAL_OTBN_SM3_KDF+0x36>
 1003972:	01f68993          	addi	s3,a3,31
 1003976:	0059d993          	srli	s3,s3,0x5
 100397a:	4401                	li	s0,0
 100397c:	02000b93          	li	s7,32
 1003980:	fff98c13          	addi	s8,s3,-1
 1003984:	01f6f913          	andi	s2,a3,31
 1003988:	00140493          	addi	s1,s0,1
 100398c:	01341663          	bne	s0,s3,1003998 <HAL_OTBN_SM3_KDF+0x3c>
 1003990:	4505                	li	a0,1
 1003992:	6145                	addi	sp,sp,48
 1003994:	08e0806f          	j	100ba22 <__riscv_restore_10>
 1003998:	0184d793          	srli	a5,s1,0x18
 100399c:	00f10623          	sb	a5,12(sp)
 10039a0:	0104d793          	srli	a5,s1,0x10
 10039a4:	00f106a3          	sb	a5,13(sp)
 10039a8:	0084d793          	srli	a5,s1,0x8
 10039ac:	00f10723          	sb	a5,14(sp)
 10039b0:	009107a3          	sb	s1,15(sp)
 10039b4:	33cd                	jal	1003796 <HAL_OTBN_SM3_Init>
 10039b6:	85d6                	mv	a1,s5
 10039b8:	8552                	mv	a0,s4
 10039ba:	3d05                	jal	10037ea <HAL_OTBN_SM3_Update>
 10039bc:	4591                	li	a1,4
 10039be:	0068                	addi	a0,sp,12
 10039c0:	352d                	jal	10037ea <HAL_OTBN_SM3_Update>
 10039c2:	0808                	addi	a0,sp,16
 10039c4:	35e9                	jal	100388e <HAL_OTBN_SM3_Final>
 10039c6:	87ca                	mv	a5,s2
 10039c8:	408c0733          	sub	a4,s8,s0
 10039cc:	412b978b          	th.mveqz	a5,s7,s2
 10039d0:	40e79b8b          	th.mveqz	s7,a5,a4
 10039d4:	0416                	slli	s0,s0,0x5
 10039d6:	008b0533          	add	a0,s6,s0
 10039da:	865e                	mv	a2,s7
 10039dc:	080c                	addi	a1,sp,16
 10039de:	136080ef          	jal	100bb14 <memcpy>
 10039e2:	8426                	mv	s0,s1
 10039e4:	b755                	j	1003988 <HAL_OTBN_SM3_KDF+0x2c>
 10039e6:	4501                	li	a0,0
 10039e8:	8082                	ret

010039ea <HAL_OTBN_SM3_HMAC>:
 10039ea:	00e082ef          	jal	t0,100b9f8 <__riscv_save_4>
 10039ee:	04000793          	li	a5,64
 10039f2:	711d                	addi	sp,sp,-96
 10039f4:	89aa                	mv	s3,a0
 10039f6:	8a2e                	mv	s4,a1
 10039f8:	8ab2                	mv	s5,a2
 10039fa:	84b6                	mv	s1,a3
 10039fc:	843a                	mv	s0,a4
 10039fe:	00e7fb63          	bgeu	a5,a4,1003a14 <HAL_OTBN_SM3_HMAC+0x2a>
 1003a02:	3b51                	jal	1003796 <HAL_OTBN_SM3_Init>
 1003a04:	85a2                	mv	a1,s0
 1003a06:	8526                	mv	a0,s1
 1003a08:	33cd                	jal	10037ea <HAL_OTBN_SM3_Update>
 1003a0a:	850a                	mv	a0,sp
 1003a0c:	3549                	jal	100388e <HAL_OTBN_SM3_Final>
 1003a0e:	02000413          	li	s0,32
 1003a12:	848a                	mv	s1,sp
 1003a14:	4781                	li	a5,0
 1003a16:	02010913          	addi	s2,sp,32
 1003a1a:	04f41f63          	bne	s0,a5,1003a78 <HAL_OTBN_SM3_HMAC+0x8e>
 1003a1e:	87a2                	mv	a5,s0
 1003a20:	04000593          	li	a1,64
 1003a24:	03600693          	li	a3,54
 1003a28:	0ff7f713          	zext.b	a4,a5
 1003a2c:	04b71e63          	bne	a4,a1,1003a88 <HAL_OTBN_SM3_HMAC+0x9e>
 1003a30:	339d                	jal	1003796 <HAL_OTBN_SM3_Init>
 1003a32:	04000593          	li	a1,64
 1003a36:	854a                	mv	a0,s2
 1003a38:	3b4d                	jal	10037ea <HAL_OTBN_SM3_Update>
 1003a3a:	85d6                	mv	a1,s5
 1003a3c:	8552                	mv	a0,s4
 1003a3e:	3375                	jal	10037ea <HAL_OTBN_SM3_Update>
 1003a40:	854e                	mv	a0,s3
 1003a42:	35b1                	jal	100388e <HAL_OTBN_SM3_Final>
 1003a44:	4781                	li	a5,0
 1003a46:	04f41563          	bne	s0,a5,1003a90 <HAL_OTBN_SM3_HMAC+0xa6>
 1003a4a:	04000593          	li	a1,64
 1003a4e:	05c00713          	li	a4,92
 1003a52:	0ff47793          	zext.b	a5,s0
 1003a56:	04b79563          	bne	a5,a1,1003aa0 <HAL_OTBN_SM3_HMAC+0xb6>
 1003a5a:	3b35                	jal	1003796 <HAL_OTBN_SM3_Init>
 1003a5c:	854a                	mv	a0,s2
 1003a5e:	04000593          	li	a1,64
 1003a62:	3361                	jal	10037ea <HAL_OTBN_SM3_Update>
 1003a64:	02000593          	li	a1,32
 1003a68:	854e                	mv	a0,s3
 1003a6a:	3341                	jal	10037ea <HAL_OTBN_SM3_Update>
 1003a6c:	854e                	mv	a0,s3
 1003a6e:	3505                	jal	100388e <HAL_OTBN_SM3_Final>
 1003a70:	4501                	li	a0,0
 1003a72:	6125                	addi	sp,sp,96
 1003a74:	7b90706f          	j	100ba2c <__riscv_restore_4>
 1003a78:	80f4c70b          	th.lrbu	a4,s1,a5,0
 1003a7c:	03674713          	xori	a4,a4,54
 1003a80:	00f9570b          	th.srb	a4,s2,a5,0
 1003a84:	0785                	addi	a5,a5,1
 1003a86:	bf51                	j	1003a1a <HAL_OTBN_SM3_HMAC+0x30>
 1003a88:	00f9568b          	th.srb	a3,s2,a5,0
 1003a8c:	0785                	addi	a5,a5,1
 1003a8e:	bf69                	j	1003a28 <HAL_OTBN_SM3_HMAC+0x3e>
 1003a90:	80f4c70b          	th.lrbu	a4,s1,a5,0
 1003a94:	05c74713          	xori	a4,a4,92
 1003a98:	00f9570b          	th.srb	a4,s2,a5,0
 1003a9c:	0785                	addi	a5,a5,1
 1003a9e:	b765                	j	1003a46 <HAL_OTBN_SM3_HMAC+0x5c>
 1003aa0:	0089570b          	th.srb	a4,s2,s0,0
 1003aa4:	0405                	addi	s0,s0,1
 1003aa6:	b775                	j	1003a52 <HAL_OTBN_SM3_HMAC+0x68>

01003aa8 <state_init>:
 1003aa8:	166f 7380 b2b9 4914 42d7 1724 0600 da8a     o..s...I.B$.....
 1003ab8:	30bc a96f 38aa 1631 ee4d e38d 0e4e b0fb     .0o..81.M...N...

01003ac8 <get_hash_outLength>:
 1003ac8:	157d                	addi	a0,a0,-1
 1003aca:	478d                	li	a5,3
 1003acc:	00a7e963          	bltu	a5,a0,1003ade <get_hash_outLength+0x16>
 1003ad0:	010047b7          	lui	a5,0x1004
 1003ad4:	c6a78793          	addi	a5,a5,-918 # 1003c6a <CSWTCH.11>
 1003ad8:	80a7c50b          	th.lrbu	a0,a5,a0,0
 1003adc:	8082                	ret
 1003ade:	4501                	li	a0,0
 1003ae0:	8082                	ret

01003ae2 <HAL_OTBN_HASH_Init>:
 1003ae2:	731072ef          	jal	t0,100ba12 <__riscv_save_0>
 1003ae6:	4709                	li	a4,2
 1003ae8:	00e50e63          	beq	a0,a4,1003b04 <HAL_OTBN_HASH_Init+0x22>
 1003aec:	4711                	li	a4,4
 1003aee:	87aa                	mv	a5,a0
 1003af0:	00e50c63          	beq	a0,a4,1003b08 <HAL_OTBN_HASH_Init+0x26>
 1003af4:	4705                	li	a4,1
 1003af6:	4501                	li	a0,0
 1003af8:	00e79463          	bne	a5,a4,1003b00 <HAL_OTBN_HASH_Init+0x1e>
 1003afc:	227d                	jal	1003caa <HAL_OTBN_SHA256_Init>
 1003afe:	4505                	li	a0,1
 1003b00:	7370706f          	j	100ba36 <__riscv_restore_0>
 1003b04:	235d                	jal	10040aa <HAL_OTBN_SHA384_Init>
 1003b06:	bfe5                	j	1003afe <HAL_OTBN_HASH_Init+0x1c>
 1003b08:	3ff000ef          	jal	1004706 <HAL_OTBN_SHA512_Init>
 1003b0c:	bfcd                	j	1003afe <HAL_OTBN_HASH_Init+0x1c>

01003b0e <HAL_OTBN_HASH_Update>:
 1003b0e:	705072ef          	jal	t0,100ba12 <__riscv_save_0>
 1003b12:	87aa                	mv	a5,a0
 1003b14:	4709                	li	a4,2
 1003b16:	852e                	mv	a0,a1
 1003b18:	85b2                	mv	a1,a2
 1003b1a:	00e78e63          	beq	a5,a4,1003b36 <HAL_OTBN_HASH_Update+0x28>
 1003b1e:	4711                	li	a4,4
 1003b20:	00e78d63          	beq	a5,a4,1003b3a <HAL_OTBN_HASH_Update+0x2c>
 1003b24:	4685                	li	a3,1
 1003b26:	4701                	li	a4,0
 1003b28:	00d79463          	bne	a5,a3,1003b30 <HAL_OTBN_HASH_Update+0x22>
 1003b2c:	2419                	jal	1003d32 <HAL_OTBN_SHA256_Update>
 1003b2e:	4705                	li	a4,1
 1003b30:	853a                	mv	a0,a4
 1003b32:	7050706f          	j	100ba36 <__riscv_restore_0>
 1003b36:	2509                	jal	1004138 <HAL_OTBN_SHA384_Update>
 1003b38:	bfdd                	j	1003b2e <HAL_OTBN_HASH_Update+0x20>
 1003b3a:	45b000ef          	jal	1004794 <HAL_OTBN_SHA512_Update>
 1003b3e:	bfc5                	j	1003b2e <HAL_OTBN_HASH_Update+0x20>

01003b40 <HAL_OTBN_HASH_Final>:
 1003b40:	6d3072ef          	jal	t0,100ba12 <__riscv_save_0>
 1003b44:	87aa                	mv	a5,a0
 1003b46:	4709                	li	a4,2
 1003b48:	852e                	mv	a0,a1
 1003b4a:	00e78e63          	beq	a5,a4,1003b66 <HAL_OTBN_HASH_Final+0x26>
 1003b4e:	4711                	li	a4,4
 1003b50:	00e78d63          	beq	a5,a4,1003b6a <HAL_OTBN_HASH_Final+0x2a>
 1003b54:	4685                	li	a3,1
 1003b56:	4701                	li	a4,0
 1003b58:	00d79463          	bne	a5,a3,1003b60 <HAL_OTBN_HASH_Final+0x20>
 1003b5c:	249d                	jal	1003dc2 <HAL_OTBN_SHA256_Final>
 1003b5e:	4705                	li	a4,1
 1003b60:	853a                	mv	a0,a4
 1003b62:	6d50706f          	j	100ba36 <__riscv_restore_0>
 1003b66:	258d                	jal	10041c8 <HAL_OTBN_SHA384_Final>
 1003b68:	bfdd                	j	1003b5e <HAL_OTBN_HASH_Final+0x1e>
 1003b6a:	4bb000ef          	jal	1004824 <HAL_OTBN_SHA512_Final>
 1003b6e:	bfc5                	j	1003b5e <HAL_OTBN_HASH_Final+0x1e>

01003b70 <HAL_OTBN_HASH>:
 1003b70:	6a3072ef          	jal	t0,100ba12 <__riscv_save_0>
 1003b74:	1141                	addi	sp,sp,-16
 1003b76:	842a                	mv	s0,a0
 1003b78:	84b6                	mv	s1,a3
 1003b7a:	c62e                	sw	a1,12(sp)
 1003b7c:	c432                	sw	a2,8(sp)
 1003b7e:	3795                	jal	1003ae2 <HAL_OTBN_HASH_Init>
 1003b80:	4622                	lw	a2,8(sp)
 1003b82:	45b2                	lw	a1,12(sp)
 1003b84:	8522                	mv	a0,s0
 1003b86:	3761                	jal	1003b0e <HAL_OTBN_HASH_Update>
 1003b88:	85a6                	mv	a1,s1
 1003b8a:	8522                	mv	a0,s0
 1003b8c:	3f55                	jal	1003b40 <HAL_OTBN_HASH_Final>
 1003b8e:	0141                	addi	sp,sp,16
 1003b90:	6a70706f          	j	100ba36 <__riscv_restore_0>

01003b94 <HAL_OTBN_HASH_HMAC>:
 1003b94:	657072ef          	jal	t0,100b9ea <__riscv_save_10>
 1003b98:	fff50913          	addi	s2,a0,-1
 1003b9c:	8b3e                	mv	s6,a5
 1003b9e:	00193913          	seqz	s2,s2
 1003ba2:	ffe50793          	addi	a5,a0,-2
 1003ba6:	8aba                	mv	s5,a4
 1003ba8:	9bf5                	andi	a5,a5,-3
 1003baa:	091a                	slli	s2,s2,0x6
 1003bac:	08000713          	li	a4,128
 1003bb0:	40f7190b          	th.mveqz	s2,a4,a5
 1003bb4:	7131                	addi	sp,sp,-192
 1003bb6:	842a                	mv	s0,a0
 1003bb8:	8a2e                	mv	s4,a1
 1003bba:	8bb2                	mv	s7,a2
 1003bbc:	84b6                	mv	s1,a3
 1003bbe:	00d97e63          	bgeu	s2,a3,1003bda <HAL_OTBN_HASH_HMAC+0x46>
 1003bc2:	3705                	jal	1003ae2 <HAL_OTBN_HASH_Init>
 1003bc4:	8626                	mv	a2,s1
 1003bc6:	85de                	mv	a1,s7
 1003bc8:	8522                	mv	a0,s0
 1003bca:	3791                	jal	1003b0e <HAL_OTBN_HASH_Update>
 1003bcc:	858a                	mv	a1,sp
 1003bce:	8522                	mv	a0,s0
 1003bd0:	3f85                	jal	1003b40 <HAL_OTBN_HASH_Final>
 1003bd2:	8522                	mv	a0,s0
 1003bd4:	3dd5                	jal	1003ac8 <get_hash_outLength>
 1003bd6:	84aa                	mv	s1,a0
 1003bd8:	8b8a                	mv	s7,sp
 1003bda:	4681                	li	a3,0
 1003bdc:	04010993          	addi	s3,sp,64
 1003be0:	04d49d63          	bne	s1,a3,1003c3a <HAL_OTBN_HASH_HMAC+0xa6>
 1003be4:	86a6                	mv	a3,s1
 1003be6:	03600793          	li	a5,54
 1003bea:	0726e063          	bltu	a3,s2,1003c4a <HAL_OTBN_HASH_HMAC+0xb6>
 1003bee:	8522                	mv	a0,s0
 1003bf0:	3dcd                	jal	1003ae2 <HAL_OTBN_HASH_Init>
 1003bf2:	864a                	mv	a2,s2
 1003bf4:	85ce                	mv	a1,s3
 1003bf6:	8522                	mv	a0,s0
 1003bf8:	3f19                	jal	1003b0e <HAL_OTBN_HASH_Update>
 1003bfa:	865a                	mv	a2,s6
 1003bfc:	85d6                	mv	a1,s5
 1003bfe:	8522                	mv	a0,s0
 1003c00:	3739                	jal	1003b0e <HAL_OTBN_HASH_Update>
 1003c02:	85d2                	mv	a1,s4
 1003c04:	8522                	mv	a0,s0
 1003c06:	3f2d                	jal	1003b40 <HAL_OTBN_HASH_Final>
 1003c08:	4781                	li	a5,0
 1003c0a:	04f49463          	bne	s1,a5,1003c52 <HAL_OTBN_HASH_HMAC+0xbe>
 1003c0e:	05c00793          	li	a5,92
 1003c12:	0524e863          	bltu	s1,s2,1003c62 <HAL_OTBN_HASH_HMAC+0xce>
 1003c16:	8522                	mv	a0,s0
 1003c18:	35e9                	jal	1003ae2 <HAL_OTBN_HASH_Init>
 1003c1a:	864a                	mv	a2,s2
 1003c1c:	85ce                	mv	a1,s3
 1003c1e:	8522                	mv	a0,s0
 1003c20:	35fd                	jal	1003b0e <HAL_OTBN_HASH_Update>
 1003c22:	8522                	mv	a0,s0
 1003c24:	3555                	jal	1003ac8 <get_hash_outLength>
 1003c26:	862a                	mv	a2,a0
 1003c28:	85d2                	mv	a1,s4
 1003c2a:	8522                	mv	a0,s0
 1003c2c:	35cd                	jal	1003b0e <HAL_OTBN_HASH_Update>
 1003c2e:	85d2                	mv	a1,s4
 1003c30:	8522                	mv	a0,s0
 1003c32:	3739                	jal	1003b40 <HAL_OTBN_HASH_Final>
 1003c34:	6129                	addi	sp,sp,192
 1003c36:	5ed0706f          	j	100ba22 <__riscv_restore_10>
 1003c3a:	80dbc78b          	th.lrbu	a5,s7,a3,0
 1003c3e:	0367c793          	xori	a5,a5,54
 1003c42:	00d9d78b          	th.srb	a5,s3,a3,0
 1003c46:	0685                	addi	a3,a3,1
 1003c48:	bf61                	j	1003be0 <HAL_OTBN_HASH_HMAC+0x4c>
 1003c4a:	00d9d78b          	th.srb	a5,s3,a3,0
 1003c4e:	0685                	addi	a3,a3,1
 1003c50:	bf69                	j	1003bea <HAL_OTBN_HASH_HMAC+0x56>
 1003c52:	80fbc70b          	th.lrbu	a4,s7,a5,0
 1003c56:	05c74713          	xori	a4,a4,92
 1003c5a:	00f9d70b          	th.srb	a4,s3,a5,0
 1003c5e:	0785                	addi	a5,a5,1
 1003c60:	b76d                	j	1003c0a <HAL_OTBN_HASH_HMAC+0x76>
 1003c62:	0099d78b          	th.srb	a5,s3,s1,0
 1003c66:	0485                	addi	s1,s1,1
 1003c68:	b76d                	j	1003c12 <HAL_OTBN_HASH_HMAC+0x7e>

01003c6a <CSWTCH.11>:
 1003c6a:	3020 4000                                    0.@

01003c6e <sha256_msg_write>:
 1003c6e:	5a5072ef          	jal	t0,100ba12 <__riscv_save_0>
 1003c72:	85aa                	mv	a1,a0
 1003c74:	bb01a503          	lw	a0,-1104(gp) # 101383b0 <index>
 1003c78:	04000613          	li	a2,64
 1003c7c:	27c040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1003c80:	bb01a783          	lw	a5,-1104(gp) # 101383b0 <index>
 1003c84:	6705                	lui	a4,0x1
 1003c86:	94070713          	addi	a4,a4,-1728 # 940 <Reset_Handler-0xfff6c0>
 1003c8a:	04078793          	addi	a5,a5,64
 1003c8e:	baf1a823          	sw	a5,-1104(gp) # 101383b0 <index>
 1003c92:	00e79a63          	bne	a5,a4,1003ca6 <sha256_msg_write+0x38>
 1003c96:	0d800513          	li	a0,216
 1003c9a:	2d6040ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 1003c9e:	14000793          	li	a5,320
 1003ca2:	baf1a823          	sw	a5,-1104(gp) # 101383b0 <index>
 1003ca6:	5910706f          	j	100ba36 <__riscv_restore_0>

01003caa <HAL_OTBN_SHA256_Init>:
 1003caa:	569072ef          	jal	t0,100ba12 <__riscv_save_0>
 1003cae:	1141                	addi	sp,sp,-16
 1003cb0:	6605                	lui	a2,0x1
 1003cb2:	ba01a623          	sw	zero,-1108(gp) # 101383ac <totasha256_hmac_cnt>
 1003cb6:	14000713          	li	a4,320
 1003cba:	ba01a423          	sw	zero,-1112(gp) # 101383a8 <remain_len>
 1003cbe:	c0060613          	addi	a2,a2,-1024 # c00 <Reset_Handler-0xfff400>
 1003cc2:	4581                	li	a1,0
 1003cc4:	4501                	li	a0,0
 1003cc6:	bae1a823          	sw	a4,-1104(gp) # 101383b0 <index>
 1003cca:	1f4040ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 1003cce:	010025b7          	lui	a1,0x1002
 1003cd2:	21c00613          	li	a2,540
 1003cd6:	d4e58593          	addi	a1,a1,-690 # 1001d4e <sha256_text>
 1003cda:	4501                	li	a0,0
 1003cdc:	1ac040ef          	jal	1007e88 <HAL_OTBN_IMEM_Write>
 1003ce0:	010045b7          	lui	a1,0x1004
 1003ce4:	02000613          	li	a2,32
 1003ce8:	ff458593          	addi	a1,a1,-12 # 1003ff4 <state_init>
 1003cec:	4501                	li	a0,0
 1003cee:	20a040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1003cf2:	02000613          	li	a2,32
 1003cf6:	010045b7          	lui	a1,0x1004
 1003cfa:	fd458593          	addi	a1,a1,-44 # 1003fd4 <bswap32_mask>
 1003cfe:	8532                	mv	a0,a2
 1003d00:	1f8040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1003d04:	010045b7          	lui	a1,0x1004
 1003d08:	10000613          	li	a2,256
 1003d0c:	ed458593          	addi	a1,a1,-300 # 1003ed4 <K>
 1003d10:	04000513          	li	a0,64
 1003d14:	1e4040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1003d18:	020017b7          	lui	a5,0x2001
 1003d1c:	f1378793          	addi	a5,a5,-237 # 2000f13 <__boot_rom_data_lma__+0xff53d3>
 1003d20:	006c                	addi	a1,sp,12
 1003d22:	4611                	li	a2,4
 1003d24:	4501                	li	a0,0
 1003d26:	c63e                	sw	a5,12(sp)
 1003d28:	160040ef          	jal	1007e88 <HAL_OTBN_IMEM_Write>
 1003d2c:	0141                	addi	sp,sp,16
 1003d2e:	5090706f          	j	100ba36 <__riscv_restore_0>

01003d32 <HAL_OTBN_SHA256_Update>:
 1003d32:	4c7072ef          	jal	t0,100b9f8 <__riscv_save_4>
 1003d36:	bac1a783          	lw	a5,-1108(gp) # 101383ac <totasha256_hmac_cnt>
 1003d3a:	ba81a903          	lw	s2,-1112(gp) # 101383a8 <remain_len>
 1003d3e:	97ae                	add	a5,a5,a1
 1003d40:	baf1a623          	sw	a5,-1108(gp) # 101383ac <totasha256_hmac_cnt>
 1003d44:	842a                	mv	s0,a0
 1003d46:	84ae                	mv	s1,a1
 1003d48:	04090463          	beqz	s2,1003d90 <HAL_OTBN_SHA256_Update+0x5e>
 1003d4c:	b6818a93          	addi	s5,gp,-1176 # 10138368 <remain_data>
 1003d50:	00b90a33          	add	s4,s2,a1
 1003d54:	03f00793          	li	a5,63
 1003d58:	01590533          	add	a0,s2,s5
 1003d5c:	0147ea63          	bltu	a5,s4,1003d70 <HAL_OTBN_SHA256_Update+0x3e>
 1003d60:	862e                	mv	a2,a1
 1003d62:	85a2                	mv	a1,s0
 1003d64:	5b1070ef          	jal	100bb14 <memcpy>
 1003d68:	bb41a423          	sw	s4,-1112(gp) # 101383a8 <remain_len>
 1003d6c:	4c10706f          	j	100ba2c <__riscv_restore_4>
 1003d70:	04000a13          	li	s4,64
 1003d74:	412a0a33          	sub	s4,s4,s2
 1003d78:	85a2                	mv	a1,s0
 1003d7a:	8652                	mv	a2,s4
 1003d7c:	599070ef          	jal	100bb14 <memcpy>
 1003d80:	8556                	mv	a0,s5
 1003d82:	fc090913          	addi	s2,s2,-64
 1003d86:	35e5                	jal	1003c6e <sha256_msg_write>
 1003d88:	94ca                	add	s1,s1,s2
 1003d8a:	ba01a423          	sw	zero,-1112(gp) # 101383a8 <remain_len>
 1003d8e:	9452                	add	s0,s0,s4
 1003d90:	fc04f913          	andi	s2,s1,-64
 1003d94:	9922                	add	s2,s2,s0
 1003d96:	03241163          	bne	s0,s2,1003db8 <HAL_OTBN_SHA256_Update+0x86>
 1003d9a:	03f4f493          	andi	s1,s1,63
 1003d9e:	d4f9                	beqz	s1,1003d6c <HAL_OTBN_SHA256_Update+0x3a>
 1003da0:	ba81a503          	lw	a0,-1112(gp) # 101383a8 <remain_len>
 1003da4:	b6818793          	addi	a5,gp,-1176 # 10138368 <remain_data>
 1003da8:	8626                	mv	a2,s1
 1003daa:	85a2                	mv	a1,s0
 1003dac:	953e                	add	a0,a0,a5
 1003dae:	567070ef          	jal	100bb14 <memcpy>
 1003db2:	ba91a423          	sw	s1,-1112(gp) # 101383a8 <remain_len>
 1003db6:	bf5d                	j	1003d6c <HAL_OTBN_SHA256_Update+0x3a>
 1003db8:	8522                	mv	a0,s0
 1003dba:	3d55                	jal	1003c6e <sha256_msg_write>
 1003dbc:	04040413          	addi	s0,s0,64
 1003dc0:	bfd9                	j	1003d96 <HAL_OTBN_SHA256_Update+0x64>

01003dc2 <HAL_OTBN_SHA256_Final>:
 1003dc2:	437072ef          	jal	t0,100b9f8 <__riscv_save_4>
 1003dc6:	ba81a703          	lw	a4,-1112(gp) # 101383a8 <remain_len>
 1003dca:	bac1aa03          	lw	s4,-1108(gp) # 101383ac <totasha256_hmac_cnt>
 1003dce:	00170793          	addi	a5,a4,1
 1003dd2:	842a                	mv	s0,a0
 1003dd4:	f8000693          	li	a3,-128
 1003dd8:	b6818513          	addi	a0,gp,-1176 # 10138368 <remain_data>
 1003ddc:	1101                	addi	sp,sp,-32
 1003dde:	00e5568b          	th.srb	a3,a0,a4,0
 1003de2:	baf1a423          	sw	a5,-1112(gp) # 101383a8 <remain_len>
 1003de6:	04000713          	li	a4,64
 1003dea:	0a0e                	slli	s4,s4,0x3
 1003dec:	00e79663          	bne	a5,a4,1003df8 <HAL_OTBN_SHA256_Final+0x36>
 1003df0:	3dbd                	jal	1003c6e <sha256_msg_write>
 1003df2:	4781                	li	a5,0
 1003df4:	ba01a423          	sw	zero,-1112(gp) # 101383a8 <remain_len>
 1003df8:	03800a93          	li	s5,56
 1003dfc:	b6718993          	addi	s3,gp,-1177 # 10138367 <currnt_state+0x1f>
 1003e00:	04000b13          	li	s6,64
 1003e04:	4701                	li	a4,0
 1003e06:	0b579863          	bne	a5,s5,1003eb6 <HAL_OTBN_SHA256_Final+0xf4>
 1003e0a:	00070463          	beqz	a4,1003e12 <HAL_OTBN_SHA256_Final+0x50>
 1003e0e:	baf1a423          	sw	a5,-1112(gp) # 101383a8 <remain_len>
 1003e12:	4481                	li	s1,0
 1003e14:	ba718993          	addi	s3,gp,-1113 # 101383a7 <remain_data+0x3f>
 1003e18:	5ae1                	li	s5,-8
 1003e1a:	03548633          	mul	a2,s1,s5
 1003e1e:	8552                	mv	a0,s4
 1003e20:	4581                	li	a1,0
 1003e22:	397070ef          	jal	100b9b8 <__lshrdi3>
 1003e26:	0099d50b          	th.srb	a0,s3,s1,0
 1003e2a:	14fd                	addi	s1,s1,-1
 1003e2c:	ff5497e3          	bne	s1,s5,1003e1a <HAL_OTBN_SHA256_Final+0x58>
 1003e30:	bb01a503          	lw	a0,-1104(gp) # 101383b0 <index>
 1003e34:	04000613          	li	a2,64
 1003e38:	b6818593          	addi	a1,gp,-1176 # 10138368 <remain_data>
 1003e3c:	0bc040ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1003e40:	bb01a783          	lw	a5,-1104(gp) # 101383b0 <index>
 1003e44:	4611                	li	a2,4
 1003e46:	858a                	mv	a1,sp
 1003e48:	04078713          	addi	a4,a5,64
 1003e4c:	f0078793          	addi	a5,a5,-256
 1003e50:	bae1a823          	sw	a4,-1104(gp) # 101383b0 <index>
 1003e54:	8399                	srli	a5,a5,0x6
 1003e56:	6705                	lui	a4,0x1
 1003e58:	f1370713          	addi	a4,a4,-237 # f13 <Reset_Handler-0xfff0ed>
 1003e5c:	07d2                	slli	a5,a5,0x14
 1003e5e:	8fd9                	or	a5,a5,a4
 1003e60:	4501                	li	a0,0
 1003e62:	c03e                	sw	a5,0(sp)
 1003e64:	024040ef          	jal	1007e88 <HAL_OTBN_IMEM_Write>
 1003e68:	0d800513          	li	a0,216
 1003e6c:	104040ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 1003e70:	02000613          	li	a2,32
 1003e74:	858a                	mv	a1,sp
 1003e76:	4501                	li	a0,0
 1003e78:	0ba040ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 1003e7c:	878a                	mv	a5,sp
 1003e7e:	02040693          	addi	a3,s0,32
 1003e82:	4fd8                	lw	a4,28(a5)
 1003e84:	0411                	addi	s0,s0,4
 1003e86:	17f1                	addi	a5,a5,-4
 1003e88:	01875613          	srli	a2,a4,0x18
 1003e8c:	fec40e23          	sb	a2,-4(s0)
 1003e90:	01075613          	srli	a2,a4,0x10
 1003e94:	fec40ea3          	sb	a2,-3(s0)
 1003e98:	00875613          	srli	a2,a4,0x8
 1003e9c:	fec40f23          	sb	a2,-2(s0)
 1003ea0:	fee40fa3          	sb	a4,-1(s0)
 1003ea4:	fcd41fe3          	bne	s0,a3,1003e82 <HAL_OTBN_SHA256_Final+0xc0>
 1003ea8:	0c300513          	li	a0,195
 1003eac:	0c4040ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 1003eb0:	6105                	addi	sp,sp,32
 1003eb2:	37b0706f          	j	100ba2c <__riscv_restore_4>
 1003eb6:	0785                	addi	a5,a5,1
 1003eb8:	00f9d00b          	th.srb	zero,s3,a5,0
 1003ebc:	4705                	li	a4,1
 1003ebe:	f56794e3          	bne	a5,s6,1003e06 <HAL_OTBN_SHA256_Final+0x44>
 1003ec2:	b6818513          	addi	a0,gp,-1176 # 10138368 <remain_data>
 1003ec6:	baf1a423          	sw	a5,-1112(gp) # 101383a8 <remain_len>
 1003eca:	3355                	jal	1003c6e <sha256_msg_write>
 1003ecc:	4781                	li	a5,0
 1003ece:	ba01a423          	sw	zero,-1112(gp) # 101383a8 <remain_len>
 1003ed2:	bf0d                	j	1003e04 <HAL_OTBN_SHA256_Final+0x42>

01003ed4 <K>:
 1003ed4:	2f98 428a 4491 7137 fbcf b5c0 dba5 e9b5     ./.B.D7q........
 1003ee4:	c25b 3956 11f1 59f1 82a4 923f 5ed5 ab1c     [.V9...Y..?..^..
 1003ef4:	aa98 d807 5b01 1283 85be 2431 7dc3 550c     .....[....1$.}.U
 1003f04:	5d74 72be b1fe 80de 06a7 9bdc f174 c19b     t].r........t...
 1003f14:	69c1 e49b 4786 efbe 9dc6 0fc1 a1cc 240c     .i...G.........$
 1003f24:	2c6f 2de9 84aa 4a74 a9dc 5cb0 88da 76f9     o,.-..tJ...\...v
 1003f34:	5152 983e c66d a831 27c8 b003 7fc7 bf59     RQ>.m.1..'....Y.
 1003f44:	0bf3 c6e0 9147 d5a7 6351 06ca 2967 1429     ....G...Qc..g)).
 1003f54:	0a85 27b7 2138 2e1b 6dfc 4d2c 0d13 5338     ...'8!...m,M..8S
 1003f64:	7354 650a 0abb 766a c92e 81c2 2c85 9272     Ts.e..jv.....,r.
 1003f74:	e8a1 a2bf 664b a81a 8b70 c24b 51a3 c76c     ....Kf..p.K..Ql.
 1003f84:	e819 d192 0624 d699 3585 f40e a070 106a     ....$....5..p.j.
 1003f94:	c116 19a4 6c08 1e37 774c 2748 bcb5 34b0     .....l7.LwH'...4
 1003fa4:	0cb3 391c aa4a 4ed8 ca4f 5b9c 6ff3 682e     ...9J..NO..[.o.h
 1003fb4:	82ee 748f 636f 78a5 7814 84c8 0208 8cc7     ...toc.x.x......
 1003fc4:	fffa 90be 6ceb a450 a3f7 bef9 78f2 c671     .....lP......xq.

01003fd4 <bswap32_mask>:
 1003fd4:	00ff 0000 00ff 0000 00ff 0000 00ff 0000     ................
 1003fe4:	00ff 0000 00ff 0000 00ff 0000 00ff 0000     ................

01003ff4 <state_init>:
 1003ff4:	cd19 5be0 d9ab 1f83 688c 9b05 527f 510e     ...[.....h...R.Q
 1004004:	f53a a54f f372 3c6e ae85 bb67 e667 6a09     :.O.r.n<..g.g..j

01004014 <SHA384_msg_write>:
 1004014:	1ff072ef          	jal	t0,100ba12 <__riscv_save_0>
 1004018:	7175                	addi	sp,sp,-144
 100401a:	081c                	addi	a5,sp,16
 100401c:	08050713          	addi	a4,a0,128
 1004020:	00054683          	lbu	a3,0(a0)
 1004024:	0521                	addi	a0,a0,8
 1004026:	00d107a3          	sb	a3,15(sp)
 100402a:	ff954683          	lbu	a3,-7(a0)
 100402e:	00d10723          	sb	a3,14(sp)
 1004032:	ffa54683          	lbu	a3,-6(a0)
 1004036:	00d106a3          	sb	a3,13(sp)
 100403a:	ffb54683          	lbu	a3,-5(a0)
 100403e:	00d10623          	sb	a3,12(sp)
 1004042:	ffc54683          	lbu	a3,-4(a0)
 1004046:	00d105a3          	sb	a3,11(sp)
 100404a:	ffd54683          	lbu	a3,-3(a0)
 100404e:	00d10523          	sb	a3,10(sp)
 1004052:	ffe54683          	lbu	a3,-2(a0)
 1004056:	00d104a3          	sb	a3,9(sp)
 100405a:	fff54683          	lbu	a3,-1(a0)
 100405e:	00d10423          	sb	a3,8(sp)
 1004062:	4622                	lw	a2,8(sp)
 1004064:	46b2                	lw	a3,12(sp)
 1004066:	c390                	sw	a2,0(a5)
 1004068:	c3d4                	sw	a3,4(a5)
 100406a:	07a1                	addi	a5,a5,8
 100406c:	fae51ae3          	bne	a0,a4,1004020 <SHA384_msg_write+0xc>
 1004070:	c3c1a503          	lw	a0,-964(gp) # 1013843c <index>
 1004074:	08000613          	li	a2,128
 1004078:	080c                	addi	a1,sp,16
 100407a:	67f030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100407e:	c3c1a783          	lw	a5,-964(gp) # 1013843c <index>
 1004082:	6705                	lui	a4,0x1
 1004084:	90070713          	addi	a4,a4,-1792 # 900 <Reset_Handler-0xfff700>
 1004088:	08078793          	addi	a5,a5,128
 100408c:	c2f1ae23          	sw	a5,-964(gp) # 1013843c <index>
 1004090:	00e79a63          	bne	a5,a4,10040a4 <SHA384_msg_write+0x90>
 1004094:	0d800513          	li	a0,216
 1004098:	6d9030ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 100409c:	10000793          	li	a5,256
 10040a0:	c2f1ae23          	sw	a5,-964(gp) # 1013843c <index>
 10040a4:	6149                	addi	sp,sp,144
 10040a6:	1910706f          	j	100ba36 <__riscv_restore_0>

010040aa <HAL_OTBN_SHA384_Init>:
 10040aa:	169072ef          	jal	t0,100ba12 <__riscv_save_0>
 10040ae:	1141                	addi	sp,sp,-16
 10040b0:	6405                	lui	s0,0x1
 10040b2:	c201ac23          	sw	zero,-968(gp) # 10138438 <total_cnt>
 10040b6:	10000493          	li	s1,256
 10040ba:	c0040613          	addi	a2,s0,-1024 # c00 <Reset_Handler-0xfff400>
 10040be:	c201aa23          	sw	zero,-972(gp) # 10138434 <remain_len>
 10040c2:	4581                	li	a1,0
 10040c4:	4501                	li	a0,0
 10040c6:	c291ae23          	sw	s1,-964(gp) # 1013843c <index>
 10040ca:	c426                	sw	s1,8(sp)
 10040cc:	c202                	sw	zero,4(sp)
 10040ce:	5f1030ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 10040d2:	010025b7          	lui	a1,0x1002
 10040d6:	63400613          	li	a2,1588
 10040da:	f6a58593          	addi	a1,a1,-150 # 1001f6a <sha512_text>
 10040de:	4501                	li	a0,0
 10040e0:	5a9030ef          	jal	1007e88 <HAL_OTBN_IMEM_Write>
 10040e4:	010045b7          	lui	a1,0x1004
 10040e8:	8626                	mv	a2,s1
 10040ea:	57058593          	addi	a1,a1,1392 # 1004570 <state_init>
 10040ee:	4501                	li	a0,0
 10040f0:	609030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 10040f4:	010045b7          	lui	a1,0x1004
 10040f8:	28000613          	li	a2,640
 10040fc:	2f058593          	addi	a1,a1,752 # 10042f0 <K>
 1004100:	92040513          	addi	a0,s0,-1760
 1004104:	5f5030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004108:	4611                	li	a2,4
 100410a:	00c105b3          	add	a1,sp,a2
 100410e:	90440513          	addi	a0,s0,-1788
 1004112:	5e7030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004116:	002c                	addi	a1,sp,8
 1004118:	4611                	li	a2,4
 100411a:	90840513          	addi	a0,s0,-1784
 100411e:	5db030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004122:	47c1                	li	a5,16
 1004124:	006c                	addi	a1,sp,12
 1004126:	4611                	li	a2,4
 1004128:	90040513          	addi	a0,s0,-1792
 100412c:	c63e                	sw	a5,12(sp)
 100412e:	5cb030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004132:	0141                	addi	sp,sp,16
 1004134:	1030706f          	j	100ba36 <__riscv_restore_0>

01004138 <HAL_OTBN_SHA384_Update>:
 1004138:	0c1072ef          	jal	t0,100b9f8 <__riscv_save_4>
 100413c:	c381a783          	lw	a5,-968(gp) # 10138438 <total_cnt>
 1004140:	c341a903          	lw	s2,-972(gp) # 10138434 <remain_len>
 1004144:	97ae                	add	a5,a5,a1
 1004146:	c2f1ac23          	sw	a5,-968(gp) # 10138438 <total_cnt>
 100414a:	842a                	mv	s0,a0
 100414c:	84ae                	mv	s1,a1
 100414e:	04090463          	beqz	s2,1004196 <HAL_OTBN_SHA384_Update+0x5e>
 1004152:	bb418a93          	addi	s5,gp,-1100 # 101383b4 <remain_data>
 1004156:	00b90a33          	add	s4,s2,a1
 100415a:	07f00793          	li	a5,127
 100415e:	01590533          	add	a0,s2,s5
 1004162:	0147ea63          	bltu	a5,s4,1004176 <HAL_OTBN_SHA384_Update+0x3e>
 1004166:	862e                	mv	a2,a1
 1004168:	85a2                	mv	a1,s0
 100416a:	1ab070ef          	jal	100bb14 <memcpy>
 100416e:	c341aa23          	sw	s4,-972(gp) # 10138434 <remain_len>
 1004172:	0bb0706f          	j	100ba2c <__riscv_restore_4>
 1004176:	08000a13          	li	s4,128
 100417a:	412a0a33          	sub	s4,s4,s2
 100417e:	85a2                	mv	a1,s0
 1004180:	8652                	mv	a2,s4
 1004182:	193070ef          	jal	100bb14 <memcpy>
 1004186:	8556                	mv	a0,s5
 1004188:	f8090913          	addi	s2,s2,-128
 100418c:	3561                	jal	1004014 <SHA384_msg_write>
 100418e:	94ca                	add	s1,s1,s2
 1004190:	c201aa23          	sw	zero,-972(gp) # 10138434 <remain_len>
 1004194:	9452                	add	s0,s0,s4
 1004196:	f804f913          	andi	s2,s1,-128
 100419a:	9922                	add	s2,s2,s0
 100419c:	03241163          	bne	s0,s2,10041be <HAL_OTBN_SHA384_Update+0x86>
 10041a0:	07f4f493          	andi	s1,s1,127
 10041a4:	d4f9                	beqz	s1,1004172 <HAL_OTBN_SHA384_Update+0x3a>
 10041a6:	c341a503          	lw	a0,-972(gp) # 10138434 <remain_len>
 10041aa:	bb418793          	addi	a5,gp,-1100 # 101383b4 <remain_data>
 10041ae:	8626                	mv	a2,s1
 10041b0:	85a2                	mv	a1,s0
 10041b2:	953e                	add	a0,a0,a5
 10041b4:	161070ef          	jal	100bb14 <memcpy>
 10041b8:	c291aa23          	sw	s1,-972(gp) # 10138434 <remain_len>
 10041bc:	bf5d                	j	1004172 <HAL_OTBN_SHA384_Update+0x3a>
 10041be:	8522                	mv	a0,s0
 10041c0:	3d91                	jal	1004014 <SHA384_msg_write>
 10041c2:	08040413          	addi	s0,s0,128
 10041c6:	bfd9                	j	100419c <HAL_OTBN_SHA384_Update+0x64>

010041c8 <HAL_OTBN_SHA384_Final>:
 10041c8:	031072ef          	jal	t0,100b9f8 <__riscv_save_4>
 10041cc:	c341a703          	lw	a4,-972(gp) # 10138434 <remain_len>
 10041d0:	c381aa03          	lw	s4,-968(gp) # 10138438 <total_cnt>
 10041d4:	00170793          	addi	a5,a4,1
 10041d8:	842a                	mv	s0,a0
 10041da:	f8000693          	li	a3,-128
 10041de:	bb418513          	addi	a0,gp,-1100 # 101383b4 <remain_data>
 10041e2:	1141                	addi	sp,sp,-16
 10041e4:	00e5568b          	th.srb	a3,a0,a4,0
 10041e8:	c2f1aa23          	sw	a5,-972(gp) # 10138434 <remain_len>
 10041ec:	08000713          	li	a4,128
 10041f0:	0a0e                	slli	s4,s4,0x3
 10041f2:	00e79663          	bne	a5,a4,10041fe <HAL_OTBN_SHA384_Final+0x36>
 10041f6:	3d39                	jal	1004014 <SHA384_msg_write>
 10041f8:	4781                	li	a5,0
 10041fa:	c201aa23          	sw	zero,-972(gp) # 10138434 <remain_len>
 10041fe:	07000a93          	li	s5,112
 1004202:	bb318993          	addi	s3,gp,-1101 # 101383b3 <index+0x3>
 1004206:	08000b13          	li	s6,128
 100420a:	0d579263          	bne	a5,s5,10042ce <HAL_OTBN_SHA384_Final+0x106>
 100420e:	4621                	li	a2,8
 1004210:	4581                	li	a1,0
 1004212:	c2418513          	addi	a0,gp,-988 # 10138424 <remain_data+0x70>
 1004216:	117070ef          	jal	100bb2c <memset>
 100421a:	07800793          	li	a5,120
 100421e:	c2f1aa23          	sw	a5,-972(gp) # 10138434 <remain_len>
 1004222:	c3318993          	addi	s3,gp,-973 # 10138433 <remain_data+0x7f>
 1004226:	4481                	li	s1,0
 1004228:	5ae1                	li	s5,-8
 100422a:	03548633          	mul	a2,s1,s5
 100422e:	8552                	mv	a0,s4
 1004230:	4581                	li	a1,0
 1004232:	786070ef          	jal	100b9b8 <__lshrdi3>
 1004236:	0099d50b          	th.srb	a0,s3,s1,0
 100423a:	14fd                	addi	s1,s1,-1
 100423c:	ff5497e3          	bne	s1,s5,100422a <HAL_OTBN_SHA384_Final+0x62>
 1004240:	bb418513          	addi	a0,gp,-1100 # 101383b4 <remain_data>
 1004244:	3bc1                	jal	1004014 <SHA384_msg_write>
 1004246:	c3c1a783          	lw	a5,-964(gp) # 1013843c <index>
 100424a:	6505                	lui	a0,0x1
 100424c:	4611                	li	a2,4
 100424e:	f0078793          	addi	a5,a5,-256
 1004252:	839d                	srli	a5,a5,0x7
 1004254:	002c                	addi	a1,sp,8
 1004256:	90050513          	addi	a0,a0,-1792 # 900 <Reset_Handler-0xfff700>
 100425a:	c43e                	sw	a5,8(sp)
 100425c:	49d030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004260:	0d800513          	li	a0,216
 1004264:	50d030ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 1004268:	4481                	li	s1,0
 100426a:	0c000913          	li	s2,192
 100426e:	4621                	li	a2,8
 1004270:	8526                	mv	a0,s1
 1004272:	00c105b3          	add	a1,sp,a2
 1004276:	4bd030ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 100427a:	4732                	lw	a4,12(sp)
 100427c:	47a2                	lw	a5,8(sp)
 100427e:	0421                	addi	s0,s0,8
 1004280:	01875693          	srli	a3,a4,0x18
 1004284:	fed40c23          	sb	a3,-8(s0)
 1004288:	01075693          	srli	a3,a4,0x10
 100428c:	fed40ca3          	sb	a3,-7(s0)
 1004290:	fee40da3          	sb	a4,-5(s0)
 1004294:	00875693          	srli	a3,a4,0x8
 1004298:	0187d713          	srli	a4,a5,0x18
 100429c:	fee40e23          	sb	a4,-4(s0)
 10042a0:	0107d713          	srli	a4,a5,0x10
 10042a4:	fee40ea3          	sb	a4,-3(s0)
 10042a8:	0087d713          	srli	a4,a5,0x8
 10042ac:	fed40d23          	sb	a3,-6(s0)
 10042b0:	fee40f23          	sb	a4,-2(s0)
 10042b4:	fef40fa3          	sb	a5,-1(s0)
 10042b8:	02048493          	addi	s1,s1,32
 10042bc:	fb2499e3          	bne	s1,s2,100426e <HAL_OTBN_SHA384_Final+0xa6>
 10042c0:	0c300513          	li	a0,195
 10042c4:	4ad030ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 10042c8:	0141                	addi	sp,sp,16
 10042ca:	7620706f          	j	100ba2c <__riscv_restore_4>
 10042ce:	0785                	addi	a5,a5,1
 10042d0:	00f9d00b          	th.srb	zero,s3,a5,0
 10042d4:	f3679be3          	bne	a5,s6,100420a <HAL_OTBN_SHA384_Final+0x42>
 10042d8:	bb418513          	addi	a0,gp,-1100 # 101383b4 <remain_data>
 10042dc:	c2f1aa23          	sw	a5,-972(gp) # 10138434 <remain_len>
 10042e0:	3b15                	jal	1004014 <SHA384_msg_write>
 10042e2:	4781                	li	a5,0
 10042e4:	c201aa23          	sw	zero,-972(gp) # 10138434 <remain_len>
 10042e8:	b70d                	j	100420a <HAL_OTBN_SHA384_Final+0x42>
 10042ea:	0000                	unimp
 10042ec:	0000                	unimp
 10042ee:	0000                	unimp

010042f0 <K>:
 10042f0:	ae22 d728 2f98 428a 65cd 23ef 4491 7137     ".(../.B.e.#.D7q
 1004300:	3b2f ec4d fbcf b5c0 dbbc 8189 dba5 e9b5     /;M.............
 1004310:	b538 f348 c25b 3956 d019 b605 11f1 59f1     8.H.[.V9.......Y
 1004320:	4f9b af19 82a4 923f 8118 da6d 5ed5 ab1c     .O....?...m..^..
 1004330:	0242 a303 aa98 d807 6fbe 4570 5b01 1283     B........opE.[..
 1004340:	b28c 4ee4 85be 2431 b4e2 d5ff 7dc3 550c     ...N..1$.....}.U
 1004350:	896f f27b 5d74 72be 96b1 3b16 b1fe 80de     o.{.t].r...;....
 1004360:	1235 25c7 06a7 9bdc 2694 cf69 f174 c19b     5..%.....&i.t...
 1004370:	4ad2 9ef1 69c1 e49b 25e3 384f 4786 efbe     .J...i...%O8.G..
 1004380:	d5b5 8b8c 9dc6 0fc1 9c65 77ac a1cc 240c     ........e..w...$
 1004390:	0275 592b 2c6f 2de9 e483 6ea6 84aa 4a74     u.+Yo,.-...n..tJ
 10043a0:	fbd4 bd41 a9dc 5cb0 53b5 8311 88da 76f9     ..A....\.S.....v
 10043b0:	dfab ee66 5152 983e 3210 2db4 c66d a831     ..f.RQ>..2.-m.1.
 10043c0:	213f 98fb 27c8 b003 0ee4 beef 7fc7 bf59     ?!...'........Y.
 10043d0:	8fc2 3da8 0bf3 c6e0 a725 930a 9147 d5a7     ...=....%...G...
 10043e0:	826f e003 6351 06ca 6e70 0a0e 2967 1429     o...Qc..pn..g)).
 10043f0:	2ffc 46d2 0a85 27b7 c926 5c26 2138 2e1b     ./.F...'&.&\8!..
 1004400:	2aed 5ac4 6dfc 4d2c b3df 9d95 0d13 5338     .*.Z.m,M......8S
 1004410:	63de 8baf 7354 650a b2a8 3c77 0abb 766a     .c..Ts.e..w<..jv
 1004420:	aee6 47ed c92e 81c2 353b 1482 2c85 9272     ...G....;5...,r.
 1004430:	0364 4cf1 e8a1 a2bf 3001 bc42 664b a81a     d..L.....0B.Kf..
 1004440:	9791 d0f8 8b70 c24b be30 0654 51a3 c76c     ....p.K.0.T..Ql.
 1004450:	5218 d6ef e819 d192 a910 5565 0624 d699     .R........eU$...
 1004460:	202a 5771 3585 f40e d1b8 32bb a070 106a     * qW.5.....2p.j.
 1004470:	d0c8 b8d2 c116 19a4 ab53 5141 6c08 1e37     ........S.AQ.l7.
 1004480:	eb99 df8e 774c 2748 48a8 e19b bcb5 34b0     ....LwH'.H.....4
 1004490:	5a63 c5c9 0cb3 391c 8acb e341 aa4a 4ed8     cZ.....9..A.J..N
 10044a0:	e373 7763 ca4f 5b9c b8a3 d6b2 6ff3 682e     s.cwO..[.....o.h
 10044b0:	b2fc 5def 82ee 748f 2f60 4317 636f 78a5     ...]...t`/.Coc.x
 10044c0:	ab72 a1f0 7814 84c8 39ec 1a64 0208 8cc7     r....x...9d.....
 10044d0:	1e28 2363 fffa 90be bde9 de82 6ceb a450     (.c#.........lP.
 10044e0:	7915 b2c6 a3f7 bef9 532b e372 78f2 c671     .y......+Sr..xq.
 10044f0:	619c ea26 3ece ca27 c207 21c0 b8c7 d186     .a&..>'....!....
 1004500:	eb1e cde0 7dd6 eada d178 ee6e 4f7f f57d     .....}..x.n..O}.
 1004510:	6fba 7217 67aa 06f0 98a6 a2c8 7dc5 0a63     .o.r.g.......}c.
 1004520:	0dae bef9 9804 113f 471b 131c 0b35 1b71     ......?..G..5.q.
 1004530:	7d84 2304 77f5 28db 2493 40c7 ab7b 32ca     .}.#.w.(.$.@{..2
 1004540:	bebc 15c9 be0a 3c9e 0d4c 9c10 67c4 431d     .......<L....g.C
 1004550:	42b6 cb3e d4be 4cc5 7e2a fc65 299c 597f     .B>....L*~e..).Y
 1004560:	faec 3ad6 6fab 5fcb 5817 4a47 198c 6c44     ...:.o._.XGJ..Dl

01004570 <state_init>:
 1004570:	9ed8 c105 9d5d cbbb 0000 0000 0000 0000     ....]...........
 1004580:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004590:	d507 367c 292a 629a 0000 0000 0000 0000     ..|6*).b........
 10045a0:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 10045b0:	dd17 3070 015a 9159 0000 0000 0000 0000     ..p0Z.Y.........
 10045c0:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 10045d0:	5939 f70e ecd8 152f 0000 0000 0000 0000     9Y..../.........
 10045e0:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 10045f0:	0b31 ffc0 2667 6733 0000 0000 0000 0000     1...g&3g........
 1004600:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004610:	1511 6858 4a87 8eb4 0000 0000 0000 0000     ..Xh.J..........
 1004620:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004630:	8fa7 64f9 2e0d db0c 0000 0000 0000 0000     ...d............
 1004640:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004650:	4fa4 befa 481d 47b5 0000 0000 0000 0000     .O...H.G........
 1004660:	0000 0000 0000 0000 0000 0000 0000 0000     ................

01004670 <msg_write>:
 1004670:	3a2072ef          	jal	t0,100ba12 <__riscv_save_0>
 1004674:	7175                	addi	sp,sp,-144
 1004676:	081c                	addi	a5,sp,16
 1004678:	08050713          	addi	a4,a0,128
 100467c:	00054683          	lbu	a3,0(a0)
 1004680:	0521                	addi	a0,a0,8
 1004682:	00d107a3          	sb	a3,15(sp)
 1004686:	ff954683          	lbu	a3,-7(a0)
 100468a:	00d10723          	sb	a3,14(sp)
 100468e:	ffa54683          	lbu	a3,-6(a0)
 1004692:	00d106a3          	sb	a3,13(sp)
 1004696:	ffb54683          	lbu	a3,-5(a0)
 100469a:	00d10623          	sb	a3,12(sp)
 100469e:	ffc54683          	lbu	a3,-4(a0)
 10046a2:	00d105a3          	sb	a3,11(sp)
 10046a6:	ffd54683          	lbu	a3,-3(a0)
 10046aa:	00d10523          	sb	a3,10(sp)
 10046ae:	ffe54683          	lbu	a3,-2(a0)
 10046b2:	00d104a3          	sb	a3,9(sp)
 10046b6:	fff54683          	lbu	a3,-1(a0)
 10046ba:	00d10423          	sb	a3,8(sp)
 10046be:	4622                	lw	a2,8(sp)
 10046c0:	46b2                	lw	a3,12(sp)
 10046c2:	c390                	sw	a2,0(a5)
 10046c4:	c3d4                	sw	a3,4(a5)
 10046c6:	07a1                	addi	a5,a5,8
 10046c8:	fae51ae3          	bne	a0,a4,100467c <msg_write+0xc>
 10046cc:	cc81a503          	lw	a0,-824(gp) # 101384c8 <index>
 10046d0:	08000613          	li	a2,128
 10046d4:	080c                	addi	a1,sp,16
 10046d6:	023030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 10046da:	cc81a783          	lw	a5,-824(gp) # 101384c8 <index>
 10046de:	6705                	lui	a4,0x1
 10046e0:	90070713          	addi	a4,a4,-1792 # 900 <Reset_Handler-0xfff700>
 10046e4:	08078793          	addi	a5,a5,128
 10046e8:	ccf1a423          	sw	a5,-824(gp) # 101384c8 <index>
 10046ec:	00e79a63          	bne	a5,a4,1004700 <msg_write+0x90>
 10046f0:	0d800513          	li	a0,216
 10046f4:	07d030ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 10046f8:	10000793          	li	a5,256
 10046fc:	ccf1a423          	sw	a5,-824(gp) # 101384c8 <index>
 1004700:	6149                	addi	sp,sp,144
 1004702:	3340706f          	j	100ba36 <__riscv_restore_0>

01004706 <HAL_OTBN_SHA512_Init>:
 1004706:	30c072ef          	jal	t0,100ba12 <__riscv_save_0>
 100470a:	1141                	addi	sp,sp,-16
 100470c:	6405                	lui	s0,0x1
 100470e:	cc01a223          	sw	zero,-828(gp) # 101384c4 <total_cnt>
 1004712:	10000493          	li	s1,256
 1004716:	c0040613          	addi	a2,s0,-1024 # c00 <Reset_Handler-0xfff400>
 100471a:	cc01a023          	sw	zero,-832(gp) # 101384c0 <remain_len>
 100471e:	4581                	li	a1,0
 1004720:	4501                	li	a0,0
 1004722:	cc91a423          	sw	s1,-824(gp) # 101384c8 <index>
 1004726:	c426                	sw	s1,8(sp)
 1004728:	c202                	sw	zero,4(sp)
 100472a:	794030ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 100472e:	010025b7          	lui	a1,0x1002
 1004732:	63400613          	li	a2,1588
 1004736:	f6a58593          	addi	a1,a1,-150 # 1001f6a <sha512_text>
 100473a:	4501                	li	a0,0
 100473c:	74c030ef          	jal	1007e88 <HAL_OTBN_IMEM_Write>
 1004740:	010055b7          	lui	a1,0x1005
 1004744:	8626                	mv	a2,s1
 1004746:	bc858593          	addi	a1,a1,-1080 # 1004bc8 <state_init>
 100474a:	4501                	li	a0,0
 100474c:	7ac030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004750:	010055b7          	lui	a1,0x1005
 1004754:	28000613          	li	a2,640
 1004758:	94858593          	addi	a1,a1,-1720 # 1004948 <K>
 100475c:	92040513          	addi	a0,s0,-1760
 1004760:	798030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004764:	4611                	li	a2,4
 1004766:	00c105b3          	add	a1,sp,a2
 100476a:	90440513          	addi	a0,s0,-1788
 100476e:	78a030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004772:	002c                	addi	a1,sp,8
 1004774:	4611                	li	a2,4
 1004776:	90840513          	addi	a0,s0,-1784
 100477a:	77e030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100477e:	47c1                	li	a5,16
 1004780:	006c                	addi	a1,sp,12
 1004782:	4611                	li	a2,4
 1004784:	90040513          	addi	a0,s0,-1792
 1004788:	c63e                	sw	a5,12(sp)
 100478a:	76e030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100478e:	0141                	addi	sp,sp,16
 1004790:	2a60706f          	j	100ba36 <__riscv_restore_0>

01004794 <HAL_OTBN_SHA512_Update>:
 1004794:	264072ef          	jal	t0,100b9f8 <__riscv_save_4>
 1004798:	cc41a783          	lw	a5,-828(gp) # 101384c4 <total_cnt>
 100479c:	cc01a903          	lw	s2,-832(gp) # 101384c0 <remain_len>
 10047a0:	97ae                	add	a5,a5,a1
 10047a2:	ccf1a223          	sw	a5,-828(gp) # 101384c4 <total_cnt>
 10047a6:	842a                	mv	s0,a0
 10047a8:	84ae                	mv	s1,a1
 10047aa:	04090463          	beqz	s2,10047f2 <HAL_OTBN_SHA512_Update+0x5e>
 10047ae:	c4018a93          	addi	s5,gp,-960 # 10138440 <remain_data>
 10047b2:	00b90a33          	add	s4,s2,a1
 10047b6:	07f00793          	li	a5,127
 10047ba:	01590533          	add	a0,s2,s5
 10047be:	0147ea63          	bltu	a5,s4,10047d2 <HAL_OTBN_SHA512_Update+0x3e>
 10047c2:	862e                	mv	a2,a1
 10047c4:	85a2                	mv	a1,s0
 10047c6:	34e070ef          	jal	100bb14 <memcpy>
 10047ca:	cd41a023          	sw	s4,-832(gp) # 101384c0 <remain_len>
 10047ce:	25e0706f          	j	100ba2c <__riscv_restore_4>
 10047d2:	08000a13          	li	s4,128
 10047d6:	412a0a33          	sub	s4,s4,s2
 10047da:	85a2                	mv	a1,s0
 10047dc:	8652                	mv	a2,s4
 10047de:	336070ef          	jal	100bb14 <memcpy>
 10047e2:	8556                	mv	a0,s5
 10047e4:	f8090913          	addi	s2,s2,-128
 10047e8:	3561                	jal	1004670 <msg_write>
 10047ea:	94ca                	add	s1,s1,s2
 10047ec:	cc01a023          	sw	zero,-832(gp) # 101384c0 <remain_len>
 10047f0:	9452                	add	s0,s0,s4
 10047f2:	f804f913          	andi	s2,s1,-128
 10047f6:	9922                	add	s2,s2,s0
 10047f8:	03241163          	bne	s0,s2,100481a <HAL_OTBN_SHA512_Update+0x86>
 10047fc:	07f4f493          	andi	s1,s1,127
 1004800:	d4f9                	beqz	s1,10047ce <HAL_OTBN_SHA512_Update+0x3a>
 1004802:	cc01a503          	lw	a0,-832(gp) # 101384c0 <remain_len>
 1004806:	c4018793          	addi	a5,gp,-960 # 10138440 <remain_data>
 100480a:	8626                	mv	a2,s1
 100480c:	85a2                	mv	a1,s0
 100480e:	953e                	add	a0,a0,a5
 1004810:	304070ef          	jal	100bb14 <memcpy>
 1004814:	cc91a023          	sw	s1,-832(gp) # 101384c0 <remain_len>
 1004818:	bf5d                	j	10047ce <HAL_OTBN_SHA512_Update+0x3a>
 100481a:	8522                	mv	a0,s0
 100481c:	3d91                	jal	1004670 <msg_write>
 100481e:	08040413          	addi	s0,s0,128
 1004822:	bfd9                	j	10047f8 <HAL_OTBN_SHA512_Update+0x64>

01004824 <HAL_OTBN_SHA512_Final>:
 1004824:	1d4072ef          	jal	t0,100b9f8 <__riscv_save_4>
 1004828:	cc01a703          	lw	a4,-832(gp) # 101384c0 <remain_len>
 100482c:	cc41aa03          	lw	s4,-828(gp) # 101384c4 <total_cnt>
 1004830:	00170793          	addi	a5,a4,1
 1004834:	842a                	mv	s0,a0
 1004836:	f8000693          	li	a3,-128
 100483a:	c4018513          	addi	a0,gp,-960 # 10138440 <remain_data>
 100483e:	1141                	addi	sp,sp,-16
 1004840:	00e5568b          	th.srb	a3,a0,a4,0
 1004844:	ccf1a023          	sw	a5,-832(gp) # 101384c0 <remain_len>
 1004848:	08000713          	li	a4,128
 100484c:	0a0e                	slli	s4,s4,0x3
 100484e:	00e79663          	bne	a5,a4,100485a <HAL_OTBN_SHA512_Final+0x36>
 1004852:	3d39                	jal	1004670 <msg_write>
 1004854:	4781                	li	a5,0
 1004856:	cc01a023          	sw	zero,-832(gp) # 101384c0 <remain_len>
 100485a:	07000a93          	li	s5,112
 100485e:	c3f18993          	addi	s3,gp,-961 # 1013843f <index+0x3>
 1004862:	08000b13          	li	s6,128
 1004866:	0d579263          	bne	a5,s5,100492a <HAL_OTBN_SHA512_Final+0x106>
 100486a:	4621                	li	a2,8
 100486c:	4581                	li	a1,0
 100486e:	cb018513          	addi	a0,gp,-848 # 101384b0 <remain_data+0x70>
 1004872:	2ba070ef          	jal	100bb2c <memset>
 1004876:	07800793          	li	a5,120
 100487a:	ccf1a023          	sw	a5,-832(gp) # 101384c0 <remain_len>
 100487e:	cbf18993          	addi	s3,gp,-833 # 101384bf <remain_data+0x7f>
 1004882:	4481                	li	s1,0
 1004884:	5ae1                	li	s5,-8
 1004886:	03548633          	mul	a2,s1,s5
 100488a:	8552                	mv	a0,s4
 100488c:	4581                	li	a1,0
 100488e:	12a070ef          	jal	100b9b8 <__lshrdi3>
 1004892:	0099d50b          	th.srb	a0,s3,s1,0
 1004896:	14fd                	addi	s1,s1,-1
 1004898:	ff5497e3          	bne	s1,s5,1004886 <HAL_OTBN_SHA512_Final+0x62>
 100489c:	c4018513          	addi	a0,gp,-960 # 10138440 <remain_data>
 10048a0:	3bc1                	jal	1004670 <msg_write>
 10048a2:	cc81a783          	lw	a5,-824(gp) # 101384c8 <index>
 10048a6:	6505                	lui	a0,0x1
 10048a8:	4611                	li	a2,4
 10048aa:	f0078793          	addi	a5,a5,-256
 10048ae:	839d                	srli	a5,a5,0x7
 10048b0:	002c                	addi	a1,sp,8
 10048b2:	90050513          	addi	a0,a0,-1792 # 900 <Reset_Handler-0xfff700>
 10048b6:	c43e                	sw	a5,8(sp)
 10048b8:	640030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 10048bc:	0d800513          	li	a0,216
 10048c0:	6b0030ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 10048c4:	4481                	li	s1,0
 10048c6:	10000913          	li	s2,256
 10048ca:	4621                	li	a2,8
 10048cc:	8526                	mv	a0,s1
 10048ce:	00c105b3          	add	a1,sp,a2
 10048d2:	660030ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 10048d6:	4732                	lw	a4,12(sp)
 10048d8:	47a2                	lw	a5,8(sp)
 10048da:	0421                	addi	s0,s0,8
 10048dc:	01875693          	srli	a3,a4,0x18
 10048e0:	fed40c23          	sb	a3,-8(s0)
 10048e4:	01075693          	srli	a3,a4,0x10
 10048e8:	fed40ca3          	sb	a3,-7(s0)
 10048ec:	fee40da3          	sb	a4,-5(s0)
 10048f0:	00875693          	srli	a3,a4,0x8
 10048f4:	0187d713          	srli	a4,a5,0x18
 10048f8:	fee40e23          	sb	a4,-4(s0)
 10048fc:	0107d713          	srli	a4,a5,0x10
 1004900:	fee40ea3          	sb	a4,-3(s0)
 1004904:	0087d713          	srli	a4,a5,0x8
 1004908:	fed40d23          	sb	a3,-6(s0)
 100490c:	fee40f23          	sb	a4,-2(s0)
 1004910:	fef40fa3          	sb	a5,-1(s0)
 1004914:	02048493          	addi	s1,s1,32
 1004918:	fb2499e3          	bne	s1,s2,10048ca <HAL_OTBN_SHA512_Final+0xa6>
 100491c:	0c300513          	li	a0,195
 1004920:	650030ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 1004924:	0141                	addi	sp,sp,16
 1004926:	1060706f          	j	100ba2c <__riscv_restore_4>
 100492a:	0785                	addi	a5,a5,1
 100492c:	00f9d00b          	th.srb	zero,s3,a5,0
 1004930:	f3679be3          	bne	a5,s6,1004866 <HAL_OTBN_SHA512_Final+0x42>
 1004934:	c4018513          	addi	a0,gp,-960 # 10138440 <remain_data>
 1004938:	ccf1a023          	sw	a5,-832(gp) # 101384c0 <remain_len>
 100493c:	3b15                	jal	1004670 <msg_write>
 100493e:	4781                	li	a5,0
 1004940:	cc01a023          	sw	zero,-832(gp) # 101384c0 <remain_len>
 1004944:	b70d                	j	1004866 <HAL_OTBN_SHA512_Final+0x42>
 1004946:	0000                	unimp

01004948 <K>:
 1004948:	ae22 d728 2f98 428a 65cd 23ef 4491 7137     ".(../.B.e.#.D7q
 1004958:	3b2f ec4d fbcf b5c0 dbbc 8189 dba5 e9b5     /;M.............
 1004968:	b538 f348 c25b 3956 d019 b605 11f1 59f1     8.H.[.V9.......Y
 1004978:	4f9b af19 82a4 923f 8118 da6d 5ed5 ab1c     .O....?...m..^..
 1004988:	0242 a303 aa98 d807 6fbe 4570 5b01 1283     B........opE.[..
 1004998:	b28c 4ee4 85be 2431 b4e2 d5ff 7dc3 550c     ...N..1$.....}.U
 10049a8:	896f f27b 5d74 72be 96b1 3b16 b1fe 80de     o.{.t].r...;....
 10049b8:	1235 25c7 06a7 9bdc 2694 cf69 f174 c19b     5..%.....&i.t...
 10049c8:	4ad2 9ef1 69c1 e49b 25e3 384f 4786 efbe     .J...i...%O8.G..
 10049d8:	d5b5 8b8c 9dc6 0fc1 9c65 77ac a1cc 240c     ........e..w...$
 10049e8:	0275 592b 2c6f 2de9 e483 6ea6 84aa 4a74     u.+Yo,.-...n..tJ
 10049f8:	fbd4 bd41 a9dc 5cb0 53b5 8311 88da 76f9     ..A....\.S.....v
 1004a08:	dfab ee66 5152 983e 3210 2db4 c66d a831     ..f.RQ>..2.-m.1.
 1004a18:	213f 98fb 27c8 b003 0ee4 beef 7fc7 bf59     ?!...'........Y.
 1004a28:	8fc2 3da8 0bf3 c6e0 a725 930a 9147 d5a7     ...=....%...G...
 1004a38:	826f e003 6351 06ca 6e70 0a0e 2967 1429     o...Qc..pn..g)).
 1004a48:	2ffc 46d2 0a85 27b7 c926 5c26 2138 2e1b     ./.F...'&.&\8!..
 1004a58:	2aed 5ac4 6dfc 4d2c b3df 9d95 0d13 5338     .*.Z.m,M......8S
 1004a68:	63de 8baf 7354 650a b2a8 3c77 0abb 766a     .c..Ts.e..w<..jv
 1004a78:	aee6 47ed c92e 81c2 353b 1482 2c85 9272     ...G....;5...,r.
 1004a88:	0364 4cf1 e8a1 a2bf 3001 bc42 664b a81a     d..L.....0B.Kf..
 1004a98:	9791 d0f8 8b70 c24b be30 0654 51a3 c76c     ....p.K.0.T..Ql.
 1004aa8:	5218 d6ef e819 d192 a910 5565 0624 d699     .R........eU$...
 1004ab8:	202a 5771 3585 f40e d1b8 32bb a070 106a     * qW.5.....2p.j.
 1004ac8:	d0c8 b8d2 c116 19a4 ab53 5141 6c08 1e37     ........S.AQ.l7.
 1004ad8:	eb99 df8e 774c 2748 48a8 e19b bcb5 34b0     ....LwH'.H.....4
 1004ae8:	5a63 c5c9 0cb3 391c 8acb e341 aa4a 4ed8     cZ.....9..A.J..N
 1004af8:	e373 7763 ca4f 5b9c b8a3 d6b2 6ff3 682e     s.cwO..[.....o.h
 1004b08:	b2fc 5def 82ee 748f 2f60 4317 636f 78a5     ...]...t`/.Coc.x
 1004b18:	ab72 a1f0 7814 84c8 39ec 1a64 0208 8cc7     r....x...9d.....
 1004b28:	1e28 2363 fffa 90be bde9 de82 6ceb a450     (.c#.........lP.
 1004b38:	7915 b2c6 a3f7 bef9 532b e372 78f2 c671     .y......+Sr..xq.
 1004b48:	619c ea26 3ece ca27 c207 21c0 b8c7 d186     .a&..>'....!....
 1004b58:	eb1e cde0 7dd6 eada d178 ee6e 4f7f f57d     .....}..x.n..O}.
 1004b68:	6fba 7217 67aa 06f0 98a6 a2c8 7dc5 0a63     .o.r.g.......}c.
 1004b78:	0dae bef9 9804 113f 471b 131c 0b35 1b71     ......?..G..5.q.
 1004b88:	7d84 2304 77f5 28db 2493 40c7 ab7b 32ca     .}.#.w.(.$.@{..2
 1004b98:	bebc 15c9 be0a 3c9e 0d4c 9c10 67c4 431d     .......<L....g.C
 1004ba8:	42b6 cb3e d4be 4cc5 7e2a fc65 299c 597f     .B>....L*~e..).Y
 1004bb8:	faec 3ad6 6fab 5fcb 5817 4a47 198c 6c44     ...:.o._.XGJ..Dl

01004bc8 <state_init>:
 1004bc8:	c908 f3bc e667 6a09 0000 0000 0000 0000     ....g..j........
 1004bd8:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004be8:	a73b 84ca ae85 bb67 0000 0000 0000 0000     ;.....g.........
 1004bf8:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004c08:	f82b fe94 f372 3c6e 0000 0000 0000 0000     +...r.n<........
 1004c18:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004c28:	36f1 5f1d f53a a54f 0000 0000 0000 0000     .6._:.O.........
 1004c38:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004c48:	82d1 ade6 527f 510e 0000 0000 0000 0000     .....R.Q........
 1004c58:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004c68:	6c1f 2b3e 688c 9b05 0000 0000 0000 0000     .l>+.h..........
 1004c78:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004c88:	bd6b fb41 d9ab 1f83 0000 0000 0000 0000     k.A.............
 1004c98:	0000 0000 0000 0000 0000 0000 0000 0000     ................
 1004ca8:	2179 137e cd19 5be0 0000 0000 0000 0000     y!~....[........
 1004cb8:	0000 0000 0000 0000 0000 0000 0000 0000     ................

01004cc8 <HAL_OTBN_ECC256_ScalarMult_Polling>:
 1004cc8:	54b062ef          	jal	t0,100ba12 <__riscv_save_0>
 1004ccc:	842e                	mv	s0,a1
 1004cce:	010015b7          	lui	a1,0x1001
 1004cd2:	84aa                	mv	s1,a0
 1004cd4:	75800613          	li	a2,1880
 1004cd8:	98a58593          	addi	a1,a1,-1654 # 100098a <ecc256_scalar_mult_text>
 1004cdc:	4501                	li	a0,0
 1004cde:	1aa030ef          	jal	1007e88 <HAL_OTBN_IMEM_Write>
 1004ce2:	400c                	lw	a1,0(s0)
 1004ce4:	02000613          	li	a2,32
 1004ce8:	4501                	li	a0,0
 1004cea:	20e030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004cee:	06000613          	li	a2,96
 1004cf2:	4581                	li	a1,0
 1004cf4:	02000513          	li	a0,32
 1004cf8:	1c6030ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 1004cfc:	404c                	lw	a1,4(s0)
 1004cfe:	02000613          	li	a2,32
 1004d02:	08000513          	li	a0,128
 1004d06:	1f2030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004d0a:	440c                	lw	a1,8(s0)
 1004d0c:	02000613          	li	a2,32
 1004d10:	0a000513          	li	a0,160
 1004d14:	1e4030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004d18:	02000613          	li	a2,32
 1004d1c:	4581                	li	a1,0
 1004d1e:	0c000513          	li	a0,192
 1004d22:	19c030ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 1004d26:	02000613          	li	a2,32
 1004d2a:	4581                	li	a1,0
 1004d2c:	0e000513          	li	a0,224
 1004d30:	18e030ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 1004d34:	010055b7          	lui	a1,0x1005
 1004d38:	fff48793          	addi	a5,s1,-1
 1004d3c:	d9458593          	addi	a1,a1,-620 # 1004d94 <SM2>
 1004d40:	42f0158b          	th.mvnez	a1,zero,a5
 1004d44:	010057b7          	lui	a5,0x1005
 1004d48:	e7478793          	addi	a5,a5,-396 # 1004e74 <P256>
 1004d4c:	4097958b          	th.mveqz	a1,a5,s1
 1004d50:	0e000613          	li	a2,224
 1004d54:	10000513          	li	a0,256
 1004d58:	1a0030ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004d5c:	1c000613          	li	a2,448
 1004d60:	4581                	li	a1,0
 1004d62:	1e000513          	li	a0,480
 1004d66:	158030ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 1004d6a:	0d800513          	li	a0,216
 1004d6e:	202030ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 1004d72:	444c                	lw	a1,12(s0)
 1004d74:	02000613          	li	a2,32
 1004d78:	0c000513          	li	a0,192
 1004d7c:	1b6030ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 1004d80:	480c                	lw	a1,16(s0)
 1004d82:	02000613          	li	a2,32
 1004d86:	0e000513          	li	a0,224
 1004d8a:	1a8030ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 1004d8e:	4a90606f          	j	100ba36 <__riscv_restore_0>
 1004d92:	0000                	unimp

01004d94 <SM2>:
 1004d94:	0e93 4d94 bd41 ddbc 8f92 15ab 89f5 f397     ...MA...........
 1004da4:	09a7 cf65 9e4b 4d5a 5e34 9d9f fa9e 28e9     ..e.K.ZM4^.....(
 1004db4:	ffff ffff ffff ffff 0000 0000 ffff ffff     ................
 1004dc4:	ffff ffff ffff ffff ffff ffff fffe ffff     ................
 1004dd4:	0003 0000 0002 0000 0002 0000 0002 0000     ................
 1004de4:	0001 0000 0001 0000 0001 0000 0001 0000     ................
 1004df4:	4123 39d5 f409 53bb 052b 21c6 df6b 7203     #A.9...S+..!k..r
 1004e04:	ffff ffff ffff ffff ffff ffff fffe ffff     ................
 1004e14:	49a0 f151 6361 12ac 3c01 fa32 2096 8dfc     .IQ.ac...<2.. ..
 1004e24:	0001 0000 0001 0000 0001 0000 0001 0000     ................
 1004e34:	74c7 334c 4589 715a 0be1 f266 0bbf 8fe3     .tL3.EZq..f.....
 1004e44:	c994 6a39 0446 5f99 8119 1f19 ae2c 32c4     ..9jF.._....,..2
 1004e54:	f0a0 2139 32e5 02df 4740 c62a 877c d0a9     ..9!.2..@G*.|...
 1004e64:	2153 6b69 cee3 59bd 779c f4f6 36a2 bc37     S!ik...Y.w...67.

01004e74 <P256>:
 1004e74:	604b 27d2 3c3e 3bce b0f6 cc53 06b0 651d     K`.'><.;..S....e
 1004e84:	86bc 7698 bd55 b3eb 93e7 aa3a 35d8 5ac6     ...vU.....:..5.Z
 1004e94:	ffff ffff ffff ffff ffff ffff 0000 0000     ................
 1004ea4:	0000 0000 0000 0000 0001 0000 ffff ffff     ................
 1004eb4:	0003 0000 0000 0000 ffff ffff fffe ffff     ................
 1004ec4:	fffe ffff fffe ffff ffff ffff 0000 0000     ................
 1004ed4:	2551 fc63 cac2 f3b9 9e84 a717 faad bce6     Q%c.............
 1004ee4:	ffff ffff ffff ffff 0000 0000 ffff ffff     ................
 1004ef4:	9bfe eedf fd85 012f 6c21 df1a 0552 4319     ....../.!l..R..C
 1004f04:	ffff ffff fffe ffff ffff ffff 0000 0000     ................
 1004f14:	c296 d898 3945 f4a1 33a0 2deb 7d81 7703     ....E9...3.-.}.w
 1004f24:	40f2 63a4 e6e5 f8bc 4247 e12c d1f2 6b17     .@.c....GB,....k
 1004f34:	51f5 37bf 4068 cbb6 5ece 6b31 3357 2bce     .Q.7h@...^1kW3.+
 1004f44:	9e16 7c0f eb4a 8ee7 7f9b fe1a 42e2 4fe3     ...|J........B.O

01004f54 <HAL_OTBN_ECC384_ECDSA_Verify_Polling>:
 1004f54:	2bf062ef          	jal	t0,100ba12 <__riscv_save_0>
 1004f58:	842e                	mv	s0,a1
 1004f5a:	6605                	lui	a2,0x1
 1004f5c:	010015b7          	lui	a1,0x1001
 1004f60:	7139                	addi	sp,sp,-64
 1004f62:	84aa                	mv	s1,a0
 1004f64:	c6c60613          	addi	a2,a2,-916 # c6c <Reset_Handler-0xfff394>
 1004f68:	0e258593          	addi	a1,a1,226 # 10010e2 <ecc384_ecdsa_verify_text>
 1004f6c:	4501                	li	a0,0
 1004f6e:	71b020ef          	jal	1007e88 <HAL_OTBN_IMEM_Write>
 1004f72:	6605                	lui	a2,0x1
 1004f74:	c0060613          	addi	a2,a2,-1024 # c00 <Reset_Handler-0xfff400>
 1004f78:	4581                	li	a1,0
 1004f7a:	4501                	li	a0,0
 1004f7c:	743020ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 1004f80:	010055b7          	lui	a1,0x1005
 1004f84:	00858593          	addi	a1,a1,8 # 1005008 <P384>
 1004f88:	4290158b          	th.mvnez	a1,zero,s1
 1004f8c:	14000613          	li	a2,320
 1004f90:	18000513          	li	a0,384
 1004f94:	765020ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004f98:	400c                	lw	a1,0(s0)
 1004f9a:	03000613          	li	a2,48
 1004f9e:	4501                	li	a0,0
 1004fa0:	759020ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004fa4:	404c                	lw	a1,4(s0)
 1004fa6:	03000613          	li	a2,48
 1004faa:	04000513          	li	a0,64
 1004fae:	74b020ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004fb2:	440c                	lw	a1,8(s0)
 1004fb4:	03000613          	li	a2,48
 1004fb8:	08000513          	li	a0,128
 1004fbc:	73d020ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004fc0:	444c                	lw	a1,12(s0)
 1004fc2:	03000613          	li	a2,48
 1004fc6:	0c000513          	li	a0,192
 1004fca:	72f020ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004fce:	480c                	lw	a1,16(s0)
 1004fd0:	03000613          	li	a2,48
 1004fd4:	10000513          	li	a0,256
 1004fd8:	721020ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1004fdc:	0d800513          	li	a0,216
 1004fe0:	791020ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 1004fe4:	858a                	mv	a1,sp
 1004fe6:	04000613          	li	a2,64
 1004fea:	14000513          	li	a0,320
 1004fee:	745020ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 1004ff2:	4048                	lw	a0,4(s0)
 1004ff4:	858a                	mv	a1,sp
 1004ff6:	03000613          	li	a2,48
 1004ffa:	2f5060ef          	jal	100baee <memcmp>
 1004ffe:	00153513          	seqz	a0,a0
 1005002:	6121                	addi	sp,sp,64
 1005004:	2330606f          	j	100ba36 <__riscv_restore_0>

01005008 <P384>:
 1005008:	d3ec2aef 2a85c8ed 8a2ed19d c656398d     .*.....*.....9V.
 1005018:	5013875a 0314088f fe814112 181d9c6e     Z..P.....A..n...
 1005028:	e3f82d19 988e056b e23ee7e4 b3312fa7     .-..k.....>../1.
 1005038:	00000000 00000000 00000000 00000000     ................
 1005048:	ffffffff 00000000 00000000 ffffffff     ................
 1005058:	fffffffe ffffffff ffffffff ffffffff     ................
 1005068:	ffffffff ffffffff ffffffff ffffffff     ................
 1005078:	00000000 00000000 00000000 00000000     ................
 1005088:	ccc52973 ecec196a 48b0a77a 581a0db2     s)..j...z..H...X
 1005098:	f4372ddf c7634d81 ffffffff ffffffff     .-7..Mc.........
 10050a8:	ffffffff ffffffff ffffffff ffffffff     ................
 10050b8:	00000000 00000000 00000000 00000000     ................
 10050c8:	72760ab7 3a545e38 bf55296c 5502f25d     ..vr8^T:l)U.]..U
 10050d8:	82542a38 59f741e0 8ba79b98 6e1d3b62     8*T..A.Y....b;.n
 10050e8:	f320ad74 8eb1c71e be8b0537 aa87ca22     t. .....7..."...
 10050f8:	00000000 00000000 00000000 00000000     ................
 1005108:	90ea0e5f 7a431d7c 1d7e819d 0a60b1ce     _...|.Cz..~...`.
 1005118:	b5f0b8c0 e9da3113 289a147c f8f41dbd     .....1..|..(....
 1005128:	9292dc29 5d9e98bf 96262c6f 3617de4a     )......]o,&.J..6
 1005138:	00000000 00000000 00000000 00000000     ................

01005148 <do_hal_flash_program_swint>:
 1005148:	00002717          	auipc	a4,0x2
 100514c:	2d470713          	addi	a4,a4,724 # 100741c <do_hal_flash_program>
 1005150:	e08017b7          	lui	a5,0xe0801
 1005154:	4805                	li	a6,1
 1005156:	07878793          	addi	a5,a5,120 # e0801078 <bitmap+0xd06c10f8>
 100515a:	01078023          	sb	a6,0(a5)

0100515e <label_line54>:
 100515e:	00078803          	lb	a6,0(a5)
 1005162:	fe081ee3          	bnez	a6,100515e <label_line54>
 1005166:	8082                	ret

01005168 <hal_flash_program_operation>:
 1005168:	0ab062ef          	jal	t0,100ba12 <__riscv_save_0>
 100516c:	300027f3          	csrr	a5,mstatus
 1005170:	8ba1                	andi	a5,a5,8
 1005172:	e789                	bnez	a5,100517c <hal_flash_program_operation+0x14>
 1005174:	2a8020ef          	jal	100741c <do_hal_flash_program>
 1005178:	0bf0606f          	j	100ba36 <__riscv_restore_0>
 100517c:	37f1                	jal	1005148 <do_hal_flash_program_swint>
 100517e:	bfed                	j	1005178 <hal_flash_program_operation+0x10>

01005180 <do_hal_flash_write_reg_swint>:
 1005180:	00002717          	auipc	a4,0x2
 1005184:	2aa70713          	addi	a4,a4,682 # 100742a <do_hal_flash_write_reg>
 1005188:	e08017b7          	lui	a5,0xe0801
 100518c:	4805                	li	a6,1
 100518e:	07878793          	addi	a5,a5,120 # e0801078 <bitmap+0xd06c10f8>
 1005192:	01078023          	sb	a6,0(a5)

01005196 <label_line59>:
 1005196:	00078803          	lb	a6,0(a5)
 100519a:	fe081ee3          	bnez	a6,1005196 <label_line59>
 100519e:	8082                	ret

010051a0 <hal_flash_write_reg_operation>:
 10051a0:	073062ef          	jal	t0,100ba12 <__riscv_save_0>
 10051a4:	300027f3          	csrr	a5,mstatus
 10051a8:	8ba1                	andi	a5,a5,8
 10051aa:	e789                	bnez	a5,10051b4 <hal_flash_write_reg_operation+0x14>
 10051ac:	27e020ef          	jal	100742a <do_hal_flash_write_reg>
 10051b0:	0870606f          	j	100ba36 <__riscv_restore_0>
 10051b4:	37f1                	jal	1005180 <do_hal_flash_write_reg_swint>
 10051b6:	bfed                	j	10051b0 <hal_flash_write_reg_operation+0x10>

010051b8 <do_hal_flash_read_swint>:
 10051b8:	00002717          	auipc	a4,0x2
 10051bc:	18a70713          	addi	a4,a4,394 # 1007342 <do_hal_flash_read>
 10051c0:	e08017b7          	lui	a5,0xe0801
 10051c4:	4805                	li	a6,1
 10051c6:	07878793          	addi	a5,a5,120 # e0801078 <bitmap+0xd06c10f8>
 10051ca:	01078023          	sb	a6,0(a5)

010051ce <label_line64>:
 10051ce:	00078803          	lb	a6,0(a5)
 10051d2:	fe081ee3          	bnez	a6,10051ce <label_line64>
 10051d6:	8082                	ret

010051d8 <hal_flash_read_operation>:
 10051d8:	03b062ef          	jal	t0,100ba12 <__riscv_save_0>
 10051dc:	300027f3          	csrr	a5,mstatus
 10051e0:	8ba1                	andi	a5,a5,8
 10051e2:	e789                	bnez	a5,10051ec <hal_flash_read_operation+0x14>
 10051e4:	15e020ef          	jal	1007342 <do_hal_flash_read>
 10051e8:	04f0606f          	j	100ba36 <__riscv_restore_0>
 10051ec:	37f1                	jal	10051b8 <do_hal_flash_read_swint>
 10051ee:	bfed                	j	10051e8 <hal_flash_read_operation+0x10>

010051f0 <do_hal_flash_read_reg_swint>:
 10051f0:	00002717          	auipc	a4,0x2
 10051f4:	16070713          	addi	a4,a4,352 # 1007350 <do_hal_flash_read_reg>
 10051f8:	e08017b7          	lui	a5,0xe0801
 10051fc:	4805                	li	a6,1
 10051fe:	07878793          	addi	a5,a5,120 # e0801078 <bitmap+0xd06c10f8>
 1005202:	01078023          	sb	a6,0(a5)

01005206 <label_line69>:
 1005206:	00078803          	lb	a6,0(a5)
 100520a:	fe081ee3          	bnez	a6,1005206 <label_line69>
 100520e:	8082                	ret

01005210 <hal_flash_read_reg_operation>:
 1005210:	003062ef          	jal	t0,100ba12 <__riscv_save_0>
 1005214:	300027f3          	csrr	a5,mstatus
 1005218:	8ba1                	andi	a5,a5,8
 100521a:	e789                	bnez	a5,1005224 <hal_flash_read_reg_operation+0x14>
 100521c:	134020ef          	jal	1007350 <do_hal_flash_read_reg>
 1005220:	0170606f          	j	100ba36 <__riscv_restore_0>
 1005224:	37f1                	jal	10051f0 <do_hal_flash_read_reg_swint>
 1005226:	bfed                	j	1005220 <hal_flash_read_reg_operation+0x10>

01005228 <do_hal_flash_chip_erase_swint>:
 1005228:	00002717          	auipc	a4,0x2
 100522c:	21070713          	addi	a4,a4,528 # 1007438 <do_hal_flash_chip_erase>
 1005230:	e08017b7          	lui	a5,0xe0801
 1005234:	4805                	li	a6,1
 1005236:	07878793          	addi	a5,a5,120 # e0801078 <bitmap+0xd06c10f8>
 100523a:	01078023          	sb	a6,0(a5)

0100523e <label_line74>:
 100523e:	00078803          	lb	a6,0(a5)
 1005242:	fe081ee3          	bnez	a6,100523e <label_line74>
 1005246:	8082                	ret

01005248 <hal_flash_chip_erase_operation>:
 1005248:	7ca062ef          	jal	t0,100ba12 <__riscv_save_0>
 100524c:	300027f3          	csrr	a5,mstatus
 1005250:	8ba1                	andi	a5,a5,8
 1005252:	e789                	bnez	a5,100525c <hal_flash_chip_erase_operation+0x14>
 1005254:	1e4020ef          	jal	1007438 <do_hal_flash_chip_erase>
 1005258:	7de0606f          	j	100ba36 <__riscv_restore_0>
 100525c:	37f1                	jal	1005228 <do_hal_flash_chip_erase_swint>
 100525e:	bfed                	j	1005258 <hal_flash_chip_erase_operation+0x10>

01005260 <u8tou32>:
 1005260:	7b2062ef          	jal	t0,100ba12 <__riscv_save_0>
 1005264:	842a                	mv	s0,a0
 1005266:	7dc060ef          	jal	100ba42 <__thead_uread4>
 100526a:	7cc0606f          	j	100ba36 <__riscv_restore_0>

0100526e <sm4_start>:
 100526e:	7a4062ef          	jal	t0,100ba12 <__riscv_save_0>
 1005272:	cd41a483          	lw	s1,-812(gp) # 101384d4 <crypt_in>
 1005276:	40029437          	lui	s0,0x40029
 100527a:	40040413          	addi	s0,s0,1024 # 40029400 <bitmap+0x2fee9480>
 100527e:	8526                	mv	a0,s1
 1005280:	37c5                	jal	1005260 <u8tou32>
 1005282:	d808                	sw	a0,48(s0)
 1005284:	00448513          	addi	a0,s1,4
 1005288:	3fe1                	jal	1005260 <u8tou32>
 100528a:	d808                	sw	a0,48(s0)
 100528c:	00848513          	addi	a0,s1,8
 1005290:	3fc1                	jal	1005260 <u8tou32>
 1005292:	d808                	sw	a0,48(s0)
 1005294:	00c48513          	addi	a0,s1,12
 1005298:	37e1                	jal	1005260 <u8tou32>
 100529a:	d808                	sw	a0,48(s0)
 100529c:	79a0606f          	j	100ba36 <__riscv_restore_0>

010052a0 <gmult>:
 10052a0:	00052883          	lw	a7,0(a0)
 10052a4:	00452803          	lw	a6,4(a0)
 10052a8:	451c                	lw	a5,8(a0)
 10052aa:	4558                	lw	a4,12(a0)
 10052ac:	1141                	addi	sp,sp,-16
 10052ae:	c622                	sw	s0,12(sp)
 10052b0:	c426                	sw	s1,8(sp)
 10052b2:	c24a                	sw	s2,4(sp)
 10052b4:	c04e                	sw	s3,0(sp)
 10052b6:	01058413          	addi	s0,a1,16
 10052ba:	4e81                	li	t4,0
 10052bc:	4e01                	li	t3,0
 10052be:	4f81                	li	t6,0
 10052c0:	4f01                	li	t5,0
 10052c2:	e10004b7          	lui	s1,0xe1000
 10052c6:	04000913          	li	s2,64
 10052ca:	0005a383          	lw	t2,0(a1)
 10052ce:	41d0                	lw	a2,4(a1)
 10052d0:	4281                	li	t0,0
 10052d2:	41f65693          	srai	a3,a2,0x1f
 10052d6:	0106f333          	and	t1,a3,a6
 10052da:	0116f9b3          	and	s3,a3,a7
 10052de:	006f4f33          	xor	t5,t5,t1
 10052e2:	00f6f333          	and	t1,a3,a5
 10052e6:	8ef9                	and	a3,a3,a4
 10052e8:	013fcfb3          	xor	t6,t6,s3
 10052ec:	006eceb3          	xor	t4,t4,t1
 10052f0:	01f71993          	slli	s3,a4,0x1f
 10052f4:	01f89313          	slli	t1,a7,0x1f
 10052f8:	00de4e33          	xor	t3,t3,a3
 10052fc:	8305                	srli	a4,a4,0x1
 10052fe:	0007a68b          	th.ext	a3,a5,0,0
 1005302:	8ee5                	and	a3,a3,s1
 1005304:	00676733          	or	a4,a4,t1
 1005308:	01f81313          	slli	t1,a6,0x1f
 100530c:	00185813          	srli	a6,a6,0x1
 1005310:	8385                	srli	a5,a5,0x1
 1005312:	0018d893          	srli	a7,a7,0x1
 1005316:	00d84833          	xor	a6,a6,a3
 100531a:	0606                	slli	a2,a2,0x1
 100531c:	01f3d693          	srli	a3,t2,0x1f
 1005320:	0285                	addi	t0,t0,1
 1005322:	00f9e7b3          	or	a5,s3,a5
 1005326:	011368b3          	or	a7,t1,a7
 100532a:	8e55                	or	a2,a2,a3
 100532c:	0386                	slli	t2,t2,0x1
 100532e:	fb2292e3          	bne	t0,s2,10052d2 <gmult+0x32>
 1005332:	05a1                	addi	a1,a1,8
 1005334:	f8b41be3          	bne	s0,a1,10052ca <gmult+0x2a>
 1005338:	4432                	lw	s0,12(sp)
 100533a:	01f52023          	sw	t6,0(a0)
 100533e:	01e52223          	sw	t5,4(a0)
 1005342:	01d52423          	sw	t4,8(a0)
 1005346:	01c52623          	sw	t3,12(a0)
 100534a:	44a2                	lw	s1,8(sp)
 100534c:	4912                	lw	s2,4(sp)
 100534e:	4982                	lw	s3,0(sp)
 1005350:	0141                	addi	sp,sp,16
 1005352:	8082                	ret

01005354 <inc_ctr>:
 1005354:	15fd                	addi	a1,a1,-1
 1005356:	80b5478b          	th.lrbu	a5,a0,a1,0
 100535a:	0785                	addi	a5,a5,1
 100535c:	0ff7f793          	zext.b	a5,a5
 1005360:	00b5578b          	th.srb	a5,a0,a1,0
 1005364:	dbe5                	beqz	a5,1005354 <inc_ctr>
 1005366:	8082                	ret

01005368 <sm4_data_length_inout_config>:
 1005368:	00f5f793          	andi	a5,a1,15
 100536c:	c391                	beqz	a5,1005370 <sm4_data_length_inout_config+0x8>
 100536e:	a001                	j	100536e <sm4_data_length_inout_config+0x6>
 1005370:	4705                	li	a4,1
 1005372:	cce18623          	sb	a4,-820(gp) # 101384cc <writeflag>
 1005376:	40029737          	lui	a4,0x40029
 100537a:	cca1aa23          	sw	a0,-812(gp) # 101384d4 <crypt_in>
 100537e:	40070713          	addi	a4,a4,1024 # 40029400 <bitmap+0x2fee9480>
 1005382:	4354                	lw	a3,4(a4)
 1005384:	ccc1a823          	sw	a2,-816(gp) # 101384d0 <crypt_out>
 1005388:	0045d793          	srli	a5,a1,0x4
 100538c:	17fd                	addi	a5,a5,-1
 100538e:	07a2                	slli	a5,a5,0x8
 1005390:	1007f793          	andi	a5,a5,256
 1005394:	eff6f693          	andi	a3,a3,-257
 1005398:	8fd5                	or	a5,a5,a3
 100539a:	c35c                	sw	a5,4(a4)
 100539c:	8082                	ret

0100539e <sm4_end>:
 100539e:	40029737          	lui	a4,0x40029
 10053a2:	40070713          	addi	a4,a4,1024 # 40029400 <bitmap+0x2fee9480>
 10053a6:	4334                	lw	a3,64(a4)
 10053a8:	cd01a783          	lw	a5,-816(gp) # 101384d0 <crypt_out>
 10053ac:	0086d593          	srli	a1,a3,0x8
 10053b0:	00d78023          	sb	a3,0(a5)
 10053b4:	00b780a3          	sb	a1,1(a5)
 10053b8:	0106d593          	srli	a1,a3,0x10
 10053bc:	82e1                	srli	a3,a3,0x18
 10053be:	00b78123          	sb	a1,2(a5)
 10053c2:	00d781a3          	sb	a3,3(a5)
 10053c6:	4374                	lw	a3,68(a4)
 10053c8:	07c1                	addi	a5,a5,16
 10053ca:	0086d593          	srli	a1,a3,0x8
 10053ce:	fed78a23          	sb	a3,-12(a5)
 10053d2:	feb78aa3          	sb	a1,-11(a5)
 10053d6:	0106d593          	srli	a1,a3,0x10
 10053da:	82e1                	srli	a3,a3,0x18
 10053dc:	feb78b23          	sb	a1,-10(a5)
 10053e0:	fed78ba3          	sb	a3,-9(a5)
 10053e4:	4734                	lw	a3,72(a4)
 10053e6:	0086d593          	srli	a1,a3,0x8
 10053ea:	fed78c23          	sb	a3,-8(a5)
 10053ee:	feb78ca3          	sb	a1,-7(a5)
 10053f2:	0106d593          	srli	a1,a3,0x10
 10053f6:	82e1                	srli	a3,a3,0x18
 10053f8:	fed78da3          	sb	a3,-5(a5)
 10053fc:	feb78d23          	sb	a1,-6(a5)
 1005400:	4778                	lw	a4,76(a4)
 1005402:	00875693          	srli	a3,a4,0x8
 1005406:	fed78ea3          	sb	a3,-3(a5)
 100540a:	01075693          	srli	a3,a4,0x10
 100540e:	fee78e23          	sb	a4,-4(a5)
 1005412:	fed78f23          	sb	a3,-2(a5)
 1005416:	8361                	srli	a4,a4,0x18
 1005418:	fee78fa3          	sb	a4,-1(a5)
 100541c:	cd41a703          	lw	a4,-812(gp) # 101384d4 <crypt_in>
 1005420:	ccf1a823          	sw	a5,-816(gp) # 101384d0 <crypt_out>
 1005424:	0741                	addi	a4,a4,16
 1005426:	cce1aa23          	sw	a4,-812(gp) # 101384d4 <crypt_in>
 100542a:	8082                	ret

0100542c <sm4_calculate>:
 100542c:	5cc062ef          	jal	t0,100b9f8 <__riscv_save_4>
 1005430:	40029437          	lui	s0,0x40029
 1005434:	40040413          	addi	s0,s0,1024 # 40029400 <bitmap+0x2fee9480>
 1005438:	4785                	li	a5,1
 100543a:	c01c                	sw	a5,0(s0)
 100543c:	4989                	li	s3,2
 100543e:	545c                	lw	a5,44(s0)
 1005440:	8b89                	andi	a5,a5,2
 1005442:	eb89                	bnez	a5,1005454 <sm4_calculate+0x28>
 1005444:	545c                	lw	a5,44(s0)
 1005446:	8b85                	andi	a5,a5,1
 1005448:	dbfd                	beqz	a5,100543e <sm4_calculate+0x12>
 100544a:	4785                	li	a5,1
 100544c:	d05c                	sw	a5,36(s0)
 100544e:	3f81                	jal	100539e <sm4_end>
 1005450:	5dc0606f          	j	100ba2c <__riscv_restore_4>
 1005454:	ccc1c483          	lbu	s1,-820(gp) # 101384cc <writeflag>
 1005458:	c889                	beqz	s1,100546a <sm4_calculate+0x3e>
 100545a:	3d11                	jal	100526e <sm4_start>
 100545c:	0014c493          	xori	s1,s1,1
 1005460:	cc918623          	sb	s1,-820(gp) # 101384cc <writeflag>
 1005464:	03342223          	sw	s3,36(s0)
 1005468:	bfd9                	j	100543e <sm4_calculate+0x12>
 100546a:	3f15                	jal	100539e <sm4_end>
 100546c:	bfc5                	j	100545c <sm4_calculate+0x30>

0100546e <block_crypt>:
 100546e:	4705                	li	a4,1
 1005470:	cce18623          	sb	a4,-820(gp) # 101384cc <writeflag>
 1005474:	cca1aa23          	sw	a0,-812(gp) # 101384d4 <crypt_in>
 1005478:	ccb1a823          	sw	a1,-816(gp) # 101384d0 <crypt_out>
 100547c:	400297b7          	lui	a5,0x40029
 1005480:	40078793          	addi	a5,a5,1024 # 40029400 <bitmap+0x2fee9480>
 1005484:	43d8                	lw	a4,4(a5)
 1005486:	eff77713          	andi	a4,a4,-257
 100548a:	c3d8                	sw	a4,4(a5)
 100548c:	b745                	j	100542c <sm4_calculate>

0100548e <HAL_SM4_Init>:
 100548e:	584062ef          	jal	t0,100ba12 <__riscv_save_0>
 1005492:	ea9fa0ef          	jal	100033a <HAL_LSSM4_MSP_Init>
 1005496:	4501                	li	a0,0
 1005498:	59e0606f          	j	100ba36 <__riscv_restore_0>

0100549c <sm4_key_start>:
 100549c:	576062ef          	jal	t0,100ba12 <__riscv_save_0>
 10054a0:	40029437          	lui	s0,0x40029
 10054a4:	40040413          	addi	s0,s0,1024 # 40029400 <bitmap+0x2fee9480>
 10054a8:	84aa                	mv	s1,a0
 10054aa:	3b5d                	jal	1005260 <u8tou32>
 10054ac:	c808                	sw	a0,16(s0)
 10054ae:	00448513          	addi	a0,s1,4 # e1000004 <bitmap+0xd0ec0084>
 10054b2:	337d                	jal	1005260 <u8tou32>
 10054b4:	c848                	sw	a0,20(s0)
 10054b6:	00848513          	addi	a0,s1,8
 10054ba:	335d                	jal	1005260 <u8tou32>
 10054bc:	cc08                	sw	a0,24(s0)
 10054be:	00c48513          	addi	a0,s1,12
 10054c2:	3b79                	jal	1005260 <u8tou32>
 10054c4:	cc48                	sw	a0,28(s0)
 10054c6:	4789                	li	a5,2
 10054c8:	c01c                	sw	a5,0(s0)
 10054ca:	56c0606f          	j	100ba36 <__riscv_restore_0>

010054ce <HAL_SM4_KeyExpansion>:
 10054ce:	544062ef          	jal	t0,100ba12 <__riscv_save_0>
 10054d2:	37e9                	jal	100549c <sm4_key_start>
 10054d4:	400297b7          	lui	a5,0x40029
 10054d8:	40078793          	addi	a5,a5,1024 # 40029400 <bitmap+0x2fee9480>
 10054dc:	57d8                	lw	a4,44(a5)
 10054de:	8b11                	andi	a4,a4,4
 10054e0:	df75                	beqz	a4,10054dc <HAL_SM4_KeyExpansion+0xe>
 10054e2:	4711                	li	a4,4
 10054e4:	d3d8                	sw	a4,36(a5)
 10054e6:	4501                	li	a0,0
 10054e8:	54e0606f          	j	100ba36 <__riscv_restore_0>

010054ec <HAL_SM4_Encrypt>:
 10054ec:	526062ef          	jal	t0,100ba12 <__riscv_save_0>
 10054f0:	87b2                	mv	a5,a2
 10054f2:	862e                	mv	a2,a1
 10054f4:	85be                	mv	a1,a5
 10054f6:	3d8d                	jal	1005368 <sm4_data_length_inout_config>
 10054f8:	400297b7          	lui	a5,0x40029
 10054fc:	40078793          	addi	a5,a5,1024 # 40029400 <bitmap+0x2fee9480>
 1005500:	43d8                	lw	a4,4(a5)
 1005502:	9b79                	andi	a4,a4,-2
 1005504:	c3d8                	sw	a4,4(a5)
 1005506:	371d                	jal	100542c <sm4_calculate>
 1005508:	4501                	li	a0,0
 100550a:	52c0606f          	j	100ba36 <__riscv_restore_0>

0100550e <HAL_SM4_Decrypt>:
 100550e:	504062ef          	jal	t0,100ba12 <__riscv_save_0>
 1005512:	87b2                	mv	a5,a2
 1005514:	862e                	mv	a2,a1
 1005516:	85be                	mv	a1,a5
 1005518:	3d81                	jal	1005368 <sm4_data_length_inout_config>
 100551a:	400297b7          	lui	a5,0x40029
 100551e:	40078793          	addi	a5,a5,1024 # 40029400 <bitmap+0x2fee9480>
 1005522:	43d8                	lw	a4,4(a5)
 1005524:	00176713          	ori	a4,a4,1
 1005528:	c3d8                	sw	a4,4(a5)
 100552a:	3709                	jal	100542c <sm4_calculate>
 100552c:	4501                	li	a0,0
 100552e:	5080606f          	j	100ba36 <__riscv_restore_0>

01005532 <HAL_SM4_CTR_Crypt>:
 1005532:	4b0062ef          	jal	t0,100b9e2 <__riscv_save_12>
 1005536:	40029937          	lui	s2,0x40029
 100553a:	40492783          	lw	a5,1028(s2) # 40029404 <bitmap+0x2fee9484>
 100553e:	1101                	addi	sp,sp,-32
 1005540:	4b05                	li	s6,1
 1005542:	9bf9                	andi	a5,a5,-2
 1005544:	40090913          	addi	s2,s2,1024
 1005548:	842a                	mv	s0,a0
 100554a:	89ae                	mv	s3,a1
 100554c:	84b2                	mv	s1,a2
 100554e:	8a36                	mv	s4,a3
 1005550:	01010a93          	addi	s5,sp,16
 1005554:	8c5a                	mv	s8,s6
 1005556:	8b8a                	mv	s7,sp
 1005558:	00f92223          	sw	a5,4(s2)
 100555c:	000aa023          	sw	zero,0(s5)
 1005560:	000aa223          	sw	zero,4(s5)
 1005564:	000aa423          	sw	zero,8(s5)
 1005568:	000aa623          	sw	zero,12(s5)
 100556c:	00492783          	lw	a5,4(s2)
 1005570:	cd818623          	sb	s8,-820(gp) # 101384cc <writeflag>
 1005574:	cc81aa23          	sw	s0,-812(gp) # 101384d4 <crypt_in>
 1005578:	eff7f793          	andi	a5,a5,-257
 100557c:	cd71a823          	sw	s7,-816(gp) # 101384d0 <crypt_out>
 1005580:	00f92223          	sw	a5,4(s2)
 1005584:	3565                	jal	100542c <sm4_calculate>
 1005586:	0114b793          	sltiu	a5,s1,17
 100558a:	4741                	li	a4,16
 100558c:	42f4970b          	th.mvnez	a4,s1,a5
 1005590:	4781                	li	a5,0
 1005592:	04e79f63          	bne	a5,a4,10055f0 <HAL_SM4_CTR_Crypt+0xbe>
 1005596:	99be                	add	s3,s3,a5
 1005598:	9a3e                	add	s4,s4,a5
 100559a:	8c9d                	sub	s1,s1,a5
 100559c:	00f44783          	lbu	a5,15(s0)
 10055a0:	0785                	addi	a5,a5,1
 10055a2:	0ff7f793          	zext.b	a5,a5
 10055a6:	00f407a3          	sb	a5,15(s0)
 10055aa:	e399                	bnez	a5,10055b0 <HAL_SM4_CTR_Crypt+0x7e>
 10055ac:	01810f23          	sb	s8,30(sp)
 10055b0:	86d6                	mv	a3,s5
 10055b2:	00f40713          	addi	a4,s0,15
 10055b6:	00f6c783          	lbu	a5,15(a3)
 10055ba:	cb99                	beqz	a5,10055d0 <HAL_SM4_CTR_Crypt+0x9e>
 10055bc:	00074783          	lbu	a5,0(a4)
 10055c0:	0785                	addi	a5,a5,1
 10055c2:	0ff7f793          	zext.b	a5,a5
 10055c6:	00f70023          	sb	a5,0(a4)
 10055ca:	e399                	bnez	a5,10055d0 <HAL_SM4_CTR_Crypt+0x9e>
 10055cc:	01668723          	sb	s6,14(a3)
 10055d0:	177d                	addi	a4,a4,-1
 10055d2:	16fd                	addi	a3,a3,-1
 10055d4:	fee411e3          	bne	s0,a4,10055b6 <HAL_SM4_CTR_Crypt+0x84>
 10055d8:	01014783          	lbu	a5,16(sp)
 10055dc:	c791                	beqz	a5,10055e8 <HAL_SM4_CTR_Crypt+0xb6>
 10055de:	00044783          	lbu	a5,0(s0)
 10055e2:	0785                	addi	a5,a5,1
 10055e4:	00f40023          	sb	a5,0(s0)
 10055e8:	f8b5                	bnez	s1,100555c <HAL_SM4_CTR_Crypt+0x2a>
 10055ea:	6105                	addi	sp,sp,32
 10055ec:	4320606f          	j	100ba1e <__riscv_restore_12>
 10055f0:	80f9c60b          	th.lrbu	a2,s3,a5,0
 10055f4:	80fbc68b          	th.lrbu	a3,s7,a5,0
 10055f8:	8eb1                	xor	a3,a3,a2
 10055fa:	00fa568b          	th.srb	a3,s4,a5,0
 10055fe:	0785                	addi	a5,a5,1
 1005600:	bf49                	j	1005592 <HAL_SM4_CTR_Crypt+0x60>

01005602 <HAL_SM4_GCM_Decrypt>:
 1005602:	3e0062ef          	jal	t0,100b9e2 <__riscv_save_12>
 1005606:	7171                	addi	sp,sp,-176
 1005608:	c63a                	sw	a4,12(sp)
 100560a:	c83e                	sw	a5,16(sp)
 100560c:	5b4e                	lw	s6,240(sp)
 100560e:	38060963          	beqz	a2,10059a0 <HAL_SM4_GCM_Decrypt+0x39e>
 1005612:	8a2a                	mv	s4,a0
 1005614:	4501                	li	a0,0
 1005616:	26070263          	beqz	a4,100587a <HAL_SM4_GCM_Decrypt+0x278>
 100561a:	47c2                	lw	a5,16(sp)
 100561c:	4711                	li	a4,4
 100561e:	17d1                	addi	a5,a5,-12
 1005620:	24f76d63          	bltu	a4,a5,100587a <HAL_SM4_GCM_Decrypt+0x278>
 1005624:	84ae                	mv	s1,a1
 1005626:	8436                	mv	s0,a3
 1005628:	85b2                	mv	a1,a2
 100562a:	89c2                	mv	s3,a6
 100562c:	8946                	mv	s2,a7
 100562e:	00081463          	bnez	a6,1005636 <HAL_SM4_GCM_Decrypt+0x34>
 1005632:	24089463          	bnez	a7,100587a <HAL_SM4_GCM_Decrypt+0x278>
 1005636:	4501                	li	a0,0
 1005638:	24040163          	beqz	s0,100587a <HAL_SM4_GCM_Decrypt+0x278>
 100563c:	00048663          	beqz	s1,1005648 <HAL_SM4_GCM_Decrypt+0x46>
 1005640:	220a0d63          	beqz	s4,100587a <HAL_SM4_GCM_Decrypt+0x278>
 1005644:	220b0b63          	beqz	s6,100587a <HAL_SM4_GCM_Decrypt+0x278>
 1005648:	400297b7          	lui	a5,0x40029
 100564c:	40078793          	addi	a5,a5,1024 # 40029400 <bitmap+0x2fee9480>
 1005650:	43d8                	lw	a4,4(a5)
 1005652:	09010a93          	addi	s5,sp,144
 1005656:	8622                	mv	a2,s0
 1005658:	9b79                	andi	a4,a4,-2
 100565a:	c3d8                	sw	a4,4(a5)
 100565c:	8556                	mv	a0,s5
 100565e:	00f4f793          	andi	a5,s1,15
 1005662:	4bc1                	li	s7,16
 1005664:	c23e                	sw	a5,4(sp)
 1005666:	d082                	sw	zero,96(sp)
 1005668:	d282                	sw	zero,100(sp)
 100566a:	d482                	sw	zero,104(sp)
 100566c:	d682                	sw	zero,108(sp)
 100566e:	d882                	sw	zero,112(sp)
 1005670:	da82                	sw	zero,116(sp)
 1005672:	dc82                	sw	zero,120(sp)
 1005674:	de82                	sw	zero,124(sp)
 1005676:	c102                	sw	zero,128(sp)
 1005678:	c302                	sw	zero,132(sp)
 100567a:	c502                	sw	zero,136(sp)
 100567c:	c702                	sw	zero,140(sp)
 100567e:	c902                	sw	zero,144(sp)
 1005680:	cb02                	sw	zero,148(sp)
 1005682:	cd02                	sw	zero,152(sp)
 1005684:	cf02                	sw	zero,156(sp)
 1005686:	d102                	sw	zero,160(sp)
 1005688:	d302                	sw	zero,164(sp)
 100568a:	d502                	sw	zero,168(sp)
 100568c:	d702                	sw	zero,172(sp)
 100568e:	408b8bb3          	sub	s7,s7,s0
 1005692:	482060ef          	jal	100bb14 <memcpy>
 1005696:	865e                	mv	a2,s7
 1005698:	4581                	li	a1,0
 100569a:	0968                	addi	a0,sp,156
 100569c:	490060ef          	jal	100bb2c <memset>
 10056a0:	4785                	li	a5,1
 10056a2:	ff04fc93          	andi	s9,s1,-16
 10056a6:	08f10fa3          	sb	a5,159(sp)
 10056aa:	019a07b3          	add	a5,s4,s9
 10056ae:	c43e                	sw	a5,8(sp)
 10056b0:	8dda                	mv	s11,s6
 10056b2:	8d52                	mv	s10,s4
 10056b4:	008a8c33          	add	s8,s5,s0
 10056b8:	47a2                	lw	a5,8(sp)
 10056ba:	04fd1563          	bne	s10,a5,1005704 <HAL_SM4_GCM_Decrypt+0x102>
 10056be:	4792                	lw	a5,4(sp)
 10056c0:	e7c1                	bnez	a5,1005748 <HAL_SM4_GCM_Decrypt+0x146>
 10056c2:	108c                	addi	a1,sp,96
 10056c4:	852e                	mv	a0,a1
 10056c6:	3365                	jal	100546e <block_crypt>
 10056c8:	1800                	addi	s0,sp,48
 10056ca:	010007b7          	lui	a5,0x1000
 10056ce:	8556                	mv	a0,s5
 10056d0:	188c                	addi	a1,sp,112
 10056d2:	d47c                	sw	a5,108(s0)
 10056d4:	3b69                	jal	100546e <block_crypt>
 10056d6:	03042b83          	lw	s7,48(s0)
 10056da:	03442c03          	lw	s8,52(s0)
 10056de:	03842a83          	lw	s5,56(s0)
 10056e2:	03c42b03          	lw	s6,60(s0)
 10056e6:	820b9b8b          	th.rev	s7,s7
 10056ea:	820c1c0b          	th.rev	s8,s8
 10056ee:	820a9a8b          	th.rev	s5,s5
 10056f2:	820b1b0b          	th.rev	s6,s6
 10056f6:	08091063          	bnez	s2,1005776 <HAL_SM4_GCM_Decrypt+0x174>
 10056fa:	4c81                	li	s9,0
 10056fc:	4981                	li	s3,0
 10056fe:	4d81                	li	s11,0
 1005700:	4d01                	li	s10,0
 1005702:	a8d5                	j	10057f6 <HAL_SM4_GCM_Decrypt+0x1f4>
 1005704:	85de                	mv	a1,s7
 1005706:	8562                	mv	a0,s8
 1005708:	31b1                	jal	1005354 <inc_ctr>
 100570a:	110c                	addi	a1,sp,160
 100570c:	8556                	mv	a0,s5
 100570e:	3385                	jal	100546e <block_crypt>
 1005710:	1814                	addi	a3,sp,48
 1005712:	000d2603          	lw	a2,0(s10)
 1005716:	5aac                	lw	a1,112(a3)
 1005718:	004d2503          	lw	a0,4(s10)
 100571c:	0dc1                	addi	s11,s11,16
 100571e:	8db1                	xor	a1,a1,a2
 1005720:	5af0                	lw	a2,116(a3)
 1005722:	febda823          	sw	a1,-16(s11)
 1005726:	0d41                	addi	s10,s10,16
 1005728:	8e29                	xor	a2,a2,a0
 100572a:	fecdaa23          	sw	a2,-12(s11)
 100572e:	ff8d2583          	lw	a1,-8(s10)
 1005732:	5eb0                	lw	a2,120(a3)
 1005734:	5ef4                	lw	a3,124(a3)
 1005736:	8e2d                	xor	a2,a2,a1
 1005738:	ffcd2583          	lw	a1,-4(s10)
 100573c:	fecdac23          	sw	a2,-8(s11)
 1005740:	8ead                	xor	a3,a3,a1
 1005742:	feddae23          	sw	a3,-4(s11)
 1005746:	bf8d                	j	10056b8 <HAL_SM4_GCM_Decrypt+0xb6>
 1005748:	008a8533          	add	a0,s5,s0
 100574c:	85de                	mv	a1,s7
 100574e:	3119                	jal	1005354 <inc_ctr>
 1005750:	1100                	addi	s0,sp,160
 1005752:	85a2                	mv	a1,s0
 1005754:	8556                	mv	a0,s5
 1005756:	3b21                	jal	100546e <block_crypt>
 1005758:	9b66                	add	s6,s6,s9
 100575a:	4781                	li	a5,0
 100575c:	4722                	lw	a4,8(sp)
 100575e:	80f4468b          	th.lrbu	a3,s0,a5,0
 1005762:	80f7470b          	th.lrbu	a4,a4,a5,0
 1005766:	8f35                	xor	a4,a4,a3
 1005768:	00fb570b          	th.srb	a4,s6,a5,0
 100576c:	4712                	lw	a4,4(sp)
 100576e:	0785                	addi	a5,a5,1 # 1000001 <Reset_Handler+0x1>
 1005770:	fef716e3          	bne	a4,a5,100575c <HAL_SM4_GCM_Decrypt+0x15a>
 1005774:	b7b9                	j	10056c2 <HAL_SM4_GCM_Decrypt+0xc0>
 1005776:	f80982e3          	beqz	s3,10056fa <HAL_SM4_GCM_Decrypt+0xf8>
 100577a:	ff097e13          	andi	t3,s2,-16
 100577e:	9e4e                	add	t3,t3,s3
 1005780:	884e                	mv	a6,s3
 1005782:	00f97313          	andi	t1,s2,15
 1005786:	4c81                	li	s9,0
 1005788:	4981                	li	s3,0
 100578a:	4d81                	li	s11,0
 100578c:	4d01                	li	s10,0
 100578e:	0fc81963          	bne	a6,t3,1005880 <HAL_SM4_GCM_Decrypt+0x27e>
 1005792:	06030263          	beqz	t1,10057f6 <HAL_SM4_GCM_Decrypt+0x1f4>
 1005796:	0088                	addi	a0,sp,64
 1005798:	861a                	mv	a2,t1
 100579a:	85c2                	mv	a1,a6
 100579c:	00052023          	sw	zero,0(a0)
 10057a0:	00052223          	sw	zero,4(a0)
 10057a4:	00052423          	sw	zero,8(a0)
 10057a8:	00052623          	sw	zero,12(a0)
 10057ac:	368060ef          	jal	100bb14 <memcpy>
 10057b0:	4836                	lw	a6,76(sp)
 10057b2:	4886                	lw	a7,64(sp)
 10057b4:	4616                	lw	a2,68(sp)
 10057b6:	4526                	lw	a0,72(sp)
 10057b8:	8208180b          	th.rev	a6,a6
 10057bc:	010cc7b3          	xor	a5,s9,a6
 10057c0:	8208988b          	th.rev	a7,a7
 10057c4:	8206160b          	th.rev	a2,a2
 10057c8:	8205150b          	th.rev	a0,a0
 10057cc:	01b646b3          	xor	a3,a2,s11
 10057d0:	01a8c733          	xor	a4,a7,s10
 10057d4:	d43e                	sw	a5,40(sp)
 10057d6:	85a2                	mv	a1,s0
 10057d8:	00a9c7b3          	xor	a5,s3,a0
 10057dc:	1008                	addi	a0,sp,32
 10057de:	d036                	sw	a3,32(sp)
 10057e0:	d23a                	sw	a4,36(sp)
 10057e2:	d63e                	sw	a5,44(sp)
 10057e4:	d862                	sw	s8,48(sp)
 10057e6:	da5e                	sw	s7,52(sp)
 10057e8:	dc5a                	sw	s6,56(sp)
 10057ea:	de56                	sw	s5,60(sp)
 10057ec:	3c55                	jal	10052a0 <gmult>
 10057ee:	5d82                	lw	s11,32(sp)
 10057f0:	5d12                	lw	s10,36(sp)
 10057f2:	5ca2                	lw	s9,40(sp)
 10057f4:	59b2                	lw	s3,44(sp)
 10057f6:	c099                	beqz	s1,10057fc <HAL_SM4_GCM_Decrypt+0x1fa>
 10057f8:	120a1d63          	bnez	s4,1005932 <HAL_SM4_GCM_Decrypt+0x330>
 10057fc:	01d95613          	srli	a2,s2,0x1d
 1005800:	01a64733          	xor	a4,a2,s10
 1005804:	d23a                	sw	a4,36(sp)
 1005806:	090e                	slli	s2,s2,0x3
 1005808:	01d4d713          	srli	a4,s1,0x1d
 100580c:	048e                	slli	s1,s1,0x3
 100580e:	013747b3          	xor	a5,a4,s3
 1005812:	1008                	addi	a0,sp,32
 1005814:	01b94933          	xor	s2,s2,s11
 1005818:	0194c4b3          	xor	s1,s1,s9
 100581c:	85a2                	mv	a1,s0
 100581e:	d63e                	sw	a5,44(sp)
 1005820:	d04a                	sw	s2,32(sp)
 1005822:	d426                	sw	s1,40(sp)
 1005824:	d862                	sw	s8,48(sp)
 1005826:	da5e                	sw	s7,52(sp)
 1005828:	dc5a                	sw	s6,56(sp)
 100582a:	de56                	sw	s5,60(sp)
 100582c:	3c95                	jal	10052a0 <gmult>
 100582e:	5682                	lw	a3,32(sp)
 1005830:	5612                	lw	a2,36(sp)
 1005832:	57a2                	lw	a5,40(sp)
 1005834:	5732                	lw	a4,44(sp)
 1005836:	8206968b          	th.rev	a3,a3
 100583a:	8207978b          	th.rev	a5,a5
 100583e:	8206160b          	th.rev	a2,a2
 1005842:	8207170b          	th.rev	a4,a4
 1005846:	c874                	sw	a3,84(s0)
 1005848:	cc7c                	sw	a5,92(s0)
 100584a:	fb010a13          	addi	s4,sp,-80
 100584e:	c830                	sw	a2,80(s0)
 1005850:	cc38                	sw	a4,88(s0)
 1005852:	4781                	li	a5,0
 1005854:	0108                	addi	a0,sp,128
 1005856:	46c1                	li	a3,16
 1005858:	1890                	addi	a2,sp,112
 100585a:	80a7c70b          	th.lrbu	a4,a5,a0,0
 100585e:	80f6460b          	th.lrbu	a2,a2,a5,0
 1005862:	8f31                	xor	a4,a4,a2
 1005864:	00a7d70b          	th.srb	a4,a5,a0,0
 1005868:	0785                	addi	a5,a5,1
 100586a:	fed797e3          	bne	a5,a3,1005858 <HAL_SM4_GCM_Decrypt+0x256>
 100586e:	4642                	lw	a2,16(sp)
 1005870:	45b2                	lw	a1,12(sp)
 1005872:	27c060ef          	jal	100baee <memcmp>
 1005876:	00153513          	seqz	a0,a0
 100587a:	614d                	addi	sp,sp,176
 100587c:	1a20606f          	j	100ba1e <__riscv_restore_12>
 1005880:	85c2                	mv	a1,a6
 1005882:	4641                	li	a2,16
 1005884:	0088                	addi	a0,sp,64
 1005886:	ce72                	sw	t3,28(sp)
 1005888:	cc1a                	sw	t1,24(sp)
 100588a:	ca42                	sw	a6,20(sp)
 100588c:	288060ef          	jal	100bb14 <memcpy>
 1005890:	4526                	lw	a0,72(sp)
 1005892:	4e86                	lw	t4,64(sp)
 1005894:	4616                	lw	a2,68(sp)
 1005896:	48b6                	lw	a7,76(sp)
 1005898:	8205150b          	th.rev	a0,a0
 100589c:	00a9c533          	xor	a0,s3,a0
 10058a0:	8206160b          	th.rev	a2,a2
 10058a4:	8208988b          	th.rev	a7,a7
 10058a8:	820e9e8b          	th.rev	t4,t4
 10058ac:	01b646b3          	xor	a3,a2,s11
 10058b0:	01aeceb3          	xor	t4,t4,s10
 10058b4:	011cc7b3          	xor	a5,s9,a7
 10058b8:	d62a                	sw	a0,44(sp)
 10058ba:	85a2                	mv	a1,s0
 10058bc:	1008                	addi	a0,sp,32
 10058be:	d036                	sw	a3,32(sp)
 10058c0:	d276                	sw	t4,36(sp)
 10058c2:	d43e                	sw	a5,40(sp)
 10058c4:	d862                	sw	s8,48(sp)
 10058c6:	da5e                	sw	s7,52(sp)
 10058c8:	dc5a                	sw	s6,56(sp)
 10058ca:	de56                	sw	s5,60(sp)
 10058cc:	3ad1                	jal	10052a0 <gmult>
 10058ce:	4852                	lw	a6,20(sp)
 10058d0:	5d82                	lw	s11,32(sp)
 10058d2:	5d12                	lw	s10,36(sp)
 10058d4:	5ca2                	lw	s9,40(sp)
 10058d6:	59b2                	lw	s3,44(sp)
 10058d8:	4e72                	lw	t3,28(sp)
 10058da:	4362                	lw	t1,24(sp)
 10058dc:	0841                	addi	a6,a6,16
 10058de:	bd45                	j	100578e <HAL_SM4_GCM_Decrypt+0x18c>
 10058e0:	85d2                	mv	a1,s4
 10058e2:	4641                	li	a2,16
 10058e4:	0888                	addi	a0,sp,80
 10058e6:	22e060ef          	jal	100bb14 <memcpy>
 10058ea:	4876                	lw	a6,92(sp)
 10058ec:	48c6                	lw	a7,80(sp)
 10058ee:	4656                	lw	a2,84(sp)
 10058f0:	4566                	lw	a0,88(sp)
 10058f2:	8208180b          	th.rev	a6,a6
 10058f6:	019847b3          	xor	a5,a6,s9
 10058fa:	8208988b          	th.rev	a7,a7
 10058fe:	8206160b          	th.rev	a2,a2
 1005902:	8205150b          	th.rev	a0,a0
 1005906:	00cdc6b3          	xor	a3,s11,a2
 100590a:	011d4733          	xor	a4,s10,a7
 100590e:	d43e                	sw	a5,40(sp)
 1005910:	85a2                	mv	a1,s0
 1005912:	013547b3          	xor	a5,a0,s3
 1005916:	1008                	addi	a0,sp,32
 1005918:	d036                	sw	a3,32(sp)
 100591a:	d23a                	sw	a4,36(sp)
 100591c:	d63e                	sw	a5,44(sp)
 100591e:	d862                	sw	s8,48(sp)
 1005920:	da5e                	sw	s7,52(sp)
 1005922:	dc5a                	sw	s6,56(sp)
 1005924:	de56                	sw	s5,60(sp)
 1005926:	3aad                	jal	10052a0 <gmult>
 1005928:	5d82                	lw	s11,32(sp)
 100592a:	5d12                	lw	s10,36(sp)
 100592c:	5ca2                	lw	s9,40(sp)
 100592e:	59b2                	lw	s3,44(sp)
 1005930:	0a41                	addi	s4,s4,16
 1005932:	47a2                	lw	a5,8(sp)
 1005934:	fb4796e3          	bne	a5,s4,10058e0 <HAL_SM4_GCM_Decrypt+0x2de>
 1005938:	4792                	lw	a5,4(sp)
 100593a:	ec0781e3          	beqz	a5,10057fc <HAL_SM4_GCM_Decrypt+0x1fa>
 100593e:	45a2                	lw	a1,8(sp)
 1005940:	0888                	addi	a0,sp,80
 1005942:	863e                	mv	a2,a5
 1005944:	00052023          	sw	zero,0(a0)
 1005948:	00052223          	sw	zero,4(a0)
 100594c:	00052423          	sw	zero,8(a0)
 1005950:	00052623          	sw	zero,12(a0)
 1005954:	1c0060ef          	jal	100bb14 <memcpy>
 1005958:	4576                	lw	a0,92(sp)
 100595a:	4846                	lw	a6,80(sp)
 100595c:	48d6                	lw	a7,84(sp)
 100595e:	45e6                	lw	a1,88(sp)
 1005960:	8205150b          	th.rev	a0,a0
 1005964:	019547b3          	xor	a5,a0,s9
 1005968:	8208180b          	th.rev	a6,a6
 100596c:	8208988b          	th.rev	a7,a7
 1005970:	8205958b          	th.rev	a1,a1
 1005974:	011dc6b3          	xor	a3,s11,a7
 1005978:	010d4733          	xor	a4,s10,a6
 100597c:	d43e                	sw	a5,40(sp)
 100597e:	1008                	addi	a0,sp,32
 1005980:	0135c7b3          	xor	a5,a1,s3
 1005984:	85a2                	mv	a1,s0
 1005986:	d036                	sw	a3,32(sp)
 1005988:	d23a                	sw	a4,36(sp)
 100598a:	d63e                	sw	a5,44(sp)
 100598c:	d862                	sw	s8,48(sp)
 100598e:	da5e                	sw	s7,52(sp)
 1005990:	dc5a                	sw	s6,56(sp)
 1005992:	de56                	sw	s5,60(sp)
 1005994:	3231                	jal	10052a0 <gmult>
 1005996:	5d82                	lw	s11,32(sp)
 1005998:	5d12                	lw	s10,36(sp)
 100599a:	5ca2                	lw	s9,40(sp)
 100599c:	59b2                	lw	s3,44(sp)
 100599e:	bdb9                	j	10057fc <HAL_SM4_GCM_Decrypt+0x1fa>
 10059a0:	4501                	li	a0,0
 10059a2:	bde1                	j	100587a <HAL_SM4_GCM_Decrypt+0x278>

010059a4 <HAL_SM4_GCM_Decrypt_Init>:
 10059a4:	06e062ef          	jal	t0,100ba12 <__riscv_save_0>
 10059a8:	84b2                	mv	s1,a2
 10059aa:	892e                	mv	s2,a1
 10059ac:	07000613          	li	a2,112
 10059b0:	4581                	li	a1,0
 10059b2:	842a                	mv	s0,a0
 10059b4:	178060ef          	jal	100bb2c <memset>
 10059b8:	400297b7          	lui	a5,0x40029
 10059bc:	40078793          	addi	a5,a5,1024 # 40029400 <bitmap+0x2fee9480>
 10059c0:	d024                	sw	s1,96(s0)
 10059c2:	43d8                	lw	a4,4(a5)
 10059c4:	9b79                	andi	a4,a4,-2
 10059c6:	c3d8                	sw	a4,4(a5)
 10059c8:	47b1                	li	a5,12
 10059ca:	02f49063          	bne	s1,a5,10059ea <HAL_SM4_GCM_Decrypt_Init+0x46>
 10059ce:	8626                	mv	a2,s1
 10059d0:	85ca                	mv	a1,s2
 10059d2:	8522                	mv	a0,s0
 10059d4:	140060ef          	jal	100bb14 <memcpy>
 10059d8:	4785                	li	a5,1
 10059da:	00040623          	sb	zero,12(s0)
 10059de:	000406a3          	sb	zero,13(s0)
 10059e2:	00040723          	sb	zero,14(s0)
 10059e6:	00f407a3          	sb	a5,15(s0)
 10059ea:	01040493          	addi	s1,s0,16
 10059ee:	85a6                	mv	a1,s1
 10059f0:	8526                	mv	a0,s1
 10059f2:	3cb5                	jal	100546e <block_crypt>
 10059f4:	03040593          	addi	a1,s0,48
 10059f8:	8522                	mv	a0,s0
 10059fa:	3c95                	jal	100546e <block_crypt>
 10059fc:	4641                	li	a2,16
 10059fe:	85a6                	mv	a1,s1
 1005a00:	04040513          	addi	a0,s0,64
 1005a04:	110060ef          	jal	100bb14 <memcpy>
 1005a08:	403c                	lw	a5,64(s0)
 1005a0a:	4078                	lw	a4,68(s0)
 1005a0c:	8207978b          	th.rev	a5,a5
 1005a10:	8207170b          	th.rev	a4,a4
 1005a14:	c038                	sw	a4,64(s0)
 1005a16:	c07c                	sw	a5,68(s0)
 1005a18:	4478                	lw	a4,76(s0)
 1005a1a:	443c                	lw	a5,72(s0)
 1005a1c:	8207170b          	th.rev	a4,a4
 1005a20:	8207978b          	th.rev	a5,a5
 1005a24:	c438                	sw	a4,72(s0)
 1005a26:	c47c                	sw	a5,76(s0)
 1005a28:	00e0606f          	j	100ba36 <__riscv_restore_0>

01005a2c <HAL_SM4_GCM_Decrypt_Update>:
 1005a2c:	7b7052ef          	jal	t0,100b9e2 <__riscv_save_12>
 1005a30:	893e                	mv	s2,a5
 1005a32:	517c                	lw	a5,100(a0)
 1005a34:	7179                	addi	sp,sp,-48
 1005a36:	ff06fd13          	andi	s10,a3,-16
 1005a3a:	97b6                	add	a5,a5,a3
 1005a3c:	d17c                	sw	a5,100(a0)
 1005a3e:	553c                	lw	a5,104(a0)
 1005a40:	842a                	mv	s0,a0
 1005a42:	8aae                	mv	s5,a1
 1005a44:	97ca                	add	a5,a5,s2
 1005a46:	89b2                	mv	s3,a2
 1005a48:	8a36                	mv	s4,a3
 1005a4a:	84ba                	mv	s1,a4
 1005a4c:	00f6fb93          	andi	s7,a3,15
 1005a50:	d53c                	sw	a5,104(a0)
 1005a52:	01a60c33          	add	s8,a2,s10
 1005a56:	8cb2                	mv	s9,a2
 1005a58:	8b2e                	mv	s6,a1
 1005a5a:	4dc1                	li	s11,16
 1005a5c:	099c1063          	bne	s8,s9,1005adc <HAL_SM4_GCM_Decrypt_Update+0xb0>
 1005a60:	0c0b9263          	bnez	s7,1005b24 <HAL_SM4_GCM_Decrypt_Update+0xf8>
 1005a64:	0e091963          	bnez	s2,1005b56 <HAL_SM4_GCM_Decrypt_Update+0x12a>
 1005a68:	060a0763          	beqz	s4,1005ad6 <HAL_SM4_GCM_Decrypt_Update+0xaa>
 1005a6c:	06098563          	beqz	s3,1005ad6 <HAL_SM4_GCM_Decrypt_Update+0xaa>
 1005a70:	04040493          	addi	s1,s0,64
 1005a74:	05040913          	addi	s2,s0,80
 1005a78:	193c9963          	bne	s9,s3,1005c0a <HAL_SM4_GCM_Decrypt_Update+0x1de>
 1005a7c:	040b8d63          	beqz	s7,1005ad6 <HAL_SM4_GCM_Decrypt_Update+0xaa>
 1005a80:	0808                	addi	a0,sp,16
 1005a82:	865e                	mv	a2,s7
 1005a84:	85e2                	mv	a1,s8
 1005a86:	00052023          	sw	zero,0(a0)
 1005a8a:	00052223          	sw	zero,4(a0)
 1005a8e:	00052423          	sw	zero,8(a0)
 1005a92:	00052623          	sw	zero,12(a0)
 1005a96:	07e060ef          	jal	100bb14 <memcpy>
 1005a9a:	4752                	lw	a4,20(sp)
 1005a9c:	4830                	lw	a2,80(s0)
 1005a9e:	45c2                	lw	a1,16(sp)
 1005aa0:	8207170b          	th.rev	a4,a4
 1005aa4:	8e39                	xor	a2,a2,a4
 1005aa6:	4878                	lw	a4,84(s0)
 1005aa8:	8205958b          	th.rev	a1,a1
 1005aac:	47f2                	lw	a5,28(sp)
 1005aae:	8f2d                	xor	a4,a4,a1
 1005ab0:	c878                	sw	a4,84(s0)
 1005ab2:	4c38                	lw	a4,88(s0)
 1005ab4:	8207978b          	th.rev	a5,a5
 1005ab8:	46e2                	lw	a3,24(sp)
 1005aba:	8f3d                	xor	a4,a4,a5
 1005abc:	4c7c                	lw	a5,92(s0)
 1005abe:	8206968b          	th.rev	a3,a3
 1005ac2:	c830                	sw	a2,80(s0)
 1005ac4:	8fb5                	xor	a5,a5,a3
 1005ac6:	cc38                	sw	a4,88(s0)
 1005ac8:	cc7c                	sw	a5,92(s0)
 1005aca:	04040593          	addi	a1,s0,64
 1005ace:	05040513          	addi	a0,s0,80
 1005ad2:	fceff0ef          	jal	10052a0 <gmult>
 1005ad6:	6145                	addi	sp,sp,48
 1005ad8:	7470506f          	j	100ba1e <__riscv_restore_12>
 1005adc:	5028                	lw	a0,96(s0)
 1005ade:	0b41                	addi	s6,s6,16
 1005ae0:	0cc1                	addi	s9,s9,16
 1005ae2:	40ad85b3          	sub	a1,s11,a0
 1005ae6:	9522                	add	a0,a0,s0
 1005ae8:	86dff0ef          	jal	1005354 <inc_ctr>
 1005aec:	100c                	addi	a1,sp,32
 1005aee:	8522                	mv	a0,s0
 1005af0:	3abd                	jal	100546e <block_crypt>
 1005af2:	ff0ca703          	lw	a4,-16(s9)
 1005af6:	5682                	lw	a3,32(sp)
 1005af8:	ff4ca603          	lw	a2,-12(s9)
 1005afc:	57b2                	lw	a5,44(sp)
 1005afe:	8eb9                	xor	a3,a3,a4
 1005b00:	5712                	lw	a4,36(sp)
 1005b02:	fedb2823          	sw	a3,-16(s6)
 1005b06:	8f31                	xor	a4,a4,a2
 1005b08:	feeb2a23          	sw	a4,-12(s6)
 1005b0c:	ff8ca683          	lw	a3,-8(s9)
 1005b10:	5722                	lw	a4,40(sp)
 1005b12:	8f35                	xor	a4,a4,a3
 1005b14:	ffcca683          	lw	a3,-4(s9)
 1005b18:	feeb2c23          	sw	a4,-8(s6)
 1005b1c:	8fb5                	xor	a5,a5,a3
 1005b1e:	fefb2e23          	sw	a5,-4(s6)
 1005b22:	bf2d                	j	1005a5c <HAL_SM4_GCM_Decrypt_Update+0x30>
 1005b24:	5028                	lw	a0,96(s0)
 1005b26:	45c1                	li	a1,16
 1005b28:	02010b13          	addi	s6,sp,32
 1005b2c:	8d89                	sub	a1,a1,a0
 1005b2e:	9522                	add	a0,a0,s0
 1005b30:	825ff0ef          	jal	1005354 <inc_ctr>
 1005b34:	85da                	mv	a1,s6
 1005b36:	8522                	mv	a0,s0
 1005b38:	3a1d                	jal	100546e <block_crypt>
 1005b3a:	9aea                	add	s5,s5,s10
 1005b3c:	4781                	li	a5,0
 1005b3e:	80fc470b          	th.lrbu	a4,s8,a5,0
 1005b42:	80fb468b          	th.lrbu	a3,s6,a5,0
 1005b46:	8f35                	xor	a4,a4,a3
 1005b48:	00fad70b          	th.srb	a4,s5,a5,0
 1005b4c:	0785                	addi	a5,a5,1
 1005b4e:	fefb98e3          	bne	s7,a5,1005b3e <HAL_SM4_GCM_Decrypt_Update+0x112>
 1005b52:	f0090de3          	beqz	s2,1005a6c <HAL_SM4_GCM_Decrypt_Update+0x40>
 1005b56:	f00489e3          	beqz	s1,1005a68 <HAL_SM4_GCM_Decrypt_Update+0x3c>
 1005b5a:	00f97d13          	andi	s10,s2,15
 1005b5e:	ff097913          	andi	s2,s2,-16
 1005b62:	9926                	add	s2,s2,s1
 1005b64:	04040a93          	addi	s5,s0,64
 1005b68:	05040b13          	addi	s6,s0,80
 1005b6c:	04991c63          	bne	s2,s1,1005bc4 <HAL_SM4_GCM_Decrypt_Update+0x198>
 1005b70:	ee0d0ce3          	beqz	s10,1005a68 <HAL_SM4_GCM_Decrypt_Update+0x3c>
 1005b74:	866a                	mv	a2,s10
 1005b76:	85ca                	mv	a1,s2
 1005b78:	850a                	mv	a0,sp
 1005b7a:	c002                	sw	zero,0(sp)
 1005b7c:	c202                	sw	zero,4(sp)
 1005b7e:	c402                	sw	zero,8(sp)
 1005b80:	c602                	sw	zero,12(sp)
 1005b82:	793050ef          	jal	100bb14 <memcpy>
 1005b86:	4712                	lw	a4,4(sp)
 1005b88:	4830                	lw	a2,80(s0)
 1005b8a:	4582                	lw	a1,0(sp)
 1005b8c:	8207170b          	th.rev	a4,a4
 1005b90:	8e39                	xor	a2,a2,a4
 1005b92:	4878                	lw	a4,84(s0)
 1005b94:	8205958b          	th.rev	a1,a1
 1005b98:	47b2                	lw	a5,12(sp)
 1005b9a:	8f2d                	xor	a4,a4,a1
 1005b9c:	c878                	sw	a4,84(s0)
 1005b9e:	4c38                	lw	a4,88(s0)
 1005ba0:	46a2                	lw	a3,8(sp)
 1005ba2:	8207978b          	th.rev	a5,a5
 1005ba6:	8f3d                	xor	a4,a4,a5
 1005ba8:	4c7c                	lw	a5,92(s0)
 1005baa:	8206968b          	th.rev	a3,a3
 1005bae:	c830                	sw	a2,80(s0)
 1005bb0:	8fb5                	xor	a5,a5,a3
 1005bb2:	cc38                	sw	a4,88(s0)
 1005bb4:	cc7c                	sw	a5,92(s0)
 1005bb6:	04040593          	addi	a1,s0,64
 1005bba:	05040513          	addi	a0,s0,80
 1005bbe:	ee2ff0ef          	jal	10052a0 <gmult>
 1005bc2:	b55d                	j	1005a68 <HAL_SM4_GCM_Decrypt_Update+0x3c>
 1005bc4:	85a6                	mv	a1,s1
 1005bc6:	4641                	li	a2,16
 1005bc8:	850a                	mv	a0,sp
 1005bca:	74b050ef          	jal	100bb14 <memcpy>
 1005bce:	4712                	lw	a4,4(sp)
 1005bd0:	4830                	lw	a2,80(s0)
 1005bd2:	4582                	lw	a1,0(sp)
 1005bd4:	8207170b          	th.rev	a4,a4
 1005bd8:	8e39                	xor	a2,a2,a4
 1005bda:	4878                	lw	a4,84(s0)
 1005bdc:	8205958b          	th.rev	a1,a1
 1005be0:	47b2                	lw	a5,12(sp)
 1005be2:	8f2d                	xor	a4,a4,a1
 1005be4:	c878                	sw	a4,84(s0)
 1005be6:	4c38                	lw	a4,88(s0)
 1005be8:	46a2                	lw	a3,8(sp)
 1005bea:	8207978b          	th.rev	a5,a5
 1005bee:	8f3d                	xor	a4,a4,a5
 1005bf0:	4c7c                	lw	a5,92(s0)
 1005bf2:	8206968b          	th.rev	a3,a3
 1005bf6:	c830                	sw	a2,80(s0)
 1005bf8:	8fb5                	xor	a5,a5,a3
 1005bfa:	cc38                	sw	a4,88(s0)
 1005bfc:	cc7c                	sw	a5,92(s0)
 1005bfe:	85d6                	mv	a1,s5
 1005c00:	855a                	mv	a0,s6
 1005c02:	e9eff0ef          	jal	10052a0 <gmult>
 1005c06:	04c1                	addi	s1,s1,16
 1005c08:	b795                	j	1005b6c <HAL_SM4_GCM_Decrypt_Update+0x140>
 1005c0a:	4641                	li	a2,16
 1005c0c:	85ce                	mv	a1,s3
 1005c0e:	00c10533          	add	a0,sp,a2
 1005c12:	703050ef          	jal	100bb14 <memcpy>
 1005c16:	4752                	lw	a4,20(sp)
 1005c18:	4830                	lw	a2,80(s0)
 1005c1a:	45c2                	lw	a1,16(sp)
 1005c1c:	8207170b          	th.rev	a4,a4
 1005c20:	8e39                	xor	a2,a2,a4
 1005c22:	4878                	lw	a4,84(s0)
 1005c24:	8205958b          	th.rev	a1,a1
 1005c28:	47f2                	lw	a5,28(sp)
 1005c2a:	8f2d                	xor	a4,a4,a1
 1005c2c:	c878                	sw	a4,84(s0)
 1005c2e:	4c38                	lw	a4,88(s0)
 1005c30:	46e2                	lw	a3,24(sp)
 1005c32:	8207978b          	th.rev	a5,a5
 1005c36:	8f3d                	xor	a4,a4,a5
 1005c38:	4c7c                	lw	a5,92(s0)
 1005c3a:	8206968b          	th.rev	a3,a3
 1005c3e:	c830                	sw	a2,80(s0)
 1005c40:	8fb5                	xor	a5,a5,a3
 1005c42:	cc38                	sw	a4,88(s0)
 1005c44:	cc7c                	sw	a5,92(s0)
 1005c46:	85a6                	mv	a1,s1
 1005c48:	854a                	mv	a0,s2
 1005c4a:	e56ff0ef          	jal	10052a0 <gmult>
 1005c4e:	09c1                	addi	s3,s3,16
 1005c50:	b525                	j	1005a78 <HAL_SM4_GCM_Decrypt_Update+0x4c>

01005c52 <HAL_SM4_GCM_Decrypt_Final>:
 1005c52:	5a7052ef          	jal	t0,100b9f8 <__riscv_save_4>
 1005c56:	5538                	lw	a4,104(a0)
 1005c58:	4934                	lw	a3,80(a0)
 1005c5a:	84ae                	mv	s1,a1
 1005c5c:	01d75593          	srli	a1,a4,0x1d
 1005c60:	070e                	slli	a4,a4,0x3
 1005c62:	8eb9                	xor	a3,a3,a4
 1005c64:	4978                	lw	a4,84(a0)
 1005c66:	517c                	lw	a5,100(a0)
 1005c68:	8932                	mv	s2,a2
 1005c6a:	8f2d                	xor	a4,a4,a1
 1005c6c:	c978                	sw	a4,84(a0)
 1005c6e:	4d38                	lw	a4,88(a0)
 1005c70:	01d7d613          	srli	a2,a5,0x1d
 1005c74:	078e                	slli	a5,a5,0x3
 1005c76:	8f3d                	xor	a4,a4,a5
 1005c78:	4d7c                	lw	a5,92(a0)
 1005c7a:	05050993          	addi	s3,a0,80
 1005c7e:	842a                	mv	s0,a0
 1005c80:	8fb1                	xor	a5,a5,a2
 1005c82:	c934                	sw	a3,80(a0)
 1005c84:	cd38                	sw	a4,88(a0)
 1005c86:	cd7c                	sw	a5,92(a0)
 1005c88:	04050593          	addi	a1,a0,64
 1005c8c:	854e                	mv	a0,s3
 1005c8e:	e12ff0ef          	jal	10052a0 <gmult>
 1005c92:	4878                	lw	a4,84(s0)
 1005c94:	483c                	lw	a5,80(s0)
 1005c96:	4641                	li	a2,16
 1005c98:	8207170b          	th.rev	a4,a4
 1005c9c:	c838                	sw	a4,80(s0)
 1005c9e:	8207978b          	th.rev	a5,a5
 1005ca2:	4c78                	lw	a4,92(s0)
 1005ca4:	c87c                	sw	a5,84(s0)
 1005ca6:	4c3c                	lw	a5,88(s0)
 1005ca8:	8207170b          	th.rev	a4,a4
 1005cac:	cc38                	sw	a4,88(s0)
 1005cae:	8207978b          	th.rev	a5,a5
 1005cb2:	02040713          	addi	a4,s0,32
 1005cb6:	cc7c                	sw	a5,92(s0)
 1005cb8:	853a                	mv	a0,a4
 1005cba:	85ce                	mv	a1,s3
 1005cbc:	659050ef          	jal	100bb14 <memcpy>
 1005cc0:	872a                	mv	a4,a0
 1005cc2:	03040413          	addi	s0,s0,48
 1005cc6:	87aa                	mv	a5,a0
 1005cc8:	9817c68b          	th.lbuia	a3,(a5),1,0
 1005ccc:	00f7c603          	lbu	a2,15(a5)
 1005cd0:	8eb1                	xor	a3,a3,a2
 1005cd2:	fed78fa3          	sb	a3,-1(a5)
 1005cd6:	fe8799e3          	bne	a5,s0,1005cc8 <HAL_SM4_GCM_Decrypt_Final+0x76>
 1005cda:	864a                	mv	a2,s2
 1005cdc:	85a6                	mv	a1,s1
 1005cde:	853a                	mv	a0,a4
 1005ce0:	60f050ef          	jal	100baee <memcmp>
 1005ce4:	00153513          	seqz	a0,a0
 1005ce8:	5450506f          	j	100ba2c <__riscv_restore_4>

01005cec <HAL_SM4_Calculation_Complete_Callback>:
 1005cec:	8082                	ret

01005cee <HAL_SM4_KeyExpansion_Complete_Callback>:
 1005cee:	8082                	ret

01005cf0 <HAL_SM4_IRQHandler>:
 1005cf0:	523052ef          	jal	t0,100ba12 <__riscv_save_0>
 1005cf4:	40029437          	lui	s0,0x40029
 1005cf8:	40040413          	addi	s0,s0,1024 # 40029400 <bitmap+0x2fee9480>
 1005cfc:	541c                	lw	a5,40(s0)
 1005cfe:	8b89                	andi	a5,a5,2
 1005d00:	cb91                	beqz	a5,1005d14 <HAL_SM4_IRQHandler+0x24>
 1005d02:	ccc1c703          	lbu	a4,-820(gp) # 101384cc <writeflag>
 1005d06:	c339                	beqz	a4,1005d4c <HAL_SM4_IRQHandler+0x5c>
 1005d08:	cc018623          	sb	zero,-820(gp) # 101384cc <writeflag>
 1005d0c:	d62ff0ef          	jal	100526e <sm4_start>
 1005d10:	4789                	li	a5,2
 1005d12:	d05c                	sw	a5,36(s0)
 1005d14:	40029437          	lui	s0,0x40029
 1005d18:	40040413          	addi	s0,s0,1024 # 40029400 <bitmap+0x2fee9480>
 1005d1c:	541c                	lw	a5,40(s0)
 1005d1e:	8b85                	andi	a5,a5,1
 1005d20:	cb91                	beqz	a5,1005d34 <HAL_SM4_IRQHandler+0x44>
 1005d22:	e7cff0ef          	jal	100539e <sm4_end>
 1005d26:	4785                	li	a5,1
 1005d28:	d05c                	sw	a5,36(s0)
 1005d2a:	4048                	lw	a0,4(s0)
 1005d2c:	fff54513          	not	a0,a0
 1005d30:	8d7d                	and	a0,a0,a5
 1005d32:	3f6d                	jal	1005cec <HAL_SM4_Calculation_Complete_Callback>
 1005d34:	400297b7          	lui	a5,0x40029
 1005d38:	40078793          	addi	a5,a5,1024 # 40029400 <bitmap+0x2fee9480>
 1005d3c:	5798                	lw	a4,40(a5)
 1005d3e:	8b11                	andi	a4,a4,4
 1005d40:	c701                	beqz	a4,1005d48 <HAL_SM4_IRQHandler+0x58>
 1005d42:	4711                	li	a4,4
 1005d44:	d3d8                	sw	a4,36(a5)
 1005d46:	3765                	jal	1005cee <HAL_SM4_KeyExpansion_Complete_Callback>
 1005d48:	4ef0506f          	j	100ba36 <__riscv_restore_0>
 1005d4c:	4705                	li	a4,1
 1005d4e:	cce18623          	sb	a4,-820(gp) # 101384cc <writeflag>
 1005d52:	e4cff0ef          	jal	100539e <sm4_end>
 1005d56:	bf6d                	j	1005d10 <HAL_SM4_IRQHandler+0x20>

01005d58 <HAL_LSCRC_Init>:
 1005d58:	dd0fa06f          	j	1000328 <HAL_LSCRC_MSP_Init>

01005d5c <HAL_LSCRC_Bit_Reverse>:
 1005d5c:	400297b7          	lui	a5,0x40029
 1005d60:	80078793          	addi	a5,a5,-2048 # 40028800 <bitmap+0x2fee8880>
 1005d64:	4705                	li	a4,1
 1005d66:	15fd                	addi	a1,a1,-1
 1005d68:	c398                	sw	a4,0(a5)
 1005d6a:	89fd                	andi	a1,a1,31
 1005d6c:	0007a223          	sw	zero,4(a5)
 1005d70:	1005e593          	ori	a1,a1,256
 1005d74:	c78c                	sw	a1,8(a5)
 1005d76:	c7d8                	sw	a4,12(a5)
 1005d78:	cb88                	sw	a0,16(a5)
 1005d7a:	5398                	lw	a4,32(a5)
 1005d7c:	5388                	lw	a0,32(a5)
 1005d7e:	8082                	ret

01005d80 <HAL_LSCRC_CRC_CALC>:
 1005d80:	46b052ef          	jal	t0,100b9ea <__riscv_save_10>
 1005d84:	842e                	mv	s0,a1
 1005d86:	00c54583          	lbu	a1,12(a0)
 1005d8a:	411c                	lw	a5,0(a0)
 1005d8c:	02000a13          	li	s4,32
 1005d90:	400299b7          	lui	s3,0x40029
 1005d94:	40ba0a33          	sub	s4,s4,a1
 1005d98:	80098993          	addi	s3,s3,-2048 # 40028800 <bitmap+0x2fee8880>
 1005d9c:	014797b3          	sll	a5,a5,s4
 1005da0:	1141                	addi	sp,sp,-16
 1005da2:	00f9a023          	sw	a5,0(s3)
 1005da6:	415c                	lw	a5,4(a0)
 1005da8:	470d                	li	a4,3
 1005daa:	84aa                	mv	s1,a0
 1005dac:	014797b3          	sll	a5,a5,s4
 1005db0:	00f9a223          	sw	a5,4(s3)
 1005db4:	4785                	li	a5,1
 1005db6:	00f9a623          	sw	a5,12(s3)
 1005dba:	8932                	mv	s2,a2
 1005dbc:	04c77463          	bgeu	a4,a2,1005e04 <HAL_LSCRC_CRC_CALC+0x84>
 1005dc0:	455c                	lw	a5,12(a0)
 1005dc2:	8aa2                	mv	s5,s0
 1005dc4:	00c40bb3          	add	s7,s0,a2
 1005dc8:	1007f793          	andi	a5,a5,256
 1005dcc:	01f7e793          	ori	a5,a5,31
 1005dd0:	00f9a423          	sw	a5,8(s3)
 1005dd4:	8b3a                	mv	s6,a4
 1005dd6:	8556                	mv	a0,s5
 1005dd8:	c62e                	sw	a1,12(sp)
 1005dda:	469050ef          	jal	100ba42 <__thead_uread4>
 1005dde:	00d4c783          	lbu	a5,13(s1)
 1005de2:	45b2                	lw	a1,12(sp)
 1005de4:	8b85                	andi	a5,a5,1
 1005de6:	cbbd                	beqz	a5,1005e5c <HAL_LSCRC_CRC_CALC+0xdc>
 1005de8:	0a91                	addi	s5,s5,4
 1005dea:	00a9a823          	sw	a0,16(s3)
 1005dee:	415b87b3          	sub	a5,s7,s5
 1005df2:	fefb62e3          	bltu	s6,a5,1005dd6 <HAL_LSCRC_CRC_CALC+0x56>
 1005df6:	ffc90793          	addi	a5,s2,-4
 1005dfa:	9bf1                	andi	a5,a5,-4
 1005dfc:	0411                	addi	s0,s0,4
 1005dfe:	943e                	add	s0,s0,a5
 1005e00:	00397913          	andi	s2,s2,3
 1005e04:	40029737          	lui	a4,0x40029
 1005e08:	80070713          	addi	a4,a4,-2048 # 40028800 <bitmap+0x2fee8880>
 1005e0c:	531c                	lw	a5,32(a4)
 1005e0e:	00d4c603          	lbu	a2,13(s1)
 1005e12:	06090f63          	beqz	s2,1005e90 <HAL_LSCRC_CRC_CALC+0x110>
 1005e16:	44d4                	lw	a3,12(s1)
 1005e18:	00391793          	slli	a5,s2,0x3
 1005e1c:	17fd                	addi	a5,a5,-1
 1005e1e:	1006f693          	andi	a3,a3,256
 1005e22:	8fd5                	or	a5,a5,a3
 1005e24:	c71c                	sw	a5,8(a4)
 1005e26:	4789                	li	a5,2
 1005e28:	02f90d63          	beq	s2,a5,1005e62 <HAL_LSCRC_CRC_CALC+0xe2>
 1005e2c:	468d                	li	a3,3
 1005e2e:	00044783          	lbu	a5,0(s0)
 1005e32:	02d91363          	bne	s2,a3,1005e58 <HAL_LSCRC_CRC_CALC+0xd8>
 1005e36:	00244883          	lbu	a7,2(s0)
 1005e3a:	00144503          	lbu	a0,1(s0)
 1005e3e:	00167813          	andi	a6,a2,1
 1005e42:	01089693          	slli	a3,a7,0x10
 1005e46:	0522                	slli	a0,a0,0x8
 1005e48:	8ec9                	or	a3,a3,a0
 1005e4a:	8edd                	or	a3,a3,a5
 1005e4c:	07c2                	slli	a5,a5,0x10
 1005e4e:	8fc9                	or	a5,a5,a0
 1005e50:	0117e7b3          	or	a5,a5,a7
 1005e54:	4306978b          	th.mvnez	a5,a3,a6
 1005e58:	cb1c                	sw	a5,16(a4)
 1005e5a:	a035                	j	1005e86 <HAL_LSCRC_CRC_CALC+0x106>
 1005e5c:	8205150b          	th.rev	a0,a0
 1005e60:	b761                	j	1005de8 <HAL_LSCRC_CRC_CALC+0x68>
 1005e62:	00144783          	lbu	a5,1(s0)
 1005e66:	00044683          	lbu	a3,0(s0)
 1005e6a:	00167513          	andi	a0,a2,1
 1005e6e:	07a2                	slli	a5,a5,0x8
 1005e70:	8edd                	or	a3,a3,a5
 1005e72:	00869813          	slli	a6,a3,0x8
 1005e76:	83a1                	srli	a5,a5,0x8
 1005e78:	0107e7b3          	or	a5,a5,a6
 1005e7c:	3c07b78b          	th.extu	a5,a5,15,0
 1005e80:	40a7968b          	th.mveqz	a3,a5,a0
 1005e84:	cb14                	sw	a3,16(a4)
 1005e86:	400297b7          	lui	a5,0x40029
 1005e8a:	80078793          	addi	a5,a5,-2048 # 40028800 <bitmap+0x2fee8880>
 1005e8e:	539c                	lw	a5,32(a5)
 1005e90:	400297b7          	lui	a5,0x40029
 1005e94:	80078793          	addi	a5,a5,-2048 # 40028800 <bitmap+0x2fee8880>
 1005e98:	5388                	lw	a0,32(a5)
 1005e9a:	8a09                	andi	a2,a2,2
 1005e9c:	01455533          	srl	a0,a0,s4
 1005ea0:	c211                	beqz	a2,1005ea4 <HAL_LSCRC_CRC_CALC+0x124>
 1005ea2:	3d6d                	jal	1005d5c <HAL_LSCRC_Bit_Reverse>
 1005ea4:	449c                	lw	a5,8(s1)
 1005ea6:	0141                	addi	sp,sp,16
 1005ea8:	8d3d                	xor	a0,a0,a5
 1005eaa:	3790506f          	j	100ba22 <__riscv_restore_10>
 1005eae:	0000                	unimp

01005eb0 <CRC32_PARAM>:
 1005eb0:	1db7 04c1 ffff ffff ffff ffff 0320 0000     ............ ...

01005ec0 <get_uint32_t>:
 1005ec0:	353052ef          	jal	t0,100ba12 <__riscv_save_0>
 1005ec4:	842a                	mv	s0,a0
 1005ec6:	37d050ef          	jal	100ba42 <__thead_uread4>
 1005eca:	8205150b          	th.rev	a0,a0
 1005ece:	3690506f          	j	100ba36 <__riscv_restore_0>

01005ed2 <set_uint32_t>:
 1005ed2:	01855793          	srli	a5,a0,0x18
 1005ed6:	00f58023          	sb	a5,0(a1)
 1005eda:	01055793          	srli	a5,a0,0x10
 1005ede:	00f580a3          	sb	a5,1(a1)
 1005ee2:	00855793          	srli	a5,a0,0x8
 1005ee6:	00f58123          	sb	a5,2(a1)
 1005eea:	00a581a3          	sb	a0,3(a1)
 1005eee:	8082                	ret

01005ef0 <crypt_in_out_length_set>:
 1005ef0:	cea1a823          	sw	a0,-784(gp) # 101384f0 <current_in>
 1005ef4:	ceb1a623          	sw	a1,-788(gp) # 101384ec <current_out>
 1005ef8:	cec1a423          	sw	a2,-792(gp) # 101384e8 <length_in>
 1005efc:	cec1a223          	sw	a2,-796(gp) # 101384e4 <length_out>
 1005f00:	cec1a023          	sw	a2,-800(gp) # 101384e0 <length_residue>
 1005f04:	8082                	ret

01005f06 <gmult>:
 1005f06:	00052883          	lw	a7,0(a0)
 1005f0a:	00452803          	lw	a6,4(a0)
 1005f0e:	451c                	lw	a5,8(a0)
 1005f10:	4558                	lw	a4,12(a0)
 1005f12:	1141                	addi	sp,sp,-16
 1005f14:	c622                	sw	s0,12(sp)
 1005f16:	c426                	sw	s1,8(sp)
 1005f18:	c24a                	sw	s2,4(sp)
 1005f1a:	c04e                	sw	s3,0(sp)
 1005f1c:	01058413          	addi	s0,a1,16
 1005f20:	4e81                	li	t4,0
 1005f22:	4e01                	li	t3,0
 1005f24:	4f81                	li	t6,0
 1005f26:	4f01                	li	t5,0
 1005f28:	e10004b7          	lui	s1,0xe1000
 1005f2c:	04000913          	li	s2,64
 1005f30:	0005a383          	lw	t2,0(a1)
 1005f34:	41d0                	lw	a2,4(a1)
 1005f36:	4281                	li	t0,0
 1005f38:	41f65693          	srai	a3,a2,0x1f
 1005f3c:	0106f333          	and	t1,a3,a6
 1005f40:	0116f9b3          	and	s3,a3,a7
 1005f44:	006f4f33          	xor	t5,t5,t1
 1005f48:	00f6f333          	and	t1,a3,a5
 1005f4c:	8ef9                	and	a3,a3,a4
 1005f4e:	013fcfb3          	xor	t6,t6,s3
 1005f52:	006eceb3          	xor	t4,t4,t1
 1005f56:	01f71993          	slli	s3,a4,0x1f
 1005f5a:	01f89313          	slli	t1,a7,0x1f
 1005f5e:	00de4e33          	xor	t3,t3,a3
 1005f62:	8305                	srli	a4,a4,0x1
 1005f64:	0007a68b          	th.ext	a3,a5,0,0
 1005f68:	8ee5                	and	a3,a3,s1
 1005f6a:	00676733          	or	a4,a4,t1
 1005f6e:	01f81313          	slli	t1,a6,0x1f
 1005f72:	00185813          	srli	a6,a6,0x1
 1005f76:	8385                	srli	a5,a5,0x1
 1005f78:	0018d893          	srli	a7,a7,0x1
 1005f7c:	00d84833          	xor	a6,a6,a3
 1005f80:	0606                	slli	a2,a2,0x1
 1005f82:	01f3d693          	srli	a3,t2,0x1f
 1005f86:	0285                	addi	t0,t0,1
 1005f88:	00f9e7b3          	or	a5,s3,a5
 1005f8c:	011368b3          	or	a7,t1,a7
 1005f90:	8e55                	or	a2,a2,a3
 1005f92:	0386                	slli	t2,t2,0x1
 1005f94:	fb2292e3          	bne	t0,s2,1005f38 <gmult+0x32>
 1005f98:	05a1                	addi	a1,a1,8
 1005f9a:	f8b41be3          	bne	s0,a1,1005f30 <gmult+0x2a>
 1005f9e:	4432                	lw	s0,12(sp)
 1005fa0:	01f52023          	sw	t6,0(a0)
 1005fa4:	01e52223          	sw	t5,4(a0)
 1005fa8:	01d52423          	sw	t4,8(a0)
 1005fac:	01c52623          	sw	t3,12(a0)
 1005fb0:	44a2                	lw	s1,8(sp)
 1005fb2:	4912                	lw	s2,4(sp)
 1005fb4:	4982                	lw	s3,0(sp)
 1005fb6:	0141                	addi	sp,sp,16
 1005fb8:	8082                	ret

01005fba <inc_ctr>:
 1005fba:	15fd                	addi	a1,a1,-1
 1005fbc:	80b5478b          	th.lrbu	a5,a0,a1,0
 1005fc0:	0785                	addi	a5,a5,1
 1005fc2:	0ff7f793          	zext.b	a5,a5
 1005fc6:	00b5578b          	th.srb	a5,a0,a1,0
 1005fca:	dbe5                	beqz	a5,1005fba <inc_ctr>
 1005fcc:	8082                	ret

01005fce <block_data_in>:
 1005fce:	245052ef          	jal	t0,100ba12 <__riscv_save_0>
 1005fd2:	cf41c903          	lbu	s2,-780(gp) # 101384f4 <BLOCK_SIZE>
 1005fd6:	84aa                	mv	s1,a0
 1005fd8:	35e5                	jal	1005ec0 <get_uint32_t>
 1005fda:	4741                	li	a4,16
 1005fdc:	87aa                	mv	a5,a0
 1005fde:	40029437          	lui	s0,0x40029
 1005fe2:	00448513          	addi	a0,s1,4 # e1000004 <bitmap+0xd0ec0084>
 1005fe6:	00e91f63          	bne	s2,a4,1006004 <block_data_in+0x36>
 1005fea:	c45c                	sw	a5,12(s0)
 1005fec:	3dd1                	jal	1005ec0 <get_uint32_t>
 1005fee:	c408                	sw	a0,8(s0)
 1005ff0:	00848513          	addi	a0,s1,8
 1005ff4:	35f1                	jal	1005ec0 <get_uint32_t>
 1005ff6:	c048                	sw	a0,4(s0)
 1005ff8:	00c48513          	addi	a0,s1,12
 1005ffc:	35d1                	jal	1005ec0 <get_uint32_t>
 1005ffe:	c008                	sw	a0,0(s0)
 1006000:	2370506f          	j	100ba36 <__riscv_restore_0>
 1006004:	c05c                	sw	a5,4(s0)
 1006006:	bfdd                	j	1005ffc <block_data_in+0x2e>

01006008 <crypt_start>:
 1006008:	7179                	addi	sp,sp,-48
 100600a:	d422                	sw	s0,40(sp)
 100600c:	d226                	sw	s1,36(sp)
 100600e:	ce4e                	sw	s3,28(sp)
 1006010:	ca56                	sw	s5,20(sp)
 1006012:	d606                	sw	ra,44(sp)
 1006014:	d04a                	sw	s2,32(sp)
 1006016:	cc52                	sw	s4,24(sp)
 1006018:	c85a                	sw	s6,16(sp)
 100601a:	c65e                	sw	s7,12(sp)
 100601c:	c462                	sw	s8,8(sp)
 100601e:	c266                	sw	s9,4(sp)
 1006020:	c06a                	sw	s10,0(sp)
 1006022:	1800                	addi	s0,sp,48
 1006024:	cf41c603          	lbu	a2,-780(gp) # 101384f4 <BLOCK_SIZE>
 1006028:	ce01a983          	lw	s3,-800(gp) # 101384e0 <length_residue>
 100602c:	013637b3          	sltu	a5,a2,s3
 1006030:	42f6198b          	th.mvnez	s3,a2,a5
 1006034:	0ff9f493          	zext.b	s1,s3
 1006038:	14960e63          	beq	a2,s1,1006194 <crypt_start+0x18c>
 100603c:	00f60793          	addi	a5,a2,15
 1006040:	1f07f793          	andi	a5,a5,496
 1006044:	8d0a                	mv	s10,sp
 1006046:	40f10133          	sub	sp,sp,a5
 100604a:	cdc1a783          	lw	a5,-804(gp) # 101384dc <crypt_padding_mode>
 100604e:	470d                	li	a4,3
 1006050:	8a0a                	mv	s4,sp
 1006052:	0ee78263          	beq	a5,a4,1006136 <crypt_start+0x12e>
 1006056:	04f76163          	bltu	a4,a5,1006098 <crypt_start+0x90>
 100605a:	4705                	li	a4,1
 100605c:	06e78263          	beq	a5,a4,10060c0 <crypt_start+0xb8>
 1006060:	4709                	li	a4,2
 1006062:	08e78c63          	beq	a5,a4,10060fa <crypt_start+0xf2>
 1006066:	8552                	mv	a0,s4
 1006068:	379d                	jal	1005fce <block_data_in>
 100606a:	816a                	mv	sp,s10
 100606c:	40029737          	lui	a4,0x40029
 1006070:	4b3c                	lw	a5,80(a4)
 1006072:	0017e793          	ori	a5,a5,1
 1006076:	cb3c                	sw	a5,80(a4)
 1006078:	fd040113          	addi	sp,s0,-48 # 40028fd0 <bitmap+0x2fee9050>
 100607c:	50b2                	lw	ra,44(sp)
 100607e:	5422                	lw	s0,40(sp)
 1006080:	5492                	lw	s1,36(sp)
 1006082:	5902                	lw	s2,32(sp)
 1006084:	49f2                	lw	s3,28(sp)
 1006086:	4a62                	lw	s4,24(sp)
 1006088:	4ad2                	lw	s5,20(sp)
 100608a:	4b42                	lw	s6,16(sp)
 100608c:	4bb2                	lw	s7,12(sp)
 100608e:	4c22                	lw	s8,8(sp)
 1006090:	4c92                	lw	s9,4(sp)
 1006092:	4d02                	lw	s10,0(sp)
 1006094:	6145                	addi	sp,sp,48
 1006096:	8082                	ret
 1006098:	4711                	li	a4,4
 100609a:	fce796e3          	bne	a5,a4,1006066 <crypt_start+0x5e>
 100609e:	cf01ab83          	lw	s7,-784(gp) # 101384f0 <current_in>
 10060a2:	4901                	li	s2,0
 10060a4:	10000c93          	li	s9,256
 10060a8:	cf41c783          	lbu	a5,-780(gp) # 101384f4 <BLOCK_SIZE>
 10060ac:	faf95de3          	bge	s2,a5,1006066 <crypt_start+0x5e>
 10060b0:	0d395063          	bge	s2,s3,1006170 <crypt_start+0x168>
 10060b4:	812bc78b          	th.lrbu	a5,s7,s2,0
 10060b8:	012a578b          	th.srb	a5,s4,s2,0
 10060bc:	0905                	addi	s2,s2,1
 10060be:	b7ed                	j	10060a8 <crypt_start+0xa0>
 10060c0:	ce41a703          	lw	a4,-796(gp) # 101384e4 <length_out>
 10060c4:	409604b3          	sub	s1,a2,s1
 10060c8:	cf01a803          	lw	a6,-784(gp) # 101384f0 <current_in>
 10060cc:	4581                	li	a1,0
 10060ce:	4781                	li	a5,0
 10060d0:	0ff4f493          	zext.b	s1,s1
 10060d4:	00c7c763          	blt	a5,a2,10060e2 <crypt_start+0xda>
 10060d8:	f80587e3          	beqz	a1,1006066 <crypt_start+0x5e>
 10060dc:	cee1a223          	sw	a4,-796(gp) # 101384e4 <length_out>
 10060e0:	b759                	j	1006066 <crypt_start+0x5e>
 10060e2:	0137d863          	bge	a5,s3,10060f2 <crypt_start+0xea>
 10060e6:	80f8450b          	th.lrbu	a0,a6,a5,0
 10060ea:	00fa550b          	th.srb	a0,s4,a5,0
 10060ee:	0785                	addi	a5,a5,1
 10060f0:	b7d5                	j	10060d4 <crypt_start+0xcc>
 10060f2:	0705                	addi	a4,a4,1 # 40029001 <bitmap+0x2fee9081>
 10060f4:	8526                	mv	a0,s1
 10060f6:	4585                	li	a1,1
 10060f8:	bfcd                	j	10060ea <crypt_start+0xe2>
 10060fa:	ce41a703          	lw	a4,-796(gp) # 101384e4 <length_out>
 10060fe:	409604b3          	sub	s1,a2,s1
 1006102:	cf01a803          	lw	a6,-784(gp) # 101384f0 <current_in>
 1006106:	4581                	li	a1,0
 1006108:	4781                	li	a5,0
 100610a:	fff60893          	addi	a7,a2,-1
 100610e:	0ff4f493          	zext.b	s1,s1
 1006112:	fcc7d3e3          	bge	a5,a2,10060d8 <crypt_start+0xd0>
 1006116:	0137d863          	bge	a5,s3,1006126 <crypt_start+0x11e>
 100611a:	80f8450b          	th.lrbu	a0,a6,a5,0
 100611e:	00fa550b          	th.srb	a0,s4,a5,0
 1006122:	0785                	addi	a5,a5,1
 1006124:	b7fd                	j	1006112 <crypt_start+0x10a>
 1006126:	411785b3          	sub	a1,a5,a7
 100612a:	8526                	mv	a0,s1
 100612c:	42b0150b          	th.mvnez	a0,zero,a1
 1006130:	0705                	addi	a4,a4,1
 1006132:	4585                	li	a1,1
 1006134:	b7ed                	j	100611e <crypt_start+0x116>
 1006136:	ce41a683          	lw	a3,-796(gp) # 101384e4 <length_out>
 100613a:	cf01a803          	lw	a6,-784(gp) # 101384f0 <current_in>
 100613e:	4501                	li	a0,0
 1006140:	4781                	li	a5,0
 1006142:	00c7c763          	blt	a5,a2,1006150 <crypt_start+0x148>
 1006146:	f20500e3          	beqz	a0,1006066 <crypt_start+0x5e>
 100614a:	ced1a223          	sw	a3,-796(gp) # 101384e4 <length_out>
 100614e:	bf21                	j	1006066 <crypt_start+0x5e>
 1006150:	0137d863          	bge	a5,s3,1006160 <crypt_start+0x158>
 1006154:	80f8470b          	th.lrbu	a4,a6,a5,0
 1006158:	00fa570b          	th.srb	a4,s4,a5,0
 100615c:	0785                	addi	a5,a5,1
 100615e:	b7d5                	j	1006142 <crypt_start+0x13a>
 1006160:	40f98733          	sub	a4,s3,a5
 1006164:	00173713          	seqz	a4,a4
 1006168:	0685                	addi	a3,a3,1
 100616a:	071e                	slli	a4,a4,0x7
 100616c:	4505                	li	a0,1
 100616e:	b7ed                	j	1006158 <crypt_start+0x150>
 1006170:	ce41a703          	lw	a4,-796(gp) # 101384e4 <length_out>
 1006174:	0705                	addi	a4,a4,1
 1006176:	cee1a223          	sw	a4,-796(gp) # 101384e4 <length_out>
 100617a:	fff78713          	addi	a4,a5,-1
 100617e:	8f85                	sub	a5,a5,s1
 1006180:	00e90763          	beq	s2,a4,100618e <crypt_start+0x186>
 1006184:	cd81a783          	lw	a5,-808(gp) # 101384d8 <crypt_rand_func>
 1006188:	9782                	jalr	a5
 100618a:	039567b3          	rem	a5,a0,s9
 100618e:	0ff7f793          	zext.b	a5,a5
 1006192:	b71d                	j	10060b8 <crypt_start+0xb0>
 1006194:	cf01a503          	lw	a0,-784(gp) # 101384f0 <current_in>
 1006198:	3d1d                	jal	1005fce <block_data_in>
 100619a:	bdc9                	j	100606c <crypt_start+0x64>

0100619c <block_data_out>:
 100619c:	077052ef          	jal	t0,100ba12 <__riscv_save_0>
 10061a0:	cf41c703          	lbu	a4,-780(gp) # 101384f4 <BLOCK_SIZE>
 10061a4:	47c1                	li	a5,16
 10061a6:	842a                	mv	s0,a0
 10061a8:	00450913          	addi	s2,a0,4
 10061ac:	400294b7          	lui	s1,0x40029
 10061b0:	02f71263          	bne	a4,a5,10061d4 <block_data_out+0x38>
 10061b4:	44e8                	lw	a0,76(s1)
 10061b6:	85a2                	mv	a1,s0
 10061b8:	3b29                	jal	1005ed2 <set_uint32_t>
 10061ba:	44a8                	lw	a0,72(s1)
 10061bc:	85ca                	mv	a1,s2
 10061be:	3b11                	jal	1005ed2 <set_uint32_t>
 10061c0:	40e8                	lw	a0,68(s1)
 10061c2:	00840593          	addi	a1,s0,8
 10061c6:	3331                	jal	1005ed2 <set_uint32_t>
 10061c8:	40a8                	lw	a0,64(s1)
 10061ca:	00c40593          	addi	a1,s0,12
 10061ce:	3311                	jal	1005ed2 <set_uint32_t>
 10061d0:	0670506f          	j	100ba36 <__riscv_restore_0>
 10061d4:	40e8                	lw	a0,68(s1)
 10061d6:	85a2                	mv	a1,s0
 10061d8:	39ed                	jal	1005ed2 <set_uint32_t>
 10061da:	40a8                	lw	a0,64(s1)
 10061dc:	85ca                	mv	a1,s2
 10061de:	bfc5                	j	10061ce <block_data_out+0x32>

010061e0 <block_crypt>:
 10061e0:	033052ef          	jal	t0,100ba12 <__riscv_save_0>
 10061e4:	842e                	mv	s0,a1
 10061e6:	33e5                	jal	1005fce <block_data_in>
 10061e8:	400297b7          	lui	a5,0x40029
 10061ec:	4bb8                	lw	a4,80(a5)
 10061ee:	00176713          	ori	a4,a4,1
 10061f2:	cbb8                	sw	a4,80(a5)
 10061f4:	4bf8                	lw	a4,84(a5)
 10061f6:	8b05                	andi	a4,a4,1
 10061f8:	df75                	beqz	a4,10061f4 <block_crypt+0x14>
 10061fa:	4705                	li	a4,1
 10061fc:	cfb8                	sw	a4,88(a5)
 10061fe:	8522                	mv	a0,s0
 1006200:	3f71                	jal	100619c <block_data_out>
 1006202:	0350506f          	j	100ba36 <__riscv_restore_0>

01006206 <crypt_end>:
 1006206:	7179                	addi	sp,sp,-48
 1006208:	d422                	sw	s0,40(sp)
 100620a:	d04a                	sw	s2,32(sp)
 100620c:	ce4e                	sw	s3,28(sp)
 100620e:	cc52                	sw	s4,24(sp)
 1006210:	c65e                	sw	s7,12(sp)
 1006212:	d606                	sw	ra,44(sp)
 1006214:	d226                	sw	s1,36(sp)
 1006216:	ca56                	sw	s5,20(sp)
 1006218:	c85a                	sw	s6,16(sp)
 100621a:	c462                	sw	s8,8(sp)
 100621c:	1800                	addi	s0,sp,48
 100621e:	400297b7          	lui	a5,0x40029
 1006222:	4bbc                	lw	a5,80(a5)
 1006224:	8b89                	andi	a5,a5,2
 1006226:	cf41c483          	lbu	s1,-780(gp) # 101384f4 <BLOCK_SIZE>
 100622a:	ce01ab83          	lw	s7,-800(gp) # 101384e0 <length_residue>
 100622e:	cec1a903          	lw	s2,-788(gp) # 101384ec <current_out>
 1006232:	12079a63          	bnez	a5,1006366 <crypt_end+0x160>
 1006236:	13749863          	bne	s1,s7,1006366 <crypt_end+0x160>
 100623a:	cdc1ab03          	lw	s6,-804(gp) # 101384dc <crypt_padding_mode>
 100623e:	120b0463          	beqz	s6,1006366 <crypt_end+0x160>
 1006242:	00f48793          	addi	a5,s1,15 # 4002900f <bitmap+0x2fee908f>
 1006246:	1f07f793          	andi	a5,a5,496
 100624a:	8c0a                	mv	s8,sp
 100624c:	40f10133          	sub	sp,sp,a5
 1006250:	850a                	mv	a0,sp
 1006252:	37a9                	jal	100619c <block_data_out>
 1006254:	478d                	li	a5,3
 1006256:	8a8a                	mv	s5,sp
 1006258:	0afb0d63          	beq	s6,a5,1006312 <crypt_end+0x10c>
 100625c:	0367e663          	bltu	a5,s6,1006288 <crypt_end+0x82>
 1006260:	4785                	li	a5,1
 1006262:	08fb1163          	bne	s6,a5,10062e4 <crypt_end+0xde>
 1006266:	009107b3          	add	a5,sp,s1
 100626a:	fff7c783          	lbu	a5,-1(a5) # 40028fff <bitmap+0x2fee907f>
 100626e:	4701                	li	a4,0
 1006270:	40f48633          	sub	a2,s1,a5
 1006274:	00975e63          	bge	a4,s1,1006290 <crypt_end+0x8a>
 1006278:	80eac68b          	th.lrbu	a3,s5,a4,0
 100627c:	02c75163          	bge	a4,a2,100629e <crypt_end+0x98>
 1006280:	00e9568b          	th.srb	a3,s2,a4,0
 1006284:	0705                	addi	a4,a4,1
 1006286:	b7fd                	j	1006274 <crypt_end+0x6e>
 1006288:	4791                	li	a5,4
 100628a:	0afb0f63          	beq	s6,a5,1006348 <crypt_end+0x142>
 100628e:	4781                	li	a5,0
 1006290:	ce81a703          	lw	a4,-792(gp) # 101384e8 <length_in>
 1006294:	40f707b3          	sub	a5,a4,a5
 1006298:	cef1a223          	sw	a5,-796(gp) # 101384e4 <length_out>
 100629c:	a029                	j	10062a6 <crypt_end+0xa0>
 100629e:	fed783e3          	beq	a5,a3,1006284 <crypt_end+0x7e>
 10062a2:	ce01a223          	sw	zero,-796(gp) # 101384e4 <length_out>
 10062a6:	8162                	mv	sp,s8
 10062a8:	cf01a783          	lw	a5,-784(gp) # 101384f0 <current_in>
 10062ac:	9926                	add	s2,s2,s1
 10062ae:	cf21a623          	sw	s2,-788(gp) # 101384ec <current_out>
 10062b2:	97a6                	add	a5,a5,s1
 10062b4:	cef1a823          	sw	a5,-784(gp) # 101384f0 <current_in>
 10062b8:	409b87b3          	sub	a5,s7,s1
 10062bc:	009bb4b3          	sltu	s1,s7,s1
 10062c0:	4290178b          	th.mvnez	a5,zero,s1
 10062c4:	cef1a023          	sw	a5,-800(gp) # 101384e0 <length_residue>
 10062c8:	fd040113          	addi	sp,s0,-48
 10062cc:	50b2                	lw	ra,44(sp)
 10062ce:	5422                	lw	s0,40(sp)
 10062d0:	5492                	lw	s1,36(sp)
 10062d2:	5902                	lw	s2,32(sp)
 10062d4:	49f2                	lw	s3,28(sp)
 10062d6:	4a62                	lw	s4,24(sp)
 10062d8:	4ad2                	lw	s5,20(sp)
 10062da:	4b42                	lw	s6,16(sp)
 10062dc:	4bb2                	lw	s7,12(sp)
 10062de:	4c22                	lw	s8,8(sp)
 10062e0:	6145                	addi	sp,sp,48
 10062e2:	8082                	ret
 10062e4:	fff48693          	addi	a3,s1,-1
 10062e8:	80d1478b          	th.lrbu	a5,sp,a3,0
 10062ec:	4701                	li	a4,0
 10062ee:	40f48633          	sub	a2,s1,a5
 10062f2:	f8975fe3          	bge	a4,s1,1006290 <crypt_end+0x8a>
 10062f6:	00c75863          	bge	a4,a2,1006306 <crypt_end+0x100>
 10062fa:	80eac58b          	th.lrbu	a1,s5,a4,0
 10062fe:	00e9558b          	th.srb	a1,s2,a4,0
 1006302:	0705                	addi	a4,a4,1
 1006304:	b7fd                	j	10062f2 <crypt_end+0xec>
 1006306:	fed75ee3          	bge	a4,a3,1006302 <crypt_end+0xfc>
 100630a:	80eac58b          	th.lrbu	a1,s5,a4,0
 100630e:	d9f5                	beqz	a1,1006302 <crypt_end+0xfc>
 1006310:	bf49                	j	10062a2 <crypt_end+0x9c>
 1006312:	fff48713          	addi	a4,s1,-1
 1006316:	87ba                	mv	a5,a4
 1006318:	80eac68b          	th.lrbu	a3,s5,a4,0
 100631c:	e689                	bnez	a3,1006326 <crypt_end+0x120>
 100631e:	f80702e3          	beqz	a4,10062a2 <crypt_end+0x9c>
 1006322:	177d                	addi	a4,a4,-1
 1006324:	bfd5                	j	1006318 <crypt_end+0x112>
 1006326:	08000613          	li	a2,128
 100632a:	f6c69ce3          	bne	a3,a2,10062a2 <crypt_end+0x9c>
 100632e:	8f99                	sub	a5,a5,a4
 1006330:	0785                	addi	a5,a5,1
 1006332:	0ff7f793          	zext.b	a5,a5
 1006336:	4681                	li	a3,0
 1006338:	f4e6dce3          	bge	a3,a4,1006290 <crypt_end+0x8a>
 100633c:	80dac60b          	th.lrbu	a2,s5,a3,0
 1006340:	00d9560b          	th.srb	a2,s2,a3,0
 1006344:	0685                	addi	a3,a3,1
 1006346:	bfcd                	j	1006338 <crypt_end+0x132>
 1006348:	009107b3          	add	a5,sp,s1
 100634c:	fff7c783          	lbu	a5,-1(a5)
 1006350:	4701                	li	a4,0
 1006352:	40f486b3          	sub	a3,s1,a5
 1006356:	f2d75de3          	bge	a4,a3,1006290 <crypt_end+0x8a>
 100635a:	80eac60b          	th.lrbu	a2,s5,a4,0
 100635e:	00e9560b          	th.srb	a2,s2,a4,0
 1006362:	0705                	addi	a4,a4,1
 1006364:	bfcd                	j	1006356 <crypt_end+0x150>
 1006366:	854a                	mv	a0,s2
 1006368:	3d15                	jal	100619c <block_data_out>
 100636a:	bf3d                	j	10062a8 <crypt_end+0xa2>

0100636c <length_check.part.0>:
 100636c:	cdc1a783          	lw	a5,-804(gp) # 101384dc <crypt_padding_mode>
 1006370:	cb99                	beqz	a5,1006386 <length_check.part.0+0x1a>
 1006372:	cf41c703          	lbu	a4,-780(gp) # 101384f4 <BLOCK_SIZE>
 1006376:	00a707b3          	add	a5,a4,a0
 100637a:	02e57533          	remu	a0,a0,a4
 100637e:	8f89                	sub	a5,a5,a0
 1006380:	00f5fc63          	bgeu	a1,a5,1006398 <length_check.part.0+0x2c>
 1006384:	a001                	j	1006384 <length_check.part.0+0x18>
 1006386:	00a5f363          	bgeu	a1,a0,100638c <length_check.part.0+0x20>
 100638a:	a001                	j	100638a <length_check.part.0+0x1e>
 100638c:	cf41c783          	lbu	a5,-780(gp) # 101384f4 <BLOCK_SIZE>
 1006390:	02f57533          	remu	a0,a0,a5
 1006394:	c111                	beqz	a0,1006398 <length_check.part.0+0x2c>
 1006396:	a001                	j	1006396 <length_check.part.0+0x2a>
 1006398:	8082                	ret

0100639a <aes_enc_dec>:
 100639a:	650052ef          	jal	t0,100b9ea <__riscv_save_10>
 100639e:	0506                	slli	a0,a0,0x1
 10063a0:	00459793          	slli	a5,a1,0x4
 10063a4:	7fffb4b7          	lui	s1,0x7fffb
 10063a8:	00f56433          	or	s0,a0,a5
 10063ac:	40029c37          	lui	s8,0x40029
 10063b0:	f0d48493          	addi	s1,s1,-243 # 7fffaf0d <bitmap+0x6febaf8d>
 10063b4:	4bc1                	li	s7,16
 10063b6:	4a05                	li	s4,1
 10063b8:	050c2783          	lw	a5,80(s8) # 40029050 <bitmap+0x2fee90d0>
 10063bc:	059a                	slli	a1,a1,0x6
 10063be:	8dc1                	or	a1,a1,s0
 10063c0:	8fe5                	and	a5,a5,s1
 10063c2:	8ddd                	or	a1,a1,a5
 10063c4:	04bc2823          	sw	a1,80(s8)
 10063c8:	cf718a23          	sb	s7,-780(gp) # 101384f4 <BLOCK_SIZE>
 10063cc:	3935                	jal	1006008 <crypt_start>
 10063ce:	054c2783          	lw	a5,84(s8)
 10063d2:	8b85                	andi	a5,a5,1
 10063d4:	dfed                	beqz	a5,10063ce <aes_enc_dec+0x34>
 10063d6:	054c2c23          	sw	s4,88(s8)
 10063da:	3535                	jal	1006206 <crypt_end>
 10063dc:	ce01a783          	lw	a5,-800(gp) # 101384e0 <length_residue>
 10063e0:	cdc1a703          	lw	a4,-804(gp) # 101384dc <crypt_padding_mode>
 10063e4:	8fd9                	or	a5,a5,a4
 10063e6:	cb81                	beqz	a5,10063f6 <aes_enc_dec+0x5c>
 10063e8:	ce41a703          	lw	a4,-796(gp) # 101384e4 <length_out>
 10063ec:	ce81a783          	lw	a5,-792(gp) # 101384e8 <length_in>
 10063f0:	4581                	li	a1,0
 10063f2:	fcf703e3          	beq	a4,a5,10063b8 <aes_enc_dec+0x1e>
 10063f6:	62c0506f          	j	100ba22 <__riscv_restore_10>

010063fa <HAL_LSCRYPT_Init>:
 10063fa:	618052ef          	jal	t0,100ba12 <__riscv_save_0>
 10063fe:	f85f90ef          	jal	1000382 <HAL_LSCRYPT_MSP_Init>
 1006402:	fc5f90ef          	jal	10003c6 <HAL_LSCRYPT_MSP_Busy_Set>
 1006406:	4501                	li	a0,0
 1006408:	62e0506f          	j	100ba36 <__riscv_restore_0>

0100640c <HAL_LSCRYPT_Block_Padding_Mode_Set>:
 100640c:	cca1ae23          	sw	a0,-804(gp) # 101384dc <crypt_padding_mode>
 1006410:	4501                	li	a0,0
 1006412:	8082                	ret

01006414 <HAL_LSCRYPT_AES_Key_Config>:
 1006414:	400297b7          	lui	a5,0x40029
 1006418:	4bb4                	lw	a3,80(a5)
 100641a:	00259713          	slli	a4,a1,0x2
 100641e:	8b31                	andi	a4,a4,12
 1006420:	9acd                	andi	a3,a3,-13
 1006422:	8f55                	or	a4,a4,a3
 1006424:	cbb8                	sw	a4,80(a5)
 1006426:	4118                	lw	a4,0(a0)
 1006428:	cb98                	sw	a4,16(a5)
 100642a:	4158                	lw	a4,4(a0)
 100642c:	cbd8                	sw	a4,20(a5)
 100642e:	4518                	lw	a4,8(a0)
 1006430:	cf98                	sw	a4,24(a5)
 1006432:	4558                	lw	a4,12(a0)
 1006434:	cfd8                	sw	a4,28(a5)
 1006436:	cd81                	beqz	a1,100644e <HAL_LSCRYPT_AES_Key_Config+0x3a>
 1006438:	4918                	lw	a4,16(a0)
 100643a:	d398                	sw	a4,32(a5)
 100643c:	4958                	lw	a4,20(a0)
 100643e:	d3d8                	sw	a4,36(a5)
 1006440:	4705                	li	a4,1
 1006442:	00e58663          	beq	a1,a4,100644e <HAL_LSCRYPT_AES_Key_Config+0x3a>
 1006446:	4d18                	lw	a4,24(a0)
 1006448:	d798                	sw	a4,40(a5)
 100644a:	4d58                	lw	a4,28(a0)
 100644c:	d7d8                	sw	a4,44(a5)
 100644e:	4501                	li	a0,0
 1006450:	8082                	ret

01006452 <HAL_LSCRYPT_AES_ECB_Encrypt>:
 1006452:	5a6052ef          	jal	t0,100b9f8 <__riscv_save_4>
 1006456:	84ae                	mv	s1,a1
 1006458:	428c                	lw	a1,0(a3)
 100645a:	4741                	li	a4,16
 100645c:	892a                	mv	s2,a0
 100645e:	8526                	mv	a0,s1
 1006460:	8436                	mv	s0,a3
 1006462:	cee18a23          	sb	a4,-780(gp) # 101384f4 <BLOCK_SIZE>
 1006466:	89b2                	mv	s3,a2
 1006468:	3711                	jal	100636c <length_check.part.0>
 100646a:	8626                	mv	a2,s1
 100646c:	85ce                	mv	a1,s3
 100646e:	854a                	mv	a0,s2
 1006470:	3441                	jal	1005ef0 <crypt_in_out_length_set>
 1006472:	4581                	li	a1,0
 1006474:	4505                	li	a0,1
 1006476:	3715                	jal	100639a <aes_enc_dec>
 1006478:	ce41a783          	lw	a5,-796(gp) # 101384e4 <length_out>
 100647c:	4501                	li	a0,0
 100647e:	c01c                	sw	a5,0(s0)
 1006480:	5ac0506f          	j	100ba2c <__riscv_restore_4>

01006484 <HAL_LSCRYPT_AES_CTR_Crypt>:
 1006484:	574052ef          	jal	t0,100b9f8 <__riscv_save_4>
 1006488:	1101                	addi	sp,sp,-32
 100648a:	842a                	mv	s0,a0
 100648c:	852e                	mv	a0,a1
 100648e:	85b6                	mv	a1,a3
 1006490:	3485                	jal	1005ef0 <crypt_in_out_length_set>
 1006492:	4941                	li	s2,16
 1006494:	cf218a23          	sb	s2,-780(gp) # 101384f4 <BLOCK_SIZE>
 1006498:	400294b7          	lui	s1,0x40029
 100649c:	48bc                	lw	a5,80(s1)
 100649e:	7fffb737          	lui	a4,0x7fffb
 10064a2:	f0d70713          	addi	a4,a4,-243 # 7fffaf0d <bitmap+0x6febaf8d>
 10064a6:	8ff9                	and	a5,a5,a4
 10064a8:	0027e793          	ori	a5,a5,2
 10064ac:	c8bc                	sw	a5,80(s1)
 10064ae:	01210ab3          	add	s5,sp,s2
 10064b2:	4b05                	li	s6,1
 10064b4:	898a                	mv	s3,sp
 10064b6:	8522                	mv	a0,s0
 10064b8:	000aa023          	sw	zero,0(s5)
 10064bc:	000aa223          	sw	zero,4(s5)
 10064c0:	000aa423          	sw	zero,8(s5)
 10064c4:	000aa623          	sw	zero,12(s5)
 10064c8:	3619                	jal	1005fce <block_data_in>
 10064ca:	48bc                	lw	a5,80(s1)
 10064cc:	0017e793          	ori	a5,a5,1
 10064d0:	c8bc                	sw	a5,80(s1)
 10064d2:	48fc                	lw	a5,84(s1)
 10064d4:	8b85                	andi	a5,a5,1
 10064d6:	dff5                	beqz	a5,10064d2 <HAL_LSCRYPT_AES_CTR_Crypt+0x4e>
 10064d8:	854e                	mv	a0,s3
 10064da:	0564ac23          	sw	s6,88(s1) # 40029058 <bitmap+0x2fee90d8>
 10064de:	397d                	jal	100619c <block_data_out>
 10064e0:	ce01a703          	lw	a4,-800(gp) # 101384e0 <length_residue>
 10064e4:	cf01a603          	lw	a2,-784(gp) # 101384f0 <current_in>
 10064e8:	cec1a683          	lw	a3,-788(gp) # 101384ec <current_out>
 10064ec:	01173793          	sltiu	a5,a4,17
 10064f0:	88ca                	mv	a7,s2
 10064f2:	42f7188b          	th.mvnez	a7,a4,a5
 10064f6:	4581                	li	a1,0
 10064f8:	4781                	li	a5,0
 10064fa:	06f89863          	bne	a7,a5,100656a <HAL_LSCRYPT_AES_CTR_Crypt+0xe6>
 10064fe:	00058863          	beqz	a1,100650e <HAL_LSCRYPT_AES_CTR_Crypt+0x8a>
 1006502:	963e                	add	a2,a2,a5
 1006504:	96be                	add	a3,a3,a5
 1006506:	cec1a823          	sw	a2,-784(gp) # 101384f0 <current_in>
 100650a:	ced1a623          	sw	a3,-788(gp) # 101384ec <current_out>
 100650e:	8f1d                	sub	a4,a4,a5
 1006510:	00f44783          	lbu	a5,15(s0)
 1006514:	cee1a023          	sw	a4,-800(gp) # 101384e0 <length_residue>
 1006518:	0785                	addi	a5,a5,1 # 40029001 <bitmap+0x2fee9081>
 100651a:	0ff7f793          	zext.b	a5,a5
 100651e:	00f407a3          	sb	a5,15(s0)
 1006522:	e399                	bnez	a5,1006528 <HAL_LSCRYPT_AES_CTR_Crypt+0xa4>
 1006524:	01610f23          	sb	s6,30(sp)
 1006528:	8656                	mv	a2,s5
 100652a:	00f40693          	addi	a3,s0,15
 100652e:	00f64783          	lbu	a5,15(a2)
 1006532:	cb99                	beqz	a5,1006548 <HAL_LSCRYPT_AES_CTR_Crypt+0xc4>
 1006534:	0006c783          	lbu	a5,0(a3)
 1006538:	0785                	addi	a5,a5,1
 100653a:	0ff7f793          	zext.b	a5,a5
 100653e:	00f68023          	sb	a5,0(a3)
 1006542:	e399                	bnez	a5,1006548 <HAL_LSCRYPT_AES_CTR_Crypt+0xc4>
 1006544:	01660723          	sb	s6,14(a2)
 1006548:	16fd                	addi	a3,a3,-1
 100654a:	167d                	addi	a2,a2,-1
 100654c:	fed411e3          	bne	s0,a3,100652e <HAL_LSCRYPT_AES_CTR_Crypt+0xaa>
 1006550:	01014783          	lbu	a5,16(sp)
 1006554:	c791                	beqz	a5,1006560 <HAL_LSCRYPT_AES_CTR_Crypt+0xdc>
 1006556:	00044783          	lbu	a5,0(s0)
 100655a:	0785                	addi	a5,a5,1
 100655c:	00f40023          	sb	a5,0(s0)
 1006560:	fb39                	bnez	a4,10064b6 <HAL_LSCRYPT_AES_CTR_Crypt+0x32>
 1006562:	4501                	li	a0,0
 1006564:	6105                	addi	sp,sp,32
 1006566:	4c60506f          	j	100ba2c <__riscv_restore_4>
 100656a:	80f6430b          	th.lrbu	t1,a2,a5,0
 100656e:	80f9c58b          	th.lrbu	a1,s3,a5,0
 1006572:	0065c5b3          	xor	a1,a1,t1
 1006576:	00f6d58b          	th.srb	a1,a3,a5,0
 100657a:	0785                	addi	a5,a5,1
 100657c:	4585                	li	a1,1
 100657e:	bfb5                	j	10064fa <HAL_LSCRYPT_AES_CTR_Crypt+0x76>

01006580 <HAL_LSCRYPT_AES_GCM_Decrypt>:
 1006580:	462052ef          	jal	t0,100b9e2 <__riscv_save_12>
 1006584:	7171                	addi	sp,sp,-176
 1006586:	c63a                	sw	a4,12(sp)
 1006588:	c83e                	sw	a5,16(sp)
 100658a:	832e                	mv	t1,a1
 100658c:	55ce                	lw	a1,240(sp)
 100658e:	3c060e63          	beqz	a2,100696a <HAL_LSCRYPT_AES_GCM_Decrypt+0x3ea>
 1006592:	892a                	mv	s2,a0
 1006594:	4505                	li	a0,1
 1006596:	2a070763          	beqz	a4,1006844 <HAL_LSCRYPT_AES_GCM_Decrypt+0x2c4>
 100659a:	47c2                	lw	a5,16(sp)
 100659c:	4711                	li	a4,4
 100659e:	17d1                	addi	a5,a5,-12
 10065a0:	2af76263          	bltu	a4,a5,1006844 <HAL_LSCRYPT_AES_GCM_Decrypt+0x2c4>
 10065a4:	8bb2                	mv	s7,a2
 10065a6:	8436                	mv	s0,a3
 10065a8:	89c2                	mv	s3,a6
 10065aa:	84c6                	mv	s1,a7
 10065ac:	00081463          	bnez	a6,10065b4 <HAL_LSCRYPT_AES_GCM_Decrypt+0x34>
 10065b0:	28089a63          	bnez	a7,1006844 <HAL_LSCRYPT_AES_GCM_Decrypt+0x2c4>
 10065b4:	4505                	li	a0,1
 10065b6:	28040763          	beqz	s0,1006844 <HAL_LSCRYPT_AES_GCM_Decrypt+0x2c4>
 10065ba:	00030663          	beqz	t1,10065c6 <HAL_LSCRYPT_AES_GCM_Decrypt+0x46>
 10065be:	28090363          	beqz	s2,1006844 <HAL_LSCRYPT_AES_GCM_Decrypt+0x2c4>
 10065c2:	28058163          	beqz	a1,1006844 <HAL_LSCRYPT_AES_GCM_Decrypt+0x2c4>
 10065c6:	4b41                	li	s6,16
 10065c8:	400296b7          	lui	a3,0x40029
 10065cc:	cf618a23          	sb	s6,-780(gp) # 101384f4 <BLOCK_SIZE>
 10065d0:	4abc                	lw	a5,80(a3)
 10065d2:	7fffb737          	lui	a4,0x7fffb
 10065d6:	f0d70713          	addi	a4,a4,-243 # 7fffaf0d <bitmap+0x6febaf8d>
 10065da:	8ff9                	and	a5,a5,a4
 10065dc:	0027e793          	ori	a5,a5,2
 10065e0:	cabc                	sw	a5,80(a3)
 10065e2:	861a                	mv	a2,t1
 10065e4:	854a                	mv	a0,s2
 10065e6:	3229                	jal	1005ef0 <crypt_in_out_length_set>
 10065e8:	ce81aa03          	lw	s4,-792(gp) # 101384e8 <length_in>
 10065ec:	09010a93          	addi	s5,sp,144
 10065f0:	85de                	mv	a1,s7
 10065f2:	00fa7793          	andi	a5,s4,15
 10065f6:	8622                	mv	a2,s0
 10065f8:	8556                	mv	a0,s5
 10065fa:	c23e                	sw	a5,4(sp)
 10065fc:	d082                	sw	zero,96(sp)
 10065fe:	d282                	sw	zero,100(sp)
 1006600:	d482                	sw	zero,104(sp)
 1006602:	d682                	sw	zero,108(sp)
 1006604:	d882                	sw	zero,112(sp)
 1006606:	da82                	sw	zero,116(sp)
 1006608:	dc82                	sw	zero,120(sp)
 100660a:	de82                	sw	zero,124(sp)
 100660c:	c102                	sw	zero,128(sp)
 100660e:	c302                	sw	zero,132(sp)
 1006610:	c502                	sw	zero,136(sp)
 1006612:	c702                	sw	zero,140(sp)
 1006614:	c902                	sw	zero,144(sp)
 1006616:	cb02                	sw	zero,148(sp)
 1006618:	cd02                	sw	zero,152(sp)
 100661a:	cf02                	sw	zero,156(sp)
 100661c:	d102                	sw	zero,160(sp)
 100661e:	d302                	sw	zero,164(sp)
 1006620:	d502                	sw	zero,168(sp)
 1006622:	d702                	sw	zero,172(sp)
 1006624:	408b0b33          	sub	s6,s6,s0
 1006628:	4ec050ef          	jal	100bb14 <memcpy>
 100662c:	865a                	mv	a2,s6
 100662e:	4581                	li	a1,0
 1006630:	0968                	addi	a0,sp,156
 1006632:	4fa050ef          	jal	100bb2c <memset>
 1006636:	4785                	li	a5,1
 1006638:	08f10fa3          	sb	a5,159(sp)
 100663c:	004a5793          	srli	a5,s4,0x4
 1006640:	c43e                	sw	a5,8(sp)
 1006642:	4c01                	li	s8,0
 1006644:	008a8bb3          	add	s7,s5,s0
 1006648:	47a2                	lw	a5,8(sp)
 100664a:	20fc1063          	bne	s8,a5,100684a <HAL_LSCRYPT_AES_GCM_Decrypt+0x2ca>
 100664e:	4792                	lw	a5,4(sp)
 1006650:	cf9d                	beqz	a5,100668e <HAL_LSCRYPT_AES_GCM_Decrypt+0x10e>
 1006652:	008a8533          	add	a0,s5,s0
 1006656:	85da                	mv	a1,s6
 1006658:	328d                	jal	1005fba <inc_ctr>
 100665a:	1100                	addi	s0,sp,160
 100665c:	85a2                	mv	a1,s0
 100665e:	8556                	mv	a0,s5
 1006660:	3641                	jal	10061e0 <block_crypt>
 1006662:	cf01a583          	lw	a1,-784(gp) # 101384f0 <current_in>
 1006666:	cec1a683          	lw	a3,-788(gp) # 101384ec <current_out>
 100666a:	4781                	li	a5,0
 100666c:	80f5c60b          	th.lrbu	a2,a1,a5,0
 1006670:	80f4470b          	th.lrbu	a4,s0,a5,0
 1006674:	8f31                	xor	a4,a4,a2
 1006676:	00f6d70b          	th.srb	a4,a3,a5,0
 100667a:	4712                	lw	a4,4(sp)
 100667c:	0785                	addi	a5,a5,1
 100667e:	fef717e3          	bne	a4,a5,100666c <HAL_LSCRYPT_AES_GCM_Decrypt+0xec>
 1006682:	ce41a783          	lw	a5,-796(gp) # 101384e4 <length_out>
 1006686:	4692                	lw	a3,4(sp)
 1006688:	97b6                	add	a5,a5,a3
 100668a:	cef1a223          	sw	a5,-796(gp) # 101384e4 <length_out>
 100668e:	108c                	addi	a1,sp,96
 1006690:	852e                	mv	a0,a1
 1006692:	36b9                	jal	10061e0 <block_crypt>
 1006694:	1800                	addi	s0,sp,48
 1006696:	010007b7          	lui	a5,0x1000
 100669a:	8556                	mv	a0,s5
 100669c:	188c                	addi	a1,sp,112
 100669e:	d47c                	sw	a5,108(s0)
 10066a0:	3681                	jal	10061e0 <block_crypt>
 10066a2:	03042b83          	lw	s7,48(s0)
 10066a6:	03442c03          	lw	s8,52(s0)
 10066aa:	03842a83          	lw	s5,56(s0)
 10066ae:	03c42b03          	lw	s6,60(s0)
 10066b2:	820b9b8b          	th.rev	s7,s7
 10066b6:	820c1c0b          	th.rev	s8,s8
 10066ba:	820a9a8b          	th.rev	s5,s5
 10066be:	820b1b0b          	th.rev	s6,s6
 10066c2:	24048063          	beqz	s1,1006902 <HAL_LSCRYPT_AES_GCM_Decrypt+0x382>
 10066c6:	22098e63          	beqz	s3,1006902 <HAL_LSCRYPT_AES_GCM_Decrypt+0x382>
 10066ca:	ff04fe13          	andi	t3,s1,-16
 10066ce:	9e4e                	add	t3,t3,s3
 10066d0:	884e                	mv	a6,s3
 10066d2:	00f4f313          	andi	t1,s1,15
 10066d6:	4d01                	li	s10,0
 10066d8:	4981                	li	s3,0
 10066da:	4c81                	li	s9,0
 10066dc:	4d81                	li	s11,0
 10066de:	1dc81163          	bne	a6,t3,10068a0 <HAL_LSCRYPT_AES_GCM_Decrypt+0x320>
 10066e2:	06030363          	beqz	t1,1006748 <HAL_LSCRYPT_AES_GCM_Decrypt+0x1c8>
 10066e6:	0088                	addi	a0,sp,64
 10066e8:	861a                	mv	a2,t1
 10066ea:	85c2                	mv	a1,a6
 10066ec:	00052023          	sw	zero,0(a0)
 10066f0:	00052223          	sw	zero,4(a0)
 10066f4:	00052423          	sw	zero,8(a0)
 10066f8:	00052623          	sw	zero,12(a0)
 10066fc:	418050ef          	jal	100bb14 <memcpy>
 1006700:	4836                	lw	a6,76(sp)
 1006702:	4886                	lw	a7,64(sp)
 1006704:	4616                	lw	a2,68(sp)
 1006706:	4526                	lw	a0,72(sp)
 1006708:	8208180b          	th.rev	a6,a6
 100670c:	010d47b3          	xor	a5,s10,a6
 1006710:	8208988b          	th.rev	a7,a7
 1006714:	8206160b          	th.rev	a2,a2
 1006718:	8205150b          	th.rev	a0,a0
 100671c:	019646b3          	xor	a3,a2,s9
 1006720:	01b8c733          	xor	a4,a7,s11
 1006724:	d43e                	sw	a5,40(sp)
 1006726:	85a2                	mv	a1,s0
 1006728:	00a9c7b3          	xor	a5,s3,a0
 100672c:	1008                	addi	a0,sp,32
 100672e:	d036                	sw	a3,32(sp)
 1006730:	d23a                	sw	a4,36(sp)
 1006732:	d63e                	sw	a5,44(sp)
 1006734:	d862                	sw	s8,48(sp)
 1006736:	da5e                	sw	s7,52(sp)
 1006738:	dc5a                	sw	s6,56(sp)
 100673a:	de56                	sw	s5,60(sp)
 100673c:	fcaff0ef          	jal	1005f06 <gmult>
 1006740:	5c82                	lw	s9,32(sp)
 1006742:	5d92                	lw	s11,36(sp)
 1006744:	5d22                	lw	s10,40(sp)
 1006746:	59b2                	lw	s3,44(sp)
 1006748:	060a0e63          	beqz	s4,10067c4 <HAL_LSCRYPT_AES_GCM_Decrypt+0x244>
 100674c:	06090c63          	beqz	s2,10067c4 <HAL_LSCRYPT_AES_GCM_Decrypt+0x244>
 1006750:	47a2                	lw	a5,8(sp)
 1006752:	88ca                	mv	a7,s2
 1006754:	00479813          	slli	a6,a5,0x4
 1006758:	984a                	add	a6,a6,s2
 100675a:	1b181963          	bne	a6,a7,100690c <HAL_LSCRYPT_AES_GCM_Decrypt+0x38c>
 100675e:	4792                	lw	a5,4(sp)
 1006760:	c3b5                	beqz	a5,10067c4 <HAL_LSCRYPT_AES_GCM_Decrypt+0x244>
 1006762:	0888                	addi	a0,sp,80
 1006764:	863e                	mv	a2,a5
 1006766:	85c2                	mv	a1,a6
 1006768:	00052023          	sw	zero,0(a0)
 100676c:	00052223          	sw	zero,4(a0)
 1006770:	00052423          	sw	zero,8(a0)
 1006774:	00052623          	sw	zero,12(a0)
 1006778:	39c050ef          	jal	100bb14 <memcpy>
 100677c:	4576                	lw	a0,92(sp)
 100677e:	4846                	lw	a6,80(sp)
 1006780:	48d6                	lw	a7,84(sp)
 1006782:	45e6                	lw	a1,88(sp)
 1006784:	8205150b          	th.rev	a0,a0
 1006788:	00ad47b3          	xor	a5,s10,a0
 100678c:	8208180b          	th.rev	a6,a6
 1006790:	8208988b          	th.rev	a7,a7
 1006794:	8205958b          	th.rev	a1,a1
 1006798:	011cc6b3          	xor	a3,s9,a7
 100679c:	010dc733          	xor	a4,s11,a6
 10067a0:	d43e                	sw	a5,40(sp)
 10067a2:	1008                	addi	a0,sp,32
 10067a4:	00b9c7b3          	xor	a5,s3,a1
 10067a8:	85a2                	mv	a1,s0
 10067aa:	d036                	sw	a3,32(sp)
 10067ac:	d23a                	sw	a4,36(sp)
 10067ae:	d63e                	sw	a5,44(sp)
 10067b0:	d862                	sw	s8,48(sp)
 10067b2:	da5e                	sw	s7,52(sp)
 10067b4:	dc5a                	sw	s6,56(sp)
 10067b6:	de56                	sw	s5,60(sp)
 10067b8:	f4eff0ef          	jal	1005f06 <gmult>
 10067bc:	5c82                	lw	s9,32(sp)
 10067be:	5d92                	lw	s11,36(sp)
 10067c0:	5d22                	lw	s10,40(sp)
 10067c2:	59b2                	lw	s3,44(sp)
 10067c4:	01d4d613          	srli	a2,s1,0x1d
 10067c8:	01b64733          	xor	a4,a2,s11
 10067cc:	d23a                	sw	a4,36(sp)
 10067ce:	048e                	slli	s1,s1,0x3
 10067d0:	01da5713          	srli	a4,s4,0x1d
 10067d4:	0a0e                	slli	s4,s4,0x3
 10067d6:	013747b3          	xor	a5,a4,s3
 10067da:	1008                	addi	a0,sp,32
 10067dc:	0194c4b3          	xor	s1,s1,s9
 10067e0:	01aa4a33          	xor	s4,s4,s10
 10067e4:	85a2                	mv	a1,s0
 10067e6:	d63e                	sw	a5,44(sp)
 10067e8:	d026                	sw	s1,32(sp)
 10067ea:	d452                	sw	s4,40(sp)
 10067ec:	d862                	sw	s8,48(sp)
 10067ee:	da5e                	sw	s7,52(sp)
 10067f0:	dc5a                	sw	s6,56(sp)
 10067f2:	de56                	sw	s5,60(sp)
 10067f4:	f12ff0ef          	jal	1005f06 <gmult>
 10067f8:	5682                	lw	a3,32(sp)
 10067fa:	5612                	lw	a2,36(sp)
 10067fc:	57a2                	lw	a5,40(sp)
 10067fe:	5732                	lw	a4,44(sp)
 1006800:	8206968b          	th.rev	a3,a3
 1006804:	8207978b          	th.rev	a5,a5
 1006808:	8206160b          	th.rev	a2,a2
 100680c:	8207170b          	th.rev	a4,a4
 1006810:	c874                	sw	a3,84(s0)
 1006812:	cc7c                	sw	a5,92(s0)
 1006814:	fb010913          	addi	s2,sp,-80
 1006818:	c830                	sw	a2,80(s0)
 100681a:	cc38                	sw	a4,88(s0)
 100681c:	4781                	li	a5,0
 100681e:	0108                	addi	a0,sp,128
 1006820:	46c1                	li	a3,16
 1006822:	1890                	addi	a2,sp,112
 1006824:	80a7c70b          	th.lrbu	a4,a5,a0,0
 1006828:	80f6460b          	th.lrbu	a2,a2,a5,0
 100682c:	8f31                	xor	a4,a4,a2
 100682e:	00a7d70b          	th.srb	a4,a5,a0,0
 1006832:	0785                	addi	a5,a5,1 # 1000001 <Reset_Handler+0x1>
 1006834:	fed797e3          	bne	a5,a3,1006822 <HAL_LSCRYPT_AES_GCM_Decrypt+0x2a2>
 1006838:	4642                	lw	a2,16(sp)
 100683a:	45b2                	lw	a1,12(sp)
 100683c:	2b2050ef          	jal	100baee <memcmp>
 1006840:	00153513          	seqz	a0,a0
 1006844:	614d                	addi	sp,sp,176
 1006846:	1d80506f          	j	100ba1e <__riscv_restore_12>
 100684a:	85da                	mv	a1,s6
 100684c:	855e                	mv	a0,s7
 100684e:	f6cff0ef          	jal	1005fba <inc_ctr>
 1006852:	110c                	addi	a1,sp,160
 1006854:	8556                	mv	a0,s5
 1006856:	3269                	jal	10061e0 <block_crypt>
 1006858:	cf01a783          	lw	a5,-784(gp) # 101384f0 <current_in>
 100685c:	1814                	addi	a3,sp,48
 100685e:	5aa8                	lw	a0,112(a3)
 1006860:	438c                	lw	a1,0(a5)
 1006862:	0047a303          	lw	t1,4(a5)
 1006866:	cec1a703          	lw	a4,-788(gp) # 101384ec <current_out>
 100686a:	8d2d                	xor	a0,a0,a1
 100686c:	5aec                	lw	a1,116(a3)
 100686e:	c308                	sw	a0,0(a4)
 1006870:	0c05                	addi	s8,s8,1
 1006872:	0065c5b3          	xor	a1,a1,t1
 1006876:	c34c                	sw	a1,4(a4)
 1006878:	4788                	lw	a0,8(a5)
 100687a:	5eac                	lw	a1,120(a3)
 100687c:	5ef4                	lw	a3,124(a3)
 100687e:	8da9                	xor	a1,a1,a0
 1006880:	47c8                	lw	a0,12(a5)
 1006882:	07c1                	addi	a5,a5,16
 1006884:	cef1a823          	sw	a5,-784(gp) # 101384f0 <current_in>
 1006888:	ce41a783          	lw	a5,-796(gp) # 101384e4 <length_out>
 100688c:	8ea9                	xor	a3,a3,a0
 100688e:	c70c                	sw	a1,8(a4)
 1006890:	c754                	sw	a3,12(a4)
 1006892:	07c1                	addi	a5,a5,16
 1006894:	0741                	addi	a4,a4,16
 1006896:	cee1a623          	sw	a4,-788(gp) # 101384ec <current_out>
 100689a:	cef1a223          	sw	a5,-796(gp) # 101384e4 <length_out>
 100689e:	b36d                	j	1006648 <HAL_LSCRYPT_AES_GCM_Decrypt+0xc8>
 10068a0:	85c2                	mv	a1,a6
 10068a2:	4641                	li	a2,16
 10068a4:	0088                	addi	a0,sp,64
 10068a6:	ce72                	sw	t3,28(sp)
 10068a8:	cc1a                	sw	t1,24(sp)
 10068aa:	ca42                	sw	a6,20(sp)
 10068ac:	268050ef          	jal	100bb14 <memcpy>
 10068b0:	4526                	lw	a0,72(sp)
 10068b2:	4e86                	lw	t4,64(sp)
 10068b4:	4616                	lw	a2,68(sp)
 10068b6:	48b6                	lw	a7,76(sp)
 10068b8:	8205150b          	th.rev	a0,a0
 10068bc:	00a9c533          	xor	a0,s3,a0
 10068c0:	8206160b          	th.rev	a2,a2
 10068c4:	8208988b          	th.rev	a7,a7
 10068c8:	820e9e8b          	th.rev	t4,t4
 10068cc:	019646b3          	xor	a3,a2,s9
 10068d0:	01beceb3          	xor	t4,t4,s11
 10068d4:	011d47b3          	xor	a5,s10,a7
 10068d8:	d62a                	sw	a0,44(sp)
 10068da:	85a2                	mv	a1,s0
 10068dc:	1008                	addi	a0,sp,32
 10068de:	d036                	sw	a3,32(sp)
 10068e0:	d276                	sw	t4,36(sp)
 10068e2:	d43e                	sw	a5,40(sp)
 10068e4:	d862                	sw	s8,48(sp)
 10068e6:	da5e                	sw	s7,52(sp)
 10068e8:	dc5a                	sw	s6,56(sp)
 10068ea:	de56                	sw	s5,60(sp)
 10068ec:	e1aff0ef          	jal	1005f06 <gmult>
 10068f0:	4852                	lw	a6,20(sp)
 10068f2:	5c82                	lw	s9,32(sp)
 10068f4:	5d92                	lw	s11,36(sp)
 10068f6:	5d22                	lw	s10,40(sp)
 10068f8:	59b2                	lw	s3,44(sp)
 10068fa:	4e72                	lw	t3,28(sp)
 10068fc:	4362                	lw	t1,24(sp)
 10068fe:	0841                	addi	a6,a6,16
 1006900:	bbf9                	j	10066de <HAL_LSCRYPT_AES_GCM_Decrypt+0x15e>
 1006902:	4d01                	li	s10,0
 1006904:	4981                	li	s3,0
 1006906:	4c81                	li	s9,0
 1006908:	4d81                	li	s11,0
 100690a:	bd3d                	j	1006748 <HAL_LSCRYPT_AES_GCM_Decrypt+0x1c8>
 100690c:	85c6                	mv	a1,a7
 100690e:	4641                	li	a2,16
 1006910:	0888                	addi	a0,sp,80
 1006912:	ca42                	sw	a6,20(sp)
 1006914:	c446                	sw	a7,8(sp)
 1006916:	1fe050ef          	jal	100bb14 <memcpy>
 100691a:	4576                	lw	a0,92(sp)
 100691c:	4346                	lw	t1,80(sp)
 100691e:	4e56                	lw	t3,84(sp)
 1006920:	45e6                	lw	a1,88(sp)
 1006922:	8205150b          	th.rev	a0,a0
 1006926:	00ad47b3          	xor	a5,s10,a0
 100692a:	8203130b          	th.rev	t1,t1
 100692e:	820e1e0b          	th.rev	t3,t3
 1006932:	8205958b          	th.rev	a1,a1
 1006936:	01ccc6b3          	xor	a3,s9,t3
 100693a:	006dc733          	xor	a4,s11,t1
 100693e:	d43e                	sw	a5,40(sp)
 1006940:	1008                	addi	a0,sp,32
 1006942:	00b9c7b3          	xor	a5,s3,a1
 1006946:	85a2                	mv	a1,s0
 1006948:	d036                	sw	a3,32(sp)
 100694a:	d23a                	sw	a4,36(sp)
 100694c:	d63e                	sw	a5,44(sp)
 100694e:	d862                	sw	s8,48(sp)
 1006950:	da5e                	sw	s7,52(sp)
 1006952:	dc5a                	sw	s6,56(sp)
 1006954:	de56                	sw	s5,60(sp)
 1006956:	db0ff0ef          	jal	1005f06 <gmult>
 100695a:	48a2                	lw	a7,8(sp)
 100695c:	5c82                	lw	s9,32(sp)
 100695e:	5d92                	lw	s11,36(sp)
 1006960:	5d22                	lw	s10,40(sp)
 1006962:	59b2                	lw	s3,44(sp)
 1006964:	4852                	lw	a6,20(sp)
 1006966:	08c1                	addi	a7,a7,16
 1006968:	bbcd                	j	100675a <HAL_LSCRYPT_AES_GCM_Decrypt+0x1da>
 100696a:	4505                	li	a0,1
 100696c:	bde1                	j	1006844 <HAL_LSCRYPT_AES_GCM_Decrypt+0x2c4>

0100696e <HAL_LSCRYPT_AES_GCM_Decrypt_Init>:
 100696e:	08a052ef          	jal	t0,100b9f8 <__riscv_save_4>
 1006972:	4941                	li	s2,16
 1006974:	400296b7          	lui	a3,0x40029
 1006978:	cf218a23          	sb	s2,-780(gp) # 101384f4 <BLOCK_SIZE>
 100697c:	4abc                	lw	a5,80(a3)
 100697e:	7fffb737          	lui	a4,0x7fffb
 1006982:	f0d70713          	addi	a4,a4,-243 # 7fffaf0d <bitmap+0x6febaf8d>
 1006986:	8ff9                	and	a5,a5,a4
 1006988:	0027e793          	ori	a5,a5,2
 100698c:	cabc                	sw	a5,80(a3)
 100698e:	84b2                	mv	s1,a2
 1006990:	89ae                	mv	s3,a1
 1006992:	07000613          	li	a2,112
 1006996:	4581                	li	a1,0
 1006998:	842a                	mv	s0,a0
 100699a:	192050ef          	jal	100bb2c <memset>
 100699e:	8626                	mv	a2,s1
 10069a0:	d024                	sw	s1,96(s0)
 10069a2:	85ce                	mv	a1,s3
 10069a4:	8522                	mv	a0,s0
 10069a6:	16e050ef          	jal	100bb14 <memcpy>
 10069aa:	40990633          	sub	a2,s2,s1
 10069ae:	4581                	li	a1,0
 10069b0:	00c40513          	addi	a0,s0,12
 10069b4:	178050ef          	jal	100bb2c <memset>
 10069b8:	4785                	li	a5,1
 10069ba:	012404b3          	add	s1,s0,s2
 10069be:	00f407a3          	sb	a5,15(s0)
 10069c2:	85a6                	mv	a1,s1
 10069c4:	8526                	mv	a0,s1
 10069c6:	81bff0ef          	jal	10061e0 <block_crypt>
 10069ca:	03040593          	addi	a1,s0,48
 10069ce:	8522                	mv	a0,s0
 10069d0:	811ff0ef          	jal	10061e0 <block_crypt>
 10069d4:	864a                	mv	a2,s2
 10069d6:	85a6                	mv	a1,s1
 10069d8:	04040513          	addi	a0,s0,64
 10069dc:	138050ef          	jal	100bb14 <memcpy>
 10069e0:	403c                	lw	a5,64(s0)
 10069e2:	4078                	lw	a4,68(s0)
 10069e4:	8207978b          	th.rev	a5,a5
 10069e8:	8207170b          	th.rev	a4,a4
 10069ec:	c038                	sw	a4,64(s0)
 10069ee:	c07c                	sw	a5,68(s0)
 10069f0:	4478                	lw	a4,76(s0)
 10069f2:	443c                	lw	a5,72(s0)
 10069f4:	8207170b          	th.rev	a4,a4
 10069f8:	8207978b          	th.rev	a5,a5
 10069fc:	c438                	sw	a4,72(s0)
 10069fe:	c47c                	sw	a5,76(s0)
 1006a00:	02c0506f          	j	100ba2c <__riscv_restore_4>

01006a04 <HAL_LSCRYPT_AES_GCM_Decrypt_Update>:
 1006a04:	7df042ef          	jal	t0,100b9e2 <__riscv_save_12>
 1006a08:	84be                	mv	s1,a5
 1006a0a:	517c                	lw	a5,100(a0)
 1006a0c:	7179                	addi	sp,sp,-48
 1006a0e:	ff06fd13          	andi	s10,a3,-16
 1006a12:	97b6                	add	a5,a5,a3
 1006a14:	d17c                	sw	a5,100(a0)
 1006a16:	553c                	lw	a5,104(a0)
 1006a18:	89b2                	mv	s3,a2
 1006a1a:	01a60c33          	add	s8,a2,s10
 1006a1e:	97a6                	add	a5,a5,s1
 1006a20:	8a32                	mv	s4,a2
 1006a22:	842a                	mv	s0,a0
 1006a24:	8b2e                	mv	s6,a1
 1006a26:	8ab6                	mv	s5,a3
 1006a28:	893a                	mv	s2,a4
 1006a2a:	00f6fb93          	andi	s7,a3,15
 1006a2e:	d53c                	sw	a5,104(a0)
 1006a30:	8cae                	mv	s9,a1
 1006a32:	4641                	li	a2,16
 1006a34:	0b4c1963          	bne	s8,s4,1006ae6 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0xe2>
 1006a38:	100b8263          	beqz	s7,1006b3c <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x138>
 1006a3c:	5028                	lw	a0,96(s0)
 1006a3e:	45c1                	li	a1,16
 1006a40:	02010c93          	addi	s9,sp,32
 1006a44:	8d89                	sub	a1,a1,a0
 1006a46:	9522                	add	a0,a0,s0
 1006a48:	d72ff0ef          	jal	1005fba <inc_ctr>
 1006a4c:	85e6                	mv	a1,s9
 1006a4e:	8522                	mv	a0,s0
 1006a50:	f90ff0ef          	jal	10061e0 <block_crypt>
 1006a54:	9b6a                	add	s6,s6,s10
 1006a56:	4781                	li	a5,0
 1006a58:	80fc470b          	th.lrbu	a4,s8,a5,0
 1006a5c:	80fcc68b          	th.lrbu	a3,s9,a5,0
 1006a60:	8f35                	xor	a4,a4,a3
 1006a62:	00fb570b          	th.srb	a4,s6,a5,0
 1006a66:	0785                	addi	a5,a5,1
 1006a68:	fefb98e3          	bne	s7,a5,1006a58 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x54>
 1006a6c:	ce41a783          	lw	a5,-796(gp) # 101384e4 <length_out>
 1006a70:	97de                	add	a5,a5,s7
 1006a72:	cef1a223          	sw	a5,-796(gp) # 101384e4 <length_out>
 1006a76:	16049263          	bnez	s1,1006bda <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x1d6>
 1006a7a:	0c098663          	beqz	s3,1006b46 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x142>
 1006a7e:	04040493          	addi	s1,s0,64
 1006a82:	05040913          	addi	s2,s0,80
 1006a86:	113a1663          	bne	s4,s3,1006b92 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x18e>
 1006a8a:	0a0b8e63          	beqz	s7,1006b46 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x142>
 1006a8e:	0808                	addi	a0,sp,16
 1006a90:	865e                	mv	a2,s7
 1006a92:	85e2                	mv	a1,s8
 1006a94:	00052023          	sw	zero,0(a0)
 1006a98:	00052223          	sw	zero,4(a0)
 1006a9c:	00052423          	sw	zero,8(a0)
 1006aa0:	00052623          	sw	zero,12(a0)
 1006aa4:	070050ef          	jal	100bb14 <memcpy>
 1006aa8:	4752                	lw	a4,20(sp)
 1006aaa:	4830                	lw	a2,80(s0)
 1006aac:	45c2                	lw	a1,16(sp)
 1006aae:	8207170b          	th.rev	a4,a4
 1006ab2:	8e39                	xor	a2,a2,a4
 1006ab4:	4878                	lw	a4,84(s0)
 1006ab6:	8205958b          	th.rev	a1,a1
 1006aba:	47f2                	lw	a5,28(sp)
 1006abc:	8f2d                	xor	a4,a4,a1
 1006abe:	c878                	sw	a4,84(s0)
 1006ac0:	4c38                	lw	a4,88(s0)
 1006ac2:	46e2                	lw	a3,24(sp)
 1006ac4:	8207978b          	th.rev	a5,a5
 1006ac8:	8f3d                	xor	a4,a4,a5
 1006aca:	4c7c                	lw	a5,92(s0)
 1006acc:	8206968b          	th.rev	a3,a3
 1006ad0:	c830                	sw	a2,80(s0)
 1006ad2:	8fb5                	xor	a5,a5,a3
 1006ad4:	cc38                	sw	a4,88(s0)
 1006ad6:	cc7c                	sw	a5,92(s0)
 1006ad8:	04040593          	addi	a1,s0,64
 1006adc:	05040513          	addi	a0,s0,80
 1006ae0:	c26ff0ef          	jal	1005f06 <gmult>
 1006ae4:	a08d                	j	1006b46 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x142>
 1006ae6:	5028                	lw	a0,96(s0)
 1006ae8:	0cc1                	addi	s9,s9,16
 1006aea:	0a41                	addi	s4,s4,16
 1006aec:	40a605b3          	sub	a1,a2,a0
 1006af0:	9522                	add	a0,a0,s0
 1006af2:	cc8ff0ef          	jal	1005fba <inc_ctr>
 1006af6:	100c                	addi	a1,sp,32
 1006af8:	8522                	mv	a0,s0
 1006afa:	ee6ff0ef          	jal	10061e0 <block_crypt>
 1006afe:	ff0a2703          	lw	a4,-16(s4)
 1006b02:	5682                	lw	a3,32(sp)
 1006b04:	ff4a2583          	lw	a1,-12(s4)
 1006b08:	57b2                	lw	a5,44(sp)
 1006b0a:	8eb9                	xor	a3,a3,a4
 1006b0c:	5712                	lw	a4,36(sp)
 1006b0e:	fedca823          	sw	a3,-16(s9)
 1006b12:	4641                	li	a2,16
 1006b14:	8f2d                	xor	a4,a4,a1
 1006b16:	feecaa23          	sw	a4,-12(s9)
 1006b1a:	ff8a2683          	lw	a3,-8(s4)
 1006b1e:	5722                	lw	a4,40(sp)
 1006b20:	8f35                	xor	a4,a4,a3
 1006b22:	ffca2683          	lw	a3,-4(s4)
 1006b26:	feecac23          	sw	a4,-8(s9)
 1006b2a:	8fb5                	xor	a5,a5,a3
 1006b2c:	fefcae23          	sw	a5,-4(s9)
 1006b30:	ce41a783          	lw	a5,-796(gp) # 101384e4 <length_out>
 1006b34:	07c1                	addi	a5,a5,16
 1006b36:	cef1a223          	sw	a5,-796(gp) # 101384e4 <length_out>
 1006b3a:	bded                	j	1006a34 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x30>
 1006b3c:	c099                	beqz	s1,1006b42 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x13e>
 1006b3e:	0a091063          	bnez	s2,1006bde <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x1da>
 1006b42:	f20a9ce3          	bnez	s5,1006a7a <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x76>
 1006b46:	6145                	addi	sp,sp,48
 1006b48:	6d70406f          	j	100ba1e <__riscv_restore_12>
 1006b4c:	85ca                	mv	a1,s2
 1006b4e:	4641                	li	a2,16
 1006b50:	850a                	mv	a0,sp
 1006b52:	7c3040ef          	jal	100bb14 <memcpy>
 1006b56:	4712                	lw	a4,4(sp)
 1006b58:	4830                	lw	a2,80(s0)
 1006b5a:	4582                	lw	a1,0(sp)
 1006b5c:	8207170b          	th.rev	a4,a4
 1006b60:	8e39                	xor	a2,a2,a4
 1006b62:	4878                	lw	a4,84(s0)
 1006b64:	8205958b          	th.rev	a1,a1
 1006b68:	47b2                	lw	a5,12(sp)
 1006b6a:	8f2d                	xor	a4,a4,a1
 1006b6c:	c878                	sw	a4,84(s0)
 1006b6e:	4c38                	lw	a4,88(s0)
 1006b70:	46a2                	lw	a3,8(sp)
 1006b72:	8207978b          	th.rev	a5,a5
 1006b76:	8f3d                	xor	a4,a4,a5
 1006b78:	4c7c                	lw	a5,92(s0)
 1006b7a:	8206968b          	th.rev	a3,a3
 1006b7e:	c830                	sw	a2,80(s0)
 1006b80:	8fb5                	xor	a5,a5,a3
 1006b82:	cc38                	sw	a4,88(s0)
 1006b84:	cc7c                	sw	a5,92(s0)
 1006b86:	85da                	mv	a1,s6
 1006b88:	8566                	mv	a0,s9
 1006b8a:	b7cff0ef          	jal	1005f06 <gmult>
 1006b8e:	0941                	addi	s2,s2,16
 1006b90:	a8b9                	j	1006bee <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x1ea>
 1006b92:	4641                	li	a2,16
 1006b94:	85ce                	mv	a1,s3
 1006b96:	00c10533          	add	a0,sp,a2
 1006b9a:	77b040ef          	jal	100bb14 <memcpy>
 1006b9e:	4752                	lw	a4,20(sp)
 1006ba0:	4830                	lw	a2,80(s0)
 1006ba2:	45c2                	lw	a1,16(sp)
 1006ba4:	8207170b          	th.rev	a4,a4
 1006ba8:	8e39                	xor	a2,a2,a4
 1006baa:	4878                	lw	a4,84(s0)
 1006bac:	8205958b          	th.rev	a1,a1
 1006bb0:	47f2                	lw	a5,28(sp)
 1006bb2:	8f2d                	xor	a4,a4,a1
 1006bb4:	c878                	sw	a4,84(s0)
 1006bb6:	4c38                	lw	a4,88(s0)
 1006bb8:	46e2                	lw	a3,24(sp)
 1006bba:	8207978b          	th.rev	a5,a5
 1006bbe:	8f3d                	xor	a4,a4,a5
 1006bc0:	4c7c                	lw	a5,92(s0)
 1006bc2:	8206968b          	th.rev	a3,a3
 1006bc6:	c830                	sw	a2,80(s0)
 1006bc8:	8fb5                	xor	a5,a5,a3
 1006bca:	cc38                	sw	a4,88(s0)
 1006bcc:	cc7c                	sw	a5,92(s0)
 1006bce:	85a6                	mv	a1,s1
 1006bd0:	854a                	mv	a0,s2
 1006bd2:	b34ff0ef          	jal	1005f06 <gmult>
 1006bd6:	09c1                	addi	s3,s3,16
 1006bd8:	b57d                	j	1006a86 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x82>
 1006bda:	ea0900e3          	beqz	s2,1006a7a <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x76>
 1006bde:	00f4fd13          	andi	s10,s1,15
 1006be2:	98c1                	andi	s1,s1,-16
 1006be4:	94ca                	add	s1,s1,s2
 1006be6:	04040b13          	addi	s6,s0,64
 1006bea:	05040c93          	addi	s9,s0,80
 1006bee:	f5249fe3          	bne	s1,s2,1006b4c <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x148>
 1006bf2:	f40d08e3          	beqz	s10,1006b42 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x13e>
 1006bf6:	866a                	mv	a2,s10
 1006bf8:	85a6                	mv	a1,s1
 1006bfa:	850a                	mv	a0,sp
 1006bfc:	c002                	sw	zero,0(sp)
 1006bfe:	c202                	sw	zero,4(sp)
 1006c00:	c402                	sw	zero,8(sp)
 1006c02:	c602                	sw	zero,12(sp)
 1006c04:	711040ef          	jal	100bb14 <memcpy>
 1006c08:	4712                	lw	a4,4(sp)
 1006c0a:	4830                	lw	a2,80(s0)
 1006c0c:	4582                	lw	a1,0(sp)
 1006c0e:	8207170b          	th.rev	a4,a4
 1006c12:	8e39                	xor	a2,a2,a4
 1006c14:	4878                	lw	a4,84(s0)
 1006c16:	8205958b          	th.rev	a1,a1
 1006c1a:	47b2                	lw	a5,12(sp)
 1006c1c:	8f2d                	xor	a4,a4,a1
 1006c1e:	c878                	sw	a4,84(s0)
 1006c20:	4c38                	lw	a4,88(s0)
 1006c22:	46a2                	lw	a3,8(sp)
 1006c24:	8207978b          	th.rev	a5,a5
 1006c28:	8f3d                	xor	a4,a4,a5
 1006c2a:	4c7c                	lw	a5,92(s0)
 1006c2c:	8206968b          	th.rev	a3,a3
 1006c30:	c830                	sw	a2,80(s0)
 1006c32:	8fb5                	xor	a5,a5,a3
 1006c34:	cc38                	sw	a4,88(s0)
 1006c36:	cc7c                	sw	a5,92(s0)
 1006c38:	04040593          	addi	a1,s0,64
 1006c3c:	05040513          	addi	a0,s0,80
 1006c40:	ac6ff0ef          	jal	1005f06 <gmult>
 1006c44:	bdfd                	j	1006b42 <HAL_LSCRYPT_AES_GCM_Decrypt_Update+0x13e>

01006c46 <HAL_LSCRYPT_AES_GCM_Decrypt_Final>:
 1006c46:	5b3042ef          	jal	t0,100b9f8 <__riscv_save_4>
 1006c4a:	5538                	lw	a4,104(a0)
 1006c4c:	4934                	lw	a3,80(a0)
 1006c4e:	84ae                	mv	s1,a1
 1006c50:	01d75593          	srli	a1,a4,0x1d
 1006c54:	070e                	slli	a4,a4,0x3
 1006c56:	8eb9                	xor	a3,a3,a4
 1006c58:	4978                	lw	a4,84(a0)
 1006c5a:	517c                	lw	a5,100(a0)
 1006c5c:	8932                	mv	s2,a2
 1006c5e:	8f2d                	xor	a4,a4,a1
 1006c60:	c978                	sw	a4,84(a0)
 1006c62:	4d38                	lw	a4,88(a0)
 1006c64:	01d7d613          	srli	a2,a5,0x1d
 1006c68:	078e                	slli	a5,a5,0x3
 1006c6a:	8f3d                	xor	a4,a4,a5
 1006c6c:	4d7c                	lw	a5,92(a0)
 1006c6e:	05050993          	addi	s3,a0,80
 1006c72:	842a                	mv	s0,a0
 1006c74:	8fb1                	xor	a5,a5,a2
 1006c76:	c934                	sw	a3,80(a0)
 1006c78:	cd38                	sw	a4,88(a0)
 1006c7a:	cd7c                	sw	a5,92(a0)
 1006c7c:	04050593          	addi	a1,a0,64
 1006c80:	854e                	mv	a0,s3
 1006c82:	a84ff0ef          	jal	1005f06 <gmult>
 1006c86:	4878                	lw	a4,84(s0)
 1006c88:	483c                	lw	a5,80(s0)
 1006c8a:	4641                	li	a2,16
 1006c8c:	8207170b          	th.rev	a4,a4
 1006c90:	c838                	sw	a4,80(s0)
 1006c92:	8207978b          	th.rev	a5,a5
 1006c96:	4c78                	lw	a4,92(s0)
 1006c98:	c87c                	sw	a5,84(s0)
 1006c9a:	4c3c                	lw	a5,88(s0)
 1006c9c:	8207170b          	th.rev	a4,a4
 1006ca0:	cc38                	sw	a4,88(s0)
 1006ca2:	8207978b          	th.rev	a5,a5
 1006ca6:	02040713          	addi	a4,s0,32
 1006caa:	cc7c                	sw	a5,92(s0)
 1006cac:	853a                	mv	a0,a4
 1006cae:	85ce                	mv	a1,s3
 1006cb0:	665040ef          	jal	100bb14 <memcpy>
 1006cb4:	872a                	mv	a4,a0
 1006cb6:	03040413          	addi	s0,s0,48
 1006cba:	87aa                	mv	a5,a0
 1006cbc:	9817c68b          	th.lbuia	a3,(a5),1,0
 1006cc0:	00f7c603          	lbu	a2,15(a5)
 1006cc4:	8eb1                	xor	a3,a3,a2
 1006cc6:	fed78fa3          	sb	a3,-1(a5)
 1006cca:	fe8799e3          	bne	a5,s0,1006cbc <HAL_LSCRYPT_AES_GCM_Decrypt_Final+0x76>
 1006cce:	864a                	mv	a2,s2
 1006cd0:	85a6                	mv	a1,s1
 1006cd2:	853a                	mv	a0,a4
 1006cd4:	61b040ef          	jal	100baee <memcmp>
 1006cd8:	00153513          	seqz	a0,a0
 1006cdc:	5510406f          	j	100ba2c <__riscv_restore_4>

01006ce0 <HAL_LSCRYPT_DES_Complete_Callback>:
 1006ce0:	8082                	ret

01006ce2 <HAL_LSCRYPT_AES_Complete_Callback>:
 1006ce2:	8082                	ret

01006ce4 <HAL_LSCRYPT_IRQHandler>:
 1006ce4:	52f042ef          	jal	t0,100ba12 <__riscv_save_0>
 1006ce8:	40029437          	lui	s0,0x40029
 1006cec:	487c                	lw	a5,84(s0)
 1006cee:	8b85                	andi	a5,a5,1
 1006cf0:	cf9d                	beqz	a5,1006d2e <HAL_LSCRYPT_IRQHandler+0x4a>
 1006cf2:	4785                	li	a5,1
 1006cf4:	cc3c                	sw	a5,88(s0)
 1006cf6:	d10ff0ef          	jal	1006206 <crypt_end>
 1006cfa:	ce41a603          	lw	a2,-796(gp) # 101384e4 <length_out>
 1006cfe:	ce81a783          	lw	a5,-792(gp) # 101384e8 <length_in>
 1006d02:	00f61863          	bne	a2,a5,1006d12 <HAL_LSCRYPT_IRQHandler+0x2e>
 1006d06:	ce01a783          	lw	a5,-800(gp) # 101384e0 <length_residue>
 1006d0a:	cdc1a703          	lw	a4,-804(gp) # 101384dc <crypt_padding_mode>
 1006d0e:	8fd9                	or	a5,a5,a4
 1006d10:	eb99                	bnez	a5,1006d26 <HAL_LSCRYPT_IRQHandler+0x42>
 1006d12:	4828                	lw	a0,80(s0)
 1006d14:	482c                	lw	a1,80(s0)
 1006d16:	0415350b          	th.extu	a0,a0,1,1
 1006d1a:	0305f593          	andi	a1,a1,48
 1006d1e:	00b035b3          	snez	a1,a1
 1006d22:	37c1                	jal	1006ce2 <HAL_LSCRYPT_AES_Complete_Callback>
 1006d24:	a019                	j	1006d2a <HAL_LSCRYPT_IRQHandler+0x46>
 1006d26:	ae2ff0ef          	jal	1006008 <crypt_start>
 1006d2a:	50d0406f          	j	100ba36 <__riscv_restore_0>
 1006d2e:	487c                	lw	a5,84(s0)
 1006d30:	8b89                	andi	a5,a5,2
 1006d32:	dfe5                	beqz	a5,1006d2a <HAL_LSCRYPT_IRQHandler+0x46>
 1006d34:	4789                	li	a5,2
 1006d36:	cc3c                	sw	a5,88(s0)
 1006d38:	cceff0ef          	jal	1006206 <crypt_end>
 1006d3c:	ce41a603          	lw	a2,-796(gp) # 101384e4 <length_out>
 1006d40:	ce81a783          	lw	a5,-792(gp) # 101384e8 <length_in>
 1006d44:	00f61863          	bne	a2,a5,1006d54 <HAL_LSCRYPT_IRQHandler+0x70>
 1006d48:	ce01a783          	lw	a5,-800(gp) # 101384e0 <length_residue>
 1006d4c:	cdc1a703          	lw	a4,-804(gp) # 101384dc <crypt_padding_mode>
 1006d50:	8fd9                	or	a5,a5,a4
 1006d52:	fbf1                	bnez	a5,1006d26 <HAL_LSCRYPT_IRQHandler+0x42>
 1006d54:	4828                	lw	a0,80(s0)
 1006d56:	482c                	lw	a1,80(s0)
 1006d58:	0415350b          	th.extu	a0,a0,1,1
 1006d5c:	0305f593          	andi	a1,a1,48
 1006d60:	00b035b3          	snez	a1,a1
 1006d64:	3fb5                	jal	1006ce0 <HAL_LSCRYPT_DES_Complete_Callback>
 1006d66:	b7d1                	j	1006d2a <HAL_LSCRYPT_IRQHandler+0x46>

01006d68 <lsqspiv2_init>:
 1006d68:	4ab042ef          	jal	t0,100ba12 <__riscv_save_0>
 1006d6c:	c78f90ef          	jal	10001e4 <lsqspiv2_msp_init>
 1006d70:	01040737          	lui	a4,0x1040
 1006d74:	400007b7          	lui	a5,0x40000
 1006d78:	20270713          	addi	a4,a4,514 # 1040202 <__boot_rom_data_lma__+0x346c2>
 1006d7c:	c398                	sw	a4,0(a5)
 1006d7e:	43d8                	lw	a4,4(a5)
 1006d80:	9b61                	andi	a4,a4,-8
 1006d82:	c3d8                	sw	a4,4(a5)
 1006d84:	4b30406f          	j	100ba36 <__riscv_restore_0>

01006d88 <lsqspiv2_stg_read_write>:
 1006d88:	48b042ef          	jal	t0,100ba12 <__riscv_save_0>
 1006d8c:	101387b7          	lui	a5,0x10138
 1006d90:	0087a783          	lw	a5,8(a5) # 10138008 <qspiv2_global_int_disable_fn>
 1006d94:	842a                	mv	s0,a0
 1006d96:	9782                	jalr	a5
 1006d98:	40000737          	lui	a4,0x40000
 1006d9c:	45a1                	li	a1,8
 1006d9e:	c36c                	sw	a1,68(a4)
 1006da0:	435c                	lw	a5,4(a4)
 1006da2:	76fd                	lui	a3,0xfffff
 1006da4:	16fd                	addi	a3,a3,-1 # ffffefff <bitmap+0xefebf07f>
 1006da6:	8ff5                	and	a5,a5,a3
 1006da8:	c35c                	sw	a5,4(a4)
 1006daa:	401c                	lw	a5,0(s0)
 1006dac:	d31c                	sw	a5,32(a4)
 1006dae:	405c                	lw	a5,4(s0)
 1006db0:	d35c                	sw	a5,36(a4)
 1006db2:	441c                	lw	a5,8(s0)
 1006db4:	d71c                	sw	a5,40(a4)
 1006db6:	00c42803          	lw	a6,12(s0) # 4002900c <bitmap+0x2fee908c>
 1006dba:	4785                	li	a5,1
 1006dbc:	03072623          	sw	a6,44(a4) # 4000002c <bitmap+0x2fec00ac>
 1006dc0:	db1c                	sw	a5,48(a4)
 1006dc2:	00f877b3          	and	a5,a6,a5
 1006dc6:	eb99                	bnez	a5,1006ddc <lsqspiv2_stg_read_write+0x54>
 1006dc8:	477c                	lw	a5,76(a4)
 1006dca:	8ba1                	andi	a5,a5,8
 1006dcc:	dff5                	beqz	a5,1006dc8 <lsqspiv2_stg_read_write+0x40>
 1006dce:	101387b7          	lui	a5,0x10138
 1006dd2:	0047a783          	lw	a5,4(a5) # 10138004 <qspiv2_global_int_restore_fn>
 1006dd6:	9782                	jalr	a5
 1006dd8:	45f0406f          	j	100ba36 <__riscv_restore_0>
 1006ddc:	4450                	lw	a2,12(s0)
 1006dde:	00f81893          	slli	a7,a6,0xf
 1006de2:	481c                	lw	a5,16(s0)
 1006de4:	3c46368b          	th.extu	a3,a2,15,4
 1006de8:	5546360b          	th.extu	a2,a2,21,20
 1006dec:	0208c663          	bltz	a7,1006e18 <lsqspiv2_stg_read_write+0x90>
 1006df0:	96b2                	add	a3,a3,a2
 1006df2:	0685                	addi	a3,a3,1
 1006df4:	8f91                	sub	a5,a5,a2
 1006df6:	5730                	lw	a2,104(a4)
 1006df8:	feb60fe3          	beq	a2,a1,1006df6 <lsqspiv2_stg_read_write+0x6e>
 1006dfc:	5847c60b          	th.lwia	a2,(a5),4,0
 1006e00:	16f1                	addi	a3,a3,-4
 1006e02:	3c06a68b          	th.ext	a3,a3,15,0
 1006e06:	d330                	sw	a2,96(a4)
 1006e08:	fed047e3          	bgtz	a3,1006df6 <lsqspiv2_stg_read_write+0x6e>
 1006e0c:	40000737          	lui	a4,0x40000
 1006e10:	477c                	lw	a5,76(a4)
 1006e12:	8ba1                	andi	a5,a5,8
 1006e14:	dff5                	beqz	a5,1006e10 <lsqspiv2_stg_read_write+0x88>
 1006e16:	bf65                	j	1006dce <lsqspiv2_stg_read_write+0x46>
 1006e18:	572c                	lw	a1,104(a4)
 1006e1a:	ddfd                	beqz	a1,1006e18 <lsqspiv2_stg_read_write+0x90>
 1006e1c:	536c                	lw	a1,100(a4)
 1006e1e:	4809                	li	a6,2
 1006e20:	00168713          	addi	a4,a3,1
 1006e24:	973e                	add	a4,a4,a5
 1006e26:	03060063          	beq	a2,a6,1006e46 <lsqspiv2_stg_read_write+0xbe>
 1006e2a:	480d                	li	a6,3
 1006e2c:	03060363          	beq	a2,a6,1006e52 <lsqspiv2_stg_read_write+0xca>
 1006e30:	00061563          	bnez	a2,1006e3a <lsqspiv2_stg_read_write+0xb2>
 1006e34:	1817d58b          	th.sbia	a1,(a5),1,0
 1006e38:	c285                	beqz	a3,1006e58 <lsqspiv2_stg_read_write+0xd0>
 1006e3a:	0085d693          	srli	a3,a1,0x8
 1006e3e:	1817d68b          	th.sbia	a3,(a5),1,0
 1006e42:	00f70b63          	beq	a4,a5,1006e58 <lsqspiv2_stg_read_write+0xd0>
 1006e46:	0105d693          	srli	a3,a1,0x10
 1006e4a:	1817d68b          	th.sbia	a3,(a5),1,0
 1006e4e:	00f70563          	beq	a4,a5,1006e58 <lsqspiv2_stg_read_write+0xd0>
 1006e52:	81e1                	srli	a1,a1,0x18
 1006e54:	1817d58b          	th.sbia	a1,(a5),1,0
 1006e58:	460d                	li	a2,3
 1006e5a:	40f706b3          	sub	a3,a4,a5
 1006e5e:	00d65a63          	bge	a2,a3,1006e72 <lsqspiv2_stg_read_write+0xea>
 1006e62:	400006b7          	lui	a3,0x40000
 1006e66:	56ac                	lw	a1,104(a3)
 1006e68:	ddfd                	beqz	a1,1006e66 <lsqspiv2_stg_read_write+0xde>
 1006e6a:	52f4                	lw	a3,100(a3)
 1006e6c:	5847d68b          	th.swia	a3,(a5),4,0
 1006e70:	b7ed                	j	1006e5a <lsqspiv2_stg_read_write+0xd2>
 1006e72:	f4f70ee3          	beq	a4,a5,1006dce <lsqspiv2_stg_read_write+0x46>
 1006e76:	40000737          	lui	a4,0x40000
 1006e7a:	5730                	lw	a2,104(a4)
 1006e7c:	de7d                	beqz	a2,1006e7a <lsqspiv2_stg_read_write+0xf2>
 1006e7e:	5378                	lw	a4,100(a4)
 1006e80:	4609                	li	a2,2
 1006e82:	00c68f63          	beq	a3,a2,1006ea0 <lsqspiv2_stg_read_write+0x118>
 1006e86:	460d                	li	a2,3
 1006e88:	00c68863          	beq	a3,a2,1006e98 <lsqspiv2_stg_read_write+0x110>
 1006e8c:	4605                	li	a2,1
 1006e8e:	f4c690e3          	bne	a3,a2,1006dce <lsqspiv2_stg_read_write+0x46>
 1006e92:	00e78023          	sb	a4,0(a5)
 1006e96:	bf25                	j	1006dce <lsqspiv2_stg_read_write+0x46>
 1006e98:	01075693          	srli	a3,a4,0x10
 1006e9c:	00d78123          	sb	a3,2(a5)
 1006ea0:	00875693          	srli	a3,a4,0x8
 1006ea4:	00d780a3          	sb	a3,1(a5)
 1006ea8:	b7ed                	j	1006e92 <lsqspiv2_stg_read_write+0x10a>

01006eaa <lsqspiv2_stg_send_command>:
 1006eaa:	369042ef          	jal	t0,100ba12 <__riscv_save_0>
 1006eae:	1101                	addi	sp,sp,-32
 1006eb0:	0562                	slli	a0,a0,0x18
 1006eb2:	07100793          	li	a5,113
 1006eb6:	c82a                	sw	a0,16(sp)
 1006eb8:	0068                	addi	a0,sp,12
 1006eba:	c63e                	sw	a5,12(sp)
 1006ebc:	cc02                	sw	zero,24(sp)
 1006ebe:	35e9                	jal	1006d88 <lsqspiv2_stg_read_write>
 1006ec0:	6105                	addi	sp,sp,32
 1006ec2:	3750406f          	j	100ba36 <__riscv_restore_0>

01006ec6 <lsqspiv2_stg_read_register>:
 1006ec6:	34d042ef          	jal	t0,100ba12 <__riscv_save_0>
 1006eca:	1101                	addi	sp,sp,-32
 1006ecc:	07100793          	li	a5,113
 1006ed0:	c63e                	sw	a5,12(sp)
 1006ed2:	fff60793          	addi	a5,a2,-1
 1006ed6:	2c07b78b          	th.extu	a5,a5,11,0
 1006eda:	66c1                	lui	a3,0x10
 1006edc:	0685                	addi	a3,a3,1 # 10001 <Reset_Handler-0xfeffff>
 1006ede:	0792                	slli	a5,a5,0x4
 1006ee0:	00300637          	lui	a2,0x300
 1006ee4:	8fd5                	or	a5,a5,a3
 1006ee6:	01459693          	slli	a3,a1,0x14
 1006eea:	8ef1                	and	a3,a3,a2
 1006eec:	0562                	slli	a0,a0,0x18
 1006eee:	c82a                	sw	a0,16(sp)
 1006ef0:	8fd5                	or	a5,a5,a3
 1006ef2:	0068                	addi	a0,sp,12
 1006ef4:	cc3e                	sw	a5,24(sp)
 1006ef6:	ce2e                	sw	a1,28(sp)
 1006ef8:	3d41                	jal	1006d88 <lsqspiv2_stg_read_write>
 1006efa:	6105                	addi	sp,sp,32
 1006efc:	33b0406f          	j	100ba36 <__riscv_restore_0>

01006f00 <lsqspiv2_stg_write_register>:
 1006f00:	313042ef          	jal	t0,100ba12 <__riscv_save_0>
 1006f04:	1101                	addi	sp,sp,-32
 1006f06:	07100793          	li	a5,113
 1006f0a:	c63e                	sw	a5,12(sp)
 1006f0c:	fff60793          	addi	a5,a2,-1 # 2fffff <Reset_Handler-0xd00001>
 1006f10:	2c07b78b          	th.extu	a5,a5,11,0
 1006f14:	01459693          	slli	a3,a1,0x14
 1006f18:	00300637          	lui	a2,0x300
 1006f1c:	0792                	slli	a5,a5,0x4
 1006f1e:	8ef1                	and	a3,a3,a2
 1006f20:	0562                	slli	a0,a0,0x18
 1006f22:	0017e793          	ori	a5,a5,1
 1006f26:	c82a                	sw	a0,16(sp)
 1006f28:	8fd5                	or	a5,a5,a3
 1006f2a:	0068                	addi	a0,sp,12
 1006f2c:	cc3e                	sw	a5,24(sp)
 1006f2e:	ce2e                	sw	a1,28(sp)
 1006f30:	3da1                	jal	1006d88 <lsqspiv2_stg_read_write>
 1006f32:	6105                	addi	sp,sp,32
 1006f34:	3030406f          	j	100ba36 <__riscv_restore_0>

01006f38 <hal_flash_read_loop.constprop.0>:
 1006f38:	2c1042ef          	jal	t0,100b9f8 <__riscv_save_4>
 1006f3c:	6985                	lui	s3,0x1
 1006f3e:	7ac1                	lui	s5,0xffff0
 1006f40:	84aa                	mv	s1,a0
 1006f42:	8932                	mv	s2,a2
 1006f44:	8436                	mv	s0,a3
 1006f46:	01859a13          	slli	s4,a1,0x18
 1006f4a:	fff98b13          	addi	s6,s3,-1 # fff <Reset_Handler-0xfff001>
 1006f4e:	0abd                	addi	s5,s5,15 # ffff000f <bitmap+0xefeb008f>
 1006f50:	e019                	bnez	s0,1006f56 <hal_flash_read_loop.constprop.0+0x1e>
 1006f52:	2db0406f          	j	100ba2c <__riscv_restore_4>
 1006f56:	012a67b3          	or	a5,s4,s2
 1006f5a:	c0dc                	sw	a5,4(s1)
 1006f5c:	0289f563          	bgeu	s3,s0,1006f86 <hal_flash_read_loop.constprop.0+0x4e>
 1006f60:	41340433          	sub	s0,s0,s3
 1006f64:	994e                	add	s2,s2,s3
 1006f66:	87da                	mv	a5,s6
 1006f68:	44d8                	lw	a4,12(s1)
 1006f6a:	2c07b78b          	th.extu	a5,a5,11,0
 1006f6e:	0792                	slli	a5,a5,0x4
 1006f70:	01577733          	and	a4,a4,s5
 1006f74:	8fd9                	or	a5,a5,a4
 1006f76:	c4dc                	sw	a5,12(s1)
 1006f78:	8526                	mv	a0,s1
 1006f7a:	a5efe0ef          	jal	10051d8 <hal_flash_read_operation>
 1006f7e:	489c                	lw	a5,16(s1)
 1006f80:	97ce                	add	a5,a5,s3
 1006f82:	c89c                	sw	a5,16(s1)
 1006f84:	b7f1                	j	1006f50 <hal_flash_read_loop.constprop.0+0x18>
 1006f86:	147d                	addi	s0,s0,-1
 1006f88:	2c04340b          	th.extu	s0,s0,11,0
 1006f8c:	3c04378b          	th.extu	a5,s0,15,0
 1006f90:	4401                	li	s0,0
 1006f92:	bfd9                	j	1006f68 <hal_flash_read_loop.constprop.0+0x30>

01006f94 <hal_flash_init>:
 1006f94:	dd5ff06f          	j	1006d68 <lsqspiv2_init>

01006f98 <hal_flash_quad_xip_mode_enter>:
 1006f98:	27b042ef          	jal	t0,100ba12 <__riscv_save_0>
 1006f9c:	420b17b7          	lui	a5,0x420b1
 1006fa0:	1101                	addi	sp,sp,-32
 1006fa2:	07178793          	addi	a5,a5,113 # 420b1071 <bitmap+0x31f710f1>
 1006fa6:	c63e                	sw	a5,12(sp)
 1006fa8:	eb0007b7          	lui	a5,0xeb000
 1006fac:	c83e                	sw	a5,16(sp)
 1006fae:	a00007b7          	lui	a5,0xa0000
 1006fb2:	ca3e                	sw	a5,20(sp)
 1006fb4:	003107b7          	lui	a5,0x310
 1006fb8:	0785                	addi	a5,a5,1 # 310001 <Reset_Handler-0xceffff>
 1006fba:	cc3e                	sw	a5,24(sp)
 1006fbc:	0068                	addi	a0,sp,12
 1006fbe:	00b10793          	addi	a5,sp,11
 1006fc2:	ce3e                	sw	a5,28(sp)
 1006fc4:	33d1                	jal	1006d88 <lsqspiv2_stg_read_write>
 1006fc6:	6105                	addi	sp,sp,32
 1006fc8:	26f0406f          	j	100ba36 <__riscv_restore_0>

01006fcc <hal_flash_dual_xip_mode_enter>:
 1006fcc:	247042ef          	jal	t0,100ba12 <__riscv_save_0>
 1006fd0:	010f17b7          	lui	a5,0x10f1
 1006fd4:	1101                	addi	sp,sp,-32
 1006fd6:	07178793          	addi	a5,a5,113 # 10f1071 <__boot_rom_data_lma__+0xe5531>
 1006fda:	c63e                	sw	a5,12(sp)
 1006fdc:	bb0007b7          	lui	a5,0xbb000
 1006fe0:	c83e                	sw	a5,16(sp)
 1006fe2:	a00007b7          	lui	a5,0xa0000
 1006fe6:	ca3e                	sw	a5,20(sp)
 1006fe8:	003107b7          	lui	a5,0x310
 1006fec:	0785                	addi	a5,a5,1 # 310001 <Reset_Handler-0xceffff>
 1006fee:	cc3e                	sw	a5,24(sp)
 1006ff0:	0068                	addi	a0,sp,12
 1006ff2:	00b10793          	addi	a5,sp,11
 1006ff6:	ce3e                	sw	a5,28(sp)
 1006ff8:	3b41                	jal	1006d88 <lsqspiv2_stg_read_write>
 1006ffa:	6105                	addi	sp,sp,32
 1006ffc:	23b0406f          	j	100ba36 <__riscv_restore_0>

01007000 <hal_flash_write_enable>:
 1007000:	4519                	li	a0,6
 1007002:	ea9ff06f          	j	1006eaa <lsqspiv2_stg_send_command>

01007006 <hal_flash_xip_mode_reset>:
 1007006:	20d042ef          	jal	t0,100ba12 <__riscv_save_0>
 100700a:	1141                	addi	sp,sp,-16
 100700c:	57fd                	li	a5,-1
 100700e:	00f10593          	addi	a1,sp,15
 1007012:	4605                	li	a2,1
 1007014:	0ff00513          	li	a0,255
 1007018:	00f107a3          	sb	a5,15(sp)
 100701c:	35d5                	jal	1006f00 <lsqspiv2_stg_write_register>
 100701e:	0141                	addi	sp,sp,16
 1007020:	2170406f          	j	100ba36 <__riscv_restore_0>

01007024 <do_hal_flash_prog_func>:
 1007024:	d65ff06f          	j	1006d88 <lsqspiv2_stg_read_write>

01007028 <do_hal_flash_write_reg_func>:
 1007028:	00554603          	lbu	a2,5(a0)
 100702c:	410c                	lw	a1,0(a0)
 100702e:	00454503          	lbu	a0,4(a0)
 1007032:	ecfff06f          	j	1006f00 <lsqspiv2_stg_write_register>

01007036 <hal_flash_quad_page_program>:
 1007036:	1dd042ef          	jal	t0,100ba12 <__riscv_save_0>
 100703a:	020007b7          	lui	a5,0x2000
 100703e:	1101                	addi	sp,sp,-32
 1007040:	1f178793          	addi	a5,a5,497 # 20001f1 <__boot_rom_data_lma__+0xff46b1>
 1007044:	c63e                	sw	a5,12(sp)
 1007046:	320007b7          	lui	a5,0x32000
 100704a:	8d5d                	or	a0,a0,a5
 100704c:	fff60793          	addi	a5,a2,-1 # 2fffff <Reset_Handler-0xd00001>
 1007050:	2c07b78b          	th.extu	a5,a5,11,0
 1007054:	01459693          	slli	a3,a1,0x14
 1007058:	00300637          	lui	a2,0x300
 100705c:	0792                	slli	a5,a5,0x4
 100705e:	8ef1                	and	a3,a3,a2
 1007060:	0017e793          	ori	a5,a5,1
 1007064:	c82a                	sw	a0,16(sp)
 1007066:	8fd5                	or	a5,a5,a3
 1007068:	0068                	addi	a0,sp,12
 100706a:	cc3e                	sw	a5,24(sp)
 100706c:	ce2e                	sw	a1,28(sp)
 100706e:	8fafe0ef          	jal	1005168 <hal_flash_program_operation>
 1007072:	6105                	addi	sp,sp,32
 1007074:	1c30406f          	j	100ba36 <__riscv_restore_0>

01007078 <hal_flash_dual_page_program>:
 1007078:	19b042ef          	jal	t0,100ba12 <__riscv_save_0>
 100707c:	010007b7          	lui	a5,0x1000
 1007080:	1101                	addi	sp,sp,-32
 1007082:	1f178793          	addi	a5,a5,497 # 10001f1 <lsqspiv2_msp_init+0xd>
 1007086:	c63e                	sw	a5,12(sp)
 1007088:	a20007b7          	lui	a5,0xa2000
 100708c:	8d5d                	or	a0,a0,a5
 100708e:	fff60793          	addi	a5,a2,-1 # 2fffff <Reset_Handler-0xd00001>
 1007092:	2c07b78b          	th.extu	a5,a5,11,0
 1007096:	01459693          	slli	a3,a1,0x14
 100709a:	00300637          	lui	a2,0x300
 100709e:	0792                	slli	a5,a5,0x4
 10070a0:	8ef1                	and	a3,a3,a2
 10070a2:	0017e793          	ori	a5,a5,1
 10070a6:	c82a                	sw	a0,16(sp)
 10070a8:	8fd5                	or	a5,a5,a3
 10070aa:	0068                	addi	a0,sp,12
 10070ac:	cc3e                	sw	a5,24(sp)
 10070ae:	ce2e                	sw	a1,28(sp)
 10070b0:	8b8fe0ef          	jal	1005168 <hal_flash_program_operation>
 10070b4:	6105                	addi	sp,sp,32
 10070b6:	1810406f          	j	100ba36 <__riscv_restore_0>

010070ba <hal_flash_page_program>:
 10070ba:	159042ef          	jal	t0,100ba12 <__riscv_save_0>
 10070be:	1101                	addi	sp,sp,-32
 10070c0:	1f100793          	li	a5,497
 10070c4:	c63e                	sw	a5,12(sp)
 10070c6:	020007b7          	lui	a5,0x2000
 10070ca:	8d5d                	or	a0,a0,a5
 10070cc:	fff60793          	addi	a5,a2,-1 # 2fffff <Reset_Handler-0xd00001>
 10070d0:	2c07b78b          	th.extu	a5,a5,11,0
 10070d4:	01459693          	slli	a3,a1,0x14
 10070d8:	00300637          	lui	a2,0x300
 10070dc:	0792                	slli	a5,a5,0x4
 10070de:	8ef1                	and	a3,a3,a2
 10070e0:	0017e793          	ori	a5,a5,1
 10070e4:	c82a                	sw	a0,16(sp)
 10070e6:	8fd5                	or	a5,a5,a3
 10070e8:	0068                	addi	a0,sp,12
 10070ea:	cc3e                	sw	a5,24(sp)
 10070ec:	ce2e                	sw	a1,28(sp)
 10070ee:	87afe0ef          	jal	1005168 <hal_flash_program_operation>
 10070f2:	6105                	addi	sp,sp,32
 10070f4:	1430406f          	j	100ba36 <__riscv_restore_0>

010070f8 <do_hal_flash_chip_erase_func>:
 10070f8:	06000513          	li	a0,96
 10070fc:	dafff06f          	j	1006eaa <lsqspiv2_stg_send_command>

01007100 <do_hal_flash_read_func>:
 1007100:	c89ff06f          	j	1006d88 <lsqspiv2_stg_read_write>

01007104 <hal_flash_quad_io_read>:
 1007104:	10f042ef          	jal	t0,100ba12 <__riscv_save_0>
 1007108:	420b17b7          	lui	a5,0x420b1
 100710c:	1101                	addi	sp,sp,-32
 100710e:	07178793          	addi	a5,a5,113 # 420b1071 <bitmap+0x31f710f1>
 1007112:	c63e                	sw	a5,12(sp)
 1007114:	00300737          	lui	a4,0x300
 1007118:	01459793          	slli	a5,a1,0x14
 100711c:	8ff9                	and	a5,a5,a4
 100711e:	6741                	lui	a4,0x10
 1007120:	0705                	addi	a4,a4,1 # 10001 <Reset_Handler-0xfeffff>
 1007122:	86b2                	mv	a3,a2
 1007124:	8fd9                	or	a5,a5,a4
 1007126:	ce2e                	sw	a1,28(sp)
 1007128:	862a                	mv	a2,a0
 100712a:	0eb00593          	li	a1,235
 100712e:	0068                	addi	a0,sp,12
 1007130:	cc3e                	sw	a5,24(sp)
 1007132:	ca02                	sw	zero,20(sp)
 1007134:	3511                	jal	1006f38 <hal_flash_read_loop.constprop.0>
 1007136:	6105                	addi	sp,sp,32
 1007138:	0ff0406f          	j	100ba36 <__riscv_restore_0>

0100713c <hal_flash_dual_io_read>:
 100713c:	0d7042ef          	jal	t0,100ba12 <__riscv_save_0>
 1007140:	110f17b7          	lui	a5,0x110f1
 1007144:	1101                	addi	sp,sp,-32
 1007146:	07178793          	addi	a5,a5,113 # 110f1071 <bitmap+0xfb10f1>
 100714a:	c63e                	sw	a5,12(sp)
 100714c:	00300737          	lui	a4,0x300
 1007150:	01459793          	slli	a5,a1,0x14
 1007154:	8ff9                	and	a5,a5,a4
 1007156:	6741                	lui	a4,0x10
 1007158:	0705                	addi	a4,a4,1 # 10001 <Reset_Handler-0xfeffff>
 100715a:	86b2                	mv	a3,a2
 100715c:	8fd9                	or	a5,a5,a4
 100715e:	ce2e                	sw	a1,28(sp)
 1007160:	862a                	mv	a2,a0
 1007162:	0bb00593          	li	a1,187
 1007166:	0068                	addi	a0,sp,12
 1007168:	cc3e                	sw	a5,24(sp)
 100716a:	ca02                	sw	zero,20(sp)
 100716c:	33f1                	jal	1006f38 <hal_flash_read_loop.constprop.0>
 100716e:	6105                	addi	sp,sp,32
 1007170:	0c70406f          	j	100ba36 <__riscv_restore_0>

01007174 <hal_flash_read_24bit_addr_8bit_dummy>:
 1007174:	09f042ef          	jal	t0,100ba12 <__riscv_save_0>
 1007178:	800007b7          	lui	a5,0x80000
 100717c:	1101                	addi	sp,sp,-32
 100717e:	872e                	mv	a4,a1
 1007180:	27178793          	addi	a5,a5,625 # 80000271 <bitmap+0x6fec02f1>
 1007184:	85b6                	mv	a1,a3
 1007186:	c63e                	sw	a5,12(sp)
 1007188:	003006b7          	lui	a3,0x300
 100718c:	01471793          	slli	a5,a4,0x14
 1007190:	8ff5                	and	a5,a5,a3
 1007192:	66c1                	lui	a3,0x10
 1007194:	0685                	addi	a3,a3,1 # 10001 <Reset_Handler-0xfeffff>
 1007196:	8fd5                	or	a5,a5,a3
 1007198:	86b2                	mv	a3,a2
 100719a:	862a                	mv	a2,a0
 100719c:	0068                	addi	a0,sp,12
 100719e:	cc3e                	sw	a5,24(sp)
 10071a0:	ce3a                	sw	a4,28(sp)
 10071a2:	ca02                	sw	zero,20(sp)
 10071a4:	3b51                	jal	1006f38 <hal_flash_read_loop.constprop.0>
 10071a6:	6105                	addi	sp,sp,32
 10071a8:	08f0406f          	j	100ba36 <__riscv_restore_0>

010071ac <hal_flash_deep_power_down>:
 10071ac:	0b900513          	li	a0,185
 10071b0:	cfbff06f          	j	1006eaa <lsqspiv2_stg_send_command>

010071b4 <hal_flash_release_from_deep_power_down>:
 10071b4:	0ab00513          	li	a0,171
 10071b8:	cf3ff06f          	j	1006eaa <lsqspiv2_stg_send_command>

010071bc <do_hal_flash_read_reg_func>:
 10071bc:	00554603          	lbu	a2,5(a0)
 10071c0:	410c                	lw	a1,0(a0)
 10071c2:	00454503          	lbu	a0,4(a0)
 10071c6:	d01ff06f          	j	1006ec6 <lsqspiv2_stg_read_register>

010071ca <hal_flash_read_unique_id>:
 10071ca:	049042ef          	jal	t0,100ba12 <__riscv_save_0>
 10071ce:	800007b7          	lui	a5,0x80000
 10071d2:	1101                	addi	sp,sp,-32
 10071d4:	27178793          	addi	a5,a5,625 # 80000271 <bitmap+0x6fec02f1>
 10071d8:	c63e                	sw	a5,12(sp)
 10071da:	4b0007b7          	lui	a5,0x4b000
 10071de:	c83e                	sw	a5,16(sp)
 10071e0:	003006b7          	lui	a3,0x300
 10071e4:	01451793          	slli	a5,a0,0x14
 10071e8:	8ff5                	and	a5,a5,a3
 10071ea:	66c1                	lui	a3,0x10
 10071ec:	0f168693          	addi	a3,a3,241 # 100f1 <Reset_Handler-0xfeff0f>
 10071f0:	8fd5                	or	a5,a5,a3
 10071f2:	ce2a                	sw	a0,28(sp)
 10071f4:	0068                	addi	a0,sp,12
 10071f6:	cc3e                	sw	a5,24(sp)
 10071f8:	ca02                	sw	zero,20(sp)
 10071fa:	fdffd0ef          	jal	10051d8 <hal_flash_read_operation>
 10071fe:	6105                	addi	sp,sp,32
 1007200:	0370406f          	j	100ba36 <__riscv_restore_0>

01007204 <hal_flash_program_security_area>:
 1007204:	00f042ef          	jal	t0,100ba12 <__riscv_save_0>
 1007208:	1101                	addi	sp,sp,-32
 100720a:	1f100793          	li	a5,497
 100720e:	0532                	slli	a0,a0,0xc
 1007210:	c63e                	sw	a5,12(sp)
 1007212:	8d4d                	or	a0,a0,a1
 1007214:	420007b7          	lui	a5,0x42000
 1007218:	8d5d                	or	a0,a0,a5
 100721a:	fff68793          	addi	a5,a3,-1
 100721e:	2c07b78b          	th.extu	a5,a5,11,0
 1007222:	01461693          	slli	a3,a2,0x14
 1007226:	003005b7          	lui	a1,0x300
 100722a:	0792                	slli	a5,a5,0x4
 100722c:	8eed                	and	a3,a3,a1
 100722e:	0017e793          	ori	a5,a5,1
 1007232:	c82a                	sw	a0,16(sp)
 1007234:	8fd5                	or	a5,a5,a3
 1007236:	0068                	addi	a0,sp,12
 1007238:	cc3e                	sw	a5,24(sp)
 100723a:	ce32                	sw	a2,28(sp)
 100723c:	f2dfd0ef          	jal	1005168 <hal_flash_program_operation>
 1007240:	6105                	addi	sp,sp,32
 1007242:	7f40406f          	j	100ba36 <__riscv_restore_0>

01007246 <hal_flash_read_security_area>:
 1007246:	7cc042ef          	jal	t0,100ba12 <__riscv_save_0>
 100724a:	800007b7          	lui	a5,0x80000
 100724e:	1101                	addi	sp,sp,-32
 1007250:	27178793          	addi	a5,a5,625 # 80000271 <bitmap+0x6fec02f1>
 1007254:	0532                	slli	a0,a0,0xc
 1007256:	c63e                	sw	a5,12(sp)
 1007258:	8d4d                	or	a0,a0,a1
 100725a:	480007b7          	lui	a5,0x48000
 100725e:	8d5d                	or	a0,a0,a5
 1007260:	fff68793          	addi	a5,a3,-1
 1007264:	2c07b78b          	th.extu	a5,a5,11,0
 1007268:	66c1                	lui	a3,0x10
 100726a:	0685                	addi	a3,a3,1 # 10001 <Reset_Handler-0xfeffff>
 100726c:	0792                	slli	a5,a5,0x4
 100726e:	003005b7          	lui	a1,0x300
 1007272:	8fd5                	or	a5,a5,a3
 1007274:	01461693          	slli	a3,a2,0x14
 1007278:	8eed                	and	a3,a3,a1
 100727a:	c82a                	sw	a0,16(sp)
 100727c:	8fd5                	or	a5,a5,a3
 100727e:	0068                	addi	a0,sp,12
 1007280:	cc3e                	sw	a5,24(sp)
 1007282:	ce32                	sw	a2,28(sp)
 1007284:	ca02                	sw	zero,20(sp)
 1007286:	f53fd0ef          	jal	10051d8 <hal_flash_read_operation>
 100728a:	6105                	addi	sp,sp,32
 100728c:	7aa0406f          	j	100ba36 <__riscv_restore_0>

01007290 <hal_flash_software_reset>:
 1007290:	782042ef          	jal	t0,100ba12 <__riscv_save_0>
 1007294:	06600513          	li	a0,102
 1007298:	3909                	jal	1006eaa <lsqspiv2_stg_send_command>
 100729a:	09900513          	li	a0,153
 100729e:	3131                	jal	1006eaa <lsqspiv2_stg_send_command>
 10072a0:	7960406f          	j	100ba36 <__riscv_restore_0>

010072a4 <xip_dummy>:
 10072a4:	8082                	ret

010072a6 <hal_flash_drv_var_init>:
 10072a6:	d0018713          	addi	a4,gp,-768 # 10138500 <flash_stat>
 10072aa:	00a700a3          	sb	a0,1(a4)
 10072ae:	d0b18023          	sb	a1,-768(gp) # 10138500 <flash_stat>
 10072b2:	8082                	ret

010072b4 <hal_flash_xip_func_ptr_dummy>:
 10072b4:	010077b7          	lui	a5,0x1007
 10072b8:	2a478793          	addi	a5,a5,676 # 10072a4 <xip_dummy>
 10072bc:	cef1ac23          	sw	a5,-776(gp) # 101384f8 <hal_flash_xip_start_fn>
 10072c0:	cef1ae23          	sw	a5,-772(gp) # 101384fc <hal_flash_xip_stop_fn>
 10072c4:	8082                	ret

010072c6 <flash_reading_critical>:
 10072c6:	74c042ef          	jal	t0,100ba12 <__riscv_save_0>
 10072ca:	cfc1a783          	lw	a5,-772(gp) # 101384fc <hal_flash_xip_stop_fn>
 10072ce:	1141                	addi	sp,sp,-16
 10072d0:	842a                	mv	s0,a0
 10072d2:	c62e                	sw	a1,12(sp)
 10072d4:	9782                	jalr	a5
 10072d6:	4532                	lw	a0,12(sp)
 10072d8:	9402                	jalr	s0
 10072da:	cf81a783          	lw	a5,-776(gp) # 101384f8 <hal_flash_xip_start_fn>
 10072de:	9782                	jalr	a5
 10072e0:	0141                	addi	sp,sp,16
 10072e2:	7540406f          	j	100ba36 <__riscv_restore_0>

010072e6 <hal_flash_chip_erase>:
 10072e6:	4501                	li	a0,0
 10072e8:	f61fd06f          	j	1005248 <hal_flash_chip_erase_operation>

010072ec <hal_flash_write_status_register>:
 10072ec:	726042ef          	jal	t0,100ba12 <__riscv_save_0>
 10072f0:	1101                	addi	sp,sp,-32
 10072f2:	00e10793          	addi	a5,sp,14
 10072f6:	00a11723          	sh	a0,14(sp)
 10072fa:	cc3e                	sw	a5,24(sp)
 10072fc:	0828                	addi	a0,sp,24
 10072fe:	20100793          	li	a5,513
 1007302:	00f11e23          	sh	a5,28(sp)
 1007306:	e9bfd0ef          	jal	10051a0 <hal_flash_write_reg_operation>
 100730a:	6105                	addi	sp,sp,32
 100730c:	72a0406f          	j	100ba36 <__riscv_restore_0>

01007310 <hal_flash_sector_erase>:
 1007310:	702042ef          	jal	t0,100ba12 <__riscv_save_0>
 1007314:	1141                	addi	sp,sp,-16
 1007316:	01055793          	srli	a5,a0,0x10
 100731a:	00f10223          	sb	a5,4(sp)
 100731e:	00855793          	srli	a5,a0,0x8
 1007322:	00f102a3          	sb	a5,5(sp)
 1007326:	005c                	addi	a5,sp,4
 1007328:	00a10323          	sb	a0,6(sp)
 100732c:	c43e                	sw	a5,8(sp)
 100732e:	0028                	addi	a0,sp,8
 1007330:	32000793          	li	a5,800
 1007334:	00f11623          	sh	a5,12(sp)
 1007338:	e69fd0ef          	jal	10051a0 <hal_flash_write_reg_operation>
 100733c:	0141                	addi	sp,sp,16
 100733e:	6f80406f          	j	100ba36 <__riscv_restore_0>

01007342 <do_hal_flash_read>:
 1007342:	85aa                	mv	a1,a0
 1007344:	01007537          	lui	a0,0x1007
 1007348:	10050513          	addi	a0,a0,256 # 1007100 <do_hal_flash_read_func>
 100734c:	f7bff06f          	j	10072c6 <flash_reading_critical>

01007350 <do_hal_flash_read_reg>:
 1007350:	85aa                	mv	a1,a0
 1007352:	01007537          	lui	a0,0x1007
 1007356:	1bc50513          	addi	a0,a0,444 # 10071bc <do_hal_flash_read_reg_func>
 100735a:	f6dff06f          	j	10072c6 <flash_reading_critical>

0100735e <hal_flash_read_id>:
 100735e:	6b4042ef          	jal	t0,100ba12 <__riscv_save_0>
 1007362:	1141                	addi	sp,sp,-16
 1007364:	c42a                	sw	a0,8(sp)
 1007366:	39f00793          	li	a5,927
 100736a:	0028                	addi	a0,sp,8
 100736c:	00f11623          	sh	a5,12(sp)
 1007370:	ea1fd0ef          	jal	1005210 <hal_flash_read_reg_operation>
 1007374:	0141                	addi	sp,sp,16
 1007376:	6c00406f          	j	100ba36 <__riscv_restore_0>

0100737a <hal_flash_read_status_register_0>:
 100737a:	698042ef          	jal	t0,100ba12 <__riscv_save_0>
 100737e:	1141                	addi	sp,sp,-16
 1007380:	c42a                	sw	a0,8(sp)
 1007382:	10500793          	li	a5,261
 1007386:	0028                	addi	a0,sp,8
 1007388:	00f11623          	sh	a5,12(sp)
 100738c:	e85fd0ef          	jal	1005210 <hal_flash_read_reg_operation>
 1007390:	0141                	addi	sp,sp,16
 1007392:	6a40406f          	j	100ba36 <__riscv_restore_0>

01007396 <hal_flash_read_status_register_1>:
 1007396:	67c042ef          	jal	t0,100ba12 <__riscv_save_0>
 100739a:	1141                	addi	sp,sp,-16
 100739c:	c42a                	sw	a0,8(sp)
 100739e:	13500793          	li	a5,309
 10073a2:	0028                	addi	a0,sp,8
 10073a4:	00f11623          	sh	a5,12(sp)
 10073a8:	e69fd0ef          	jal	1005210 <hal_flash_read_reg_operation>
 10073ac:	0141                	addi	sp,sp,16
 10073ae:	6880406f          	j	100ba36 <__riscv_restore_0>

010073b2 <hal_flash_read_status_register_0_ram>:
 10073b2:	660042ef          	jal	t0,100ba12 <__riscv_save_0>
 10073b6:	1141                	addi	sp,sp,-16
 10073b8:	c42a                	sw	a0,8(sp)
 10073ba:	10500793          	li	a5,261
 10073be:	0028                	addi	a0,sp,8
 10073c0:	00f11623          	sh	a5,12(sp)
 10073c4:	3be5                	jal	10071bc <do_hal_flash_read_reg_func>
 10073c6:	0141                	addi	sp,sp,16
 10073c8:	66e0406f          	j	100ba36 <__riscv_restore_0>

010073cc <hal_flash_write_in_process>:
 10073cc:	646042ef          	jal	t0,100ba12 <__riscv_save_0>
 10073d0:	1141                	addi	sp,sp,-16
 10073d2:	00f10513          	addi	a0,sp,15
 10073d6:	3ff1                	jal	10073b2 <hal_flash_read_status_register_0_ram>
 10073d8:	00f14503          	lbu	a0,15(sp)
 10073dc:	0141                	addi	sp,sp,16
 10073de:	8905                	andi	a0,a0,1
 10073e0:	6560406f          	j	100ba36 <__riscv_restore_0>

010073e4 <flash_writing_critical>:
 10073e4:	62e042ef          	jal	t0,100ba12 <__riscv_save_0>
 10073e8:	892e                	mv	s2,a1
 10073ea:	84aa                	mv	s1,a0
 10073ec:	ce3f80ef          	jal	10000ce <enter_critical>
 10073f0:	cfc1a783          	lw	a5,-772(gp) # 101384fc <hal_flash_xip_stop_fn>
 10073f4:	842a                	mv	s0,a0
 10073f6:	9782                	jalr	a5
 10073f8:	3121                	jal	1007000 <hal_flash_write_enable>
 10073fa:	854a                	mv	a0,s2
 10073fc:	9482                	jalr	s1
 10073fe:	4785                	li	a5,1
 1007400:	8522                	mv	a0,s0
 1007402:	d0f18023          	sb	a5,-768(gp) # 10138500 <flash_stat>
 1007406:	cd3f80ef          	jal	10000d8 <exit_critical>
 100740a:	37c9                	jal	10073cc <hal_flash_write_in_process>
 100740c:	fd7d                	bnez	a0,100740a <flash_writing_critical+0x26>
 100740e:	cf81a783          	lw	a5,-776(gp) # 101384f8 <hal_flash_xip_start_fn>
 1007412:	d0018023          	sb	zero,-768(gp) # 10138500 <flash_stat>
 1007416:	9782                	jalr	a5
 1007418:	61e0406f          	j	100ba36 <__riscv_restore_0>

0100741c <do_hal_flash_program>:
 100741c:	85aa                	mv	a1,a0
 100741e:	01007537          	lui	a0,0x1007
 1007422:	02450513          	addi	a0,a0,36 # 1007024 <do_hal_flash_prog_func>
 1007426:	fbfff06f          	j	10073e4 <flash_writing_critical>

0100742a <do_hal_flash_write_reg>:
 100742a:	85aa                	mv	a1,a0
 100742c:	01007537          	lui	a0,0x1007
 1007430:	02850513          	addi	a0,a0,40 # 1007028 <do_hal_flash_write_reg_func>
 1007434:	fb1ff06f          	j	10073e4 <flash_writing_critical>

01007438 <do_hal_flash_chip_erase>:
 1007438:	85aa                	mv	a1,a0
 100743a:	01007537          	lui	a0,0x1007
 100743e:	0f850513          	addi	a0,a0,248 # 10070f8 <do_hal_flash_chip_erase_func>
 1007442:	fa3ff06f          	j	10073e4 <flash_writing_critical>

01007446 <hal_flash_erase_security_area>:
 1007446:	5cc042ef          	jal	t0,100ba12 <__riscv_save_0>
 100744a:	1141                	addi	sp,sp,-16
 100744c:	005c                	addi	a5,sp,4
 100744e:	0512                	slli	a0,a0,0x4
 1007450:	00a102a3          	sb	a0,5(sp)
 1007454:	c43e                	sw	a5,8(sp)
 1007456:	0028                	addi	a0,sp,8
 1007458:	34400793          	li	a5,836
 100745c:	00f11623          	sh	a5,12(sp)
 1007460:	00010223          	sb	zero,4(sp)
 1007464:	00010323          	sb	zero,6(sp)
 1007468:	d39fd0ef          	jal	10051a0 <hal_flash_write_reg_operation>
 100746c:	0141                	addi	sp,sp,16
 100746e:	5c80406f          	j	100ba36 <__riscv_restore_0>

01007472 <hal_flash_fast_read>:
 1007472:	46ad                	li	a3,11
 1007474:	d01ff06f          	j	1007174 <hal_flash_read_24bit_addr_8bit_dummy>

01007478 <hal_flash_read_sfdp>:
 1007478:	05a00693          	li	a3,90
 100747c:	cf9ff06f          	j	1007174 <hal_flash_read_24bit_addr_8bit_dummy>

01007480 <lscache_cache_enable>:
 1007480:	592042ef          	jal	t0,100ba12 <__riscv_save_0>
 1007484:	842a                	mv	s0,a0
 1007486:	cf2f90ef          	jal	1000978 <lscache_msp_init>
 100748a:	00541793          	slli	a5,s0,0x5
 100748e:	0207f793          	andi	a5,a5,32
 1007492:	0017e793          	ori	a5,a5,1
 1007496:	40020737          	lui	a4,0x40020
 100749a:	c31c                	sw	a5,0(a4)
 100749c:	435c                	lw	a5,4(a4)
 100749e:	8b91                	andi	a5,a5,4
 10074a0:	dff5                	beqz	a5,100749c <lscache_cache_enable+0x1c>
 10074a2:	40020737          	lui	a4,0x40020
 10074a6:	435c                	lw	a5,4(a4)
 10074a8:	8b91                	andi	a5,a5,4
 10074aa:	fff5                	bnez	a5,10074a6 <lscache_cache_enable+0x26>
 10074ac:	58a0406f          	j	100ba36 <__riscv_restore_0>

010074b0 <uart_flag_poll>:
 10074b0:	411c                	lw	a5,0(a0)
 10074b2:	4158                	lw	a4,4(a0)
 10074b4:	439c                	lw	a5,0(a5)
 10074b6:	539c                	lw	a5,32(a5)
 10074b8:	00e7f533          	and	a0,a5,a4
 10074bc:	00a03533          	snez	a0,a0
 10074c0:	8082                	ret

010074c2 <UART_AutoBaudRate_Detect_Start.isra.0>:
 10074c2:	455c                	lw	a5,12(a0)
 10074c4:	7765                	lui	a4,0xffff9
 10074c6:	177d                	addi	a4,a4,-1 # ffff8fff <bitmap+0xefeb907f>
 10074c8:	0807e793          	ori	a5,a5,128
 10074cc:	c55c                	sw	a5,12(a0)
 10074ce:	491c                	lw	a5,16(a0)
 10074d0:	05b6                	slli	a1,a1,0xd
 10074d2:	8ff9                	and	a5,a5,a4
 10074d4:	8fcd                	or	a5,a5,a1
 10074d6:	6705                	lui	a4,0x1
 10074d8:	8fd9                	or	a5,a5,a4
 10074da:	c91c                	sw	a5,16(a0)
 10074dc:	8082                	ret

010074de <HAL_UART_Init>:
 10074de:	c921                	beqz	a0,100752e <HAL_UART_Init+0x50>
 10074e0:	532042ef          	jal	t0,100ba12 <__riscv_save_0>
 10074e4:	842a                	mv	s0,a0
 10074e6:	d43f80ef          	jal	1000228 <HAL_UART_MSP_Init>
 10074ea:	8522                	mv	a0,s0
 10074ec:	df3f80ef          	jal	10002de <HAL_UART_MSP_Busy_Set>
 10074f0:	401c                	lw	a5,0(s0)
 10074f2:	4501                	li	a0,0
 10074f4:	47d8                	lw	a4,12(a5)
 10074f6:	08076713          	ori	a4,a4,128
 10074fa:	c7d8                	sw	a4,12(a5)
 10074fc:	4058                	lw	a4,4(s0)
 10074fe:	c798                	sw	a4,8(a5)
 1007500:	47d8                	lw	a4,12(a5)
 1007502:	f7f77713          	andi	a4,a4,-129
 1007506:	c7d8                	sw	a4,12(a5)
 1007508:	471d                	li	a4,7
 100750a:	cfd8                	sw	a4,28(a5)
 100750c:	4418                	lw	a4,8(s0)
 100750e:	1457368b          	th.extu	a3,a4,5,5
 1007512:	06a6                	slli	a3,a3,0x9
 1007514:	8b7d                	andi	a4,a4,31
 1007516:	8f55                	or	a4,a4,a3
 1007518:	02076713          	ori	a4,a4,32
 100751c:	c7d8                	sw	a4,12(a5)
 100751e:	02000713          	li	a4,32
 1007522:	d418                	sw	a4,40(s0)
 1007524:	d458                	sw	a4,44(s0)
 1007526:	5818                	lw	a4,48(s0)
 1007528:	cf98                	sw	a4,24(a5)
 100752a:	50c0406f          	j	100ba36 <__riscv_restore_0>
 100752e:	4505                	li	a0,1
 1007530:	8082                	ret

01007532 <HAL_UART_Transmit>:
 1007532:	4c6042ef          	jal	t0,100b9f8 <__riscv_save_4>
 1007536:	1141                	addi	sp,sp,-16
 1007538:	842a                	mv	s0,a0
 100753a:	89ae                	mv	s3,a1
 100753c:	84b2                	mv	s1,a2
 100753e:	8936                	mv	s2,a3
 1007540:	b33f80ef          	jal	1000072 <systick_get_value>
 1007544:	5418                	lw	a4,40(s0)
 1007546:	02000793          	li	a5,32
 100754a:	0cf71163          	bne	a4,a5,100760c <HAL_UART_Transmit+0xda>
 100754e:	8a2a                	mv	s4,a0
 1007550:	4505                	li	a0,1
 1007552:	08098d63          	beqz	s3,10075ec <HAL_UART_Transmit+0xba>
 1007556:	08048b63          	beqz	s1,10075ec <HAL_UART_Transmit+0xba>
 100755a:	02100793          	li	a5,33
 100755e:	d41c                	sw	a5,40(s0)
 1007560:	00941c23          	sh	s1,24(s0)
 1007564:	57fd                	li	a5,-1
 1007566:	04f91863          	bne	s2,a5,10075b6 <HAL_UART_Transmit+0x84>
 100756a:	4018                	lw	a4,0(s0)
 100756c:	00f48633          	add	a2,s1,a5
 1007570:	67c1                	lui	a5,0x10
 1007572:	3c06360b          	th.extu	a2,a2,15,0
 1007576:	17fd                	addi	a5,a5,-1 # ffff <Reset_Handler-0xff0001>
 1007578:	06f61d63          	bne	a2,a5,10075f2 <HAL_UART_Transmit+0xc0>
 100757c:	531c                	lw	a5,32(a4)
 100757e:	0407f793          	andi	a5,a5,64
 1007582:	dfed                	beqz	a5,100757c <HAL_UART_Transmit+0x4a>
 1007584:	a025                	j	10075ac <HAL_UART_Transmit+0x7a>
 1007586:	01845783          	lhu	a5,24(s0)
 100758a:	4018                	lw	a4,0(s0)
 100758c:	17fd                	addi	a5,a5,-1
 100758e:	3c07b78b          	th.extu	a5,a5,15,0
 1007592:	00f41c23          	sh	a5,24(s0)
 1007596:	9819c68b          	th.lbuia	a3,(s3),1,0
 100759a:	c354                	sw	a3,4(a4)
 100759c:	e79d                	bnez	a5,10075ca <HAL_UART_Transmit+0x98>
 100759e:	04000713          	li	a4,64
 10075a2:	86a2                	mv	a3,s0
 10075a4:	8552                	mv	a0,s4
 10075a6:	ad7f80ef          	jal	100007c <systick_poll_timeout>
 10075aa:	ed0d                	bnez	a0,10075e4 <HAL_UART_Transmit+0xb2>
 10075ac:	02000793          	li	a5,32
 10075b0:	d41c                	sw	a5,40(s0)
 10075b2:	4501                	li	a0,0
 10075b4:	a825                	j	10075ec <HAL_UART_Transmit+0xba>
 10075b6:	3e800793          	li	a5,1000
 10075ba:	02f90933          	mul	s2,s2,a5
 10075be:	01007637          	lui	a2,0x1007
 10075c2:	4b060613          	addi	a2,a2,1200 # 10074b0 <uart_flag_poll>
 10075c6:	02f955b3          	divu	a1,s2,a5
 10075ca:	40000713          	li	a4,1024
 10075ce:	86a2                	mv	a3,s0
 10075d0:	8552                	mv	a0,s4
 10075d2:	c62e                	sw	a1,12(sp)
 10075d4:	aa9f80ef          	jal	100007c <systick_poll_timeout>
 10075d8:	010077b7          	lui	a5,0x1007
 10075dc:	45b2                	lw	a1,12(sp)
 10075de:	4b078613          	addi	a2,a5,1200 # 10074b0 <uart_flag_poll>
 10075e2:	d155                	beqz	a0,1007586 <HAL_UART_Transmit+0x54>
 10075e4:	02000793          	li	a5,32
 10075e8:	d41c                	sw	a5,40(s0)
 10075ea:	4511                	li	a0,4
 10075ec:	0141                	addi	sp,sp,16
 10075ee:	43e0406f          	j	100ba2c <__riscv_restore_4>
 10075f2:	5314                	lw	a3,32(a4)
 10075f4:	2006f693          	andi	a3,a3,512
 10075f8:	deed                	beqz	a3,10075f2 <HAL_UART_Transmit+0xc0>
 10075fa:	00c41c23          	sh	a2,24(s0)
 10075fe:	9819c68b          	th.lbuia	a3,(s3),1,0
 1007602:	167d                	addi	a2,a2,-1
 1007604:	3c06360b          	th.extu	a2,a2,15,0
 1007608:	c354                	sw	a3,4(a4)
 100760a:	b7bd                	j	1007578 <HAL_UART_Transmit+0x46>
 100760c:	4509                	li	a0,2
 100760e:	bff9                	j	10075ec <HAL_UART_Transmit+0xba>

01007610 <HAL_UART_Receive>:
 1007610:	3e8042ef          	jal	t0,100b9f8 <__riscv_save_4>
 1007614:	842a                	mv	s0,a0
 1007616:	892e                	mv	s2,a1
 1007618:	89b2                	mv	s3,a2
 100761a:	84b6                	mv	s1,a3
 100761c:	a57f80ef          	jal	1000072 <systick_get_value>
 1007620:	5458                	lw	a4,44(s0)
 1007622:	02000793          	li	a5,32
 1007626:	08f71d63          	bne	a4,a5,10076c0 <HAL_UART_Receive+0xb0>
 100762a:	8a2a                	mv	s4,a0
 100762c:	4505                	li	a0,1
 100762e:	04090d63          	beqz	s2,1007688 <HAL_UART_Receive+0x78>
 1007632:	04098b63          	beqz	s3,1007688 <HAL_UART_Receive+0x78>
 1007636:	02200793          	li	a5,34
 100763a:	d45c                	sw	a5,44(s0)
 100763c:	03341223          	sh	s3,36(s0)
 1007640:	57fd                	li	a5,-1
 1007642:	06f48b63          	beq	s1,a5,10076b8 <HAL_UART_Receive+0xa8>
 1007646:	3e800793          	li	a5,1000
 100764a:	02f484b3          	mul	s1,s1,a5
 100764e:	6985                	lui	s3,0x1
 1007650:	01007ab7          	lui	s5,0x1007
 1007654:	80098993          	addi	s3,s3,-2048 # 800 <Reset_Handler-0xfff800>
 1007658:	4b0a8a93          	addi	s5,s5,1200 # 10074b0 <uart_flag_poll>
 100765c:	02f4d4b3          	divu	s1,s1,a5
 1007660:	02445783          	lhu	a5,36(s0)
 1007664:	e791                	bnez	a5,1007670 <HAL_UART_Receive+0x60>
 1007666:	02000793          	li	a5,32
 100766a:	d45c                	sw	a5,44(s0)
 100766c:	4501                	li	a0,0
 100766e:	a829                	j	1007688 <HAL_UART_Receive+0x78>
 1007670:	874e                	mv	a4,s3
 1007672:	86a2                	mv	a3,s0
 1007674:	8656                	mv	a2,s5
 1007676:	85a6                	mv	a1,s1
 1007678:	8552                	mv	a0,s4
 100767a:	a03f80ef          	jal	100007c <systick_poll_timeout>
 100767e:	c519                	beqz	a0,100768c <HAL_UART_Receive+0x7c>
 1007680:	02000793          	li	a5,32
 1007684:	d45c                	sw	a5,44(s0)
 1007686:	4511                	li	a0,4
 1007688:	3a40406f          	j	100ba2c <__riscv_restore_4>
 100768c:	02445783          	lhu	a5,36(s0)
 1007690:	17fd                	addi	a5,a5,-1
 1007692:	02f41223          	sh	a5,36(s0)
 1007696:	401c                	lw	a5,0(s0)
 1007698:	439c                	lw	a5,0(a5)
 100769a:	1819578b          	th.sbia	a5,(s2),1,0
 100769e:	b7c9                	j	1007660 <HAL_UART_Receive+0x50>
 10076a0:	4018                	lw	a4,0(s0)
 10076a2:	5314                	lw	a3,32(a4)
 10076a4:	01469613          	slli	a2,a3,0x14
 10076a8:	fe065ce3          	bgez	a2,10076a0 <HAL_UART_Receive+0x90>
 10076ac:	17fd                	addi	a5,a5,-1
 10076ae:	02f41223          	sh	a5,36(s0)
 10076b2:	431c                	lw	a5,0(a4)
 10076b4:	1819578b          	th.sbia	a5,(s2),1,0
 10076b8:	02445783          	lhu	a5,36(s0)
 10076bc:	d7cd                	beqz	a5,1007666 <HAL_UART_Receive+0x56>
 10076be:	b7cd                	j	10076a0 <HAL_UART_Receive+0x90>
 10076c0:	4509                	li	a0,2
 10076c2:	b7d9                	j	1007688 <HAL_UART_Receive+0x78>
 10076c4:	2f49                	jal	1007e56 <HAL_UART_AutoBaudRate_Detect_IT+0x8>
 10076c6:	4f4e                	lw	t5,208(sp)
 10076c8:	545f 4741 553a      	.insn	6, 0x553a4741545f
 10076ce:	5241                	li	tp,-16
 10076d0:	5f54                	lw	a3,60(a4)
 10076d2:	7254                	flw	fa3,36(a2)
 10076d4:	6e61                	lui	t3,0x18
 10076d6:	74696d73          	csrrsi	s10,0x746,18
 10076da:	625f 7375 0079      	.insn	6, 0x00797375625f
 10076e0:	2f49                	jal	1007e72 <HAL_IWDG_Init+0x6>
 10076e2:	4f4e                	lw	t5,208(sp)
 10076e4:	545f 4741 753a      	.insn	6, 0x753a4741545f
 10076ea:	7261                	lui	tp,0xffff8
 10076ec:	5f74                	lw	a3,124(a4)
 10076ee:	7872                	flw	fa6,60(sp)
 10076f0:	6f20                	flw	fs0,88(a4)
 10076f2:	6576                	flw	fa0,92(sp)
 10076f4:	7272                	flw	ft4,60(sp)
 10076f6:	6e75                	lui	t3,0x1d
 10076f8:	2121                	jal	1007b00 <HAL_UART_Receive+0x4f0>
 10076fa:	0021                	c.nop	8
 10076fc:	7325                	lui	t1,0xfffe9
 10076fe:	4900                	lw	s0,16(a0)
 1007700:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 1007704:	4154                	lw	a3,4(a0)
 1007706:	61553a47          	fmsub.s	fs4,fa0,fs5,fa2,rup
 100770a:	7472                	flw	fs0,60(sp)
 100770c:	4220                	lw	s0,64(a2)
 100770e:	2e746f6f          	jal	t5,104e1f4 <__boot_rom_data_lma__+0x426b4>
 1007712:	2e2e                	.insn	2, 0x2e2e
 1007714:	4900                	lw	s0,16(a0)
 1007716:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 100771a:	4154                	lw	a3,4(a0)
 100771c:	6f423a47          	.insn	4, 0x6f423a47
 1007720:	5520746f          	jal	s0,100ec72 <__boot_rom_data_lma__+0x3132>
 1007724:	7261                	lui	tp,0xffff8
 1007726:	2074                	.insn	2, 0x2074
 1007728:	6944                	flw	fs1,20(a0)
 100772a:	6c626173          	csrrsi	sp,0x6c6,4
 100772e:	2e65                	jal	1007ae6 <HAL_UART_Receive+0x4d6>
 1007730:	2e2e                	.insn	2, 0x2e2e
 1007732:	4900                	lw	s0,16(a0)
 1007734:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 1007738:	4154                	lw	a3,4(a0)
 100773a:	20093a47          	fmsub.s	fs4,fs2,ft0,ft4,rup
 100773e:	6574                	flw	fa3,76(a0)
 1007740:	775f7473          	csrrci	s0,0x775,30
 1007744:	2064726f          	jal	tp,104e94a <__boot_rom_data_lma__+0x42e0a>
 1007748:	6170                	flw	fa2,68(a0)
 100774a:	49007373          	csrrci	t1,0x490,0
 100774e:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 1007752:	4154                	lw	a3,4(a0)
 1007754:	20093a47          	fmsub.s	fs4,fs2,ft0,ft4,rup
 1007758:	6568                	flw	fa0,76(a0)
 100775a:	6461                	lui	s0,0x18
 100775c:	7265                	lui	tp,0xffff9
 100775e:	635f 6372 7020      	.insn	6, 0x70206372635f
 1007764:	7361                	lui	t1,0xffff8
 1007766:	2f490073          	.insn	4, 0x2f490073
 100776a:	4f4e                	lw	t5,208(sp)
 100776c:	545f 4741 093a      	.insn	6, 0x093a4741545f
 1007772:	7620                	flw	fs0,104(a2)
 1007774:	7265                	lui	tp,0xffff9
 1007776:	6e6f6973          	csrrsi	s2,0x6e6,30
 100777a:	7020                	flw	fs0,96(s0)
 100777c:	7361                	lui	t1,0xffff8
 100777e:	2f490073          	.insn	4, 0x2f490073
 1007782:	4f4e                	lw	t5,208(sp)
 1007784:	545f 4741 093a      	.insn	6, 0x093a4741545f
 100778a:	7320                	flw	fs0,96(a4)
 100778c:	6769                	lui	a4,0x1a
 100778e:	5f6e                	lw	t5,248(sp)
 1007790:	6576                	flw	fa0,92(sp)
 1007792:	6972                	flw	fs2,28(sp)
 1007794:	7966                	flw	fs2,120(sp)
 1007796:	7020                	flw	fs0,96(s0)
 1007798:	7361                	lui	t1,0xffff8
 100779a:	2f490073          	.insn	4, 0x2f490073
 100779e:	4f4e                	lw	t5,208(sp)
 10077a0:	545f 4741 663a      	.insn	6, 0x663a4741545f
 10077a6:	616c                	flw	fa1,68(a0)
 10077a8:	695f6873          	csrrsi	a6,0x695,30
 10077ac:	616d                	addi	sp,sp,240
 10077ae:	2d206567          	.insn	4, 0x2d206567
 10077b2:	652d                	lui	a0,0xb
 10077b4:	6578                	flw	fa4,76(a0)
 10077b6:	615f 6464 3a72      	.insn	6, 0x3a726464615f
 10077bc:	7830                	flw	fa2,112(s0)
 10077be:	7825                	lui	a6,0xfffe9
 10077c0:	4900                	lw	s0,16(a0)
 10077c2:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 10077c6:	4154                	lw	a3,4(a0)
 10077c8:	656b3a47          	.insn	4, 0x656b3a47
 10077cc:	5f79                	li	t5,-2
 10077ce:	6564                	flw	fs1,76(a0)
 10077d0:	6972                	flw	fs2,28(sp)
 10077d2:	6576                	flw	fa0,92(sp)
 10077d4:	2d20                	.insn	2, 0x2d20
 10077d6:	612d                	addi	sp,sp,224
 10077d8:	676c                	flw	fa1,76(a4)
 10077da:	64253a6f          	jal	s4,105ae1c <__boot_rom_data_lma__+0x4f2dc>
 10077de:	2d20                	.insn	2, 0x2d20
 10077e0:	692d                	lui	s2,0xb
 10077e2:	3a64                	.insn	2, 0x3a64
 10077e4:	6425                	lui	s0,0x9
 10077e6:	4900                	lw	s0,16(a0)
 10077e8:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 10077ec:	4154                	lw	a3,4(a0)
 10077ee:	6c463a47          	.insn	4, 0x6c463a47
 10077f2:	7361                	lui	t1,0xffff8
 10077f4:	2068                	.insn	2, 0x2068
 10077f6:	6f42                	flw	ft10,16(sp)
 10077f8:	2e2e746f          	jal	s0,10eeada <__boot_rom_data_lma__+0xe2f9a>
 10077fc:	002e                	c.slli	zero,0xb
 10077fe:	2f49                	jal	1007f90 <HAL_OTBN_CMD_Write_Polling+0x20>
 1007800:	4f4e                	lw	t5,208(sp)
 1007802:	545f 4741 463a      	.insn	6, 0x463a4741545f
 1007808:	616c                	flw	fa1,68(a0)
 100780a:	42206873          	csrrsi	a6,0x422,0
 100780e:	20746f6f          	jal	t5,104e214 <__boot_rom_data_lma__+0x426d4>
 1007812:	6166                	flw	ft2,88(sp)
 1007814:	6c69                	lui	s8,0x1a
 1007816:	2e2e                	.insn	2, 0x2e2e
 1007818:	002e                	c.slli	zero,0xb
 100781a:	2f49                	jal	1007fac <HAL_OTBN_IRQHandler+0x4>
 100781c:	4f4e                	lw	t5,208(sp)
 100781e:	545f 4741 463a      	.insn	6, 0x463a4741545f
 1007824:	616c                	flw	fa1,68(a0)
 1007826:	42206873          	csrrsi	a6,0x422,0
 100782a:	20746f6f          	jal	t5,104e230 <__boot_rom_data_lma__+0x426f0>
 100782e:	6552                	flw	fa0,20(sp)
 1007830:	7274                	flw	fa3,100(a2)
 1007832:	2e79                	jal	1007bd0 <HAL_UART_Transmit_IT+0x68>
 1007834:	2e2e                	.insn	2, 0x2e2e
 1007836:	4900                	lw	s0,16(a0)
 1007838:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 100783c:	4154                	lw	a3,4(a0)
 100783e:	4f423a47          	.insn	4, 0x4f423a47
 1007842:	2d20544f          	.insn	4, 0x2d20544f
 1007846:	6c66                	flw	fs8,88(sp)
 1007848:	253a776f          	jal	a4,10af29a <__boot_rom_data_lma__+0xa375a>
 100784c:	2064                	.insn	2, 0x2064
 100784e:	6e2d                	lui	t3,0xb
 1007850:	616d726f          	jal	tp,10dee66 <__boot_rom_data_lma__+0xd3326>
 1007854:	5f6c                	lw	a1,124(a4)
 1007856:	6f6d                	lui	t5,0x1b
 1007858:	6564                	flw	fs1,76(a0)
 100785a:	253a                	.insn	2, 0x253a
 100785c:	2064                	.insn	2, 0x2064
 100785e:	732d                	lui	t1,0xfffeb
 1007860:	6365                	lui	t1,0x19
 1007862:	7275                	lui	tp,0xffffd
 1007864:	5f65                	li	t5,-7
 1007866:	6f6d                	lui	t5,0x1b
 1007868:	6564                	flw	fs1,76(a0)
 100786a:	253a                	.insn	2, 0x253a
 100786c:	0064                	addi	s1,sp,12
 100786e:	2f49                	jal	1008000 <otp_single_wirte+0x2c>
 1007870:	4f4e                	lw	t5,208(sp)
 1007872:	545f 4741 563a      	.insn	6, 0x563a4741545f
 1007878:	7265                	lui	tp,0xffff9
 100787a:	6669                	lui	a2,0x1a
 100787c:	4679                	li	a2,30
 100787e:	6f6c                	flw	fa1,92(a4)
 1007880:	72652077          	.insn	4, 0x72652077
 1007884:	6f72                	flw	ft10,28(sp)
 1007886:	5f72                	lw	t5,60(sp)
 1007888:	65646f63          	bltu	s0,s6,1007ee6 <HAL_OTBN_DMEM_Set+0x28>
 100788c:	253a                	.insn	2, 0x253a
 100788e:	0064                	addi	s1,sp,12
 1007890:	2f49                	jal	1008022 <otp_single_wirte+0x4e>
 1007892:	4f4e                	lw	t5,208(sp)
 1007894:	545f 4741 443a      	.insn	6, 0x443a4741545f
 100789a:	6365                	lui	t1,0x19
 100789c:	7972                	flw	fs2,60(sp)
 100789e:	7470                	flw	fa2,108(s0)
 10078a0:	6c46                	flw	fs8,80(sp)
 10078a2:	6520776f          	jal	a4,100eef4 <__boot_rom_data_lma__+0x33b4>
 10078a6:	7272                	flw	ft4,60(sp)
 10078a8:	635f726f          	jal	tp,10ff6dc <__boot_rom_data_lma__+0xf3b9c>
 10078ac:	3a65646f          	jal	s0,105dc52 <__boot_rom_data_lma__+0x52112>
 10078b0:	6425                	lui	s0,0x9
 10078b2:	4900                	lw	s0,16(a0)
 10078b4:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 10078b8:	4154                	lw	a3,4(a0)
 10078ba:	6f4e3a47          	.insn	4, 0x6f4e3a47
 10078be:	736e                	flw	ft6,248(sp)
 10078c0:	6365                	lui	t1,0x19
 10078c2:	7275                	lui	tp,0xffffd
 10078c4:	2065                	jal	100796c <HAL_UART_Receive+0x35c>
 10078c6:	7265                	lui	tp,0xffff9
 10078c8:	6f72                	flw	ft10,28(sp)
 10078ca:	5f72                	lw	t5,60(sp)
 10078cc:	65646f63          	bltu	s0,s6,1007f2a <HAL_OTBN_DMEM_Write+0x32>
 10078d0:	253a                	.insn	2, 0x253a
 10078d2:	0064                	addi	s1,sp,12
 10078d4:	2f49                	jal	1008066 <otp_single_wirte+0x92>
 10078d6:	4f4e                	lw	t5,208(sp)
 10078d8:	545f 4741 473a      	.insn	6, 0x473a4741545f
 10078de:	206f546f          	jal	s0,10fcae4 <__boot_rom_data_lma__+0xf0fa4>
 10078e2:	654e                	flw	fa0,208(sp)
 10078e4:	7478                	flw	fa4,108(s0)
 10078e6:	4120                	lw	s0,64(a0)
 10078e8:	6464                	flw	fs1,76(s0)
 10078ea:	2072                	.insn	2, 0x2072
 10078ec:	203a                	.insn	2, 0x203a
 10078ee:	7830                	flw	fa2,112(s0)
 10078f0:	7825                	lui	a6,0xfffe9
 10078f2:	4900                	lw	s0,16(a0)
 10078f4:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 10078f8:	4154                	lw	a3,4(a0)
 10078fa:	45533a47          	.insn	4, 0x45533a47
 10078fe:	57495f43          	.insn	4, 0x57495f43
 1007902:	4744                	lw	s1,12(a4)
 1007904:	4f20                	lw	s0,88(a4)
 1007906:	6570                	flw	fa2,76(a0)
 1007908:	2c6e                	.insn	2, 0x2c6e
 100790a:	7420                	flw	fs0,104(s0)
 100790c:	6d69                	lui	s10,0x1a
 100790e:	2065                	jal	10079b6 <HAL_UART_Receive+0x3a6>
 1007910:	203a                	.insn	2, 0x203a
 1007912:	6425                	lui	s0,0x9
 1007914:	4900                	lw	s0,16(a0)
 1007916:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 100791a:	4154                	lw	a3,4(a0)
 100791c:	696c3a47          	fmsub.s	fs4,fs8,fs6,fa3,rup
 1007920:	6566                	flw	fa0,88(sp)
 1007922:	635f 6379 656c      	.insn	6, 0x656c6379635f
 1007928:	755f 6470 7461      	.insn	6, 0x74616470755f
 100792e:	2065                	jal	10079d6 <HAL_UART_Receive+0x3c6>
 1007930:	7865                	lui	a6,0xffff9
 1007932:	6570                	flw	fa2,76(a0)
 1007934:	73207463          	bgeu	zero,s2,100805c <otp_single_wirte+0x88>
 1007938:	6174                	flw	fa3,68(a0)
 100793a:	7574                	flw	fa3,108(a0)
 100793c:	203a2073          	csrs	0x203,s4
 1007940:	6425                	lui	s0,0x9
 1007942:	4900                	lw	s0,16(a0)
 1007944:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 1007948:	4154                	lw	a3,4(a0)
 100794a:	75433a47          	.insn	4, 0x75433a47
 100794e:	7272                	flw	ft4,60(sp)
 1007950:	6e65                	lui	t3,0x19
 1007952:	2074                	.insn	2, 0x2074
 1007954:	696c                	flw	fa1,84(a0)
 1007956:	6566                	flw	fa0,88(sp)
 1007958:	6320                	flw	fs0,64(a4)
 100795a:	6379                	lui	t1,0x1e
 100795c:	656c                	flw	fa1,76(a0)
 100795e:	3a20                	.insn	2, 0x3a20
 1007960:	3020                	.insn	2, 0x3020
 1007962:	2578                	.insn	2, 0x2578
 1007964:	0078                	addi	a4,sp,12
 1007966:	2f49                	jal	10080f8 <HAL_OTP_Read+0x3a>
 1007968:	4f4e                	lw	t5,208(sp)
 100796a:	545f 4741 4f3a      	.insn	6, 0x4f3a4741545f
 1007970:	7074                	flw	fa3,100(s0)
 1007972:	4320                	lw	s0,64(a4)
 1007974:	2065646f          	jal	s0,105db7a <__boot_rom_data_lma__+0x5203a>
 1007978:	20435243          	fmadd.s	ft4,ft6,ft4,ft4,unknown
 100797c:	6552                	flw	fa0,20(sp)
 100797e:	746c7573          	csrrci	a0,0x746,24
 1007982:	3a20                	.insn	2, 0x3a20
 1007984:	2520                	.insn	2, 0x2520
 1007986:	0064                	addi	s1,sp,12
 1007988:	2f49                	jal	100811a <HAL_OTP_Read+0x5c>
 100798a:	4f4e                	lw	t5,208(sp)
 100798c:	545f 4741 4f3a      	.insn	6, 0x4f3a4741545f
 1007992:	5054                	lw	a3,36(s0)
 1007994:	4320                	lw	s0,64(a4)
 1007996:	4746                	lw	a4,80(sp)
 1007998:	445f 5441 3a41      	.insn	6, 0x3a415441445f
 100799e:	4900                	lw	s0,16(a0)
 10079a0:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 10079a4:	4154                	lw	a3,4(a0)
 10079a6:	78303a47          	fmsub.s	fs4,ft0,ft3,fa5,rup
 10079aa:	3025                	jal	10071d2 <hal_flash_read_unique_id+0x8>
 10079ac:	7832                	flw	fa6,44(sp)
 10079ae:	093a                	slli	s2,s2,0xe
 10079b0:	7830                	flw	fa2,112(s0)
 10079b2:	3025                	jal	10071da <hal_flash_read_unique_id+0x10>
 10079b4:	7838                	flw	fa4,112(s0)
 10079b6:	3009                	jal	10071b8 <hal_flash_release_from_deep_power_down+0x4>
 10079b8:	2578                	.insn	2, 0x2578
 10079ba:	3830                	.insn	2, 0x3830
 10079bc:	0978                	addi	a4,sp,156
 10079be:	7830                	flw	fa2,112(s0)
 10079c0:	3025                	jal	10071e8 <hal_flash_read_unique_id+0x1e>
 10079c2:	7838                	flw	fa4,112(s0)
 10079c4:	3009                	jal	10071c6 <do_hal_flash_read_reg_func+0xa>
 10079c6:	2578                	.insn	2, 0x2578
 10079c8:	3830                	.insn	2, 0x3830
 10079ca:	0078                	addi	a4,sp,12
 10079cc:	2f49                	jal	100815e <HAL_OTP_Read+0xa0>
 10079ce:	4f4e                	lw	t5,208(sp)
 10079d0:	545f 4741 663a      	.insn	6, 0x663a4741545f
 10079d6:	616c                	flw	fa1,68(a0)
 10079d8:	78206873          	csrrsi	a6,0x782,0
 10079dc:	7069                	c.lui	zero,0xffffa
 10079de:	7220                	flw	fs0,96(a2)
 10079e0:	7365                	lui	t1,0xffff9
 10079e2:	7465                	lui	s0,0xffff9
 10079e4:	2e2e                	.insn	2, 0x2e2e
 10079e6:	002e                	c.slli	zero,0xb
 10079e8:	2f49                	jal	100817a <HAL_OTP_Read+0xbc>
 10079ea:	4f4e                	lw	t5,208(sp)
 10079ec:	545f 4741 663a      	.insn	6, 0x663a4741545f
 10079f2:	616c                	flw	fa1,68(a0)
 10079f4:	72206873          	csrrsi	a6,minstretcfgh,0
 10079f8:	7365                	lui	t1,0xffff9
 10079fa:	7465                	lui	s0,0xffff9
 10079fc:	2e2e                	.insn	2, 0x2e2e
 10079fe:	002e                	c.slli	zero,0xb
 1007a00:	2f49                	jal	1008192 <HAL_OTP_Read+0xd4>
 1007a02:	4f4e                	lw	t5,208(sp)
 1007a04:	545f 4741 433a      	.insn	6, 0x433a4741545f
 1007a0a:	5952                	lw	s2,52(sp)
 1007a0c:	5450                	lw	a2,44(s0)
 1007a0e:	495f 2050 4d53      	.insn	6, 0x4d532050495f
 1007a14:	2034                	.insn	2, 0x2034
 1007a16:	666c6573          	csrrsi	a0,0x666,24
 1007a1a:	7420                	flw	fs0,104(s0)
 1007a1c:	7365                	lui	t1,0xffff9
 1007a1e:	2074                	.insn	2, 0x2074
 1007a20:	6166                	flw	ft2,88(sp)
 1007a22:	6c69                	lui	s8,0x1a
 1007a24:	2e2e                	.insn	2, 0x2e2e
 1007a26:	002e                	c.slli	zero,0xb
 1007a28:	2f49                	jal	10081ba <HAL_OTP_Read+0xfc>
 1007a2a:	4f4e                	lw	t5,208(sp)
 1007a2c:	545f 4741 433a      	.insn	6, 0x433a4741545f
 1007a32:	5952                	lw	s2,52(sp)
 1007a34:	5450                	lw	a2,44(s0)
 1007a36:	495f 2050 4d53      	.insn	6, 0x4d532050495f
 1007a3c:	2034                	.insn	2, 0x2034
 1007a3e:	666c6573          	csrrsi	a0,0x666,24
 1007a42:	7420                	flw	fs0,104(s0)
 1007a44:	7365                	lui	t1,0xffff9
 1007a46:	2074                	.insn	2, 0x2074
 1007a48:	6564                	flw	fs1,76(a0)
 1007a4a:	70797263          	bgeu	s2,t2,100814e <HAL_OTP_Read+0x90>
 1007a4e:	2074                	.insn	2, 0x2074
 1007a50:	6166                	flw	ft2,88(sp)
 1007a52:	6c69                	lui	s8,0x1a
 1007a54:	2e2e                	.insn	2, 0x2e2e
 1007a56:	002e                	c.slli	zero,0xb
 1007a58:	2f49                	jal	10081ea <otp_block_write+0x1c>
 1007a5a:	4f4e                	lw	t5,208(sp)
 1007a5c:	545f 4741 433a      	.insn	6, 0x433a4741545f
 1007a62:	5952                	lw	s2,52(sp)
 1007a64:	5450                	lw	a2,44(s0)
 1007a66:	495f 2050 5243      	.insn	6, 0x52432050495f
 1007a6c:	65732043          	.insn	4, 0x65732043
 1007a70:	666c                	flw	fa1,76(a2)
 1007a72:	7420                	flw	fs0,104(s0)
 1007a74:	7365                	lui	t1,0xffff9
 1007a76:	2074                	.insn	2, 0x2074
 1007a78:	6166                	flw	ft2,88(sp)
 1007a7a:	6c69                	lui	s8,0x1a
 1007a7c:	2e2e                	.insn	2, 0x2e2e
 1007a7e:	002e                	c.slli	zero,0xb
 1007a80:	2f49                	jal	1008212 <otp_block_write+0x44>
 1007a82:	4f4e                	lw	t5,208(sp)
 1007a84:	545f 4741 433a      	.insn	6, 0x433a4741545f
 1007a8a:	5952                	lw	s2,52(sp)
 1007a8c:	5450                	lw	a2,44(s0)
 1007a8e:	495f 2050 4853      	.insn	6, 0x48532050495f
 1007a94:	3241                	jal	1007414 <flash_writing_critical+0x30>
 1007a96:	3635                	jal	10075c2 <HAL_UART_Transmit+0x90>
 1007a98:	7320                	flw	fs0,96(a4)
 1007a9a:	6c65                	lui	s8,0x19
 1007a9c:	2066                	.insn	2, 0x2066
 1007a9e:	6574                	flw	fa3,76(a0)
 1007aa0:	66207473          	csrrci	s0,0x662,0
 1007aa4:	6961                	lui	s2,0x18
 1007aa6:	2e6c                	.insn	2, 0x2e6c
 1007aa8:	2e2e                	.insn	2, 0x2e2e
 1007aaa:	4900                	lw	s0,16(a0)
 1007aac:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 1007ab0:	4154                	lw	a3,4(a0)
 1007ab2:	52433a47          	.insn	4, 0x52433a47
 1007ab6:	5059                	c.li	zero,-10
 1007ab8:	5f54                	lw	a3,60(a4)
 1007aba:	5049                	c.li	zero,-14
 1007abc:	4120                	lw	s0,64(a0)
 1007abe:	5345                	li	t1,-15
 1007ac0:	7320                	flw	fs0,96(a4)
 1007ac2:	6c65                	lui	s8,0x19
 1007ac4:	2066                	.insn	2, 0x2066
 1007ac6:	6574                	flw	fa3,76(a0)
 1007ac8:	66207473          	csrrci	s0,0x662,0
 1007acc:	6961                	lui	s2,0x18
 1007ace:	2e6c                	.insn	2, 0x2e6c
 1007ad0:	2e2e                	.insn	2, 0x2e2e
 1007ad2:	4900                	lw	s0,16(a0)
 1007ad4:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 1007ad8:	4154                	lw	a3,4(a0)
 1007ada:	52433a47          	.insn	4, 0x52433a47
 1007ade:	5059                	c.li	zero,-10
 1007ae0:	5f54                	lw	a3,60(a4)
 1007ae2:	5049                	c.li	zero,-14
 1007ae4:	5320                	lw	s0,96(a4)
 1007ae6:	324d                	jal	1007488 <lscache_cache_enable+0x8>
 1007ae8:	6520                	flw	fs0,72(a0)
 1007aea:	636e                	flw	ft6,216(sp)
 1007aec:	7972                	flw	fs2,60(sp)
 1007aee:	7470                	flw	fa2,108(s0)
 1007af0:	6620                	flw	fs0,72(a2)
 1007af2:	6961                	lui	s2,0x18
 1007af4:	2e6c                	.insn	2, 0x2e6c
 1007af6:	2e2e                	.insn	2, 0x2e2e
 1007af8:	4900                	lw	s0,16(a0)
 1007afa:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 1007afe:	4154                	lw	a3,4(a0)
 1007b00:	52433a47          	.insn	4, 0x52433a47
 1007b04:	5059                	c.li	zero,-10
 1007b06:	5f54                	lw	a3,60(a4)
 1007b08:	5049                	c.li	zero,-14
 1007b0a:	5320                	lw	s0,96(a4)
 1007b0c:	324d                	jal	10074ae <lscache_cache_enable+0x2e>
 1007b0e:	6420                	flw	fs0,72(s0)
 1007b10:	6365                	lui	t1,0x19
 1007b12:	7972                	flw	fs2,60(sp)
 1007b14:	7470                	flw	fa2,108(s0)
 1007b16:	6620                	flw	fs0,72(a2)
 1007b18:	6961                	lui	s2,0x18
 1007b1a:	2e6c                	.insn	2, 0x2e6c
 1007b1c:	2e2e                	.insn	2, 0x2e2e
 1007b1e:	4900                	lw	s0,16(a0)
 1007b20:	5f4f4e2f          	.insn	4, 0x5f4f4e2f
 1007b24:	4154                	lw	a3,4(a0)
 1007b26:	52433a47          	.insn	4, 0x52433a47
 1007b2a:	5059                	c.li	zero,-10
 1007b2c:	5f54                	lw	a3,60(a4)
 1007b2e:	5049                	c.li	zero,-14
 1007b30:	5320                	lw	s0,96(a4)
 1007b32:	324d                	jal	10074d4 <UART_AutoBaudRate_Detect_Start.isra.0+0x12>
 1007b34:	7320                	flw	fs0,96(a4)
 1007b36:	6769                	lui	a4,0x1a
 1007b38:	206e                	.insn	2, 0x206e
 1007b3a:	6166                	flw	ft2,88(sp)
 1007b3c:	6c69                	lui	s8,0x1a
 1007b3e:	2e2e                	.insn	2, 0x2e2e
 1007b40:	002e                	c.slli	zero,0xb
 1007b42:	2f49                	jal	10082d4 <uart_log_init+0x14>
 1007b44:	4f4e                	lw	t5,208(sp)
 1007b46:	545f 4741 433a      	.insn	6, 0x433a4741545f
 1007b4c:	5952                	lw	s2,52(sp)
 1007b4e:	5450                	lw	a2,44(s0)
 1007b50:	495f 2050 4d53      	.insn	6, 0x4d532050495f
 1007b56:	2032                	.insn	2, 0x2032
 1007b58:	6576                	flw	fa0,92(sp)
 1007b5a:	6972                	flw	fs2,28(sp)
 1007b5c:	7966                	flw	fs2,120(sp)
 1007b5e:	6620                	flw	fs0,72(a2)
 1007b60:	6961                	lui	s2,0x18
 1007b62:	2e6c                	.insn	2, 0x2e6c
 1007b64:	2e2e                	.insn	2, 0x2e2e
 1007b66:	0000                	unimp

01007b68 <HAL_UART_Transmit_IT>:
 1007b68:	5514                	lw	a3,40(a0)
 1007b6a:	02000793          	li	a5,32
 1007b6e:	04f69363          	bne	a3,a5,1007bb4 <HAL_UART_Transmit_IT+0x4c>
 1007b72:	872a                	mv	a4,a0
 1007b74:	4505                	li	a0,1
 1007b76:	c1a5                	beqz	a1,1007bd6 <HAL_UART_Transmit_IT+0x6e>
 1007b78:	04060f63          	beqz	a2,1007bd6 <HAL_UART_Transmit_IT+0x6e>
 1007b7c:	431c                	lw	a5,0(a4)
 1007b7e:	757d                	lui	a0,0xfffff
 1007b80:	7ff50513          	addi	a0,a0,2047 # fffff7ff <bitmap+0xefebf87f>
 1007b84:	4b94                	lw	a3,16(a5)
 1007b86:	167d                	addi	a2,a2,-1 # 19fff <Reset_Handler-0xfe6001>
 1007b88:	8ee9                	and	a3,a3,a0
 1007b8a:	cb94                	sw	a3,16(a5)
 1007b8c:	02100693          	li	a3,33
 1007b90:	d714                	sw	a3,40(a4)
 1007b92:	4fd4                	lw	a3,28(a5)
 1007b94:	4501                	li	a0,0
 1007b96:	f3f6f693          	andi	a3,a3,-193
 1007b9a:	cfd4                	sw	a3,28(a5)
 1007b9c:	4689                	li	a3,2
 1007b9e:	df94                	sw	a3,56(a5)
 1007ba0:	00c71c23          	sh	a2,24(a4) # 1a018 <Reset_Handler-0xfe5fe8>
 1007ba4:	00158613          	addi	a2,a1,1 # 300001 <Reset_Handler-0xcfffff>
 1007ba8:	cb50                	sw	a2,20(a4)
 1007baa:	0005c703          	lbu	a4,0(a1)
 1007bae:	c3d8                	sw	a4,4(a5)
 1007bb0:	d3d4                	sw	a3,36(a5)
 1007bb2:	8082                	ret
 1007bb4:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1007bb8:	cf91                	beqz	a5,1007bd4 <HAL_UART_Transmit_IT+0x6c>
 1007bba:	659032ef          	jal	t0,100ba12 <__riscv_save_0>
 1007bbe:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1007bc2:	010075b7          	lui	a1,0x1007
 1007bc6:	6c458593          	addi	a1,a1,1732 # 10076c4 <HAL_UART_Receive+0xb4>
 1007bca:	4505                	li	a0,1
 1007bcc:	9782                	jalr	a5
 1007bce:	4509                	li	a0,2
 1007bd0:	6670306f          	j	100ba36 <__riscv_restore_0>
 1007bd4:	4509                	li	a0,2
 1007bd6:	8082                	ret

01007bd8 <HAL_UART_Receive_IT>:
 1007bd8:	5554                	lw	a3,44(a0)
 1007bda:	02000793          	li	a5,32
 1007bde:	872a                	mv	a4,a0
 1007be0:	04f69463          	bne	a3,a5,1007c28 <HAL_UART_Receive_IT+0x50>
 1007be4:	4505                	li	a0,1
 1007be6:	c1b1                	beqz	a1,1007c2a <HAL_UART_Receive_IT+0x52>
 1007be8:	04060163          	beqz	a2,1007c2a <HAL_UART_Receive_IT+0x52>
 1007bec:	431c                	lw	a5,0(a4)
 1007bee:	757d                	lui	a0,0xfffff
 1007bf0:	7ff50513          	addi	a0,a0,2047 # fffff7ff <bitmap+0xefebf87f>
 1007bf4:	4b94                	lw	a3,16(a5)
 1007bf6:	8ee9                	and	a3,a3,a0
 1007bf8:	cb94                	sw	a3,16(a5)
 1007bfa:	02200693          	li	a3,34
 1007bfe:	d30c                	sw	a1,32(a4)
 1007c00:	02c71223          	sh	a2,36(a4)
 1007c04:	d754                	sw	a3,44(a4)
 1007c06:	471d                	li	a4,7
 1007c08:	00c76a63          	bltu	a4,a2,1007c1c <HAL_UART_Receive_IT+0x44>
 1007c0c:	4fd8                	lw	a4,28(a5)
 1007c0e:	fcf77713          	andi	a4,a4,-49
 1007c12:	cfd8                	sw	a4,28(a5)
 1007c14:	4705                	li	a4,1
 1007c16:	d3d8                	sw	a4,36(a5)
 1007c18:	4501                	li	a0,0
 1007c1a:	8082                	ret
 1007c1c:	4fd8                	lw	a4,28(a5)
 1007c1e:	fcf77713          	andi	a4,a4,-49
 1007c22:	02076713          	ori	a4,a4,32
 1007c26:	b7f5                	j	1007c12 <HAL_UART_Receive_IT+0x3a>
 1007c28:	4509                	li	a0,2
 1007c2a:	8082                	ret

01007c2c <HAL_UART_RxToIdleCpltCallback>:
 1007c2c:	8082                	ret

01007c2e <UART_Transmit_IT_DMA>:
 1007c2e:	8082                	ret

01007c30 <HAL_UARTx_IRQHandler>:
 1007c30:	5e3032ef          	jal	t0,100ba12 <__riscv_save_0>
 1007c34:	411c                	lw	a5,0(a0)
 1007c36:	842a                	mv	s0,a0
 1007c38:	0347a903          	lw	s2,52(a5)
 1007c3c:	5384                	lw	s1,32(a5)
 1007c3e:	4b94                	lw	a3,16(a5)
 1007c40:	00297713          	andi	a4,s2,2
 1007c44:	01469613          	slli	a2,a3,0x14
 1007c48:	0a065363          	bgez	a2,1007cee <HAL_UARTx_IRQHandler+0xbe>
 1007c4c:	00070563          	beqz	a4,1007c56 <HAL_UARTx_IRQHandler+0x26>
 1007c50:	4709                	li	a4,2
 1007c52:	df98                	sw	a4,56(a5)
 1007c54:	3fe9                	jal	1007c2e <UART_Transmit_IT_DMA>
 1007c56:	00197793          	andi	a5,s2,1
 1007c5a:	cb95                	beqz	a5,1007c8e <HAL_UARTx_IRQHandler+0x5e>
 1007c5c:	4018                	lw	a4,0(s0)
 1007c5e:	4685                	li	a3,1
 1007c60:	5b1c                	lw	a5,48(a4)
 1007c62:	0407f793          	andi	a5,a5,64
 1007c66:	cfe9                	beqz	a5,1007d40 <HAL_UARTx_IRQHandler+0x110>
 1007c68:	d714                	sw	a3,40(a4)
 1007c6a:	04000793          	li	a5,64
 1007c6e:	df1c                	sw	a5,56(a4)
 1007c70:	4b1c                	lw	a5,16(a4)
 1007c72:	76fd                	lui	a3,0xfffff
 1007c74:	16fd                	addi	a3,a3,-1 # ffffefff <bitmap+0xefebf07f>
 1007c76:	8ff5                	and	a5,a5,a3
 1007c78:	cb1c                	sw	a5,16(a4)
 1007c7a:	475c                	lw	a5,12(a4)
 1007c7c:	8522                	mv	a0,s0
 1007c7e:	f7f7f793          	andi	a5,a5,-129
 1007c82:	c75c                	sw	a5,12(a4)
 1007c84:	430c                	lw	a1,0(a4)
 1007c86:	0ff5f593          	zext.b	a1,a1
 1007c8a:	325020ef          	jal	100a7ae <HAL_UART_BaudRateDetectCpltCallback>
 1007c8e:	01097913          	andi	s2,s2,16
 1007c92:	02090f63          	beqz	s2,1007cd0 <HAL_UARTx_IRQHandler+0xa0>
 1007c96:	401c                	lw	a5,0(s0)
 1007c98:	5454                	lw	a3,44(s0)
 1007c9a:	4741                	li	a4,16
 1007c9c:	df98                	sw	a4,56(a5)
 1007c9e:	02200713          	li	a4,34
 1007ca2:	02e69763          	bne	a3,a4,1007cd0 <HAL_UARTx_IRQHandler+0xa0>
 1007ca6:	4fdc                	lw	a5,28(a5)
 1007ca8:	3087b78b          	th.extu	a5,a5,12,8
 1007cac:	4018                	lw	a4,0(s0)
 1007cae:	18079063          	bnez	a5,1007e2e <HAL_UARTx_IRQHandler+0x1fe>
 1007cb2:	4f5c                	lw	a5,28(a4)
 1007cb4:	02445583          	lhu	a1,36(s0) # ffff9024 <bitmap+0xefeb90a4>
 1007cb8:	8522                	mv	a0,s0
 1007cba:	fcf7f793          	andi	a5,a5,-49
 1007cbe:	0207e793          	ori	a5,a5,32
 1007cc2:	cf5c                	sw	a5,28(a4)
 1007cc4:	02000793          	li	a5,32
 1007cc8:	d45c                	sw	a5,44(s0)
 1007cca:	47c5                	li	a5,17
 1007ccc:	d71c                	sw	a5,40(a4)
 1007cce:	3fb9                	jal	1007c2c <HAL_UART_RxToIdleCpltCallback>
 1007cd0:	8889                	andi	s1,s1,2
 1007cd2:	cc81                	beqz	s1,1007cea <HAL_UARTx_IRQHandler+0xba>
 1007cd4:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1007cd8:	cb89                	beqz	a5,1007cea <HAL_UARTx_IRQHandler+0xba>
 1007cda:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1007cde:	010075b7          	lui	a1,0x1007
 1007ce2:	6e058593          	addi	a1,a1,1760 # 10076e0 <HAL_UART_Receive+0xd0>
 1007ce6:	4505                	li	a0,1
 1007ce8:	9782                	jalr	a5
 1007cea:	54d0306f          	j	100ba36 <__riscv_restore_0>
 1007cee:	d725                	beqz	a4,1007c56 <HAL_UARTx_IRQHandler+0x26>
 1007cf0:	5510                	lw	a2,40(a0)
 1007cf2:	4709                	li	a4,2
 1007cf4:	df98                	sw	a4,56(a5)
 1007cf6:	02100693          	li	a3,33
 1007cfa:	f4d61ee3          	bne	a2,a3,1007c56 <HAL_UARTx_IRQHandler+0x26>
 1007cfe:	4fd4                	lw	a3,28(a5)
 1007d00:	00d6d613          	srli	a2,a3,0xd
 1007d04:	8a7d                	andi	a2,a2,31
 1007d06:	fa21                	bnez	a2,1007c56 <HAL_UARTx_IRQHandler+0x26>
 1007d08:	01855683          	lhu	a3,24(a0)
 1007d0c:	e68d                	bnez	a3,1007d36 <HAL_UARTx_IRQHandler+0x106>
 1007d0e:	d798                	sw	a4,40(a5)
 1007d10:	02000793          	li	a5,32
 1007d14:	d51c                	sw	a5,40(a0)
 1007d16:	29d020ef          	jal	100a7b2 <HAL_UART_TxCpltCallback>
 1007d1a:	bf35                	j	1007c56 <HAL_UARTx_IRQHandler+0x26>
 1007d1c:	01845703          	lhu	a4,24(s0)
 1007d20:	db1d                	beqz	a4,1007c56 <HAL_UARTx_IRQHandler+0x26>
 1007d22:	177d                	addi	a4,a4,-1
 1007d24:	00e41c23          	sh	a4,24(s0)
 1007d28:	4858                	lw	a4,20(s0)
 1007d2a:	00170693          	addi	a3,a4,1
 1007d2e:	c854                	sw	a3,20(s0)
 1007d30:	00074703          	lbu	a4,0(a4)
 1007d34:	c3d8                	sw	a4,4(a5)
 1007d36:	5398                	lw	a4,32(a5)
 1007d38:	20077713          	andi	a4,a4,512
 1007d3c:	f365                	bnez	a4,1007d1c <HAL_UARTx_IRQHandler+0xec>
 1007d3e:	bf21                	j	1007c56 <HAL_UARTx_IRQHandler+0x26>
 1007d40:	5450                	lw	a2,44(s0)
 1007d42:	df14                	sw	a3,56(a4)
 1007d44:	02200793          	li	a5,34
 1007d48:	f4f613e3          	bne	a2,a5,1007c8e <HAL_UARTx_IRQHandler+0x5e>
 1007d4c:	4f5c                	lw	a5,28(a4)
 1007d4e:	4758                	lw	a4,12(a4)
 1007d50:	459d                	li	a1,7
 1007d52:	3087b78b          	th.extu	a5,a5,12,8
 1007d56:	10077713          	andi	a4,a4,256
 1007d5a:	461d                	li	a2,7
 1007d5c:	c749                	beqz	a4,1007de6 <HAL_UARTx_IRQHandler+0x1b6>
 1007d5e:	f2f6f8e3          	bgeu	a3,a5,1007c8e <HAL_UARTx_IRQHandler+0x5e>
 1007d62:	4018                	lw	a4,0(s0)
 1007d64:	4310                	lw	a2,0(a4)
 1007d66:	5018                	lw	a4,32(s0)
 1007d68:	00170513          	addi	a0,a4,1
 1007d6c:	d008                	sw	a0,32(s0)
 1007d6e:	00c70023          	sb	a2,0(a4)
 1007d72:	02445703          	lhu	a4,36(s0)
 1007d76:	4010                	lw	a2,0(s0)
 1007d78:	177d                	addi	a4,a4,-1
 1007d7a:	3c07370b          	th.extu	a4,a4,15,0
 1007d7e:	02e41223          	sh	a4,36(s0)
 1007d82:	02d71963          	bne	a4,a3,1007db4 <HAL_UARTx_IRQHandler+0x184>
 1007d86:	501c                	lw	a5,32(s0)
 1007d88:	4218                	lw	a4,0(a2)
 1007d8a:	00178693          	addi	a3,a5,1
 1007d8e:	d014                	sw	a3,32(s0)
 1007d90:	00e78023          	sb	a4,0(a5)
 1007d94:	4018                	lw	a4,0(s0)
 1007d96:	4f5c                	lw	a5,28(a4)
 1007d98:	fcf7f793          	andi	a5,a5,-49
 1007d9c:	0207e793          	ori	a5,a5,32
 1007da0:	cf5c                	sw	a5,28(a4)
 1007da2:	02000793          	li	a5,32
 1007da6:	d45c                	sw	a5,44(s0)
 1007da8:	47c5                	li	a5,17
 1007daa:	d71c                	sw	a5,40(a4)
 1007dac:	8522                	mv	a0,s0
 1007dae:	209020ef          	jal	100a7b6 <HAL_UART_RxCpltCallback>
 1007db2:	bdf1                	j	1007c8e <HAL_UARTx_IRQHandler+0x5e>
 1007db4:	00e5ea63          	bltu	a1,a4,1007dc8 <HAL_UARTx_IRQHandler+0x198>
 1007db8:	4e58                	lw	a4,28(a2)
 1007dba:	fcf77713          	andi	a4,a4,-49
 1007dbe:	17fd                	addi	a5,a5,-1
 1007dc0:	ce58                	sw	a4,28(a2)
 1007dc2:	0ff7f793          	zext.b	a5,a5
 1007dc6:	bf61                	j	1007d5e <HAL_UARTx_IRQHandler+0x12e>
 1007dc8:	4e58                	lw	a4,28(a2)
 1007dca:	fcf77713          	andi	a4,a4,-49
 1007dce:	02076713          	ori	a4,a4,32
 1007dd2:	b7f5                	j	1007dbe <HAL_UARTx_IRQHandler+0x18e>
 1007dd4:	04d66763          	bltu	a2,a3,1007e22 <HAL_UARTx_IRQHandler+0x1f2>
 1007dd8:	4f54                	lw	a3,28(a4)
 1007dda:	fcf6f693          	andi	a3,a3,-49
 1007dde:	17fd                	addi	a5,a5,-1
 1007de0:	cf54                	sw	a3,28(a4)
 1007de2:	0ff7f793          	zext.b	a5,a5
 1007de6:	ea0784e3          	beqz	a5,1007c8e <HAL_UARTx_IRQHandler+0x5e>
 1007dea:	4018                	lw	a4,0(s0)
 1007dec:	4314                	lw	a3,0(a4)
 1007dee:	5018                	lw	a4,32(s0)
 1007df0:	00170593          	addi	a1,a4,1
 1007df4:	d00c                	sw	a1,32(s0)
 1007df6:	00d70023          	sb	a3,0(a4)
 1007dfa:	02445683          	lhu	a3,36(s0)
 1007dfe:	4018                	lw	a4,0(s0)
 1007e00:	16fd                	addi	a3,a3,-1
 1007e02:	3c06b68b          	th.extu	a3,a3,15,0
 1007e06:	02d41223          	sh	a3,36(s0)
 1007e0a:	f6e9                	bnez	a3,1007dd4 <HAL_UARTx_IRQHandler+0x1a4>
 1007e0c:	4f5c                	lw	a5,28(a4)
 1007e0e:	fcf7f793          	andi	a5,a5,-49
 1007e12:	0207e793          	ori	a5,a5,32
 1007e16:	cf5c                	sw	a5,28(a4)
 1007e18:	02000793          	li	a5,32
 1007e1c:	d45c                	sw	a5,44(s0)
 1007e1e:	4785                	li	a5,1
 1007e20:	b769                	j	1007daa <HAL_UARTx_IRQHandler+0x17a>
 1007e22:	4f54                	lw	a3,28(a4)
 1007e24:	fcf6f693          	andi	a3,a3,-49
 1007e28:	0206e693          	ori	a3,a3,32
 1007e2c:	bf4d                	j	1007dde <HAL_UARTx_IRQHandler+0x1ae>
 1007e2e:	4314                	lw	a3,0(a4)
 1007e30:	5018                	lw	a4,32(s0)
 1007e32:	17fd                	addi	a5,a5,-1
 1007e34:	0ff7f793          	zext.b	a5,a5
 1007e38:	00170613          	addi	a2,a4,1
 1007e3c:	d010                	sw	a2,32(s0)
 1007e3e:	00d70023          	sb	a3,0(a4)
 1007e42:	02445703          	lhu	a4,36(s0)
 1007e46:	177d                	addi	a4,a4,-1
 1007e48:	02e41223          	sh	a4,36(s0)
 1007e4c:	b585                	j	1007cac <HAL_UARTx_IRQHandler+0x7c>

01007e4e <HAL_UART_AutoBaudRate_Detect_IT>:
 1007e4e:	3c5032ef          	jal	t0,100ba12 <__riscv_save_0>
 1007e52:	4100                	lw	s0,0(a0)
 1007e54:	8522                	mv	a0,s0
 1007e56:	e6cff0ef          	jal	10074c2 <UART_AutoBaudRate_Detect_Start.isra.0>
 1007e5a:	4c5c                	lw	a5,28(s0)
 1007e5c:	4501                	li	a0,0
 1007e5e:	fcf7f793          	andi	a5,a5,-49
 1007e62:	cc5c                	sw	a5,28(s0)
 1007e64:	4785                	li	a5,1
 1007e66:	d05c                	sw	a5,36(s0)
 1007e68:	3cf0306f          	j	100ba36 <__riscv_restore_0>

01007e6c <HAL_IWDG_Init>:
 1007e6c:	3a7032ef          	jal	t0,100ba12 <__riscv_save_0>
 1007e70:	842a                	mv	s0,a0
 1007e72:	84ae                	mv	s1,a1
 1007e74:	d54f80ef          	jal	10003c8 <HAL_IWDG_MSP_Init>
 1007e78:	478d                	li	a5,3
 1007e7a:	c004                	sw	s1,0(s0)
 1007e7c:	c05c                	sw	a5,4(s0)
 1007e7e:	4501                	li	a0,0
 1007e80:	3b70306f          	j	100ba36 <__riscv_restore_0>

01007e84 <HAL_OTBN_Init>:
 1007e84:	e8ef806f          	j	1000512 <HAL_LSOTBN_MSP_Init>

01007e88 <HAL_OTBN_IMEM_Write>:
 1007e88:	38b032ef          	jal	t0,100ba12 <__riscv_save_0>
 1007e8c:	400107b7          	lui	a5,0x40010
 1007e90:	4f9c                	lw	a5,24(a5)
 1007e92:	4409                	li	s0,2
 1007e94:	e385                	bnez	a5,1007eb4 <HAL_OTBN_IMEM_Write+0x2c>
 1007e96:	00c507b3          	add	a5,a0,a2
 1007e9a:	6709                	lui	a4,0x2
 1007e9c:	4405                	li	s0,1
 1007e9e:	00f76b63          	bltu	a4,a5,1007eb4 <HAL_OTBN_IMEM_Write+0x2c>
 1007ea2:	00c56433          	or	s0,a0,a2
 1007ea6:	880d                	andi	s0,s0,3
 1007ea8:	e809                	bnez	s0,1007eba <HAL_OTBN_IMEM_Write+0x32>
 1007eaa:	400147b7          	lui	a5,0x40014
 1007eae:	8209                	srli	a2,a2,0x2
 1007eb0:	953e                	add	a0,a0,a5
 1007eb2:	2e7d                	jal	1008270 <memcpy32>
 1007eb4:	8522                	mv	a0,s0
 1007eb6:	3810306f          	j	100ba36 <__riscv_restore_0>
 1007eba:	4405                	li	s0,1
 1007ebc:	bfe5                	j	1007eb4 <HAL_OTBN_IMEM_Write+0x2c>

01007ebe <HAL_OTBN_DMEM_Set>:
 1007ebe:	355032ef          	jal	t0,100ba12 <__riscv_save_0>
 1007ec2:	400107b7          	lui	a5,0x40010
 1007ec6:	4f9c                	lw	a5,24(a5)
 1007ec8:	4409                	li	s0,2
 1007eca:	e395                	bnez	a5,1007eee <HAL_OTBN_DMEM_Set+0x30>
 1007ecc:	6785                	lui	a5,0x1
 1007ece:	00c50733          	add	a4,a0,a2
 1007ed2:	c0078793          	addi	a5,a5,-1024 # c00 <Reset_Handler-0xfff400>
 1007ed6:	4405                	li	s0,1
 1007ed8:	00e7eb63          	bltu	a5,a4,1007eee <HAL_OTBN_DMEM_Set+0x30>
 1007edc:	00c56433          	or	s0,a0,a2
 1007ee0:	880d                	andi	s0,s0,3
 1007ee2:	e809                	bnez	s0,1007ef4 <HAL_OTBN_DMEM_Set+0x36>
 1007ee4:	400187b7          	lui	a5,0x40018
 1007ee8:	8209                	srli	a2,a2,0x2
 1007eea:	953e                	add	a0,a0,a5
 1007eec:	2e61                	jal	1008284 <memset32>
 1007eee:	8522                	mv	a0,s0
 1007ef0:	3470306f          	j	100ba36 <__riscv_restore_0>
 1007ef4:	4405                	li	s0,1
 1007ef6:	bfe5                	j	1007eee <HAL_OTBN_DMEM_Set+0x30>

01007ef8 <HAL_OTBN_DMEM_Write>:
 1007ef8:	31b032ef          	jal	t0,100ba12 <__riscv_save_0>
 1007efc:	400107b7          	lui	a5,0x40010
 1007f00:	4f9c                	lw	a5,24(a5)
 1007f02:	4409                	li	s0,2
 1007f04:	e395                	bnez	a5,1007f28 <HAL_OTBN_DMEM_Write+0x30>
 1007f06:	6785                	lui	a5,0x1
 1007f08:	00c50733          	add	a4,a0,a2
 1007f0c:	c0078793          	addi	a5,a5,-1024 # c00 <Reset_Handler-0xfff400>
 1007f10:	4405                	li	s0,1
 1007f12:	00e7eb63          	bltu	a5,a4,1007f28 <HAL_OTBN_DMEM_Write+0x30>
 1007f16:	00c56433          	or	s0,a0,a2
 1007f1a:	880d                	andi	s0,s0,3
 1007f1c:	e809                	bnez	s0,1007f2e <HAL_OTBN_DMEM_Write+0x36>
 1007f1e:	400187b7          	lui	a5,0x40018
 1007f22:	8209                	srli	a2,a2,0x2
 1007f24:	953e                	add	a0,a0,a5
 1007f26:	26a9                	jal	1008270 <memcpy32>
 1007f28:	8522                	mv	a0,s0
 1007f2a:	30d0306f          	j	100ba36 <__riscv_restore_0>
 1007f2e:	4405                	li	s0,1
 1007f30:	bfe5                	j	1007f28 <HAL_OTBN_DMEM_Write+0x30>

01007f32 <HAL_OTBN_DMEM_Read>:
 1007f32:	2e1032ef          	jal	t0,100ba12 <__riscv_save_0>
 1007f36:	40010737          	lui	a4,0x40010
 1007f3a:	4f18                	lw	a4,24(a4)
 1007f3c:	4409                	li	s0,2
 1007f3e:	e705                	bnez	a4,1007f66 <HAL_OTBN_DMEM_Read+0x34>
 1007f40:	6705                	lui	a4,0x1
 1007f42:	00c506b3          	add	a3,a0,a2
 1007f46:	c0070713          	addi	a4,a4,-1024 # c00 <Reset_Handler-0xfff400>
 1007f4a:	87aa                	mv	a5,a0
 1007f4c:	4405                	li	s0,1
 1007f4e:	00d76c63          	bltu	a4,a3,1007f66 <HAL_OTBN_DMEM_Read+0x34>
 1007f52:	00c56433          	or	s0,a0,a2
 1007f56:	880d                	andi	s0,s0,3
 1007f58:	e811                	bnez	s0,1007f6c <HAL_OTBN_DMEM_Read+0x3a>
 1007f5a:	852e                	mv	a0,a1
 1007f5c:	400185b7          	lui	a1,0x40018
 1007f60:	8209                	srli	a2,a2,0x2
 1007f62:	95be                	add	a1,a1,a5
 1007f64:	2631                	jal	1008270 <memcpy32>
 1007f66:	8522                	mv	a0,s0
 1007f68:	2cf0306f          	j	100ba36 <__riscv_restore_0>
 1007f6c:	4405                	li	s0,1
 1007f6e:	bfe5                	j	1007f66 <HAL_OTBN_DMEM_Read+0x34>

01007f70 <HAL_OTBN_CMD_Write_Polling>:
 1007f70:	400107b7          	lui	a5,0x40010
 1007f74:	4398                	lw	a4,0(a5)
 1007f76:	c319                	beqz	a4,1007f7c <HAL_OTBN_CMD_Write_Polling+0xc>
 1007f78:	4705                	li	a4,1
 1007f7a:	c398                	sw	a4,0(a5)
 1007f7c:	43d8                	lw	a4,4(a5)
 1007f7e:	9b79                	andi	a4,a4,-2
 1007f80:	c3d8                	sw	a4,4(a5)
 1007f82:	cb88                	sw	a0,16(a5)
 1007f84:	400107b7          	lui	a5,0x40010
 1007f88:	4398                	lw	a4,0(a5)
 1007f8a:	df7d                	beqz	a4,1007f88 <HAL_OTBN_CMD_Write_Polling+0x18>
 1007f8c:	4705                	li	a4,1
 1007f8e:	c398                	sw	a4,0(a5)
 1007f90:	8082                	ret

01007f92 <HAL_OTBN_Error_Bit_Get>:
 1007f92:	400107b7          	lui	a5,0x40010
 1007f96:	4fc8                	lw	a0,28(a5)
 1007f98:	0007ae23          	sw	zero,28(a5) # 4001001c <bitmap+0x2fed009c>
 1007f9c:	8082                	ret

01007f9e <HAL_OTBN_Checksum_Clear>:
 1007f9e:	400107b7          	lui	a5,0x40010
 1007fa2:	0207a423          	sw	zero,40(a5) # 40010028 <bitmap+0x2fed00a8>
 1007fa6:	8082                	ret

01007fa8 <HAL_OTBN_IRQHandler>:
 1007fa8:	400107b7          	lui	a5,0x40010
 1007fac:	4398                	lw	a4,0(a5)
 1007fae:	cb01                	beqz	a4,1007fbe <HAL_OTBN_IRQHandler+0x16>
 1007fb0:	4705                	li	a4,1
 1007fb2:	c398                	sw	a4,0(a5)
 1007fb4:	d081a783          	lw	a5,-760(gp) # 10138508 <callback_func>
 1007fb8:	d041a503          	lw	a0,-764(gp) # 10138504 <callback_param>
 1007fbc:	8782                	jr	a5
 1007fbe:	8082                	ret

01007fc0 <otp_check_power_ready>:
 1007fc0:	400036b7          	lui	a3,0x40003
 1007fc4:	03c00713          	li	a4,60
 1007fc8:	42dc                	lw	a5,4(a3)
 1007fca:	03c7f793          	andi	a5,a5,60
 1007fce:	fee79de3          	bne	a5,a4,1007fc8 <otp_check_power_ready+0x8>
 1007fd2:	8082                	ret

01007fd4 <otp_single_wirte>:
 1007fd4:	225032ef          	jal	t0,100b9f8 <__riscv_save_4>
 1007fd8:	40003437          	lui	s0,0x40003
 1007fdc:	00042023          	sw	zero,0(s0) # 40003000 <bitmap+0x2fec3080>
 1007fe0:	04042823          	sw	zero,80(s0)
 1007fe4:	4a05                	li	s4,1
 1007fe6:	05442a23          	sw	s4,84(s0)
 1007fea:	4c5c                	lw	a5,28(s0)
 1007fec:	6705                	lui	a4,0x1
 1007fee:	8aaa                	mv	s5,a0
 1007ff0:	9bbd                	andi	a5,a5,-17
 1007ff2:	cc5c                	sw	a5,28(s0)
 1007ff4:	fff60793          	addi	a5,a2,-1
 1007ff8:	2c07b78b          	th.extu	a5,a5,11,0
 1007ffc:	8fd9                	or	a5,a5,a4
 1007ffe:	c41c                	sw	a5,8(s0)
 1008000:	4789                	li	a5,2
 1008002:	c05c                	sw	a5,4(s0)
 1008004:	478d                	li	a5,3
 1008006:	c43c                	sw	a5,72(s0)
 1008008:	8552                	mv	a0,s4
 100800a:	84ae                	mv	s1,a1
 100800c:	89b6                	mv	s3,a3
 100800e:	8932                	mv	s2,a2
 1008010:	5ad010ef          	jal	1009dbc <rom_delay>
 1008014:	8552                	mv	a0,s4
 1008016:	04042423          	sw	zero,72(s0)
 100801a:	5a3010ef          	jal	1009dbc <rom_delay>
 100801e:	001007b7          	lui	a5,0x100
 1008022:	f0078793          	addi	a5,a5,-256 # fff00 <Reset_Handler-0xf00100>
 1008026:	04a2                	slli	s1,s1,0x8
 1008028:	8cfd                	and	s1,s1,a5
 100802a:	098e                	slli	s3,s3,0x3
 100802c:	005007b7          	lui	a5,0x500
 1008030:	0134e4b3          	or	s1,s1,s3
 1008034:	08178793          	addi	a5,a5,129 # 500081 <Reset_Handler-0xafff7f>
 1008038:	8cdd                	or	s1,s1,a5
 100803a:	cc04                	sw	s1,24(s0)
 100803c:	01442023          	sw	s4,0(s0)
 1008040:	8556                	mv	a0,s5
 1008042:	40003737          	lui	a4,0x40003
 1008046:	02090063          	beqz	s2,1008066 <otp_single_wirte+0x92>
 100804a:	473c                	lw	a5,72(a4)
 100804c:	8b91                	andi	a5,a5,4
 100804e:	fff5                	bnez	a5,100804a <otp_single_wirte+0x76>
 1008050:	5845478b          	th.lwia	a5,(a0),4,0
 1008054:	c33c                	sw	a5,64(a4)
 1008056:	00593713          	sltiu	a4,s2,5
 100805a:	4791                	li	a5,4
 100805c:	42e9178b          	th.mvnez	a5,s2,a4
 1008060:	40f90933          	sub	s2,s2,a5
 1008064:	bff9                	j	1008042 <otp_single_wirte+0x6e>
 1008066:	4f7c                	lw	a5,92(a4)
 1008068:	8b85                	andi	a5,a5,1
 100806a:	dff5                	beqz	a5,1008066 <otp_single_wirte+0x92>
 100806c:	1c10306f          	j	100ba2c <__riscv_restore_4>

01008070 <HAL_OTP_CTRL_Init>:
 1008070:	1a3032ef          	jal	t0,100ba12 <__riscv_save_0>
 1008074:	d54f80ef          	jal	10005c8 <HAL_MSP_OTP_CTRL_Init>
 1008078:	37a1                	jal	1007fc0 <otp_check_power_ready>
 100807a:	40003737          	lui	a4,0x40003
 100807e:	4f1c                	lw	a5,24(a4)
 1008080:	03200513          	li	a0,50
 1008084:	0017e793          	ori	a5,a5,1
 1008088:	cf1c                	sw	a5,24(a4)
 100808a:	533010ef          	jal	1009dbc <rom_delay>
 100808e:	1a90306f          	j	100ba36 <__riscv_restore_0>

01008092 <HAL_OTP_SET_WR_Addr>:
 1008092:	4118                	lw	a4,0(a0)
 1008094:	400037b7          	lui	a5,0x40003
 1008098:	db98                	sw	a4,48(a5)
 100809a:	4158                	lw	a4,4(a0)
 100809c:	dbd8                	sw	a4,52(a5)
 100809e:	4518                	lw	a4,8(a0)
 10080a0:	df98                	sw	a4,56(a5)
 10080a2:	4558                	lw	a4,12(a0)
 10080a4:	dfd8                	sw	a4,60(a5)
 10080a6:	8082                	ret

010080a8 <HAL_OTP_SET_RD_Addr>:
 10080a8:	4118                	lw	a4,0(a0)
 10080aa:	400037b7          	lui	a5,0x40003
 10080ae:	d398                	sw	a4,32(a5)
 10080b0:	4158                	lw	a4,4(a0)
 10080b2:	d3d8                	sw	a4,36(a5)
 10080b4:	4518                	lw	a4,8(a0)
 10080b6:	d798                	sw	a4,40(a5)
 10080b8:	4558                	lw	a4,12(a0)
 10080ba:	d7d8                	sw	a4,44(a5)
 10080bc:	8082                	ret

010080be <HAL_OTP_Read>:
 10080be:	12d032ef          	jal	t0,100b9ea <__riscv_save_10>
 10080c2:	00c50a33          	add	s4,a0,a2
 10080c6:	6b85                	lui	s7,0x1
 10080c8:	4985                	li	s3,1
 10080ca:	0d4beb63          	bltu	s7,s4,10081a0 <HAL_OTP_Read+0xe2>
 10080ce:	8432                	mv	s0,a2
 10080d0:	4985                	li	s3,1
 10080d2:	c679                	beqz	a2,10081a0 <HAL_OTP_Read+0xe2>
 10080d4:	400034b7          	lui	s1,0x40003
 10080d8:	8aae                	mv	s5,a1
 10080da:	892a                	mv	s2,a0
 10080dc:	00367b13          	andi	s6,a2,3
 10080e0:	35c5                	jal	1007fc0 <otp_check_power_ready>
 10080e2:	0004a023          	sw	zero,0(s1) # 40003000 <bitmap+0x2fec3080>
 10080e6:	0404a823          	sw	zero,80(s1)
 10080ea:	0534aa23          	sw	s3,84(s1)
 10080ee:	4cdc                	lw	a5,28(s1)
 10080f0:	854e                	mv	a0,s3
 10080f2:	9bbd                	andi	a5,a5,-17
 10080f4:	ccdc                	sw	a5,28(s1)
 10080f6:	00340793          	addi	a5,s0,3
 10080fa:	9bf1                	andi	a5,a5,-4
 10080fc:	17fd                	addi	a5,a5,-1 # 40002fff <bitmap+0x2fec307f>
 10080fe:	2c07b78b          	th.extu	a5,a5,11,0
 1008102:	0177e7b3          	or	a5,a5,s7
 1008106:	c4dc                	sw	a5,12(s1)
 1008108:	0134a223          	sw	s3,4(s1)
 100810c:	478d                	li	a5,3
 100810e:	c4fc                	sw	a5,76(s1)
 1008110:	4ad010ef          	jal	1009dbc <rom_delay>
 1008114:	854e                	mv	a0,s3
 1008116:	0404a623          	sw	zero,76(s1)
 100811a:	4a3010ef          	jal	1009dbc <rom_delay>
 100811e:	00100737          	lui	a4,0x100
 1008122:	f0070713          	addi	a4,a4,-256 # fff00 <Reset_Handler-0xf00100>
 1008126:	00891793          	slli	a5,s2,0x8
 100812a:	8ff9                	and	a5,a5,a4
 100812c:	00100737          	lui	a4,0x100
 1008130:	974e                	add	a4,a4,s3
 1008132:	8fd9                	or	a5,a5,a4
 1008134:	cc9c                	sw	a5,24(s1)
 1008136:	0134a023          	sw	s3,0(s1)
 100813a:	8756                	mv	a4,s5
 100813c:	028b0863          	beq	s6,s0,100816c <HAL_OTP_Read+0xae>
 1008140:	400036b7          	lui	a3,0x40003
 1008144:	46fc                	lw	a5,76(a3)
 1008146:	8ba1                	andi	a5,a5,8
 1008148:	fff5                	bnez	a5,1008144 <HAL_OTP_Read+0x86>
 100814a:	42fc                	lw	a5,68(a3)
 100814c:	0711                	addi	a4,a4,4 # 100004 <Reset_Handler-0xeffffc>
 100814e:	1471                	addi	s0,s0,-4
 1008150:	0087d693          	srli	a3,a5,0x8
 1008154:	fed70ea3          	sb	a3,-3(a4)
 1008158:	0107d693          	srli	a3,a5,0x10
 100815c:	fef70e23          	sb	a5,-4(a4)
 1008160:	fed70f23          	sb	a3,-2(a4)
 1008164:	83e1                	srli	a5,a5,0x18
 1008166:	fef70fa3          	sb	a5,-1(a4)
 100816a:	bfc9                	j	100813c <HAL_OTP_Read+0x7e>
 100816c:	c005                	beqz	s0,100818c <HAL_OTP_Read+0xce>
 100816e:	400036b7          	lui	a3,0x40003
 1008172:	46fc                	lw	a5,76(a3)
 1008174:	8ba1                	andi	a5,a5,8
 1008176:	fff5                	bnez	a5,1008172 <HAL_OTP_Read+0xb4>
 1008178:	42f0                	lw	a2,68(a3)
 100817a:	00379693          	slli	a3,a5,0x3
 100817e:	00d656b3          	srl	a3,a2,a3
 1008182:	00f7568b          	th.srb	a3,a4,a5,0
 1008186:	0785                	addi	a5,a5,1
 1008188:	fef419e3          	bne	s0,a5,100817a <HAL_OTP_Read+0xbc>
 100818c:	1a7d                	addi	s4,s4,-1
 100818e:	00595913          	srli	s2,s2,0x5
 1008192:	005a5a13          	srli	s4,s4,0x5
 1008196:	400034b7          	lui	s1,0x40003
 100819a:	012a7663          	bgeu	s4,s2,10081a6 <HAL_OTP_Read+0xe8>
 100819e:	4981                	li	s3,0
 10081a0:	854e                	mv	a0,s3
 10081a2:	0810306f          	j	100ba22 <__riscv_restore_10>
 10081a6:	00595713          	srli	a4,s2,0x5
 10081aa:	0721                	addi	a4,a4,8
 10081ac:	44e4c70b          	th.lrw	a4,s1,a4,2
 10081b0:	01275733          	srl	a4,a4,s2
 10081b4:	8b05                	andi	a4,a4,1
 10081b6:	cb01                	beqz	a4,10081c6 <HAL_OTP_Read+0x108>
 10081b8:	02000613          	li	a2,32
 10081bc:	0ff00593          	li	a1,255
 10081c0:	8556                	mv	a0,s5
 10081c2:	16b030ef          	jal	100bb2c <memset>
 10081c6:	0905                	addi	s2,s2,1 # 18001 <Reset_Handler-0xfe7fff>
 10081c8:	020a8a93          	addi	s5,s5,32
 10081cc:	b7f9                	j	100819a <HAL_OTP_Read+0xdc>

010081ce <otp_block_write>:
 10081ce:	00c50733          	add	a4,a0,a2
 10081d2:	6785                	lui	a5,0x1
 10081d4:	00e7f463          	bgeu	a5,a4,10081dc <otp_block_write+0xe>
 10081d8:	4501                	li	a0,0
 10081da:	8082                	ret
 10081dc:	01d032ef          	jal	t0,100b9f8 <__riscv_save_4>
 10081e0:	02000793          	li	a5,32
 10081e4:	7119                	addi	sp,sp,-128
 10081e6:	8432                	mv	s0,a2
 10081e8:	00c7e863          	bltu	a5,a2,10081f8 <otp_block_write+0x2a>
 10081ec:	89ae                	mv	s3,a1
 10081ee:	858a                	mv	a1,sp
 10081f0:	892a                	mv	s2,a0
 10081f2:	848a                	mv	s1,sp
 10081f4:	35e9                	jal	10080be <HAL_OTP_Read>
 10081f6:	cd19                	beqz	a0,1008214 <otp_block_write+0x46>
 10081f8:	4501                	li	a0,0
 10081fa:	6109                	addi	sp,sp,128
 10081fc:	0310306f          	j	100ba2c <__riscv_restore_4>
 1008200:	80a4c78b          	th.lrbu	a5,s1,a0,0
 1008204:	80a9c70b          	th.lrbu	a4,s3,a0,0
 1008208:	fff7c793          	not	a5,a5
 100820c:	8fd9                	or	a5,a5,a4
 100820e:	00a4d78b          	th.srb	a5,s1,a0,0
 1008212:	0505                	addi	a0,a0,1
 1008214:	fea416e3          	bne	s0,a0,1008200 <otp_block_write+0x32>
 1008218:	4681                	li	a3,0
 100821a:	8622                	mv	a2,s0
 100821c:	85ca                	mv	a1,s2
 100821e:	8526                	mv	a0,s1
 1008220:	3b55                	jal	1007fd4 <otp_single_wirte>
 1008222:	8526                	mv	a0,s1
 1008224:	4685                	li	a3,1
 1008226:	8622                	mv	a2,s0
 1008228:	85ca                	mv	a1,s2
 100822a:	336d                	jal	1007fd4 <otp_single_wirte>
 100822c:	4505                	li	a0,1
 100822e:	b7f1                	j	10081fa <otp_block_write+0x2c>

01008230 <HAL_OTP_Write>:
 1008230:	7c8032ef          	jal	t0,100b9f8 <__riscv_save_4>
 1008234:	8432                	mv	s0,a2
 1008236:	892a                	mv	s2,a0
 1008238:	89ae                	mv	s3,a1
 100823a:	fe047a13          	andi	s4,s0,-32
 100823e:	3349                	jal	1007fc0 <otp_check_power_ready>
 1008240:	4481                	li	s1,0
 1008242:	009985b3          	add	a1,s3,s1
 1008246:	00990533          	add	a0,s2,s1
 100824a:	01449763          	bne	s1,s4,1008258 <HAL_OTP_Write+0x28>
 100824e:	01f47613          	andi	a2,s0,31
 1008252:	ee01                	bnez	a2,100826a <HAL_OTP_Write+0x3a>
 1008254:	4501                	li	a0,0
 1008256:	a801                	j	1008266 <HAL_OTP_Write+0x36>
 1008258:	02000613          	li	a2,32
 100825c:	3f8d                	jal	10081ce <otp_block_write>
 100825e:	02048493          	addi	s1,s1,32 # 40003020 <bitmap+0x2fec30a0>
 1008262:	f165                	bnez	a0,1008242 <HAL_OTP_Write+0x12>
 1008264:	4515                	li	a0,5
 1008266:	7c60306f          	j	100ba2c <__riscv_restore_4>
 100826a:	3795                	jal	10081ce <otp_block_write>
 100826c:	f565                	bnez	a0,1008254 <HAL_OTP_Write+0x24>
 100826e:	bfdd                	j	1008264 <HAL_OTP_Write+0x34>

01008270 <memcpy32>:
 1008270:	4781                	li	a5,0
 1008272:	00f61363          	bne	a2,a5,1008278 <memcpy32+0x8>
 1008276:	8082                	ret
 1008278:	44f5c70b          	th.lrw	a4,a1,a5,2
 100827c:	44f5570b          	th.srw	a4,a0,a5,2
 1008280:	0785                	addi	a5,a5,1 # 1001 <Reset_Handler-0xffefff>
 1008282:	bfc5                	j	1008272 <memcpy32+0x2>

01008284 <memset32>:
 1008284:	4781                	li	a5,0
 1008286:	00f61363          	bne	a2,a5,100828c <memset32+0x8>
 100828a:	8082                	ret
 100828c:	44f5558b          	th.srw	a1,a0,a5,2
 1008290:	0785                	addi	a5,a5,1
 1008292:	bfd5                	j	1008286 <memset32+0x2>

01008294 <uart_log_tx>:
 1008294:	4781                	li	a5,0
 1008296:	00b78d63          	beq	a5,a1,10082b0 <uart_log_tx+0x1c>
 100829a:	400a16b7          	lui	a3,0x400a1
 100829e:	5298                	lw	a4,32(a3)
 10082a0:	20077713          	andi	a4,a4,512
 10082a4:	df6d                	beqz	a4,100829e <uart_log_tx+0xa>
 10082a6:	80f5470b          	th.lrbu	a4,a0,a5,0
 10082aa:	0785                	addi	a5,a5,1
 10082ac:	c2d8                	sw	a4,4(a3)
 10082ae:	b7e5                	j	1008296 <uart_log_tx+0x2>
 10082b0:	8082                	ret

010082b2 <mini_puts>:
 10082b2:	760032ef          	jal	t0,100ba12 <__riscv_save_0>
 10082b6:	842e                	mv	s0,a1
 10082b8:	3ff1                	jal	1008294 <uart_log_tx>
 10082ba:	8522                	mv	a0,s0
 10082bc:	77a0306f          	j	100ba36 <__riscv_restore_0>

010082c0 <uart_log_init>:
 10082c0:	752032ef          	jal	t0,100ba12 <__riscv_save_0>
 10082c4:	842f80ef          	jal	1000306 <LL_UART1_MSP_Init>
 10082c8:	0c300593          	li	a1,195
 10082cc:	0c400513          	li	a0,196
 10082d0:	d62f80ef          	jal	1000832 <pinmux_uart1_init>
 10082d4:	400a17b7          	lui	a5,0x400a1
 10082d8:	47d8                	lw	a4,12(a5)
 10082da:	08076713          	ori	a4,a4,128
 10082de:	c7d8                	sw	a4,12(a5)
 10082e0:	1b200713          	li	a4,434
 10082e4:	c798                	sw	a4,8(a5)
 10082e6:	47d8                	lw	a4,12(a5)
 10082e8:	f7f77713          	andi	a4,a4,-129
 10082ec:	c7d8                	sw	a4,12(a5)
 10082ee:	471d                	li	a4,7
 10082f0:	cfd8                	sw	a4,28(a5)
 10082f2:	470d                	li	a4,3
 10082f4:	c7d8                	sw	a4,12(a5)
 10082f6:	7400306f          	j	100ba36 <__riscv_restore_0>

010082fa <log_output>:
 10082fa:	7139                	addi	sp,sp,-64
 10082fc:	cc22                	sw	s0,24(sp)
 10082fe:	842a                	mv	s0,a0
 1008300:	01008537          	lui	a0,0x1008
 1008304:	d432                	sw	a2,40(sp)
 1008306:	d636                	sw	a3,44(sp)
 1008308:	862e                	mv	a2,a1
 100830a:	1034                	addi	a3,sp,40
 100830c:	4581                	li	a1,0
 100830e:	2b250513          	addi	a0,a0,690 # 10082b2 <mini_puts>
 1008312:	ce06                	sw	ra,28(sp)
 1008314:	d83a                	sw	a4,48(sp)
 1008316:	da3e                	sw	a5,52(sp)
 1008318:	dc42                	sw	a6,56(sp)
 100831a:	de46                	sw	a7,60(sp)
 100831c:	c636                	sw	a3,12(sp)
 100831e:	2c01                	jal	100852e <mini_vpprintf>
 1008320:	c419                	beqz	s0,100832e <log_output+0x34>
 1008322:	01008537          	lui	a0,0x1008
 1008326:	4585                	li	a1,1
 1008328:	3dd50513          	addi	a0,a0,989 # 10083dd <linefeed_value>
 100832c:	37a5                	jal	1008294 <uart_log_tx>
 100832e:	40f2                	lw	ra,28(sp)
 1008330:	4462                	lw	s0,24(sp)
 1008332:	6121                	addi	sp,sp,64
 1008334:	8082                	ret

01008336 <log_hex_output>:
 1008336:	00159793          	slli	a5,a1,0x1
 100833a:	07c5                	addi	a5,a5,17 # 400a1011 <bitmap+0x2ff61091>
 100833c:	1141                	addi	sp,sp,-16
 100833e:	8391                	srli	a5,a5,0x4
 1008340:	c422                	sw	s0,8(sp)
 1008342:	c606                	sw	ra,12(sp)
 1008344:	0800                	addi	s0,sp,16
 1008346:	0792                	slli	a5,a5,0x4
 1008348:	01008737          	lui	a4,0x1008
 100834c:	40f10133          	sub	sp,sp,a5
 1008350:	860a                	mv	a2,sp
 1008352:	4781                	li	a5,0
 1008354:	3cc70713          	addi	a4,a4,972 # 10083cc <hex_num_tab>
 1008358:	00110813          	addi	a6,sp,1
 100835c:	3c07b68b          	th.extu	a3,a5,15,0
 1008360:	02b6e963          	bltu	a3,a1,1008392 <log_hex_output+0x5c>
 1008364:	4729                	li	a4,10
 1008366:	02b6178b          	th.addsl	a5,a2,a1,1
 100836a:	02b6570b          	th.srb	a4,a2,a1,1
 100836e:	010076b7          	lui	a3,0x1007
 1008372:	01008537          	lui	a0,0x1008
 1008376:	000780a3          	sb	zero,1(a5)
 100837a:	6fc68693          	addi	a3,a3,1788 # 10076fc <HAL_UART_Receive+0xec>
 100837e:	4581                	li	a1,0
 1008380:	2b250513          	addi	a0,a0,690 # 10082b2 <mini_puts>
 1008384:	226d                	jal	100852e <mini_vpprintf>
 1008386:	ff040113          	addi	sp,s0,-16
 100838a:	40b2                	lw	ra,12(sp)
 100838c:	4422                	lw	s0,8(sp)
 100838e:	0141                	addi	sp,sp,16
 1008390:	8082                	ret
 1008392:	80f5468b          	th.lrbu	a3,a0,a5,0
 1008396:	0046d893          	srli	a7,a3,0x4
 100839a:	8117488b          	th.lrbu	a7,a4,a7,0
 100839e:	8abd                	andi	a3,a3,15
 10083a0:	80d7468b          	th.lrbu	a3,a4,a3,0
 10083a4:	02f6588b          	th.srb	a7,a2,a5,1
 10083a8:	02f8568b          	th.srb	a3,a6,a5,1
 10083ac:	0785                	addi	a5,a5,1
 10083ae:	b77d                	j	100835c <log_hex_output+0x26>

010083b0 <ls_log_init>:
 10083b0:	010087b7          	lui	a5,0x1008
 10083b4:	2fa78793          	addi	a5,a5,762 # 10082fa <log_output>
 10083b8:	d0f1a823          	sw	a5,-752(gp) # 10138510 <log_output_fn>
 10083bc:	010087b7          	lui	a5,0x1008
 10083c0:	33678793          	addi	a5,a5,822 # 1008336 <log_hex_output>
 10083c4:	d0f1a623          	sw	a5,-756(gp) # 1013850c <log_hex_output_fn>
 10083c8:	ef9ff06f          	j	10082c0 <uart_log_init>

010083cc <hex_num_tab>:
 10083cc:	33323130 37363534 42413938 46454443     0123456789ABCDEF
 10083dc:	                                         .

010083dd <linefeed_value>:
 10083dd:	                                         .

010083de <mini_pad>:
 10083de:	00068863          	beqz	a3,10083ee <mini_pad+0x10>
 10083e2:	4801                	li	a6,0
 10083e4:	00b6d763          	bge	a3,a1,10083f2 <mini_pad+0x14>
 10083e8:	85b6                	mv	a1,a3
 10083ea:	4805                	li	a6,1
 10083ec:	a019                	j	10083f2 <mini_pad+0x14>
 10083ee:	4801                	li	a6,0
 10083f0:	86ae                	mv	a3,a1
 10083f2:	8e8d                	sub	a3,a3,a1
 10083f4:	4781                	li	a5,0
 10083f6:	40f688b3          	sub	a7,a3,a5
 10083fa:	05104663          	bgtz	a7,1008446 <mini_pad+0x68>
 10083fe:	0006a793          	slti	a5,a3,0
 1008402:	42f0168b          	th.mvnez	a3,zero,a5
 1008406:	96ba                	add	a3,a3,a4
 1008408:	4781                	li	a5,0
 100840a:	40f58633          	sub	a2,a1,a5
 100840e:	04c04063          	bgtz	a2,100844e <mini_pad+0x70>
 1008412:	0005a793          	slti	a5,a1,0
 1008416:	42f0158b          	th.mvnez	a1,zero,a5
 100841a:	95b6                	add	a1,a1,a3
 100841c:	40e58533          	sub	a0,a1,a4
 1008420:	02080263          	beqz	a6,1008444 <mini_pad+0x66>
 1008424:	02b77063          	bgeu	a4,a1,1008444 <mini_pad+0x66>
 1008428:	02a00793          	li	a5,42
 100842c:	86ae                	mv	a3,a1
 100842e:	09f6d78b          	th.sbib	a5,(a3),-1,0
 1008432:	00d77963          	bgeu	a4,a3,1008444 <mini_pad+0x66>
 1008436:	86ae                	mv	a3,a1
 1008438:	09e6d78b          	th.sbib	a5,(a3),-2,0
 100843c:	00d77463          	bgeu	a4,a3,1008444 <mini_pad+0x66>
 1008440:	fef58ea3          	sb	a5,-3(a1) # 40017ffd <bitmap+0x2fed807d>
 1008444:	8082                	ret
 1008446:	00f7560b          	th.srb	a2,a4,a5,0
 100844a:	0785                	addi	a5,a5,1
 100844c:	b76d                	j	10083f6 <mini_pad+0x18>
 100844e:	80f5460b          	th.lrbu	a2,a0,a5,0
 1008452:	00f6d60b          	th.srb	a2,a3,a5,0
 1008456:	0785                	addi	a5,a5,1
 1008458:	bf4d                	j	100840a <mini_pad+0x2c>

0100845a <_puts>:
 100845a:	86aa                	mv	a3,a0
 100845c:	852e                	mv	a0,a1
 100845e:	ce01                	beqz	a2,1008476 <_puts+0x1c>
 1008460:	00062883          	lw	a7,0(a2)
 1008464:	4701                	li	a4,0
 1008466:	425c                	lw	a5,4(a2)
 1008468:	00a74863          	blt	a4,a0,1008478 <_puts+0x1e>
 100846c:	00078023          	sb	zero,0(a5)
 1008470:	4248                	lw	a0,4(a2)
 1008472:	41150533          	sub	a0,a0,a7
 1008476:	8082                	ret
 1008478:	00862803          	lw	a6,8(a2)
 100847c:	420c                	lw	a1,0(a2)
 100847e:	187d                	addi	a6,a6,-1 # ffff8fff <bitmap+0xefeb907f>
 1008480:	95c2                	add	a1,a1,a6
 1008482:	feb785e3          	beq	a5,a1,100846c <_puts+0x12>
 1008486:	00178593          	addi	a1,a5,1
 100848a:	c24c                	sw	a1,4(a2)
 100848c:	80e6c58b          	th.lrbu	a1,a3,a4,0
 1008490:	0705                	addi	a4,a4,1
 1008492:	00b78023          	sb	a1,0(a5)
 1008496:	bfc1                	j	1008466 <_puts+0xc>

01008498 <mini_itoa.part.0>:
 1008498:	4e01                	li	t3,0
 100849a:	00055763          	bgez	a0,10084a8 <mini_itoa.part.0+0x10>
 100849e:	00069563          	bnez	a3,10084a8 <mini_itoa.part.0+0x10>
 10084a2:	40a00533          	neg	a0,a0
 10084a6:	4e05                	li	t3,1
 10084a8:	00167793          	andi	a5,a2,1
 10084ac:	06100693          	li	a3,97
 10084b0:	04100613          	li	a2,65
 10084b4:	40f6960b          	th.mveqz	a2,a3,a5
 10084b8:	88ba                	mv	a7,a4
 10084ba:	4f25                	li	t5,9
 10084bc:	1659                	addi	a2,a2,-10
 10084be:	02b57833          	remu	a6,a0,a1
 10084c2:	8eaa                	mv	t4,a0
 10084c4:	0ff87793          	zext.b	a5,a6
 10084c8:	03078313          	addi	t1,a5,48
 10084cc:	00c786b3          	add	a3,a5,a2
 10084d0:	0ff37313          	zext.b	t1,t1
 10084d4:	0ff6f693          	zext.b	a3,a3
 10084d8:	010f3833          	sltu	a6,t5,a6
 10084dc:	4103168b          	th.mveqz	a3,t1,a6
 10084e0:	87c6                	mv	a5,a7
 10084e2:	1817d68b          	th.sbia	a3,(a5),1,0
 10084e6:	02b55533          	divu	a0,a0,a1
 10084ea:	02bef663          	bgeu	t4,a1,1008516 <mini_itoa.part.0+0x7e>
 10084ee:	000e0863          	beqz	t3,10084fe <mini_itoa.part.0+0x66>
 10084f2:	02d00693          	li	a3,45
 10084f6:	00d78023          	sb	a3,0(a5)
 10084fa:	00288793          	addi	a5,a7,2
 10084fe:	40e78533          	sub	a0,a5,a4
 1008502:	4609                	li	a2,2
 1008504:	00078023          	sb	zero,0(a5)
 1008508:	4681                	li	a3,0
 100850a:	02c54633          	div	a2,a0,a2
 100850e:	17fd                	addi	a5,a5,-1
 1008510:	00c6c563          	blt	a3,a2,100851a <mini_itoa.part.0+0x82>
 1008514:	8082                	ret
 1008516:	88be                	mv	a7,a5
 1008518:	b75d                	j	10084be <mini_itoa.part.0+0x26>
 100851a:	0007c803          	lbu	a6,0(a5)
 100851e:	80d7458b          	th.lrbu	a1,a4,a3,0
 1008522:	00d7580b          	th.srb	a6,a4,a3,0
 1008526:	00b78023          	sb	a1,0(a5)
 100852a:	0685                	addi	a3,a3,1
 100852c:	b7cd                	j	100850e <mini_itoa.part.0+0x76>

0100852e <mini_vpprintf>:
 100852e:	4bc032ef          	jal	t0,100b9ea <__riscv_save_10>
 1008532:	7139                	addi	sp,sp,-64
 1008534:	8432                	mv	s0,a2
 1008536:	8d36                	mv	s10,a3
 1008538:	e515                	bnez	a0,1008564 <mini_vpprintf+0x36>
 100853a:	010084b7          	lui	s1,0x1008
 100853e:	4901                	li	s2,0
 1008540:	45a48493          	addi	s1,s1,1114 # 100845a <_puts>
 1008544:	4981                	li	s3,0
 1008546:	02500a13          	li	s4,37
 100854a:	02000a93          	li	s5,32
 100854e:	4b29                	li	s6,10
 1008550:	8c22                	mv	s8,s0
 1008552:	981c478b          	th.lbuia	a5,(s8),1,0
 1008556:	00f107a3          	sb	a5,15(sp)
 100855a:	eb81                	bnez	a5,100856a <mini_vpprintf+0x3c>
 100855c:	854e                	mv	a0,s3
 100855e:	6121                	addi	sp,sp,64
 1008560:	4c20306f          	j	100ba22 <__riscv_restore_10>
 1008564:	84aa                	mv	s1,a0
 1008566:	892e                	mv	s2,a1
 1008568:	bff1                	j	1008544 <mini_vpprintf+0x16>
 100856a:	01478c63          	beq	a5,s4,1008582 <mini_vpprintf+0x54>
 100856e:	864a                	mv	a2,s2
 1008570:	4585                	li	a1,1
 1008572:	00f10513          	addi	a0,sp,15
 1008576:	9482                	jalr	s1
 1008578:	8bea                	mv	s7,s10
 100857a:	8462                	mv	s0,s8
 100857c:	99aa                	add	s3,s3,a0
 100857e:	8d5e                	mv	s10,s7
 1008580:	bfc1                	j	1008550 <mini_vpprintf+0x22>
 1008582:	00144783          	lbu	a5,1(s0)
 1008586:	8cd6                	mv	s9,s5
 1008588:	0409                	addi	s0,s0,2
 100858a:	fd078713          	addi	a4,a5,-48
 100858e:	40e79c8b          	th.mveqz	s9,a5,a4
 1008592:	00f107a3          	sb	a5,15(sp)
 1008596:	4681                	li	a3,0
 1008598:	4701                	li	a4,0
 100859a:	45a5                	li	a1,9
 100859c:	fd078613          	addi	a2,a5,-48
 10085a0:	0ff67513          	zext.b	a0,a2
 10085a4:	04a5fe63          	bgeu	a1,a0,1008600 <mini_vpprintf+0xd2>
 10085a8:	00068463          	beqz	a3,10085b0 <mini_vpprintf+0x82>
 10085ac:	00f107a3          	sb	a5,15(sp)
 10085b0:	01972693          	slti	a3,a4,25
 10085b4:	4c61                	li	s8,24
 10085b6:	06c00613          	li	a2,108
 10085ba:	42d71c0b          	th.mvnez	s8,a4,a3
 10085be:	4681                	li	a3,0
 10085c0:	00c79763          	bne	a5,a2,10085ce <mini_vpprintf+0xa0>
 10085c4:	9814478b          	th.lbuia	a5,(s0),1,0
 10085c8:	4685                	li	a3,1
 10085ca:	00f107a3          	sb	a5,15(sp)
 10085ce:	00f14603          	lbu	a2,15(sp)
 10085d2:	06400793          	li	a5,100
 10085d6:	06f60763          	beq	a2,a5,1008644 <mini_vpprintf+0x116>
 10085da:	02c7ea63          	bltu	a5,a2,100860e <mini_vpprintf+0xe0>
 10085de:	05800793          	li	a5,88
 10085e2:	0af60163          	beq	a2,a5,1008684 <mini_vpprintf+0x156>
 10085e6:	06300793          	li	a5,99
 10085ea:	0af60e63          	beq	a2,a5,10086a6 <mini_vpprintf+0x178>
 10085ee:	f60607e3          	beqz	a2,100855c <mini_vpprintf+0x2e>
 10085f2:	864a                	mv	a2,s2
 10085f4:	4585                	li	a1,1
 10085f6:	00f10513          	addi	a0,sp,15
 10085fa:	9482                	jalr	s1
 10085fc:	8bea                	mv	s7,s10
 10085fe:	bfbd                	j	100857c <mini_vpprintf+0x4e>
 1008600:	2167160b          	th.mula	a2,a4,s6
 1008604:	9814478b          	th.lbuia	a5,(s0),1,0
 1008608:	4685                	li	a3,1
 100860a:	8732                	mv	a4,a2
 100860c:	bf41                	j	100859c <mini_vpprintf+0x6e>
 100860e:	07500793          	li	a5,117
 1008612:	02f60963          	beq	a2,a5,1008644 <mini_vpprintf+0x116>
 1008616:	07800793          	li	a5,120
 100861a:	06f60563          	beq	a2,a5,1008684 <mini_vpprintf+0x156>
 100861e:	07300793          	li	a5,115
 1008622:	fcf618e3          	bne	a2,a5,10085f2 <mini_vpprintf+0xc4>
 1008626:	000d2503          	lw	a0,0(s10) # 1a000 <Reset_Handler-0xfe6000>
 100862a:	004d0b93          	addi	s7,s10,4
 100862e:	4581                	li	a1,0
 1008630:	80b5478b          	th.lrbu	a5,a0,a1,0
 1008634:	e7d1                	bnez	a5,10086c0 <mini_vpprintf+0x192>
 1008636:	864a                	mv	a2,s2
 1008638:	02e05c63          	blez	a4,1008670 <mini_vpprintf+0x142>
 100863c:	0818                	addi	a4,sp,16
 100863e:	86e2                	mv	a3,s8
 1008640:	8666                	mv	a2,s9
 1008642:	a01d                	j	1008668 <mini_vpprintf+0x13a>
 1008644:	004d0b93          	addi	s7,s10,4
 1008648:	c695                	beqz	a3,1008674 <mini_vpprintf+0x146>
 100864a:	f8b60613          	addi	a2,a2,-117
 100864e:	1038                	addi	a4,sp,40
 1008650:	00163693          	seqz	a3,a2
 1008654:	000d2503          	lw	a0,0(s10)
 1008658:	4601                	li	a2,0
 100865a:	45a9                	li	a1,10
 100865c:	3d35                	jal	1008498 <mini_itoa.part.0>
 100865e:	0818                	addi	a4,sp,16
 1008660:	86e2                	mv	a3,s8
 1008662:	8666                	mv	a2,s9
 1008664:	85aa                	mv	a1,a0
 1008666:	1028                	addi	a0,sp,40
 1008668:	3b9d                	jal	10083de <mini_pad>
 100866a:	85aa                	mv	a1,a0
 100866c:	864a                	mv	a2,s2
 100866e:	0808                	addi	a0,sp,16
 1008670:	9482                	jalr	s1
 1008672:	b729                	j	100857c <mini_vpprintf+0x4e>
 1008674:	07500793          	li	a5,117
 1008678:	1038                	addi	a4,sp,40
 100867a:	4685                	li	a3,1
 100867c:	fcf60ce3          	beq	a2,a5,1008654 <mini_vpprintf+0x126>
 1008680:	4681                	li	a3,0
 1008682:	bfc9                	j	1008654 <mini_vpprintf+0x126>
 1008684:	000d2503          	lw	a0,0(s10)
 1008688:	fa860613          	addi	a2,a2,-88
 100868c:	00163613          	seqz	a2,a2
 1008690:	1038                	addi	a4,sp,40
 1008692:	4685                	li	a3,1
 1008694:	45c1                	li	a1,16
 1008696:	3509                	jal	1008498 <mini_itoa.part.0>
 1008698:	004d0b93          	addi	s7,s10,4
 100869c:	85aa                	mv	a1,a0
 100869e:	0818                	addi	a4,sp,16
 10086a0:	86e2                	mv	a3,s8
 10086a2:	8666                	mv	a2,s9
 10086a4:	b7c9                	j	1008666 <mini_vpprintf+0x138>
 10086a6:	000d2783          	lw	a5,0(s10)
 10086aa:	004d0b93          	addi	s7,s10,4
 10086ae:	0818                	addi	a4,sp,16
 10086b0:	00f107a3          	sb	a5,15(sp)
 10086b4:	86e2                	mv	a3,s8
 10086b6:	8666                	mv	a2,s9
 10086b8:	4585                	li	a1,1
 10086ba:	00f10513          	addi	a0,sp,15
 10086be:	b76d                	j	1008668 <mini_vpprintf+0x13a>
 10086c0:	0585                	addi	a1,a1,1
 10086c2:	b7bd                	j	1008630 <mini_vpprintf+0x102>

010086c4 <goto_uart>:
 10086c4:	34e032ef          	jal	t0,100ba12 <__riscv_save_0>
 10086c8:	52018513          	addi	a0,gp,1312 # 10138d20 <otp_cfg>
 10086cc:	08852403          	lw	s0,136(a0)
 10086d0:	06852903          	lw	s2,104(a0)
 10086d4:	6fc020ef          	jal	100add0 <boot_set_otp_premission>
 10086d8:	1a000613          	li	a2,416
 10086dc:	4581                	li	a1,0
 10086de:	52018513          	addi	a0,gp,1312 # 10138d20 <otp_cfg>
 10086e2:	1c74340b          	th.extu	s0,s0,7,7
 10086e6:	446030ef          	jal	100bb2c <memset>
 10086ea:	c415                	beqz	s0,1008716 <goto_uart+0x52>
 10086ec:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 10086f0:	cb89                	beqz	a5,1008702 <goto_uart+0x3e>
 10086f2:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 10086f6:	010075b7          	lui	a1,0x1007
 10086fa:	6ff58593          	addi	a1,a1,1791 # 10076ff <HAL_UART_Receive+0xef>
 10086fe:	4505                	li	a0,1
 1008700:	9782                	jalr	a5
 1008702:	006020ef          	jal	100a708 <boot_uart_init>
 1008706:	4789                	li	a5,2
 1008708:	d181a703          	lw	a4,-744(gp) # 10138518 <uart_stage>
 100870c:	fef71ee3          	bne	a4,a5,1008708 <goto_uart+0x44>
 1008710:	854a                	mv	a0,s2
 1008712:	3e6010ef          	jal	1009af8 <parser_loop>
 1008716:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100871a:	cb89                	beqz	a5,100872c <goto_uart+0x68>
 100871c:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008720:	010075b7          	lui	a1,0x1007
 1008724:	71558593          	addi	a1,a1,1813 # 1007715 <HAL_UART_Receive+0x105>
 1008728:	4505                	li	a0,1
 100872a:	9782                	jalr	a5
 100872c:	a001                	j	100872c <goto_uart+0x68>

0100872e <boot_verify_flow>:
 100872e:	2e4032ef          	jal	t0,100ba12 <__riscv_save_0>
 1008732:	7129                	addi	sp,sp,-320
 1008734:	10000613          	li	a2,256
 1008738:	008c                	addi	a1,sp,64
 100873a:	892a                	mv	s2,a0
 100873c:	4ed010ef          	jal	100a428 <boot_flash_read>
 1008740:	4706                	lw	a4,64(sp)
 1008742:	a5a547b7          	lui	a5,0xa5a54
 1008746:	c3c78793          	addi	a5,a5,-964 # a5a53c3c <bitmap+0x95913cbc>
 100874a:	00f70763          	beq	a4,a5,1008758 <boot_verify_flow+0x2a>
 100874e:	4401                	li	s0,0
 1008750:	8522                	mv	a0,s0
 1008752:	6131                	addi	sp,sp,320
 1008754:	2e20306f          	j	100ba36 <__riscv_restore_0>
 1008758:	4716                	lw	a4,68(sp)
 100875a:	5a5ac7b7          	lui	a5,0x5a5ac
 100875e:	3c378793          	addi	a5,a5,963 # 5a5ac3c3 <bitmap+0x4a46c443>
 1008762:	fef716e3          	bne	a4,a5,100874e <boot_verify_flow+0x20>
 1008766:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100876a:	cb89                	beqz	a5,100877c <boot_verify_flow+0x4e>
 100876c:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008770:	010075b7          	lui	a1,0x1007
 1008774:	73358593          	addi	a1,a1,1843 # 1007733 <HAL_UART_Receive+0x123>
 1008778:	4505                	li	a0,1
 100877a:	9782                	jalr	a5
 100877c:	0fc00593          	li	a1,252
 1008780:	0088                	addi	a0,sp,64
 1008782:	4ab010ef          	jal	100a42c <boot_crc32>
 1008786:	13c12783          	lw	a5,316(sp)
 100878a:	fca792e3          	bne	a5,a0,100874e <boot_verify_flow+0x20>
 100878e:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1008792:	cb89                	beqz	a5,10087a4 <boot_verify_flow+0x76>
 1008794:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008798:	010075b7          	lui	a1,0x1007
 100879c:	74d58593          	addi	a1,a1,1869 # 100774d <HAL_UART_Receive+0x13d>
 10087a0:	4505                	li	a0,1
 10087a2:	9782                	jalr	a5
 10087a4:	52018413          	addi	s0,gp,1312 # 10138d20 <otp_cfg>
 10087a8:	10042783          	lw	a5,256(s0)
 10087ac:	4746                	lw	a4,80(sp)
 10087ae:	00e7d7b3          	srl	a5,a5,a4
 10087b2:	8b85                	andi	a5,a5,1
 10087b4:	dfc9                	beqz	a5,100874e <boot_verify_flow+0x20>
 10087b6:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 10087ba:	cb89                	beqz	a5,10087cc <boot_verify_flow+0x9e>
 10087bc:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 10087c0:	010075b7          	lui	a1,0x1007
 10087c4:	76858593          	addi	a1,a1,1896 # 1007768 <HAL_UART_Receive+0x158>
 10087c8:	4505                	li	a0,1
 10087ca:	9782                	jalr	a5
 10087cc:	05514783          	lbu	a5,85(sp)
 10087d0:	04000613          	li	a2,64
 10087d4:	858a                	mv	a1,sp
 10087d6:	02f4178b          	th.addsl	a5,s0,a5,1
 10087da:	1817c503          	lbu	a0,385(a5)
 10087de:	1013f437          	lui	s0,0x1013f
 10087e2:	0512                	slli	a0,a0,0x4
 10087e4:	1a050513          	addi	a0,a0,416
 10087e8:	363010ef          	jal	100a34a <boot_otp_read>
 10087ec:	4626                	lw	a2,72(sp)
 10087ee:	46b6                	lw	a3,76(sp)
 10087f0:	08c40713          	addi	a4,s0,140 # 1013f08c <shareMemory+0x108c>
 10087f4:	964a                	add	a2,a2,s2
 10087f6:	100c                	addi	a1,sp,32
 10087f8:	850a                	mv	a0,sp
 10087fa:	5e1010ef          	jal	100a5da <boot_sm3_ecdsa_flash>
 10087fe:	08c40693          	addi	a3,s0,140
 1008802:	19b8                	addi	a4,sp,248
 1008804:	1010                	addi	a2,sp,32
 1008806:	858a                	mv	a1,sp
 1008808:	4519                	li	a0,6
 100880a:	34c020ef          	jal	100ab56 <boot_ecc_verify>
 100880e:	842a                	mv	s0,a0
 1008810:	dd1d                	beqz	a0,100874e <boot_verify_flow+0x20>
 1008812:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1008816:	cb89                	beqz	a5,1008828 <boot_verify_flow+0xfa>
 1008818:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100881c:	010075b7          	lui	a1,0x1007
 1008820:	78058593          	addi	a1,a1,1920 # 1007780 <HAL_UART_Receive+0x170>
 1008824:	4505                	li	a0,1
 1008826:	9782                	jalr	a5
 1008828:	4546                	lw	a0,80(sp)
 100882a:	1013f4b7          	lui	s1,0x1013f
 100882e:	00048493          	mv	s1,s1
 1008832:	0dc48593          	addi	a1,s1,220 # 1013f0dc <shareMemory+0x10dc>
 1008836:	22a030ef          	jal	100ba60 <__thead_uwrite4>
 100883a:	bf19                	j	1008750 <boot_verify_flow+0x22>

0100883c <boot_nonsecure>:
 100883c:	1d6032ef          	jal	t0,100ba12 <__riscv_save_0>
 1008840:	7111                	addi	sp,sp,-256
 1008842:	842e                	mv	s0,a1
 1008844:	10000613          	li	a2,256
 1008848:	858a                	mv	a1,sp
 100884a:	84aa                	mv	s1,a0
 100884c:	8522                	mv	a0,s0
 100884e:	3db010ef          	jal	100a428 <boot_flash_read>
 1008852:	0fc00593          	li	a1,252
 1008856:	850a                	mv	a0,sp
 1008858:	3d5010ef          	jal	100a42c <boot_crc32>
 100885c:	57fe                	lw	a5,252(sp)
 100885e:	04a79363          	bne	a5,a0,10088a4 <boot_nonsecure+0x68>
 1008862:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1008866:	cb91                	beqz	a5,100887a <boot_nonsecure+0x3e>
 1008868:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100886c:	566e                	lw	a2,248(sp)
 100886e:	010075b7          	lui	a1,0x1007
 1008872:	79c58593          	addi	a1,a1,1948 # 100779c <HAL_UART_Receive+0x18c>
 1008876:	4505                	li	a0,1
 1008878:	9782                	jalr	a5
 100887a:	55ee                	lw	a1,248(sp)
 100887c:	47a2                	lw	a5,8(sp)
 100887e:	ed81                	bnez	a1,1008896 <boot_nonsecure+0x5a>
 1008880:	08000737          	lui	a4,0x8000
 1008884:	97ba                	add	a5,a5,a4
 1008886:	c09c                	sw	a5,0(s1)
 1008888:	8522                	mv	a0,s0
 100888a:	2c5010ef          	jal	100a34e <boot_flash_start_xip>
 100888e:	4505                	li	a0,1
 1008890:	6111                	addi	sp,sp,256
 1008892:	1a40306f          	j	100ba36 <__riscv_restore_0>
 1008896:	4632                	lw	a2,12(sp)
 1008898:	c08c                	sw	a1,0(s1)
 100889a:	00878533          	add	a0,a5,s0
 100889e:	38b010ef          	jal	100a428 <boot_flash_read>
 10088a2:	b7f5                	j	100888e <boot_nonsecure+0x52>
 10088a4:	4501                	li	a0,0
 10088a6:	b7ed                	j	1008890 <boot_nonsecure+0x54>

010088a8 <boot_decryptFlow>:
 10088a8:	150032ef          	jal	t0,100b9f8 <__riscv_save_4>
 10088ac:	7129                	addi	sp,sp,-320
 10088ae:	84ae                	mv	s1,a1
 10088b0:	892a                	mv	s2,a0
 10088b2:	10000613          	li	a2,256
 10088b6:	008c                	addi	a1,sp,64
 10088b8:	8526                	mv	a0,s1
 10088ba:	36f010ef          	jal	100a428 <boot_flash_read>
 10088be:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 10088c2:	05414403          	lbu	s0,84(sp)
 10088c6:	cf81                	beqz	a5,10088de <boot_decryptFlow+0x36>
 10088c8:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 10088cc:	05614603          	lbu	a2,86(sp)
 10088d0:	010075b7          	lui	a1,0x1007
 10088d4:	86a2                	mv	a3,s0
 10088d6:	7c158593          	addi	a1,a1,1985 # 10077c1 <HAL_UART_Receive+0x1b1>
 10088da:	4505                	li	a0,1
 10088dc:	9782                	jalr	a5
 10088de:	05614703          	lbu	a4,86(sp)
 10088e2:	cb01                	beqz	a4,10088f2 <boot_decryptFlow+0x4a>
 10088e4:	4785                	li	a5,1
 10088e6:	08f70463          	beq	a4,a5,100896e <boot_decryptFlow+0xc6>
 10088ea:	4501                	li	a0,0
 10088ec:	6131                	addi	sp,sp,320
 10088ee:	13e0306f          	j	100ba2c <__riscv_restore_4>
 10088f2:	52018793          	addi	a5,gp,1312 # 10138d20 <otp_cfg>
 10088f6:	0c040413          	addi	s0,s0,192
 10088fa:	a287c70b          	th.lrhu	a4,a5,s0,1
 10088fe:	4689                	li	a3,2
 1008900:	8b3d                	andi	a4,a4,15
 1008902:	fed714e3          	bne	a4,a3,10088ea <boot_decryptFlow+0x42>
 1008906:	0287940b          	th.addsl	s0,a5,s0,1
 100890a:	00144503          	lbu	a0,1(s0)
 100890e:	4641                	li	a2,16
 1008910:	00c105b3          	add	a1,sp,a2
 1008914:	0512                	slli	a0,a0,0x4
 1008916:	1a050513          	addi	a0,a0,416
 100891a:	231010ef          	jal	100a34a <boot_otp_read>
 100891e:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1008922:	cb99                	beqz	a5,1008938 <boot_decryptFlow+0x90>
 1008924:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008928:	13812603          	lw	a2,312(sp)
 100892c:	010075b7          	lui	a1,0x1007
 1008930:	79c58593          	addi	a1,a1,1948 # 100779c <HAL_UART_Receive+0x18c>
 1008934:	4505                	li	a0,1
 1008936:	9782                	jalr	a5
 1008938:	13812703          	lw	a4,312(sp)
 100893c:	4526                	lw	a0,72(sp)
 100893e:	45b6                	lw	a1,76(sp)
 1008940:	eb2d                	bnez	a4,10089b2 <boot_decryptFlow+0x10a>
 1008942:	08000737          	lui	a4,0x8000
 1008946:	972a                	add	a4,a4,a0
 1008948:	00e92023          	sw	a4,0(s2)
 100894c:	05714703          	lbu	a4,87(sp)
 1008950:	00b506b3          	add	a3,a0,a1
 1008954:	862a                	mv	a2,a0
 1008956:	00e03733          	snez	a4,a4
 100895a:	08a8                	addi	a0,sp,88
 100895c:	16fd                	addi	a3,a3,-1
 100895e:	080c                	addi	a1,sp,16
 1008960:	263010ef          	jal	100a3c2 <boot_flash_sm4_realtime_decrypt>
 1008964:	8526                	mv	a0,s1
 1008966:	1e9010ef          	jal	100a34e <boot_flash_start_xip>
 100896a:	4505                	li	a0,1
 100896c:	b741                	j	10088ec <boot_decryptFlow+0x44>
 100896e:	52018793          	addi	a5,gp,1312 # 10138d20 <otp_cfg>
 1008972:	0c040413          	addi	s0,s0,192
 1008976:	a287c68b          	th.lrhu	a3,a5,s0,1
 100897a:	4619                	li	a2,6
 100897c:	8abd                	andi	a3,a3,15
 100897e:	f6c696e3          	bne	a3,a2,10088ea <boot_decryptFlow+0x42>
 1008982:	0287940b          	th.addsl	s0,a5,s0,1
 1008986:	00144503          	lbu	a0,1(s0)
 100898a:	02000613          	li	a2,32
 100898e:	00c105b3          	add	a1,sp,a2
 1008992:	0512                	slli	a0,a0,0x4
 1008994:	1a050513          	addi	a0,a0,416
 1008998:	c63a                	sw	a4,12(sp)
 100899a:	1b1010ef          	jal	100a34a <boot_otp_read>
 100899e:	4732                	lw	a4,12(sp)
 10089a0:	4641                	li	a2,16
 10089a2:	1014                	addi	a3,sp,32
 10089a4:	00c105b3          	add	a1,sp,a2
 10089a8:	10a8                	addi	a0,sp,104
 10089aa:	6a2010ef          	jal	100a04c <boot_sm2_decrypt>
 10089ae:	f925                	bnez	a0,100891e <boot_decryptFlow+0x76>
 10089b0:	bf2d                	j	10088ea <boot_decryptFlow+0x42>
 10089b2:	00e92023          	sw	a4,0(s2)
 10089b6:	08b4                	addi	a3,sp,88
 10089b8:	0810                	addi	a2,sp,16
 10089ba:	9526                	add	a0,a0,s1
 10089bc:	06e020ef          	jal	100aa2a <boot_sm4_ctr_decrypt>
 10089c0:	b76d                	j	100896a <boot_decryptFlow+0xc2>

010089c2 <ali_image_hash_generate>:
 10089c2:	050032ef          	jal	t0,100ba12 <__riscv_save_0>
 10089c6:	1141                	addi	sp,sp,-16
 10089c8:	1013f6b7          	lui	a3,0x1013f
 10089cc:	842a                	mv	s0,a0
 10089ce:	862e                	mv	a2,a1
 10089d0:	c62e                	sw	a1,12(sp)
 10089d2:	08c68693          	addi	a3,a3,140 # 1013f08c <shareMemory+0x108c>
 10089d6:	85aa                	mv	a1,a0
 10089d8:	4519                	li	a0,6
 10089da:	263010ef          	jal	100a43c <boot_hash>
 10089de:	4632                	lw	a2,12(sp)
 10089e0:	1013f6b7          	lui	a3,0x1013f
 10089e4:	0ac68693          	addi	a3,a3,172 # 1013f0ac <shareMemory+0x10ac>
 10089e8:	85a2                	mv	a1,s0
 10089ea:	4505                	li	a0,1
 10089ec:	251010ef          	jal	100a43c <boot_hash>
 10089f0:	0141                	addi	sp,sp,16
 10089f2:	0440306f          	j	100ba36 <__riscv_restore_0>

010089f6 <main>:
 10089f6:	7ed022ef          	jal	t0,100b9e2 <__riscv_save_12>
 10089fa:	7155                	addi	sp,sp,-208
 10089fc:	05b020ef          	jal	100b256 <platform_init>
 1008a00:	33a020ef          	jal	100ad3a <boot_life_cycle_check>
 1008a04:	40e020ef          	jal	100ae12 <boot_otp_code_check>
 1008a08:	4509                	li	a0,2
 1008a0a:	131010ef          	jal	100a33a <boot_io_read>
 1008a0e:	c111                	beqz	a0,1008a12 <main+0x1c>
 1008a10:	3955                	jal	10086c4 <goto_uart>
 1008a12:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1008a16:	cb89                	beqz	a5,1008a28 <main+0x32>
 1008a18:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008a1c:	010075b7          	lui	a1,0x1007
 1008a20:	7e758593          	addi	a1,a1,2023 # 10077e7 <HAL_UART_Receive+0x1d7>
 1008a24:	4505                	li	a0,1
 1008a26:	9782                	jalr	a5
 1008a28:	450d                	li	a0,3
 1008a2a:	111010ef          	jal	100a33a <boot_io_read>
 1008a2e:	842a                	mv	s0,a0
 1008a30:	4a85                	li	s5,1
 1008a32:	e911                	bnez	a0,1008a46 <main+0x50>
 1008a34:	5a81a403          	lw	s0,1448(gp) # 10138da8 <otp_cfg+0x88>
 1008a38:	1044340b          	th.extu	s0,s0,4,4
 1008a3c:	01544433          	xor	s0,s0,s5
 1008a40:	0ff47413          	zext.b	s0,s0
 1008a44:	8aa2                	mv	s5,s0
 1008a46:	4505                	li	a0,1
 1008a48:	0f3010ef          	jal	100a33a <boot_io_read>
 1008a4c:	4485                	li	s1,1
 1008a4e:	e519                	bnez	a0,1008a5c <main+0x66>
 1008a50:	5a81a483          	lw	s1,1448(gp) # 10138da8 <otp_cfg+0x88>
 1008a54:	0c34b48b          	th.extu	s1,s1,3,3
 1008a58:	0014c493          	xori	s1,s1,1
 1008a5c:	4c05                	li	s8,1
 1008a5e:	01844433          	xor	s0,s0,s8
 1008a62:	0ff47793          	zext.b	a5,s0
 1008a66:	ca3e                	sw	a5,20(sp)
 1008a68:	010087b7          	lui	a5,0x1008
 1008a6c:	83778793          	addi	a5,a5,-1993 # 1007837 <HAL_UART_Receive+0x227>
 1008a70:	4d09                	li	s10,2
 1008a72:	cc3e                	sw	a5,24(sp)
 1008a74:	075010ef          	jal	100a2e8 <boot_flow_get>
 1008a78:	842a                	mv	s0,a0
 1008a7a:	07851763          	bne	a0,s8,1008ae8 <main+0xf2>
 1008a7e:	5a81a403          	lw	s0,1448(gp) # 10138da8 <otp_cfg+0x88>
 1008a82:	fff44413          	not	s0,s0
 1008a86:	8805                	andi	s0,s0,1
 1008a88:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1008a8c:	cb89                	beqz	a5,1008a9e <main+0xa8>
 1008a8e:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008a92:	46d2                	lw	a3,20(sp)
 1008a94:	45e2                	lw	a1,24(sp)
 1008a96:	8726                	mv	a4,s1
 1008a98:	8622                	mv	a2,s0
 1008a9a:	4505                	li	a0,1
 1008a9c:	9782                	jalr	a5
 1008a9e:	cc41                	beqz	s0,1008b36 <main+0x140>
 1008aa0:	09841a63          	bne	s0,s8,1008b34 <main+0x13e>
 1008aa4:	5a81a403          	lw	s0,1448(gp) # 10138da8 <otp_cfg+0x88>
 1008aa8:	8059                	srli	s0,s0,0x16
 1008aaa:	043a                	slli	s0,s0,0xe
 1008aac:	0c048463          	beqz	s1,1008b74 <main+0x17e>
 1008ab0:	8522                	mv	a0,s0
 1008ab2:	0a0a8963          	beqz	s5,1008b64 <main+0x16e>
 1008ab6:	2ef1                	jal	1008e92 <aliBoot_verifyFlow>
 1008ab8:	1013f9b7          	lui	s3,0x1013f
 1008abc:	8a2a                	mv	s4,a0
 1008abe:	00098993          	mv	s3,s3
 1008ac2:	cd25                	beqz	a0,1008b3a <main+0x144>
 1008ac4:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1008ac8:	cb91                	beqz	a5,1008adc <main+0xe6>
 1008aca:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008ace:	010085b7          	lui	a1,0x1008
 1008ad2:	862a                	mv	a2,a0
 1008ad4:	86e58593          	addi	a1,a1,-1938 # 100786e <HAL_UART_Receive+0x25e>
 1008ad8:	4505                	li	a0,1
 1008ada:	9782                	jalr	a5
 1008adc:	0e498593          	addi	a1,s3,228 # 1013f0e4 <shareMemory+0x10e4>
 1008ae0:	8552                	mv	a0,s4
 1008ae2:	77f020ef          	jal	100ba60 <__thead_uwrite4>
 1008ae6:	b779                	j	1008a74 <main+0x7e>
 1008ae8:	fba510e3          	bne	a0,s10,1008a88 <main+0x92>
 1008aec:	5a81a783          	lw	a5,1448(gp) # 10138da8 <otp_cfg+0x88>
 1008af0:	0027f713          	andi	a4,a5,2
 1008af4:	f0071ee3          	bnez	a4,1008a10 <main+0x1a>
 1008af8:	8b91                	andi	a5,a5,4
 1008afa:	d141c703          	lbu	a4,-748(gp) # 10138514 <log_en>
 1008afe:	cf81                	beqz	a5,1008b16 <main+0x120>
 1008b00:	00070a63          	beqz	a4,1008b14 <main+0x11e>
 1008b04:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008b08:	010075b7          	lui	a1,0x1007
 1008b0c:	7fe58593          	addi	a1,a1,2046 # 10077fe <HAL_UART_Receive+0x1ee>
 1008b10:	4505                	li	a0,1
 1008b12:	9782                	jalr	a5
 1008b14:	a001                	j	1008b14 <main+0x11e>
 1008b16:	cb09                	beqz	a4,1008b28 <main+0x132>
 1008b18:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008b1c:	010085b7          	lui	a1,0x1008
 1008b20:	81a58593          	addi	a1,a1,-2022 # 100781a <HAL_UART_Receive+0x20a>
 1008b24:	4505                	li	a0,1
 1008b26:	9782                	jalr	a5
 1008b28:	14a010ef          	jal	1009c72 <clr_startup_part_flag>
 1008b2c:	7bc010ef          	jal	100a2e8 <boot_flow_get>
 1008b30:	842a                	mv	s0,a0
 1008b32:	bf99                	j	1008a88 <main+0x92>
 1008b34:	a001                	j	1008b34 <main+0x13e>
 1008b36:	4401                	li	s0,0
 1008b38:	bf95                	j	1008aac <main+0xb6>
 1008b3a:	8522                	mv	a0,s0
 1008b3c:	102c                	addi	a1,sp,40
 1008b3e:	2d79                	jal	10091dc <aliBoot_decryptFlow>
 1008b40:	842a                	mv	s0,a0
 1008b42:	c53d                	beqz	a0,1008bb0 <main+0x1ba>
 1008b44:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1008b48:	cb91                	beqz	a5,1008b5c <main+0x166>
 1008b4a:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008b4e:	010085b7          	lui	a1,0x1008
 1008b52:	862a                	mv	a2,a0
 1008b54:	89058593          	addi	a1,a1,-1904 # 1007890 <HAL_UART_Receive+0x280>
 1008b58:	4505                	li	a0,1
 1008b5a:	9782                	jalr	a5
 1008b5c:	0e498593          	addi	a1,s3,228
 1008b60:	8522                	mv	a0,s0
 1008b62:	b741                	j	1008ae2 <main+0xec>
 1008b64:	36e9                	jal	100872e <boot_verify_flow>
 1008b66:	f00507e3          	beqz	a0,1008a74 <main+0x7e>
 1008b6a:	85a2                	mv	a1,s0
 1008b6c:	1048                	addi	a0,sp,36
 1008b6e:	3b2d                	jal	10088a8 <boot_decryptFlow>
 1008b70:	e529                	bnez	a0,1008bba <main+0x1c4>
 1008b72:	b709                	j	1008a74 <main+0x7e>
 1008b74:	180a8d63          	beqz	s5,1008d0e <main+0x318>
 1008b78:	8522                	mv	a0,s0
 1008b7a:	102c                	addi	a1,sp,40
 1008b7c:	179000ef          	jal	10094f4 <aliBoot_nonsecure>
 1008b80:	842a                	mv	s0,a0
 1008b82:	c51d                	beqz	a0,1008bb0 <main+0x1ba>
 1008b84:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1008b88:	cb91                	beqz	a5,1008b9c <main+0x1a6>
 1008b8a:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1008b8e:	010085b7          	lui	a1,0x1008
 1008b92:	862a                	mv	a2,a0
 1008b94:	8b358593          	addi	a1,a1,-1869 # 10078b3 <HAL_UART_Receive+0x2a3>
 1008b98:	4505                	li	a0,1
 1008b9a:	9782                	jalr	a5
 1008b9c:	1013f9b7          	lui	s3,0x1013f
 1008ba0:	00098993          	mv	s3,s3
 1008ba4:	0e498593          	addi	a1,s3,228 # 1013f0e4 <shareMemory+0x10e4>
 1008ba8:	8522                	mv	a0,s0
 1008baa:	6b7020ef          	jal	100ba60 <__thead_uwrite4>
 1008bae:	b5d9                	j	1008a74 <main+0x7e>
 1008bb0:	55b2                	lw	a1,44(sp)
 1008bb2:	5542                	lw	a0,48(sp)
 1008bb4:	3539                	jal	10089c2 <ali_image_hash_generate>
 1008bb6:	57c2                	lw	a5,48(sp)
 1008bb8:	d23e                	sw	a5,36(sp)
 1008bba:	02000593          	li	a1,32
 1008bbe:	60018513          	addi	a0,gp,1536 # 10138e00 <otp_cfg+0xe0>
 1008bc2:	06b010ef          	jal	100a42c <boot_crc32>
 1008bc6:	52018a13          	addi	s4,gp,1312 # 10138d20 <otp_cfg>
 1008bca:	0dca2783          	lw	a5,220(s4)
 1008bce:	1013eb37          	lui	s6,0x1013e
 1008bd2:	000b0b13          	mv	s6,s6
 1008bd6:	8f89                	sub	a5,a5,a0
 1008bd8:	6405                	lui	s0,0x1
 1008bda:	945a                	add	s0,s0,s6
 1008bdc:	0017b793          	seqz	a5,a5
 1008be0:	04000993          	li	s3,64
 1008be4:	0ef40423          	sb	a5,232(s0) # 10e8 <Reset_Handler-0xffef18>
 1008be8:	60018693          	addi	a3,gp,1536 # 10138e00 <otp_cfg+0xe0>
 1008bec:	03410893          	addi	a7,sp,52
 1008bf0:	4801                	li	a6,0
 1008bf2:	4781                	li	a5,0
 1008bf4:	02000713          	li	a4,32
 1008bf8:	4601                	li	a2,0
 1008bfa:	4581                	li	a1,0
 1008bfc:	c04e                	sw	s3,0(sp)
 1008bfe:	4505                	li	a0,1
 1008c00:	07e010ef          	jal	1009c7e <boot_hkdf>
 1008c04:	02c00613          	li	a2,44
 1008c08:	060a0593          	addi	a1,s4,96
 1008c0c:	18c8                	addi	a0,sp,116
 1008c0e:	707020ef          	jal	100bb14 <memcpy>
 1008c12:	03000613          	li	a2,48
 1008c16:	0ac40593          	addi	a1,s0,172
 1008c1a:	1108                	addi	a0,sp,160
 1008c1c:	6f9020ef          	jal	100bb14 <memcpy>
 1008c20:	1013fbb7          	lui	s7,0x1013f
 1008c24:	048b8893          	addi	a7,s7,72 # 1013f048 <shareMemory+0x1048>
 1008c28:	4801                	li	a6,0
 1008c2a:	4781                	li	a5,0
 1008c2c:	09c00713          	li	a4,156
 1008c30:	1854                	addi	a3,sp,52
 1008c32:	4601                	li	a2,0
 1008c34:	4581                	li	a1,0
 1008c36:	c04e                	sw	s3,0(sp)
 1008c38:	4505                	li	a0,1
 1008c3a:	044010ef          	jal	1009c7e <boot_hkdf>
 1008c3e:	85ce                	mv	a1,s3
 1008c40:	048b8513          	addi	a0,s7,72
 1008c44:	7e8010ef          	jal	100a42c <boot_crc32>
 1008c48:	08840593          	addi	a1,s0,136
 1008c4c:	615020ef          	jal	100ba60 <__thead_uwrite4>
 1008c50:	02000613          	li	a2,32
 1008c54:	08c40593          	addi	a1,s0,140
 1008c58:	1108                	addi	a0,sp,160
 1008c5a:	1013fcb7          	lui	s9,0x1013f
 1008c5e:	6b7020ef          	jal	100bb14 <memcpy>
 1008c62:	004c8893          	addi	a7,s9,4 # 1013f004 <shareMemory+0x1004>
 1008c66:	4801                	li	a6,0
 1008c68:	4781                	li	a5,0
 1008c6a:	08c00713          	li	a4,140
 1008c6e:	1854                	addi	a3,sp,52
 1008c70:	4601                	li	a2,0
 1008c72:	4581                	li	a1,0
 1008c74:	c04e                	sw	s3,0(sp)
 1008c76:	4519                	li	a0,6
 1008c78:	006010ef          	jal	1009c7e <boot_hkdf>
 1008c7c:	85ce                	mv	a1,s3
 1008c7e:	004c8513          	addi	a0,s9,4
 1008c82:	7aa010ef          	jal	100a42c <boot_crc32>
 1008c86:	04440793          	addi	a5,s0,68
 1008c8a:	85be                	mv	a1,a5
 1008c8c:	ce3e                	sw	a5,28(sp)
 1008c8e:	5d3020ef          	jal	100ba60 <__thead_uwrite4>
 1008c92:	22bd                	jal	1008e00 <gm_algo_check>
 1008c94:	ed11                	bnez	a0,1008cb0 <main+0x2ba>
 1008c96:	000a8d63          	beqz	s5,1008cb0 <main+0x2ba>
 1008c9a:	4581                	li	a1,0
 1008c9c:	864e                	mv	a2,s3
 1008c9e:	004c8513          	addi	a0,s9,4
 1008ca2:	68b020ef          	jal	100bb2c <memset>
 1008ca6:	04440593          	addi	a1,s0,68
 1008caa:	4501                	li	a0,0
 1008cac:	5b5020ef          	jal	100ba60 <__thead_uwrite4>
 1008cb0:	2285                	jal	1008e10 <gj_algo_check>
 1008cb2:	ed19                	bnez	a0,1008cd0 <main+0x2da>
 1008cb4:	000a8e63          	beqz	s5,1008cd0 <main+0x2da>
 1008cb8:	4581                	li	a1,0
 1008cba:	04000613          	li	a2,64
 1008cbe:	048b8513          	addi	a0,s7,72
 1008cc2:	66b020ef          	jal	100bb2c <memset>
 1008cc6:	08840593          	addi	a1,s0,136
 1008cca:	4501                	li	a0,0
 1008ccc:	595020ef          	jal	100ba60 <__thead_uwrite4>
 1008cd0:	a5a54537          	lui	a0,0xa5a54
 1008cd4:	85a2                	mv	a1,s0
 1008cd6:	c3c50513          	addi	a0,a0,-964 # a5a53c3c <bitmap+0x95913cbc>
 1008cda:	587020ef          	jal	100ba60 <__thead_uwrite4>
 1008cde:	6585                	lui	a1,0x1
 1008ce0:	14958593          	addi	a1,a1,329 # 1149 <Reset_Handler-0xffeeb7>
 1008ce4:	855a                	mv	a0,s6
 1008ce6:	746010ef          	jal	100a42c <boot_crc32>
 1008cea:	14940593          	addi	a1,s0,329
 1008cee:	573020ef          	jal	100ba60 <__thead_uwrite4>
 1008cf2:	0de020ef          	jal	100add0 <boot_set_otp_premission>
 1008cf6:	5b8010ef          	jal	100a2ae <boot_open_wdg>
 1008cfa:	1a000613          	li	a2,416
 1008cfe:	4581                	li	a1,0
 1008d00:	8552                	mv	a0,s4
 1008d02:	62b020ef          	jal	100bb2c <memset>
 1008d06:	5512                	lw	a0,36(sp)
 1008d08:	71d000ef          	jal	1009c24 <goto_next>
 1008d0c:	b3a5                	j	1008a74 <main+0x7e>
 1008d0e:	85a2                	mv	a1,s0
 1008d10:	1048                	addi	a0,sp,36
 1008d12:	362d                	jal	100883c <boot_nonsecure>
 1008d14:	bdb1                	j	1008b70 <main+0x17a>

01008d16 <boot_uart_buaddetect_cb>:
 1008d16:	4fd022ef          	jal	t0,100ba12 <__riscv_save_0>
 1008d1a:	1141                	addi	sp,sp,-16
 1008d1c:	4605                	li	a2,1
 1008d1e:	d0018e23          	sb	zero,-740(gp) # 1013851c <uart_rx_offset>
 1008d22:	00f10513          	addi	a0,sp,15
 1008d26:	d001ac23          	sw	zero,-744(gp) # 10138518 <uart_stage>
 1008d2a:	85b2                	mv	a1,a2
 1008d2c:	faa00793          	li	a5,-86
 1008d30:	00f107a3          	sb	a5,15(sp)
 1008d34:	251010ef          	jal	100a784 <boot_uart_write>
 1008d38:	0141                	addi	sp,sp,16
 1008d3a:	4fd0206f          	j	100ba36 <__riscv_restore_0>

01008d3e <boot_uart_tx_cb>:
 1008d3e:	d181a703          	lw	a4,-744(gp) # 10138518 <uart_stage>
 1008d42:	4605                	li	a2,1
 1008d44:	c701                	beqz	a4,1008d4c <boot_uart_tx_cb+0xe>
 1008d46:	00c70a63          	beq	a4,a2,1008d5a <boot_uart_tx_cb+0x1c>
 1008d4a:	8082                	ret
 1008d4c:	85b2                	mv	a1,a2
 1008d4e:	d1d18513          	addi	a0,gp,-739 # 1013851d <uart_rx_byte>
 1008d52:	d0c1ac23          	sw	a2,-744(gp) # 10138518 <uart_stage>
 1008d56:	2050106f          	j	100a75a <boot_uart_read>
 1008d5a:	4709                	li	a4,2
 1008d5c:	d0e1ac23          	sw	a4,-744(gp) # 10138518 <uart_stage>
 1008d60:	8082                	ret

01008d62 <boot_uart_rx_cb>:
 1008d62:	d181a603          	lw	a2,-744(gp) # 10138518 <uart_stage>
 1008d66:	4785                	li	a5,1
 1008d68:	04f61963          	bne	a2,a5,1008dba <boot_uart_rx_cb+0x58>
 1008d6c:	4a7022ef          	jal	t0,100ba12 <__riscv_save_0>
 1008d70:	d1c1c583          	lbu	a1,-740(gp) # 1013851c <uart_rx_offset>
 1008d74:	01009737          	lui	a4,0x1009
 1008d78:	dc070713          	addi	a4,a4,-576 # 1008dc0 <uart_rx_magic_word>
 1008d7c:	80b7468b          	th.lrbu	a3,a4,a1,0
 1008d80:	d1d1c703          	lbu	a4,-739(gp) # 1013851d <uart_rx_byte>
 1008d84:	00e68b63          	beq	a3,a4,1008d9a <boot_uart_rx_cb+0x38>
 1008d88:	d0018e23          	sb	zero,-740(gp) # 1013851c <uart_rx_offset>
 1008d8c:	4605                	li	a2,1
 1008d8e:	85b2                	mv	a1,a2
 1008d90:	d1d18513          	addi	a0,gp,-739 # 1013851d <uart_rx_byte>
 1008d94:	1c7010ef          	jal	100a75a <boot_uart_read>
 1008d98:	a839                	j	1008db6 <boot_uart_rx_cb+0x54>
 1008d9a:	0585                	addi	a1,a1,1
 1008d9c:	0ff5f593          	zext.b	a1,a1
 1008da0:	d0b18e23          	sb	a1,-740(gp) # 1013851c <uart_rx_offset>
 1008da4:	4791                	li	a5,4
 1008da6:	fef593e3          	bne	a1,a5,1008d8c <boot_uart_rx_cb+0x2a>
 1008daa:	01009537          	lui	a0,0x1009
 1008dae:	dbc50513          	addi	a0,a0,-580 # 1008dbc <uart_tx_magic_word>
 1008db2:	1d3010ef          	jal	100a784 <boot_uart_write>
 1008db6:	4810206f          	j	100ba36 <__riscv_restore_0>
 1008dba:	8082                	ret

01008dbc <uart_tx_magic_word>:
 1008dbc:	c3c3 5a5a                                   ..ZZ

01008dc0 <uart_rx_magic_word>:
 1008dc0:	3c3c a5a5                                   <<..

01008dc4 <get_entry_number>:
 1008dc4:	435022ef          	jal	t0,100b9f8 <__riscv_save_4>
 1008dc8:	84aa                	mv	s1,a0
 1008dca:	479020ef          	jal	100ba42 <__thead_uread4>
 1008dce:	892a                	mv	s2,a0
 1008dd0:	4401                	li	s0,0
 1008dd2:	06800a13          	li	s4,104
 1008dd6:	4a85                	li	s5,1
 1008dd8:	01246763          	bltu	s0,s2,1008de6 <get_entry_number+0x22>
 1008ddc:	0ff00413          	li	s0,255
 1008de0:	8522                	mv	a0,s0
 1008de2:	44b0206f          	j	100ba2c <__riscv_restore_4>
 1008de6:	89a6                	mv	s3,s1
 1008de8:	2144198b          	th.mula	s3,s0,s4
 1008dec:	00498513          	addi	a0,s3,4
 1008df0:	453020ef          	jal	100ba42 <__thead_uread4>
 1008df4:	ff5506e3          	beq	a0,s5,1008de0 <get_entry_number+0x1c>
 1008df8:	0405                	addi	s0,s0,1
 1008dfa:	0ff47413          	zext.b	s0,s0
 1008dfe:	bfe9                	j	1008dd8 <get_entry_number+0x14>

01008e00 <gm_algo_check>:
 1008e00:	5a81a783          	lw	a5,1448(gp) # 10138da8 <otp_cfg+0x88>
 1008e04:	6c01a503          	lw	a0,1728(gp) # 10138ec0 <algo_select>
 1008e08:	2cb7b78b          	th.extu	a5,a5,11,11
 1008e0c:	8d7d                	and	a0,a0,a5
 1008e0e:	8082                	ret

01008e10 <gj_algo_check>:
 1008e10:	6c01a503          	lw	a0,1728(gp) # 10138ec0 <algo_select>
 1008e14:	0415350b          	th.extu	a0,a0,1,1
 1008e18:	8082                	ret

01008e1a <aliboot_ecdsa_hash>:
 1008e1a:	3df022ef          	jal	t0,100b9f8 <__riscv_save_4>
 1008e1e:	84ae                	mv	s1,a1
 1008e20:	85be                	mv	a1,a5
 1008e22:	4785                	li	a5,1
 1008e24:	1141                	addi	sp,sp,-16
 1008e26:	842a                	mv	s0,a0
 1008e28:	8932                	mv	s2,a2
 1008e2a:	89b6                	mv	s3,a3
 1008e2c:	02f50263          	beq	a0,a5,1008e50 <aliboot_ecdsa_hash+0x36>
 1008e30:	4799                	li	a5,6
 1008e32:	4501                	li	a0,0
 1008e34:	02f41763          	bne	s0,a5,1008e62 <aliboot_ecdsa_hash+0x48>
 1008e38:	8a3a                	mv	s4,a4
 1008e3a:	c62e                	sw	a1,12(sp)
 1008e3c:	37d1                	jal	1008e00 <gm_algo_check>
 1008e3e:	c115                	beqz	a0,1008e62 <aliboot_ecdsa_hash+0x48>
 1008e40:	45b2                	lw	a1,12(sp)
 1008e42:	874e                	mv	a4,s3
 1008e44:	86ca                	mv	a3,s2
 1008e46:	8626                	mv	a2,s1
 1008e48:	8552                	mv	a0,s4
 1008e4a:	04f010ef          	jal	100a698 <boot_sm3_ecdsa>
 1008e4e:	a809                	j	1008e60 <aliboot_ecdsa_hash+0x46>
 1008e50:	37c1                	jal	1008e10 <gj_algo_check>
 1008e52:	c901                	beqz	a0,1008e62 <aliboot_ecdsa_hash+0x48>
 1008e54:	86ce                	mv	a3,s3
 1008e56:	864a                	mv	a2,s2
 1008e58:	85a6                	mv	a1,s1
 1008e5a:	8522                	mv	a0,s0
 1008e5c:	5e0010ef          	jal	100a43c <boot_hash>
 1008e60:	4505                	li	a0,1
 1008e62:	0141                	addi	sp,sp,16
 1008e64:	3c90206f          	j	100ba2c <__riscv_restore_4>

01008e68 <algo_select_set>:
 1008e68:	5a81a783          	lw	a5,1448(gp) # 10138da8 <otp_cfg+0x88>
 1008e6c:	54e7b70b          	th.extu	a4,a5,21,14
 1008e70:	3ce7b78b          	th.extu	a5,a5,15,14
 1008e74:	c781                	beqz	a5,1008e7c <algo_select_set+0x14>
 1008e76:	6cf1a023          	sw	a5,1728(gp) # 10138ec0 <algo_select>
 1008e7a:	8082                	ret
 1008e7c:	0c27378b          	th.extu	a5,a4,3,2
 1008e80:	fbfd                	bnez	a5,1008e76 <algo_select_set+0xe>
 1008e82:	1447378b          	th.extu	a5,a4,5,4
 1008e86:	fbe5                	bnez	a5,1008e76 <algo_select_set+0xe>
 1008e88:	00675793          	srli	a5,a4,0x6
 1008e8c:	f7ed                	bnez	a5,1008e76 <algo_select_set+0xe>
 1008e8e:	478d                	li	a5,3
 1008e90:	b7dd                	j	1008e76 <algo_select_set+0xe>

01008e92 <aliBoot_verifyFlow>:
 1008e92:	359022ef          	jal	t0,100b9ea <__riscv_save_10>
 1008e96:	7135                	addi	sp,sp,-160
 1008e98:	8aaa                	mv	s5,a0
 1008e9a:	37f9                	jal	1008e68 <algo_select_set>
 1008e9c:	4611                	li	a2,4
 1008e9e:	086c                	addi	a1,sp,28
 1008ea0:	008a8513          	addi	a0,s5,8
 1008ea4:	584010ef          	jal	100a428 <boot_flash_read>
 1008ea8:	4672                	lw	a2,28(sp)
 1008eaa:	6785                	lui	a5,0x1
 1008eac:	54d9                	li	s1,-10
 1008eae:	1af61f63          	bne	a2,a5,100906c <aliBoot_verifyFlow+0x1da>
 1008eb2:	1013e437          	lui	s0,0x1013e
 1008eb6:	00040593          	mv	a1,s0
 1008eba:	8556                	mv	a0,s5
 1008ebc:	56c010ef          	jal	100a428 <boot_flash_read>
 1008ec0:	00040413          	mv	s0,s0
 1008ec4:	00840513          	addi	a0,s0,8 # 1013e008 <shareMemory+0x8>
 1008ec8:	37b020ef          	jal	100ba42 <__thead_uread4>
 1008ecc:	47f2                	lw	a5,28(sp)
 1008ece:	5489                	li	s1,-30
 1008ed0:	18f51e63          	bne	a0,a5,100906c <aliBoot_verifyFlow+0x1da>
 1008ed4:	04400593          	li	a1,68
 1008ed8:	8522                	mv	a0,s0
 1008eda:	552010ef          	jal	100a42c <boot_crc32>
 1008ede:	ce2a                	sw	a0,28(sp)
 1008ee0:	892a                	mv	s2,a0
 1008ee2:	04440513          	addi	a0,s0,68
 1008ee6:	35d020ef          	jal	100ba42 <__thead_uread4>
 1008eea:	fd800493          	li	s1,-40
 1008eee:	16a91f63          	bne	s2,a0,100906c <aliBoot_verifyFlow+0x1da>
 1008ef2:	8522                	mv	a0,s0
 1008ef4:	34f020ef          	jal	100ba42 <__thead_uread4>
 1008ef8:	025357b7          	lui	a5,0x2535
 1008efc:	94178793          	addi	a5,a5,-1727 # 2534941 <__boot_rom_data_lma__+0x1528e01>
 1008f00:	fce00493          	li	s1,-50
 1008f04:	16f51463          	bne	a0,a5,100906c <aliBoot_verifyFlow+0x1da>
 1008f08:	00440513          	addi	a0,s0,4
 1008f0c:	337020ef          	jal	100ba42 <__thead_uread4>
 1008f10:	fcd00493          	li	s1,-51
 1008f14:	14051c63          	bnez	a0,100906c <aliBoot_verifyFlow+0x1da>
 1008f18:	02c40a13          	addi	s4,s0,44
 1008f1c:	8552                	mv	a0,s4
 1008f1e:	325020ef          	jal	100ba42 <__thead_uread4>
 1008f22:	52018b13          	addi	s6,gp,1312 # 10138d20 <otp_cfg>
 1008f26:	100b2783          	lw	a5,256(s6) # 1013e100 <shareMemory+0x100>
 1008f2a:	fcc00493          	li	s1,-52
 1008f2e:	00a7d7b3          	srl	a5,a5,a0
 1008f32:	8b85                	andi	a5,a5,1
 1008f34:	12078c63          	beqz	a5,100906c <aliBoot_verifyFlow+0x1da>
 1008f38:	04840513          	addi	a0,s0,72
 1008f3c:	307020ef          	jal	100ba42 <__thead_uread4>
 1008f40:	015357b7          	lui	a5,0x1535
 1008f44:	94178793          	addi	a5,a5,-1727 # 1534941 <__boot_rom_data_lma__+0x528e01>
 1008f48:	fc400493          	li	s1,-60
 1008f4c:	12f51063          	bne	a0,a5,100906c <aliBoot_verifyFlow+0x1da>
 1008f50:	04c40513          	addi	a0,s0,76
 1008f54:	2ef020ef          	jal	100ba42 <__thead_uread4>
 1008f58:	fc300493          	li	s1,-61
 1008f5c:	10051863          	bnez	a0,100906c <aliBoot_verifyFlow+0x1da>
 1008f60:	1013e537          	lui	a0,0x1013e
 1008f64:	4641                	li	a2,16
 1008f66:	69018593          	addi	a1,gp,1680 # 10138e90 <otp_cfg+0x170>
 1008f6a:	05050513          	addi	a0,a0,80 # 1013e050 <shareMemory+0x50>
 1008f6e:	381020ef          	jal	100baee <memcmp>
 1008f72:	fc200493          	li	s1,-62
 1008f76:	0e051b63          	bnez	a0,100906c <aliBoot_verifyFlow+0x1da>
 1008f7a:	06040993          	addi	s3,s0,96
 1008f7e:	854e                	mv	a0,s3
 1008f80:	2c3020ef          	jal	100ba42 <__thead_uread4>
 1008f84:	104b2903          	lw	s2,260(s6)
 1008f88:	fc100493          	li	s1,-63
 1008f8c:	00a95933          	srl	s2,s2,a0
 1008f90:	00197913          	andi	s2,s2,1
 1008f94:	0c090c63          	beqz	s2,100906c <aliBoot_verifyFlow+0x1da>
 1008f98:	46840b13          	addi	s6,s0,1128
 1008f9c:	855a                	mv	a0,s6
 1008f9e:	2a5020ef          	jal	100ba42 <__thead_uread4>
 1008fa2:	4799                	li	a5,6
 1008fa4:	84aa                	mv	s1,a0
 1008fa6:	00f51763          	bne	a0,a5,1008fb4 <aliBoot_verifyFlow+0x122>
 1008faa:	3d99                	jal	1008e00 <gm_algo_check>
 1008fac:	e561                	bnez	a0,1009074 <aliBoot_verifyFlow+0x1e2>
 1008fae:	fc000493          	li	s1,-64
 1008fb2:	a86d                	j	100906c <aliBoot_verifyFlow+0x1da>
 1008fb4:	3db1                	jal	1008e10 <gj_algo_check>
 1008fb6:	dd65                	beqz	a0,1008fae <aliBoot_verifyFlow+0x11c>
 1008fb8:	03000b93          	li	s7,48
 1008fbc:	66018493          	addi	s1,gp,1632 # 10138e60 <otp_cfg+0x140>
 1008fc0:	1013e5b7          	lui	a1,0x1013e
 1008fc4:	40400613          	li	a2,1028
 1008fc8:	46858593          	addi	a1,a1,1128 # 1013e468 <shareMemory+0x468>
 1008fcc:	854a                	mv	a0,s2
 1008fce:	1094                	addi	a3,sp,96
 1008fd0:	46c010ef          	jal	100a43c <boot_hash>
 1008fd4:	865e                	mv	a2,s7
 1008fd6:	108c                	addi	a1,sp,96
 1008fd8:	8526                	mv	a0,s1
 1008fda:	315020ef          	jal	100baee <memcmp>
 1008fde:	f961                	bnez	a0,1008fae <aliBoot_verifyFlow+0x11c>
 1008fe0:	7ff40913          	addi	s2,s0,2047
 1008fe4:	07094503          	lbu	a0,112(s2)
 1008fe8:	06f94803          	lbu	a6,111(s2)
 1008fec:	1013ec37          	lui	s8,0x1013e
 1008ff0:	0522                	slli	a0,a0,0x8
 1008ff2:	1013ebb7          	lui	s7,0x1013e
 1008ff6:	6605                	lui	a2,0x1
 1008ff8:	1013e5b7          	lui	a1,0x1013e
 1008ffc:	66cc0793          	addi	a5,s8,1644 # 1013e66c <shareMemory+0x66c>
 1009000:	46cb8713          	addi	a4,s7,1132 # 1013e46c <shareMemory+0x46c>
 1009004:	1094                	addi	a3,sp,96
 1009006:	82860613          	addi	a2,a2,-2008 # 828 <Reset_Handler-0xfff7d8>
 100900a:	04858593          	addi	a1,a1,72 # 1013e048 <shareMemory+0x48>
 100900e:	01056533          	or	a0,a0,a6
 1009012:	3521                	jal	1008e1a <aliboot_ecdsa_hash>
 1009014:	fbf00493          	li	s1,-65
 1009018:	c931                	beqz	a0,100906c <aliBoot_verifyFlow+0x1da>
 100901a:	855a                	mv	a0,s6
 100901c:	227020ef          	jal	100ba42 <__thead_uread4>
 1009020:	1013f737          	lui	a4,0x1013f
 1009024:	87070713          	addi	a4,a4,-1936 # 1013e870 <shareMemory+0x870>
 1009028:	1094                	addi	a3,sp,96
 100902a:	66cc0613          	addi	a2,s8,1644
 100902e:	46cb8593          	addi	a1,s7,1132
 1009032:	325010ef          	jal	100ab56 <boot_ecc_verify>
 1009036:	fbe00493          	li	s1,-66
 100903a:	c90d                	beqz	a0,100906c <aliBoot_verifyFlow+0x1da>
 100903c:	60094503          	lbu	a0,1536(s2)
 1009040:	5ff94803          	lbu	a6,1535(s2)
 1009044:	1013eb37          	lui	s6,0x1013e
 1009048:	0522                	slli	a0,a0,0x8
 100904a:	1013e4b7          	lui	s1,0x1013e
 100904e:	6605                	lui	a2,0x1
 1009050:	268b0793          	addi	a5,s6,616 # 1013e268 <shareMemory+0x268>
 1009054:	06848713          	addi	a4,s1,104 # 1013e068 <shareMemory+0x68>
 1009058:	1014                	addi	a3,sp,32
 100905a:	e0060613          	addi	a2,a2,-512 # e00 <Reset_Handler-0xfff200>
 100905e:	85a2                	mv	a1,s0
 1009060:	01056533          	or	a0,a0,a6
 1009064:	3b5d                	jal	1008e1a <aliboot_ecdsa_hash>
 1009066:	ed09                	bnez	a0,1009080 <aliBoot_verifyFlow+0x1ee>
 1009068:	fba00493          	li	s1,-70
 100906c:	8526                	mv	a0,s1
 100906e:	610d                	addi	sp,sp,160
 1009070:	1b30206f          	j	100ba22 <__riscv_restore_10>
 1009074:	8926                	mv	s2,s1
 1009076:	02000b93          	li	s7,32
 100907a:	64018493          	addi	s1,gp,1600 # 10138e40 <otp_cfg+0x120>
 100907e:	b789                	j	1008fc0 <aliBoot_verifyFlow+0x12e>
 1009080:	06440513          	addi	a0,s0,100
 1009084:	1bf020ef          	jal	100ba42 <__thead_uread4>
 1009088:	1013f737          	lui	a4,0x1013f
 100908c:	06848593          	addi	a1,s1,104
 1009090:	e0070713          	addi	a4,a4,-512 # 1013ee00 <shareMemory+0xe00>
 1009094:	1014                	addi	a3,sp,32
 1009096:	268b0613          	addi	a2,s6,616
 100909a:	2bd010ef          	jal	100ab56 <boot_ecc_verify>
 100909e:	fb900493          	li	s1,-71
 10090a2:	d569                	beqz	a0,100906c <aliBoot_verifyFlow+0x1da>
 10090a4:	27190913          	addi	s2,s2,625
 10090a8:	854a                	mv	a0,s2
 10090aa:	199020ef          	jal	100ba42 <__thead_uread4>
 10090ae:	157d                	addi	a0,a0,-1
 10090b0:	479d                	li	a5,7
 10090b2:	fb000493          	li	s1,-80
 10090b6:	faa7ebe3          	bltu	a5,a0,100906c <aliBoot_verifyFlow+0x1da>
 10090ba:	854a                	mv	a0,s2
 10090bc:	3321                	jal	1008dc4 <get_entry_number>
 10090be:	0ff00793          	li	a5,255
 10090c2:	892a                	mv	s2,a0
 10090c4:	faf00493          	li	s1,-81
 10090c8:	faf502e3          	beq	a0,a5,100906c <aliBoot_verifyFlow+0x1da>
 10090cc:	8b22                	mv	s6,s0
 10090ce:	06800b93          	li	s7,104
 10090d2:	21751b0b          	th.mula	s6,a0,s7
 10090d6:	7ffb0b13          	addi	s6,s6,2047
 10090da:	299b0513          	addi	a0,s6,665
 10090de:	165020ef          	jal	100ba42 <__thead_uread4>
 10090e2:	4785                	li	a5,1
 10090e4:	06f50c63          	beq	a0,a5,100915c <aliBoot_verifyFlow+0x2ca>
 10090e8:	4799                	li	a5,6
 10090ea:	08f50d63          	beq	a0,a5,1009184 <aliBoot_verifyFlow+0x2f2>
 10090ee:	fab00493          	li	s1,-85
 10090f2:	fd2d                	bnez	a0,100906c <aliBoot_verifyFlow+0x1da>
 10090f4:	3b31                	jal	1008e10 <gj_algo_check>
 10090f6:	fae00493          	li	s1,-82
 10090fa:	d92d                	beqz	a0,100906c <aliBoot_verifyFlow+0x1da>
 10090fc:	289b0513          	addi	a0,s6,649
 1009100:	143020ef          	jal	100ba42 <__thead_uread4>
 1009104:	c62a                	sw	a0,12(sp)
 1009106:	281b0513          	addi	a0,s6,641
 100910a:	139020ef          	jal	100ba42 <__thead_uread4>
 100910e:	45b2                	lw	a1,12(sp)
 1009110:	1090                	addi	a2,sp,96
 1009112:	9556                	add	a0,a0,s5
 1009114:	84da                	mv	s1,s6
 1009116:	362010ef          	jal	100a478 <boot_sha256_flash>
 100911a:	06800793          	li	a5,104
 100911e:	02f90933          	mul	s2,s2,a5
 1009122:	6585                	lui	a1,0x1
 1009124:	a9c58593          	addi	a1,a1,-1380 # a9c <Reset_Handler-0xfff564>
 1009128:	95ca                	add	a1,a1,s2
 100912a:	9922                	add	s2,s2,s0
 100912c:	7ff90913          	addi	s2,s2,2047
 1009130:	95a2                	add	a1,a1,s0
 1009132:	29990513          	addi	a0,s2,665
 1009136:	c62e                	sw	a1,12(sp)
 1009138:	10b020ef          	jal	100ba42 <__thead_uread4>
 100913c:	45b2                	lw	a1,12(sp)
 100913e:	157d                	addi	a0,a0,-1
 1009140:	02000793          	li	a5,32
 1009144:	03000613          	li	a2,48
 1009148:	42a7960b          	th.mvnez	a2,a5,a0
 100914c:	1088                	addi	a0,sp,96
 100914e:	1a1020ef          	jal	100baee <memcmp>
 1009152:	84aa                	mv	s1,a0
 1009154:	c13d                	beqz	a0,10091ba <aliBoot_verifyFlow+0x328>
 1009156:	faa00493          	li	s1,-86
 100915a:	bf09                	j	100906c <aliBoot_verifyFlow+0x1da>
 100915c:	3955                	jal	1008e10 <gj_algo_check>
 100915e:	fad00493          	li	s1,-83
 1009162:	f00505e3          	beqz	a0,100906c <aliBoot_verifyFlow+0x1da>
 1009166:	289b0513          	addi	a0,s6,649
 100916a:	0d9020ef          	jal	100ba42 <__thead_uread4>
 100916e:	c62a                	sw	a0,12(sp)
 1009170:	281b0513          	addi	a0,s6,641
 1009174:	0cf020ef          	jal	100ba42 <__thead_uread4>
 1009178:	45b2                	lw	a1,12(sp)
 100917a:	1090                	addi	a2,sp,96
 100917c:	9556                	add	a0,a0,s5
 100917e:	374010ef          	jal	100a4f2 <boot_sha384_flash>
 1009182:	bf61                	j	100911a <aliBoot_verifyFlow+0x288>
 1009184:	39b5                	jal	1008e00 <gm_algo_check>
 1009186:	fac00493          	li	s1,-84
 100918a:	ee0501e3          	beqz	a0,100906c <aliBoot_verifyFlow+0x1da>
 100918e:	06800793          	li	a5,104
 1009192:	84a2                	mv	s1,s0
 1009194:	20f9148b          	th.mula	s1,s2,a5
 1009198:	7ff48493          	addi	s1,s1,2047
 100919c:	28948513          	addi	a0,s1,649
 10091a0:	0a3020ef          	jal	100ba42 <__thead_uread4>
 10091a4:	c62a                	sw	a0,12(sp)
 10091a6:	28148513          	addi	a0,s1,641
 10091aa:	099020ef          	jal	100ba42 <__thead_uread4>
 10091ae:	45b2                	lw	a1,12(sp)
 10091b0:	1090                	addi	a2,sp,96
 10091b2:	9556                	add	a0,a0,s5
 10091b4:	3b8010ef          	jal	100a56c <boot_sm3_flash>
 10091b8:	b78d                	j	100911a <aliBoot_verifyFlow+0x288>
 10091ba:	8552                	mv	a0,s4
 10091bc:	087020ef          	jal	100ba42 <__thead_uread4>
 10091c0:	6785                	lui	a5,0x1
 10091c2:	943e                	add	s0,s0,a5
 10091c4:	0dc40593          	addi	a1,s0,220
 10091c8:	099020ef          	jal	100ba60 <__thead_uwrite4>
 10091cc:	854e                	mv	a0,s3
 10091ce:	075020ef          	jal	100ba42 <__thead_uread4>
 10091d2:	0e040593          	addi	a1,s0,224
 10091d6:	08b020ef          	jal	100ba60 <__thead_uwrite4>
 10091da:	bd49                	j	100906c <aliBoot_verifyFlow+0x1da>

010091dc <aliBoot_decryptFlow>:
 10091dc:	00f022ef          	jal	t0,100b9ea <__riscv_save_10>
 10091e0:	89aa                	mv	s3,a0
 10091e2:	1013f537          	lui	a0,0x1013f
 10091e6:	cc010113          	addi	sp,sp,-832
 10091ea:	a7050513          	addi	a0,a0,-1424 # 1013ea70 <shareMemory+0xa70>
 10091ee:	842e                	mv	s0,a1
 10091f0:	3ed1                	jal	1008dc4 <get_entry_number>
 10091f2:	0ff00793          	li	a5,255
 10091f6:	2ef50c63          	beq	a0,a5,10094ee <aliBoot_decryptFlow+0x312>
 10091fa:	1013e4b7          	lui	s1,0x1013e
 10091fe:	06800793          	li	a5,104
 1009202:	00048493          	mv	s1,s1
 1009206:	20f5148b          	th.mula	s1,a0,a5
 100920a:	7ff48493          	addi	s1,s1,2047 # 1013e7ff <shareMemory+0x7ff>
 100920e:	27948513          	addi	a0,s1,633
 1009212:	031020ef          	jal	100ba42 <__thead_uread4>
 1009216:	c408                	sw	a0,8(s0)
 1009218:	28148513          	addi	a0,s1,641
 100921c:	027020ef          	jal	100ba42 <__thead_uread4>
 1009220:	892a                	mv	s2,a0
 1009222:	c008                	sw	a0,0(s0)
 1009224:	28948513          	addi	a0,s1,649
 1009228:	01b020ef          	jal	100ba42 <__thead_uread4>
 100922c:	24000613          	li	a2,576
 1009230:	020c                	addi	a1,sp,256
 1009232:	c048                	sw	a0,4(s0)
 1009234:	01390533          	add	a0,s2,s3
 1009238:	1f0010ef          	jal	100a428 <boot_flash_read>
 100923c:	10012703          	lw	a4,256(sp)
 1009240:	035357b7          	lui	a5,0x3535
 1009244:	94178793          	addi	a5,a5,-1727 # 3534941 <__boot_rom_data_lma__+0x2528e01>
 1009248:	00f70e63          	beq	a4,a5,1009264 <aliBoot_decryptFlow+0x88>
 100924c:	4008                	lw	a0,0(s0)
 100924e:	4050                	lw	a2,4(s0)
 1009250:	440c                	lw	a1,8(s0)
 1009252:	954e                	add	a0,a0,s3
 1009254:	1d4010ef          	jal	100a428 <boot_flash_read>
 1009258:	4781                	li	a5,0
 100925a:	853e                	mv	a0,a5
 100925c:	34010113          	addi	sp,sp,832
 1009260:	7c20206f          	j	100ba22 <__riscv_restore_10>
 1009264:	10614b03          	lbu	s6,262(sp)
 1009268:	10514d03          	lbu	s10,261(sp)
 100926c:	52018a93          	addi	s5,gp,1312 # 10138d20 <otp_cfg>
 1009270:	0c0b0b13          	addi	s6,s6,192
 1009274:	4bc1                	li	s7,16
 1009276:	fffd0793          	addi	a5,s10,-1
 100927a:	02000a13          	li	s4,32
 100927e:	036a9c8b          	th.addsl	s9,s5,s6,1
 1009282:	42fb9a0b          	th.mvnez	s4,s7,a5
 1009286:	001cc783          	lbu	a5,1(s9)
 100928a:	1a000913          	li	s2,416
 100928e:	854a                	mv	a0,s2
 1009290:	20fb950b          	th.mula	a0,s7,a5
 1009294:	a36ac48b          	th.lrhu	s1,s5,s6,1
 1009298:	10ac                	addi	a1,sp,104
 100929a:	8c5e                	mv	s8,s7
 100929c:	0f04f493          	andi	s1,s1,240
 10092a0:	8626                	mv	a2,s1
 10092a2:	0a8010ef          	jal	100a34a <boot_otp_read>
 10092a6:	10714703          	lbu	a4,263(sp)
 10092aa:	13770363          	beq	a4,s7,10093d0 <aliBoot_decryptFlow+0x1f4>
 10092ae:	00ebea63          	bltu	s7,a4,10092c2 <aliBoot_decryptFlow+0xe6>
 10092b2:	04070b63          	beqz	a4,1009308 <aliBoot_decryptFlow+0x12c>
 10092b6:	4785                	li	a5,1
 10092b8:	08f70763          	beq	a4,a5,1009346 <aliBoot_decryptFlow+0x16a>
 10092bc:	f9300793          	li	a5,-109
 10092c0:	bf69                	j	100925a <aliBoot_decryptFlow+0x7e>
 10092c2:	47c5                	li	a5,17
 10092c4:	14f70563          	beq	a4,a5,100940e <aliBoot_decryptFlow+0x232>
 10092c8:	47c9                	li	a5,18
 10092ca:	fef719e3          	bne	a4,a5,10092bc <aliBoot_decryptFlow+0xe0>
 10092ce:	3689                	jal	1008e10 <gj_algo_check>
 10092d0:	f9000793          	li	a5,-112
 10092d4:	d159                	beqz	a0,100925a <aliBoot_decryptFlow+0x7e>
 10092d6:	001cc783          	lbu	a5,1(s9)
 10092da:	854a                	mv	a0,s2
 10092dc:	8626                	mv	a2,s1
 10092de:	2977950b          	th.mulah	a0,a5,s7
 10092e2:	10ac                	addi	a1,sp,104
 10092e4:	066010ef          	jal	100a34a <boot_otp_read>
 10092e8:	4781                	li	a5,0
 10092ea:	c052                	sw	s4,0(sp)
 10092ec:	02810893          	addi	a7,sp,40
 10092f0:	4801                	li	a6,0
 10092f2:	8726                	mv	a4,s1
 10092f4:	10b4                	addi	a3,sp,104
 10092f6:	4611                	li	a2,4
 10092f8:	022c                	addi	a1,sp,264
 10092fa:	4505                	li	a0,1
 10092fc:	183000ef          	jal	1009c7e <boot_hkdf>
 1009300:	f9600793          	li	a5,-106
 1009304:	ed11                	bnez	a0,1009320 <aliBoot_decryptFlow+0x144>
 1009306:	bf91                	j	100925a <aliBoot_decryptFlow+0x7e>
 1009308:	a36ac70b          	th.lrhu	a4,s5,s6,1
 100930c:	f9500793          	li	a5,-107
 1009310:	8b3d                	andi	a4,a4,15
 1009312:	f5a714e3          	bne	a4,s10,100925a <aliBoot_decryptFlow+0x7e>
 1009316:	8626                	mv	a2,s1
 1009318:	10ac                	addi	a1,sp,104
 100931a:	1028                	addi	a0,sp,40
 100931c:	7f8020ef          	jal	100bb14 <memcpy>
 1009320:	4004                	lw	s1,0(s0)
 1009322:	404c                	lw	a1,4(s0)
 1009324:	10514903          	lbu	s2,261(sp)
 1009328:	24048493          	addi	s1,s1,576
 100932c:	dc058593          	addi	a1,a1,-576
 1009330:	c004                	sw	s1,0(s0)
 1009332:	c04c                	sw	a1,4(s0)
 1009334:	4785                	li	a5,1
 1009336:	10f90b63          	beq	s2,a5,100944c <aliBoot_decryptFlow+0x270>
 100933a:	4789                	li	a5,2
 100933c:	16f90163          	beq	s2,a5,100949e <aliBoot_decryptFlow+0x2c2>
 1009340:	f9f00793          	li	a5,-97
 1009344:	bf19                	j	100925a <aliBoot_decryptFlow+0x7e>
 1009346:	a36ac68b          	th.lrhu	a3,s5,s6,1
 100934a:	4789                	li	a5,2
 100934c:	8abd                	andi	a3,a3,15
 100934e:	04f68563          	beq	a3,a5,1009398 <aliBoot_decryptFlow+0x1bc>
 1009352:	4799                	li	a5,6
 1009354:	04f68e63          	beq	a3,a5,10093b0 <aliBoot_decryptFlow+0x1d4>
 1009358:	f9400793          	li	a5,-108
 100935c:	eee69fe3          	bne	a3,a4,100925a <aliBoot_decryptFlow+0x7e>
 1009360:	3c45                	jal	1008e10 <gj_algo_check>
 1009362:	e501                	bnez	a0,100936a <aliBoot_decryptFlow+0x18e>
 1009364:	f9c00793          	li	a5,-100
 1009368:	bdcd                	j	100925a <aliBoot_decryptFlow+0x7e>
 100936a:	1130                	addi	a2,sp,168
 100936c:	10ac                	addi	a1,sp,104
 100936e:	1a08                	addi	a0,sp,304
 1009370:	44a010ef          	jal	100a7ba <boot_aes_kek_decrypt>
 1009374:	d965                	beqz	a0,1009364 <aliBoot_decryptFlow+0x188>
 1009376:	46ae                	lw	a3,200(sp)
 1009378:	4701                	li	a4,0
 100937a:	4781                	li	a5,0
 100937c:	112c                	addi	a1,sp,168
 100937e:	4621                	li	a2,8
 1009380:	44f5c50b          	th.lrw	a0,a1,a5,2
 1009384:	0785                	addi	a5,a5,1
 1009386:	8f29                	xor	a4,a4,a0
 1009388:	fec79ce3          	bne	a5,a2,1009380 <aliBoot_decryptFlow+0x1a4>
 100938c:	f9900793          	li	a5,-103
 1009390:	ece695e3          	bne	a3,a4,100925a <aliBoot_decryptFlow+0x7e>
 1009394:	8652                	mv	a2,s4
 1009396:	b751                	j	100931a <aliBoot_decryptFlow+0x13e>
 1009398:	34a5                	jal	1008e00 <gm_algo_check>
 100939a:	e501                	bnez	a0,10093a2 <aliBoot_decryptFlow+0x1c6>
 100939c:	f9b00793          	li	a5,-101
 10093a0:	bd6d                	j	100925a <aliBoot_decryptFlow+0x7e>
 10093a2:	1130                	addi	a2,sp,168
 10093a4:	10ac                	addi	a1,sp,104
 10093a6:	1a08                	addi	a0,sp,304
 10093a8:	4a6010ef          	jal	100a84e <boot_sm4_kek_decrypt>
 10093ac:	f569                	bnez	a0,1009376 <aliBoot_decryptFlow+0x19a>
 10093ae:	b7fd                	j	100939c <aliBoot_decryptFlow+0x1c0>
 10093b0:	ce3a                	sw	a4,28(sp)
 10093b2:	34b9                	jal	1008e00 <gm_algo_check>
 10093b4:	4772                	lw	a4,28(sp)
 10093b6:	e501                	bnez	a0,10093be <aliBoot_decryptFlow+0x1e2>
 10093b8:	f9a00793          	li	a5,-102
 10093bc:	bd79                	j	100925a <aliBoot_decryptFlow+0x7e>
 10093be:	10b4                	addi	a3,sp,104
 10093c0:	03000613          	li	a2,48
 10093c4:	112c                	addi	a1,sp,168
 10093c6:	1a08                	addi	a0,sp,304
 10093c8:	485000ef          	jal	100a04c <boot_sm2_decrypt>
 10093cc:	f54d                	bnez	a0,1009376 <aliBoot_decryptFlow+0x19a>
 10093ce:	b7ed                	j	10093b8 <aliBoot_decryptFlow+0x1dc>
 10093d0:	3c05                	jal	1008e00 <gm_algo_check>
 10093d2:	f9200793          	li	a5,-110
 10093d6:	e80502e3          	beqz	a0,100925a <aliBoot_decryptFlow+0x7e>
 10093da:	001cc783          	lbu	a5,1(s9)
 10093de:	854a                	mv	a0,s2
 10093e0:	8626                	mv	a2,s1
 10093e2:	2977950b          	th.mulah	a0,a5,s7
 10093e6:	10ac                	addi	a1,sp,104
 10093e8:	763000ef          	jal	100a34a <boot_otp_read>
 10093ec:	02810893          	addi	a7,sp,40
 10093f0:	c052                	sw	s4,0(sp)
 10093f2:	4801                	li	a6,0
 10093f4:	4781                	li	a5,0
 10093f6:	8726                	mv	a4,s1
 10093f8:	10b4                	addi	a3,sp,104
 10093fa:	4611                	li	a2,4
 10093fc:	022c                	addi	a1,sp,264
 10093fe:	4519                	li	a0,6
 1009400:	07f000ef          	jal	1009c7e <boot_hkdf>
 1009404:	f0051ee3          	bnez	a0,1009320 <aliBoot_decryptFlow+0x144>
 1009408:	f9800793          	li	a5,-104
 100940c:	b5b9                	j	100925a <aliBoot_decryptFlow+0x7e>
 100940e:	3409                	jal	1008e10 <gj_algo_check>
 1009410:	f9100793          	li	a5,-111
 1009414:	e40503e3          	beqz	a0,100925a <aliBoot_decryptFlow+0x7e>
 1009418:	001cc783          	lbu	a5,1(s9)
 100941c:	854a                	mv	a0,s2
 100941e:	8626                	mv	a2,s1
 1009420:	2977950b          	th.mulah	a0,a5,s7
 1009424:	10ac                	addi	a1,sp,104
 1009426:	725000ef          	jal	100a34a <boot_otp_read>
 100942a:	02810893          	addi	a7,sp,40
 100942e:	c052                	sw	s4,0(sp)
 1009430:	4801                	li	a6,0
 1009432:	4781                	li	a5,0
 1009434:	8726                	mv	a4,s1
 1009436:	10b4                	addi	a3,sp,104
 1009438:	4611                	li	a2,4
 100943a:	022c                	addi	a1,sp,264
 100943c:	4501                	li	a0,0
 100943e:	041000ef          	jal	1009c7e <boot_hkdf>
 1009442:	ec051fe3          	bnez	a0,1009320 <aliBoot_decryptFlow+0x144>
 1009446:	f9700793          	li	a5,-105
 100944a:	bd01                	j	100925a <aliBoot_decryptFlow+0x7e>
 100944c:	ce2e                	sw	a1,28(sp)
 100944e:	32c9                	jal	1008e10 <gj_algo_check>
 1009450:	fa500793          	li	a5,-91
 1009454:	e00503e3          	beqz	a0,100925a <aliBoot_decryptFlow+0x7e>
 1009458:	10414703          	lbu	a4,260(sp)
 100945c:	45f2                	lw	a1,28(sp)
 100945e:	cf11                	beqz	a4,100947a <aliBoot_decryptFlow+0x29e>
 1009460:	4689                	li	a3,2
 1009462:	fa300793          	li	a5,-93
 1009466:	ded71ae3          	bne	a4,a3,100925a <aliBoot_decryptFlow+0x7e>
 100946a:	4418                	lw	a4,8(s0)
 100946c:	0a14                	addi	a3,sp,272
 100946e:	1030                	addi	a2,sp,40
 1009470:	01348533          	add	a0,s1,s3
 1009474:	45e010ef          	jal	100a8d2 <boot_aes_ctr_decrypt>
 1009478:	b3c5                	j	1009258 <aliBoot_decryptFlow+0x7c>
 100947a:	10c15783          	lhu	a5,268(sp)
 100947e:	10e15883          	lhu	a7,270(sp)
 1009482:	4410                	lw	a2,8(s0)
 1009484:	12010813          	addi	a6,sp,288
 1009488:	0a18                	addi	a4,sp,272
 100948a:	1034                	addi	a3,sp,40
 100948c:	01348533          	add	a0,s1,s3
 1009490:	4de010ef          	jal	100a96e <boot_aes_gcm_decrypt>
 1009494:	fa400793          	li	a5,-92
 1009498:	dc0510e3          	bnez	a0,1009258 <aliBoot_decryptFlow+0x7c>
 100949c:	bb7d                	j	100925a <aliBoot_decryptFlow+0x7e>
 100949e:	ce2e                	sw	a1,28(sp)
 10094a0:	3285                	jal	1008e00 <gm_algo_check>
 10094a2:	fa200793          	li	a5,-94
 10094a6:	da050ae3          	beqz	a0,100925a <aliBoot_decryptFlow+0x7e>
 10094aa:	10414703          	lbu	a4,260(sp)
 10094ae:	45f2                	lw	a1,28(sp)
 10094b0:	cf09                	beqz	a4,10094ca <aliBoot_decryptFlow+0x2ee>
 10094b2:	fa000793          	li	a5,-96
 10094b6:	db2712e3          	bne	a4,s2,100925a <aliBoot_decryptFlow+0x7e>
 10094ba:	4418                	lw	a4,8(s0)
 10094bc:	0a14                	addi	a3,sp,272
 10094be:	1030                	addi	a2,sp,40
 10094c0:	01348533          	add	a0,s1,s3
 10094c4:	566010ef          	jal	100aa2a <boot_sm4_ctr_decrypt>
 10094c8:	bb41                	j	1009258 <aliBoot_decryptFlow+0x7c>
 10094ca:	10c15783          	lhu	a5,268(sp)
 10094ce:	10e15883          	lhu	a7,270(sp)
 10094d2:	4410                	lw	a2,8(s0)
 10094d4:	12010813          	addi	a6,sp,288
 10094d8:	0a18                	addi	a4,sp,272
 10094da:	1034                	addi	a3,sp,40
 10094dc:	01348533          	add	a0,s1,s3
 10094e0:	5d6010ef          	jal	100aab6 <boot_sm4_gcm_decrypt>
 10094e4:	fa100793          	li	a5,-95
 10094e8:	d60518e3          	bnez	a0,1009258 <aliBoot_decryptFlow+0x7c>
 10094ec:	b3bd                	j	100925a <aliBoot_decryptFlow+0x7e>
 10094ee:	faf00793          	li	a5,-81
 10094f2:	b3a5                	j	100925a <aliBoot_decryptFlow+0x7e>

010094f4 <aliBoot_nonsecure>:
 10094f4:	504022ef          	jal	t0,100b9f8 <__riscv_save_4>
 10094f8:	1013e437          	lui	s0,0x1013e
 10094fc:	1141                	addi	sp,sp,-16
 10094fe:	6605                	lui	a2,0x1
 1009500:	84ae                	mv	s1,a1
 1009502:	00040593          	mv	a1,s0
 1009506:	89aa                	mv	s3,a0
 1009508:	721000ef          	jal	100a428 <boot_flash_read>
 100950c:	00040513          	mv	a0,s0
 1009510:	04400593          	li	a1,68
 1009514:	719000ef          	jal	100a42c <boot_crc32>
 1009518:	00040413          	mv	s0,s0
 100951c:	892a                	mv	s2,a0
 100951e:	04440513          	addi	a0,s0,68 # 1013e044 <shareMemory+0x44>
 1009522:	520020ef          	jal	100ba42 <__thead_uread4>
 1009526:	07251063          	bne	a0,s2,1009586 <aliBoot_nonsecure+0x92>
 100952a:	1013f537          	lui	a0,0x1013f
 100952e:	a7050513          	addi	a0,a0,-1424 # 1013ea70 <shareMemory+0xa70>
 1009532:	893ff0ef          	jal	1008dc4 <get_entry_number>
 1009536:	87aa                	mv	a5,a0
 1009538:	0ff00713          	li	a4,255
 100953c:	faf00513          	li	a0,-81
 1009540:	04e78063          	beq	a5,a4,1009580 <aliBoot_nonsecure+0x8c>
 1009544:	06800713          	li	a4,104
 1009548:	20e7940b          	th.mula	s0,a5,a4
 100954c:	7ff40413          	addi	s0,s0,2047
 1009550:	27940513          	addi	a0,s0,633
 1009554:	4ee020ef          	jal	100ba42 <__thead_uread4>
 1009558:	c488                	sw	a0,8(s1)
 100955a:	c62a                	sw	a0,12(sp)
 100955c:	28140513          	addi	a0,s0,641
 1009560:	4e2020ef          	jal	100ba42 <__thead_uread4>
 1009564:	892a                	mv	s2,a0
 1009566:	c088                	sw	a0,0(s1)
 1009568:	28940513          	addi	a0,s0,649
 100956c:	4d6020ef          	jal	100ba42 <__thead_uread4>
 1009570:	45b2                	lw	a1,12(sp)
 1009572:	862a                	mv	a2,a0
 1009574:	c0c8                	sw	a0,4(s1)
 1009576:	01390533          	add	a0,s2,s3
 100957a:	6af000ef          	jal	100a428 <boot_flash_read>
 100957e:	4501                	li	a0,0
 1009580:	0141                	addi	sp,sp,16
 1009582:	4aa0206f          	j	100ba2c <__riscv_restore_4>
 1009586:	fd800513          	li	a0,-40
 100958a:	bfdd                	j	1009580 <aliBoot_nonsecure+0x8c>

0100958c <uart_read>:
 100958c:	4601                	li	a2,0
 100958e:	1cc0106f          	j	100a75a <boot_uart_read>

01009592 <uart_read_word>:
 1009592:	480022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009596:	1141                	addi	sp,sp,-16
 1009598:	0068                	addi	a0,sp,12
 100959a:	4591                	li	a1,4
 100959c:	3fc5                	jal	100958c <uart_read>
 100959e:	4532                	lw	a0,12(sp)
 10095a0:	0141                	addi	sp,sp,16
 10095a2:	4940206f          	j	100ba36 <__riscv_restore_0>

010095a6 <uart_read_byte>:
 10095a6:	46c022ef          	jal	t0,100ba12 <__riscv_save_0>
 10095aa:	1141                	addi	sp,sp,-16
 10095ac:	00f10513          	addi	a0,sp,15
 10095b0:	4585                	li	a1,1
 10095b2:	3fe9                	jal	100958c <uart_read>
 10095b4:	00f14503          	lbu	a0,15(sp)
 10095b8:	0141                	addi	sp,sp,16
 10095ba:	47c0206f          	j	100ba36 <__riscv_restore_0>

010095be <uart_write>:
 10095be:	4601                	li	a2,0
 10095c0:	1c40106f          	j	100a784 <boot_uart_write>

010095c4 <uart_write_byte>:
 10095c4:	44e022ef          	jal	t0,100ba12 <__riscv_save_0>
 10095c8:	1141                	addi	sp,sp,-16
 10095ca:	00a107a3          	sb	a0,15(sp)
 10095ce:	4585                	li	a1,1
 10095d0:	00f10513          	addi	a0,sp,15
 10095d4:	37ed                	jal	10095be <uart_write>
 10095d6:	0141                	addi	sp,sp,16
 10095d8:	45e0206f          	j	100ba36 <__riscv_restore_0>

010095dc <mem32_write_cmd_handler>:
 10095dc:	436022ef          	jal	t0,100ba12 <__riscv_save_0>
 10095e0:	3f4d                	jal	1009592 <uart_read_word>
 10095e2:	842a                	mv	s0,a0
 10095e4:	377d                	jal	1009592 <uart_read_word>
 10095e6:	c008                	sw	a0,0(s0)
 10095e8:	4501                	li	a0,0
 10095ea:	3fe9                	jal	10095c4 <uart_write_byte>
 10095ec:	4501                	li	a0,0
 10095ee:	3fd9                	jal	10095c4 <uart_write_byte>
 10095f0:	4460206f          	j	100ba36 <__riscv_restore_0>

010095f4 <mem_bulk_write_cmd_handler>:
 10095f4:	41e022ef          	jal	t0,100ba12 <__riscv_save_0>
 10095f8:	3f69                	jal	1009592 <uart_read_word>
 10095fa:	842a                	mv	s0,a0
 10095fc:	3f59                	jal	1009592 <uart_read_word>
 10095fe:	3c05358b          	th.extu	a1,a0,15,0
 1009602:	8522                	mv	a0,s0
 1009604:	3761                	jal	100958c <uart_read>
 1009606:	4509                	li	a0,2
 1009608:	3f75                	jal	10095c4 <uart_write_byte>
 100960a:	4501                	li	a0,0
 100960c:	3f65                	jal	10095c4 <uart_write_byte>
 100960e:	4280206f          	j	100ba36 <__riscv_restore_0>

01009612 <program_go_cmd_handler>:
 1009612:	400022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009616:	3fb5                	jal	1009592 <uart_read_word>
 1009618:	842a                	mv	s0,a0
 100961a:	3fa5                	jal	1009592 <uart_read_word>
 100961c:	84aa                	mv	s1,a0
 100961e:	4511                	li	a0,4
 1009620:	3755                	jal	10095c4 <uart_write_byte>
 1009622:	4501                	li	a0,0
 1009624:	3745                	jal	10095c4 <uart_write_byte>
 1009626:	8526                	mv	a0,s1
 1009628:	9402                	jalr	s0
 100962a:	40c0206f          	j	100ba36 <__riscv_restore_0>

0100962e <flash_chip_erase_cmd_handler>:
 100962e:	3e4022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009632:	3f95                	jal	10095a6 <uart_read_byte>
 1009634:	06000793          	li	a5,96
 1009638:	4405                	li	s0,1
 100963a:	00f51563          	bne	a0,a5,1009644 <flash_chip_erase_cmd_handler+0x16>
 100963e:	ca9fd0ef          	jal	10072e6 <hal_flash_chip_erase>
 1009642:	4401                	li	s0,0
 1009644:	4515                	li	a0,5
 1009646:	3fbd                	jal	10095c4 <uart_write_byte>
 1009648:	8522                	mv	a0,s0
 100964a:	3fad                	jal	10095c4 <uart_write_byte>
 100964c:	3ea0206f          	j	100ba36 <__riscv_restore_0>

01009650 <flash_read_status_reg_0_handler>:
 1009650:	3c2022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009654:	1141                	addi	sp,sp,-16
 1009656:	00f10513          	addi	a0,sp,15
 100965a:	d21fd0ef          	jal	100737a <hal_flash_read_status_register_0>
 100965e:	4519                	li	a0,6
 1009660:	3795                	jal	10095c4 <uart_write_byte>
 1009662:	4501                	li	a0,0
 1009664:	3785                	jal	10095c4 <uart_write_byte>
 1009666:	00f14503          	lbu	a0,15(sp)
 100966a:	3fa9                	jal	10095c4 <uart_write_byte>
 100966c:	0141                	addi	sp,sp,16
 100966e:	3c80206f          	j	100ba36 <__riscv_restore_0>

01009672 <flash_read_status_reg_1_handler>:
 1009672:	3a0022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009676:	1141                	addi	sp,sp,-16
 1009678:	00f10513          	addi	a0,sp,15
 100967c:	d1bfd0ef          	jal	1007396 <hal_flash_read_status_register_1>
 1009680:	451d                	li	a0,7
 1009682:	3789                	jal	10095c4 <uart_write_byte>
 1009684:	4501                	li	a0,0
 1009686:	3f3d                	jal	10095c4 <uart_write_byte>
 1009688:	00f14503          	lbu	a0,15(sp)
 100968c:	3f25                	jal	10095c4 <uart_write_byte>
 100968e:	0141                	addi	sp,sp,16
 1009690:	3a60206f          	j	100ba36 <__riscv_restore_0>

01009694 <flash_write_status_reg_handler>:
 1009694:	37e022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009698:	3739                	jal	10095a6 <uart_read_byte>
 100969a:	842a                	mv	s0,a0
 100969c:	3729                	jal	10095a6 <uart_read_byte>
 100969e:	00851793          	slli	a5,a0,0x8
 10096a2:	0087e533          	or	a0,a5,s0
 10096a6:	3c05350b          	th.extu	a0,a0,15,0
 10096aa:	c43fd0ef          	jal	10072ec <hal_flash_write_status_register>
 10096ae:	4521                	li	a0,8
 10096b0:	3f11                	jal	10095c4 <uart_write_byte>
 10096b2:	4501                	li	a0,0
 10096b4:	3f01                	jal	10095c4 <uart_write_byte>
 10096b6:	3800206f          	j	100ba36 <__riscv_restore_0>

010096ba <flash_quad_page_program_handler>:
 10096ba:	358022ef          	jal	t0,100ba12 <__riscv_save_0>
 10096be:	1141                	addi	sp,sp,-16
 10096c0:	3dc9                	jal	1009592 <uart_read_word>
 10096c2:	842a                	mv	s0,a0
 10096c4:	35f9                	jal	1009592 <uart_read_word>
 10096c6:	3c05360b          	th.extu	a2,a0,15,0
 10096ca:	101384b7          	lui	s1,0x10138
 10096ce:	85b2                	mv	a1,a2
 10096d0:	52048513          	addi	a0,s1,1312 # 10138520 <temp_buf>
 10096d4:	c632                	sw	a2,12(sp)
 10096d6:	3d5d                	jal	100958c <uart_read>
 10096d8:	4632                	lw	a2,12(sp)
 10096da:	52048593          	addi	a1,s1,1312
 10096de:	8522                	mv	a0,s0
 10096e0:	957fd0ef          	jal	1007036 <hal_flash_quad_page_program>
 10096e4:	4525                	li	a0,9
 10096e6:	3df9                	jal	10095c4 <uart_write_byte>
 10096e8:	4501                	li	a0,0
 10096ea:	3de9                	jal	10095c4 <uart_write_byte>
 10096ec:	0141                	addi	sp,sp,16
 10096ee:	3480206f          	j	100ba36 <__riscv_restore_0>

010096f2 <flash_page_program_handler>:
 10096f2:	320022ef          	jal	t0,100ba12 <__riscv_save_0>
 10096f6:	1141                	addi	sp,sp,-16
 10096f8:	3d69                	jal	1009592 <uart_read_word>
 10096fa:	842a                	mv	s0,a0
 10096fc:	3d59                	jal	1009592 <uart_read_word>
 10096fe:	3c05360b          	th.extu	a2,a0,15,0
 1009702:	101384b7          	lui	s1,0x10138
 1009706:	85b2                	mv	a1,a2
 1009708:	52048513          	addi	a0,s1,1312 # 10138520 <temp_buf>
 100970c:	c632                	sw	a2,12(sp)
 100970e:	3dbd                	jal	100958c <uart_read>
 1009710:	4632                	lw	a2,12(sp)
 1009712:	52048593          	addi	a1,s1,1312
 1009716:	8522                	mv	a0,s0
 1009718:	9a3fd0ef          	jal	10070ba <hal_flash_page_program>
 100971c:	4529                	li	a0,10
 100971e:	355d                	jal	10095c4 <uart_write_byte>
 1009720:	4501                	li	a0,0
 1009722:	354d                	jal	10095c4 <uart_write_byte>
 1009724:	0141                	addi	sp,sp,16
 1009726:	3100206f          	j	100ba36 <__riscv_restore_0>

0100972a <flash_sector_erase_handler>:
 100972a:	2e8022ef          	jal	t0,100ba12 <__riscv_save_0>
 100972e:	3595                	jal	1009592 <uart_read_word>
 1009730:	be1fd0ef          	jal	1007310 <hal_flash_sector_erase>
 1009734:	452d                	li	a0,11
 1009736:	3579                	jal	10095c4 <uart_write_byte>
 1009738:	4501                	li	a0,0
 100973a:	3569                	jal	10095c4 <uart_write_byte>
 100973c:	2fa0206f          	j	100ba36 <__riscv_restore_0>

01009740 <flash_deep_power_down_handler>:
 1009740:	2d2022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009744:	a69fd0ef          	jal	10071ac <hal_flash_deep_power_down>
 1009748:	4539                	li	a0,14
 100974a:	3dad                	jal	10095c4 <uart_write_byte>
 100974c:	4501                	li	a0,0
 100974e:	3d9d                	jal	10095c4 <uart_write_byte>
 1009750:	2e60206f          	j	100ba36 <__riscv_restore_0>

01009754 <flash_release_from_deep_power_down>:
 1009754:	2be022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009758:	a5dfd0ef          	jal	10071b4 <hal_flash_release_from_deep_power_down>
 100975c:	453d                	li	a0,15
 100975e:	359d                	jal	10095c4 <uart_write_byte>
 1009760:	4501                	li	a0,0
 1009762:	358d                	jal	10095c4 <uart_write_byte>
 1009764:	2d20206f          	j	100ba36 <__riscv_restore_0>

01009768 <flash_erase_security_area_handler>:
 1009768:	2aa022ef          	jal	t0,100ba12 <__riscv_save_0>
 100976c:	3d2d                	jal	10095a6 <uart_read_byte>
 100976e:	cd9fd0ef          	jal	1007446 <hal_flash_erase_security_area>
 1009772:	4549                	li	a0,18
 1009774:	3d81                	jal	10095c4 <uart_write_byte>
 1009776:	4501                	li	a0,0
 1009778:	35b1                	jal	10095c4 <uart_write_byte>
 100977a:	2bc0206f          	j	100ba36 <__riscv_restore_0>

0100977e <flash_program_security_area_handler>:
 100977e:	294022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009782:	1141                	addi	sp,sp,-16
 1009784:	3539                	jal	1009592 <uart_read_word>
 1009786:	842a                	mv	s0,a0
 1009788:	3529                	jal	1009592 <uart_read_word>
 100978a:	3c05368b          	th.extu	a3,a0,15,0
 100978e:	101384b7          	lui	s1,0x10138
 1009792:	85b6                	mv	a1,a3
 1009794:	52048513          	addi	a0,s1,1312 # 10138520 <temp_buf>
 1009798:	c636                	sw	a3,12(sp)
 100979a:	3bcd                	jal	100958c <uart_read>
 100979c:	46b2                	lw	a3,12(sp)
 100979e:	52048613          	addi	a2,s1,1312
 10097a2:	3c04358b          	th.extu	a1,s0,15,0
 10097a6:	01845513          	srli	a0,s0,0x18
 10097aa:	a5bfd0ef          	jal	1007204 <hal_flash_program_security_area>
 10097ae:	454d                	li	a0,19
 10097b0:	3d11                	jal	10095c4 <uart_write_byte>
 10097b2:	4501                	li	a0,0
 10097b4:	3d01                	jal	10095c4 <uart_write_byte>
 10097b6:	0141                	addi	sp,sp,16
 10097b8:	27e0206f          	j	100ba36 <__riscv_restore_0>

010097bc <flash_software_reset_handler>:
 10097bc:	256022ef          	jal	t0,100ba12 <__riscv_save_0>
 10097c0:	ad1fd0ef          	jal	1007290 <hal_flash_software_reset>
 10097c4:	4555                	li	a0,21
 10097c6:	3bfd                	jal	10095c4 <uart_write_byte>
 10097c8:	4501                	li	a0,0
 10097ca:	3bed                	jal	10095c4 <uart_write_byte>
 10097cc:	26a0206f          	j	100ba36 <__riscv_restore_0>

010097d0 <mem32_write_multi_cmd_handler>:
 10097d0:	1101                	addi	sp,sp,-32
 10097d2:	cc22                	sw	s0,24(sp)
 10097d4:	ca26                	sw	s1,20(sp)
 10097d6:	c84a                	sw	s2,16(sp)
 10097d8:	c64e                	sw	s3,12(sp)
 10097da:	c452                	sw	s4,8(sp)
 10097dc:	ce06                	sw	ra,28(sp)
 10097de:	1000                	addi	s0,sp,32
 10097e0:	33d9                	jal	10095a6 <uart_read_byte>
 10097e2:	00251793          	slli	a5,a0,0x2
 10097e6:	07bd                	addi	a5,a5,15
 10097e8:	9bc1                	andi	a5,a5,-16
 10097ea:	40f10133          	sub	sp,sp,a5
 10097ee:	898a                	mv	s3,sp
 10097f0:	40f10133          	sub	sp,sp,a5
 10097f4:	84aa                	mv	s1,a0
 10097f6:	8a0a                	mv	s4,sp
 10097f8:	4901                	li	s2,0
 10097fa:	0ff97793          	zext.b	a5,s2
 10097fe:	0297e563          	bltu	a5,s1,1009828 <mem32_write_multi_cmd_handler+0x58>
 1009802:	4781                	li	a5,0
 1009804:	0ff7f713          	zext.b	a4,a5
 1009808:	02976863          	bltu	a4,s1,1009838 <mem32_write_multi_cmd_handler+0x68>
 100980c:	4559                	li	a0,22
 100980e:	3b5d                	jal	10095c4 <uart_write_byte>
 1009810:	4501                	li	a0,0
 1009812:	3b4d                	jal	10095c4 <uart_write_byte>
 1009814:	fe040113          	addi	sp,s0,-32
 1009818:	40f2                	lw	ra,28(sp)
 100981a:	4462                	lw	s0,24(sp)
 100981c:	44d2                	lw	s1,20(sp)
 100981e:	4942                	lw	s2,16(sp)
 1009820:	49b2                	lw	s3,12(sp)
 1009822:	4a22                	lw	s4,8(sp)
 1009824:	6105                	addi	sp,sp,32
 1009826:	8082                	ret
 1009828:	33ad                	jal	1009592 <uart_read_word>
 100982a:	4529d50b          	th.srw	a0,s3,s2,2
 100982e:	3395                	jal	1009592 <uart_read_word>
 1009830:	452a550b          	th.srw	a0,s4,s2,2
 1009834:	0905                	addi	s2,s2,1
 1009836:	b7d1                	j	10097fa <mem32_write_multi_cmd_handler+0x2a>
 1009838:	44f9c70b          	th.lrw	a4,s3,a5,2
 100983c:	44fa468b          	th.lrw	a3,s4,a5,2
 1009840:	0785                	addi	a5,a5,1
 1009842:	c314                	sw	a3,0(a4)
 1009844:	b7c1                	j	1009804 <mem32_write_multi_cmd_handler+0x34>

01009846 <flash_dual_page_program_handler>:
 1009846:	1cc022ef          	jal	t0,100ba12 <__riscv_save_0>
 100984a:	1141                	addi	sp,sp,-16
 100984c:	3399                	jal	1009592 <uart_read_word>
 100984e:	842a                	mv	s0,a0
 1009850:	3389                	jal	1009592 <uart_read_word>
 1009852:	3c05360b          	th.extu	a2,a0,15,0
 1009856:	101384b7          	lui	s1,0x10138
 100985a:	85b2                	mv	a1,a2
 100985c:	52048513          	addi	a0,s1,1312 # 10138520 <temp_buf>
 1009860:	c632                	sw	a2,12(sp)
 1009862:	332d                	jal	100958c <uart_read>
 1009864:	4632                	lw	a2,12(sp)
 1009866:	52048593          	addi	a1,s1,1312
 100986a:	8522                	mv	a0,s0
 100986c:	80dfd0ef          	jal	1007078 <hal_flash_dual_page_program>
 1009870:	4561                	li	a0,24
 1009872:	3b89                	jal	10095c4 <uart_write_byte>
 1009874:	4501                	li	a0,0
 1009876:	33b9                	jal	10095c4 <uart_write_byte>
 1009878:	0141                	addi	sp,sp,16
 100987a:	1bc0206f          	j	100ba36 <__riscv_restore_0>

0100987e <flash_init_handler>:
 100987e:	194022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009882:	3315                	jal	10095a6 <uart_read_byte>
 1009884:	cd19                	beqz	a0,10098a2 <flash_init_handler+0x24>
 1009886:	816f70ef          	jal	100089c <pinmux_hal_flash_quad_init>
 100988a:	4581                	li	a1,0
 100988c:	4501                	li	a0,0
 100988e:	a19fd0ef          	jal	10072a6 <hal_flash_drv_var_init>
 1009892:	f02fd0ef          	jal	1006f94 <hal_flash_init>
 1009896:	4565                	li	a0,25
 1009898:	3335                	jal	10095c4 <uart_write_byte>
 100989a:	4501                	li	a0,0
 100989c:	3325                	jal	10095c4 <uart_write_byte>
 100989e:	1980206f          	j	100ba36 <__riscv_restore_0>
 10098a2:	fbbf60ef          	jal	100085c <pinmux_hal_flash_init>
 10098a6:	b7d5                	j	100988a <flash_init_handler+0xc>

010098a8 <otp_write_handler>:
 10098a8:	16a022ef          	jal	t0,100ba12 <__riscv_save_0>
 10098ac:	31dd                	jal	1009592 <uart_read_word>
 10098ae:	84aa                	mv	s1,a0
 10098b0:	31cd                	jal	1009592 <uart_read_word>
 10098b2:	842a                	mv	s0,a0
 10098b4:	10138937          	lui	s2,0x10138
 10098b8:	fb8fe0ef          	jal	1008070 <HAL_OTP_CTRL_Init>
 10098bc:	3c04358b          	th.extu	a1,s0,15,0
 10098c0:	52090513          	addi	a0,s2,1312 # 10138520 <temp_buf>
 10098c4:	31e1                	jal	100958c <uart_read>
 10098c6:	8622                	mv	a2,s0
 10098c8:	52090593          	addi	a1,s2,1312
 10098cc:	8526                	mv	a0,s1
 10098ce:	963fe0ef          	jal	1008230 <HAL_OTP_Write>
 10098d2:	4575                	li	a0,29
 10098d4:	39c5                	jal	10095c4 <uart_write_byte>
 10098d6:	4501                	li	a0,0
 10098d8:	31f5                	jal	10095c4 <uart_write_byte>
 10098da:	15c0206f          	j	100ba36 <__riscv_restore_0>

010098de <life_cycle_update>:
 10098de:	134022ef          	jal	t0,100ba12 <__riscv_save_0>
 10098e2:	1141                	addi	sp,sp,-16
 10098e4:	31c9                	jal	10095a6 <uart_read_byte>
 10098e6:	47a1                	li	a5,8
 10098e8:	45c1                	li	a1,16
 10098ea:	42a7958b          	th.mvnez	a1,a5,a0
 10098ee:	842a                	mv	s0,a0
 10098f0:	850a                	mv	a0,sp
 10098f2:	3969                	jal	100958c <uart_read>
 10098f4:	4481                	li	s1,0
 10098f6:	e811                	bnez	s0,100990a <life_cycle_update+0x2c>
 10098f8:	101404b7          	lui	s1,0x10140
 10098fc:	f8048513          	addi	a0,s1,-128 # 1013ff80 <bitmap>
 1009900:	08000593          	li	a1,128
 1009904:	3161                	jal	100958c <uart_read>
 1009906:	f8048493          	addi	s1,s1,-128
 100990a:	4579                	li	a0,30
 100990c:	3965                	jal	10095c4 <uart_write_byte>
 100990e:	4501                	li	a0,0
 1009910:	3955                	jal	10095c4 <uart_write_byte>
 1009912:	858a                	mv	a1,sp
 1009914:	8626                	mv	a2,s1
 1009916:	8522                	mv	a0,s0
 1009918:	2d2010ef          	jal	100abea <boot_life_cycle_update_request>
 100991c:	0141                	addi	sp,sp,16
 100991e:	1180206f          	j	100ba36 <__riscv_restore_0>

01009922 <mem32_read_cmd_handler>:
 1009922:	0f0022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009926:	1141                	addi	sp,sp,-16
 1009928:	31ad                	jal	1009592 <uart_read_word>
 100992a:	4100                	lw	s0,0(a0)
 100992c:	4505                	li	a0,1
 100992e:	3959                	jal	10095c4 <uart_write_byte>
 1009930:	4501                	li	a0,0
 1009932:	3949                	jal	10095c4 <uart_write_byte>
 1009934:	0068                	addi	a0,sp,12
 1009936:	4591                	li	a1,4
 1009938:	c622                	sw	s0,12(sp)
 100993a:	3151                	jal	10095be <uart_write>
 100993c:	0141                	addi	sp,sp,16
 100993e:	0f80206f          	j	100ba36 <__riscv_restore_0>

01009942 <mem_bulk_read_cmd_handler>:
 1009942:	0d0022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009946:	31b1                	jal	1009592 <uart_read_word>
 1009948:	842a                	mv	s0,a0
 100994a:	31a1                	jal	1009592 <uart_read_word>
 100994c:	84aa                	mv	s1,a0
 100994e:	450d                	li	a0,3
 1009950:	3995                	jal	10095c4 <uart_write_byte>
 1009952:	4501                	li	a0,0
 1009954:	3985                	jal	10095c4 <uart_write_byte>
 1009956:	3c04b58b          	th.extu	a1,s1,15,0
 100995a:	8522                	mv	a0,s0
 100995c:	318d                	jal	10095be <uart_write>
 100995e:	0d80206f          	j	100ba36 <__riscv_restore_0>

01009962 <flash_quad_io_read_handler>:
 1009962:	0b0022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009966:	3135                	jal	1009592 <uart_read_word>
 1009968:	84aa                	mv	s1,a0
 100996a:	10138937          	lui	s2,0x10138
 100996e:	3115                	jal	1009592 <uart_read_word>
 1009970:	862a                	mv	a2,a0
 1009972:	52090593          	addi	a1,s2,1312 # 10138520 <temp_buf>
 1009976:	842a                	mv	s0,a0
 1009978:	8526                	mv	a0,s1
 100997a:	f8afd0ef          	jal	1007104 <hal_flash_quad_io_read>
 100997e:	4531                	li	a0,12
 1009980:	3191                	jal	10095c4 <uart_write_byte>
 1009982:	4501                	li	a0,0
 1009984:	3181                	jal	10095c4 <uart_write_byte>
 1009986:	3c04358b          	th.extu	a1,s0,15,0
 100998a:	52090513          	addi	a0,s2,1312
 100998e:	3905                	jal	10095be <uart_write>
 1009990:	0a60206f          	j	100ba36 <__riscv_restore_0>

01009994 <flash_fast_read_handler>:
 1009994:	07e022ef          	jal	t0,100ba12 <__riscv_save_0>
 1009998:	3eed                	jal	1009592 <uart_read_word>
 100999a:	84aa                	mv	s1,a0
 100999c:	10138937          	lui	s2,0x10138
 10099a0:	3ecd                	jal	1009592 <uart_read_word>
 10099a2:	862a                	mv	a2,a0
 10099a4:	52090593          	addi	a1,s2,1312 # 10138520 <temp_buf>
 10099a8:	842a                	mv	s0,a0
 10099aa:	8526                	mv	a0,s1
 10099ac:	ac7fd0ef          	jal	1007472 <hal_flash_fast_read>
 10099b0:	4535                	li	a0,13
 10099b2:	3909                	jal	10095c4 <uart_write_byte>
 10099b4:	4501                	li	a0,0
 10099b6:	3139                	jal	10095c4 <uart_write_byte>
 10099b8:	3c04358b          	th.extu	a1,s0,15,0
 10099bc:	52090513          	addi	a0,s2,1312
 10099c0:	3efd                	jal	10095be <uart_write>
 10099c2:	0740206f          	j	100ba36 <__riscv_restore_0>

010099c6 <flash_read_sfdp_handler>:
 10099c6:	04c022ef          	jal	t0,100ba12 <__riscv_save_0>
 10099ca:	36e1                	jal	1009592 <uart_read_word>
 10099cc:	84aa                	mv	s1,a0
 10099ce:	36d1                	jal	1009592 <uart_read_word>
 10099d0:	3c05340b          	th.extu	s0,a0,15,0
 10099d4:	10138937          	lui	s2,0x10138
 10099d8:	8622                	mv	a2,s0
 10099da:	52090593          	addi	a1,s2,1312 # 10138520 <temp_buf>
 10099de:	8526                	mv	a0,s1
 10099e0:	a99fd0ef          	jal	1007478 <hal_flash_read_sfdp>
 10099e4:	456d                	li	a0,27
 10099e6:	3ef9                	jal	10095c4 <uart_write_byte>
 10099e8:	4501                	li	a0,0
 10099ea:	3ee9                	jal	10095c4 <uart_write_byte>
 10099ec:	85a2                	mv	a1,s0
 10099ee:	52090513          	addi	a0,s2,1312
 10099f2:	36f1                	jal	10095be <uart_write>
 10099f4:	0420206f          	j	100ba36 <__riscv_restore_0>

010099f8 <flash_read_jedec_id_handler>:
 10099f8:	01a022ef          	jal	t0,100ba12 <__riscv_save_0>
 10099fc:	1141                	addi	sp,sp,-16
 10099fe:	0068                	addi	a0,sp,12
 1009a00:	95ffd0ef          	jal	100735e <hal_flash_read_id>
 1009a04:	4541                	li	a0,16
 1009a06:	3e7d                	jal	10095c4 <uart_write_byte>
 1009a08:	4501                	li	a0,0
 1009a0a:	3e6d                	jal	10095c4 <uart_write_byte>
 1009a0c:	0068                	addi	a0,sp,12
 1009a0e:	458d                	li	a1,3
 1009a10:	367d                	jal	10095be <uart_write>
 1009a12:	0141                	addi	sp,sp,16
 1009a14:	0220206f          	j	100ba36 <__riscv_restore_0>

01009a18 <flash_read_unique_id_handler>:
 1009a18:	7fb012ef          	jal	t0,100ba12 <__riscv_save_0>
 1009a1c:	1141                	addi	sp,sp,-16
 1009a1e:	850a                	mv	a0,sp
 1009a20:	faafd0ef          	jal	10071ca <hal_flash_read_unique_id>
 1009a24:	4545                	li	a0,17
 1009a26:	3e79                	jal	10095c4 <uart_write_byte>
 1009a28:	4501                	li	a0,0
 1009a2a:	3e69                	jal	10095c4 <uart_write_byte>
 1009a2c:	850a                	mv	a0,sp
 1009a2e:	45c1                	li	a1,16
 1009a30:	3679                	jal	10095be <uart_write>
 1009a32:	0141                	addi	sp,sp,16
 1009a34:	0020206f          	j	100ba36 <__riscv_restore_0>

01009a38 <flash_read_security_area_handler>:
 1009a38:	7db012ef          	jal	t0,100ba12 <__riscv_save_0>
 1009a3c:	3e99                	jal	1009592 <uart_read_word>
 1009a3e:	84aa                	mv	s1,a0
 1009a40:	3e89                	jal	1009592 <uart_read_word>
 1009a42:	3c05340b          	th.extu	s0,a0,15,0
 1009a46:	10138937          	lui	s2,0x10138
 1009a4a:	86a2                	mv	a3,s0
 1009a4c:	52090613          	addi	a2,s2,1312 # 10138520 <temp_buf>
 1009a50:	3c04b58b          	th.extu	a1,s1,15,0
 1009a54:	0184d513          	srli	a0,s1,0x18
 1009a58:	feefd0ef          	jal	1007246 <hal_flash_read_security_area>
 1009a5c:	4551                	li	a0,20
 1009a5e:	369d                	jal	10095c4 <uart_write_byte>
 1009a60:	4501                	li	a0,0
 1009a62:	368d                	jal	10095c4 <uart_write_byte>
 1009a64:	85a2                	mv	a1,s0
 1009a66:	52090513          	addi	a0,s2,1312
 1009a6a:	3e91                	jal	10095be <uart_write>
 1009a6c:	7cb0106f          	j	100ba36 <__riscv_restore_0>

01009a70 <flash_dual_io_read_handler>:
 1009a70:	7a3012ef          	jal	t0,100ba12 <__riscv_save_0>
 1009a74:	3e39                	jal	1009592 <uart_read_word>
 1009a76:	84aa                	mv	s1,a0
 1009a78:	10138937          	lui	s2,0x10138
 1009a7c:	3e19                	jal	1009592 <uart_read_word>
 1009a7e:	862a                	mv	a2,a0
 1009a80:	52090593          	addi	a1,s2,1312 # 10138520 <temp_buf>
 1009a84:	842a                	mv	s0,a0
 1009a86:	8526                	mv	a0,s1
 1009a88:	eb4fd0ef          	jal	100713c <hal_flash_dual_io_read>
 1009a8c:	455d                	li	a0,23
 1009a8e:	3e1d                	jal	10095c4 <uart_write_byte>
 1009a90:	4501                	li	a0,0
 1009a92:	3e0d                	jal	10095c4 <uart_write_byte>
 1009a94:	3c04358b          	th.extu	a1,s0,15,0
 1009a98:	52090513          	addi	a0,s2,1312
 1009a9c:	360d                	jal	10095be <uart_write>
 1009a9e:	7990106f          	j	100ba36 <__riscv_restore_0>

01009aa2 <otp_read_handler>:
 1009aa2:	771012ef          	jal	t0,100ba12 <__riscv_save_0>
 1009aa6:	34f5                	jal	1009592 <uart_read_word>
 1009aa8:	84aa                	mv	s1,a0
 1009aaa:	34e5                	jal	1009592 <uart_read_word>
 1009aac:	842a                	mv	s0,a0
 1009aae:	10138937          	lui	s2,0x10138
 1009ab2:	dbefe0ef          	jal	1008070 <HAL_OTP_CTRL_Init>
 1009ab6:	8622                	mv	a2,s0
 1009ab8:	52090593          	addi	a1,s2,1312 # 10138520 <temp_buf>
 1009abc:	8526                	mv	a0,s1
 1009abe:	e00fe0ef          	jal	10080be <HAL_OTP_Read>
 1009ac2:	4571                	li	a0,28
 1009ac4:	3601                	jal	10095c4 <uart_write_byte>
 1009ac6:	4501                	li	a0,0
 1009ac8:	3cf5                	jal	10095c4 <uart_write_byte>
 1009aca:	3c04358b          	th.extu	a1,s0,15,0
 1009ace:	52090513          	addi	a0,s2,1312
 1009ad2:	34f5                	jal	10095be <uart_write>
 1009ad4:	7630106f          	j	100ba36 <__riscv_restore_0>

01009ad8 <unknown_cmd_handler>:
 1009ad8:	73b012ef          	jal	t0,100ba12 <__riscv_save_0>
 1009adc:	0ff00513          	li	a0,255
 1009ae0:	34d5                	jal	10095c4 <uart_write_byte>
 1009ae2:	4501                	li	a0,0
 1009ae4:	34c5                	jal	10095c4 <uart_write_byte>
 1009ae6:	7510106f          	j	100ba36 <__riscv_restore_0>

01009aea <feature_disabled_rsp_send>:
 1009aea:	729012ef          	jal	t0,100ba12 <__riscv_save_0>
 1009aee:	3cd9                	jal	10095c4 <uart_write_byte>
 1009af0:	4509                	li	a0,2
 1009af2:	3cc9                	jal	10095c4 <uart_write_byte>
 1009af4:	7430106f          	j	100ba36 <__riscv_restore_0>

01009af8 <parser_loop>:
 1009af8:	701012ef          	jal	t0,100b9f8 <__riscv_save_4>
 1009afc:	0100a4b7          	lui	s1,0x100a
 1009b00:	842a                	mv	s0,a0
 1009b02:	497d                	li	s2,31
 1009b04:	4985                	li	s3,1
 1009b06:	b3048493          	addi	s1,s1,-1232 # 1009b30 <cmd_handler>
 1009b0a:	3c71                	jal	10095a6 <uart_read_byte>
 1009b0c:	00a96f63          	bltu	s2,a0,1009b2a <parser_loop+0x32>
 1009b10:	00a99733          	sll	a4,s3,a0
 1009b14:	8f61                	and	a4,a4,s0
 1009b16:	e319                	bnez	a4,1009b1c <parser_loop+0x24>
 1009b18:	3fc9                	jal	1009aea <feature_disabled_rsp_send>
 1009b1a:	bfc5                	j	1009b0a <parser_loop+0x12>
 1009b1c:	01250763          	beq	a0,s2,1009b2a <parser_loop+0x32>
 1009b20:	44a4c78b          	th.lrw	a5,s1,a0,2
 1009b24:	c399                	beqz	a5,1009b2a <parser_loop+0x32>
 1009b26:	9782                	jalr	a5
 1009b28:	b7cd                	j	1009b0a <parser_loop+0x12>
 1009b2a:	377d                	jal	1009ad8 <unknown_cmd_handler>
 1009b2c:	bff9                	j	1009b0a <parser_loop+0x12>
 1009b2e:	0000                	unimp

01009b30 <cmd_handler>:
 1009b30:	95dc 0100 9922 0100 95f4 0100 9942 0100     ....".......B...
 1009b40:	9612 0100 962e 0100 9650 0100 9672 0100     ........P...r...
 1009b50:	9694 0100 96ba 0100 96f2 0100 972a 0100     ............*...
 1009b60:	9962 0100 9994 0100 9740 0100 9754 0100     b.......@...T...
 1009b70:	99f8 0100 9a18 0100 9768 0100 977e 0100     ........h...~...
 1009b80:	9a38 0100 97bc 0100 97d0 0100 9a70 0100     8...........p...
 1009b90:	9846 0100 987e 0100 0000 0000 99c6 0100     F...~...........
 1009ba0:	9aa2 0100 98a8 0100 98de 0100               ............

01009bac <copy_reverse>:
 1009bac:	95b2                	add	a1,a1,a2
 1009bae:	4781                	li	a5,0
 1009bb0:	89f5c70b          	th.lbuib	a4,(a1),-1,0
 1009bb4:	00f5570b          	th.srb	a4,a0,a5,0
 1009bb8:	0785                	addi	a5,a5,1
 1009bba:	fef61be3          	bne	a2,a5,1009bb0 <copy_reverse+0x4>
 1009bbe:	8082                	ret

01009bc0 <ls_otbn_fireware_init>:
 1009bc0:	653012ef          	jal	t0,100ba12 <__riscv_save_0>
 1009bc4:	bdafe0ef          	jal	1007f9e <HAL_OTBN_Checksum_Clear>
 1009bc8:	48000613          	li	a2,1152
 1009bcc:	4581                	li	a1,0
 1009bce:	4501                	li	a0,0
 1009bd0:	aeefe0ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 1009bd4:	010037b7          	lui	a5,0x1003
 1009bd8:	acc7a603          	lw	a2,-1332(a5) # 1002acc <sm2_imem_size>
 1009bdc:	010035b7          	lui	a1,0x1003
 1009be0:	bc058593          	addi	a1,a1,-1088 # 1002bc0 <sm2_imem>
 1009be4:	4501                	li	a0,0
 1009be6:	aa2fe0ef          	jal	1007e88 <HAL_OTBN_IMEM_Write>
 1009bea:	010037b7          	lui	a5,0x1003
 1009bee:	ac87a603          	lw	a2,-1336(a5) # 1002ac8 <sm2_dmem_size>
 1009bf2:	010035b7          	lui	a1,0x1003
 1009bf6:	ad058593          	addi	a1,a1,-1328 # 1002ad0 <sm2_dmem>
 1009bfa:	4501                	li	a0,0
 1009bfc:	afcfe0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 1009c00:	6370106f          	j	100ba36 <__riscv_restore_0>

01009c04 <arr_reverse.constprop.0>:
 1009c04:	01f50713          	addi	a4,a0,31
 1009c08:	4781                	li	a5,0
 1009c0a:	46c1                	li	a3,16
 1009c0c:	00074583          	lbu	a1,0(a4)
 1009c10:	80f5460b          	th.lrbu	a2,a0,a5,0
 1009c14:	00f5558b          	th.srb	a1,a0,a5,0
 1009c18:	19f7560b          	th.sbia	a2,(a4),-1,0
 1009c1c:	0785                	addi	a5,a5,1
 1009c1e:	fed797e3          	bne	a5,a3,1009c0c <arr_reverse.constprop.0+0x8>
 1009c22:	8082                	ret

01009c24 <goto_next>:
 1009c24:	5ef012ef          	jal	t0,100ba12 <__riscv_save_0>
 1009c28:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 1009c2c:	842a                	mv	s0,a0
 1009c2e:	cb91                	beqz	a5,1009c42 <goto_next+0x1e>
 1009c30:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 1009c34:	010085b7          	lui	a1,0x1008
 1009c38:	862a                	mv	a2,a0
 1009c3a:	8d458593          	addi	a1,a1,-1836 # 10078d4 <HAL_UART_Receive+0x2c4>
 1009c3e:	4505                	li	a0,1
 1009c40:	9782                	jalr	a5
 1009c42:	300026f3          	csrr	a3,mstatus
 1009c46:	10139737          	lui	a4,0x10139
 1009c4a:	fc874783          	lbu	a5,-56(a4) # 10138fc8 <goto_next_mstatus>
 1009c4e:	fc870713          	addi	a4,a4,-56
 1009c52:	00174703          	lbu	a4,1(a4)
 1009c56:	07ae                	slli	a5,a5,0xb
 1009c58:	071e                	slli	a4,a4,0x7
 1009c5a:	8fd9                	or	a5,a5,a4
 1009c5c:	7779                	lui	a4,0xffffe
 1009c5e:	77770713          	addi	a4,a4,1911 # ffffe777 <bitmap+0xefebe7f7>
 1009c62:	8f75                	and	a4,a4,a3
 1009c64:	8fd9                	or	a5,a5,a4
 1009c66:	30079073          	csrw	mstatus,a5
 1009c6a:	34141073          	csrw	mepc,s0
 1009c6e:	30200073          	mret

01009c72 <clr_startup_part_flag>:
 1009c72:	4002f737          	lui	a4,0x4002f
 1009c76:	473c                	lw	a5,72(a4)
 1009c78:	9bc1                	andi	a5,a5,-16
 1009c7a:	c73c                	sw	a5,72(a4)
 1009c7c:	8082                	ret

01009c7e <boot_hkdf>:
 1009c7e:	565012ef          	jal	t0,100b9e2 <__riscv_save_12>
 1009c82:	7175                	addi	sp,sp,-144
 1009c84:	4cce                	lw	s9,208(sp)
 1009c86:	892a                	mv	s2,a0
 1009c88:	84b6                	mv	s1,a3
 1009c8a:	8a3a                	mv	s4,a4
 1009c8c:	8abe                	mv	s5,a5
 1009c8e:	8c42                	mv	s8,a6
 1009c90:	89c6                	mv	s3,a7
 1009c92:	edb1                	bnez	a1,1009cee <boot_hkdf+0x70>
 1009c94:	fff50713          	addi	a4,a0,-1
 1009c98:	03000793          	li	a5,48
 1009c9c:	02000413          	li	s0,32
 1009ca0:	40e7940b          	th.mveqz	s0,a5,a4
 1009ca4:	8622                	mv	a2,s0
 1009ca6:	00f10533          	add	a0,sp,a5
 1009caa:	683010ef          	jal	100bb2c <memset>
 1009cae:	03010313          	addi	t1,sp,48
 1009cb2:	4505                	li	a0,1
 1009cb4:	04a90063          	beq	s2,a0,1009cf4 <boot_hkdf+0x76>
 1009cb8:	4799                	li	a5,6
 1009cba:	04f90863          	beq	s2,a5,1009d0a <boot_hkdf+0x8c>
 1009cbe:	02091463          	bnez	s2,1009ce6 <boot_hkdf+0x68>
 1009cc2:	87d2                	mv	a5,s4
 1009cc4:	8726                	mv	a4,s1
 1009cc6:	86a2                	mv	a3,s0
 1009cc8:	861a                	mv	a2,t1
 1009cca:	858a                	mv	a1,sp
 1009ccc:	ec9f90ef          	jal	1003b94 <HAL_OTBN_HASH_HMAC>
 1009cd0:	02000493          	li	s1,32
 1009cd4:	000a9763          	bnez	s5,1009ce2 <boot_hkdf+0x64>
 1009cd8:	01007ab7          	lui	s5,0x1007
 1009cdc:	4c01                	li	s8,0
 1009cde:	6fba8a93          	addi	s5,s5,1787 # 10076fb <HAL_UART_Receive+0xeb>
 1009ce2:	02099c63          	bnez	s3,1009d1a <boot_hkdf+0x9c>
 1009ce6:	4501                	li	a0,0
 1009ce8:	6149                	addi	sp,sp,144
 1009cea:	5350106f          	j	100ba1e <__riscv_restore_12>
 1009cee:	832e                	mv	t1,a1
 1009cf0:	8432                	mv	s0,a2
 1009cf2:	b7c1                	j	1009cb2 <boot_hkdf+0x34>
 1009cf4:	8726                	mv	a4,s1
 1009cf6:	87d2                	mv	a5,s4
 1009cf8:	86a2                	mv	a3,s0
 1009cfa:	861a                	mv	a2,t1
 1009cfc:	858a                	mv	a1,sp
 1009cfe:	4509                	li	a0,2
 1009d00:	e95f90ef          	jal	1003b94 <HAL_OTBN_HASH_HMAC>
 1009d04:	03000493          	li	s1,48
 1009d08:	b7f1                	j	1009cd4 <boot_hkdf+0x56>
 1009d0a:	8722                	mv	a4,s0
 1009d0c:	869a                	mv	a3,t1
 1009d0e:	8652                	mv	a2,s4
 1009d10:	85a6                	mv	a1,s1
 1009d12:	850a                	mv	a0,sp
 1009d14:	cd7f90ef          	jal	10039ea <HAL_OTBN_SM3_HMAC>
 1009d18:	bf65                	j	1009cd0 <boot_hkdf+0x52>
 1009d1a:	029cf7b3          	remu	a5,s9,s1
 1009d1e:	029cdbb3          	divu	s7,s9,s1
 1009d22:	00f037b3          	snez	a5,a5
 1009d26:	9bbe                	add	s7,s7,a5
 1009d28:	0ff00793          	li	a5,255
 1009d2c:	fb77ede3          	bltu	a5,s7,1009ce6 <boot_hkdf+0x68>
 1009d30:	4b05                	li	s6,1
 1009d32:	10138a37          	lui	s4,0x10138
 1009d36:	4401                	li	s0,0
 1009d38:	520a0a13          	addi	s4,s4,1312 # 10138520 <temp_buf>
 1009d3c:	8d5a                	mv	s10,s6
 1009d3e:	4d99                	li	s11,6
 1009d40:	016bf463          	bgeu	s7,s6,1009d48 <boot_hkdf+0xca>
 1009d44:	4505                	li	a0,1
 1009d46:	b74d                	j	1009ce8 <boot_hkdf+0x6a>
 1009d48:	8622                	mv	a2,s0
 1009d4a:	108c                	addi	a1,sp,96
 1009d4c:	8552                	mv	a0,s4
 1009d4e:	5c7010ef          	jal	100bb14 <memcpy>
 1009d52:	8662                	mv	a2,s8
 1009d54:	85d6                	mv	a1,s5
 1009d56:	008a0533          	add	a0,s4,s0
 1009d5a:	5bb010ef          	jal	100bb14 <memcpy>
 1009d5e:	008c07b3          	add	a5,s8,s0
 1009d62:	00fa5b0b          	th.srb	s6,s4,a5,0
 1009d66:	0785                	addi	a5,a5,1
 1009d68:	03a90c63          	beq	s2,s10,1009da0 <boot_hkdf+0x122>
 1009d6c:	05b90063          	beq	s2,s11,1009dac <boot_hkdf+0x12e>
 1009d70:	f6091be3          	bnez	s2,1009ce6 <boot_hkdf+0x68>
 1009d74:	8752                	mv	a4,s4
 1009d76:	86a6                	mv	a3,s1
 1009d78:	860a                	mv	a2,sp
 1009d7a:	108c                	addi	a1,sp,96
 1009d7c:	4505                	li	a0,1
 1009d7e:	e17f90ef          	jal	1003b94 <HAL_OTBN_HASH_HMAC>
 1009d82:	416b87b3          	sub	a5,s7,s6
 1009d86:	8666                	mv	a2,s9
 1009d88:	854e                	mv	a0,s3
 1009d8a:	42f4960b          	th.mvnez	a2,s1,a5
 1009d8e:	108c                	addi	a1,sp,96
 1009d90:	585010ef          	jal	100bb14 <memcpy>
 1009d94:	0b05                	addi	s6,s6,1
 1009d96:	409c8cb3          	sub	s9,s9,s1
 1009d9a:	99a6                	add	s3,s3,s1
 1009d9c:	8426                	mv	s0,s1
 1009d9e:	b74d                	j	1009d40 <boot_hkdf+0xc2>
 1009da0:	8752                	mv	a4,s4
 1009da2:	86a6                	mv	a3,s1
 1009da4:	860a                	mv	a2,sp
 1009da6:	108c                	addi	a1,sp,96
 1009da8:	4509                	li	a0,2
 1009daa:	bfd1                	j	1009d7e <boot_hkdf+0x100>
 1009dac:	8726                	mv	a4,s1
 1009dae:	868a                	mv	a3,sp
 1009db0:	863e                	mv	a2,a5
 1009db2:	85d2                	mv	a1,s4
 1009db4:	1088                	addi	a0,sp,96
 1009db6:	c35f90ef          	jal	10039ea <HAL_OTBN_SM3_HMAC>
 1009dba:	b7e1                	j	1009d82 <boot_hkdf+0x104>

01009dbc <rom_delay>:
 1009dbc:	400217b7          	lui	a5,0x40021
 1009dc0:	57d8                	lw	a4,44(a5)
 1009dc2:	46a1                	li	a3,8
 1009dc4:	2047370b          	th.extu	a4,a4,8,4
 1009dc8:	02d70563          	beq	a4,a3,1009df2 <rom_delay+0x36>
 1009dcc:	00e6ed63          	bltu	a3,a4,1009de6 <rom_delay+0x2a>
 1009dd0:	4789                	li	a5,2
 1009dd2:	00e7e563          	bltu	a5,a4,1009ddc <rom_delay+0x20>
 1009dd6:	47e5                	li	a5,25
 1009dd8:	e705                	bnez	a4,1009e00 <rom_delay+0x44>
 1009dda:	a001                	j	1009dda <rom_delay+0x1e>
 1009ddc:	4691                	li	a3,4
 1009dde:	47e5                	li	a5,25
 1009de0:	02d70063          	beq	a4,a3,1009e00 <rom_delay+0x44>
 1009de4:	bfdd                	j	1009dda <rom_delay+0x1e>
 1009de6:	46c1                	li	a3,16
 1009de8:	25800793          	li	a5,600
 1009dec:	00d70a63          	beq	a4,a3,1009e00 <rom_delay+0x44>
 1009df0:	b7ed                	j	1009dda <rom_delay+0x1e>
 1009df2:	57d8                	lw	a4,44(a5)
 1009df4:	25800793          	li	a5,600
 1009df8:	8b3d                	andi	a4,a4,15
 1009dfa:	0705                	addi	a4,a4,1 # 4002f001 <bitmap+0x2feef081>
 1009dfc:	02e7d7b3          	divu	a5,a5,a4
 1009e00:	4585                	li	a1,1
 1009e02:	02a78533          	mul	a0,a5,a0
 1009e06:	810d                	srli	a0,a0,0x3
 1009e08:	bbaf606f          	j	10001c2 <rv32_delay_asm>

01009e0c <open_dpll>:
 1009e0c:	52018793          	addi	a5,gp,1312 # 10138d20 <otp_cfg>
 1009e10:	05c7d683          	lhu	a3,92(a5) # 4002105c <bitmap+0x2fee10dc>
 1009e14:	40021737          	lui	a4,0x40021
 1009e18:	06400513          	li	a0,100
 1009e1c:	cb54                	sw	a3,20(a4)
 1009e1e:	05e7d683          	lhu	a3,94(a5)
 1009e22:	cf54                	sw	a3,28(a4)
 1009e24:	53b4                	lw	a3,96(a5)
 1009e26:	cb14                	sw	a3,16(a4)
 1009e28:	53fc                	lw	a5,100(a5)
 1009e2a:	cf1c                	sw	a5,24(a4)
 1009e2c:	f91ff06f          	j	1009dbc <rom_delay>

01009e30 <boot_sm2_encrypt>:
 1009e30:	7161                	addi	sp,sp,-432
 1009e32:	1a112623          	sw	ra,428(sp)
 1009e36:	1a812423          	sw	s0,424(sp)
 1009e3a:	1a912223          	sw	s1,420(sp)
 1009e3e:	1b00                	addi	s0,sp,432
 1009e40:	1b212023          	sw	s2,416(sp)
 1009e44:	19312e23          	sw	s3,412(sp)
 1009e48:	19412c23          	sw	s4,408(sp)
 1009e4c:	19512a23          	sw	s5,404(sp)
 1009e50:	19612823          	sw	s6,400(sp)
 1009e54:	19712623          	sw	s7,396(sp)
 1009e58:	19812423          	sw	s8,392(sp)
 1009e5c:	19912223          	sw	s9,388(sp)
 1009e60:	19a12023          	sw	s10,384(sp)
 1009e64:	17b12e23          	sw	s11,380(sp)
 1009e68:	8aba                	mv	s5,a4
 1009e6a:	e4d42e23          	sw	a3,-420(s0)
 1009e6e:	84b2                	mv	s1,a2
 1009e70:	8a2a                	mv	s4,a0
 1009e72:	892e                	mv	s2,a1
 1009e74:	8bbe                	mv	s7,a5
 1009e76:	80efe0ef          	jal	1007e84 <HAL_OTBN_Init>
 1009e7a:	00f48793          	addi	a5,s1,15
 1009e7e:	9bc1                	andi	a5,a5,-16
 1009e80:	e5c42583          	lw	a1,-420(s0)
 1009e84:	40f10133          	sub	sp,sp,a5
 1009e88:	e8040c13          	addi	s8,s0,-384
 1009e8c:	8562                	mv	a0,s8
 1009e8e:	8c8a                	mv	s9,sp
 1009e90:	02000613          	li	a2,32
 1009e94:	40f10133          	sub	sp,sp,a5
 1009e98:	0100c9b7          	lui	s3,0x100c
 1009e9c:	3b01                	jal	1009bac <copy_reverse>
 1009e9e:	ea040d93          	addi	s11,s0,-352
 1009ea2:	88898993          	addi	s3,s3,-1912 # 100b888 <SM2_G>
 1009ea6:	85ce                	mv	a1,s3
 1009ea8:	02000613          	li	a2,32
 1009eac:	856e                	mv	a0,s11
 1009eae:	467010ef          	jal	100bb14 <memcpy>
 1009eb2:	02000613          	li	a2,32
 1009eb6:	ec040d13          	addi	s10,s0,-320
 1009eba:	00c985b3          	add	a1,s3,a2
 1009ebe:	856a                	mv	a0,s10
 1009ec0:	455010ef          	jal	100bb14 <memcpy>
 1009ec4:	856e                	mv	a0,s11
 1009ec6:	3b3d                	jal	1009c04 <arr_reverse.constprop.0>
 1009ec8:	856a                	mv	a0,s10
 1009eca:	3b2d                	jal	1009c04 <arr_reverse.constprop.0>
 1009ecc:	e6c40593          	addi	a1,s0,-404
 1009ed0:	e7a42a23          	sw	s10,-396(s0)
 1009ed4:	f4040993          	addi	s3,s0,-192
 1009ed8:	f6040d13          	addi	s10,s0,-160
 1009edc:	4505                	li	a0,1
 1009ede:	e7842623          	sw	s8,-404(s0)
 1009ee2:	e7b42823          	sw	s11,-400(s0)
 1009ee6:	e7a42e23          	sw	s10,-388(s0)
 1009eea:	e7342c23          	sw	s3,-392(s0)
 1009eee:	ddbfa0ef          	jal	1004cc8 <HAL_OTBN_ECC256_ScalarMult_Polling>
 1009ef2:	854e                	mv	a0,s3
 1009ef4:	3b01                	jal	1009c04 <arr_reverse.constprop.0>
 1009ef6:	856a                	mv	a0,s10
 1009ef8:	3331                	jal	1009c04 <arr_reverse.constprop.0>
 1009efa:	ee040d93          	addi	s11,s0,-288
 1009efe:	85d6                	mv	a1,s5
 1009f00:	02000613          	li	a2,32
 1009f04:	856e                	mv	a0,s11
 1009f06:	315d                	jal	1009bac <copy_reverse>
 1009f08:	02000613          	li	a2,32
 1009f0c:	f0040d13          	addi	s10,s0,-256
 1009f10:	00ca85b3          	add	a1,s5,a2
 1009f14:	856a                	mv	a0,s10
 1009f16:	3959                	jal	1009bac <copy_reverse>
 1009f18:	e6c40593          	addi	a1,s0,-404
 1009f1c:	f8040a93          	addi	s5,s0,-128
 1009f20:	e7842623          	sw	s8,-404(s0)
 1009f24:	4505                	li	a0,1
 1009f26:	fa040c13          	addi	s8,s0,-96
 1009f2a:	e7b42823          	sw	s11,-400(s0)
 1009f2e:	e7a42a23          	sw	s10,-396(s0)
 1009f32:	e7542c23          	sw	s5,-392(s0)
 1009f36:	e7842e23          	sw	s8,-388(s0)
 1009f3a:	d8ffa0ef          	jal	1004cc8 <HAL_OTBN_ECC256_ScalarMult_Polling>
 1009f3e:	8556                	mv	a0,s5
 1009f40:	31d1                	jal	1009c04 <arr_reverse.constprop.0>
 1009f42:	8562                	mv	a0,s8
 1009f44:	31c1                	jal	1009c04 <arr_reverse.constprop.0>
 1009f46:	86a6                	mv	a3,s1
 1009f48:	8666                	mv	a2,s9
 1009f4a:	04000593          	li	a1,64
 1009f4e:	8556                	mv	a0,s5
 1009f50:	a0df90ef          	jal	100395c <HAL_OTBN_SM3_KDF>
 1009f54:	8b0a                	mv	s6,sp
 1009f56:	4781                	li	a5,0
 1009f58:	4701                	li	a4,0
 1009f5a:	0a97e263          	bltu	a5,s1,1009ffe <boot_sm2_encrypt+0x1ce>
 1009f5e:	4501                	li	a0,0
 1009f60:	06970163          	beq	a4,s1,1009fc2 <boot_sm2_encrypt+0x192>
 1009f64:	4701                	li	a4,0
 1009f66:	0a976863          	bltu	a4,s1,100a016 <boot_sm2_encrypt+0x1e6>
 1009f6a:	82df90ef          	jal	1003796 <HAL_OTBN_SM3_Init>
 1009f6e:	02000593          	li	a1,32
 1009f72:	8556                	mv	a0,s5
 1009f74:	877f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 1009f78:	8552                	mv	a0,s4
 1009f7a:	85a6                	mv	a1,s1
 1009f7c:	86ff90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 1009f80:	02000593          	li	a1,32
 1009f84:	8562                	mv	a0,s8
 1009f86:	865f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 1009f8a:	f2040513          	addi	a0,s0,-224
 1009f8e:	901f90ef          	jal	100388e <HAL_OTBN_SM3_Final>
 1009f92:	04090a13          	addi	s4,s2,64
 1009f96:	04000613          	li	a2,64
 1009f9a:	85ce                	mv	a1,s3
 1009f9c:	854a                	mv	a0,s2
 1009f9e:	080b8763          	beqz	s7,100a02c <boot_sm2_encrypt+0x1fc>
 1009fa2:	373010ef          	jal	100bb14 <memcpy>
 1009fa6:	02000613          	li	a2,32
 1009faa:	f2040593          	addi	a1,s0,-224
 1009fae:	8552                	mv	a0,s4
 1009fb0:	365010ef          	jal	100bb14 <memcpy>
 1009fb4:	8626                	mv	a2,s1
 1009fb6:	85da                	mv	a1,s6
 1009fb8:	06090513          	addi	a0,s2,96
 1009fbc:	359010ef          	jal	100bb14 <memcpy>
 1009fc0:	4505                	li	a0,1
 1009fc2:	e5040113          	addi	sp,s0,-432
 1009fc6:	1ac12083          	lw	ra,428(sp)
 1009fca:	1a812403          	lw	s0,424(sp)
 1009fce:	1a412483          	lw	s1,420(sp)
 1009fd2:	1a012903          	lw	s2,416(sp)
 1009fd6:	19c12983          	lw	s3,412(sp)
 1009fda:	19812a03          	lw	s4,408(sp)
 1009fde:	19412a83          	lw	s5,404(sp)
 1009fe2:	19012b03          	lw	s6,400(sp)
 1009fe6:	18c12b83          	lw	s7,396(sp)
 1009fea:	18812c03          	lw	s8,392(sp)
 1009fee:	18412c83          	lw	s9,388(sp)
 1009ff2:	18012d03          	lw	s10,384(sp)
 1009ff6:	17c12d83          	lw	s11,380(sp)
 1009ffa:	615d                	addi	sp,sp,432
 1009ffc:	8082                	ret
 1009ffe:	80fcc60b          	th.lrbu	a2,s9,a5,0
 100a002:	00170693          	addi	a3,a4,1 # 40021001 <bitmap+0x2fee1081>
 100a006:	0ff6f693          	zext.b	a3,a3
 100a00a:	0785                	addi	a5,a5,1
 100a00c:	40c6970b          	th.mveqz	a4,a3,a2
 100a010:	0ff7f793          	zext.b	a5,a5
 100a014:	b799                	j	1009f5a <boot_sm2_encrypt+0x12a>
 100a016:	80ea478b          	th.lrbu	a5,s4,a4,0
 100a01a:	80ecc68b          	th.lrbu	a3,s9,a4,0
 100a01e:	8fb5                	xor	a5,a5,a3
 100a020:	00eb578b          	th.srb	a5,s6,a4,0
 100a024:	0705                	addi	a4,a4,1
 100a026:	0ff77713          	zext.b	a4,a4
 100a02a:	bf35                	j	1009f66 <boot_sm2_encrypt+0x136>
 100a02c:	2e9010ef          	jal	100bb14 <memcpy>
 100a030:	8626                	mv	a2,s1
 100a032:	85da                	mv	a1,s6
 100a034:	8552                	mv	a0,s4
 100a036:	2df010ef          	jal	100bb14 <memcpy>
 100a03a:	00990533          	add	a0,s2,s1
 100a03e:	02000613          	li	a2,32
 100a042:	f2040593          	addi	a1,s0,-224
 100a046:	04050513          	addi	a0,a0,64
 100a04a:	bf8d                	j	1009fbc <boot_sm2_encrypt+0x18c>

0100a04c <boot_sm2_decrypt>:
 100a04c:	19f012ef          	jal	t0,100b9ea <__riscv_save_10>
 100a050:	8a2e                	mv	s4,a1
 100a052:	710d                	addi	sp,sp,-352
 100a054:	84aa                	mv	s1,a0
 100a056:	8432                	mv	s0,a2
 100a058:	85b6                	mv	a1,a3
 100a05a:	04050b13          	addi	s6,a0,64
 100a05e:	c721                	beqz	a4,100a0a6 <boot_sm2_decrypt+0x5a>
 100a060:	895a                	mv	s2,s6
 100a062:	06050b13          	addi	s6,a0,96
 100a066:	02010b93          	addi	s7,sp,32
 100a06a:	02000613          	li	a2,32
 100a06e:	855e                	mv	a0,s7
 100a070:	3e35                	jal	1009bac <copy_reverse>
 100a072:	04010a93          	addi	s5,sp,64
 100a076:	85a6                	mv	a1,s1
 100a078:	02000613          	li	a2,32
 100a07c:	8556                	mv	a0,s5
 100a07e:	363d                	jal	1009bac <copy_reverse>
 100a080:	02000613          	li	a2,32
 100a084:	06010993          	addi	s3,sp,96
 100a088:	00c485b3          	add	a1,s1,a2
 100a08c:	854e                	mv	a0,s3
 100a08e:	3e39                	jal	1009bac <copy_reverse>
 100a090:	85ce                	mv	a1,s3
 100a092:	8556                	mv	a0,s5
 100a094:	e0cf90ef          	jal	10036a0 <HAL_OTBN_SM2_ValidPoint_Polling_v2>
 100a098:	84aa                	mv	s1,a0
 100a09a:	e911                	bnez	a0,100a0ae <boot_sm2_decrypt+0x62>
 100a09c:	4481                	li	s1,0
 100a09e:	8526                	mv	a0,s1
 100a0a0:	6135                	addi	sp,sp,352
 100a0a2:	1810106f          	j	100ba22 <__riscv_restore_10>
 100a0a6:	04060913          	addi	s2,a2,64 # 1040 <Reset_Handler-0xffefc0>
 100a0aa:	992a                	add	s2,s2,a0
 100a0ac:	bf6d                	j	100a066 <boot_sm2_decrypt+0x1a>
 100a0ae:	006c                	addi	a1,sp,12
 100a0b0:	c856                	sw	s5,16(sp)
 100a0b2:	ca4e                	sw	s3,20(sp)
 100a0b4:	0c010a93          	addi	s5,sp,192
 100a0b8:	0a010993          	addi	s3,sp,160
 100a0bc:	4505                	li	a0,1
 100a0be:	c65e                	sw	s7,12(sp)
 100a0c0:	cc4e                	sw	s3,24(sp)
 100a0c2:	ce56                	sw	s5,28(sp)
 100a0c4:	c05fa0ef          	jal	1004cc8 <HAL_OTBN_ECC256_ScalarMult_Polling>
 100a0c8:	854e                	mv	a0,s3
 100a0ca:	3e2d                	jal	1009c04 <arr_reverse.constprop.0>
 100a0cc:	8556                	mv	a0,s5
 100a0ce:	3e1d                	jal	1009c04 <arr_reverse.constprop.0>
 100a0d0:	86a2                	mv	a3,s0
 100a0d2:	1190                	addi	a2,sp,224
 100a0d4:	04000593          	li	a1,64
 100a0d8:	854e                	mv	a0,s3
 100a0da:	883f90ef          	jal	100395c <HAL_OTBN_SM3_KDF>
 100a0de:	4701                	li	a4,0
 100a0e0:	0ff77793          	zext.b	a5,a4
 100a0e4:	0487e263          	bltu	a5,s0,100a128 <boot_sm2_decrypt+0xdc>
 100a0e8:	eaef90ef          	jal	1003796 <HAL_OTBN_SM3_Init>
 100a0ec:	02000593          	li	a1,32
 100a0f0:	854e                	mv	a0,s3
 100a0f2:	ef8f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a0f6:	85a2                	mv	a1,s0
 100a0f8:	1208                	addi	a0,sp,288
 100a0fa:	ef0f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a0fe:	02000593          	li	a1,32
 100a102:	8556                	mv	a0,s5
 100a104:	ee6f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a108:	0108                	addi	a0,sp,128
 100a10a:	f84f90ef          	jal	100388e <HAL_OTBN_SM3_Final>
 100a10e:	02000613          	li	a2,32
 100a112:	85ca                	mv	a1,s2
 100a114:	0108                	addi	a0,sp,128
 100a116:	1d9010ef          	jal	100baee <memcmp>
 100a11a:	f149                	bnez	a0,100a09c <boot_sm2_decrypt+0x50>
 100a11c:	8622                	mv	a2,s0
 100a11e:	120c                	addi	a1,sp,288
 100a120:	8552                	mv	a0,s4
 100a122:	1f3010ef          	jal	100bb14 <memcpy>
 100a126:	bfa5                	j	100a09e <boot_sm2_decrypt+0x52>
 100a128:	16078793          	addi	a5,a5,352
 100a12c:	978a                	add	a5,a5,sp
 100a12e:	80eb460b          	th.lrbu	a2,s6,a4,0
 100a132:	f807c683          	lbu	a3,-128(a5)
 100a136:	0705                	addi	a4,a4,1
 100a138:	8eb1                	xor	a3,a3,a2
 100a13a:	fcd78023          	sb	a3,-64(a5)
 100a13e:	b74d                	j	100a0e0 <boot_sm2_decrypt+0x94>

0100a140 <boot_sm2_sign>:
 100a140:	0d3012ef          	jal	t0,100ba12 <__riscv_save_0>
 100a144:	7159                	addi	sp,sp,-112
 100a146:	892a                	mv	s2,a0
 100a148:	84b2                	mv	s1,a2
 100a14a:	1808                	addi	a0,sp,48
 100a14c:	02000613          	li	a2,32
 100a150:	8436                	mv	s0,a3
 100a152:	3ca9                	jal	1009bac <copy_reverse>
 100a154:	02000613          	li	a2,32
 100a158:	85ca                	mv	a1,s2
 100a15a:	0808                	addi	a0,sp,16
 100a15c:	3c81                	jal	1009bac <copy_reverse>
 100a15e:	02000613          	li	a2,32
 100a162:	85a6                	mv	a1,s1
 100a164:	0888                	addi	a0,sp,80
 100a166:	a47ff0ef          	jal	1009bac <copy_reverse>
 100a16a:	3c99                	jal	1009bc0 <ls_otbn_fireware_init>
 100a16c:	15b00793          	li	a5,347
 100a170:	02000613          	li	a2,32
 100a174:	088c                	addi	a1,sp,80
 100a176:	0e000513          	li	a0,224
 100a17a:	c63e                	sw	a5,12(sp)
 100a17c:	d7dfd0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100a180:	c509                	beqz	a0,100a18a <boot_sm2_sign+0x4a>
 100a182:	4501                	li	a0,0
 100a184:	6165                	addi	sp,sp,112
 100a186:	0b10106f          	j	100ba36 <__riscv_restore_0>
 100a18a:	4611                	li	a2,4
 100a18c:	006c                	addi	a1,sp,12
 100a18e:	14000513          	li	a0,320
 100a192:	d67fd0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100a196:	f575                	bnez	a0,100a182 <boot_sm2_sign+0x42>
 100a198:	02000613          	li	a2,32
 100a19c:	4581                	li	a1,0
 100a19e:	1a000513          	li	a0,416
 100a1a2:	d1dfd0ef          	jal	1007ebe <HAL_OTBN_DMEM_Set>
 100a1a6:	fd71                	bnez	a0,100a182 <boot_sm2_sign+0x42>
 100a1a8:	02000613          	li	a2,32
 100a1ac:	080c                	addi	a1,sp,16
 100a1ae:	16000513          	li	a0,352
 100a1b2:	d47fd0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100a1b6:	f571                	bnez	a0,100a182 <boot_sm2_sign+0x42>
 100a1b8:	02000613          	li	a2,32
 100a1bc:	180c                	addi	a1,sp,48
 100a1be:	1e000513          	li	a0,480
 100a1c2:	d37fd0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100a1c6:	fd55                	bnez	a0,100a182 <boot_sm2_sign+0x42>
 100a1c8:	0d800513          	li	a0,216
 100a1cc:	da5fd0ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 100a1d0:	dc3fd0ef          	jal	1007f92 <HAL_OTBN_Error_Bit_Get>
 100a1d4:	f55d                	bnez	a0,100a182 <boot_sm2_sign+0x42>
 100a1d6:	02000613          	li	a2,32
 100a1da:	85a2                	mv	a1,s0
 100a1dc:	20000513          	li	a0,512
 100a1e0:	d53fd0ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 100a1e4:	02040493          	addi	s1,s0,32
 100a1e8:	02000613          	li	a2,32
 100a1ec:	85a6                	mv	a1,s1
 100a1ee:	22000513          	li	a0,544
 100a1f2:	d41fd0ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 100a1f6:	8522                	mv	a0,s0
 100a1f8:	a0dff0ef          	jal	1009c04 <arr_reverse.constprop.0>
 100a1fc:	8526                	mv	a0,s1
 100a1fe:	a07ff0ef          	jal	1009c04 <arr_reverse.constprop.0>
 100a202:	4505                	li	a0,1
 100a204:	b741                	j	100a184 <boot_sm2_sign+0x44>

0100a206 <boot_sm2_verify>:
 100a206:	00d012ef          	jal	t0,100ba12 <__riscv_save_0>
 100a20a:	1141                	addi	sp,sp,-16
 100a20c:	842a                	mv	s0,a0
 100a20e:	9b3ff0ef          	jal	1009bc0 <ls_otbn_fireware_init>
 100a212:	72700793          	li	a5,1831
 100a216:	4611                	li	a2,4
 100a218:	006c                	addi	a1,sp,12
 100a21a:	14000513          	li	a0,320
 100a21e:	c63e                	sw	a5,12(sp)
 100a220:	cd9fd0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100a224:	c509                	beqz	a0,100a22e <boot_sm2_verify+0x28>
 100a226:	4501                	li	a0,0
 100a228:	0141                	addi	sp,sp,16
 100a22a:	00d0106f          	j	100ba36 <__riscv_restore_0>
 100a22e:	444c                	lw	a1,12(s0)
 100a230:	02000613          	li	a2,32
 100a234:	24000513          	li	a0,576
 100a238:	cc1fd0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100a23c:	f56d                	bnez	a0,100a226 <boot_sm2_verify+0x20>
 100a23e:	480c                	lw	a1,16(s0)
 100a240:	02000613          	li	a2,32
 100a244:	26000513          	li	a0,608
 100a248:	cb1fd0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100a24c:	fd69                	bnez	a0,100a226 <boot_sm2_verify+0x20>
 100a24e:	404c                	lw	a1,4(s0)
 100a250:	02000613          	li	a2,32
 100a254:	20000513          	li	a0,512
 100a258:	ca1fd0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100a25c:	f569                	bnez	a0,100a226 <boot_sm2_verify+0x20>
 100a25e:	440c                	lw	a1,8(s0)
 100a260:	02000613          	li	a2,32
 100a264:	22000513          	li	a0,544
 100a268:	c91fd0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100a26c:	fd4d                	bnez	a0,100a226 <boot_sm2_verify+0x20>
 100a26e:	400c                	lw	a1,0(s0)
 100a270:	02000613          	li	a2,32
 100a274:	1e000513          	li	a0,480
 100a278:	c81fd0ef          	jal	1007ef8 <HAL_OTBN_DMEM_Write>
 100a27c:	f54d                	bnez	a0,100a226 <boot_sm2_verify+0x20>
 100a27e:	0d800513          	li	a0,216
 100a282:	ceffd0ef          	jal	1007f70 <HAL_OTBN_CMD_Write_Polling>
 100a286:	d0dfd0ef          	jal	1007f92 <HAL_OTBN_Error_Bit_Get>
 100a28a:	fd51                	bnez	a0,100a226 <boot_sm2_verify+0x20>
 100a28c:	440c                	lw	a1,8(s0)
 100a28e:	02000613          	li	a2,32
 100a292:	28000513          	li	a0,640
 100a296:	c9dfd0ef          	jal	1007f32 <HAL_OTBN_DMEM_Read>
 100a29a:	f551                	bnez	a0,100a226 <boot_sm2_verify+0x20>
 100a29c:	404c                	lw	a1,4(s0)
 100a29e:	4408                	lw	a0,8(s0)
 100a2a0:	02000613          	li	a2,32
 100a2a4:	04b010ef          	jal	100baee <memcmp>
 100a2a8:	00153513          	seqz	a0,a0
 100a2ac:	bfb5                	j	100a228 <boot_sm2_verify+0x22>

0100a2ae <boot_open_wdg>:
 100a2ae:	764012ef          	jal	t0,100ba12 <__riscv_save_0>
 100a2b2:	5a41a603          	lw	a2,1444(gp) # 10138da4 <otp_cfg+0x84>
 100a2b6:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100a2ba:	5106360b          	th.extu	a2,a2,20,16
 100a2be:	0605                	addi	a2,a2,1
 100a2c0:	00f61413          	slli	s0,a2,0xf
 100a2c4:	cb89                	beqz	a5,100a2d6 <boot_open_wdg+0x28>
 100a2c6:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100a2ca:	010085b7          	lui	a1,0x1008
 100a2ce:	8f358593          	addi	a1,a1,-1805 # 10078f3 <HAL_UART_Receive+0x2e3>
 100a2d2:	4505                	li	a0,1
 100a2d4:	9782                	jalr	a5
 100a2d6:	400a2537          	lui	a0,0x400a2
 100a2da:	85a2                	mv	a1,s0
 100a2dc:	80050513          	addi	a0,a0,-2048 # 400a1800 <bitmap+0x2ff61880>
 100a2e0:	b8dfd0ef          	jal	1007e6c <HAL_IWDG_Init>
 100a2e4:	7520106f          	j	100ba36 <__riscv_restore_0>

0100a2e8 <boot_flow_get>:
 100a2e8:	4002f7b7          	lui	a5,0x4002f
 100a2ec:	47b8                	lw	a4,72(a5)
 100a2ee:	460d                	li	a2,3
 100a2f0:	0ff77693          	zext.b	a3,a4
 100a2f4:	8b3d                	andi	a4,a4,15
 100a2f6:	02c70e63          	beq	a4,a2,100a332 <boot_flow_get+0x4a>
 100a2fa:	8ab1                	andi	a3,a3,12
 100a2fc:	ea81                	bnez	a3,100a30c <boot_flow_get+0x24>
 100a2fe:	00070e63          	beqz	a4,100a31a <boot_flow_get+0x32>
 100a302:	4685                	li	a3,1
 100a304:	02d70163          	beq	a4,a3,100a326 <boot_flow_get+0x3e>
 100a308:	4509                	li	a0,2
 100a30a:	8082                	ret
 100a30c:	469d                	li	a3,7
 100a30e:	fed71de3          	bne	a4,a3,100a308 <boot_flow_get+0x20>
 100a312:	47b8                	lw	a4,72(a5)
 100a314:	00876713          	ori	a4,a4,8
 100a318:	a811                	j	100a32c <boot_flow_get+0x44>
 100a31a:	47b8                	lw	a4,72(a5)
 100a31c:	00176713          	ori	a4,a4,1
 100a320:	c7b8                	sw	a4,72(a5)
 100a322:	4501                	li	a0,0
 100a324:	8082                	ret
 100a326:	47b8                	lw	a4,72(a5)
 100a328:	00276713          	ori	a4,a4,2
 100a32c:	c7b8                	sw	a4,72(a5)
 100a32e:	4505                	li	a0,1
 100a330:	8082                	ret
 100a332:	47b8                	lw	a4,72(a5)
 100a334:	00476713          	ori	a4,a4,4
 100a338:	b7e5                	j	100a320 <boot_flow_get+0x38>

0100a33a <boot_io_read>:
 100a33a:	4002f7b7          	lui	a5,0x4002f
 100a33e:	3f07a783          	lw	a5,1008(a5) # 4002f3f0 <bitmap+0x2feef470>
 100a342:	00a7d533          	srl	a0,a5,a0
 100a346:	8905                	andi	a0,a0,1
 100a348:	8082                	ret

0100a34a <boot_otp_read>:
 100a34a:	d75fd06f          	j	10080be <HAL_OTP_Read>

0100a34e <boot_flash_start_xip>:
 100a34e:	6c4012ef          	jal	t0,100ba12 <__riscv_save_0>
 100a352:	52018493          	addi	s1,gp,1312 # 10138d20 <otp_cfg>
 100a356:	0884a783          	lw	a5,136(s1)
 100a35a:	842a                	mv	s0,a0
 100a35c:	2007f713          	andi	a4,a5,512
 100a360:	4007f793          	andi	a5,a5,1024
 100a364:	e3a1                	bnez	a5,100a3a4 <boot_flash_start_xip+0x56>
 100a366:	02070c63          	beqz	a4,100a39e <boot_flash_start_xip+0x50>
 100a36a:	c63fc0ef          	jal	1006fcc <hal_flash_dual_xip_mode_enter>
 100a36e:	400007b7          	lui	a5,0x40000
 100a372:	0007aa23          	sw	zero,20(a5) # 40000014 <bitmap+0x2fec0094>
 100a376:	a0000737          	lui	a4,0xa0000
 100a37a:	400007b7          	lui	a5,0x40000
 100a37e:	cf98                	sw	a4,24(a5)
 100a380:	54f8                	lw	a4,108(s1)
 100a382:	6685                	lui	a3,0x1
 100a384:	8039                	srli	s0,s0,0xe
 100a386:	cb98                	sw	a4,16(a5)
 100a388:	43d8                	lw	a4,4(a5)
 100a38a:	4505                	li	a0,1
 100a38c:	8f55                	or	a4,a4,a3
 100a38e:	c3d8                	sw	a4,4(a5)
 100a390:	08078793          	addi	a5,a5,128 # 40000080 <bitmap+0x2fec0100>
 100a394:	dba0                	sw	s0,112(a5)
 100a396:	8eafd0ef          	jal	1007480 <lscache_cache_enable>
 100a39a:	69c0106f          	j	100ba36 <__riscv_restore_0>
 100a39e:	bfbfc0ef          	jal	1006f98 <hal_flash_quad_xip_mode_enter>
 100a3a2:	b7f1                	j	100a36e <boot_flash_start_xip+0x20>
 100a3a4:	0eb00793          	li	a5,235
 100a3a8:	0bb00693          	li	a3,187
 100a3ac:	42e6978b          	th.mvnez	a5,a3,a4
 100a3b0:	07e2                	slli	a5,a5,0x18
 100a3b2:	00100737          	lui	a4,0x100
 100a3b6:	8fd9                	or	a5,a5,a4
 100a3b8:	40000737          	lui	a4,0x40000
 100a3bc:	cb5c                	sw	a5,20(a4)
 100a3be:	4701                	li	a4,0
 100a3c0:	bf6d                	j	100a37a <boot_flash_start_xip+0x2c>

0100a3c2 <boot_flash_sm4_realtime_decrypt>:
 100a3c2:	636012ef          	jal	t0,100b9f8 <__riscv_save_4>
 100a3c6:	1101                	addi	sp,sp,-32
 100a3c8:	84ae                	mv	s1,a1
 100a3ca:	89b2                	mv	s3,a2
 100a3cc:	85aa                	mv	a1,a0
 100a3ce:	4631                	li	a2,12
 100a3d0:	0048                	addi	a0,sp,4
 100a3d2:	8436                	mv	s0,a3
 100a3d4:	893a                	mv	s2,a4
 100a3d6:	fd6ff0ef          	jal	1009bac <copy_reverse>
 100a3da:	4641                	li	a2,16
 100a3dc:	85a6                	mv	a1,s1
 100a3de:	00c10533          	add	a0,sp,a2
 100a3e2:	400004b7          	lui	s1,0x40000
 100a3e6:	fc6ff0ef          	jal	1009bac <copy_reverse>
 100a3ea:	00f46413          	ori	s0,s0,15
 100a3ee:	0734a823          	sw	s3,112(s1) # 40000070 <bitmap+0x2fec00f0>
 100a3f2:	460d                	li	a2,3
 100a3f4:	004c                	addi	a1,sp,4
 100a3f6:	08848513          	addi	a0,s1,136
 100a3fa:	d8e0                	sw	s0,116(s1)
 100a3fc:	e75fd0ef          	jal	1008270 <memcpy32>
 100a400:	4611                	li	a2,4
 100a402:	080c                	addi	a1,sp,16
 100a404:	0a448513          	addi	a0,s1,164
 100a408:	e69fd0ef          	jal	1008270 <memcpy32>
 100a40c:	08048793          	addi	a5,s1,128
 100a410:	4715                	li	a4,5
 100a412:	d7f8                	sw	a4,108(a5)
 100a414:	470d                	li	a4,3
 100a416:	c398                	sw	a4,0(a5)
 100a418:	00090563          	beqz	s2,100a422 <boot_flash_sm4_realtime_decrypt+0x60>
 100a41c:	4785                	li	a5,1
 100a41e:	0ef4a223          	sw	a5,228(s1)
 100a422:	6105                	addi	sp,sp,32
 100a424:	6080106f          	j	100ba2c <__riscv_restore_4>

0100a428 <boot_flash_read>:
 100a428:	84afd06f          	j	1007472 <hal_flash_fast_read>

0100a42c <boot_crc32>:
 100a42c:	862e                	mv	a2,a1
 100a42e:	85aa                	mv	a1,a0
 100a430:	01006537          	lui	a0,0x1006
 100a434:	eb050513          	addi	a0,a0,-336 # 1005eb0 <CRC32_PARAM>
 100a438:	949fb06f          	j	1005d80 <HAL_LSCRC_CRC_CALC>

0100a43c <boot_hash>:
 100a43c:	5d6012ef          	jal	t0,100ba12 <__riscv_save_0>
 100a440:	87aa                	mv	a5,a0
 100a442:	4505                	li	a0,1
 100a444:	02a78663          	beq	a5,a0,100a470 <boot_hash+0x34>
 100a448:	4719                	li	a4,6
 100a44a:	00e78663          	beq	a5,a4,100a456 <boot_hash+0x1a>
 100a44e:	02078263          	beqz	a5,100a472 <boot_hash+0x36>
 100a452:	5e40106f          	j	100ba36 <__riscv_restore_0>
 100a456:	84ae                	mv	s1,a1
 100a458:	8932                	mv	s2,a2
 100a45a:	8436                	mv	s0,a3
 100a45c:	b3af90ef          	jal	1003796 <HAL_OTBN_SM3_Init>
 100a460:	8526                	mv	a0,s1
 100a462:	85ca                	mv	a1,s2
 100a464:	b86f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a468:	8522                	mv	a0,s0
 100a46a:	c24f90ef          	jal	100388e <HAL_OTBN_SM3_Final>
 100a46e:	b7d5                	j	100a452 <boot_hash+0x16>
 100a470:	4509                	li	a0,2
 100a472:	efef90ef          	jal	1003b70 <HAL_OTBN_HASH>
 100a476:	bff1                	j	100a452 <boot_hash+0x16>

0100a478 <boot_sha256_flash>:
 100a478:	580012ef          	jal	t0,100b9f8 <__riscv_save_4>
 100a47c:	842e                	mv	s0,a1
 100a47e:	84aa                	mv	s1,a0
 100a480:	1141                	addi	sp,sp,-16
 100a482:	4505                	li	a0,1
 100a484:	80047a13          	andi	s4,s0,-2048
 100a488:	6a85                	lui	s5,0x1
 100a48a:	10138937          	lui	s2,0x10138
 100a48e:	89b2                	mv	s3,a2
 100a490:	9a26                	add	s4,s4,s1
 100a492:	e50f90ef          	jal	1003ae2 <HAL_OTBN_HASH_Init>
 100a496:	800a8a93          	addi	s5,s5,-2048 # 800 <Reset_Handler-0xfff800>
 100a49a:	52090913          	addi	s2,s2,1312 # 10138520 <temp_buf>
 100a49e:	03449a63          	bne	s1,s4,100a4d2 <boot_sha256_flash+0x5a>
 100a4a2:	7ff47613          	andi	a2,s0,2047
 100a4a6:	ce19                	beqz	a2,100a4c4 <boot_sha256_flash+0x4c>
 100a4a8:	10138437          	lui	s0,0x10138
 100a4ac:	52040593          	addi	a1,s0,1312 # 10138520 <temp_buf>
 100a4b0:	8526                	mv	a0,s1
 100a4b2:	c632                	sw	a2,12(sp)
 100a4b4:	fbffc0ef          	jal	1007472 <hal_flash_fast_read>
 100a4b8:	4632                	lw	a2,12(sp)
 100a4ba:	52040593          	addi	a1,s0,1312
 100a4be:	4505                	li	a0,1
 100a4c0:	e4ef90ef          	jal	1003b0e <HAL_OTBN_HASH_Update>
 100a4c4:	85ce                	mv	a1,s3
 100a4c6:	4505                	li	a0,1
 100a4c8:	e78f90ef          	jal	1003b40 <HAL_OTBN_HASH_Final>
 100a4cc:	0141                	addi	sp,sp,16
 100a4ce:	55e0106f          	j	100ba2c <__riscv_restore_4>
 100a4d2:	6605                	lui	a2,0x1
 100a4d4:	8526                	mv	a0,s1
 100a4d6:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100a4da:	85ca                	mv	a1,s2
 100a4dc:	f97fc0ef          	jal	1007472 <hal_flash_fast_read>
 100a4e0:	6605                	lui	a2,0x1
 100a4e2:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100a4e6:	85ca                	mv	a1,s2
 100a4e8:	4505                	li	a0,1
 100a4ea:	e24f90ef          	jal	1003b0e <HAL_OTBN_HASH_Update>
 100a4ee:	94d6                	add	s1,s1,s5
 100a4f0:	b77d                	j	100a49e <boot_sha256_flash+0x26>

0100a4f2 <boot_sha384_flash>:
 100a4f2:	506012ef          	jal	t0,100b9f8 <__riscv_save_4>
 100a4f6:	842e                	mv	s0,a1
 100a4f8:	84aa                	mv	s1,a0
 100a4fa:	1141                	addi	sp,sp,-16
 100a4fc:	4509                	li	a0,2
 100a4fe:	80047a13          	andi	s4,s0,-2048
 100a502:	6a85                	lui	s5,0x1
 100a504:	10138937          	lui	s2,0x10138
 100a508:	89b2                	mv	s3,a2
 100a50a:	9a26                	add	s4,s4,s1
 100a50c:	dd6f90ef          	jal	1003ae2 <HAL_OTBN_HASH_Init>
 100a510:	800a8a93          	addi	s5,s5,-2048 # 800 <Reset_Handler-0xfff800>
 100a514:	52090913          	addi	s2,s2,1312 # 10138520 <temp_buf>
 100a518:	03449a63          	bne	s1,s4,100a54c <boot_sha384_flash+0x5a>
 100a51c:	7ff47613          	andi	a2,s0,2047
 100a520:	ce19                	beqz	a2,100a53e <boot_sha384_flash+0x4c>
 100a522:	10138437          	lui	s0,0x10138
 100a526:	52040593          	addi	a1,s0,1312 # 10138520 <temp_buf>
 100a52a:	8526                	mv	a0,s1
 100a52c:	c632                	sw	a2,12(sp)
 100a52e:	f45fc0ef          	jal	1007472 <hal_flash_fast_read>
 100a532:	4632                	lw	a2,12(sp)
 100a534:	52040593          	addi	a1,s0,1312
 100a538:	4509                	li	a0,2
 100a53a:	dd4f90ef          	jal	1003b0e <HAL_OTBN_HASH_Update>
 100a53e:	85ce                	mv	a1,s3
 100a540:	4509                	li	a0,2
 100a542:	dfef90ef          	jal	1003b40 <HAL_OTBN_HASH_Final>
 100a546:	0141                	addi	sp,sp,16
 100a548:	4e40106f          	j	100ba2c <__riscv_restore_4>
 100a54c:	6605                	lui	a2,0x1
 100a54e:	8526                	mv	a0,s1
 100a550:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100a554:	85ca                	mv	a1,s2
 100a556:	f1dfc0ef          	jal	1007472 <hal_flash_fast_read>
 100a55a:	6605                	lui	a2,0x1
 100a55c:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100a560:	85ca                	mv	a1,s2
 100a562:	4509                	li	a0,2
 100a564:	daaf90ef          	jal	1003b0e <HAL_OTBN_HASH_Update>
 100a568:	94d6                	add	s1,s1,s5
 100a56a:	b77d                	j	100a518 <boot_sha384_flash+0x26>

0100a56c <boot_sm3_flash>:
 100a56c:	48c012ef          	jal	t0,100b9f8 <__riscv_save_4>
 100a570:	842e                	mv	s0,a1
 100a572:	84aa                	mv	s1,a0
 100a574:	80047a13          	andi	s4,s0,-2048
 100a578:	6a85                	lui	s5,0x1
 100a57a:	10138937          	lui	s2,0x10138
 100a57e:	89b2                	mv	s3,a2
 100a580:	9a26                	add	s4,s4,s1
 100a582:	a14f90ef          	jal	1003796 <HAL_OTBN_SM3_Init>
 100a586:	800a8a93          	addi	s5,s5,-2048 # 800 <Reset_Handler-0xfff800>
 100a58a:	52090913          	addi	s2,s2,1312 # 10138520 <temp_buf>
 100a58e:	03449763          	bne	s1,s4,100a5bc <boot_sm3_flash+0x50>
 100a592:	7ff47413          	andi	s0,s0,2047
 100a596:	cc11                	beqz	s0,100a5b2 <boot_sm3_flash+0x46>
 100a598:	10138937          	lui	s2,0x10138
 100a59c:	52090593          	addi	a1,s2,1312 # 10138520 <temp_buf>
 100a5a0:	8526                	mv	a0,s1
 100a5a2:	8622                	mv	a2,s0
 100a5a4:	ecffc0ef          	jal	1007472 <hal_flash_fast_read>
 100a5a8:	85a2                	mv	a1,s0
 100a5aa:	52090513          	addi	a0,s2,1312
 100a5ae:	a3cf90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a5b2:	854e                	mv	a0,s3
 100a5b4:	adaf90ef          	jal	100388e <HAL_OTBN_SM3_Final>
 100a5b8:	4740106f          	j	100ba2c <__riscv_restore_4>
 100a5bc:	6605                	lui	a2,0x1
 100a5be:	8526                	mv	a0,s1
 100a5c0:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100a5c4:	85ca                	mv	a1,s2
 100a5c6:	eadfc0ef          	jal	1007472 <hal_flash_fast_read>
 100a5ca:	6585                	lui	a1,0x1
 100a5cc:	80058593          	addi	a1,a1,-2048 # 800 <Reset_Handler-0xfff800>
 100a5d0:	854a                	mv	a0,s2
 100a5d2:	a18f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a5d6:	94d6                	add	s1,s1,s5
 100a5d8:	bf5d                	j	100a58e <boot_sm3_flash+0x22>

0100a5da <boot_sm3_ecdsa_flash>:
 100a5da:	41e012ef          	jal	t0,100b9f8 <__riscv_save_4>
 100a5de:	1141                	addi	sp,sp,-16
 100a5e0:	77e1                	lui	a5,0xffff8
 100a5e2:	893a                	mv	s2,a4
 100a5e4:	8432                	mv	s0,a2
 100a5e6:	84b6                	mv	s1,a3
 100a5e8:	00f11723          	sh	a5,14(sp)
 100a5ec:	8a2a                	mv	s4,a0
 100a5ee:	89ae                	mv	s3,a1
 100a5f0:	9a6f90ef          	jal	1003796 <HAL_OTBN_SM3_Init>
 100a5f4:	4589                	li	a1,2
 100a5f6:	00e10513          	addi	a0,sp,14
 100a5fa:	9f0f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a5fe:	0100c537          	lui	a0,0x100c
 100a602:	09000593          	li	a1,144
 100a606:	8c850513          	addi	a0,a0,-1848 # 100b8c8 <sm2_with_sm3_predata>
 100a60a:	9e0f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a60e:	8552                	mv	a0,s4
 100a610:	02000593          	li	a1,32
 100a614:	9d6f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a618:	02000593          	li	a1,32
 100a61c:	854e                	mv	a0,s3
 100a61e:	9ccf90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a622:	854a                	mv	a0,s2
 100a624:	a6af90ef          	jal	100388e <HAL_OTBN_SM3_Final>
 100a628:	96ef90ef          	jal	1003796 <HAL_OTBN_SM3_Init>
 100a62c:	02000593          	li	a1,32
 100a630:	854a                	mv	a0,s2
 100a632:	8004fa13          	andi	s4,s1,-2048
 100a636:	6a85                	lui	s5,0x1
 100a638:	101389b7          	lui	s3,0x10138
 100a63c:	9aef90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a640:	9a22                	add	s4,s4,s0
 100a642:	800a8a93          	addi	s5,s5,-2048 # 800 <Reset_Handler-0xfff800>
 100a646:	52098993          	addi	s3,s3,1312 # 10138520 <temp_buf>
 100a64a:	03441863          	bne	s0,s4,100a67a <boot_sm3_ecdsa_flash+0xa0>
 100a64e:	7ff4f493          	andi	s1,s1,2047
 100a652:	cc91                	beqz	s1,100a66e <boot_sm3_ecdsa_flash+0x94>
 100a654:	101389b7          	lui	s3,0x10138
 100a658:	52098593          	addi	a1,s3,1312 # 10138520 <temp_buf>
 100a65c:	8522                	mv	a0,s0
 100a65e:	8626                	mv	a2,s1
 100a660:	e13fc0ef          	jal	1007472 <hal_flash_fast_read>
 100a664:	85a6                	mv	a1,s1
 100a666:	52098513          	addi	a0,s3,1312
 100a66a:	980f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a66e:	854a                	mv	a0,s2
 100a670:	a1ef90ef          	jal	100388e <HAL_OTBN_SM3_Final>
 100a674:	0141                	addi	sp,sp,16
 100a676:	3b60106f          	j	100ba2c <__riscv_restore_4>
 100a67a:	6605                	lui	a2,0x1
 100a67c:	8522                	mv	a0,s0
 100a67e:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100a682:	85ce                	mv	a1,s3
 100a684:	deffc0ef          	jal	1007472 <hal_flash_fast_read>
 100a688:	6585                	lui	a1,0x1
 100a68a:	80058593          	addi	a1,a1,-2048 # 800 <Reset_Handler-0xfff800>
 100a68e:	854e                	mv	a0,s3
 100a690:	95af90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a694:	9456                	add	s0,s0,s5
 100a696:	bf55                	j	100a64a <boot_sm3_ecdsa_flash+0x70>

0100a698 <boot_sm3_ecdsa>:
 100a698:	360012ef          	jal	t0,100b9f8 <__riscv_save_4>
 100a69c:	1141                	addi	sp,sp,-16
 100a69e:	77e1                	lui	a5,0xffff8
 100a6a0:	843a                	mv	s0,a4
 100a6a2:	84b2                	mv	s1,a2
 100a6a4:	8936                	mv	s2,a3
 100a6a6:	00f11723          	sh	a5,14(sp)
 100a6aa:	8a2a                	mv	s4,a0
 100a6ac:	89ae                	mv	s3,a1
 100a6ae:	8e8f90ef          	jal	1003796 <HAL_OTBN_SM3_Init>
 100a6b2:	00e10513          	addi	a0,sp,14
 100a6b6:	4589                	li	a1,2
 100a6b8:	932f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a6bc:	0100c537          	lui	a0,0x100c
 100a6c0:	09000593          	li	a1,144
 100a6c4:	8c850513          	addi	a0,a0,-1848 # 100b8c8 <sm2_with_sm3_predata>
 100a6c8:	922f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a6cc:	8552                	mv	a0,s4
 100a6ce:	02000593          	li	a1,32
 100a6d2:	918f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a6d6:	02000593          	li	a1,32
 100a6da:	854e                	mv	a0,s3
 100a6dc:	90ef90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a6e0:	8522                	mv	a0,s0
 100a6e2:	9acf90ef          	jal	100388e <HAL_OTBN_SM3_Final>
 100a6e6:	8b0f90ef          	jal	1003796 <HAL_OTBN_SM3_Init>
 100a6ea:	8522                	mv	a0,s0
 100a6ec:	02000593          	li	a1,32
 100a6f0:	8faf90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a6f4:	85ca                	mv	a1,s2
 100a6f6:	8526                	mv	a0,s1
 100a6f8:	8f2f90ef          	jal	10037ea <HAL_OTBN_SM3_Update>
 100a6fc:	8522                	mv	a0,s0
 100a6fe:	990f90ef          	jal	100388e <HAL_OTBN_SM3_Final>
 100a702:	0141                	addi	sp,sp,16
 100a704:	3280106f          	j	100ba2c <__riscv_restore_4>

0100a708 <boot_uart_init>:
 100a708:	30a012ef          	jal	t0,100ba12 <__riscv_save_0>
 100a70c:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100a710:	c799                	beqz	a5,100a71e <boot_uart_init+0x16>
 100a712:	400a1737          	lui	a4,0x400a1
 100a716:	531c                	lw	a5,32(a4)
 100a718:	4007f793          	andi	a5,a5,1024
 100a71c:	dfed                	beqz	a5,100a716 <boot_uart_init+0xe>
 100a71e:	0c300593          	li	a1,195
 100a722:	0c400513          	li	a0,196
 100a726:	90cf60ef          	jal	1000832 <pinmux_uart1_init>
 100a72a:	10139437          	lui	s0,0x10139
 100a72e:	f9440413          	addi	s0,s0,-108 # 10138f94 <uart_inst>
 100a732:	400a17b7          	lui	a5,0x400a1
 100a736:	c01c                	sw	a5,0(s0)
 100a738:	00844783          	lbu	a5,8(s0)
 100a73c:	8522                	mv	a0,s0
 100a73e:	f807f793          	andi	a5,a5,-128
 100a742:	0037e793          	ori	a5,a5,3
 100a746:	00f40423          	sb	a5,8(s0)
 100a74a:	d95fc0ef          	jal	10074de <HAL_UART_Init>
 100a74e:	4581                	li	a1,0
 100a750:	8522                	mv	a0,s0
 100a752:	efcfd0ef          	jal	1007e4e <HAL_UART_AutoBaudRate_Detect_IT>
 100a756:	2e00106f          	j	100ba36 <__riscv_restore_0>

0100a75a <boot_uart_read>:
 100a75a:	2b8012ef          	jal	t0,100ba12 <__riscv_save_0>
 100a75e:	101397b7          	lui	a5,0x10139
 100a762:	ca09                	beqz	a2,100a774 <boot_uart_read+0x1a>
 100a764:	862e                	mv	a2,a1
 100a766:	85aa                	mv	a1,a0
 100a768:	f9478513          	addi	a0,a5,-108 # 10138f94 <uart_inst>
 100a76c:	c6cfd0ef          	jal	1007bd8 <HAL_UART_Receive_IT>
 100a770:	2c60106f          	j	100ba36 <__riscv_restore_0>
 100a774:	862e                	mv	a2,a1
 100a776:	56fd                	li	a3,-1
 100a778:	85aa                	mv	a1,a0
 100a77a:	f9478513          	addi	a0,a5,-108
 100a77e:	e93fc0ef          	jal	1007610 <HAL_UART_Receive>
 100a782:	b7fd                	j	100a770 <boot_uart_read+0x16>

0100a784 <boot_uart_write>:
 100a784:	28e012ef          	jal	t0,100ba12 <__riscv_save_0>
 100a788:	101397b7          	lui	a5,0x10139
 100a78c:	ca09                	beqz	a2,100a79e <boot_uart_write+0x1a>
 100a78e:	862e                	mv	a2,a1
 100a790:	85aa                	mv	a1,a0
 100a792:	f9478513          	addi	a0,a5,-108 # 10138f94 <uart_inst>
 100a796:	bd2fd0ef          	jal	1007b68 <HAL_UART_Transmit_IT>
 100a79a:	29c0106f          	j	100ba36 <__riscv_restore_0>
 100a79e:	862e                	mv	a2,a1
 100a7a0:	56fd                	li	a3,-1
 100a7a2:	85aa                	mv	a1,a0
 100a7a4:	f9478513          	addi	a0,a5,-108
 100a7a8:	d8bfc0ef          	jal	1007532 <HAL_UART_Transmit>
 100a7ac:	b7fd                	j	100a79a <boot_uart_write+0x16>

0100a7ae <HAL_UART_BaudRateDetectCpltCallback>:
 100a7ae:	d68fe06f          	j	1008d16 <boot_uart_buaddetect_cb>

0100a7b2 <HAL_UART_TxCpltCallback>:
 100a7b2:	d8cfe06f          	j	1008d3e <boot_uart_tx_cb>

0100a7b6 <HAL_UART_RxCpltCallback>:
 100a7b6:	dacfe06f          	j	1008d62 <boot_uart_rx_cb>

0100a7ba <boot_aes_kek_decrypt>:
 100a7ba:	258012ef          	jal	t0,100ba12 <__riscv_save_0>
 100a7be:	7139                	addi	sp,sp,-64
 100a7c0:	c802                	sw	zero,16(sp)
 100a7c2:	ca02                	sw	zero,20(sp)
 100a7c4:	cc02                	sw	zero,24(sp)
 100a7c6:	ce02                	sw	zero,28(sp)
 100a7c8:	03354783          	lbu	a5,51(a0)
 100a7cc:	84b2                	mv	s1,a2
 100a7ce:	03254603          	lbu	a2,50(a0)
 100a7d2:	07a2                	slli	a5,a5,0x8
 100a7d4:	842a                	mv	s0,a0
 100a7d6:	8e5d                	or	a2,a2,a5
 100a7d8:	892e                	mv	s2,a1
 100a7da:	03650593          	addi	a1,a0,54
 100a7de:	0808                	addi	a0,sp,16
 100a7e0:	334010ef          	jal	100bb14 <memcpy>
 100a7e4:	02000613          	li	a2,32
 100a7e8:	00c10533          	add	a0,sp,a2
 100a7ec:	85ca                	mv	a1,s2
 100a7ee:	bbeff0ef          	jal	1009bac <copy_reverse>
 100a7f2:	4589                	li	a1,2
 100a7f4:	1008                	addi	a0,sp,32
 100a7f6:	c1ffb0ef          	jal	1006414 <HAL_LSCRYPT_AES_Key_Config>
 100a7fa:	03044783          	lbu	a5,48(s0)
 100a7fe:	cf91                	beqz	a5,100a81a <boot_aes_kek_decrypt+0x60>
 100a800:	4709                	li	a4,2
 100a802:	4501                	li	a0,0
 100a804:	04e79263          	bne	a5,a4,100a848 <boot_aes_kek_decrypt+0x8e>
 100a808:	86a6                	mv	a3,s1
 100a80a:	03000613          	li	a2,48
 100a80e:	85a2                	mv	a1,s0
 100a810:	0808                	addi	a0,sp,16
 100a812:	c73fb0ef          	jal	1006484 <HAL_LSCRYPT_AES_CTR_Crypt>
 100a816:	4505                	li	a0,1
 100a818:	a805                	j	100a848 <boot_aes_kek_decrypt+0x8e>
 100a81a:	03544783          	lbu	a5,53(s0)
 100a81e:	03344683          	lbu	a3,51(s0)
 100a822:	03444703          	lbu	a4,52(s0)
 100a826:	03244603          	lbu	a2,50(s0)
 100a82a:	07a2                	slli	a5,a5,0x8
 100a82c:	06a2                	slli	a3,a3,0x8
 100a82e:	8fd9                	or	a5,a5,a4
 100a830:	8ed1                	or	a3,a3,a2
 100a832:	c026                	sw	s1,0(sp)
 100a834:	4881                	li	a7,0
 100a836:	4801                	li	a6,0
 100a838:	04640713          	addi	a4,s0,70
 100a83c:	0810                	addi	a2,sp,16
 100a83e:	03000593          	li	a1,48
 100a842:	8522                	mv	a0,s0
 100a844:	d3dfb0ef          	jal	1006580 <HAL_LSCRYPT_AES_GCM_Decrypt>
 100a848:	6121                	addi	sp,sp,64
 100a84a:	1ec0106f          	j	100ba36 <__riscv_restore_0>

0100a84e <boot_sm4_kek_decrypt>:
 100a84e:	1c4012ef          	jal	t0,100ba12 <__riscv_save_0>
 100a852:	1101                	addi	sp,sp,-32
 100a854:	c802                	sw	zero,16(sp)
 100a856:	ca02                	sw	zero,20(sp)
 100a858:	cc02                	sw	zero,24(sp)
 100a85a:	ce02                	sw	zero,28(sp)
 100a85c:	03354783          	lbu	a5,51(a0)
 100a860:	84b2                	mv	s1,a2
 100a862:	03254603          	lbu	a2,50(a0)
 100a866:	07a2                	slli	a5,a5,0x8
 100a868:	842a                	mv	s0,a0
 100a86a:	8e5d                	or	a2,a2,a5
 100a86c:	892e                	mv	s2,a1
 100a86e:	03650593          	addi	a1,a0,54
 100a872:	0808                	addi	a0,sp,16
 100a874:	2a0010ef          	jal	100bb14 <memcpy>
 100a878:	854a                	mv	a0,s2
 100a87a:	c55fa0ef          	jal	10054ce <HAL_SM4_KeyExpansion>
 100a87e:	03044783          	lbu	a5,48(s0)
 100a882:	cf91                	beqz	a5,100a89e <boot_sm4_kek_decrypt+0x50>
 100a884:	4709                	li	a4,2
 100a886:	4501                	li	a0,0
 100a888:	04e79263          	bne	a5,a4,100a8cc <boot_sm4_kek_decrypt+0x7e>
 100a88c:	0808                	addi	a0,sp,16
 100a88e:	86a6                	mv	a3,s1
 100a890:	03000613          	li	a2,48
 100a894:	85a2                	mv	a1,s0
 100a896:	c9dfa0ef          	jal	1005532 <HAL_SM4_CTR_Crypt>
 100a89a:	4505                	li	a0,1
 100a89c:	a805                	j	100a8cc <boot_sm4_kek_decrypt+0x7e>
 100a89e:	03544783          	lbu	a5,53(s0)
 100a8a2:	03344683          	lbu	a3,51(s0)
 100a8a6:	03444703          	lbu	a4,52(s0)
 100a8aa:	03244603          	lbu	a2,50(s0)
 100a8ae:	07a2                	slli	a5,a5,0x8
 100a8b0:	06a2                	slli	a3,a3,0x8
 100a8b2:	8fd9                	or	a5,a5,a4
 100a8b4:	8ed1                	or	a3,a3,a2
 100a8b6:	c026                	sw	s1,0(sp)
 100a8b8:	4881                	li	a7,0
 100a8ba:	4801                	li	a6,0
 100a8bc:	04640713          	addi	a4,s0,70
 100a8c0:	0810                	addi	a2,sp,16
 100a8c2:	03000593          	li	a1,48
 100a8c6:	8522                	mv	a0,s0
 100a8c8:	d3bfa0ef          	jal	1005602 <HAL_SM4_GCM_Decrypt>
 100a8cc:	6105                	addi	sp,sp,32
 100a8ce:	1680106f          	j	100ba36 <__riscv_restore_0>

0100a8d2 <boot_aes_ctr_decrypt>:
 100a8d2:	126012ef          	jal	t0,100b9f8 <__riscv_save_4>
 100a8d6:	7139                	addi	sp,sp,-64
 100a8d8:	84b2                	mv	s1,a2
 100a8da:	4641                	li	a2,16
 100a8dc:	842e                	mv	s0,a1
 100a8de:	89aa                	mv	s3,a0
 100a8e0:	85b6                	mv	a1,a3
 100a8e2:	00c10533          	add	a0,sp,a2
 100a8e6:	8a3a                	mv	s4,a4
 100a8e8:	22c010ef          	jal	100bb14 <memcpy>
 100a8ec:	02000613          	li	a2,32
 100a8f0:	85a6                	mv	a1,s1
 100a8f2:	00c10533          	add	a0,sp,a2
 100a8f6:	ab6ff0ef          	jal	1009bac <copy_reverse>
 100a8fa:	4589                	li	a1,2
 100a8fc:	1008                	addi	a0,sp,32
 100a8fe:	6a85                	lui	s5,0x1
 100a900:	10138937          	lui	s2,0x10138
 100a904:	b11fb0ef          	jal	1006414 <HAL_LSCRYPT_AES_Key_Config>
 100a908:	80047b13          	andi	s6,s0,-2048
 100a90c:	4481                	li	s1,0
 100a90e:	800a8a93          	addi	s5,s5,-2048 # 800 <Reset_Handler-0xfff800>
 100a912:	52090913          	addi	s2,s2,1312 # 10138520 <temp_buf>
 100a916:	014486b3          	add	a3,s1,s4
 100a91a:	00998533          	add	a0,s3,s1
 100a91e:	03649763          	bne	s1,s6,100a94c <boot_aes_ctr_decrypt+0x7a>
 100a922:	7ff47613          	andi	a2,s0,2047
 100a926:	c205                	beqz	a2,100a946 <boot_aes_ctr_decrypt+0x74>
 100a928:	10138437          	lui	s0,0x10138
 100a92c:	52040593          	addi	a1,s0,1312 # 10138520 <temp_buf>
 100a930:	c636                	sw	a3,12(sp)
 100a932:	c432                	sw	a2,8(sp)
 100a934:	b3ffc0ef          	jal	1007472 <hal_flash_fast_read>
 100a938:	46b2                	lw	a3,12(sp)
 100a93a:	4622                	lw	a2,8(sp)
 100a93c:	52040593          	addi	a1,s0,1312
 100a940:	0808                	addi	a0,sp,16
 100a942:	b43fb0ef          	jal	1006484 <HAL_LSCRYPT_AES_CTR_Crypt>
 100a946:	6121                	addi	sp,sp,64
 100a948:	0e40106f          	j	100ba2c <__riscv_restore_4>
 100a94c:	6605                	lui	a2,0x1
 100a94e:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100a952:	85ca                	mv	a1,s2
 100a954:	c436                	sw	a3,8(sp)
 100a956:	b1dfc0ef          	jal	1007472 <hal_flash_fast_read>
 100a95a:	46a2                	lw	a3,8(sp)
 100a95c:	6605                	lui	a2,0x1
 100a95e:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100a962:	85ca                	mv	a1,s2
 100a964:	0808                	addi	a0,sp,16
 100a966:	b1ffb0ef          	jal	1006484 <HAL_LSCRYPT_AES_CTR_Crypt>
 100a96a:	94d6                	add	s1,s1,s5
 100a96c:	b76d                	j	100a916 <boot_aes_ctr_decrypt+0x44>

0100a96e <boot_aes_gcm_decrypt>:
 100a96e:	07c012ef          	jal	t0,100b9ea <__riscv_save_10>
 100a972:	7175                	addi	sp,sp,-144
 100a974:	842e                	mv	s0,a1
 100a976:	8a2a                	mv	s4,a0
 100a978:	8ab2                	mv	s5,a2
 100a97a:	7ff5fb93          	andi	s7,a1,2047
 100a97e:	863e                	mv	a2,a5
 100a980:	85ba                	mv	a1,a4
 100a982:	0808                	addi	a0,sp,16
 100a984:	8936                	mv	s2,a3
 100a986:	84ba                	mv	s1,a4
 100a988:	89c2                	mv	s3,a6
 100a98a:	8b46                	mv	s6,a7
 100a98c:	c63e                	sw	a5,12(sp)
 100a98e:	c802                	sw	zero,16(sp)
 100a990:	ca02                	sw	zero,20(sp)
 100a992:	cc02                	sw	zero,24(sp)
 100a994:	ce02                	sw	zero,28(sp)
 100a996:	17e010ef          	jal	100bb14 <memcpy>
 100a99a:	854a                	mv	a0,s2
 100a99c:	a68ff0ef          	jal	1009c04 <arr_reverse.constprop.0>
 100a9a0:	4589                	li	a1,2
 100a9a2:	854a                	mv	a0,s2
 100a9a4:	a71fb0ef          	jal	1006414 <HAL_LSCRYPT_AES_Key_Config>
 100a9a8:	4632                	lw	a2,12(sp)
 100a9aa:	85a6                	mv	a1,s1
 100a9ac:	1008                	addi	a0,sp,32
 100a9ae:	6c05                	lui	s8,0x1
 100a9b0:	10138937          	lui	s2,0x10138
 100a9b4:	fbbfb0ef          	jal	100696e <HAL_LSCRYPT_AES_GCM_Decrypt_Init>
 100a9b8:	80047413          	andi	s0,s0,-2048
 100a9bc:	4481                	li	s1,0
 100a9be:	800c0c13          	addi	s8,s8,-2048 # 800 <Reset_Handler-0xfff800>
 100a9c2:	52090913          	addi	s2,s2,1312 # 10138520 <temp_buf>
 100a9c6:	01548cb3          	add	s9,s1,s5
 100a9ca:	009a0533          	add	a0,s4,s1
 100a9ce:	02849c63          	bne	s1,s0,100aa06 <boot_aes_gcm_decrypt+0x98>
 100a9d2:	020b8263          	beqz	s7,100a9f6 <boot_aes_gcm_decrypt+0x88>
 100a9d6:	10138437          	lui	s0,0x10138
 100a9da:	865e                	mv	a2,s7
 100a9dc:	52040593          	addi	a1,s0,1312 # 10138520 <temp_buf>
 100a9e0:	a93fc0ef          	jal	1007472 <hal_flash_fast_read>
 100a9e4:	4781                	li	a5,0
 100a9e6:	4701                	li	a4,0
 100a9e8:	86de                	mv	a3,s7
 100a9ea:	52040613          	addi	a2,s0,1312
 100a9ee:	85e6                	mv	a1,s9
 100a9f0:	1008                	addi	a0,sp,32
 100a9f2:	812fc0ef          	jal	1006a04 <HAL_LSCRYPT_AES_GCM_Decrypt_Update>
 100a9f6:	865a                	mv	a2,s6
 100a9f8:	85ce                	mv	a1,s3
 100a9fa:	1008                	addi	a0,sp,32
 100a9fc:	a4afc0ef          	jal	1006c46 <HAL_LSCRYPT_AES_GCM_Decrypt_Final>
 100aa00:	6149                	addi	sp,sp,144
 100aa02:	0200106f          	j	100ba22 <__riscv_restore_10>
 100aa06:	6605                	lui	a2,0x1
 100aa08:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100aa0c:	85ca                	mv	a1,s2
 100aa0e:	a65fc0ef          	jal	1007472 <hal_flash_fast_read>
 100aa12:	6685                	lui	a3,0x1
 100aa14:	4781                	li	a5,0
 100aa16:	4701                	li	a4,0
 100aa18:	80068693          	addi	a3,a3,-2048 # 800 <Reset_Handler-0xfff800>
 100aa1c:	864a                	mv	a2,s2
 100aa1e:	85e6                	mv	a1,s9
 100aa20:	1008                	addi	a0,sp,32
 100aa22:	fe3fb0ef          	jal	1006a04 <HAL_LSCRYPT_AES_GCM_Decrypt_Update>
 100aa26:	94e2                	add	s1,s1,s8
 100aa28:	bf79                	j	100a9c6 <boot_aes_gcm_decrypt+0x58>

0100aa2a <boot_sm4_ctr_decrypt>:
 100aa2a:	7cf002ef          	jal	t0,100b9f8 <__riscv_save_4>
 100aa2e:	1101                	addi	sp,sp,-32
 100aa30:	89aa                	mv	s3,a0
 100aa32:	8532                	mv	a0,a2
 100aa34:	842e                	mv	s0,a1
 100aa36:	c436                	sw	a3,8(sp)
 100aa38:	8a3a                	mv	s4,a4
 100aa3a:	a95fa0ef          	jal	10054ce <HAL_SM4_KeyExpansion>
 100aa3e:	45a2                	lw	a1,8(sp)
 100aa40:	4641                	li	a2,16
 100aa42:	00c10533          	add	a0,sp,a2
 100aa46:	6a85                	lui	s5,0x1
 100aa48:	10138937          	lui	s2,0x10138
 100aa4c:	0c8010ef          	jal	100bb14 <memcpy>
 100aa50:	80047b13          	andi	s6,s0,-2048
 100aa54:	4481                	li	s1,0
 100aa56:	800a8a93          	addi	s5,s5,-2048 # 800 <Reset_Handler-0xfff800>
 100aa5a:	52090913          	addi	s2,s2,1312 # 10138520 <temp_buf>
 100aa5e:	014486b3          	add	a3,s1,s4
 100aa62:	00998533          	add	a0,s3,s1
 100aa66:	03649763          	bne	s1,s6,100aa94 <boot_sm4_ctr_decrypt+0x6a>
 100aa6a:	7ff47613          	andi	a2,s0,2047
 100aa6e:	c205                	beqz	a2,100aa8e <boot_sm4_ctr_decrypt+0x64>
 100aa70:	10138437          	lui	s0,0x10138
 100aa74:	52040593          	addi	a1,s0,1312 # 10138520 <temp_buf>
 100aa78:	c636                	sw	a3,12(sp)
 100aa7a:	c432                	sw	a2,8(sp)
 100aa7c:	9f7fc0ef          	jal	1007472 <hal_flash_fast_read>
 100aa80:	46b2                	lw	a3,12(sp)
 100aa82:	4622                	lw	a2,8(sp)
 100aa84:	52040593          	addi	a1,s0,1312
 100aa88:	0808                	addi	a0,sp,16
 100aa8a:	aa9fa0ef          	jal	1005532 <HAL_SM4_CTR_Crypt>
 100aa8e:	6105                	addi	sp,sp,32
 100aa90:	79d0006f          	j	100ba2c <__riscv_restore_4>
 100aa94:	6605                	lui	a2,0x1
 100aa96:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100aa9a:	85ca                	mv	a1,s2
 100aa9c:	c436                	sw	a3,8(sp)
 100aa9e:	9d5fc0ef          	jal	1007472 <hal_flash_fast_read>
 100aaa2:	46a2                	lw	a3,8(sp)
 100aaa4:	6605                	lui	a2,0x1
 100aaa6:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100aaaa:	85ca                	mv	a1,s2
 100aaac:	0808                	addi	a0,sp,16
 100aaae:	a85fa0ef          	jal	1005532 <HAL_SM4_CTR_Crypt>
 100aab2:	94d6                	add	s1,s1,s5
 100aab4:	b76d                	j	100aa5e <boot_sm4_ctr_decrypt+0x34>

0100aab6 <boot_sm4_gcm_decrypt>:
 100aab6:	735002ef          	jal	t0,100b9ea <__riscv_save_10>
 100aaba:	7119                	addi	sp,sp,-128
 100aabc:	8b2a                	mv	s6,a0
 100aabe:	8536                	mv	a0,a3
 100aac0:	842e                	mv	s0,a1
 100aac2:	8bb2                	mv	s7,a2
 100aac4:	c63a                	sw	a4,12(sp)
 100aac6:	c43e                	sw	a5,8(sp)
 100aac8:	89c2                	mv	s3,a6
 100aaca:	8a46                	mv	s4,a7
 100aacc:	7ff5fa93          	andi	s5,a1,2047
 100aad0:	9fffa0ef          	jal	10054ce <HAL_SM4_KeyExpansion>
 100aad4:	4622                	lw	a2,8(sp)
 100aad6:	45b2                	lw	a1,12(sp)
 100aad8:	0808                	addi	a0,sp,16
 100aada:	6c05                	lui	s8,0x1
 100aadc:	10138937          	lui	s2,0x10138
 100aae0:	ec5fa0ef          	jal	10059a4 <HAL_SM4_GCM_Decrypt_Init>
 100aae4:	80047413          	andi	s0,s0,-2048
 100aae8:	4481                	li	s1,0
 100aaea:	800c0c13          	addi	s8,s8,-2048 # 800 <Reset_Handler-0xfff800>
 100aaee:	52090913          	addi	s2,s2,1312 # 10138520 <temp_buf>
 100aaf2:	01748cb3          	add	s9,s1,s7
 100aaf6:	009b0533          	add	a0,s6,s1
 100aafa:	02849c63          	bne	s1,s0,100ab32 <boot_sm4_gcm_decrypt+0x7c>
 100aafe:	020a8263          	beqz	s5,100ab22 <boot_sm4_gcm_decrypt+0x6c>
 100ab02:	10138437          	lui	s0,0x10138
 100ab06:	8656                	mv	a2,s5
 100ab08:	52040593          	addi	a1,s0,1312 # 10138520 <temp_buf>
 100ab0c:	967fc0ef          	jal	1007472 <hal_flash_fast_read>
 100ab10:	4781                	li	a5,0
 100ab12:	4701                	li	a4,0
 100ab14:	86d6                	mv	a3,s5
 100ab16:	52040613          	addi	a2,s0,1312
 100ab1a:	85e6                	mv	a1,s9
 100ab1c:	0808                	addi	a0,sp,16
 100ab1e:	f0ffa0ef          	jal	1005a2c <HAL_SM4_GCM_Decrypt_Update>
 100ab22:	8652                	mv	a2,s4
 100ab24:	85ce                	mv	a1,s3
 100ab26:	0808                	addi	a0,sp,16
 100ab28:	92afb0ef          	jal	1005c52 <HAL_SM4_GCM_Decrypt_Final>
 100ab2c:	6109                	addi	sp,sp,128
 100ab2e:	6f50006f          	j	100ba22 <__riscv_restore_10>
 100ab32:	6605                	lui	a2,0x1
 100ab34:	80060613          	addi	a2,a2,-2048 # 800 <Reset_Handler-0xfff800>
 100ab38:	85ca                	mv	a1,s2
 100ab3a:	939fc0ef          	jal	1007472 <hal_flash_fast_read>
 100ab3e:	6685                	lui	a3,0x1
 100ab40:	4781                	li	a5,0
 100ab42:	4701                	li	a4,0
 100ab44:	80068693          	addi	a3,a3,-2048 # 800 <Reset_Handler-0xfff800>
 100ab48:	864a                	mv	a2,s2
 100ab4a:	85e6                	mv	a1,s9
 100ab4c:	0808                	addi	a0,sp,16
 100ab4e:	edffa0ef          	jal	1005a2c <HAL_SM4_GCM_Decrypt_Update>
 100ab52:	94e2                	add	s1,s1,s8
 100ab54:	bf79                	j	100aaf2 <boot_sm4_gcm_decrypt+0x3c>

0100ab56 <boot_ecc_verify>:
 100ab56:	695002ef          	jal	t0,100b9ea <__riscv_save_10>
 100ab5a:	716d                	addi	sp,sp,-272
 100ab5c:	03000793          	li	a5,48
 100ab60:	893a                	mv	s2,a4
 100ab62:	02000413          	li	s0,32
 100ab66:	ffc50713          	addi	a4,a0,-4
 100ab6a:	40e7940b          	th.mveqz	s0,a5,a4
 100ab6e:	02010b93          	addi	s7,sp,32
 100ab72:	89ae                	mv	s3,a1
 100ab74:	8ab2                	mv	s5,a2
 100ab76:	85b6                	mv	a1,a3
 100ab78:	8622                	mv	a2,s0
 100ab7a:	84aa                	mv	s1,a0
 100ab7c:	855e                	mv	a0,s7
 100ab7e:	82eff0ef          	jal	1009bac <copy_reverse>
 100ab82:	05010a13          	addi	s4,sp,80
 100ab86:	85ce                	mv	a1,s3
 100ab88:	8622                	mv	a2,s0
 100ab8a:	8552                	mv	a0,s4
 100ab8c:	820ff0ef          	jal	1009bac <copy_reverse>
 100ab90:	08010993          	addi	s3,sp,128
 100ab94:	85d6                	mv	a1,s5
 100ab96:	8622                	mv	a2,s0
 100ab98:	854e                	mv	a0,s3
 100ab9a:	812ff0ef          	jal	1009bac <copy_reverse>
 100ab9e:	0b010b13          	addi	s6,sp,176
 100aba2:	8622                	mv	a2,s0
 100aba4:	85ca                	mv	a1,s2
 100aba6:	855a                	mv	a0,s6
 100aba8:	804ff0ef          	jal	1009bac <copy_reverse>
 100abac:	0e010a93          	addi	s5,sp,224
 100abb0:	8622                	mv	a2,s0
 100abb2:	008905b3          	add	a1,s2,s0
 100abb6:	8556                	mv	a0,s5
 100abb8:	ff5fe0ef          	jal	1009bac <copy_reverse>
 100abbc:	4c11                	li	s8,4
 100abbe:	c65e                	sw	s7,12(sp)
 100abc0:	c85a                	sw	s6,16(sp)
 100abc2:	ca56                	sw	s5,20(sp)
 100abc4:	cc52                	sw	s4,24(sp)
 100abc6:	ce4e                	sw	s3,28(sp)
 100abc8:	01848a63          	beq	s1,s8,100abdc <boot_ecc_verify+0x86>
 100abcc:	4799                	li	a5,6
 100abce:	4501                	li	a0,0
 100abd0:	00f49a63          	bne	s1,a5,100abe4 <boot_ecc_verify+0x8e>
 100abd4:	0068                	addi	a0,sp,12
 100abd6:	e30ff0ef          	jal	100a206 <boot_sm2_verify>
 100abda:	a029                	j	100abe4 <boot_ecc_verify+0x8e>
 100abdc:	006c                	addi	a1,sp,12
 100abde:	4501                	li	a0,0
 100abe0:	b74fa0ef          	jal	1004f54 <HAL_OTBN_ECC384_ECDSA_Verify_Polling>
 100abe4:	6151                	addi	sp,sp,272
 100abe6:	63d0006f          	j	100ba22 <__riscv_restore_10>

0100abea <boot_life_cycle_update_request>:
 100abea:	629002ef          	jal	t0,100ba12 <__riscv_save_0>
 100abee:	4002f4b7          	lui	s1,0x4002f
 100abf2:	8932                	mv	s2,a2
 100abf4:	4789                	li	a5,2
 100abf6:	4611                	li	a2,4
 100abf8:	42a7960b          	th.mvnez	a2,a5,a0
 100abfc:	842a                	mv	s0,a0
 100abfe:	07048513          	addi	a0,s1,112 # 4002f070 <bitmap+0x2feef0f0>
 100ac02:	e6efd0ef          	jal	1008270 <memcpy32>
 100ac06:	0724a623          	sw	s2,108(s1)
 100ac0a:	44bc                	lw	a5,72(s1)
 100ac0c:	7741                	lui	a4,0xffff0
 100ac0e:	0ff70713          	addi	a4,a4,255 # ffff00ff <bitmap+0xefeb017f>
 100ac12:	8ff9                	and	a5,a5,a4
 100ac14:	0422                	slli	s0,s0,0x8
 100ac16:	8fc1                	or	a5,a5,s0
 100ac18:	0207e793          	ori	a5,a5,32
 100ac1c:	c4bc                	sw	a5,72(s1)
 100ac1e:	7e1027f3          	csrr	a5,mhpmevent2
 100ac22:	9bf1                	andi	a5,a5,-4
 100ac24:	0017e793          	ori	a5,a5,1
 100ac28:	7e179073          	csrw	mhpmevent2,a5
 100ac2c:	a001                	j	100ac2c <boot_life_cycle_update_request+0x42>

0100ac2e <life_cycle_update>:
 100ac2e:	5e5002ef          	jal	t0,100ba12 <__riscv_save_0>
 100ac32:	4002f7b7          	lui	a5,0x4002f
 100ac36:	47b0                	lw	a2,72(a5)
 100ac38:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100ac3c:	1101                	addi	sp,sp,-32
 100ac3e:	8221                	srli	a2,a2,0x8
 100ac40:	00c105a3          	sb	a2,11(sp)
 100ac44:	cb99                	beqz	a5,100ac5a <life_cycle_update+0x2c>
 100ac46:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100ac4a:	010085b7          	lui	a1,0x1008
 100ac4e:	0ff67613          	zext.b	a2,a2
 100ac52:	91558593          	addi	a1,a1,-1771 # 1007915 <HAL_UART_Receive+0x305>
 100ac56:	4505                	li	a0,1
 100ac58:	9782                	jalr	a5
 100ac5a:	4002f5b7          	lui	a1,0x4002f
 100ac5e:	4611                	li	a2,4
 100ac60:	07058593          	addi	a1,a1,112 # 4002f070 <bitmap+0x2feef0f0>
 100ac64:	0808                	addi	a0,sp,16
 100ac66:	e0afd0ef          	jal	1008270 <memcpy32>
 100ac6a:	00b14783          	lbu	a5,11(sp)
 100ac6e:	0fc00713          	li	a4,252
 100ac72:	0fd7f693          	andi	a3,a5,253
 100ac76:	08e68463          	beq	a3,a4,100acfe <life_cycle_update+0xd0>
 100ac7a:	0a079d63          	bnez	a5,100ad34 <life_cycle_update+0x106>
 100ac7e:	0100b5b7          	lui	a1,0x100b
 100ac82:	4641                	li	a2,16
 100ac84:	7d858593          	addi	a1,a1,2008 # 100b7d8 <token_invaild.4>
 100ac88:	5e018513          	addi	a0,gp,1504 # 10138de0 <otp_cfg+0xc0>
 100ac8c:	663000ef          	jal	100baee <memcmp>
 100ac90:	c155                	beqz	a0,100ad34 <life_cycle_update+0x106>
 100ac92:	0100b5b7          	lui	a1,0x100b
 100ac96:	4641                	li	a2,16
 100ac98:	7c858593          	addi	a1,a1,1992 # 100b7c8 <token_zeros.3>
 100ac9c:	5e018513          	addi	a0,gp,1504 # 10138de0 <otp_cfg+0xc0>
 100aca0:	64f000ef          	jal	100baee <memcmp>
 100aca4:	c941                	beqz	a0,100ad34 <life_cycle_update+0x106>
 100aca6:	4641                	li	a2,16
 100aca8:	00c105b3          	add	a1,sp,a2
 100acac:	5e018513          	addi	a0,gp,1504 # 10138de0 <otp_cfg+0xc0>
 100acb0:	63f000ef          	jal	100baee <memcmp>
 100acb4:	e141                	bnez	a0,100ad34 <life_cycle_update+0x106>
 100acb6:	c602                	sw	zero,12(sp)
 100acb8:	4002f7b7          	lui	a5,0x4002f
 100acbc:	06c7a903          	lw	s2,108(a5) # 4002f06c <bitmap+0x2feef0ec>
 100acc0:	02800413          	li	s0,40
 100acc4:	40000493          	li	s1,1024
 100acc8:	00345793          	srli	a5,s0,0x3
 100accc:	80f9478b          	th.lrbu	a5,s2,a5,0
 100acd0:	00747713          	andi	a4,s0,7
 100acd4:	40e7d7b3          	sra	a5,a5,a4
 100acd8:	8b85                	andi	a5,a5,1
 100acda:	c799                	beqz	a5,100ace8 <life_cycle_update+0xba>
 100acdc:	4611                	li	a2,4
 100acde:	006c                	addi	a1,sp,12
 100ace0:	00241513          	slli	a0,s0,0x2
 100ace4:	d4cfd0ef          	jal	1008230 <HAL_OTP_Write>
 100ace8:	0405                	addi	s0,s0,1
 100acea:	fc941fe3          	bne	s0,s1,100acc8 <life_cycle_update+0x9a>
 100acee:	4605                	li	a2,1
 100acf0:	00b10593          	addi	a1,sp,11
 100acf4:	08c00513          	li	a0,140
 100acf8:	d38fd0ef          	jal	1008230 <HAL_OTP_Write>
 100acfc:	a825                	j	100ad34 <life_cycle_update+0x106>
 100acfe:	0100b5b7          	lui	a1,0x100b
 100ad02:	4621                	li	a2,8
 100ad04:	7d858593          	addi	a1,a1,2008 # 100b7d8 <token_invaild.4>
 100ad08:	5f018513          	addi	a0,gp,1520 # 10138df0 <otp_cfg+0xd0>
 100ad0c:	5e3000ef          	jal	100baee <memcmp>
 100ad10:	c115                	beqz	a0,100ad34 <life_cycle_update+0x106>
 100ad12:	0100b5b7          	lui	a1,0x100b
 100ad16:	4621                	li	a2,8
 100ad18:	7c858593          	addi	a1,a1,1992 # 100b7c8 <token_zeros.3>
 100ad1c:	5f018513          	addi	a0,gp,1520 # 10138df0 <otp_cfg+0xd0>
 100ad20:	5cf000ef          	jal	100baee <memcmp>
 100ad24:	c901                	beqz	a0,100ad34 <life_cycle_update+0x106>
 100ad26:	4621                	li	a2,8
 100ad28:	080c                	addi	a1,sp,16
 100ad2a:	5f018513          	addi	a0,gp,1520 # 10138df0 <otp_cfg+0xd0>
 100ad2e:	5c1000ef          	jal	100baee <memcmp>
 100ad32:	dd55                	beqz	a0,100acee <life_cycle_update+0xc0>
 100ad34:	6105                	addi	sp,sp,32
 100ad36:	5010006f          	j	100ba36 <__riscv_restore_0>

0100ad3a <boot_life_cycle_check>:
 100ad3a:	4d9002ef          	jal	t0,100ba12 <__riscv_save_0>
 100ad3e:	4002f7b7          	lui	a5,0x4002f
 100ad42:	47b8                	lw	a4,72(a5)
 100ad44:	1141                	addi	sp,sp,-16
 100ad46:	02077713          	andi	a4,a4,32
 100ad4a:	c711                	beqz	a4,100ad56 <boot_life_cycle_check+0x1c>
 100ad4c:	47b8                	lw	a4,72(a5)
 100ad4e:	fdf77713          	andi	a4,a4,-33
 100ad52:	c7b8                	sw	a4,72(a5)
 100ad54:	3de9                	jal	100ac2e <life_cycle_update>
 100ad56:	4605                	li	a2,1
 100ad58:	00f10593          	addi	a1,sp,15
 100ad5c:	08c00513          	li	a0,140
 100ad60:	b5efd0ef          	jal	10080be <HAL_OTP_Read>
 100ad64:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100ad68:	cb99                	beqz	a5,100ad7e <boot_life_cycle_check+0x44>
 100ad6a:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100ad6e:	00f14603          	lbu	a2,15(sp)
 100ad72:	010085b7          	lui	a1,0x1008
 100ad76:	94358593          	addi	a1,a1,-1725 # 1007943 <HAL_UART_Receive+0x333>
 100ad7a:	4505                	li	a0,1
 100ad7c:	9782                	jalr	a5
 100ad7e:	00f14783          	lbu	a5,15(sp)
 100ad82:	0fe00713          	li	a4,254
 100ad86:	00e78f63          	beq	a5,a4,100ada4 <boot_life_cycle_check+0x6a>
 100ad8a:	0ff00713          	li	a4,255
 100ad8e:	02e78b63          	beq	a5,a4,100adc4 <boot_life_cycle_check+0x8a>
 100ad92:	02078963          	beqz	a5,100adc4 <boot_life_cycle_check+0x8a>
 100ad96:	0fc00713          	li	a4,252
 100ad9a:	00e78d63          	beq	a5,a4,100adb4 <boot_life_cycle_check+0x7a>
 100ad9e:	0141                	addi	sp,sp,16
 100ada0:	4970006f          	j	100ba36 <__riscv_restore_0>
 100ada4:	40022737          	lui	a4,0x40022
 100ada8:	435c                	lw	a5,4(a4)
 100adaa:	9bbd                	andi	a5,a5,-17
 100adac:	c35c                	sw	a5,4(a4)
 100adae:	b43f50ef          	jal	10008f0 <pinmux_cjtag_init>
 100adb2:	b7f5                	j	100ad9e <boot_life_cycle_check+0x64>
 100adb4:	40022737          	lui	a4,0x40022
 100adb8:	435c                	lw	a5,4(a4)
 100adba:	9bbd                	andi	a5,a5,-17
 100adbc:	c35c                	sw	a5,4(a4)
 100adbe:	b57f50ef          	jal	1000914 <pinmux_cjtag_deinit>
 100adc2:	bff1                	j	100ad9e <boot_life_cycle_check+0x64>
 100adc4:	40022737          	lui	a4,0x40022
 100adc8:	435c                	lw	a5,4(a4)
 100adca:	0107e793          	ori	a5,a5,16
 100adce:	bff9                	j	100adac <boot_life_cycle_check+0x72>

0100add0 <boot_set_otp_premission>:
 100add0:	443002ef          	jal	t0,100ba12 <__riscv_save_0>
 100add4:	1101                	addi	sp,sp,-32
 100add6:	52018793          	addi	a5,gp,1312 # 10138d20 <otp_cfg>
 100adda:	4701                	li	a4,0
 100addc:	4641                	li	a2,16
 100adde:	0b07a683          	lw	a3,176(a5) # 4002f0b0 <bitmap+0x2feef130>
 100ade2:	080c                	addi	a1,sp,16
 100ade4:	0791                	addi	a5,a5,4
 100ade6:	fff6c693          	not	a3,a3
 100adea:	4027568b          	th.srw	a3,a4,sp,0
 100adee:	09c7a683          	lw	a3,156(a5)
 100adf2:	fff6c693          	not	a3,a3
 100adf6:	40e5d68b          	th.srw	a3,a1,a4,0
 100adfa:	0711                	addi	a4,a4,4 # 40022004 <bitmap+0x2fee2084>
 100adfc:	fec711e3          	bne	a4,a2,100adde <boot_set_otp_premission+0xe>
 100ae00:	850a                	mv	a0,sp
 100ae02:	a90fd0ef          	jal	1008092 <HAL_OTP_SET_WR_Addr>
 100ae06:	0808                	addi	a0,sp,16
 100ae08:	aa0fd0ef          	jal	10080a8 <HAL_OTP_SET_RD_Addr>
 100ae0c:	6105                	addi	sp,sp,32
 100ae0e:	4290006f          	j	100ba36 <__riscv_restore_0>

0100ae12 <boot_otp_code_check>:
 100ae12:	401002ef          	jal	t0,100ba12 <__riscv_save_0>
 100ae16:	52018413          	addi	s0,gp,1312 # 10138d20 <otp_cfg>
 100ae1a:	08d44503          	lbu	a0,141(s0)
 100ae1e:	0ff00793          	li	a5,255
 100ae22:	06f50363          	beq	a0,a5,100ae88 <boot_otp_code_check+0x76>
 100ae26:	08e45603          	lhu	a2,142(s0)
 100ae2a:	67c1                	lui	a5,0x10
 100ae2c:	17f5                	addi	a5,a5,-3 # fffd <Reset_Handler-0xff0003>
 100ae2e:	fff60713          	addi	a4,a2,-1
 100ae32:	3c07370b          	th.extu	a4,a4,15,0
 100ae36:	04e7e963          	bltu	a5,a4,100ae88 <boot_otp_code_check+0x76>
 100ae3a:	04050763          	beqz	a0,100ae88 <boot_otp_code_check+0x76>
 100ae3e:	1013f4b7          	lui	s1,0x1013f
 100ae42:	14e48593          	addi	a1,s1,334 # 1013f14e <otp_code>
 100ae46:	0516                	slli	a0,a0,0x5
 100ae48:	a76fd0ef          	jal	10080be <HAL_OTP_Read>
 100ae4c:	08e45583          	lhu	a1,142(s0)
 100ae50:	14e48513          	addi	a0,s1,334
 100ae54:	dd8ff0ef          	jal	100a42c <boot_crc32>
 100ae58:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100ae5c:	0d842403          	lw	s0,216(s0)
 100ae60:	84aa                	mv	s1,a0
 100ae62:	cf89                	beqz	a5,100ae7c <boot_otp_code_check+0x6a>
 100ae64:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100ae68:	40850633          	sub	a2,a0,s0
 100ae6c:	010085b7          	lui	a1,0x1008
 100ae70:	00163613          	seqz	a2,a2
 100ae74:	96658593          	addi	a1,a1,-1690 # 1007966 <HAL_UART_Receive+0x356>
 100ae78:	4505                	li	a0,1
 100ae7a:	9782                	jalr	a5
 100ae7c:	00849663          	bne	s1,s0,100ae88 <boot_otp_code_check+0x76>
 100ae80:	0f134097          	auipc	ra,0xf134
 100ae84:	2ce080e7          	jalr	718(ra) # 1013f14e <otp_code>
 100ae88:	3af0006f          	j	100ba36 <__riscv_restore_0>

0100ae8c <lvds_cfg>:
 100ae8c:	357002ef          	jal	t0,100b9e2 <__riscv_save_12>
 100ae90:	711d                	addi	sp,sp,-96
 100ae92:	d7af50ef          	jal	100040c <HAL_MSP_LTPI_PHY_Init>
 100ae96:	d8cf50ef          	jal	1000422 <HAL_MSP_LTPI_HPM_Init>
 100ae9a:	52018613          	addi	a2,gp,1312 # 10138d20 <otp_cfg>
 100ae9e:	463c                	lw	a5,72(a2)
 100aea0:	04865b03          	lhu	s6,72(a2)
 100aea4:	04a64a83          	lbu	s5,74(a2)
 100aea8:	6587b70b          	th.extu	a4,a5,25,24
 100aeac:	c43a                	sw	a4,8(sp)
 100aeae:	6da7b70b          	th.extu	a4,a5,27,26
 100aeb2:	0772                	slli	a4,a4,0x1c
 100aeb4:	c63a                	sw	a4,12(sp)
 100aeb6:	75c7b70b          	th.extu	a4,a5,29,28
 100aeba:	83f9                	srli	a5,a5,0x1e
 100aebc:	07fa                	slli	a5,a5,0x1e
 100aebe:	ca3e                	sw	a5,20(sp)
 100aec0:	467c                	lw	a5,76(a2)
 100aec2:	077a                	slli	a4,a4,0x1e
 100aec4:	c83a                	sw	a4,16(sp)
 100aec6:	03f7f713          	andi	a4,a5,63
 100aeca:	0742                	slli	a4,a4,0x10
 100aecc:	cc3a                	sw	a4,24(sp)
 100aece:	1c67b70b          	th.extu	a4,a5,7,6
 100aed2:	075a                	slli	a4,a4,0x16
 100aed4:	ce3a                	sw	a4,28(sp)
 100aed6:	2c87b70b          	th.extu	a4,a5,11,8
 100aeda:	38c7b78b          	th.extu	a5,a5,14,12
 100aede:	07c2                	slli	a5,a5,0x10
 100aee0:	d23e                	sw	a5,36(sp)
 100aee2:	04e65783          	lhu	a5,78(a2)
 100aee6:	0722                	slli	a4,a4,0x8
 100aee8:	d03a                	sw	a4,32(sp)
 100aeea:	07c2                	slli	a5,a5,0x10
 100aeec:	d43e                	sw	a5,40(sp)
 100aeee:	4a3c                	lw	a5,80(a2)
 100aef0:	4006bdb7          	lui	s11,0x4006b
 100aef4:	3ff7f713          	andi	a4,a5,1023
 100aef8:	d63a                	sw	a4,44(sp)
 100aefa:	2ca7b70b          	th.extu	a4,a5,11,10
 100aefe:	0766                	slli	a4,a4,0x19
 100af00:	d83a                	sw	a4,48(sp)
 100af02:	34c7b70b          	th.extu	a4,a5,13,12
 100af06:	0772                	slli	a4,a4,0x1c
 100af08:	da3a                	sw	a4,52(sp)
 100af0a:	3ce7b70b          	th.extu	a4,a5,15,14
 100af0e:	077a                	slli	a4,a4,0x1e
 100af10:	dc3a                	sw	a4,56(sp)
 100af12:	5507b70b          	th.extu	a4,a5,21,16
 100af16:	0742                	slli	a4,a4,0x10
 100af18:	de3a                	sw	a4,60(sp)
 100af1a:	5d67b70b          	th.extu	a4,a5,23,22
 100af1e:	075a                	slli	a4,a4,0x16
 100af20:	c0ba                	sw	a4,64(sp)
 100af22:	6d87b70b          	th.extu	a4,a5,27,24
 100af26:	75c7b78b          	th.extu	a5,a5,29,28
 100af2a:	078a                	slli	a5,a5,0x2
 100af2c:	c4be                	sw	a5,72(sp)
 100af2e:	4a7c                	lw	a5,84(a2)
 100af30:	0752                	slli	a4,a4,0x14
 100af32:	c2ba                	sw	a4,68(sp)
 100af34:	5107b70b          	th.extu	a4,a5,20,16
 100af38:	0742                	slli	a4,a4,0x10
 100af3a:	c6ba                	sw	a4,76(sp)
 100af3c:	5957b70b          	th.extu	a4,a5,22,21
 100af40:	0756                	slli	a4,a4,0x15
 100af42:	c8ba                	sw	a4,80(sp)
 100af44:	7187b70b          	th.extu	a4,a5,28,24
 100af48:	79d7b78b          	th.extu	a5,a5,30,29
 100af4c:	0762                	slli	a4,a4,0x18
 100af4e:	07f6                	slli	a5,a5,0x1d
 100af50:	caba                	sw	a4,84(sp)
 100af52:	ccbe                	sw	a5,88(sp)
 100af54:	ffe00d37          	lui	s10,0xffe00
 100af58:	4006b7b7          	lui	a5,0x4006b
 100af5c:	c1000cb7          	lui	s9,0xc1000
 100af60:	7c41                	lui	s8,0xffff0
 100af62:	ffc10337          	lui	t1,0xffc10
 100af66:	ff000bb7          	lui	s7,0xff000
 100af6a:	d0000eb7          	lui	t4,0xd0000
 100af6e:	ff400e37          	lui	t3,0xff400
 100af72:	7a7d                	lui	s4,0xfffff
 100af74:	fff909b7          	lui	s3,0xfff90
 100af78:	fa000937          	lui	s2,0xfa000
 100af7c:	ff1004b7          	lui	s1,0xff100
 100af80:	ffe10437          	lui	s0,0xffe10
 100af84:	ffa003b7          	lui	t2,0xffa00
 100af88:	e10002b7          	lui	t0,0xe1000
 100af8c:	a0000fb7          	lui	t6,0xa0000
 100af90:	140d8713          	addi	a4,s11,320 # 4006b140 <bitmap+0x2ff2b1c0>
 100af94:	0b22                	slli	s6,s6,0x8
 100af96:	0ae2                	slli	s5,s5,0x18
 100af98:	08078793          	addi	a5,a5,128 # 4006b080 <bitmap+0x2ff2b100>
 100af9c:	53818593          	addi	a1,gp,1336 # 10138d38 <otp_cfg+0x18>
 100afa0:	1d7d                	addi	s10,s10,-1 # ffdfffff <bitmap+0xefcc007f>
 100afa2:	1cfd                	addi	s9,s9,-1 # c0ffffff <bitmap+0xb0ec007f>
 100afa4:	0ffc0c13          	addi	s8,s8,255 # ffff00ff <bitmap+0xefeb017f>
 100afa8:	137d                	addi	t1,t1,-1 # ffc0ffff <bitmap+0xefad007f>
 100afaa:	0ffb8b93          	addi	s7,s7,255 # ff0000ff <bitmap+0xeeec017f>
 100afae:	1efd                	addi	t4,t4,-1 # cfffffff <bitmap+0xbfec007f>
 100afb0:	1e7d                	addi	t3,t3,-1 # ff3fffff <bitmap+0xef2c007f>
 100afb2:	0ffa0a13          	addi	s4,s4,255 # fffff0ff <bitmap+0xefebf17f>
 100afb6:	19fd                	addi	s3,s3,-1 # fff8ffff <bitmap+0xefe5007f>
 100afb8:	197d                	addi	s2,s2,-1 # f9ffffff <bitmap+0xe9ec007f>
 100afba:	14fd                	addi	s1,s1,-1 # ff0fffff <bitmap+0xeefc007f>
 100afbc:	147d                	addi	s0,s0,-1 # ffe0ffff <bitmap+0xefcd007f>
 100afbe:	13fd                	addi	t2,t2,-1 # ff9fffff <bitmap+0xef8c007f>
 100afc0:	12fd                	addi	t0,t0,-1 # e0ffffff <bitmap+0xd0ec007f>
 100afc2:	1ffd                	addi	t6,t6,-1 # 9fffffff <bitmap+0x8fec007f>
 100afc4:	ceba                	sw	a4,92(sp)
 100afc6:	4658                	lw	a4,12(a2)
 100afc8:	4394                	lw	a3,0(a5)
 100afca:	43c8                	lw	a0,4(a5)
 100afcc:	34c7370b          	th.extu	a4,a4,13,12
 100afd0:	9ae5                	andi	a3,a3,-7
 100afd2:	0706                	slli	a4,a4,0x1
 100afd4:	8f55                	or	a4,a4,a3
 100afd6:	c398                	sw	a4,0(a5)
 100afd8:	4654                	lw	a3,12(a2)
 100afda:	01a57533          	and	a0,a0,s10
 100afde:	f0777713          	andi	a4,a4,-249
 100afe2:	38e6b68b          	th.extu	a3,a3,14,14
 100afe6:	06d6                	slli	a3,a3,0x15
 100afe8:	8ec9                	or	a3,a3,a0
 100afea:	c3d4                	sw	a3,4(a5)
 100afec:	4a54                	lw	a3,20(a2)
 100afee:	43c8                	lw	a0,4(a5)
 100aff0:	00c7d803          	lhu	a6,12(a5)
 100aff4:	3cb6b68b          	th.extu	a3,a3,15,11
 100aff8:	068e                	slli	a3,a3,0x3
 100affa:	8ed9                	or	a3,a3,a4
 100affc:	c394                	sw	a3,0(a5)
 100affe:	4a58                	lw	a4,20(a2)
 100b000:	5bd4                	lw	a3,52(a5)
 100b002:	01957533          	and	a0,a0,s9
 100b006:	5d57370b          	th.extu	a4,a4,23,21
 100b00a:	fc76f693          	andi	a3,a3,-57
 100b00e:	070e                	slli	a4,a4,0x3
 100b010:	8f55                	or	a4,a4,a3
 100b012:	dbd8                	sw	a4,52(a5)
 100b014:	4a58                	lw	a4,20(a2)
 100b016:	5394                	lw	a3,32(a5)
 100b018:	6587370b          	th.extu	a4,a4,25,24
 100b01c:	9ae5                	andi	a3,a3,-7
 100b01e:	0706                	slli	a4,a4,0x1
 100b020:	8f55                	or	a4,a4,a3
 100b022:	d398                	sw	a4,32(a5)
 100b024:	4198                	lw	a4,0(a1)
 100b026:	4794                	lw	a3,8(a5)
 100b028:	07f77713          	andi	a4,a4,127
 100b02c:	f806f693          	andi	a3,a3,-128
 100b030:	8f55                	or	a4,a4,a3
 100b032:	c798                	sw	a4,8(a5)
 100b034:	4194                	lw	a3,0(a1)
 100b036:	4f98                	lw	a4,24(a5)
 100b038:	2476b68b          	th.extu	a3,a3,9,7
 100b03c:	f8f77713          	andi	a4,a4,-113
 100b040:	0692                	slli	a3,a3,0x4
 100b042:	8ed9                	or	a3,a3,a4
 100b044:	4198                	lw	a4,0(a1)
 100b046:	0176f6b3          	and	a3,a3,s7
 100b04a:	0166e6b3          	or	a3,a3,s6
 100b04e:	3ca7370b          	th.extu	a4,a4,15,10
 100b052:	0762                	slli	a4,a4,0x18
 100b054:	8f49                	or	a4,a4,a0
 100b056:	0025d503          	lhu	a0,2(a1)
 100b05a:	01877733          	and	a4,a4,s8
 100b05e:	5c06b68b          	th.extu	a3,a3,23,0
 100b062:	0542                	slli	a0,a0,0x10
 100b064:	01056533          	or	a0,a0,a6
 100b068:	c7c8                	sw	a0,12(a5)
 100b06a:	0075c803          	lbu	a6,7(a1)
 100b06e:	41c8                	lw	a0,4(a1)
 100b070:	0156e6b3          	or	a3,a3,s5
 100b074:	0862                	slli	a6,a6,0x18
 100b076:	5c05350b          	th.extu	a0,a0,23,0
 100b07a:	01056533          	or	a0,a0,a6
 100b07e:	0085a803          	lw	a6,8(a1)
 100b082:	cb88                	sw	a0,16(a5)
 100b084:	0085c503          	lbu	a0,8(a1)
 100b088:	f0087813          	andi	a6,a6,-256
 100b08c:	01056533          	or	a0,a0,a6
 100b090:	00c5c803          	lbu	a6,12(a1)
 100b094:	cbc8                	sw	a0,20(a5)
 100b096:	0822                	slli	a6,a6,0x8
 100b098:	00e86833          	or	a6,a6,a4
 100b09c:	5798                	lw	a4,40(a5)
 100b09e:	45c8                	lw	a0,12(a1)
 100b0a0:	7408380b          	th.extu	a6,a6,29,0
 100b0a4:	9b41                	andi	a4,a4,-16
 100b0a6:	2485388b          	th.extu	a7,a0,9,8
 100b0aa:	01176733          	or	a4,a4,a7
 100b0ae:	2ca5388b          	th.extu	a7,a0,11,10
 100b0b2:	088a                	slli	a7,a7,0x2
 100b0b4:	01176733          	or	a4,a4,a7
 100b0b8:	38c5350b          	th.extu	a0,a0,14,12
 100b0bc:	0512                	slli	a0,a0,0x4
 100b0be:	f8f77713          	andi	a4,a4,-113
 100b0c2:	8f49                	or	a4,a4,a0
 100b0c4:	45c8                	lw	a0,12(a1)
 100b0c6:	0247a883          	lw	a7,36(a5)
 100b0ca:	4f32                	lw	t5,12(sp)
 100b0cc:	5505350b          	th.extu	a0,a0,21,16
 100b0d0:	0068f8b3          	and	a7,a7,t1
 100b0d4:	0542                	slli	a0,a0,0x10
 100b0d6:	01156533          	or	a0,a0,a7
 100b0da:	00f5c883          	lbu	a7,15(a1)
 100b0de:	5c05350b          	th.extu	a0,a0,23,0
 100b0e2:	cf94                	sw	a3,24(a5)
 100b0e4:	08e2                	slli	a7,a7,0x18
 100b0e6:	01156533          	or	a0,a0,a7
 100b0ea:	01c7a883          	lw	a7,28(a5)
 100b0ee:	46a2                	lw	a3,8(sp)
 100b0f0:	01277733          	and	a4,a4,s2
 100b0f4:	ffc8f893          	andi	a7,a7,-4
 100b0f8:	00d8e8b3          	or	a7,a7,a3
 100b0fc:	46d2                	lw	a3,20(sp)
 100b0fe:	0148f8b3          	and	a7,a7,s4
 100b102:	994d                	andi	a0,a0,-13
 100b104:	00d86833          	or	a6,a6,a3
 100b108:	4794                	lw	a3,8(a5)
 100b10a:	01387833          	and	a6,a6,s3
 100b10e:	05c1                	addi	a1,a1,16
 100b110:	01d6f6b3          	and	a3,a3,t4
 100b114:	01e6e6b3          	or	a3,a3,t5
 100b118:	4f42                	lw	t5,16(sp)
 100b11a:	7406b68b          	th.extu	a3,a3,29,0
 100b11e:	01e6e6b3          	or	a3,a3,t5
 100b122:	4f62                	lw	t5,24(sp)
 100b124:	0066f6b3          	and	a3,a3,t1
 100b128:	01e6e6b3          	or	a3,a3,t5
 100b12c:	4f72                	lw	t5,28(sp)
 100b12e:	01c6f6b3          	and	a3,a3,t3
 100b132:	01e6e6b3          	or	a3,a3,t5
 100b136:	c794                	sw	a3,8(a5)
 100b138:	5682                	lw	a3,32(sp)
 100b13a:	00d8e8b3          	or	a7,a7,a3
 100b13e:	5692                	lw	a3,36(sp)
 100b140:	0117ae23          	sw	a7,28(a5)
 100b144:	00d86833          	or	a6,a6,a3
 100b148:	0107a223          	sw	a6,4(a5)
 100b14c:	02c7d683          	lhu	a3,44(a5)
 100b150:	5822                	lw	a6,40(sp)
 100b152:	0106e6b3          	or	a3,a3,a6
 100b156:	d7d4                	sw	a3,44(a5)
 100b158:	5b94                	lw	a3,48(a5)
 100b15a:	5832                	lw	a6,44(sp)
 100b15c:	c006f693          	andi	a3,a3,-1024
 100b160:	0106e6b3          	or	a3,a3,a6
 100b164:	5842                	lw	a6,48(sp)
 100b166:	8ee5                	and	a3,a3,s1
 100b168:	01076733          	or	a4,a4,a6
 100b16c:	5852                	lw	a6,52(sp)
 100b16e:	01d77733          	and	a4,a4,t4
 100b172:	01076733          	or	a4,a4,a6
 100b176:	5862                	lw	a6,56(sp)
 100b178:	7407370b          	th.extu	a4,a4,29,0
 100b17c:	01076733          	or	a4,a4,a6
 100b180:	5872                	lw	a6,60(sp)
 100b182:	00677733          	and	a4,a4,t1
 100b186:	01076733          	or	a4,a4,a6
 100b18a:	4806                	lw	a6,64(sp)
 100b18c:	01c77733          	and	a4,a4,t3
 100b190:	01076733          	or	a4,a4,a6
 100b194:	d798                	sw	a4,40(a5)
 100b196:	4716                	lw	a4,68(sp)
 100b198:	8ed9                	or	a3,a3,a4
 100b19a:	4726                	lw	a4,72(sp)
 100b19c:	db94                	sw	a3,48(a5)
 100b19e:	8d59                	or	a0,a0,a4
 100b1a0:	d3c8                	sw	a0,36(a5)
 100b1a2:	5398                	lw	a4,32(a5)
 100b1a4:	46b6                	lw	a3,76(sp)
 100b1a6:	8f61                	and	a4,a4,s0
 100b1a8:	8f55                	or	a4,a4,a3
 100b1aa:	46c6                	lw	a3,80(sp)
 100b1ac:	00777733          	and	a4,a4,t2
 100b1b0:	8f55                	or	a4,a4,a3
 100b1b2:	46d6                	lw	a3,84(sp)
 100b1b4:	00577733          	and	a4,a4,t0
 100b1b8:	8f55                	or	a4,a4,a3
 100b1ba:	46e6                	lw	a3,88(sp)
 100b1bc:	01f77733          	and	a4,a4,t6
 100b1c0:	8f55                	or	a4,a4,a3
 100b1c2:	00176713          	ori	a4,a4,1
 100b1c6:	d398                	sw	a4,32(a5)
 100b1c8:	4398                	lw	a4,0(a5)
 100b1ca:	00176713          	ori	a4,a4,1
 100b1ce:	5e87d70b          	th.swia	a4,(a5),8,3
 100b1d2:	4776                	lw	a4,92(sp)
 100b1d4:	dee799e3          	bne	a5,a4,100afc6 <lvds_cfg+0x13a>
 100b1d8:	4e3c                	lw	a5,88(a2)
 100b1da:	06fdac23          	sw	a5,120(s11)
 100b1de:	05465783          	lhu	a5,84(a2)
 100b1e2:	07c2                	slli	a5,a5,0x10
 100b1e4:	06fdae23          	sw	a5,124(s11)
 100b1e8:	6125                	addi	sp,sp,96
 100b1ea:	0350006f          	j	100ba1e <__riscv_restore_12>

0100b1ee <lvds_process>:
 100b1ee:	025002ef          	jal	t0,100ba12 <__riscv_save_0>
 100b1f2:	4002f7b7          	lui	a5,0x4002f
 100b1f6:	5fdc                	lw	a5,60(a5)
 100b1f8:	0187d713          	srli	a4,a5,0x18
 100b1fc:	07f77713          	andi	a4,a4,127
 100b200:	c721                	beqz	a4,100b248 <lvds_process+0x5a>
 100b202:	c0bfe0ef          	jal	1009e0c <open_dpll>
 100b206:	3159                	jal	100ae8c <lvds_cfg>
 100b208:	4006b6b7          	lui	a3,0x4006b
 100b20c:	5ebc                	lw	a5,120(a3)
 100b20e:	fffc0737          	lui	a4,0xfffc0
 100b212:	177d                	addi	a4,a4,-1 # fffbffff <bitmap+0xefe8007f>
 100b214:	8ff9                	and	a5,a5,a4
 100b216:	debc                	sw	a5,120(a3)
 100b218:	4006a737          	lui	a4,0x4006a
 100b21c:	10072783          	lw	a5,256(a4) # 4006a100 <bitmap+0x2ff2a180>
 100b220:	663d                	lui	a2,0xf
 100b222:	6691                	lui	a3,0x4
 100b224:	0017e793          	ori	a5,a5,1
 100b228:	10f72023          	sw	a5,256(a4)
 100b22c:	431c                	lw	a5,0(a4)
 100b22e:	8ff1                	and	a5,a5,a2
 100b230:	fed79ee3          	bne	a5,a3,100b22c <lvds_process+0x3e>
 100b234:	4006a637          	lui	a2,0x4006a
 100b238:	000f06b7          	lui	a3,0xf0
 100b23c:	00040737          	lui	a4,0x40
 100b240:	421c                	lw	a5,0(a2)
 100b242:	8ff5                	and	a5,a5,a3
 100b244:	fee79ee3          	bne	a5,a4,100b240 <lvds_process+0x52>
 100b248:	4002f437          	lui	s0,0x4002f
 100b24c:	483c                	lw	a5,80(s0)
 100b24e:	dffd                	beqz	a5,100b24c <lvds_process+0x5e>
 100b250:	483c                	lw	a5,80(s0)
 100b252:	9782                	jalr	a5
 100b254:	bfe5                	j	100b24c <lvds_process+0x5e>

0100b256 <platform_init>:
 100b256:	7a2002ef          	jal	t0,100b9f8 <__riscv_save_4>
 100b25a:	1141                	addi	sp,sp,-16
 100b25c:	30046073          	csrsi	mstatus,8
 100b260:	e11fc0ef          	jal	1008070 <HAL_OTP_CTRL_Init>
 100b264:	52018593          	addi	a1,gp,1312 # 10138d20 <otp_cfg>
 100b268:	1a000613          	li	a2,416
 100b26c:	4501                	li	a0,0
 100b26e:	e51fc0ef          	jal	10080be <HAL_OTP_Read>
 100b272:	1013e4b7          	lui	s1,0x1013e
 100b276:	45300613          	li	a2,1107
 100b27a:	4581                	li	a1,0
 100b27c:	00048513          	mv	a0,s1
 100b280:	804fd0ef          	jal	1008284 <memset32>
 100b284:	52018413          	addi	s0,gp,1312 # 10138d20 <otp_cfg>
 100b288:	405c                	lw	a5,4(s0)
 100b28a:	0a07c063          	bltz	a5,100b32a <platform_init+0xd4>
 100b28e:	4418                	lw	a4,8(s0)
 100b290:	6791                	lui	a5,0x4
 100b292:	17c1                	addi	a5,a5,-16 # 3ff0 <Reset_Handler-0xffc010>
 100b294:	4002f6b7          	lui	a3,0x4002f
 100b298:	3ce7358b          	th.extu	a1,a4,15,14
 100b29c:	00f7e793          	ori	a5,a5,15
 100b2a0:	4e90                	lw	a2,24(a3)
 100b2a2:	8ff9                	and	a5,a5,a4
 100b2a4:	05ba                	slli	a1,a1,0xe
 100b2a6:	4d07370b          	th.extu	a4,a4,19,16
 100b2aa:	8fcd                	or	a5,a5,a1
 100b2ac:	0742                	slli	a4,a4,0x10
 100b2ae:	8fd9                	or	a5,a5,a4
 100b2b0:	fff00737          	lui	a4,0xfff00
 100b2b4:	8f71                	and	a4,a4,a2
 100b2b6:	8fd9                	or	a5,a5,a4
 100b2b8:	ce9c                	sw	a5,24(a3)
 100b2ba:	4858                	lw	a4,20(s0)
 100b2bc:	4a90                	lw	a2,16(a3)
 100b2be:	6505                	lui	a0,0x1
 100b2c0:	1c57378b          	th.extu	a5,a4,7,5
 100b2c4:	0792                	slli	a5,a5,0x4
 100b2c6:	70077713          	andi	a4,a4,1792
 100b2ca:	8fd9                	or	a5,a5,a4
 100b2cc:	88f67713          	andi	a4,a2,-1905
 100b2d0:	8fd9                	or	a5,a5,a4
 100b2d2:	ca9c                	sw	a5,16(a3)
 100b2d4:	4458                	lw	a4,12(s0)
 100b2d6:	4ad0                	lw	a2,20(a3)
 100b2d8:	00048493          	mv	s1,s1
 100b2dc:	4d07378b          	th.extu	a5,a4,19,16
 100b2e0:	01c75593          	srli	a1,a4,0x1c
 100b2e4:	05f2                	slli	a1,a1,0x1c
 100b2e6:	07c2                	slli	a5,a5,0x10
 100b2e8:	2c07370b          	th.extu	a4,a4,11,0
 100b2ec:	8fcd                	or	a5,a5,a1
 100b2ee:	3c07370b          	th.extu	a4,a4,15,0
 100b2f2:	8fd9                	or	a5,a5,a4
 100b2f4:	0ff0f737          	lui	a4,0xff0f
 100b2f8:	8f71                	and	a4,a4,a2
 100b2fa:	8fd9                	or	a5,a5,a4
 100b2fc:	cadc                	sw	a5,20(a3)
 100b2fe:	4818                	lw	a4,16(s0)
 100b300:	40021637          	lui	a2,0x40021
 100b304:	5e14                	lw	a3,56(a2)
 100b306:	2ca7378b          	th.extu	a5,a4,11,10
 100b30a:	07aa                	slli	a5,a5,0xa
 100b30c:	3ff77713          	andi	a4,a4,1023
 100b310:	8fd9                	or	a5,a5,a4
 100b312:	777d                	lui	a4,0xfffff
 100b314:	8f75                	and	a4,a4,a3
 100b316:	8fd9                	or	a5,a5,a4
 100b318:	0e950513          	addi	a0,a0,233 # 10e9 <Reset_Handler-0xffef17>
 100b31c:	de1c                	sw	a5,56(a2)
 100b31e:	85a2                	mv	a1,s0
 100b320:	06000613          	li	a2,96
 100b324:	9526                	add	a0,a0,s1
 100b326:	7ee000ef          	jal	100bb14 <memcpy>
 100b32a:	4002f7b7          	lui	a5,0x4002f
 100b32e:	000f0737          	lui	a4,0xf0
 100b332:	3ee7a223          	sw	a4,996(a5) # 4002f3e4 <bitmap+0x2feef464>
 100b336:	3e07a023          	sw	zero,992(a5)
 100b33a:	3e07a423          	sw	zero,1000(a5)
 100b33e:	3e07a623          	sw	zero,1004(a5)
 100b342:	3e07a823          	sw	zero,1008(a5)
 100b346:	3f07a703          	lw	a4,1008(a5)
 100b34a:	8b05                	andi	a4,a4,1
 100b34c:	c311                	beqz	a4,100b350 <platform_init+0xfa>
 100b34e:	3545                	jal	100b1ee <lvds_process>
 100b350:	5fd8                	lw	a4,60(a5)
 100b352:	7987370b          	th.extu	a4,a4,30,24
 100b356:	22070663          	beqz	a4,100b582 <platform_init+0x32c>
 100b35a:	08842703          	lw	a4,136(s0) # 4002f088 <bitmap+0x2feef108>
 100b35e:	01371693          	slli	a3,a4,0x13
 100b362:	2206c663          	bltz	a3,100b58e <platform_init+0x338>
 100b366:	10077713          	andi	a4,a4,256
 100b36a:	5824                	lw	s1,112(s0)
 100b36c:	07442903          	lw	s2,116(s0)
 100b370:	e715                	bnez	a4,100b39c <platform_init+0x146>
 100b372:	5b98                	lw	a4,48(a5)
 100b374:	800006b7          	lui	a3,0x80000
 100b378:	4529                	li	a0,10
 100b37a:	00476713          	ori	a4,a4,4
 100b37e:	db98                	sw	a4,48(a5)
 100b380:	5b98                	lw	a4,48(a5)
 100b382:	8f55                	or	a4,a4,a3
 100b384:	db98                	sw	a4,48(a5)
 100b386:	5b98                	lw	a4,48(a5)
 100b388:	7807370b          	th.extu	a4,a4,30,0
 100b38c:	db98                	sw	a4,48(a5)
 100b38e:	08442783          	lw	a5,132(s0)
 100b392:	83d5                	srli	a5,a5,0x15
 100b394:	02a78533          	mul	a0,a5,a0
 100b398:	a25fe0ef          	jal	1009dbc <rom_delay>
 100b39c:	a71fe0ef          	jal	1009e0c <open_dpll>
 100b3a0:	08042703          	lw	a4,128(s0)
 100b3a4:	400217b7          	lui	a5,0x40021
 100b3a8:	db98                	sw	a4,48(a5)
 100b3aa:	5c38                	lw	a4,120(s0)
 100b3ac:	d7d8                	sw	a4,44(a5)
 100b3ae:	4705                	li	a4,1
 100b3b0:	d798                	sw	a4,40(a5)
 100b3b2:	5c78                	lw	a4,124(s0)
 100b3b4:	d7d8                	sw	a4,44(a5)
 100b3b6:	e2ff40ef          	jal	10001e4 <lsqspiv2_msp_init>
 100b3ba:	400007b7          	lui	a5,0x40000
 100b3be:	c384                	sw	s1,0(a5)
 100b3c0:	0127a223          	sw	s2,4(a5) # 40000004 <bitmap+0x2fec0084>
 100b3c4:	cd8f50ef          	jal	100089c <pinmux_hal_flash_quad_init>
 100b3c8:	eedfb0ef          	jal	10072b4 <hal_flash_xip_func_ptr_dummy>
 100b3cc:	4581                	li	a1,0
 100b3ce:	4501                	li	a0,0
 100b3d0:	ed7fb0ef          	jal	10072a6 <hal_flash_drv_var_init>
 100b3d4:	08842783          	lw	a5,136(s0)
 100b3d8:	1867b70b          	th.extu	a4,a5,6,6
 100b3dc:	d0e18a23          	sb	a4,-748(gp) # 10138514 <log_en>
 100b3e0:	cf39                	beqz	a4,100b43e <platform_init+0x1e8>
 100b3e2:	08445903          	lhu	s2,132(s0)
 100b3e6:	77c1                	lui	a5,0xffff0
 100b3e8:	0785                	addi	a5,a5,1 # ffff0001 <bitmap+0xefeb0081>
 100b3ea:	97ca                	add	a5,a5,s2
 100b3ec:	0d900713          	li	a4,217
 100b3f0:	40f7190b          	th.mveqz	s2,a4,a5
 100b3f4:	fbdfc0ef          	jal	10083b0 <ls_log_init>
 100b3f8:	f0ff40ef          	jal	1000306 <LL_UART1_MSP_Init>
 100b3fc:	0c300593          	li	a1,195
 100b400:	0c400513          	li	a0,196
 100b404:	c2ef50ef          	jal	1000832 <pinmux_uart1_init>
 100b408:	400a17b7          	lui	a5,0x400a1
 100b40c:	47d8                	lw	a4,12(a5)
 100b40e:	08076713          	ori	a4,a4,128
 100b412:	c7d8                	sw	a4,12(a5)
 100b414:	0127a423          	sw	s2,8(a5) # 400a1008 <bitmap+0x2ff61088>
 100b418:	47d8                	lw	a4,12(a5)
 100b41a:	f7f77713          	andi	a4,a4,-129
 100b41e:	c7d8                	sw	a4,12(a5)
 100b420:	471d                	li	a4,7
 100b422:	cfd8                	sw	a4,28(a5)
 100b424:	470d                	li	a4,3
 100b426:	c7d8                	sw	a4,12(a5)
 100b428:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b42c:	cb89                	beqz	a5,100b43e <platform_init+0x1e8>
 100b42e:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b432:	010085b7          	lui	a1,0x1008
 100b436:	98858593          	addi	a1,a1,-1656 # 1007988 <HAL_UART_Receive+0x378>
 100b43a:	4505                	li	a0,1
 100b43c:	9782                	jalr	a5
 100b43e:	01008a37          	lui	s4,0x1008
 100b442:	8922                	mv	s2,s0
 100b444:	4981                	li	s3,0
 100b446:	99fa0a13          	addi	s4,s4,-1633 # 100799f <HAL_UART_Receive+0x38f>
 100b44a:	0c000a93          	li	s5,192
 100b44e:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b452:	cf99                	beqz	a5,100b470 <platform_init+0x21a>
 100b454:	d101a883          	lw	a7,-752(gp) # 10138510 <log_output_fn>
 100b458:	00c92803          	lw	a6,12(s2)
 100b45c:	00892783          	lw	a5,8(s2)
 100b460:	00492703          	lw	a4,4(s2)
 100b464:	00092683          	lw	a3,0(s2)
 100b468:	864e                	mv	a2,s3
 100b46a:	85d2                	mv	a1,s4
 100b46c:	4505                	li	a0,1
 100b46e:	9882                	jalr	a7
 100b470:	09c1                	addi	s3,s3,16
 100b472:	0941                	addi	s2,s2,16
 100b474:	fd599de3          	bne	s3,s5,100b44e <platform_init+0x1f8>
 100b478:	e0800937          	lui	s2,0xe0800
 100b47c:	00092783          	lw	a5,0(s2) # e0800000 <bitmap+0xd06c0080>
 100b480:	010005b7          	lui	a1,0x1000
 100b484:	00094703          	lbu	a4,0(s2)
 100b488:	0ff7f793          	zext.b	a5,a5
 100b48c:	01e7e793          	ori	a5,a5,30
 100b490:	00f90023          	sb	a5,0(s2)
 100b494:	0c858593          	addi	a1,a1,200 # 10000c8 <SWINT_Handler_ASM>
 100b498:	4579                	li	a0,30
 100b49a:	cb8f50ef          	jal	1000952 <rv_set_int_isr>
 100b49e:	e08017b7          	lui	a5,0xe0801
 100b4a2:	4709                	li	a4,2
 100b4a4:	06e78d23          	sb	a4,122(a5) # e080107a <bitmap+0xd06c10fa>
 100b4a8:	00492703          	lw	a4,4(s2)
 100b4ac:	4621                	li	a2,8
 100b4ae:	0ff00693          	li	a3,255
 100b4b2:	6157370b          	th.extu	a4,a4,24,21
 100b4b6:	8e19                	sub	a2,a2,a4
 100b4b8:	07b7c703          	lbu	a4,123(a5)
 100b4bc:	00c696b3          	sll	a3,a3,a2
 100b4c0:	fff6c693          	not	a3,a3
 100b4c4:	8f75                	and	a4,a4,a3
 100b4c6:	46bd                	li	a3,15
 100b4c8:	00c696b3          	sll	a3,a3,a2
 100b4cc:	8f55                	or	a4,a4,a3
 100b4ce:	0ff77713          	zext.b	a4,a4
 100b4d2:	06e78da3          	sb	a4,123(a5)
 100b4d6:	0787c703          	lbu	a4,120(a5)
 100b4da:	0fe77713          	andi	a4,a4,254
 100b4de:	06e78c23          	sb	a4,120(a5)
 100b4e2:	0797c703          	lbu	a4,121(a5)
 100b4e6:	00176713          	ori	a4,a4,1
 100b4ea:	06e78ca3          	sb	a4,121(a5)
 100b4ee:	4002f7b7          	lui	a5,0x4002f
 100b4f2:	47bc                	lw	a5,72(a5)
 100b4f4:	8bc1                	andi	a5,a5,16
 100b4f6:	cf91                	beqz	a5,100b512 <platform_init+0x2bc>
 100b4f8:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b4fc:	cb89                	beqz	a5,100b50e <platform_init+0x2b8>
 100b4fe:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b502:	010085b7          	lui	a1,0x1008
 100b506:	9cc58593          	addi	a1,a1,-1588 # 10079cc <HAL_UART_Receive+0x3bc>
 100b50a:	4505                	li	a0,1
 100b50c:	9782                	jalr	a5
 100b50e:	af9fb0ef          	jal	1007006 <hal_flash_xip_mode_reset>
 100b512:	08842783          	lw	a5,136(s0)
 100b516:	0207f793          	andi	a5,a5,32
 100b51a:	e79d                	bnez	a5,100b548 <platform_init+0x2f2>
 100b51c:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b520:	cb89                	beqz	a5,100b532 <platform_init+0x2dc>
 100b522:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b526:	010085b7          	lui	a1,0x1008
 100b52a:	9e858593          	addi	a1,a1,-1560 # 10079e8 <HAL_UART_Receive+0x3d8>
 100b52e:	4505                	li	a0,1
 100b530:	9782                	jalr	a5
 100b532:	c83fb0ef          	jal	10071b4 <hal_flash_release_from_deep_power_down>
 100b536:	4551                	li	a0,20
 100b538:	885fe0ef          	jal	1009dbc <rom_delay>
 100b53c:	d55fb0ef          	jal	1007290 <hal_flash_software_reset>
 100b540:	0c800513          	li	a0,200
 100b544:	879fe0ef          	jal	1009dbc <rom_delay>
 100b548:	f47f90ef          	jal	100548e <HAL_SM4_Init>
 100b54c:	939fc0ef          	jal	1007e84 <HAL_OTBN_Init>
 100b550:	809fa0ef          	jal	1005d58 <HAL_LSCRC_Init>
 100b554:	ea7fa0ef          	jal	10063fa <HAL_LSCRYPT_Init>
 100b558:	4501                	li	a0,0
 100b55a:	eb3fa0ef          	jal	100640c <HAL_LSCRYPT_Block_Padding_Mode_Set>
 100b55e:	08842783          	lw	a5,136(s0)
 100b562:	01279713          	slli	a4,a5,0x12
 100b566:	02075a63          	bgez	a4,100b59a <platform_init+0x344>
 100b56a:	101397b7          	lui	a5,0x10139
 100b56e:	470d                	li	a4,3
 100b570:	fce78423          	sb	a4,-56(a5) # 10138fc8 <goto_next_mstatus>
 100b574:	fc878793          	addi	a5,a5,-56
 100b578:	4705                	li	a4,1
 100b57a:	00e780a3          	sb	a4,1(a5)
 100b57e:	0141                	addi	sp,sp,16
 100b580:	a175                	j	100ba2c <__riscv_restore_4>
 100b582:	400007b7          	lui	a5,0x40000
 100b586:	4384                	lw	s1,0(a5)
 100b588:	0047a903          	lw	s2,4(a5) # 40000004 <bitmap+0x2fec0084>
 100b58c:	b52d                	j	100b3b6 <platform_init+0x160>
 100b58e:	010404b7          	lui	s1,0x1040
 100b592:	4901                	li	s2,0
 100b594:	20248493          	addi	s1,s1,514 # 1040202 <__boot_rom_data_lma__+0x346c2>
 100b598:	bd39                	j	100b3b6 <platform_init+0x160>
 100b59a:	0100c937          	lui	s2,0x100c
 100b59e:	99890513          	addi	a0,s2,-1640 # 100b998 <test_key>
 100b5a2:	f2df90ef          	jal	10054ce <HAL_SM4_KeyExpansion>
 100b5a6:	10138437          	lui	s0,0x10138
 100b5aa:	4641                	li	a2,16
 100b5ac:	52040593          	addi	a1,s0,1312 # 10138520 <temp_buf>
 100b5b0:	99890513          	addi	a0,s2,-1640
 100b5b4:	f39f90ef          	jal	10054ec <HAL_SM4_Encrypt>
 100b5b8:	0100c9b7          	lui	s3,0x100c
 100b5bc:	4641                	li	a2,16
 100b5be:	98898593          	addi	a1,s3,-1656 # 100b988 <sm4_result>
 100b5c2:	52040513          	addi	a0,s0,1312
 100b5c6:	2325                	jal	100baee <memcmp>
 100b5c8:	cd09                	beqz	a0,100b5e2 <platform_init+0x38c>
 100b5ca:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b5ce:	cb89                	beqz	a5,100b5e0 <platform_init+0x38a>
 100b5d0:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b5d4:	010085b7          	lui	a1,0x1008
 100b5d8:	a0058593          	addi	a1,a1,-1536 # 1007a00 <HAL_UART_Receive+0x3f0>
 100b5dc:	4505                	li	a0,1
 100b5de:	9782                	jalr	a5
 100b5e0:	a001                	j	100b5e0 <platform_init+0x38a>
 100b5e2:	4641                	li	a2,16
 100b5e4:	52040593          	addi	a1,s0,1312
 100b5e8:	98898513          	addi	a0,s3,-1656
 100b5ec:	f23f90ef          	jal	100550e <HAL_SM4_Decrypt>
 100b5f0:	4641                	li	a2,16
 100b5f2:	99890593          	addi	a1,s2,-1640
 100b5f6:	52040513          	addi	a0,s0,1312
 100b5fa:	29d5                	jal	100baee <memcmp>
 100b5fc:	cd09                	beqz	a0,100b616 <platform_init+0x3c0>
 100b5fe:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b602:	cb89                	beqz	a5,100b614 <platform_init+0x3be>
 100b604:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b608:	010085b7          	lui	a1,0x1008
 100b60c:	a2858593          	addi	a1,a1,-1496 # 1007a28 <HAL_UART_Receive+0x418>
 100b610:	4505                	li	a0,1
 100b612:	9782                	jalr	a5
 100b614:	a001                	j	100b614 <platform_init+0x3be>
 100b616:	01006537          	lui	a0,0x1006
 100b61a:	02000613          	li	a2,32
 100b61e:	99890593          	addi	a1,s2,-1640
 100b622:	eb050513          	addi	a0,a0,-336 # 1005eb0 <CRC32_PARAM>
 100b626:	f5afa0ef          	jal	1005d80 <HAL_LSCRC_CRC_CALC>
 100b62a:	c42a                	sw	a0,8(sp)
 100b62c:	4722                	lw	a4,8(sp)
 100b62e:	c405e7b7          	lui	a5,0xc405e
 100b632:	02878793          	addi	a5,a5,40 # c405e028 <bitmap+0xb3f1e0a8>
 100b636:	00f70e63          	beq	a4,a5,100b652 <platform_init+0x3fc>
 100b63a:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b63e:	cb89                	beqz	a5,100b650 <platform_init+0x3fa>
 100b640:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b644:	010085b7          	lui	a1,0x1008
 100b648:	a5858593          	addi	a1,a1,-1448 # 1007a58 <HAL_UART_Receive+0x448>
 100b64c:	4505                	li	a0,1
 100b64e:	9782                	jalr	a5
 100b650:	a001                	j	100b650 <platform_init+0x3fa>
 100b652:	e58f80ef          	jal	1003caa <HAL_OTBN_SHA256_Init>
 100b656:	02000593          	li	a1,32
 100b65a:	99890513          	addi	a0,s2,-1640
 100b65e:	ed4f80ef          	jal	1003d32 <HAL_OTBN_SHA256_Update>
 100b662:	52040513          	addi	a0,s0,1312
 100b666:	f5cf80ef          	jal	1003dc2 <HAL_OTBN_SHA256_Final>
 100b66a:	0100c5b7          	lui	a1,0x100c
 100b66e:	02000613          	li	a2,32
 100b672:	96858593          	addi	a1,a1,-1688 # 100b968 <sha_result>
 100b676:	52040513          	addi	a0,s0,1312
 100b67a:	2995                	jal	100baee <memcmp>
 100b67c:	cd09                	beqz	a0,100b696 <platform_init+0x440>
 100b67e:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b682:	cb89                	beqz	a5,100b694 <platform_init+0x43e>
 100b684:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b688:	010085b7          	lui	a1,0x1008
 100b68c:	a8058593          	addi	a1,a1,-1408 # 1007a80 <HAL_UART_Receive+0x470>
 100b690:	4505                	li	a0,1
 100b692:	9782                	jalr	a5
 100b694:	a001                	j	100b694 <platform_init+0x43e>
 100b696:	49c1                	li	s3,16
 100b698:	4589                	li	a1,2
 100b69a:	99890513          	addi	a0,s2,-1640
 100b69e:	c64e                	sw	s3,12(sp)
 100b6a0:	d75fa0ef          	jal	1006414 <HAL_LSCRYPT_AES_Key_Config>
 100b6a4:	52040613          	addi	a2,s0,1312
 100b6a8:	85ce                	mv	a1,s3
 100b6aa:	0074                	addi	a3,sp,12
 100b6ac:	99890513          	addi	a0,s2,-1640
 100b6b0:	da3fa0ef          	jal	1006452 <HAL_LSCRYPT_AES_ECB_Encrypt>
 100b6b4:	0100c5b7          	lui	a1,0x100c
 100b6b8:	864e                	mv	a2,s3
 100b6ba:	95858593          	addi	a1,a1,-1704 # 100b958 <aes_result>
 100b6be:	52040513          	addi	a0,s0,1312
 100b6c2:	2135                	jal	100baee <memcmp>
 100b6c4:	cd09                	beqz	a0,100b6de <platform_init+0x488>
 100b6c6:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b6ca:	cb89                	beqz	a5,100b6dc <platform_init+0x486>
 100b6cc:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b6d0:	010085b7          	lui	a1,0x1008
 100b6d4:	aab58593          	addi	a1,a1,-1365 # 1007aab <HAL_UART_Receive+0x49b>
 100b6d8:	4505                	li	a0,1
 100b6da:	9782                	jalr	a5
 100b6dc:	a001                	j	100b6dc <platform_init+0x486>
 100b6de:	0100c937          	lui	s2,0x100c
 100b6e2:	0100cab7          	lui	s5,0x100c
 100b6e6:	0100c437          	lui	s0,0x100c
 100b6ea:	4785                	li	a5,1
 100b6ec:	80890713          	addi	a4,s2,-2040 # 100b808 <g_pub_key>
 100b6f0:	848a8693          	addi	a3,s5,-1976 # 100b848 <g_random>
 100b6f4:	02000613          	li	a2,32
 100b6f8:	72418593          	addi	a1,gp,1828 # 10138f24 <ciphertext.2>
 100b6fc:	86840513          	addi	a0,s0,-1944 # 100b868 <g_plaintext>
 100b700:	f30fe0ef          	jal	1009e30 <boot_sm2_encrypt>
 100b704:	ed09                	bnez	a0,100b71e <platform_init+0x4c8>
 100b706:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b70a:	cb89                	beqz	a5,100b71c <platform_init+0x4c6>
 100b70c:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b710:	010085b7          	lui	a1,0x1008
 100b714:	ad358593          	addi	a1,a1,-1325 # 1007ad3 <HAL_UART_Receive+0x4c3>
 100b718:	4505                	li	a0,1
 100b71a:	9782                	jalr	a5
 100b71c:	a001                	j	100b71c <platform_init+0x4c6>
 100b71e:	0100ba37          	lui	s4,0x100b
 100b722:	4705                	li	a4,1
 100b724:	7e8a0693          	addi	a3,s4,2024 # 100b7e8 <g_pri_key>
 100b728:	02000613          	li	a2,32
 100b72c:	70418593          	addi	a1,gp,1796 # 10138f04 <plaintext_result.1>
 100b730:	72418513          	addi	a0,gp,1828 # 10138f24 <ciphertext.2>
 100b734:	919fe0ef          	jal	100a04c <boot_sm2_decrypt>
 100b738:	c909                	beqz	a0,100b74a <platform_init+0x4f4>
 100b73a:	02000613          	li	a2,32
 100b73e:	86840593          	addi	a1,s0,-1944
 100b742:	70418513          	addi	a0,gp,1796 # 10138f04 <plaintext_result.1>
 100b746:	2665                	jal	100baee <memcmp>
 100b748:	cd09                	beqz	a0,100b762 <platform_init+0x50c>
 100b74a:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b74e:	cb89                	beqz	a5,100b760 <platform_init+0x50a>
 100b750:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b754:	010085b7          	lui	a1,0x1008
 100b758:	af958593          	addi	a1,a1,-1287 # 1007af9 <HAL_UART_Receive+0x4e9>
 100b75c:	4505                	li	a0,1
 100b75e:	9782                	jalr	a5
 100b760:	a001                	j	100b760 <platform_init+0x50a>
 100b762:	6c418693          	addi	a3,gp,1732 # 10138ec4 <sign.0>
 100b766:	848a8613          	addi	a2,s5,-1976
 100b76a:	86840593          	addi	a1,s0,-1944
 100b76e:	7e8a0513          	addi	a0,s4,2024
 100b772:	9cffe0ef          	jal	100a140 <boot_sm2_sign>
 100b776:	ed09                	bnez	a0,100b790 <platform_init+0x53a>
 100b778:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b77c:	cb89                	beqz	a5,100b78e <platform_init+0x538>
 100b77e:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b782:	010085b7          	lui	a1,0x1008
 100b786:	b1f58593          	addi	a1,a1,-1249 # 1007b1f <HAL_UART_Receive+0x50f>
 100b78a:	4505                	li	a0,1
 100b78c:	9782                	jalr	a5
 100b78e:	a001                	j	100b78e <platform_init+0x538>
 100b790:	0100c637          	lui	a2,0x100c
 100b794:	6c418713          	addi	a4,gp,1732 # 10138ec4 <sign.0>
 100b798:	86840693          	addi	a3,s0,-1944
 100b79c:	82860613          	addi	a2,a2,-2008 # 100b828 <g_pub_key+0x20>
 100b7a0:	80890593          	addi	a1,s2,-2040
 100b7a4:	4519                	li	a0,6
 100b7a6:	bb0ff0ef          	jal	100ab56 <boot_ecc_verify>
 100b7aa:	dc0510e3          	bnez	a0,100b56a <platform_init+0x314>
 100b7ae:	d141c783          	lbu	a5,-748(gp) # 10138514 <log_en>
 100b7b2:	cb89                	beqz	a5,100b7c4 <platform_init+0x56e>
 100b7b4:	d101a783          	lw	a5,-752(gp) # 10138510 <log_output_fn>
 100b7b8:	010085b7          	lui	a1,0x1008
 100b7bc:	b4258593          	addi	a1,a1,-1214 # 1007b42 <HAL_UART_Receive+0x532>
 100b7c0:	4505                	li	a0,1
 100b7c2:	9782                	jalr	a5
 100b7c4:	a001                	j	100b7c4 <platform_init+0x56e>
 100b7c6:	0000                	unimp

0100b7c8 <token_zeros.3>:
 100b7c8:	0000 0000 0000 0000 0000 0000 0000 0000     ................

0100b7d8 <token_invaild.4>:
 100b7d8:	ffff ffff ffff ffff ffff ffff ffff ffff     ................

0100b7e8 <g_pri_key>:
 100b7e8:	61a9 d29a 5dad 26fe c676 e346 1f66 8bdd     .a...].&v.F.f...
 100b7f8:	8f53 aee4 fc82 a6af ac70 03bf ae92 c14d     S.......p.....M.

0100b808 <g_pub_key>:
 100b808:	925f 4796 a147 a6c1 0c50 aea9 e4d0 c428     _..GG...P.....(.
 100b818:	b50a 7e85 c41b 72cd c24d ef73 fea3 5f45     ...~...rM.s...E_
 100b828:	0934 10ae d05e 7edf 1381 16ad 1002 0bbd     4...^..~........
 100b838:	fbd9 ac98 2254 ccdd a59a da86 0d34 25d4     ....T"......4..%

0100b848 <g_random>:
 100b848:	db0e c8f1 5b27 ebac 560c 6335 bfdc d0e1     ....'[...V5c....
 100b858:	ca99 ba62 69db 2e1c ee5c f277 5cac 9703     ..b..i..\.w..\..

0100b868 <g_plaintext>:
 100b868:	3231 3433 3635 3837 3231 3433 3635 3837     1234567812345678
 100b878:	3231 3433 3635 3837 3231 3433 3635 3837     1234567812345678

0100b888 <SM2_G>:
 100b888:	c432 2cae 191f 1981 995f 4604 396a 94c9     2..,...._..Fj9..
 100b898:	e38f bf0b 66f2 e10b 5a71 8945 4c33 c774     .....f..qZE.3Lt.
 100b8a8:	37bc a236 f6f4 9c77 bd59 e3ce 696b 5321     .76...w.Y...ki!S
 100b8b8:	a9d0 7c87 2ac6 4047 df02 e532 3921 a0f0     ...|.*G@..2.!9..

0100b8c8 <sm2_with_sm3_predata>:
 100b8c8:	3231 3433 3635 3837 3231 3433 3635 3837     1234567812345678
 100b8d8:	ffff feff ffff ffff ffff ffff ffff ffff     ................
 100b8e8:	ffff ffff 0000 0000 ffff ffff ffff fcff     ................
 100b8f8:	e928 9efa 9f9d 345e 5a4d 4b9e 65cf a709     (.....^4MZ.K.e..
 100b908:	97f3 f589 ab15 928f bcdd 41bd 944d 930e     ...........AM...
 100b918:	c432 2cae 191f 1981 995f 4604 396a 94c9     2..,...._..Fj9..
 100b928:	e38f bf0b 66f2 e10b 5a71 8945 4c33 c774     .....f..qZE.3Lt.
 100b938:	37bc a236 f6f4 9c77 bd59 e3ce 696b 5321     .76...w.Y...ki!S
 100b948:	a9d0 7c87 2ac6 4047 df02 e532 3921 a0f0     ...|.*G@..2.!9..

0100b958 <aes_result>:
 100b958:	7aaf 9a0c c7e6 4aca b9aa 5789 3217 6ae8     .z.....J...W.2.j

0100b968 <sha_result>:
 100b968:	c48c b598 13fc eb81 9067 516e c8f9 9b36     ........g.nQ..6.
 100b978:	5f2a 66c1 98a5 d7d9 0375 710c 1ad7 28c3     *_.f....u..q...(

0100b988 <sm4_result>:
 100b988:	1e68 34df 06d2 5e96 b386 4fe9 6e53 4642     h..4...^...OSnBF

0100b998 <test_key>:
 100b998:	2301 6745 ab89 efcd dcfe 98ba 5476 1032     .#Eg........vT2.
 100b9a8:	2301 6745 ab89 efcd dcfe 98ba 5476 1032     .#Eg........vT2.

0100b9b8 <__lshrdi3>:
 100b9b8:	00060c63          	beqz	a2,100b9d0 <__lshrdi3+0x18>
 100b9bc:	02000793          	li	a5,32
 100b9c0:	8f91                	sub	a5,a5,a2
 100b9c2:	00f04863          	bgtz	a5,100b9d2 <__lshrdi3+0x1a>
 100b9c6:	1601                	addi	a2,a2,-32
 100b9c8:	00c5d533          	srl	a0,a1,a2
 100b9cc:	4701                	li	a4,0
 100b9ce:	85ba                	mv	a1,a4
 100b9d0:	8082                	ret
 100b9d2:	00c5d733          	srl	a4,a1,a2
 100b9d6:	00c55533          	srl	a0,a0,a2
 100b9da:	00f595b3          	sll	a1,a1,a5
 100b9de:	8d4d                	or	a0,a0,a1
 100b9e0:	b7fd                	j	100b9ce <__lshrdi3+0x16>

0100b9e2 <__riscv_save_12>:
 100b9e2:	7139                	addi	sp,sp,-64
 100b9e4:	4301                	li	t1,0
 100b9e6:	c66e                	sw	s11,12(sp)
 100b9e8:	a019                	j	100b9ee <__riscv_save_10+0x4>

0100b9ea <__riscv_save_10>:
 100b9ea:	7139                	addi	sp,sp,-64
 100b9ec:	5341                	li	t1,-16
 100b9ee:	c86a                	sw	s10,16(sp)
 100b9f0:	ca66                	sw	s9,20(sp)
 100b9f2:	cc62                	sw	s8,24(sp)
 100b9f4:	ce5e                	sw	s7,28(sp)
 100b9f6:	a019                	j	100b9fc <__riscv_save_4+0x4>

0100b9f8 <__riscv_save_4>:
 100b9f8:	7139                	addi	sp,sp,-64
 100b9fa:	5301                	li	t1,-32
 100b9fc:	d05a                	sw	s6,32(sp)
 100b9fe:	d256                	sw	s5,36(sp)
 100ba00:	d452                	sw	s4,40(sp)
 100ba02:	d64e                	sw	s3,44(sp)
 100ba04:	d84a                	sw	s2,48(sp)
 100ba06:	da26                	sw	s1,52(sp)
 100ba08:	dc22                	sw	s0,56(sp)
 100ba0a:	de06                	sw	ra,60(sp)
 100ba0c:	40610133          	sub	sp,sp,t1
 100ba10:	8282                	jr	t0

0100ba12 <__riscv_save_0>:
 100ba12:	1141                	addi	sp,sp,-16
 100ba14:	c04a                	sw	s2,0(sp)
 100ba16:	c226                	sw	s1,4(sp)
 100ba18:	c422                	sw	s0,8(sp)
 100ba1a:	c606                	sw	ra,12(sp)
 100ba1c:	8282                	jr	t0

0100ba1e <__riscv_restore_12>:
 100ba1e:	4db2                	lw	s11,12(sp)
 100ba20:	0141                	addi	sp,sp,16

0100ba22 <__riscv_restore_10>:
 100ba22:	4d02                	lw	s10,0(sp)
 100ba24:	4c92                	lw	s9,4(sp)
 100ba26:	4c22                	lw	s8,8(sp)
 100ba28:	4bb2                	lw	s7,12(sp)
 100ba2a:	0141                	addi	sp,sp,16

0100ba2c <__riscv_restore_4>:
 100ba2c:	4b02                	lw	s6,0(sp)
 100ba2e:	4a92                	lw	s5,4(sp)
 100ba30:	4a22                	lw	s4,8(sp)
 100ba32:	49b2                	lw	s3,12(sp)
 100ba34:	0141                	addi	sp,sp,16

0100ba36 <__riscv_restore_0>:
 100ba36:	4902                	lw	s2,0(sp)
 100ba38:	4492                	lw	s1,4(sp)
 100ba3a:	4422                	lw	s0,8(sp)
 100ba3c:	40b2                	lw	ra,12(sp)
 100ba3e:	0141                	addi	sp,sp,16
 100ba40:	8082                	ret

0100ba42 <__thead_uread4>:
 100ba42:	00154703          	lbu	a4,1(a0)
 100ba46:	00054783          	lbu	a5,0(a0)
 100ba4a:	0722                	slli	a4,a4,0x8
 100ba4c:	8f5d                	or	a4,a4,a5
 100ba4e:	00254783          	lbu	a5,2(a0)
 100ba52:	00354503          	lbu	a0,3(a0)
 100ba56:	07c2                	slli	a5,a5,0x10
 100ba58:	8fd9                	or	a5,a5,a4
 100ba5a:	0562                	slli	a0,a0,0x18
 100ba5c:	8d5d                	or	a0,a0,a5
 100ba5e:	8082                	ret

0100ba60 <__thead_uwrite4>:
 100ba60:	00855793          	srli	a5,a0,0x8
 100ba64:	00a58023          	sb	a0,0(a1)
 100ba68:	00f580a3          	sb	a5,1(a1)
 100ba6c:	01055793          	srli	a5,a0,0x10
 100ba70:	8161                	srli	a0,a0,0x18
 100ba72:	00f58123          	sb	a5,2(a1)
 100ba76:	00a581a3          	sb	a0,3(a1)
 100ba7a:	8082                	ret

0100ba7c <__thead_uread8>:
 100ba7c:	00154783          	lbu	a5,1(a0)
 100ba80:	00054703          	lbu	a4,0(a0)
 100ba84:	00554683          	lbu	a3,5(a0)
 100ba88:	07a2                	slli	a5,a5,0x8
 100ba8a:	8fd9                	or	a5,a5,a4
 100ba8c:	00254703          	lbu	a4,2(a0)
 100ba90:	06a2                	slli	a3,a3,0x8
 100ba92:	00354603          	lbu	a2,3(a0)
 100ba96:	0742                	slli	a4,a4,0x10
 100ba98:	8f5d                	or	a4,a4,a5
 100ba9a:	00454783          	lbu	a5,4(a0)
 100ba9e:	00754583          	lbu	a1,7(a0)
 100baa2:	0662                	slli	a2,a2,0x18
 100baa4:	8edd                	or	a3,a3,a5
 100baa6:	00654783          	lbu	a5,6(a0)
 100baaa:	05e2                	slli	a1,a1,0x18
 100baac:	00e66533          	or	a0,a2,a4
 100bab0:	07c2                	slli	a5,a5,0x10
 100bab2:	8fd5                	or	a5,a5,a3
 100bab4:	8ddd                	or	a1,a1,a5
 100bab6:	8082                	ret

0100bab8 <__thead_uwrite8>:
 100bab8:	00855793          	srli	a5,a0,0x8
 100babc:	00f600a3          	sb	a5,1(a2)
 100bac0:	01055793          	srli	a5,a0,0x10
 100bac4:	00f60123          	sb	a5,2(a2)
 100bac8:	0085d793          	srli	a5,a1,0x8
 100bacc:	00a60023          	sb	a0,0(a2)
 100bad0:	00b60223          	sb	a1,4(a2)
 100bad4:	8161                	srli	a0,a0,0x18
 100bad6:	00f602a3          	sb	a5,5(a2)
 100bada:	0105d793          	srli	a5,a1,0x10
 100bade:	81e1                	srli	a1,a1,0x18
 100bae0:	00a601a3          	sb	a0,3(a2)
 100bae4:	00f60323          	sb	a5,6(a2)
 100bae8:	00b603a3          	sb	a1,7(a2)
 100baec:	8082                	ret

0100baee <memcmp>:
 100baee:	4701                	li	a4,0
 100baf0:	00e61463          	bne	a2,a4,100baf8 <memcmp+0xa>
 100baf4:	4501                	li	a0,0
 100baf6:	8082                	ret
 100baf8:	00e507b3          	add	a5,a0,a4
 100bafc:	0705                	addi	a4,a4,1 # f0001 <Reset_Handler-0xf0ffff>
 100bafe:	00e586b3          	add	a3,a1,a4
 100bb02:	0007c783          	lbu	a5,0(a5)
 100bb06:	fff6c683          	lbu	a3,-1(a3) # 7fffffff <bitmap+0x6fec007f>
 100bb0a:	fed783e3          	beq	a5,a3,100baf0 <memcmp+0x2>
 100bb0e:	40d78533          	sub	a0,a5,a3
 100bb12:	8082                	ret

0100bb14 <memcpy>:
 100bb14:	832a                	mv	t1,a0
 100bb16:	ca09                	beqz	a2,100bb28 <memcpy+0x14>
 100bb18:	00058383          	lb	t2,0(a1)
 100bb1c:	00730023          	sb	t2,0(t1)
 100bb20:	167d                	addi	a2,a2,-1
 100bb22:	0305                	addi	t1,t1,1
 100bb24:	0585                	addi	a1,a1,1
 100bb26:	fa6d                	bnez	a2,100bb18 <memcpy+0x4>
 100bb28:	8082                	ret
 100bb2a:	0000                	unimp

0100bb2c <memset>:
 100bb2c:	832a                	mv	t1,a0
 100bb2e:	c611                	beqz	a2,100bb3a <memset+0xe>
 100bb30:	00b30023          	sb	a1,0(t1)
 100bb34:	167d                	addi	a2,a2,-1
 100bb36:	0305                	addi	t1,t1,1
 100bb38:	fe65                	bnez	a2,100bb30 <memset+0x4>
 100bb3a:	8082                	ret
 100bb3c:	0000                	unimp
 100bb3e:	0000                	unimp

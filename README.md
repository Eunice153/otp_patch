# otp_patch prj

1.git clone project with name otp_patch
cd ls_sdk
git clone http://github.com/Eunice/otp_patch.git otp_patch

2.build
# otp_sample
otp_patch/otp_main_only$ scons ic=qsh
# load otp bin
otp_patch/otp_4k_bin_load$ scons ic=qsh
# otp driver
# 生成 otp_patch.elf文件
otp_patch/otp_patch_driver$ riscv64-unknown-elf-gcc -o otp_patch.elf  -std=c11 -mabi=ilp32f -march=rv32imafc_zifencei_xtheade -mshorten-memrefs -mstrict-align -msave-restore -malign-data=natural -g -ffunction-sections -fdata-sections -fstrict-volatile-bitfields -fno-common -Wall -Os -nostdlib -T otp_patch.ld -T rom_sym.ld -DQSH -DGLOBAL_OUTPUT_LVL=0 -DNDEBUG -I. -I/home/eunice/zephyr_workspace/ls_sdk/bootloader/boot_ram/qsh -I/home/eunice/zephyr_workspace/ls_sdk/hal_driver/inc -I/home/eunice/zephyr_workspace/ls_sdk/hal_driver/api -I/home/eunice/zephyr_workspace/ls_sdk/hal_driver/api/otbn -I/home/eunice/zephyr_workspace/ls_sdk/module/common -I/home/eunice/zephyr_workspace/ls_sdk/module/crc -I/home/eunice/zephyr_workspace/ls_sdk/module/debug -I/home/eunice/zephyr_workspace/ls_sdk/module/debug/mini-printf -I/home/eunice/zephyr_workspace/ls_sdk/module/debug/RTT -I/home/eunice/zephyr_workspace/ls_sdk/module/debug/semihosting/riscv -I/home/eunice/zephyr_workspace/ls_sdk/module/static_buffer -I/home/eunice/zephyr_workspace/ls_sdk/module/micro-ecc -I/home/eunice/zephyr_workspace/ls_sdk/soc -I/home/eunice/zephyr_workspace/ls_sdk/soc/rv32 -I/home/eunice/zephyr_workspace/ls_sdk/soc/rv32/qsh -I/home/eunice/zephyr_workspace/ls_sdk/soc/rv32/qsh/include otp_patch.c
# 生成otp_patch.asm
otp_patch/otp_patch_driver$ riscv64-unknown-elf-objdump -d -x -z otp_patch.elf >otp_patch.asm
# 生成 otp_patch.bin
otp_patch/otp_patch_driver$ riscv64-unknown-elf-objcopy -O binary otp_patch.elf otp_patch.bin

# otp_patch_4Kbin_direct.py   功能：生成一个完整的otp bin文件
otp_patch/tools$ python3 otp_patch_4Kbin_direct.py ../otp_patch_driver/otp_patch.bin
生成文件名称：（1）otp_patch_4K_direct.bin （2）otp_patch_array.txt

3.usage
(1)先执行load otp bin 将生成的otp_patch_4K_direct.bin 下载到otp
(2) otp_sample 的内容运行在flash
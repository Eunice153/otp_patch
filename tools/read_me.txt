1.otp_patch_4Kbin_direct.py   功能：生成一个bin文件包含crc之类的值
使用方法：
0x88位置处：#ffffffdf只把flash_dis配置1,0xFFFFDFDF是把自测打开，flash_dis为0;0xFFFFFF9F把log关闭
路径：ls_sdk/examples/peripheral/otp_patch/tools$
运行命令：python3 otp_patch_4Kbin_direct.py ../otp_patch_driver/otp_patch.bin
生成文件名称：（1）otp_patch_4K_direct.bin （2）otp_patch_array.txt

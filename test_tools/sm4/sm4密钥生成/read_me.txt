> 对应 0x20 脚本已删除；本文件仅保留历史说明，不再作为可执行命令。

SM4 密钥生成/导出测试 read_me
/*
脚本的测试流程：比如生成一个sm4的密钥（SM4没有公私钥对），将生成的密钥1存到tmp槽5；
上位机自己有一对SM2测试密钥：私钥2（TEST_D）和公钥2；
将公钥2通过LOAD_PUBKEY导入设备，设备用公钥2把tmp槽5的密钥1做SM2包裹导出；
上位机用私钥2解开包裹，得到密钥1；
再用密钥1做Python SM4参考加解密，和设备槽5的SM4加解密结果比较；
结果一致，说明导出的密钥1和设备槽5里的密钥是同一把。
*/

一、用途
调用设备 GENKEY(5) 生成临时 SM4 密钥，再用 LOAD_PUBKEY + EXPORT_KEY
把 16B 密钥用 TEST_D 公钥包裹导出；上位机用 TEST_D 解出密钥，
并做 ECB 加密/解密自检。

只使用临时槽 5（RAM），不写 OTP。

二、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。

三、运行命令

进入本目录：
    cd otp_patch/test_tools/sm4/sm4密钥生成
    python3 sm4_key.py COM24

从 test_tools 根目录：
    python3 sm4/sm4密钥生成/sm4_key.py COM24

常用参数：
    --baud 921600     改波特率
    --out ./xxx.md    改报告路径

四、实际发送的命令
    GENKEY(5)
    LOAD_PUBKEY(TEST_D 公钥)
    EXPORT_KEY(5, 1)        （固件旧名 SM4_EXPORT；通用导出）
    SM4_CRYPT ECB 加密/解密自检

不会发送 SET_PASSWORD(0x05)、KEY_STORE(0x16)、KEY_DESTROY(0x18)。

五、报告
默认：
    ../sm4_report/sm4_key_report.md

内容：
    GENKEY / LOAD_PUBKEY / EXPORT_KEY 状态、
    恢复出的 16B 密钥 K、ECB 加密自检、ECB 解密自检。

六、预期结果
    结论：全部符合预期
    GENKEY、LOAD_PUBKEY、EXPORT_KEY、ECB 加解密自检均为 OK。

七、常见问题
- 打开 COM 失败：端口被占用。
- EXPORT_KEY 失败：检查 LOAD_PUBKEY 是否 64B、std 是否 1。
- 解包失败：检查 TEST_D 公钥/私钥是否配对。
- ECB 自检失败：检查密钥是否 16B、设备固件 SM4 路径是否正常。
- 复位后临时密钥丢失，重新运行脚本即可。

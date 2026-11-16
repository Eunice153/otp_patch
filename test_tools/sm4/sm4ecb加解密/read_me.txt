SM4 ECB 加解密测试 read_me
/*
脚本的测试流程：先生成临时槽5的SM4密钥K，用LOAD_PUBKEY+EXPORT_KEY把K导出，
上位机用TEST_D解出K。
ECB：对每组明文，设备ECB加密的结果和Python SM4用K算出的密文比较；
再让设备ECB解密，比较解密出的明文和原始明文。
CBC：固定IV，设备CBC加密的结果和Python SM4用K、IV算出的密文比较；
再让设备CBC解密，比较解密出的明文和原始明文。
*/
一、用途
使用临时槽 5 测试 SM4 ECB：
1. 设备 ECB 加密，和 Python 参考实现比对。
2. 设备 ECB 解密，和原文比对。

只使用临时槽 5（RAM），不写 OTP。

二、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。
4. 单帧 DATA 上限 512B，ECB 参数占 3B，测试长度最大 480B。

三、运行命令

进入本目录：
    cd otp_patch/test_tools/sm4/sm4ecb加解密
    python3 sm4_ecb.py COM24

从 test_tools 根目录：
    python3 sm4/sm4ecb加解密/sm4_ecb.py COM24

常用参数：
    --lengths 16,32,64,256,480   默认这 5 组
    --baud 921600                改波特率
    --out ./xxx.md               改报告路径

四、实际发送的命令
    GENKEY(5)
    LOAD_PUBKEY(TEST_D 公钥)
    EXPORT_KEY(5, 1)        （固件旧名 SM4_EXPORT）
    SM4_CRYPT(id=5, mode=0(ECB), op=0/1, data)

不会发送 SET_PASSWORD(0x05)、KEY_STORE(0x16)、KEY_DESTROY(0x18)。

五、报告
默认：
    ../sm4_report/sm4_ecb_report.md

内容：
    (1) 加密(ECB)：明文/设备密文/参考密文/结论
    (2) 解密(ECB)：密文/设备明文/预期明文/结论

六、预期结果
    结论：全部符合预期
    5 组 ECB 加密、解密均与参考实现一致。

七、常见问题
- 打开 COM 失败：端口被占用。
- SM4_CRYPT 返回 FE：检查长度是否 16 的倍数。
- 密文不一致：检查恢复出的密钥是否与设备槽 5 一致。
- 复位后临时密钥丢失，重新运行脚本即可。

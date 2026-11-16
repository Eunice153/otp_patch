SM4 CBC 加解密（0x40）read_me
/*
脚本的测试流程：先生成临时槽5的SM4密钥K，用LOAD_PUBKEY+EXPORT_KEY把K导出，
上位机用TEST_D解出K。
ECB：对每组明文，设备ECB加密的结果和Python SM4用K算出的密文比较；
再让设备ECB解密，比较解密出的明文和原始明文。
CBC：固定IV，设备CBC加密的结果和Python SM4用K、IV算出的密文比较；
再让设备CBC解密，比较解密出的明文和原始明文。
*/
一、用途

    GENKEY(5) + 导出/恢复 16B 密钥
    固定 IV：
      0x40 CBC 加密 -> 设备密文 vs Python 参考
      0x40 CBC 解密 -> 设备明文 vs 原文

使用 NO3 的 0x40 SM4_BULK。

二、前提
- 固件必须是 NO3；NO2 没有 0x40。
- 只使用 RAM 临时槽 5，不写 OTP。
- 0x40 的 data 必须是 16 的倍数，最大 131072B。
- CBC IV 是 16B，由上位机传入。

三、运行
进入本目录：
    cd otp_patch/test_tools/sm4/sm4cbc加解密
    python3 sm4_cbc_40.py COM24

从 test_tools 根目录：
    python3 sm4/sm4cbc加解密/sm4_cbc_40.py COM24

常用参数：
    --lengths 16,32,64,256,480   默认 5 组，最大 131072
    --iv 32位hex                默认 00 01 ... 0F
    --writes N                  请求拆 N 次串口 write
    --reads N                   应答 DATA 拆 N 次 read
    --timeout 120
    --baud 115200
    --out ./xxx.md

128KB CBC：
    python3 sm4_cbc_40.py COM24 --lengths 131072

四、实际发送
    GENKEY(5)
    LOAD_PUBKEY(TEST_D)
    EXPORT_KEY(5,1)
    0x40 SM4_BULK CBC 加密
    0x40 SM4_BULK CBC 解密

不会发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY。

五、报告
默认：
    ../sm4_report/sm4_cbc_40_report.md

内容：
    - 恢复出的密钥 K
    - CBC IV
    - 每个长度的 0x40 加密/解密结果
    - 与 Python 参考实现比对
    - 128KB 等大数据只记录 SHA256 和长度

六、预期
    结论：全部符合预期

七、常见问题
- 0x40 无应答：确认烧的是 NO3；0x40 是 4 字节 LEN。
- 返回 0xFE：CBC 缺 16B IV，或 data 不是 16 的倍数。
- 返回 0xF8：临时槽 5 为空。
- 密文不一致：检查密钥、IV、长度、mode/op。

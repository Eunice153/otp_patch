SM4 ECB 加解密（0x40）read_me
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
    每组长度：
      0x40 ECB 加密 -> 设备密文 vs Python 参考
      0x40 ECB 解密 -> 设备明文 vs 原文

使用 NO3 的 0x40 SM4_BULK。

二、前提
- 固件必须是 NO3；NO2 没有 0x40。
- 只使用 RAM 临时槽 5，不写 OTP。
- 0x40 的 data 必须是 16 的倍数，最大 131072B。

三、运行
进入本目录：
    cd otp_patch/test_tools/sm4/sm4ecb加解密
    python3 sm4_ecb_40.py COM24

从 test_tools 根目录：
    python3 sm4/sm4ecb加解密/sm4_ecb_40.py COM24

常用参数：
    --lengths 16,32,64,256,480   默认这 5 组，最大 131072
    --writes N                   请求拆 N 次串口 write，默认 1
    --reads N                    应答 DATA 拆 N 次 read，默认 1
    --timeout 120
    --baud 115200
    --out ./xxx.md

128KB ECB：
    python3 sm4_ecb_40.py COM24 --lengths 131072

四、实际发送
    GENKEY(5)
    LOAD_PUBKEY(TEST_D)
    EXPORT_KEY(5,1)
    0x40 SM4_BULK ECB 加密
    0x40 SM4_BULK ECB 解密

不会发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY。

五、报告
默认：
    ../sm4_report/sm4_ecb_40_report.md

内容：
    - 恢复出的密钥 K
    - 每个长度的 0x40 加密/解密结果
    - 与 Python 参考实现比对
    - 128KB 等大数据只记录 SHA256 和长度，不整段写报告

六、预期
    结论：全部符合预期

七、常见问题
- 0x40 无应答：确认烧的是 NO3，不是 NO2；0x40 是 4 字节 LEN。
- 返回 0xF8：临时槽 5 为空，先用 GENKEY(5)。
- 超时：128KB 单程约 11.4s，加大 --timeout。
- 密文不一致：检查密钥、长度、mode/op。

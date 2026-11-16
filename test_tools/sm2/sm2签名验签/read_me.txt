SM2 签名验签测试 read_me
/*
脚本的测试流程：比如生成一个sm2签名的密钥对，将生成的私钥1存到tmp数组，公钥1导出来了；
准备一个32字节的摘要，用私钥1做sm2签名；再用导出的公钥1验签，看验签结果是不是1；
把签名改一个字节再验签，结果应该是0。
上位机也可以用导出的私钥1签名，设备用公钥1验签。
*/

一、用途
使用临时槽 4 测试 SM2 签名/验签：
1. 设备 SM2_SIGN 对 5 组 SM3 摘要签名，上位机用公钥验签。
2. 设备 SM2_VERIFY 验证自己的签名。
3. 篡改签名后设备验签，结果应为 0。
4. 上位机用导出的私钥签名，设备 SM2_VERIFY 验签。

只使用临时槽 4（RAM），不写 OTP。

二、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。

三、运行命令

进入本目录：
    cd otp_patch/test_tools/sm2/sm2签名验签
    python3 sm2_sign_verify.py COM24

从 test_tools 根目录：
    python3 sm2/sm2签名验签/sm2_sign_verify.py COM24

常用参数：
    --baud 921600     改波特率
    --out ./xxx.md    改报告路径

四、实际发送的命令
    GENKEY(4)
    GETPUBKEY(4)
    LOAD_PUBKEY(TEST_D 公钥)
    EXPORT_KEY(4, 1)        （固件旧名 SM4_EXPORT）
    SM2_SIGN(4, digest, k)
    SM2_VERIFY(pub, digest, sig)
    SM2_VERIFY(pub, digest, 篡改后的 sig)
    SM2_VERIFY(pub, digest, 上位机签名)

不会发送 SET_PASSWORD(0x05)、KEY_STORE(0x16)、KEY_DESTROY(0x18)。

五、报告
默认：
    ../sm2_report/sm2_sign_verify_report.md

内容：
    表 1：消息 / SM3 摘要 / 设备 k / 设备签名 /
          主机验签 / 设备验签 / 篡改验签 / 结果
    表 2：消息 / 上位机 k / 上位机签名 / 设备验签

六、预期结果
    结论：全部符合预期
    5 组消息：
      设备签名→主机验签 OK
      设备验签 OK
      篡改验签结果 0
      主机签名→设备验签 OK

七、常见问题
- 打开 COM 失败：端口被占用。
- SM2_SIGN 返回 FE：检查槽位是否 4、payload 是否
  [id] + digest(32) + k(32)。
- 设备验签返回 0：检查签名/摘要/公钥是否对应。
- 篡改验签返回 1：签名篡改方式或设备验签可能有问题。
- 复位后临时密钥丢失，重新运行脚本即可。

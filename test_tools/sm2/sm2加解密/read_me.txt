SM2 加解密测试 read_me
/*
脚本的测试流程：比如生成一个sm2的解密的密钥对，将生成的私钥1存到tmp数组，公钥1导出来了；
将导出的公钥1进行sm2加密。最后使用sm2解密看，比较解密出的明文和原始明文是不是一致的
*/
一、用途
使用临时槽 3 做 SM2 加解密：
1. GENKEY(3) 生成密钥对，GETPUBKEY(3) 读出设备公钥 pub。
2. SM2_ENC 用 pub 加密。
3. 设备 SM2_DEC 用槽 3 私钥解密。
4. 可选：LOAD_PUBKEY(TEST_D) + EXPORT_KEY(3,1) 把设备私钥包裹导出，
   上位机用 TEST_D 解开后独立解密，做交叉校验。

注意：SM2_ENC 用的公钥是 GETPUBKEY(3) 读出的 pub；
LOAD_PUBKEY/EXPORT_KEY 不参与 SM2_ENC，只用于主机侧校验。

只使用临时槽 3（RAM），不写 OTP。

二、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。
4. SM2 解密明文最大 64B（ROM boot_sm2_decrypt 栈帧限制）。

三、运行命令

进入本目录：
    cd otp_patch/test_tools/sm2/sm2加解密
    python3 sm2_crypt.py COM24

从 test_tools 根目录：
    python3 sm2/sm2加解密/sm2_crypt.py COM24

常用参数：
    --lengths 16,24,32,48,64   明文长度列表，默认 16/24/32/48/64
    --baud 921600              改波特率
    --out ./xxx.md             改报告路径

示例：
    python3 sm2_crypt.py COM24 --lengths 16,32,64

四、实际发送的命令

加密/解密主流程：
    GENKEY(3)
    GETPUBKEY(3)              -> pub（SM2_ENC 用这个公钥）
    SM2_ENC(std=1, pub, k, pt)
    SM2_DEC(3, std=1, pt_len, ct)

可选的主机侧校验（不参与 SM2_ENC）：
    LOAD_PUBKEY(TEST_D 公钥)
    EXPORT_KEY(3, 1)          -> 设备私钥包裹
    上位机用 TEST_D 解出私钥 d，再 sm2_decrypt(ct, d) 独立校验

不会发送 SET_PASSWORD(0x05)、KEY_STORE(0x16)、KEY_DESTROY(0x18)。

五、报告
默认：
    ../sm2_report/sm2_crypt_report.md

内容：
    每组长度、设备 k、设备密文、设备加密→上位机解密、
    设备解密(设备密文)、上位机 k、上位机密文、
    设备解密(上位机密文)、结果

六、预期结果
    结论：全部符合预期
    5 组长度三项校验均为 OK。

七、常见问题
- 打开 COM 失败：端口被占用。
- SM2_DEC 返回 FE：检查 pt_len 是否 1..64、密文长度是否
  96+pt_len、槽位是否 3。
- 设备加密→上位机解密失败：检查导出私钥是否匹配、密文布局
  是否 C1(64)||C3(32)||C2。
- 复位后临时密钥丢失，重新运行脚本即可。

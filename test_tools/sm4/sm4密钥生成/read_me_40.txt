SM4 密钥生成（0x40 自检）read_me
/*
脚本的测试流程：比如生成一个sm4的密钥（SM4没有公私钥对），将生成的密钥1存到tmp槽5；
上位机自己有一对SM2测试密钥：私钥2（TEST_D）和公钥2；
将公钥2通过LOAD_PUBKEY导入设备，设备用公钥2把tmp槽5的密钥1做SM2包裹导出；
上位机用私钥2解开包裹，得到密钥1；
再用密钥1做Python SM4参考加解密，和设备槽5的SM4加解密结果比较；
结果一致，说明导出的密钥1和设备槽5里的密钥是同一把。
*/
一、用途
和原 sm4_key.py 功能一样：
    GENKEY(5)
    LOAD_PUBKEY(TEST_D 公钥)
    EXPORT_KEY(5,1)
    上位机用 TEST_D 解出 16B SM4 密钥
    用该密钥做 ECB 加密/解密自检

区别：自检走 NO3 的 0x40 SM4_BULK，不是 0x20。
原 sm4_key.py 保留不变。

二、前提
- 固件必须是 NO3；NO2 没有 0x40。
- 只使用 RAM 临时槽 5，不写 OTP。
- 不发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY。

三、运行
进入本目录：
    cd otp_patch/test_tools/sm4/sm4密钥生成
    python3 sm4_key_40.py COM24

从 test_tools 根目录：
    python3 sm4/sm4密钥生成/sm4_key_40.py COM24

常用参数：
    --baud 115200
    --timeout 30
    --out ./xxx.md

四、实际发送
    GENKEY(5)                  普通 0x11 命令
    LOAD_PUBKEY(TEST_D)        普通 0x15
    EXPORT_KEY(5,1)            普通 0x13
    0x40 SM4_BULK ECB 加密
    0x40 SM4_BULK ECB 解密

五、报告
默认：
    ../sm4_report/sm4_key_40_report.md

内容：
    GENKEY / LOAD_PUBKEY / EXPORT_KEY 状态、
    恢复出的 16B 密钥 K、
    0x40 ECB 加密/解密自检。

六、预期
    结论：全部符合预期

七、常见问题
- 0x40 无应答：确认烧的是 NO3，不是 NO2。
- EXPORT_KEY 失败：检查 LOAD_PUBKEY 是否 64B、std 是否 1。
- 解包失败：检查 TEST_D 公钥/私钥是否配对。
- 0x40 自检失败：检查临时槽 5 是否 GENKEY 成功。
- 复位后临时密钥丢失，重新运行脚本即可。

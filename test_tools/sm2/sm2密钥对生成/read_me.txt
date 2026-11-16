SM2 密钥对生成测试 read_me
/*
脚本的测试流程：比如生成一个sm2的解密的密钥对，将生成的私钥1存到tmp数组，公钥1导出来了；
上位机自己有一个密钥2，他可以算自己的公钥2；将公钥2导入，可以把tmp数组的私钥1带出来。
比较私钥1和公钥1是不是一对。
*/

一、用途
调用设备 GENKEY(3/4) 生成临时 SM2 密钥对，GETPUBKEY 读公钥；
再用 LOAD_PUBKEY + EXPORT_KEY 导出私钥包裹，上位机用 TEST_D 解出
私钥 d，并由 d 计算公钥与设备公钥比对。

说明：EXPORT_KEY 就是固件命令 0x13（历史名字 CMD_SM4_EXPORT），
它是通用密钥导出命令；SM2 槽返回 128B，跟 SM4 加密无关。

只使用临时槽 3/4（RAM），不写 OTP。

二、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下可直接用 python3；检测到 COMx 会自动转 Windows Python。
3. 需要 pyserial。

三、运行命令

进入本目录：
    cd otp_patch/test_tools/sm2/sm2密钥对生成
    python3 sm2_keypair.py COM24

在 test_tools 根目录（就是 eunice@Eunice:~/zephyr_workspace/ls_sdk/otp_patch/test_tools$）：
    python3 "sm2/sm2密钥对生成/sm2_keypair.py" COM24

常用参数：
    --slots 3,4       只测指定临时槽，默认 3,4
    --show-private    控制台和报告显示临时私钥 d
    --baud 921600     改波特率，默认 115200
    --out ./xxx.md    改报告路径

示例：
    python3 sm2_keypair.py COM24 --slots 3
    python3 sm2_keypair.py COM24 --show-private

四、实际发送的命令
    GENKEY(3) / GENKEY(4)
    GETPUBKEY(3) / GETPUBKEY(4)
    LOAD_PUBKEY(TEST_D 公钥)
    EXPORT_KEY(3, 1) / EXPORT_KEY(4, 1)   （固件旧名 SM4_EXPORT）

不会发送 SET_PASSWORD(0x05)、KEY_STORE(0x16)、KEY_DESTROY(0x18)。

五、报告
默认：
    ../sm2_report/sm2_keypair_report.md

内容：
    槽位 / GENKEY / 公钥 X / 公钥 Y / LOAD_PUBKEY /
    私钥导出 / 公私钥匹配 / 结果

默认不显示私钥；加 --show-private 才显示临时私钥 d。

六、预期结果
    结论：全部符合预期
    槽 3/4：GENKEY、GETPUBKEY、LOAD_PUBKEY、私钥导出、
    公私钥匹配均为 OK。

七、常见问题
- 打不开 COM24：端口被占用或端口号不对。
- GENKEY 失败：槽位必须是 3/4（本脚本只允许临时 SM2 槽）。
- 私钥导出失败：检查 LOAD_PUBKEY 是否是 64B、EXPORT 是否 std=1。
- 复位后临时密钥丢失，重新运行脚本即可。

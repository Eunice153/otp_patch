SM3 单帧测试 read_me

一、用途
使用 0x10 单帧命令做 SM3 正确性测试：
- 空数据
- 1 字节
- 3 字节 abc
- 64 字节
- 512 字节

上位机用 Python hashlib(SM3) 计算参考摘要，和设备返回的 32B 摘要比较。

SM3 不使用密钥，不涉及 OTP。

二、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。
4. 0x10 单帧 DATA 最大 512B；更大的数据用同目录的
   sm3_oneshot_41.py（NO3 0x41，最大 128KB）。

三、运行命令

进入本目录：
    cd otp_patch/test_tools/sm3/sm3单帧
    python3 sm3_oneshot.py COM24

从 test_tools 根目录：
    python3 sm3/sm3单帧/sm3_oneshot.py COM24

常用参数：
    --data <hex>      自定义数据，可重复；提供后只测自定义数据
    --baud 921600     改波特率
    --out ./xxx.md    改报告路径

示例：
    python3 sm3_oneshot.py COM24 --data "616263"
    python3 sm3_oneshot.py COM24 --data "616263" --data "00112233"

四、实际发送的命令
    0x10 + DATA[LEN]    (LEN <= 512)
    应答：32B 摘要

不发送 OTP 命令。

五、报告
默认：
    ../sm3_report/sm3_oneshot_report.md

内容：
    组 / 名称 / 长度 / 输入 / 设备摘要 / 参考摘要 / 状态 / 结论

六、预期结果
    结论：全部符合预期
    5 组单帧摘要均与 Python SM3 参考一致。

七、常见问题
- 打开 COM 失败：端口被占用。
- 0x10 返回 FE：检查数据长度是否 <=512。
- 摘要不一致：确认设备运行的是修复后的固件，0x10 路径应正确。
- 超过 512B 的数据请改用 sm3_oneshot_41.py（0x41，NO3）。

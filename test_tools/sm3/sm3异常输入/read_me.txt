SM3 非正常输入测试 read_me

一、用途
发送异常/边界 SM3 命令，记录完整发送帧、完整返回帧、
设备响应、预期和结论。

覆盖：
- 基线 0x10 "abc"
- 0x10 空数据
- 0x10 512B（普通帧上限）
- 内容 64B 全 0x00
- 内容 64B 全 0xFF
- 内容 64B 全 0x5A（帧头字节）
- 内容 64B 00/FF 交替
- 0x10 LEN=513（帧层超过 512，固件丢弃，不应答）

SM3 算法本身没有非法内容；全 00/FF/5A 都是合法输入，
应返回 STATUS=0x00 + 正确摘要。

SM3 不使用密钥，不涉及 OTP。
流式 0x1A/0x1B/0x1C 已删除。
NO3 的 0x41 版本见同目录 sm3_abnormal_41.py。

二、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。
4. 单帧 DATA 最大 512B。

三、运行命令

进入本目录：
    cd otp_patch/test_tools/sm3/sm3异常输入
    python3 sm3_abnormal.py COM24

从 test_tools 根目录：
    python3 sm3/sm3异常输入/sm3_abnormal.py COM24

常用参数：
    --baud 921600     改波特率
    --out ./xxx.md    改报告路径

四、实际发送的命令
    0x10 单帧
    0x10 LEN=513 的超长帧（帧层丢弃）

不发送 OTP 命令。

五、报告
默认：
    ../sm3_report/sm3_abnormal_report.md

列：
    序号 / 非正常输入 / 完整发送数据 / 完整返回数据 /
    设备响应 / 预期 / 结论

六、预期结果
    结论：状态码和摘要全部符合预期
    - 0x10 abc/空数据/512B 返回 00 + 正确摘要
    - 0x10 LEN=513 帧层丢弃，无应答

七、常见问题
- 打开 COM 失败：端口被占用。
- 0x10 513B 用例 timeout 是预期结果，表示帧层丢弃。
- 摘要不符：检查数据长度是否和 LEN 一致。

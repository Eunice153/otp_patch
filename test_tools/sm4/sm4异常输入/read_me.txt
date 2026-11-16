SM4 非正常输入测试 read_me

一、用途
向设备发送非法/异常的 SM4 命令，记录完整发送帧、完整返回帧、
设备响应、预期和结论。

覆盖：
- 数据长度 0 / 非 16 字节倍数
- 非法 id / mode / op
- CBC 缺 IV / IV 后数据不是 16 的倍数

不包含 OTP 槽、未知命令和帧层异常用例。
只使用临时槽 5（RAM），不写 OTP。

二、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。

三、运行命令

进入本目录：
    cd otp_patch/test_tools/sm4/sm4异常输入
    python3 sm4_abnormal.py COM24

从 test_tools 根目录：
    python3 sm4/sm4异常输入/sm4_abnormal.py COM24

常用参数：
    --baud 921600     改波特率
    --out ./xxx.md    改报告路径

四、实际发送的命令
    GENKEY(5)
    SM4_CRYPT 的 9 条负向用例

不会发送 SET_PASSWORD(0x05)、KEY_STORE(0x16)、KEY_DESTROY(0x18)。

五、报告
默认：
    ../sm4_report/sm4_abnormal_report.md

列：
    序号 / 非正常输入 / 完整发送数据 / 完整返回数据 /
    设备响应 / 预期 / 结论

六、预期结果
    结论：全部符合预期
    非法参数/长度返回 0xFE；基线 ECB 16B 返回 0x00 + 16B 密文。

七、常见问题
- 打开 COM 失败：端口被占用。
- 基线返回 FE：检查临时槽 5 是否 GENKEY 成功。
- 某条负向用例无应答：检查帧 LEN 是否与实际数据一致。

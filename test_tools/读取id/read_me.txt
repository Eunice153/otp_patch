读取芯片 ID read_me

一、用途
发送 GET_UID(0x60) 读取芯片 ID：
- type 0: OTP 0x170 起始 8 字节唯一标识（UID）
- type 1: OTP 0x00 起始 8 字节生产信息（LotID + waferid）

只读 OTP，不写 OTP。

二、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。

三、运行命令

进入本目录：
    cd otp_patch/test_tools/读取id
    python3 get_uid.py COM24

从 test_tools 根目录：
    python3 读取id/get_uid.py COM24

常用参数：
    --type all     同时读 type 0 和 type 1（默认）
    --type 0       只读唯一标识 UID
    --type 1       只读生产信息
    --timeout 2    单次读取超时，默认 2s
    --baud 921600
    --out ./xxx.md

读取失败（timeout/STATUS 非 0）时，脚本会立即停止并关闭串口，
不再尝试后续 type。

四、实际发送的命令
    GET_UID 0x60 + [type]
    应答：5A 60 00 00 08 + 8B ID

五、报告
默认：
    ./get_uid_report.md

内容：
    type、说明、完整发送/返回数据、8B ID、STATUS、结论。

六、预期结果
    STATUS=0x00
    DATA 长度 8B
    结论：全部符合预期

注意：
- type 0 返回 `FF FF FF FF FF FF FF FF` 表示 OTP 0x170 区域
  未写/未配置；读取命令本身是成功的，不是 timeout。
- type 1 返回的是 OTP 0x00 生产信息。

七、常见问题
- 打开 COM 失败：端口被占用。
- type 0/1 返回 FE：检查 type 是否 0/1。
- 返回 0xFF 5A：读取失败或 OTP 未配置。
- 本命令只读，不会写 OTP。

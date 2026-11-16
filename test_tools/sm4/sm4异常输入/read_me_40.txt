SM4 非正常输入（0x40）read_me

一、用途
发送帧使用 NO3 的
0x40 SM4_BULK（4 字节 LEN），应答也是 4 字节 LEN。

覆盖：
- 正常 ECB 16B 基线
- 数据长度 15B（非 16 倍数）
- 数据长度 0
- 非法 id=0x00 / 0x06
- 非法 mode=0x02
- 非法 op=0x02
- CBC 只给 IV、无数据
- CBC IV + 15B 数据

不包含 OTP 槽、未知命令和帧层异常用例。
只使用临时槽 5（RAM），不写 OTP。

二、前提
- 固件必须是 NO3；NO2 没有 0x40。
- 0x40 PAYLOAD：[id, mode, op] + IV + data。
- 0x40 是 4 字节长度，发送和返回与普通 2 字节 LEN 命令不同。

三、运行
进入本目录：
    cd otp_patch/test_tools/sm4/sm4异常输入
    python3 sm4_abnormal_40.py COM24

从 test_tools 根目录：
    python3 sm4/sm4异常输入/sm4_abnormal_40.py COM24

常用参数：
    --baud 115200
    --out ./xxx.md

四、实际发送
    GENKEY(5)
    0x40 SM4_BULK 的 9 条负向/基线用例

不会发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY。

五、报告
默认：
    ../sm4_report/sm4_abnormal_40_report.md

列：
    序号 / 非正常输入 / 完整发送数据 / 完整返回数据 /
    设备响应 / 预期 / 结论

完整发送/返回数据是 0x40 的 4 字节 LEN 帧。

六、预期
    基线 ECB 16B 返回 0x00 + 16B 密文
    其余非法参数/长度返回 0xFE
    结论：全部符合预期

七、常见问题
- 0x40 无应答：确认烧的是 NO3；0x40 是 4 字节 LEN。
- 基线返回 FE：检查临时槽 5 是否 GENKEY 成功。
- 某条负向用例无应答：检查 0x40 LEN 是否和 PAYLOAD 一致。

SM3 非正常输入（0x41）read_me

一、用途
使用 NO3 的 0x41 SM3_BULK 测试内容与长度边界：
- 0B 基线
- 3B 基线
- 64B 全 0x00
- 64B 全 0xFF
- 64B 全 0x5A（帧头字节）
- 64B 00/FF 交替
- 131072B 上限
- 131073B 超过上限，预期 0xFE

SM3 算法本身没有非法内容；全 00/FF/5A 都是合法输入，
应返回 STATUS=0x00 + 正确摘要。

原 0x10 非正常输入脚本 sm3_abnormal.py 保留（已删除流式用例）。
SM3 不使用密钥，不涉及 OTP。

二、0x41 的边界
0x41 只有一个长度参数：
    0..131072       合法
    131073..131124  固件 128KB 缓冲能收下，handler 返回 0xFE
    >131124        帧层直接丢弃，不应答

本脚本测到 131073 为止，不发送 >131124 的帧。

三、运行
进入本目录：
    cd otp_patch/test_tools/sm3/sm3异常输入
    python3 sm3_abnormal_41.py COM24

从 test_tools 根目录：
    python3 sm3/sm3异常输入/sm3_abnormal_41.py COM24

常用参数：
    --timeout 60
    --baud 115200
    --out ./xxx.md

四、实际发送
    5A 41 LEN0..LEN3 data

不会发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY。

五、报告
默认：
    ../sm3_report/sm3_abnormal_41_report.md

列：
    序号 / 非正常输入 / 完整发送数据 / 完整返回数据 /
    设备响应 / 预期 / 结论

超过 512B 的发送帧只记录长度、首尾字节和 SHA256；
设备返回的摘要完整列出。

六、预期
    0B/3B/131072B：STATUS=0x00 + 正确摘要
    131073B：STATUS=0xFE
    结论：全部符合预期

七、常见问题
- 无应答：确认烧的是 NO3；0x41 是 4 字节 LEN。
- 131073B 超时：128KB+ 单程约 11.4s，加大 --timeout。
- 摘要不一致：检查 LEN 和实际数据长度。
- 流式 0x1A/0x1B/0x1C 已删除，不要再用。

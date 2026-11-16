SM3 单帧大数据（0x41）read_me

一、用途
使用 NO3 的 0x41 SM3_BULK 测试 SM3：
- 一个逻辑大帧，4 字节 LEN
- 最大 131072B
- 固件收齐后调用一次 Invoke_SM3_cal，返回 32B 摘要

只保留 0x41 版本。
SM3 不使用密钥，不涉及 OTP。

二、前提
- 固件必须是 NO3；NO2 没有 0x41。
- 0x41 PAYLOAD 就是 SM3 原始数据，没有额外头。
- 上位机可以一次 write，也可以拆成 n 次 write。
- 应答可以分 n 次 read。
- 中间没有帧头、偏移或 ACK。

三、运行
进入本目录：
    cd otp_patch/test_tools/sm3/sm3单帧
    python3 sm3_oneshot_41.py COM24

从 test_tools 根目录：
    python3 sm3/sm3单帧/sm3_oneshot_41.py COM24

默认用例：
    空数据
    1B / 3B
    55B / 56B / 63B / 64B / 65B
    119B / 120B / 127B / 128B
    512B
    128KB pattern

55/56、63/64/65、119/120、127/128 是 SM3 填充边界：
这些长度都合法，但会跨过不同的 64B 分组/填充分支，用来验证
padding 实现是否鲁棒。

常用参数：
    --data HEX        自定义数据，可重复；提供后只测这些
    --writes N        请求拆 N 次串口 write，默认 1
    --reads N         应答摘要拆 N 次 read，默认 1
    --timeout 60
    --baud 115200
    --out ./xxx.md

只测小数据：
    python3 sm3_oneshot_41.py COM24 --data 616263

只测 128KB：
    python3 sm3_oneshot_41.py COM24 --data <256KB hex> 不现实；
    默认用例里已经包含 128KB，直接运行即可。

四、实际发送
    5A 41 LEN0..LEN3 data

不会发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY。

五、报告
默认：
    ../sm3_report/sm3_oneshot_41_report.md

内容：
    每个用例的长度、STATUS、设备摘要、Python 参考摘要、结论。

六、预期
    每个用例摘要与参考一致
    结论：全部符合预期

注意：SM3 标准定义消息位长 < 2^64。
>2^64 位属于算法定义域之外，本平台也无法发送：
2^64 bit = 2^61 字节，约 2 EiB，且当前 LEN/缓冲只有 128KB。
因此不把“>2^64 位”作为可执行用例，只做说明。

七、常见问题
- 无应答：确认烧的是 NO3；0x41 是 4 字节 LEN。
- 超时：128KB 单程约 11.4s，加大 --timeout。
- 摘要不一致：检查 LEN 是否等于实际 data 字节数。

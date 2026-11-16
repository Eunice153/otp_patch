SM3 速率测试 read_me
/*
cd otp_patch/test_tools

# 默认 128KB × 3 轮
python3 sm3/sm3_speed/sm3_speed.py COM24

# 指定大小和轮数
python3 sm3/sm3_speed/sm3_speed.py COM24 --size 64K --runs 5
python3 sm3/sm3_speed/sm3_speed.py COM24 --size 32K --runs 10
python3 sm3/sm3_speed/sm3_speed.py COM24 --size 131072 --runs 3
*/
一、用途
测量 NO3 固件 0x41 SM3 的端到端执行时间：
    主机发送 0x41 大帧 + data
    -> 固件收齐
    -> Invoke_SM3_cal
    -> 32B 摘要
    -> 主机收完摘要

默认：128KB，3 轮。
可以指定数据大小和轮数。

注意：Kbps 包含串口传输时间，不是纯 SM3 运算时间。
115200 8N1 的理论 payload 上限约 92.16 Kbps，所以 128KB 的
89 Kbps 左右是正常范围。

二、前提
- 固件必须是 NO3；0x41 是 NO3 的逻辑大帧。
- NO2 没有 0x41。
- SM3 不使用密钥，不涉及 OTP。
- 单个大帧最大 131072B（128KB）。

三、运行
进入本目录：
    cd otp_patch/test_tools/sm3/sm3_speed
    python3 sm3_speed.py COM24

从 test_tools 根目录：
    python3 sm3/sm3_speed/sm3_speed.py COM24

默认就是：
    --size 128K --runs 3

指定数据大小和轮数：
    python3 sm3_speed.py COM24 --size 64K --runs 5
    python3 sm3_speed.py COM24 --size 131072 --runs 3
    python3 sm3_speed.py COM24 --size 32K --runs 10

常用参数：
    --size N       数据大小，默认 128K；支持 64K/128K/131072
    --runs N       轮数，默认 3
    --baud 115200  默认，和固件一致
    --timeout 120  单轮超时
    --no-verify    不比对摘要
    --out ./xxx.md 改报告路径

四、实际发送
    5A 41 LEN0..LEN3 data

每次运行只发一个 0x41 逻辑大帧。
不发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY。

五、报告
默认：
    ../sm3_report/sm3_speed_report.md

内容：
    - 串口、数据大小、轮数、命令
    - 每一轮运算时间
    - 平均执行时间
    - 杂凑运算平均速率 Kbps
    - 每轮摘要校验结果

六、速率计算
    Kbps = 数据字节数 × 8 / 时间 / 1000

时间从主机开始发送大帧算起，到收完 32B 摘要为止，
包含：
    - UART 发送 128KB
    - 固件收齐
    - SM3 计算
    - UART 回 32B

所以它测的是系统端到端吞吐，不是纯算法周期。

七、示例结果
128KB × 3 轮，115200 下典型结果：

    第一次  11.7 s 左右
    第二次  11.7 s 左右
    第三次  11.7 s 左右
    平均    11.7 s 左右
    速率    89 Kbps 左右

具体数值受 USB 转串口、主机调度影响。

八、常见问题
- 无应答：确认烧的是 NO3；0x41 是 4 字节 LEN。
- 超时：128KB 单程约 11.4s，确保 --timeout 足够。
- 速率明显低于 80 Kbps：检查波特率是否真是 115200，
  是否被 USB 转串口/其他工具拖慢。
- 摘要 FAIL：检查 LEN 和实际数据长度。
- 流式 0x1A/0x1B/0x1C 已删除，不要再用。

SM4 CBC 速率测试 read_me

一、用途
测量 NO3 固件 0x40 SM4 CBC 的端到端执行时间。

默认：
    数据大小 128KB
    轮数 3
    op=both（加密 + 解密）
    IV=00 01 ... 0F

也可以：
    --op enc     只测加密
    --op both    加密和解密都测
    --iv HEX     指定 16B CBC IV

注意：Kbps 包含 UART 传输时间，不是纯 SM4 运算时间。
115200 8N1 的理论 payload 上限约 92.16 Kbps。

二、前提
- 固件必须是 NO3；0x40 是 NO3 的逻辑大帧。
- 只使用 RAM 临时槽 5，不写 OTP。
- data 必须是 16 的倍数，最大 131072B。
- 默认先 GENKEY(5)；--no-genkey 使用现有临时密钥。

三、运行
进入本目录：
    cd otp_patch/test_tools/sm4/sm4cbc_speed
    python3 sm4_cbc_speed.py COM24

从 test_tools 根目录：
    python3 sm4/sm4cbc_speed/sm4_cbc_speed.py COM24

默认就是：
    --size 128K --runs 3 --op both

指定大小/轮数/操作/IV：
    python3 sm4_cbc_speed.py COM24 --size 64K --runs 5
    python3 sm4_cbc_speed.py COM24 --size 131072 --runs 3
    python3 sm4_cbc_speed.py COM24 --op enc
    python3 sm4_cbc_speed.py COM24 --op both
    python3 sm4_cbc_speed.py COM24 \
        --iv 000102030405060708090A0B0C0D0E0F

常用参数：
    --size N       数据大小，默认 128K
    --runs N       轮数，默认 3
    --op dec|enc|both  默认 both
    --iv 32位hex   CBC IV，默认 00 01 ... 0F
    --no-genkey    使用现有临时槽 5
    --no-verify    不比对 Python 参考
    --timeout 120
    --baud 115200
    --out ./xxx.md

四、报告
默认：
    ../sm4_report/sm4_cbc_speed_report.md

表格列：
    数据大小 / 第一次 / 第二次 / 第三次 /
    平均执行时间 / 加密平均速率(Kbps) 或 解密平均速率(Kbps)

默认 --op both，会分别有“加密(CBC)”和“解密(CBC)”两张表；
    --op enc/dec 只出一张表。

五、速率计算
    Kbps = 数据字节数 × 8 / 时间 / 1000

时间从主机开始发 0x40 大帧到收完结果，包含：
    - UART 发送 128KB
    - 固件收齐
    - SM4 CBC 加/解密
    - UART 回 128KB

六、常见问题
- 无应答：确认烧的是 NO3；0x40 是 4 字节 LEN。
- 返回 0xF8：临时槽 5 为空，先 GENKEY(5)。
- 超时：128KB 单程约 11.4s，加大 --timeout。
- 速率明显低于 80 Kbps：检查波特率是否 115200，
  是否被 USB 转串口/其他工具拖慢。
- CBC IV 不是 16B：检查 --iv 是否为 32 个 hex 字符。

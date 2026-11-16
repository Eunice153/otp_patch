NO3 大数据单帧 read_me（0x40 SM4 / 0x41 SM3）

一、设计
这是“一个逻辑大帧”，不是每 512B 一个协议帧。
上位机把整帧拆成任意 n 次串口 write 都可以；固件按 4 字节 LEN
连续收齐后只处理一次，收齐后只回一帧。
上位机也可以分 n 次 read 接收应答。
中间没有帧头、偏移、序号或 ACK。

二、帧格式（4 字节长度）
请求：
    5A CMD LEN0 LEN1 LEN2 LEN3 PAYLOAD[LEN]
应答：
    5A CMD STATUS LEN0 LEN1 LEN2 LEN3 DATA[LEN]

LEN 是大端 32 位，表示 PAYLOAD 字节数。

三、0x40 SM4_BULK
PAYLOAD 和原 0x20 一致，只是 data 可以到 128KB：
    [0] id      5=临时槽，2=OTP 槽（需先 AUTH）
    [1] mode    0=ECB，1=CBC；bit7=1 表示后面跟 [pwd_len][pwd]
    [2] op      0=加密，1=解密
    [3..]       可选 [pwd_len][口令 12~32B]
    [..]        CBC 时 16B IV
    [..]        data（16 的正整数倍，最大 131072B）

应答 DATA 与请求 data 等长，不额外附加 IV。

示例：临时槽 5，CBC 加密 16B，IV=00 01 ... 0F
    PAYLOAD = 05 01 00 00 01 02 ... 0F + 16B 明文
    LEN = 3 + 16 + 16 = 35 = 0x23
    发送：5A 40 00 00 00 23 <PAYLOAD>
    应答：5A 40 00 00 00 00 10 + 16B 密文

解密时 mode/op 改为 01 01，data 换成密文，IV 不变。

四、0x41 SM3_BULK
PAYLOAD 就是 SM3 原始数据，没有额外头。
    LEN = 数据长度（0..131072）
    应答 DATA = 32B 摘要

示例：SM3("abc")
    发送：5A 41 00 00 00 03 61 62 63
    应答：5A 41 00 00 00 00 20 + 32B 摘要

五、上位机拆分 write/read
拆分只发生在串口读写层，不影响协议：
    - 可以把“5A 41 + LEN + data”拆成 n 次 write；
    - 固件状态机按字节累积，不关心中间分了几次；
    - 应答也可以分 n 次 read。
唯一注意：拆分后的写入之间不要停太久，否则固件的半帧超时
会丢弃本次大帧。脚本默认连续写。

六、长度和缓冲
- 单次 data 最大 131072B（128KB）。
- SM4 data 必须是 16 的正整数倍。
- 固件使用 128KB 输入 + 128KB 输出静态缓冲，收齐后一次处理。
- 115200 下 128KB 单程约 11.4s；脚本默认超时 120s。

七、密钥/OTP
- SM4 临时槽 5 需要先发 GENKEY(5)：5A 11 00 00 01 05。
- id=2 需要先 AUTH 或带临时口令；固件只做只读加载，不写 OTP。
- SM3 不需要密钥。
- 本脚本不发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY。

八、脚本
    cd otp_patch/otp_main_only_full_test_uart_NO3/test_tools

    # SM4 CBC 4096B，请求拆 8 次写，应答拆 8 次读
    python3 large_bulk.py COM24 --algo sm4 --mode cbc --size 4096 \
        --writes 8 --reads 8 --verify

    # SM4 ECB 128KB
    python3 large_bulk.py COM24 --algo sm4 --mode ecb --size 131072 \
        --writes 16 --reads 16

    # SM3 128KB
    python3 large_bulk.py COM24 --algo sm3 --size 131072 \
        --writes 16 --reads 1 --verify

    # 指定 IV / 文件
    python3 large_bulk.py COM24 --algo sm4 --mode cbc --in pt.bin \
        --iv "000102030405060708090A0B0C0D0E0F" --out ct.bin

参数：
    --writes N   把请求拆成 N 次串口 write
    --reads N    把应答数据拆成 N 次 read
    --verify     与纯 Python SM3/SM4 参考实现交叉校验
    --no-genkey  不重新生成临时槽 5 密钥
    --timeout    单次大帧超时，默认 120s

九、与 0x20 的关系
0x20 SM4_CRYPT 仍然保留，适合 <=480B 小数据（SSCOM 可直接发）。
0x40 只是把同一个 payload 的数据长度扩大到 128KB。

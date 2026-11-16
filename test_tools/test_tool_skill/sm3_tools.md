# SM3 测试脚本

所有脚本都在 `otp_patch/test_tools/sm3/` 下，报告统一写入
`otp_patch/test_tools/sm3/sm3_report/`。

## 公共前提

- WSL 下 `python3 <script> COM24` 会自动转用 Windows Python。
- 运行前关闭占用 COM 口的串口工具。
- 依赖 pyserial。
- SM3 不使用密钥，不涉及 OTP。
- 0x10 单帧 DATA ≤512B。
- NO3 的 0x41 是 4 字节 LEN 的逻辑大帧，最大 128KB。
- 流式 0x1A/0x1B/0x1C 已删除。

## 1. 0x10 单帧

脚本：`sm3/sm3单帧/sm3_oneshot.py`

```bash
python3 sm3/sm3单帧/sm3_oneshot.py COM24
python3 sm3/sm3单帧/sm3_oneshot.py COM24 --data "616263"
```

- 默认 5 组：空数据、1B、abc、64B、512B。
- 设备 0x10 返回 32B 摘要，和 Python hashlib(SM3) 比较。
- 报告：`sm3_report/sm3_oneshot_report.md`

## 2. 0x41 单帧大数据（仅 NO3）

脚本：`sm3/sm3单帧/sm3_oneshot_41.py`

```bash
python3 sm3/sm3单帧/sm3_oneshot_41.py COM24
python3 sm3/sm3单帧/sm3_oneshot_41.py COM24 --data "616263"
python3 sm3/sm3单帧/sm3_oneshot_41.py COM24 --writes 16 --reads 4
```

流程：

```text
0x41 SM3_BULK + data
收齐 4 字节 LEN 指定的数据
Invoke_SM3_cal -> 32B 摘要
```

- 默认包含 0B、1B、3B、55B、56B、63B、64B、65B、
  119B、120B、127B、128B、512B、128KB。
- 55/56、63/64/65、119/120、127/128 是 SM3 padding 边界。
- 0x41 是 NO3 的逻辑大帧，4 字节 LEN，最大 131072B。
- 请求可以一次 write，也可以拆 n 次；应答可以分 n 次 read。
- 报告：`sm3_report/sm3_oneshot_41_report.md`

## 3. 0x10 非正常输入

脚本：`sm3/sm3异常输入/sm3_abnormal.py`

```bash
python3 sm3/sm3异常输入/sm3_abnormal.py COM24
```

覆盖：

- 基线 0x10 "abc"
- 0x10 空数据
- 0x10 512B（普通帧上限）
- 64B 全 0x00 / 全 0xFF / 全 0x5A / 00-FF 交替
- 0x10 LEN=513（帧层超过 512，固件丢弃，无应答）

全 00/FF/5A 是合法 SM3 输入，应返回 0x00 + 正确摘要。

报告：`sm3_report/sm3_abnormal_report.md`

- 列：序号 / 非正常输入 / 完整发送数据 / 完整返回数据 /
  设备响应 / 预期 / 结论。

## 4. 0x41 非正常输入（仅 NO3）

脚本：`sm3/sm3异常输入/sm3_abnormal_41.py`

```bash
python3 sm3/sm3异常输入/sm3_abnormal_41.py COM24
```

覆盖：

- 0B / 3B 基线
- 64B 全 0x00 / 全 0xFF / 全 0x5A / 00-FF 交替
- 131072B 上限
- 131073B 超过上限，预期 0xFE

SM3 算法本身没有非法内容；全 00/FF/5A 都是合法输入，
应返回 0x00 + 正确摘要。

报告：`sm3_report/sm3_abnormal_41_report.md`

- 超过 512B 的发送帧只记录长度、首尾字节和 SHA256；
  设备返回的摘要完整列出。

## 5. 速率测试（仅 NO3）

脚本：`sm3/sm3_speed/sm3_speed.py`

```bash
# 默认 128KB × 3 轮
python3 sm3/sm3_speed/sm3_speed.py COM24

# 指定大小和轮数
python3 sm3/sm3_speed/sm3_speed.py COM24 --size 64K --runs 5
python3 sm3/sm3_speed/sm3_speed.py COM24 --size 131072 --runs 3
```

测量：

```text
0x41 大帧端到端时间
= 主机发送 + 固件收齐 + Invoke_SM3_cal + 主机收摘要
```

- 默认 128KB、3 轮。
- Kbps 包含 UART 传输，不是纯算法运算时间。
- 115200 8N1 理论 payload 上限约 92.16 Kbps。
- 报告：`sm3_report/sm3_speed_report.md`

## 报告路径

```text
otp_patch/test_tools/sm3/sm3_report/
├── sm3_oneshot_report.md
├── sm3_oneshot_41_report.md
├── sm3_abnormal_report.md
├── sm3_abnormal_41_report.md
└── sm3_speed_report.md
```

`--out` 可以覆盖；WSL 下 `--out` 会自动转成 Windows 路径。

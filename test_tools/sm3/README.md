# SM3 工具

```text
otp_patch/test_tools/sm3/
├── sm3单帧/
│   ├── sm3_oneshot.py       # 0x10，≤512B
│   ├── read_me.txt
│   ├── sm3_oneshot_41.py    # NO3 0x41，≤128KB
│   └── read_me_41.txt
├── sm3异常输入/
│   ├── sm3_abnormal.py      # 0x10 边界/异常
│   ├── read_me.txt
│   ├── sm3_abnormal_41.py   # NO3 0x41 长度边界
│   └── read_me_41.txt
├── sm3_speed/
│   ├── sm3_speed.py         # 0x41 速率，默认 128KB×3
│   └── read_me.txt
└── sm3_report/              # 报告输出
```

流式 `0x1A/0x1B/0x1C` 已删除；大数据统一用 NO3 的 `0x41`
（收齐后调用一次 `Invoke_SM3_cal`）。

## 快速开始

```bash
cd otp_patch/test_tools

# 0x10 单帧（≤512B）
python3 sm3/sm3单帧/sm3_oneshot.py COM24

# NO3 0x41 单帧大数据（最大 128KB）
python3 sm3/sm3单帧/sm3_oneshot_41.py COM24

# 0x10 非正常输入
python3 sm3/sm3异常输入/sm3_abnormal.py COM24

# NO3 0x41 长度边界
python3 sm3/sm3异常输入/sm3_abnormal_41.py COM24

# 速率：默认 128KB × 3 轮
python3 sm3/sm3_speed/sm3_speed.py COM24
python3 sm3/sm3_speed/sm3_speed.py COM24 --size 64K --runs 5
```

报告默认写到：

```text
otp_patch/test_tools/sm3/sm3_report/
├── sm3_oneshot_report.md
├── sm3_oneshot_41_report.md
├── sm3_abnormal_report.md
├── sm3_abnormal_41_report.md
└── sm3_speed_report.md
```

## 规则

- SM3 不使用密钥，不涉及 OTP。
- `0x10` 单帧 DATA ≤512B。
- `0x41` 是 NO3 的逻辑大帧，4 字节 LEN，最大 128KB；
  主机可以拆成 n 次 write，固件收齐后只处理一次。
- NO2 没有 0x41，只能用 0x10。

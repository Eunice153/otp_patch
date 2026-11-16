# SM3 工具

只保留 NO3 的 `0x41 SM3_BULK` 测试。

```text
otp_patch/test_tools/sm3/
├── sm3单帧/
│   ├── sm3_oneshot_41.py    # 0x41，≤128KB
│   └── read_me_41.txt
├── sm3异常输入/
│   ├── sm3_abnormal_41.py   # 0x41 长度边界
│   └── read_me_41.txt
├── sm3_speed/
│   ├── sm3_speed.py         # 0x41 速率，默认 128KB×3
│   └── read_me.txt
└── sm3_report/              # 报告输出
```

`0x1A/0x1B/0x1C` 流式和短 SM3 测试已删除；SM3 统一用 `0x41`。

## 快速开始

```bash
cd otp_patch/test_tools

# 0x41 单帧/大帧，最大 128KB
python3 sm3/sm3单帧/sm3_oneshot_41.py COM24

# 0x41 长度边界
python3 sm3/sm3异常输入/sm3_abnormal_41.py COM24

# 速率：默认 128KB × 3 轮
python3 sm3/sm3_speed/sm3_speed.py COM24
python3 sm3/sm3_speed/sm3_speed.py COM24 --size 64K --runs 5
```

报告默认写到：

```text
otp_patch/test_tools/sm3/sm3_report/
├── sm3_oneshot_41_report.md
├── sm3_abnormal_41_report.md
└── sm3_speed_report.md
```

## 规则

- SM3 不使用密钥，不涉及 OTP。
- `0x41` 是 NO3 的逻辑大帧，4 字节 LEN，最大 128KB；
  主机可以拆成 n 次 write，固件收齐后只处理一次。
- 只对 NO3 固件有效。

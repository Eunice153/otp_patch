# SM4 测试脚本

所有脚本都在 `otp_patch/test_tools/sm4/` 下，报告统一写入
`otp_patch/test_tools/sm4/sm4_report/`。

只保留 NO3 的 `0x40 SM4_BULK` 测试；短 SM4（0x20）测试已删除。

## 公共前提

- WSL 下 `python3 <script> COM24` 会自动转用 Windows Python。
- 运行前关闭占用 COM 口的串口工具。
- 依赖 pyserial。
- **不写 OTP**：脚本只用临时槽 5；禁止 `SET_PASSWORD` /
  `KEY_STORE` / `KEY_DESTROY`。
- NO3 的 0x40 使用 4 字节 LEN，data 最大 131072B。
- 0x40 PAYLOAD：`[id, mode, op] + 可选口令 + [IV] + data`。

## 1. 密钥生成/导出

脚本：`sm4/sm4密钥生成/sm4_key_40.py`

```bash
python3 sm4/sm4密钥生成/sm4_key_40.py COM24
```

流程：

```text
GENKEY(5)
LOAD_PUBKEY(TEST_D 公钥)
EXPORT_KEY(5, 1)
上位机用 TEST_D 解出 16B SM4 密钥
0x40 ECB 加密/解密自检
```

报告：`sm4_report/sm4_key_40_report.md`

## 2. ECB 加解密

脚本：`sm4/sm4ecb加解密/sm4_ecb_40.py`

```bash
python3 sm4/sm4ecb加解密/sm4_ecb_40.py COM24
python3 sm4/sm4ecb加解密/sm4_ecb_40.py COM24 --lengths 16,32,64
python3 sm4/sm4ecb加解密/sm4_ecb_40.py COM24 --lengths 131072
```

- 默认长度：16/32/64/256/480B。
- 每个长度都做设备加密→Python 参考比对、设备解密→原文比对。
- 报告：`sm4_report/sm4_ecb_40_report.md`

## 3. CBC 加解密

脚本：`sm4/sm4cbc加解密/sm4_cbc_40.py`

```bash
python3 sm4/sm4cbc加解密/sm4_cbc_40.py COM24
python3 sm4/sm4cbc加解密/sm4_cbc_40.py COM24 --iv 000102030405060708090A0B0C0D0E0F
python3 sm4/sm4cbc加解密/sm4_cbc_40.py COM24 --lengths 131072
```

- 默认长度：16/32/64/256/480B。
- 默认 IV：`00 01 ... 0F`，可用 `--iv` 覆盖。
- 报告：`sm4_report/sm4_cbc_40_report.md`

## 4. 异常输入

脚本：`sm4/sm4异常输入/sm4_abnormal_40.py`

```bash
python3 sm4/sm4异常输入/sm4_abnormal_40.py COM24
```

覆盖：

- 数据长度 0 / 非 16 字节倍数
- 非法 id / mode / op
- CBC 缺 IV / IV 后数据不是 16 的倍数

报告：`sm4_report/sm4_abnormal_40_report.md`

## 5. 密钥导入

脚本：`sm4/sm4密钥导入导出/sm4_key_import_40.py`

```bash
python3 sm4/sm4密钥导入导出/sm4_key_import_40.py COM24
python3 sm4/sm4密钥导入导出/sm4_key_import_40.py COM24 --password "Abcd1234Efghijkm"
python3 sm4/sm4密钥导入导出/sm4_key_import_40.py COM24 --key 0123456789ABCDEFFEDCBA9876543210
```

流程：

```text
KEY_LOAD(dec_id, 口令)            可选：只读加载 OTP→SRAM
GETPUBKEY(dec_id)                 只读 OTP 公钥
上位机生成/指定 16B SM4 密钥
SM2 包裹该密钥
KEY_IMPORT(target=5, dec_id, 1, wrapped)
EXPORT_KEY(5,1) 导出比对
0x40 ECB 加密/解密验证
```

前提：

- 芯片已有 `dec_id=0` 或 `1` 的 OTP SM2 密钥；
- 如未加载，用 `--password` 先 `KEY_LOAD`（只读）；
- 没有 OTP 密钥时脚本停止，不写 OTP。

报告：`sm4_report/sm4_key_import_40_report.md`

## 6. 速率测试

```text
sm4/sm4ecb_speed/sm4_ecb_speed.py
sm4/sm4cbc_speed/sm4_cbc_speed.py
```

```bash
# 默认 128KB × 3 轮加密+解密
python3 sm4/sm4ecb_speed/sm4_ecb_speed.py COM24
python3 sm4/sm4cbc_speed/sm4_cbc_speed.py COM24

python3 sm4/sm4ecb_speed/sm4_ecb_speed.py COM24 --size 64K --runs 5
python3 sm4/sm4cbc_speed/sm4_cbc_speed.py COM24 --op both
```

- 测量端到端，包含 UART 传输。
- 报告：`sm4_ecb_speed_report.md` / `sm4_cbc_speed_report.md`

## 报告路径

```text
otp_patch/test_tools/sm4/sm4_report/
├── sm4_key_40_report.md
├── sm4_ecb_40_report.md
├── sm4_cbc_40_report.md
├── sm4_abnormal_40_report.md
├── sm4_key_import_40_report.md
├── sm4_ecb_speed_report.md
└── sm4_cbc_speed_report.md
```

`--out` 可以覆盖；WSL 下 `--out` 会自动转成 Windows 路径。

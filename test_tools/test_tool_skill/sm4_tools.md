# SM4 测试脚本

所有脚本都在 `otp_patch/test_tools/sm4/` 下，报告统一写入
`otp_patch/test_tools/sm4/sm4_report/`。

## 公共前提

- WSL 下 `python3 <script> COM24` 会自动转用 Windows Python。
- 运行前关闭占用 COM 口的串口工具。
- 依赖 pyserial。
- **不写 OTP**：只用临时槽 5；脚本禁止 `SET_PASSWORD` /
  `KEY_STORE` / `KEY_DESTROY`。
- 普通 0x20 单帧 DATA ≤512B。ECB 参数占 3B，CBC 参数 3B + IV 16B，
  所以 0x20 测试长度最大 480B。
- NO3 的 0x40 不受 512B 限制，使用 4 字节 LEN，data 最大 131072B。

## 1. 密钥生成/导出

脚本：`sm4/sm4密钥生成/sm4_key.py`

```bash
python3 sm4/sm4密钥生成/sm4_key.py COM24
```

流程：

```text
GENKEY(5)
LOAD_PUBKEY(TEST_D 公钥)
EXPORT_KEY(5, 1)        # 固件旧名 SM4_EXPORT；通用导出
上位机用 TEST_D 解出 16B SM4 密钥
ECB 加密/解密自检
```

报告：`sm4_report/sm4_key_report.md`

- 记录 GENKEY、LOAD_PUBKEY、EXPORT_KEY 状态；
- 记录本次临时密钥 K（16B）；
- 记录 ECB 加密/解密自检结果。

## 2. ECB 加解密

脚本：`sm4/sm4ecb加解密/sm4_ecb.py`

```bash
python3 sm4/sm4ecb加解密/sm4_ecb.py COM24
python3 sm4/sm4ecb加解密/sm4_ecb.py COM24 --lengths 16,32,64
```

流程：

```text
GENKEY(5) -> 导出/恢复 16B 密钥
每组长度 L:
  SM4_CRYPT(mode=ECB, op=加密) -> 设备密文 vs Python 参考
  SM4_CRYPT(mode=ECB, op=解密) -> 设备明文 vs 原文
```

- 默认长度：16/32/64/256/480B。
- 报告：`sm4_report/sm4_ecb_report.md`
- 两张表：加密(ECB) / 解密(ECB)。

## 3. CBC 加解密

脚本：`sm4/sm4cbc加解密/sm4_cbc.py`

```bash
python3 sm4/sm4cbc加解密/sm4_cbc.py COM24
python3 sm4/sm4cbc加解密/sm4_cbc.py COM24 --iv 000102030405060708090A0B0C0D0E0F
```

流程：

```text
GENKEY(5) -> 导出/恢复 16B 密钥
固定 IV:
  SM4_CRYPT(mode=CBC, op=加密, IV) -> 设备密文 vs Python 参考
  SM4_CRYPT(mode=CBC, op=解密, IV) -> 设备明文 vs 原文
```

- 默认长度：16/32/64/256/480B。
- 默认 IV：`00 01 ... 0F`；可用 `--iv` 覆盖。
- 报告：`sm4_report/sm4_cbc_report.md`
- 两张表：加密(CBC) / 解密(CBC)。

## 4. 异常输入

脚本：`sm4/sm4异常输入/sm4_abnormal.py`

```bash
python3 sm4/sm4异常输入/sm4_abnormal.py COM24
```

覆盖：

- 数据长度 0 / 非 16 字节倍数；
- 非法 id / mode / op；
- CBC 缺 IV / IV 后数据不是 16 的倍数。

不包含 OTP 槽、未知命令和帧层异常用例。

报告：`sm4_report/sm4_abnormal_report.md`

- 列：序号 / 非正常输入 / 完整发送数据 / 完整返回数据 /
  设备响应 / 预期 / 结论。

## 5. 密钥导入

脚本：`sm4/sm4密钥导入导出/sm4_key_import.py`

```bash
python3 sm4/sm4密钥导入导出/sm4_key_import.py COM24
python3 sm4/sm4密钥导入导出/sm4_key_import.py COM24 --password "123456789012"
python3 sm4/sm4密钥导入导出/sm4_key_import.py COM24 --key 0123456789ABCDEFFEDCBA9876543210
```

流程：

```text
KEY_LOAD(dec_id, 口令)            可选：只读加载 OTP→SRAM
GETPUBKEY(dec_id)                 只读 OTP 公钥
上位机生成/指定 16B SM4 密钥
SM2 包裹该密钥
KEY_IMPORT(target=5, dec_id, 1, wrapped)
EXPORT_KEY(5,1) 导出比对
SM4_CRYPT ECB 加密/解密验证
```

前提：

- 芯片必须已有 `dec_id = 0` 或 `1` 的 OTP SM2 密钥；
- `GETPUBKEY` 读的是 SRAM 里的 `key_data_table[dec_id]`，如果 OTP
  密钥还没加载，先加 `--password` 发 `KEY_LOAD`（只读）；
- 没有 OTP 密钥时脚本停止并写“未加载/未执行”，不写 OTP。

报告：`sm4_report/sm4_key_import_report.md`

- 记录 OTP 槽号、KEY_LOAD 状态、OTP 公钥、包裹密文、
  KEY_IMPORT 状态、导出密钥匹配、ECB 加密/解密。

当前空片运行结果：

```text
GETPUBKEY(0): 未加载/未配置；如已配置 OTP 密钥，用 --password 先 KEY_LOAD（只读）
结论：存在失败/未执行项
```

## 6. 0x40 大数据（仅 NO3）

脚本：`sm4/sm4大数据/sm4_bulk.py`

```bash
# 默认 CBC，16/480/4096/131072B，加密+解密
python3 sm4/sm4大数据/sm4_bulk.py COM24

# 只测 128KB CBC
python3 sm4/sm4大数据/sm4_bulk.py COM24 --mode cbc --lengths 131072

# 128KB ECB
python3 sm4/sm4大数据/sm4_bulk.py COM24 --mode ecb --lengths 131072

# 请求拆 16 次 write，应答拆 16 次 read
python3 sm4/sm4大数据/sm4_bulk.py COM24 --mode cbc --lengths 131072 \
    --writes 16 --reads 16
```

流程：

```text
GENKEY(5)
LOAD_PUBKEY(TEST_D 公钥)
EXPORT_KEY(5,1) -> 恢复 16B 密钥
对每个长度 L:
  0x40 SM4_BULK 加密 -> 设备密文 vs Python 参考
  0x40 SM4_BULK 解密 -> 设备明文 vs 原文
```

- 0x40 是一个逻辑大帧，4 字节 LEN，最大 131072B。
- 请求可以一次 write，也可以拆 n 次；应答可以分 n 次 read。
- 中间没有帧头、偏移和 ACK。
- 只对 NO3 固件有效；NO2 没有 0x40。
- 报告：`sm4_report/sm4_bulk_report.md`
- 128KB 报告只记录长度、SHA256 和应答头，不整段存 131072B。

## 6.1 速率测试（仅 NO3）

脚本：

```text
sm4/sm4ecb_speed/sm4_ecb_speed.py
sm4/sm4cbc_speed/sm4_cbc_speed.py
```

```bash
# 默认 128KB × 3 轮加密+解密
python3 sm4/sm4ecb_speed/sm4_ecb_speed.py COM24
python3 sm4/sm4cbc_speed/sm4_cbc_speed.py COM24

# 指定大小/轮数
python3 sm4/sm4ecb_speed/sm4_ecb_speed.py COM24 --size 64K --runs 5

# 加密 / 两者
python3 sm4/sm4ecb_speed/sm4_ecb_speed.py COM24 --op enc
python3 sm4/sm4cbc_speed/sm4_cbc_speed.py COM24 --op both
```

- 命令：0x40 SM4_BULK，一个逻辑大帧。
- 默认 128KB、3 轮、加密+解密；`--op enc/dec` 只测一项。
- 测量端到端，包含 UART 传输。
- 报告：`sm4_ecb_speed_report.md` / `sm4_cbc_speed_report.md`

## 7. 各脚本的 0x40 版本

以下目录保留原 0x20 脚本，同时新增 0x40 版本和 `read_me_40.txt`：

| 目录 | 原脚本 | 0x40 脚本 | 报告 |
|---|---|---|---|
| `sm4密钥生成` | `sm4_key.py` | `sm4_key_40.py` | `sm4_key_40_report.md` |
| `sm4ecb加解密` | `sm4_ecb.py` | `sm4_ecb_40.py` | `sm4_ecb_40_report.md` |
| `sm4cbc加解密` | `sm4_cbc.py` | `sm4_cbc_40.py` | `sm4_cbc_40_report.md` |
| `sm4密钥导入导出` | `sm4_key_import.py` | `sm4_key_import_40.py` | `sm4_key_import_40_report.md` |
| `sm4异常输入` | `sm4_abnormal.py` | `sm4_abnormal_40.py` | `sm4_abnormal_40_report.md` |

```bash
python3 sm4/sm4密钥生成/sm4_key_40.py COM24
python3 sm4/sm4ecb加解密/sm4_ecb_40.py COM24
python3 sm4/sm4cbc加解密/sm4_cbc_40.py COM24
python3 sm4/sm4密钥导入导出/sm4_key_import_40.py COM24
python3 sm4/sm4异常输入/sm4_abnormal_40.py COM24
```

0x40 版本只对 NO3 有效；原 0x20 脚本保留给 NO2/NO3 回归。

## 报告路径

```text
otp_patch/test_tools/sm4/sm4_report/
├── sm4_key_report.md
├── sm4_ecb_report.md
├── sm4_cbc_report.md
├── sm4_abnormal_report.md
├── sm4_key_import_report.md
├── sm4_bulk_report.md
├── sm4_key_40_report.md
├── sm4_ecb_40_report.md
├── sm4_cbc_40_report.md
├── sm4_abnormal_40_report.md
├── sm4_key_import_40_report.md
├── sm4_ecb_speed_report.md
└── sm4_cbc_speed_report.md
```

`--out` 可以覆盖；WSL 下 `--out` 会自动转成 Windows 路径。

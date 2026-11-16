# SM2 测试脚本

所有脚本都在 `otp_patch/test_tools/sm2/` 下，报告统一写入
`otp_patch/test_tools/sm2/sm2_report/`。

## 公共前提

- WSL 下 `python3 <script> COM24` 会自动转用 Windows Python。
- 运行前关闭占用 COM 口的串口工具。
- 依赖 pyserial。
- **不写 OTP**：只用临时槽 3/4/5；脚本禁止 `SET_PASSWORD` /
  `KEY_STORE` / `KEY_DESTROY`。

## 1. 密钥对生成

脚本：`sm2/sm2密钥对生成/sm2_keypair.py`

```bash
python3 sm2/sm2密钥对生成/sm2_keypair.py COM24
python3 sm2/sm2密钥对生成/sm2_keypair.py COM24 --slots 3,4
python3 sm2/sm2密钥对生成/sm2_keypair.py COM24 --show-private
```

流程：

```text
GENKEY(3/4)
GETPUBKEY(3/4)
LOAD_PUBKEY(TEST_D 公钥)
EXPORT_KEY(slot, 1)          # 固件 0x13，旧名 CMD_SM4_EXPORT；通用导出
上位机用 TEST_D 解出私钥 d
pub_from_priv(d) 与设备公钥比对
```

`EXPORT_KEY` 不是 SM4 加密：SM2 槽返回 128B（64 C1 + 32 C3 +
32 C2），SM4 槽返回 112B。

报告：`sm2_report/sm2_keypair_report.md`

- 表格：槽位 / GENKEY / 公钥 X / 公钥 Y / LOAD_PUBKEY / 私钥导出 /
  公私钥匹配 / 结果
- 默认不显示私钥；`--show-private` 才显示临时私钥 d。

## 2. 加解密

脚本：`sm2/sm2加解密/sm2_crypt.py`

```bash
python3 sm2/sm2加解密/sm2_crypt.py COM24
python3 sm2/sm2加解密/sm2_crypt.py COM24 --lengths 16,32,64
```

流程：

```text
GENKEY(3) -> GETPUBKEY(3) -> 导出私钥 d
每组长度 L:
  SM2_ENC(std=1, pub, k_dev, pt)
  上位机用 d 解密设备密文
  SM2_DEC(3, std=1, L, ct_dev)
  SM2_ENC 由上位机生成 ct_host
  SM2_DEC(3, std=1, L, ct_host)
边界: SM2_DEC pt_len=65 -> 期望 0xFE
```

- `--slot` 只允许 3；OTP 槽不在本测试范围。
- 明文长度 1..64；SM2 解密受 ROM 栈帧限制。
- 报告：`sm2_report/sm2_crypt_report.md`
- 报告记录设备 k、设备密文、上位机 k、上位机密文和三项校验结果。

## 3. 加解密密钥导入

脚本：`sm2/sm2加解密密钥导入/sm2_key_import.py`

```bash
python3 "sm2/sm2加解密密钥导入/sm2_key_import.py" COM24
python3 "sm2/sm2加解密密钥导入/sm2_key_import.py" COM24 --dec-id 0
python3 "sm2/sm2加解密密钥导入/sm2_key_import.py" COM24 --password "123456789012"
python3 "sm2/sm2加解密密钥导入/sm2_key_import.py" COM24 --key <64位hex私钥>
```

流程：

```text
KEY_LOAD(dec_id, 口令)            可选：只读加载 OTP→SRAM
GETPUBKEY(dec_id)                 只读 OTP 公钥
上位机生成/指定私钥 d
SM2 包裹 d（用 OTP 公钥）
KEY_IMPORT(target=3, dec_id, std=1, wrapped)
GETPUBKEY(3) 比对导入公钥
LOAD_PUBKEY(TEST_D) + EXPORT_KEY(3,1) 导出私钥比对
SM2_ENC -> SM2_DEC(3) 验证导入密钥可解密
```

前提：

- 芯片必须已有 `dec_id = 0` 或 `1` 的 OTP SM2 密钥。
- `GETPUBKEY` 读的是 SRAM 里的 `key_data_table[dec_id]`；如果
  OTP 密钥还没加载，先加 `--password` 发 `KEY_LOAD`（只读）。
- 如果 `GETPUBKEY(dec_id)` 失败，脚本会停止并写“未加载/未执行”，
  **不会**尝试 `SET_PASSWORD` / `KEY_STORE` 去配置 OTP。
- `--target` 只允许 3；`KEY_IMPORT` 只写临时槽 3。

报告：`sm2_report/sm2_key_import_report.md`

- 记录 OTP 槽号、OTP 公钥、导入公钥、包裹密文、
  KEY_IMPORT 状态、公钥匹配、私钥匹配、解密测试。
- 默认不显示导入私钥；`--show-private` 才显示。

当前空片（OTP 槽 0 未配置）运行结果：

```text
GETPUBKEY(0): 未加载/未配置；停止（不会写 OTP）
结论：存在失败/未执行项
```

## 4. 签名验签

脚本：`sm2/sm2签名验签/sm2_sign_verify.py`

```bash
python3 sm2/sm2签名验签/sm2_sign_verify.py COM24
```

流程：

```text
GENKEY(4) -> GETPUBKEY(4) -> 导出私钥 d
对 5 组消息计算 SM3 摘要:
  SM2_SIGN(4, digest, k_dev)
  上位机 sm2_verify 验签
  设备 SM2_VERIFY(pub, digest, sig)
  篡改签名后设备验签，期望结果 0
  上位机 sm2_sign_host(d, digest, k_host)
  设备 SM2_VERIFY 验签主机签名
```

- `--slot` 只允许 4；OTP 签名槽不在本测试范围。
- 报告：`sm2_report/sm2_sign_verify_report.md`
- 两张表：设备签名 / 上位机签名+设备验签。

## 报告路径

```text
otp_patch/test_tools/sm2/sm2_report/
├── sm2_keypair_report.md
├── sm2_crypt_report.md
├── sm2_key_import_report.md
└── sm2_sign_verify_report.md
```

`--out` 可以覆盖；WSL 下 `--out` 会自动转成 Windows 路径。

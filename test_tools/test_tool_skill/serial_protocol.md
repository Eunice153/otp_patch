# 串口协议与命令

## 1. 帧格式

```text
请求: 5A  CMD  LEN_H  LEN_L  DATA[LEN]
应答: 5A  CMD  STATUS  LEN_H  LEN_L  DATA[LEN]
```

- `SOF = 0x5A`
- `CMD`：命令码
- `LEN`：DATA 字节数，16 位大端
- `STATUS`：只有应答有；请求没有
- `CMD_MAX_DATA = 512`（`cmd_uart.h`）

### 512B 上限

普通命令单帧 DATA 最大 **512B**，这是固件命令缓冲区的限制，
不是 UART 硬件能力。超过 512B 时，普通帧层直接丢弃，不应答。

大数据改用 NO3 的 `0x40`/`0x41`：

- 4 字节 LEN 的逻辑大帧；
- 最大 128KB；
- 上位机可以拆成 n 次串口 write；
- SM3 流式 `0x1A/0x1B/0x1C` 已删除。

接收端不要假设“一次 read 就是一帧”：先读 5 字节应答头，再按 LEN
读 DATA；UART 分多次送来由状态机累积。

## 2. 状态码

| 值 | 含义 |
|---|---|
| `0x00` | 成功 |
| `0x01` | 帧错误 |
| `0x02` | 未知命令 |
| `0x03` | 数据过长 |
| `0xFD` | 无权限/未授权 |
| `0xFE` | 参数/状态非法 |
| `0xFF` | 通用错误 |

`SM2_VERIFY` 验签失败时 `STATUS=0x00`，结果字节为 `0x00`；
验签成功结果字节为 `0x01`。

## 3. 命令表

| 命令 | 值 | 说明 |
|---|---|---|
| `PING` | `0x01` | 连通性 |
| `AUTH` | `0x02` | 会话认证 |
| `LOGOUT` | `0x03` | 清会话 |
| `GET_INFO` | `0x04` | 版本/认证状态 |
| `SET_PASSWORD` | `0x05` | **写 OTP，测试脚本禁用** |
| `CHECK_PASSWORD` | `0x06` | 校验口令 |
| `SM3` | `0x10` | 单帧 SM3，≤512B |
| `GENKEY` | `0x11` | 生成临时密钥 3/4/5 |
| `GETPUBKEY` | `0x12` | 读公钥 64B |
| `EXPORT_KEY` | `0x13` | 通用密钥导出（固件旧名 `SM4_EXPORT`） |
| `KEY_IMPORT` | `0x14` | 导入密钥到临时槽 3/4/5 |
| `LOAD_PUBKEY` | `0x15` | 设置导出包裹用公钥（RAM） |
| `KEY_STORE` | `0x16` | **写 OTP，测试脚本禁用** |
| `KEY_LOAD` | `0x17` | 从 OTP 加载到 SRAM（只读） |
| `KEY_DESTROY` | `0x18` | **销毁 OTP 密钥，测试脚本禁用** |
| `SM4_CRYPT` | `0x20` | SM4 ECB/CBC |
| `SM4_BULK` | `0x40` | NO3 大数据 SM4，4B 长度，≤128KB |
| `SM3_BULK` | `0x41` | NO3 大数据 SM3，4B 长度，≤128KB |
| `SM2_ENC` | `0x23` | SM2 加密 |
| `SM2_DEC` | `0x24` | SM2 解密 |
| `SM2_SIGN` | `0x30` | SM2 签名 |
| `SM2_VERIFY` | `0x31` | SM2 验签 |
| `SELFTEST` | `0x50` | 指令自检 |
| `GET_UID` | `0x60` | 读取芯片 ID |

## 4. SM2 命令 payload

### GENKEY

```text
请求: [id]
id: 3 = 临时解密槽, 4 = 临时签名槽, 5 = 临时 SM4 槽
应答: LEN=0
```

OTP 槽 0/1/2 不能 GENKEY；`h_genkey` 会拒绝。

### GETPUBKEY

```text
请求: [id]
应答: 64B 公钥 (X 32B || Y 32B)
```

### EXPORT_KEY（固件旧名 SM4_EXPORT）

```text
请求: [id, std]
id: 0..5
std: 1 = 标准模式
应答: 64B C1 || 32B C3 || key_len
      SM2 密钥 key_len=32 -> 128B
      SM4 密钥 key_len=16 -> 112B
```

这是**通用密钥导出**，不是 SM4 加密。SM2 槽 3/4 也用它导出
32B 私钥，返回 128B。导出前需要 `LOAD_PUBKEY` 设置包裹公钥。

### LOAD_PUBKEY

```text
请求: 64B 公钥
应答: LEN=0
```

只写 RAM，不改 OTP。

### KEY_IMPORT

```text
请求: [target, dec_id, std] + ct
target: 3/4/5（临时槽）
dec_id: 0/1（OTP SM2 解密/签名槽，用于解开包裹）
std: 1
ct: 64B C1 || 32B C3 || key_len
应答: LEN=0
```

只写临时槽 target，不写 OTP。需要芯片已有对应 OTP 密钥；
没有时导入会失败/拒绝。

### SM2_ENC

```text
请求: [std] + pub(64) + k(32) + pt
应答: C1(64) + C3(32) + C2(pt_len)
```

### SM2_DEC

```text
请求: [id, std, pt_len_H, pt_len_L] + ct
id: 0 = OTP 解密槽, 3 = 临时解密槽
pt_len: 1..64（ROM 栈帧限制）
ct: 64B C1 || 32B C3 || pt_len
应答: 明文 pt_len
```

### SM2_SIGN

```text
请求: [id] + digest(32) + k(32)
id: 1 = OTP 签名槽, 4 = 临时签名槽
应答: 64B 签名 (r 32B || s 32B)
```

### SM2_VERIFY

```text
请求: pub(64) + digest(32) + sig(64)
应答: 1B，0x01=通过，0x00=失败；STATUS 仍为 0x00
```

### SELFTEST

```text
请求: 可选 [mask_H, mask_L]
      不传时固件使用 mask=0xFFFF
应答: 4B 大端 result，bit=0 表示该项通过：
  bit0 TRNG
  bit1 SM3 KAT
  bit2 SM4 KAT
  bit3 SM2 KAT
```

SELFTEST 只使用 RAM 临时槽，不写 OTP。

### GET_UID

```text
请求: [type]
  type 0: OTP 0x170 起始 8 字节唯一标识
  type 1: OTP 0x00 起始 8 字节生产信息
应答: 8B ID
```

GET_UID 只读 OTP，不写 OTP。

## 5. SM3

### 单帧

```text
0x10 + DATA[LEN]  (LEN ≤512)
应答: 32B 摘要
```

### 0x41 大数据（仅 NO3）

```text
请求: 5A 41 LEN0 LEN1 LEN2 LEN3 DATA[LEN]
应答: 5A 41 STATUS LEN0 LEN1 LEN2 LEN3 32B 摘要
```

- LEN 是 data 字节数，4 字节大端，范围 0..131072。
- 固件收齐后调用一次 `Invoke_SM3_cal`。
- 主机可以拆成 n 次 write，应答可以分 n 次 read。
- 流式 0x1A/0x1B/0x1C 已删除。

## 6. SM4

### SM4_CRYPT

```text
请求: [id, mode, op] + [IV] + DATA
id:   2 = OTP SM4 槽, 5 = 临时 SM4 槽
mode: 0 = ECB, 1 = CBC
op:   0 = 加密, 1 = 解密
IV:   CBC 时必须有 16B
DATA: 必须是 16B 的正整数倍
应答: 与 DATA 等长的密文/明文
```

限制：

- 单帧 DATA ≤512B；ECB 参数占 3B，CBC 参数 3B + IV 16B，
  所以单帧明文最大 480B（16 的倍数）。
- 硬件 `SM4_CALC_LEN` 实际只有 1 bit；OTP patch 的
  `SM4_enc_dec_process` 已按 16B 逐块调用，支持多块。
- `id=2` 需要 AUTH 或临时口令；测试脚本只用 `id=5`。

### 大数据 0x40 / 0x41（仅 NO3）

NO3 增加“一个逻辑大帧”的 SM4/SM3 命令，使用 **4 字节长度**，
和其他命令的 2 字节长度不同：

```text
请求: 5A CMD LEN0 LEN1 LEN2 LEN3 PAYLOAD[LEN]
应答: 5A CMD STATUS LEN0 LEN1 LEN2 LEN3 DATA[LEN]
```

`0x40 SM4_BULK` 的 PAYLOAD 和原 `0x20` 一致：

```text
[id, mode, op]
+ 可选 [pwd_len][口令 12~32B]
+ CBC 时 16B IV
+ data（16 的正整数倍，最大 131072B）
id:   5=临时槽，2=OTP 槽（需先 AUTH）
mode: 0=ECB，1=CBC；bit7=1 表示带临时口令
op:   0=加密，1=解密
```

`0x41 SM3_BULK` 的 PAYLOAD 就是 SM3 原始数据（0..131072B），
应答 32B 摘要。

- 固件用 128KB 输入 + 128KB 输出静态缓冲，收齐后一次处理。
- 上位机可以把整个请求拆成任意 n 次串口 write，也可以分 n 次
  read 收应答；中间没有帧头、偏移或 ACK。
- SM4 CBC 的 IV 由上位机按原 0x20 方式提供；应答与 data 等长。
- 只需临时槽时不用口令；OTP 槽 2 需要先 AUTH，且只读加载。
- 0x40/0x41 不写 OTP。

`0x20 SM4_CRYPT` 仍然保留，适合 ≤480B 的小数据。

## 7. 报告约定

SM2 脚本默认输出：

```text
otp_patch/test_tools/sm2/sm2_report/
```

- `sm2_keypair_report.md`
- `sm2_crypt_report.md`
- `sm2_key_import_report.md`
- `sm2_sign_verify_report.md`

SM3 脚本默认输出：

```text
otp_patch/test_tools/sm3/sm3_report/
```

- `sm3_oneshot_report.md`
- `sm3_oneshot_41_report.md`
- `sm3_abnormal_report.md`
- `sm3_abnormal_41_report.md`

SM4 脚本默认输出：

```text
otp_patch/test_tools/sm4/sm4_report/
```

- `sm4_key_report.md`
- `sm4_ecb_report.md`
- `sm4_cbc_report.md`
- `sm4_abnormal_report.md`
- `sm4_key_import_report.md`

其他：

```text
otp_patch/test_tools/指令自检/selftest_report.md
otp_patch/test_tools/读取id/get_uid_report.md
```

脚本的 `--out` 可覆盖；WSL 下会自动转成 Windows 路径。

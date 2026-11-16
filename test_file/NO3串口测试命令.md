# NO3 串口测试命令

参考：

- `../file/otp/otp_要求/串口命令接口清单.md`
- `../file/otp/otp_要求/串口命令测试顺序.md`
- `../file/otp/otp_要求/串口命令接口验证文档.md`
- `../file/otp/otp_要求/空片验证流程.md`

适用固件：

```text
otp_main_only_full_test_uart_NO3
```

串口：

```text
UART1，115200 / 8N1，TX=PN04，RX=PN03
```

> 以下路径均相对于 `otp_patch` 目录；命令默认在 `otp_patch` 下执行。

> 本文是给客户的完整命令表，包含 OTP 读、写、销毁相关命令的格式。
>
> ⚠ 标记的命令会写 OTP 或销毁 OTP，常规测试不要发送；
> 只在产线或客户明确授权时执行。本文其余命令只用 RAM 临时槽，不写 OTP。
>
> SM3 统一用 `0x41`，SM4 统一用 `0x40`；短 SM3/SM4 不在本文范围。

---

## 1. 发送方式

### 1.1 小命令

PING、GET_INFO、GET_UID、AUTH、GENKEY、GETPUBKEY、KEY_STORE、
KEY_LOAD、KEY_DESTROY、SM2、SELFTEST 等：

- 串口工具用 **HEX 发送、HEX 显示**
- 帧格式：

```text
请求：5A | CMD | LEN_H | LEN_L | DATA
应答：5A | CMD | STATUS | LEN_H | LEN_L | DATA
```

- LEN 是 DATA 字节数，大端，最大 512B
- LEN 必须和实际 DATA 完全一致
- DATA 可以为 0B（LEN=0000）
- 口令按原始字节发送，不带结尾 `'\0'`

### 1.2 大数据命令 0x40 / 0x41

它们不是 2 字节 LEN，而是 **4 字节 LEN**：

```text
请求：5A | CMD | LEN0 | LEN1 | LEN2 | LEN3 | DATA
应答：5A | CMD | STATUS | LEN0 | LEN1 | LEN2 | LEN3 | DATA
```

- 0x41 的 DATA 最大 131072B（128KB）
- 0x40 的 DATA = 3B 参数 + 可选口令 + 可选 IV + 数据，
  数据部分最大 131072B
- 0x40 头部最多 `3 + 1 + 32 + 16 = 52B`，所以 0x40 的 LEN 最大为 131124B
- 上位机可以一次 write，也可以拆 n 次 write
- 固件收齐 LEN 后只处理一次，收完只回一帧
- 上位机也可以分 n 次 read 接收应答
- 不能再用 2 字节 LEN 的格式发 0x40/0x41

### 1.3 长度错误和异常帧行为

| 情况 | 设备行为 |
|---|---|
| LEN 比实际 DATA 大 | 继续等剩余字节；超时后丢弃，无应答 |
| LEN 比实际 DATA 小 | 多余字节被当成下一帧内容，可能吞掉下一帧 |
| 普通命令 LEN > 512 | 状态机直接丢弃，无应答 |
| 0x41 LEN > 131072 | 0x41 处理函数返回 `0xFE`（LEN 最大可收到 131124） |
| 0x40/0x41 LEN > 131124 | 帧层直接丢弃，无应答 |
| 未知 CMD | 返回 `0x02` |
| 帧头/长度字段损坏 | 当前实现直接丢弃并重新找 `0x5A`，不返回 `0x01` |

- 普通帧半帧超时：`CMD_FRAME_GAP_CNT = 200000`
- 大数据帧半帧超时：`CMD_BULK_GAP_CNT = 50000000`

128KB 不建议在串口助手里手工粘贴，直接用本文后面的 Python 脚本。

---

## 2. 状态码

| STATUS | 含义 |
|---|---|
| `00` | 成功 |
| `FF` | 通用错误（-1） |
| `FE` | id/参数/长度非法（-2） |
| `FD` | 权限不足/口令错误（-3） |
| `FC` | 解密/验签失败（-4） |
| `FB` | 保留（-5） |
| `FA` | OTP 损坏（-6） |
| `F9` | 槽位/密码已存在（-7） |
| `F8` | 槽位/密码未设置（-8） |
| `01` | 帧错误（协议保留，当前不主动返回） |
| `02` | 未知命令 |
| `03` | 数据/应答超长 |

STATUS 是 `int8_t` 补码：`-3` 发送为 `0xFD`，`-8` 发送为 `0xF8`。

---

## 3. 密钥槽

| ID | 名称 | 存储 | 使用方式 |
| --- | --- | --- | --- |
| 0 | OTP SM2 解密密钥 | OTP | `KEY_LOAD(0)` 只读加载 |
| 1 | OTP SM2 签名密钥 | OTP | `KEY_LOAD(1)` 只读加载 |
| 2 | OTP SM4 密钥 | OTP | `KEY_LOAD(2)` 只读加载 |
| 3 | 临时 SM2 解密密钥 | RAM | `GENKEY(3)` |
| 4 | 临时 SM2 签名密钥 | RAM | `GENKEY(4)` |
| 5 | 临时 SM4 密钥 | RAM | `GENKEY(5)` |

`KEY_STORE` 的固化对应关系：

```text
临时槽 3 -> OTP 槽 0
临时槽 4 -> OTP 槽 1
临时槽 5 -> OTP 槽 2
```

- 临时槽复位后丢失
- OTP 槽 0/1/2 不能用 `GENKEY` 直接生成；必须先 `GENKEY(3/4/5)`
  生成临时密钥，再 `KEY_STORE(3/4/5)` 写入
- OTP 槽必须先用 `KEY_LOAD` 加载到 SRAM，SM2/SM4 才能使用
- 空片没有口令时，`AUTH`/`CHECK_PASSWORD` 返回 `0xF8`

---

## 4. 建议测试顺序

```text
1. PING / GET_INFO / GET_UID
2. SELFTEST
3. AUTH / LOGOUT / CHECK_PASSWORD
4. SM2 临时密钥：GENKEY / GETPUBKEY / SM2_ENC / SM2_DEC / SM2_SIGN / SM2_VERIFY
5. SM4 0x40：GENKEY(5) / ECB / CBC
6. SM3 0x41
7. 密钥导入（需要 OTP 密钥时）
8. OTP 写/销毁命令（仅产线授权时）
9. 速率/异常测试（可选）
```

### 4.1 命令覆盖表

| CMD | 命令 | 本文是否包含 |
|---|---|---|
| `0x01` | PING | 是 |
| `0x02` | AUTH | 是 |
| `0x03` | LOGOUT | 是 |
| `0x04` | GET_INFO | 是 |
| `0x05` | SET_PASSWORD | 是 ⚠ 写 OTP |
| `0x06` | CHECK_PASSWORD | 是 |
| `0x11` | GENKEY | 是 |
| `0x12` | GETPUBKEY | 是 |
| `0x13` | EXPORT_KEY | 是 |
| `0x14` | KEY_IMPORT | 是（只写临时槽） |
| `0x15` | LOAD_PUBKEY | 是 |
| `0x16` | KEY_STORE | 是 ⚠ 写 OTP |
| `0x17` | KEY_LOAD | 是（只读） |
| `0x18` | KEY_DESTROY | 是 ⚠ 销毁 OTP |
| `0x23` | SM2_ENC | 是 |
| `0x24` | SM2_DEC | 是 |
| `0x30` | SM2_SIGN | 是 |
| `0x31` | SM2_VERIFY | 是 |
| `0x40` | SM4_BULK | 是 |
| `0x41` | SM3_BULK | 是 |
| `0x50` | SELFTEST | 是 |
| `0x60` | GET_UID | 是 |

说明：

- `0x21/0x22` SM4-GCM 只有宏定义，未注册到命令表，发送返回 `0x02`
- `0x1A/0x1B/0x1C` SM3 流式已从固件删除
- `0x40/0x41` 只对 NO3 固件有效，NO2 没有这两个命令

### 4.2 命令总表

| CMD | 名称 | 请求 DATA | 应答 DATA | 鉴权 / OTP |
| --- | --- | --- | --- | --- |
| `0x01` | PING | 无 | 无 | 无 |
| `0x02` | AUTH | 口令 12~32B | 无 | 无 |
| `0x03` | LOGOUT | 无 | 无 | 清除会话 |
| `0x04` | GET_INFO | 无 | 4B | 无 |
| `0x05` | SET_PASSWORD | 口令 12~32B | 无 | ⚠ 写 OTP |
| `0x06` | CHECK_PASSWORD | 口令 12~32B | 无 | 不建立会话 |
| `0x11` | GENKEY | id 1B（3/4/5） | 无 | 只写 RAM |
| `0x12` | GETPUBKEY | id 1B（0/1/3/4） | 公钥 64B | OTP 槽需先 KEY_LOAD |
| `0x13` | EXPORT_KEY | id 1B + std 1B | 112B 或 128B | 需先 LOAD_PUBKEY |
| `0x14` | KEY_IMPORT | target + dec_id + std + 密文 | 无 | 只写临时槽 3/4/5 |
| `0x15` | LOAD_PUBKEY | 公钥 64B | 无 | 只写 SRAM |
| `0x16` | KEY_STORE | id 1B（3/4/5）[+ 口令] | 无 | ⚠ 写 OTP，需口令 |
| `0x17` | KEY_LOAD | id 1B（0/1/2）[+ 口令] | 无 | 只读 OTP，需口令 |
| `0x18` | KEY_DESTROY | id 1B（0..5）[+ 口令] | 无 | ⚠ 销毁 OTP，需口令 |
| `0x23` | SM2_ENC | std + 公钥 64B + k 32B + 明文 | 密文 96+pt_len | 无 |
| `0x24` | SM2_DEC | id + std + pt_len + 密文 [+ 口令] | 明文 | OTP id=0 需口令 |
| `0x30` | SM2_SIGN | id + digest 32B + k 32B [+ 口令] | 签名 64B | OTP id=1 需口令 |
| `0x31` | SM2_VERIFY | 公钥 64B + digest 32B + sig 64B | 结果 1B | 无 |
| `0x40` | SM4_BULK | id + mode + op [+ 口令] [+ IV] + data | 与 data 等长 | OTP id=2 需口令 |
| `0x41` | SM3_BULK | data（0..131072B） | 摘要 32B | 无 |
| `0x50` | SELFTEST | mask 2B（可选） | result 4B | 无，只用 RAM |
| `0x60` | GET_UID | type 1B | UID 8B | 只读 OTP |

---

## 5. 链路与信息命令

### 5.1 PING（0x01）

发送：

```text
5A 01 00 00
```

应答：

```text
5A 01 00 00 00
```

用途：确认串口链路和固件在线。

### 5.2 GET_INFO（0x04）

发送：

```text
5A 04 00 00
```

应答：

```text
5A 04 00 00 04 01 00 00 00
```

DATA 4B：

```text
DATA[0] = 协议版本，当前 01
DATA[1] = 会话状态：00 未 AUTH，01 已 AUTH
DATA[2] = 保留 00
DATA[3] = 保留 00
```

### 5.3 GET_UID（0x60）

type 0（OTP 0x170 起 8B UID）：

```text
发送：5A 60 00 01 00
应答：5A 60 00 00 08 + 8B UID
```

type 1（OTP 0x00 起 8B 生产信息）：

```text
发送：5A 60 00 01 01
应答：5A 60 00 00 08 + 8B
```

- type 0/1 都只读 OTP
- 其它 type 返回 `0xFE`
- 空片 type 0 返回 8 个 `FF` 是正常现象

命令行：

```bash
python3 test_tools/读取id/get_uid.py COM24 --type all
python3 test_tools/读取id/get_uid.py COM24 --type 0
python3 test_tools/读取id/get_uid.py COM24 --type 1
```

报告：

```text
test_tools/读取id/get_uid_report.md
```

### 5.4 未知命令

发送未注册的 CMD（例如 `5A 21 ...`）返回：

```text
5A <CMD> 02 00 00
```

即 STATUS=`0x02`，无 DATA。

---

## 6. SELFTEST（0x50）

发送默认 mask：

```text
5A 50 00 00
```

或指定 mask：

```text
5A 50 00 02 00 0F
```

预期：

```text
5A 50 00 00 04 00 00 00 00
```

result=0x00000000 表示：

```text
bit0 TRNG OK
bit1 SM3 KAT OK
bit2 SM4 KAT OK
bit3 SM2 KAT OK
```

单项失败时 result：

```text
TRNG = 00 00 00 01
SM3  = 00 00 00 02
SM4  = 00 00 00 04
SM2  = 00 00 00 08
```

组合失败按 bit 或，例如 `00 00 00 05` = TRNG + SM4 失败。
result 是位图，不是错误码。

- 不传 DATA 时固件使用 mask=0xFFFF
- mask 中为 0 的位不执行，结果位也不置位
- SELFTEST 只使用 RAM 临时槽，不写 OTP

命令行：

```bash
python3 test_tools/指令自检/selftest.py COM24
python3 test_tools/指令自检/selftest.py COM24 --mask 0x0000 --timeout 5
python3 test_tools/指令自检/selftest.py COM24 --mask 0x0001
python3 test_tools/指令自检/selftest.py COM24 --mask 0x0002
python3 test_tools/指令自检/selftest.py COM24 --mask 0x0004
python3 test_tools/指令自检/selftest.py COM24 --mask 0x0008
python3 test_tools/指令自检/selftest.py COM24 --mask 0x000F
```

报告：

```text
test_tools/指令自检/selftest_report.md
```

无应答时先复位，再单项定位，不要连续重复发送。

---

## 7. 口令与会话命令

### 7.1 口令规则与鉴权方式

口令长度：

```text
12~32 字节，按字节计，不能包含 0x00
```

需要口令的命令支持两种方式：

1. **会话方式**：先 `AUTH`，后续命令不带口令，设备使用会话口令
2. **临时口令方式**：命令 DATA 末尾直接追加 12~32B 口令，只对本次命令有效

规则：

- 既没有 AUTH，也没有临时口令 → `0xFD`
- 带临时口令时，不改变会话状态
- 请求里同时有会话和临时口令时，以请求里的临时口令为准
- 追加口令长度不在 12~32 → `0xFE`

需要口令的命令：

| CMD | 命令 | 基本 DATA | 临时口令追加位置 |
| --- | --- | --- | --- |
| `0x16` | KEY_STORE | `id` | `id + pwd` |
| `0x17` | KEY_LOAD | `id` | `id + pwd` |
| `0x18` | KEY_DESTROY | `id` | `id + pwd` |
| `0x24` | SM2_DEC | `id + std + pt_len + 密文` | 末尾追加 `pwd` |
| `0x30` | SM2_SIGN | `id + digest + k` | 末尾追加 `pwd` |
| `0x40` | SM4_BULK | `id + mode + op + ...` | `mode.bit7=1` + `pwd_len + pwd` |

示例口令：

```text
Abcd1234Efghijkm
= 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

### 7.2 AUTH（0x02）

```text
发送：5A 02 00 10 + 16B 口令
应答：5A 02 00 00 00
```

- 成功后设备保存会话口令，GET_INFO 的 DATA[1] 变为 `01`
- 口令错误：`0xFD`
- OTP 未设置口令（空片）：`0xF8`
- 口令长度非法：`0xFE`
- AUTH 不写 OTP

### 7.3 LOGOUT（0x03）

```text
发送：5A 03 00 00
应答：5A 03 00 00 00
```

清空会话口令和鉴权状态。LOGOUT 本身不要求先 AUTH。

### 7.4 CHECK_PASSWORD（0x06）

```text
发送：5A 06 00 10 + 16B 口令
应答：5A 06 00 00 00
```

- 只校验口令，不建立会话，不改变当前会话状态
- 口令错误：`0xFD`
- OTP 未设置口令（空片）：`0xF8`

### 7.5 SET_PASSWORD（0x05）⚠ 写 OTP

用途：给空片设置 OTP 口令，属于产线一次性操作。

```text
发送：5A 05 00 10 + 16B 口令
应答：5A 05 00 00 00
```

DATA：

```text
口令 12~32B
```

状态：

| STATUS | 含义 |
|---|---|
| `00` | 设置成功 |
| `F9` | 密码已经存在，不能重复设置 |
| `FE` | 口令长度非法 |
| `FA` | OTP 损坏 |
| `FF` | 其它错误 |

安全说明：

- `SET_PASSWORD` 会在 OTP 中写入口令，成功后不能通过复位清除
- 开启后，任何能访问串口的人都可以认领空片
- 当前测试固件 `CMD_ENABLE_SET_PASSWORD=1`；正式/产线版本建议关闭
- 常规测试不要发送此命令

---

## 8. SM2 测试

### 8.1 生成临时密钥（0x11 GENKEY）

```text
GENKEY(3)：5A 11 00 01 03
GENKEY(4)：5A 11 00 01 04
```

应答：

```text
5A 11 00 00 00
```

- id 只允许 `3/4/5`
- `3` = 临时 SM2 解密私钥
- `4` = 临时 SM2 签名私钥
- `5` = 临时 SM4 密钥
- OTP 槽 `0/1/2` 不能生成，返回 `0xFE`
- GENKEY 只写 RAM，不写 OTP

### 8.2 读公钥（0x12 GETPUBKEY）

```text
GETPUBKEY(3)：5A 12 00 01 03
GETPUBKEY(4)：5A 12 00 01 04
```

应答：

```text
5A 12 00 00 40 + 64B 公钥
```

- id 支持 `0/1/3/4`
- 公钥格式：`X(32B) || Y(32B)`，大端
- OTP 槽 0/1 需要先用 `KEY_LOAD(0/1)` 加载到 SRAM，否则返回 `0xF8`
- 临时槽 3/4 需要先 `GENKEY(3/4)`

### 8.3 加载包裹公钥（0x15 LOAD_PUBKEY）

```text
发送：5A 15 00 40 + 64B 公钥
应答：5A 15 00 00 00
```

- 只写 SRAM，不写 OTP
- DATA 必须正好 64B，否则返回 `0xFE`
- `EXPORT_KEY` 前必须先执行此命令

### 8.4 导出密钥（0x13 EXPORT_KEY）

DATA：

```text
[id][std]
```

示例：

```text
EXPORT_KEY(3,1)：5A 13 00 02 03 01
EXPORT_KEY(4,1)：5A 13 00 02 04 01
EXPORT_KEY(5,1)：5A 13 00 02 05 01
```

应答长度：

```text
id=2/5（SM4 密钥 16B）：0x40 + 0x20 + 16 = 112B，LEN=0x70
id=3/4（SM2 私钥 32B）：0x40 + 0x20 + 32 = 128B，LEN=0x80
```

前置条件：

- 已通过 `LOAD_PUBKEY` 加载包裹公钥
- 密钥槽非空
- id=2（OTP SM4）需先用 `KEY_LOAD(2)` 加载到 SRAM

说明：`EXPORT_KEY` 是 0x13，历史名字叫 `SM4_EXPORT`，实际是通用密钥导出，
不是 SM4 加密。

### 8.5 SM2_ENC（0x23）

DATA：

```text
[std 1B] + [public 64B] + [k 32B] + [明文]
```

请求：

```text
5A 23 + LEN + std + pub64 + k32 + pt
```

应答：

```text
5A 23 00 + LEN + C1(64) + C3(32) + C2(pt_len)
```

约束：

```text
明文长度 1..415B
应答密文长度 = 96 + pt_len
```

- `std` 为 1 表示标准模式，0 表示非标准模式
- `k` 由上位机传入
- 明文过长导致密文超过 512B 时返回 `0x03`

### 8.6 SM2_DEC（0x24）

DATA：

```text
[id] + [std] + [pt_len_H] + [pt_len_L] + C1(64) + C3(32) + C2(pt_len)
```

请求：

```text
5A 24 + LEN + id + std + pt_len + 密文
```

应答：

```text
5A 24 00 + LEN + 明文
```

约束：

```text
id 只能是 0（OTP）或 3（临时）
pt_len 必须是 1..64
密文长度 = 96 + pt_len
id=0 可在末尾追加 12~32B 临时口令
id=3 不允许追加口令
```

- 明文最大 64B，这是 ROM `boot_sm2_decrypt` 固定栈帧的限制
- `pt_len > 64` 返回 `0xFE`
- id=0 且既未 AUTH、也没带临时口令 → `0xFD`

### 8.7 SM2_SIGN（0x30）

DATA：

```text
[id] + [digest 32B] + [k 32B]
```

请求：

```text
5A 30 00 41 + id + digest + k
```

应答：

```text
5A 30 00 00 40 + 64B 签名
```

约束：

```text
id 只能是 1（OTP）或 4（临时）
digest 是 32B 摘要，不是原文
id=1 可在末尾追加 12~32B 临时口令
id=4 不允许追加口令
```

- id=1 且既未 AUTH、也没带临时口令 → `0xFD`
- 签名格式：`r(32B) || s(32B)`

### 8.8 SM2_VERIFY（0x31）

DATA：

```text
[pub 64B] + [digest 32B] + [sig 64B]
```

请求：

```text
5A 31 00 A0 + pub + digest + sig
```

应答：

```text
5A 31 00 00 01 + 结果
```

结果：

```text
01 = 验签通过
00 = 验签失败
```

- DATA 必须正好 160B（LEN=0x00A0）
- 验签失败时 STATUS 仍为 `0x00`，由结果字节区分

### 8.9 SM2 命令行与报告

```bash
python3 test_tools/sm2/sm2密钥对生成/sm2_keypair.py COM24
python3 test_tools/sm2/sm2加解密/sm2_crypt.py COM24
python3 test_tools/sm2/sm2签名验签/sm2_sign_verify.py COM24
python3 "test_tools/sm2/sm2加解密密钥导入/sm2_key_import.py" COM24
```

报告：

```text
test_tools/sm2/sm2_report/sm2_keypair_report.md
test_tools/sm2/sm2_report/sm2_crypt_report.md
test_tools/sm2/sm2_report/sm2_sign_verify_report.md
test_tools/sm2/sm2_report/sm2_key_import_report.md
```

---

## 9. SM4 大数据 0x40

前置：生成临时槽 5 密钥：

```text
发送：5A 11 00 01 05
应答：5A 11 00 00 00
```

临时槽复位后丢失，重新跑前再发一次 GENKEY(5)。

### 9.1 帧格式

```text
请求：5A 40 LEN0 LEN1 LEN2 LEN3
      [id] [mode] [op]
      [可选 pwd_len + 临时口令]
      [CBC 时 16B IV]
      data

应答：5A 40 STATUS LEN0 LEN1 LEN2 LEN3
      DATA
```

### 9.2 PAYLOAD 细节

```text
[id]     1B：2=OTP 槽（需口令），5=临时槽
[mode]   1B：低 7 位 0=ECB，1=CBC；bit7=1 表示后面带临时口令
[op]     1B：0=加密，1=解密
```

`mode.bit7=1` 时紧跟：

```text
[pwd_len 1B] + [口令 12~32B]
```

CBC 时再跟：

```text
[IV 16B]
```

最后是数据：

```text
data：16 的正整数倍，最大 131072B
```

应答 DATA 与输入 data 等长。

鉴权：

- id=5：不需要口令
- id=2：已 AUTH 时用会话口令；否则必须在 `mode.bit7=1` 中带临时口令
- id=2 且既未 AUTH、也没带口令 → `0xFD`
- id=2 会先执行 `KEY_LOAD(2)` 只读加载，不写 OTP

### 9.3 ECB 16B 示例

```text
发送：
5A 40 00 00 00 13
05 00 00
<16B 明文>

应答：
5A 40 00 00 00 00 10
<16B 密文>
```

### 9.4 CBC 16B 示例

IV 默认：

```text
00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
```

```text
发送：
5A 40 00 00 00 23
05 01 00
<16B IV>
<16B 明文>

应答：
5A 40 00 00 00 00 10
<16B 密文>
```

解密时把 op 改成 01，data 换成密文，IV 保持不变。

### 9.5 128KB ECB 示例

```text
PAYLOAD = 3B 参数 + 131072B 数据
LEN = 0x00020003 = 131075

发送：
5A 40 00 02 00 03
05 00 00
<131072B 数据>

应答：
5A 40 00 00 02 00 00
<131072B 结果>
```

### 9.6 128KB CBC 示例

```text
PAYLOAD = 3B 参数 + 16B IV + 131072B 数据
LEN = 0x00020013 = 131091

发送：
5A 40 00 02 00 13
05 01 00
<16B IV>
<131072B 数据>

应答：
5A 40 00 00 02 00 00
<131072B 结果>
```

128KB 用脚本发送，不要手工粘贴。

### 9.7 OTP 槽 2 示例

先 AUTH：

```text
发送：5A 02 00 10 + 16B 口令
```

再发 0x40：

```text
发送：
5A 40 00 00 00 13
02 00 00
<16B 明文>
```

或者不 AUTH，在 mode 中带临时口令：

```text
发送：
5A 40 00 00 00 24
02 80 00
10
<16B 口令>
<16B 明文>
```

`LEN=0x0024 = 36 = 3B 参数 + 1B pwd_len + 16B 口令 + 16B 数据`。

- `mode=0x80` 表示 ECB + 临时口令
- `mode=0x81` 表示 CBC + 临时口令
- 临时口令长度必须为 12~32B，且 `pwd_len` 与实际一致

### 9.8 命令行与报告

```bash
# 密钥生成（0x40）
python3 test_tools/sm4/sm4密钥生成/sm4_key_40.py COM24

# ECB / CBC 正确性
python3 test_tools/sm4/sm4ecb加解密/sm4_ecb_40.py COM24
python3 test_tools/sm4/sm4cbc加解密/sm4_cbc_40.py COM24

# 异常输入
python3 test_tools/sm4/sm4异常输入/sm4_abnormal_40.py COM24

# 128KB 大帧
python3 test_tools/sm4/sm4ecb加解密/sm4_ecb_40.py COM24 --lengths 131072
python3 test_tools/sm4/sm4cbc加解密/sm4_cbc_40.py COM24 --lengths 131072

# 速率
python3 test_tools/sm4/sm4ecb_speed/sm4_ecb_speed.py COM24
python3 test_tools/sm4/sm4cbc_speed/sm4_cbc_speed.py COM24
```

报告：

```text
test_tools/sm4/sm4_report/sm4_key_40_report.md
test_tools/sm4/sm4_report/sm4_ecb_40_report.md
test_tools/sm4/sm4_report/sm4_cbc_40_report.md
test_tools/sm4/sm4_report/sm4_abnormal_40_report.md
test_tools/sm4/sm4_report/sm4_bulk_report.md
test_tools/sm4/sm4_report/sm4_ecb_speed_report.md
test_tools/sm4/sm4_report/sm4_cbc_speed_report.md
test_tools/sm4/sm4_report/sm4_key_import_40_report.md
```

---

## 10. SM3 大数据 0x41

### 10.1 帧格式

```text
请求：5A 41 LEN0 LEN1 LEN2 LEN3 data
应答：5A 41 STATUS LEN0 LEN1 LEN2 LEN3 32B 摘要
```

- LEN 是 data 字节数，0..131072
- 没有 key/mode/op/IV
- 0x41 是 NO3 的逻辑大帧

### 10.2 小数据示例

SM3("abc")：

```text
发送：
5A 41 00 00 00 03 61 62 63

应答：
5A 41 00 00 00 00 20
66 C7 F0 F4 62 EE ED D9 D1 F2 D4 6B DC 10 E4 E2
41 67 C4 87 5C F2 F7 A2 29 7D A0 2B 8F 4B A8 E0
```

### 10.3 空消息示例

```text
发送：
5A 41 00 00 00 00

应答：
5A 41 00 00 00 00 20
1A B2 1D 83 55 CF A1 7F 8E 61 19 48 31 E8 1A 8F
22 BE C8 C7 28 FE FB 74 7E D0 35 EB 50 82 AA 2B
```

空消息是合法输入，LEN=0 时固件立即处理，不需要额外数据。

### 10.4 128KB 示例

```text
LEN = 0x00020000 = 131072

发送：
5A 41 00 02 00 00
<131072B 数据>

应答：
5A 41 00 00 00 00 20
<32B 摘要>
```

### 10.5 命令行与报告

```bash
python3 test_tools/sm3/sm3单帧/sm3_oneshot_41.py COM24
python3 test_tools/sm3/sm3异常输入/sm3_abnormal_41.py COM24
python3 test_tools/sm3/sm3_speed/sm3_speed.py COM24
```

报告：

```text
test_tools/sm3/sm3_report/sm3_oneshot_41_report.md
test_tools/sm3/sm3_report/sm3_abnormal_41_report.md
test_tools/sm3/sm3_report/sm3_speed_report.md
```

---

## 11. OTP 与密钥管理命令

本节命令涉及 OTP 密钥的固化、加载和销毁。`KEY_LOAD` 只读；
`KEY_STORE` 写 OTP；`KEY_DESTROY` 销毁 OTP；`KEY_IMPORT` 只写临时槽。

### 11.1 KEY_STORE（0x16）⚠ 写 OTP

用途：把临时槽 3/4/5 的密钥固化到 OTP 槽 0/1/2。

DATA：

```text
[id]
或
[id] + [口令 12~32B]
```

- id 只允许 `3/4/5`
- 对应关系：`3 -> 0`，`4 -> 1`，`5 -> 2`
- 不带口令时必须已 `AUTH`，使用会话口令
- 带口令时只对本次命令有效
- 既未 AUTH、也没带口令 → `0xFD`
- 口令错误 → `0xFD`
- OTP 槽已经有密钥 → `0xF9`
- 临时槽为空 → `0xF8`

示例（已 AUTH，固化临时槽 5 到 OTP 槽 2）：

```text
发送：5A 16 00 01 05
应答：5A 16 00 00 00
```

示例（不 AUTH，带 16B 临时口令）：

```text
发送：
5A 16 00 11
05
41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D

应答：5A 16 00 00 00
```

`LEN=0x0011 = 17 = 1B id + 16B 口令`。

⚠ KEY_STORE 是一次性 OTP 写入；重复固化同一槽返回 `0xF9`，不能用它覆盖。

### 11.2 KEY_LOAD（0x17）只读

用途：把 OTP 槽 0/1/2 的密钥加载到 SRAM，供 SM2/SM4 使用。

DATA：

```text
[id]
或
[id] + [口令 12~32B]
```

- id 只允许 `0/1/2`
- 不带口令时必须已 `AUTH`
- 既未 AUTH、也没带口令 → `0xFD`
- 口令错误 → `0xFD`
- OTP 槽为空 → `0xF8`
- 重复加载返回 `0x00`
- 只读 OTP，不修改 OTP

示例（已 AUTH，加载 OTP 槽 0）：

```text
发送：5A 17 00 01 00
应答：5A 17 00 00 00
```

示例（带 16B 临时口令）：

```text
发送：
5A 17 00 11
00
41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D

应答：5A 17 00 00 00
```

### 11.3 KEY_DESTROY（0x18）⚠ 销毁 OTP

用途：销毁 OTP 槽 0/1/2 的密钥，或清除临时槽 3/4/5。

DATA：

```text
[id]
或
[id] + [口令 12~32B]
```

- id 允许 `0..5`
- OTP 槽 0/1/2 销毁后不可恢复
- 临时槽 3/4/5 只清除 RAM，复位后本来也会丢失
- 不带口令时必须已 `AUTH`
- 既未 AUTH、也没带口令 → `0xFD`
- OTP 槽 0/1/2 口令错误 → `0xFD`
- 临时槽 3/4/5 不校验口令内容，但仍要求已 AUTH 或带口令
- 槽位为空 → `0xF8`

示例（已 AUTH，销毁 OTP 槽 2）：

```text
发送：5A 18 00 01 02
应答：5A 18 00 00 00
```

示例（带 16B 临时口令）：

```text
发送：
5A 18 00 11
02
41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D

应答：5A 18 00 00 00
```

⚠ OTP 槽销毁不可恢复；执行前必须确认槽号和授权。

### 11.4 KEY_IMPORT（0x14）

用途：用 OTP SM2 私钥解开包裹密钥，导入到临时槽 3/4/5。

DATA：

```text
[target] + [dec_id] + [std] + [包裹密文]
```

- target：`3/4/5`
- dec_id：`0/1`，使用对应 OTP SM2 私钥解密
- std：1=标准模式，0=非标准模式
- 包裹密文长度：
  - target=5：112B（SM4 密钥 16B）
  - target=3/4：128B（SM2 私钥 32B）

示例（SM4 导入临时槽 5）：

```text
LEN = 3 + 112 = 115 = 0x0073

发送：
5A 14 00 73
05 00 01
<112B 包裹密文>

应答：5A 14 00 00 00
```

示例（SM2 导入临时槽 3）：

```text
LEN = 3 + 128 = 131 = 0x0083

发送：
5A 14 00 83
03 00 01
<128B 包裹密文>

应答：5A 14 00 00 00
```

前置条件：

- dec_id 对应的 OTP SM2 密钥已用 `KEY_LOAD(dec_id)` 加载到 SRAM
- target 只能是临时槽 3/4/5，不能写入 OTP
- 空片或 OTP 密钥未配置时命令失败，不会写 OTP

### 11.5 OTP 命令执行前提

发送 `0x05`、`0x16`、`0x18` 前必须确认：

```text
1. 已获得产线/客户明确授权
2. 确认芯片处于空片或允许操作的状态
3. 确认槽号正确：KEY_STORE 只允许 3/4/5；KEY_DESTROY 允许 0..5
4. 确认口令为 12~32B
5. 确认操作不可撤销（SET_PASSWORD / KEY_STORE / KEY_DESTROY）
```

常规功能测试不发送这三条命令，只用临时槽 3/4/5。

### 11.6 命令行与报告

SM2 导入临时槽 3：

```bash
python3 "test_tools/sm2/sm2加解密密钥导入/sm2_key_import.py" COM24
```

SM4 导入临时槽 5：

```bash
python3 test_tools/sm4/sm4密钥导入导出/sm4_key_import_40.py COM24
```

报告：

```text
test_tools/sm2/sm2_report/sm2_key_import_report.md
test_tools/sm4/sm4_report/sm4_key_import_40_report.md
```

---

## 12. 安全红线

- `0x05 SET_PASSWORD`：写 OTP 口令，一次性，常规测试不发送
- `0x16 KEY_STORE`：把临时密钥固化到 OTP，一次性，常规测试不发送
- `0x18 KEY_DESTROY`：销毁 OTP 密钥，不可恢复，常规测试不发送
- `0x17 KEY_LOAD`：只读 OTP，不修改 OTP
- `0x14 KEY_IMPORT`：只写临时槽 3/4/5，不写 OTP
- 本文所有常规测试只使用临时槽 3/4/5
- 测试脚本禁止发送 `SET_PASSWORD`、`KEY_STORE`、`KEY_DESTROY`
- 失败时不要用写 OTP 的方式“修复”

---

## 13. 其他说明

- SM3 统一用 `0x41`，SM4 统一用 `0x40`
- SM3 流式 `0x1A/0x1B/0x1C` 已从固件删除
- `0x21/0x22` SM4-GCM 未实现，发送返回 `0x02`
- `0x40/0x41` 只对 NO3 固件有效；NO2 没有这两个命令
- 128KB 测试建议直接用 Python 脚本，不建议手工发送

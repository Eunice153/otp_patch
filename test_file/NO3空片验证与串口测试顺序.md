# NO3 空片验证与串口测试顺序（合并版）

> 适用固件：`otp_main_only_full_test_uart_NO3`
>
> 串口：UART1，115200 / 8N1，TX=PN04，RX=PN03
>
> 路径约定：以下路径均相对于 `otp_patch` 目录。
> 带 `cd otp_patch` 的代码块从 `ls_sdk` 仓库根目录执行；如果你已经在
> `otp_patch` 下，把该行去掉即可。
>
> **安全总则**
>
> - OTP 写入/销毁不可恢复，只能 `1 -> 0`。
> - OTP 相关操作统一放在文档后部：第 5.5 节是只读探测（建议最后做），
>   第 6 节是写操作，**默认跳过**；只在空片/报废样片、且明确授权时执行。
> - 常规验证只用 RAM 临时槽 3/4/5，不写 OTP。
> - 本文 SM3/SM4 手工验证只用 `0x41/0x40` 的小数据；128KB 大字节数据全部交给脚本。
>
> **复制粘贴说明**
>
> - 手工帧必须用串口工具的 **HEX 发送/HEX 显示**。
> - 没有尖括号 `<...>` 的帧是固定帧，可以直接复制粘贴。
> - 带 `<...>` 的帧是动态帧，必须用上一步应答的字节替换；想完全免手工，直接用第 0 节脚本。
> - 128KB 不要手工发送，统一用第 0.3 节脚本。
>
> **与原始文档的差异**
>
> - `0x1A/0x1B/0x1C` SM3 流式已从 NO3 固件删除，本文不再使用。
> - 大块 SM3 用 `0x41`，大块 SM4 用 `0x40`。
> - SM3/SM4 手工帧只验证小数据；128KB 用脚本。
> - `SM2_DEC` 明文最大 64B。
> - OTP 布局：口令 `0x280~0x2A0`，槽 0 `0x2A1~0x2C5`，
>   槽 1 `0x2C6~0x2EA`，槽 2 `0x2EB~0x2FF`。

---

## 0. 一键安全验证（不写 OTP）

### 0.1 运行前

1. 已烧 NO3 固件和 OTP patch。
2. 串口助手、烧写工具、其它 Python 脚本全部关闭，保证脚本能独占 COM 口。
3. 准备空片或已固化片均可；本节的脚本只用临时槽 3/4/5。

### 0.2 复制整段到终端

在 `ls_sdk` 仓库根目录执行；如果已经在 `otp_patch` 下，去掉 `cd otp_patch`。

```bash
cd otp_patch
PORT=COM24
python3 test_tools/指令自检/selftest.py "$PORT" &&
python3 test_tools/读取id/get_uid.py "$PORT" --type all &&
python3 test_tools/sm3/sm3单帧/sm3_oneshot_41.py "$PORT" &&
python3 test_tools/sm4/sm4密钥生成/sm4_key_40.py "$PORT" &&
python3 test_tools/sm4/sm4ecb加解密/sm4_ecb_40.py "$PORT" &&
python3 test_tools/sm4/sm4cbc加解密/sm4_cbc_40.py "$PORT" &&
python3 test_tools/sm2/sm2密钥对生成/sm2_keypair.py "$PORT" &&
python3 test_tools/sm2/sm2加解密/sm2_crypt.py "$PORT" &&
python3 test_tools/sm2/sm2签名验签/sm2_sign_verify.py "$PORT"
```

`&&` 表示上一条通过才继续。任何一条失败就停下来看第 9 节，
不要继续后面的破坏性 OTP 操作。

### 0.3 128KB 大数据脚本（小数据通过后再跑）

在 `ls_sdk` 仓库根目录执行；如果已经在 `otp_patch` 下，去掉 `cd otp_patch`。

```bash
cd otp_patch
PORT=COM24

# SM4 128KB ECB / CBC 正确性
python3 test_tools/sm4/sm4ecb加解密/sm4_ecb_40.py "$PORT" --lengths 131072
python3 test_tools/sm4/sm4cbc加解密/sm4_cbc_40.py "$PORT" --lengths 131072

# SM4 128KB 速率（可选）
python3 test_tools/sm4/sm4ecb_speed/sm4_ecb_speed.py "$PORT"
python3 test_tools/sm4/sm4cbc_speed/sm4_cbc_speed.py "$PORT"

# SM3 128KB 正确性 / 速率
python3 test_tools/sm3/sm3_speed/sm3_speed.py "$PORT"
```

说明：

- `sm3_oneshot_41.py` 默认已经包含 128KB 向量，所以第 0.2 节会顺带验证一次。
- 手工 HEX 只做小数据；128KB 不要手工粘贴。

### 0.4 报告位置

```text
test_tools/指令自检/selftest_report.md
test_tools/读取id/get_uid_report.md
test_tools/sm3/sm3_report/sm3_oneshot_41_report.md
test_tools/sm3/sm3_report/sm3_speed_report.md
test_tools/sm4/sm4_report/sm4_key_40_report.md
test_tools/sm4/sm4_report/sm4_ecb_40_report.md
test_tools/sm4/sm4_report/sm4_cbc_40_report.md
test_tools/sm4/sm4_report/sm4_ecb_speed_report.md
test_tools/sm4/sm4_report/sm4_cbc_speed_report.md
test_tools/sm2/sm2_report/sm2_keypair_report.md
test_tools/sm2/sm2_report/sm2_crypt_report.md
test_tools/sm2/sm2_report/sm2_sign_verify_report.md
```

报告是每次脚本运行的证据；128KB 报告只记录长度、摘要/哈希和应答头，
不会把 128KB 全量贴进 Markdown。

---

## 1. 链路与基础信息（不写 OTP）

> 本节命令不写 OTP。OTP 布局、空片探测和 OTP 写操作统一放到
> 第 5.5 节和第 6 节；建议先完成第 1~5 节不写 OTP 的测试。

### 1.1 PING（0x01）


发送：

```text
5A 01 00 00
```

预期：

```text
5A 01 00 00 00
```

### 1.2 GET_INFO（0x04）

发送：

```text
5A 04 00 00
```

预期：

```text
5A 04 00 00 04 01 00 00 00
```

DATA[1]=`00` 表示未登录；已 AUTH 时为 `01`。

### 1.3 GET_UID（0x60）

type 0（OTP `0x170` 起 8B UID）：

```text
5A 60 00 01 00
```

预期：

```text
5A 60 00 00 08 + 8B UID
```

type 1（OTP `0x00` 起 8B 生产信息）：

```text
5A 60 00 01 01
```

预期：

```text
5A 60 00 00 08 + 8B
```

空片 type 0 返回 8 个 `FF` 正常；type 1 可能有生产数据。

### 1.4 SELFTEST（0x50）

全项：

```text
5A 50 00 02 00 0F
```

预期：

```text
5A 50 00 00 04 00 00 00 00
```

单项：

| 项目 | 发送 | 通过 result | 失败 result | 失败含义 |
| --- | --- | --- | --- | --- |
| TRNG | `5A 50 00 02 00 01` | `00 00 00 00` | `00 00 00 01` | bit0=1，TRNG 自检失败 |
| SM3 | `5A 50 00 02 00 02` | `00 00 00 00` | `00 00 00 02` | bit1=1，SM3 KAT 失败 |
| SM4 | `5A 50 00 02 00 04` | `00 00 00 00` | `00 00 00 04` | bit2=1，SM4 KAT 失败 |
| SM2 | `5A 50 00 02 00 08` | `00 00 00 00` | `00 00 00 08` | bit3=1，SM2 KAT 失败 |

result 是 4 字节大端位图，bit=1 表示失败：

```text
bit0 = 0x00000001  TRNG
bit1 = 0x00000002  SM3 KAT
bit2 = 0x00000004  SM4 KAT
bit3 = 0x00000008  SM2 KAT
```

单项 mask 只会置对应一位，所以失败时 result 就是上表的固定值。
全项 mask `00 0F` 时是这四位按位或：

| result | 失败项 |
| --- | --- |
| `00 00 00 00` | 全部通过 |
| `00 00 00 01` | TRNG |
| `00 00 00 02` | SM3 |
| `00 00 00 04` | SM4 |
| `00 00 00 08` | SM2 |
| `00 00 00 03` | TRNG + SM3 |
| `00 00 00 05` | TRNG + SM4 |
| `00 00 00 06` | SM3 + SM4 |
| `00 00 00 07` | TRNG + SM3 + SM4 |
| `00 00 00 09` | TRNG + SM2 |
| `00 00 00 0A` | SM3 + SM2 |
| `00 00 00 0B` | TRNG + SM3 + SM2 |
| `00 00 00 0C` | SM4 + SM2 |
| `00 00 00 0D` | TRNG + SM4 + SM2 |
| `00 00 00 0E` | SM3 + SM4 + SM2 |
| `00 00 00 0F` | 四项全部失败 |

组合值就是对应 bit 相加。

失败时优先排查：

```text
bit0=1：TRNG 自检失败，优先查 TRNG 时钟/初始化/硬件状态
bit1=1：SM3 KAT 失败，优先查 SM3 引擎和 Invoke_SM3_cal 调用通路
bit2=1：SM4 KAT 失败，优先查 SM4 引擎和 Invoke_SM4_KAT 调用通路
bit3=1：SM2 KAT 失败，优先查 SM2 生成/签名/验签自洽性
```

判读注意：

- `STATUS` 正常固定为 `00`；如果 `STATUS` 不是 `00`，先按命令/帧错误处理，不要当成 KAT 失败。
- 单项 mask 却出现多个 bit，或出现未选择的 bit，优先怀疑串口帧错位、掩码发错、固件版本不对。
- `result` 不是错误码，不能把 `00 00 00 02` 当成某个“错误号”；它只表示 SM3 那一位失败。
- SM2 KAT 会重新生成临时槽 4，之前未固化的槽 4 密钥会被覆盖。
- 无应答时先复位，再用单项 mask 定位，不要连续重复发送。

---

## 2. SM3 0x41 小数据验证

0x41 帧格式：

```text
请求：5A 41 LEN0 LEN1 LEN2 LEN3 data
应答：5A 41 STATUS LEN0 LEN1 LEN2 LEN3 32B 摘要
```

- LEN 是原始数据字节数，0..131072
- LEN=0 是合法空消息
- 应答头是 7B：`5A 41 STATUS LEN0 LEN1 LEN2 LEN3`
- 摘要固定 32B

### 2.1 SM3("abc")

发送：

```text
5A 41 00 00 00 03 61 62 63
```

预期：

```text
5A 41 00 00 00 00 20
66 C7 F0 F4 62 EE ED D9 D1 F2 D4 6B DC 10 E4 E2
41 67 C4 87 5C F2 F7 A2 29 7D A0 2B 8F 4B A8 E0
```

### 2.2 SM3 空消息

发送：

```text
5A 41 00 00 00 00
```

预期：

```text
5A 41 00 00 00 00 20
1A B2 1D 83 55 CF A1 7F 8E 61 19 48 31 E8 1A 8F
22 BE C8 C7 28 FE FB 74 7E D0 35 EB 50 82 AA 2B
```

### 2.3 SM3("a")

发送：

```text
5A 41 00 00 00 01 61
```

预期：

```text
5A 41 00 00 00 00 20
62 34 76 AC 18 F6 5A 29 09 E4 3C 7F EC 61 B4 9C
7E 76 4A 91 A1 8C CB 82 F1 91 7A 29 C8 6C 5E 88
```

### 2.4 128KB

不要手工发送，使用脚本：

```bash
python3 test_tools/sm3/sm3_speed/sm3_speed.py COM24
```

`sm3_oneshot_41.py` 默认也会验证 128KB 向量：

```bash
python3 test_tools/sm3/sm3单帧/sm3_oneshot_41.py COM24
```

---

## 3. SM4 0x40 小数据验证

0x40 帧格式：

```text
请求：5A 40 LEN0 LEN1 LEN2 LEN3
      id mode op [pwd_len pwd] [IV] data
应答：5A 40 STATUS LEN0 LEN1 LEN2 LEN3 data
```

- id：`5`=临时槽，`2`=OTP 槽（需口令）
- mode：低 7 位 `0`=ECB，`1`=CBC；bit7=1 表示带临时口令
- op：`0`=加密，`1`=解密
- data：16 的正整数倍；小数据验证用 16B
- 应答 DATA 与输入 data 等长
- 应答头是 7B：`5A 40 STATUS LEN0 LEN1 LEN2 LEN3`

### 3.1 生成临时槽 5 密钥

发送：

```text
5A 11 00 01 05
```

预期：

```text
5A 11 00 00 00
```

临时槽复位后丢失，每次复位后都要重新 GENKEY(5)。

### 3.2 ECB 加密 16B

固定明文：

```text
00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

发送：

```text
5A 40 00 00 00 13 05 00 00 00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

预期：

```text
5A 40 00 00 00 00 10 + 16B 密文
```

记录这 16B 密文，下一步解密用。

### 3.3 ECB 解密 16B

把上一步的 16B 密文接在最后：

```text
5A 40 00 00 00 13 05 00 01 <上一步的 16B 密文>
```

预期：

```text
5A 40 00 00 00 00 10 00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

解密结果必须与 3.2 的明文逐字节一致。

### 3.4 CBC 加密 16B

固定 IV：

```text
00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
```

发送：

```text
5A 40 00 00 00 23 05 01 00
00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

实际发送时连成一行：

```text
5A 40 00 00 00 23 05 01 00 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

预期：

```text
5A 40 00 00 00 00 10 + 16B 密文
```

记录这 16B 密文，下一步解密用。

### 3.5 CBC 解密 16B

IV 必须与加密时相同：

```text
5A 40 00 00 00 23 05 01 01 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F <上一步的 16B 密文>
```

预期：

```text
5A 40 00 00 00 00 10 00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

### 3.6 128KB

不要手工发送，使用脚本：

```bash
python3 test_tools/sm4/sm4ecb加解密/sm4_ecb_40.py COM24 --lengths 131072
python3 test_tools/sm4/sm4cbc加解密/sm4_cbc_40.py COM24 --lengths 131072
```

### 3.7 临时口令格式（OTP 槽 2 用）

不 AUTH、直接带口令时，`mode.bit7=1`，后面跟 `pwd_len + pwd`：

```text
ECB：5A 40 <LEN4> 02 80 00 10 <16B 口令> <data>
CBC：5A 40 <LEN4> 02 81 00 10 <16B 口令> <16B IV> <data>
```

LEN 计算：

```text
ECB 16B data：3 + 1 + 16 + 16 = 36 = 0x00000024
CBC 16B data：3 + 1 + 16 + 16 + 16 = 52 = 0x00000034
```

空片阶段不需要这条；固化 OTP 槽 2 后再用。

---

## 4. SM2 临时密钥验证

### 4.1 生成并读取临时公钥

```text
5A 11 00 01 03      → 5A 11 00 00 00
5A 12 00 01 03      → 5A 12 00 00 40 + 64B 公钥（记录为 PUB3）

5A 11 00 01 04      → 5A 11 00 00 00
5A 12 00 01 04      → 5A 12 00 00 40 + 64B 公钥（记录为 PUB4）
```

### 4.2 SM2 加密（0x23）

DATA：

```text
std 1B + PUB3 64B + k 32B + 明文
```

固定测试数据：

```text
std = 01
k   = 00 × 31 + 01
明文 = 00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

发送：

```text
5A 23 00 71 01 <PUB3 64B> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

预期：

```text
5A 23 00 00 70 + 112B 密文（记录为 CT）
```

密文长度 = `96 + 明文长度`。

### 4.3 SM2 解密（0x24）

临时槽 3，明文长度 16：

```text
5A 24 00 74 03 01 00 10 <CT 112B>
```

预期：

```text
5A 24 00 00 10 00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

约束：

```text
id 只能是 3（临时）或 0（OTP）
pt_len 必须是 1..64
密文长度 = 96 + pt_len
```

### 4.4 SM2 签名（0x30）

临时槽 4，摘要全 0，k = `00 × 31 + 01`：

```text
5A 30 00 41 04
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
```

连成一行：

```text
5A 30 00 41 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
```

预期：

```text
5A 30 00 00 40 + 64B 签名（记录为 SIG）
```

### 4.5 SM2 验签（0x31）

```text
5A 31 00 A0 <PUB4 64B> <32B 摘要，全 00> <SIG 64B>
```

预期：

```text
5A 31 00 00 01 01
```

最后 1 字节：

```text
01 = 验签通过
00 = 验签失败
```

把 SIG 任意一个字节取反再发，应得到最后 1 字节 `00`。

### 4.6 一键脚本

```bash
python3 test_tools/sm2/sm2密钥对生成/sm2_keypair.py COM24
python3 test_tools/sm2/sm2加解密/sm2_crypt.py COM24
python3 test_tools/sm2/sm2签名验签/sm2_sign_verify.py COM24
```

报告：

```text
test_tools/sm2/sm2_report/sm2_keypair_report.md
test_tools/sm2/sm2_report/sm2_crypt_report.md
test_tools/sm2/sm2_report/sm2_sign_verify_report.md
```

---

### 4.7 加载外部公钥（0x15 LOAD_PUBKEY）

用途：把上位机公钥加载到芯片 SRAM，供 `EXPORT_KEY(0x13)` 包裹导出密钥。
只写 SRAM，不写 OTP，不需要 AUTH。

请求：

```text
5A 15 00 40 + 64B 公钥
```

响应：

```text
5A 15 00 00 00
```

- DATA 必须正好 64B：`X(32B) || Y(32B)`，大端。
- 长度不是 64B → `0xFE`。
- 只影响当前 SRAM，复位后丢失。

示例（加载测试公钥 TEST_D）：

```text
5A 15 00 40 3C BB 3D 11 77 FF A1 A2 1B B0 54 AE 61 34 55 EB 40 9A 77 59 3D 17 22 18 08 97 7E CB FB 05 86 47 9C F7 53 93 C8 D2 57 99 7F 3F C1 DF 9E 95 24 49 74 6F D7 5E D1 30 7E 4D D4 93 AE 3D D0 A8 00 BD
```

加载后再导出：

```text
EXPORT_KEY(5,1)：5A 13 00 02 05 01  → 5A 13 00 00 70 + 112B
EXPORT_KEY(3,1)：5A 13 00 02 03 01  → 5A 13 00 00 80 + 128B
EXPORT_KEY(4,1)：5A 13 00 02 04 01  → 5A 13 00 00 80 + 128B
```

前置条件：

- 已 `LOAD_PUBKEY`
- 密钥槽非空
- id=2（OTP SM4）还需先 `KEY_LOAD(2)` 或 AUTH

---

## 5. 口令与会话（不写 OTP）

示例口令：

```text
Abcd1234Efghijkm
= 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

### 5.1 CHECK_PASSWORD（0x06）

发送：

```text
5A 06 00 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

预期：

```text
5A 06 00 00 00
```

- `FD`：口令错误
- `F8`：OTP 未设置口令（空片）
- `FE`：口令长度不在 12~32

错误口令（12B，固定帧）：

```text
5A 06 00 0C 57 72 6F 6E 67 31 32 33 34 41 62 63
```

预期：

```text
5A 06 FD 00 00
```

### 5.2 AUTH（0x02）

发送：

```text
5A 02 00 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

预期：

```text
5A 02 00 00 00
```

- `FD`：口令错误
- `F8`：空片未设置口令；只有空片授权时才做第 6.1 节 SET_PASSWORD
- `FE`：口令长度不在 12~32

错误口令（12B，固定帧）：

```text
5A 02 00 0C 57 72 6F 6E 67 31 32 33 34 41 62 63
```

预期：

```text
5A 02 FD 00 00
```

### 5.3 GET_INFO 确认登录

发送：

```text
5A 04 00 00
```

预期：

```text
5A 04 00 00 04 01 01 00 00
```

### 5.4 LOGOUT（0x03）

发送：

```text
5A 03 00 00
```

预期：

```text
5A 03 00 00 00
```

再发 GET_INFO，DATA[1] 回到 `00`。

---

## 5.5 OTP 空片探测与槽位说明（只读，但涉及 OTP，建议最后做）

> ⚠ 本节涉及 OTP 命令。`CHECK_PASSWORD`、`KEY_LOAD`、`GET_UID` 都是只读，
> 不会写 OTP，但仍建议先完成第 1~5 节所有不写 OTP 的测试，再做本节。
> 真正写 OTP 的操作在第 6 节，默认跳过。

### 5.5.1 OTP 布局

| OTP 偏移 | 内容 | 空片值 |
| --- | --- | --- |
| `0x280~0x29F` | 口令 SM3 哈希（32B） | FF |
| `0x2A0` | 口令标志（00=已设置，FF=未设置） | FF |
| `0x2A1~0x2C0` | 槽 0：SM2 解密私钥（32B） | FF |
| `0x2C1~0x2C4` | 槽 0 密钥校验值（4B） | FF |
| `0x2C5` | 槽 0 标志（00=已设置，FF=未设置） | FF |
| `0x2C6~0x2E5` | 槽 1：SM2 签名私钥（32B） | FF |
| `0x2E6~0x2E9` | 槽 1 密钥校验值（4B） | FF |
| `0x2EA` | 槽 1 标志 | FF |
| `0x2EB~0x2FA` | 槽 2：SM4 密钥（16B） | FF |
| `0x2FB~0x2FE` | 槽 2 密钥校验值（4B） | FF |
| `0x2FF` | 槽 2 标志 | FF |

### 5.5.2 密钥槽与 OTP 固化关系

OTP 槽 0/1/2 **不能直接用 GENKEY 生成**；必须先在对应的 RAM 临时槽
生成密钥，再用 `KEY_STORE` 写入 OTP。

| OTP 槽 | 用途 | 临时生成槽 | 生成命令 | 写入 OTP 命令 | 加载命令 |
| --- | --- | --- | --- | --- | --- |
| 0 | SM2 解密私钥 | 3 | `5A 11 00 01 03` | `5A 16 00 01 03` | `5A 17 00 01 00` |
| 1 | SM2 签名私钥 | 4 | `5A 11 00 01 04` | `5A 16 00 01 04` | `5A 17 00 01 01` |
| 2 | SM4 密钥 | 5 | `5A 11 00 01 05` | `5A 16 00 01 05` | `5A 17 00 01 02` |

```text
OTP 槽 0 ← GENKEY(3) → KEY_STORE(3)
OTP 槽 1 ← GENKEY(4) → KEY_STORE(4)
OTP 槽 2 ← GENKEY(5) → KEY_STORE(5)
```

- `GENKEY` 只接受 id `3/4/5`；对 `0/1/2` 发送 `GENKEY` 返回 `0xFE`。
- `KEY_STORE` 的 id 用 `3/4/5`，它把临时槽密钥写到对应的 OTP 槽 `0/1/2`。
- `KEY_STORE` 需要口令：已 `AUTH` 用会话口令，或在 DATA 末尾追加 12~32B 口令。
- `KEY_LOAD` 的 id 用 `0/1/2`，只读加载 OTP 密钥到 SRAM。
- 固化后的验证顺序：`KEY_LOAD(0/1/2)` → `GETPUBKEY(0/1)` 或 SM2/SM4 运算。

固化完整顺序见第 6 节；固化后只读验证见第 7 节。

### 5.5.3 CHECK_PASSWORD 探口令

发送示例口令：

```text
5A 06 00 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

判读：

| 应答 | 含义 | 下一步 |
| --- | --- | --- |
| `5A 06 F8 00 00` | 口令未设置 | 继续看 5.5.4；此时 KEY_LOAD 可能返回 FD，属正常 |
| `5A 06 00 00 00` | 口令已设置且匹配 | 不是空片，跳到第 7 节 |
| `5A 06 FD 00 00` | 口令已设置但不同 | 不是空片，不要执行第 6 节 |
| `5A 06 FA 00 00` / `FF 00 00` | OTP 异常 | 停止，不要写 OTP |

### 5.5.4 KEY_LOAD 探三个密钥槽（仅口令已知时有效）

用同一条临时口令分别加载槽 0/1/2：

```text
5A 17 00 11 00 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
5A 17 00 11 01 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
5A 17 00 11 02 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

判读：

| 应答 | 含义 | 下一步 |
| --- | --- | --- |
| `5A 17 00 00 00` | 口令正确，该槽已固化并加载到 SRAM | 不是空片，跳到第 7 节 |
| `5A 17 F8 00 00` | 口令正确，但该槽未固化 | 该槽为空；三个都 F8 才符合空槽特征 |
| `5A 17 FD 00 00` | 口令错误，或口令未设置；**无法判断槽状态** | 不要写 OTP，先确认口令状态 |
| `5A 17 FA 00 00` | 槽标志异常/校验值不匹配 | 停止，不要写 OTP |
| `5A 17 FE 00 00` | id 不是 0/1/2 | 检查帧 |
| `5A 17 FF 00 00` | OTP 读失败 | 停止 |

> **重要：空片上 `KEY_LOAD` 通常返回 `FD`，不是 `F8`。**
>
> `KEY_LOAD` 的顺序是“先校验口令，再检查槽”。如果 `CHECK_PASSWORD`
> 已经返回 `F8`（口令未设置），`KEY_LOAD` 会在鉴权阶段返回 `FD`，
> 根本不会检查槽标志。所以：
>
> ```text
> CHECK_PASSWORD = F8（口令未设置）
> KEY_LOAD(0/1/2) = FD（鉴权失败，槽状态未知）
> ```
>
> 这是正常现象，不能据此判断槽已固化，也不能用“KEY_LOAD 全 F8”作为空片判据。

### 5.5.5 辅助确认

```text
5A 60 00 01 00
```

type 0 读 OTP `0x170~0x177`，空片通常返回 8 个 `FF`。
但这只能作为辅助，不能单独证明 `0x280~0x2FF` 全 FF。

客户发布版以 5.5.3 的 CHECK_PASSWORD 应答为准；
5.5.4 的 KEY_LOAD 只有在口令已设置时才能判断槽状态。

---

## 6. 首次 OTP 写入口令和密钥（破坏性，默认跳过）

> **只有空片/报废样片、明确授权时才执行本节。**
>
> OTP 槽 0/1/2 都必须先 `GENKEY(3/4/5)` 生成临时密钥，再 `KEY_STORE(3/4/5)`
> 写入；不能直接对 OTP 槽执行 GENKEY。
>
> 以下每一步都不可恢复；不要为了看状态码反复写入。

执行前确认：

```text
[ ] 当前是空片/报废样片，不是正式片
[ ] 已获得明确授权
[ ] 已确认当前芯片为空片/报废样片（芯片来源或产线工具确认）
[ ] 已记录当前 GETPUBKEY/GET_UID 结果
```

### 6.1 SET_PASSWORD（0x05）

`SET_PASSWORD` 不要求先 AUTH。给空片设置口令：

```text
5A 05 00 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

预期：

```text
5A 05 00 00 00
```

状态：

| STATUS | 含义 |
|---|---|
| `00` | 首次写入成功 |
| `F9` | 口令已存在，不能重复设置 |
| `FE` | 口令长度非法 |
| `FA` | OTP 标志异常 |
| `FF` | OTP 写失败 |

当前测试固件默认 `CMD_ENABLE_SET_PASSWORD=1`；如果产线固件把它关掉，
发送 `0x05` 会返回 `0x02`（未知命令）。

写入后确认：

- `0x2A0` 从 `FF` 变成 `00`
- `0x280~0x29F` 变成 SM3(口令) 哈希

然后 AUTH：

```text
5A 02 00 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

预期 `5A 02 00 00 00`；GET_INFO DATA[1]=`01`。

### 6.2 固化槽 0（SM2 解密）

先 AUTH，然后：

```text
5A 11 00 01 03      → GENKEY(3)
5A 12 00 01 03      → GETPUBKEY(3)，记录公钥
5A 16 00 01 03      → KEY_STORE(3)，写入 OTP 槽 0
```

预期：

```text
5A 11 00 00 00
5A 12 00 00 40 + 64B 公钥
5A 16 00 00 00
```

### 6.3 固化槽 1（SM2 签名）

```text
5A 11 00 01 04      → GENKEY(4)
5A 12 00 01 04      → GETPUBKEY(4)，记录公钥
5A 16 00 01 04      → KEY_STORE(4)，写入 OTP 槽 1
```

### 6.4 固化槽 2（SM4）

```text
5A 11 00 01 05      → GENKEY(5)
5A 16 00 01 05      → KEY_STORE(5)，写入 OTP 槽 2
```

槽 2 没有公钥，不需要 GETPUBKEY。

### 6.5 固化后确认

固化后用命令确认：

```text
5A 06 00 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
→ 5A 06 00 00 00（口令已设置且匹配）

5A 17 00 11 00 <16B 口令> → 5A 17 00 00 00（槽 0 已固化）
5A 17 00 11 01 <16B 口令> → 5A 17 00 00 00（槽 1 已固化）
5A 17 00 11 02 <16B 口令> → 5A 17 00 00 00（槽 2 已固化）
```

再发一次对应的 `KEY_STORE` 应该返回 `F9`，证明槽已存在：

```text
5A 16 00 11 03 <16B 口令> → 5A 16 F9 00 00
5A 16 00 11 04 <16B 口令> → 5A 16 F9 00 00
5A 16 00 11 05 <16B 口令> → 5A 16 F9 00 00
```

以上命令全部通过，就说明口令和三个 OTP 槽都已写入并可加载。

### 6.6 KEY_STORE 关键警告

```text
KEY_STORE 不会检查临时槽是否为空，也不会返回 F8。
如果没先 GENKEY 就发 KEY_STORE，会把全 0x00 当成密钥永久写进 OTP。
```

所以顺序必须是：

```text
GENKEY(3/4/5) → 可选 GETPUBKEY → KEY_STORE(3/4/5)
```

已固化的槽再次 `KEY_STORE` 返回 `F9`，不会覆盖。

### 6.7 KEY_DESTROY（仅报废片，默认不执行）

销毁 OTP 槽（需口令）：

```text
5A 18 00 01 00      → 销毁槽 0
5A 18 00 01 01      → 销毁槽 1
5A 18 00 01 02      → 销毁槽 2
```

或带临时口令：

```text
5A 18 00 11 00 + 16B 口令
```

预期 `5A 18 00 00 00`。

⚠ 销毁后不可恢复；`DestroyKey` 只清密钥和校验值，槽标志仍是 `00`，
之后该槽既不能 `KEY_STORE`（返回 `F9`），也不能再使用。
销毁后再 `KEY_LOAD` 会返回 `FA`（槽标志已设置但校验值不匹配）。

---

## 7. 固化后的 OTP 密钥验证（只读）

本节只读，不写 OTP；空片固化后或已固化芯片都可以执行。

### 7.1 KEY_LOAD（0x17）

三种槽：

```text
槽0：5A 17 00 01 00
槽1：5A 17 00 01 01
槽2：5A 17 00 01 02
```

需要先 AUTH；或不 AUTH，用临时口令：

```text
槽0：5A 17 00 11 00 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
槽1：5A 17 00 11 01 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
槽2：5A 17 00 11 02 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

预期：

```text
5A 17 00 00 00
```

- `F8`：该槽未固化
- `FD`：未登录/口令错误
- `FA`：槽标志异常或密钥校验值不匹配

未登录、不带口令：

```text
5A 17 00 01 00
```

预期：

```text
5A 17 FD 00 00
```

错误口令（12B）：

```text
5A 17 00 0D 00 57 72 6F 6E 67 31 32 33 34 41 62 63
```

预期：

```text
5A 17 FD 00 00
```

### 7.2 槽 0：SM2 解密回路

```text
5A 12 00 01 00      → GETPUBKEY(0)，记录 64B 公钥
```

用该公钥加密 16B 明文：

```text
5A 23 00 71 01 <PUB0 64B> <k 32B> <16B 明文>
```

记录 112B 密文 CT，再用槽 0 解密：

```text
5A 24 00 84 00 01 00 10 <CT 112B> 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

LEN=`0x0084` = 4 + 112 + 16（口令）。

预期：

```text
5A 24 00 00 10 + 16B 明文
```

已 AUTH 时可以不带口令：

```text
5A 24 00 74 00 01 00 10 <CT 112B>
```

### 7.3 槽 1：SM2 签名/验签回路

```text
5A 12 00 01 01      → GETPUBKEY(1)，记录 PUB1
```

签名（临时口令，LEN=`0x0051`）：

```text
5A 30 00 51 01 <32B 摘要> <32B k> 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D
```

预期：

```text
5A 30 00 00 40 + 64B 签名 SIG
```

验签：

```text
5A 31 00 A0 <PUB1 64B> <32B 摘要> <SIG 64B>
```

预期最后 1 字节 `01`。

已 AUTH 时可以不带口令：

```text
5A 30 00 41 01 <32B 摘要> <32B k>
```

### 7.4 槽 2：SM4 ECB/CBC 回路（0x40）

槽 2 是 OTP SM4 密钥，不能导出；用“加密→解密”回路验证。

ECB 加密（临时口令，LEN=`0x00000024`）：

```text
5A 40 00 00 00 24 02 80 00 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D 00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

预期：

```text
5A 40 00 00 00 00 10 + 16B 密文
```

ECB 解密（op=1）：

```text
5A 40 00 00 00 24 02 80 01 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D <16B 密文>
```

预期：

```text
5A 40 00 00 00 00 10 00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

CBC 加密（LEN=`0x00000034`）：

```text
5A 40 00 00 00 34 02 81 00 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 00 11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF
```

CBC 解密（op=1，IV 不变）：

```text
5A 40 00 00 00 34 02 81 01 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F <16B 密文>
```

### 7.5 已固化芯片的只读检查

```text
5A 06 00 10 41 62 63 64 31 32 33 34 45 66 67 68 69 6A 6B 6D   → 00
5A 17 00 11 00 <口令>                                             → 00
5A 17 00 11 01 <口令>                                             → 00
5A 17 00 11 02 <口令>                                             → 00
5A 12 00 01 00                                                    → 64B 公钥
5A 12 00 01 01                                                    → 64B 公钥
```

对已固化槽再发 `KEY_STORE`，应返回 `F9`（不需要先 GENKEY）：

```text
5A 16 00 11 03 <口令>      → 5A 16 F9 00 00
5A 16 00 11 04 <口令>      → 5A 16 F9 00 00
5A 16 00 11 05 <口令>      → 5A 16 F9 00 00
```

未登录且不带口令：

```text
5A 16 00 01 03      → 5A 16 FD 00 00
```

### 7.6 用 OTP 密钥导入 SM4 密钥（可选）

前置：OTP 槽 0 或槽 1 已固化，且知道 OTP 口令。

运行前关闭 SSCOM 等占用 COM 口的工具。

从 `otp_patch` 根目录：

```bash
python3 test_tools/sm4/sm4密钥导入导出/sm4_key_import_40.py COM24 --password "Abcd1234Efghijkm"
```

从 `test_tools` 目录：

```bash
python3 sm4/sm4密钥导入导出/sm4_key_import_40.py COM24 --password "Abcd1234Efghijkm"
```

脚本流程：

```text
KEY_LOAD(0, 口令)        只读加载 OTP 槽 0 到 SRAM
GETPUBKEY(0)             读 OTP 公钥
上位机生成 16B SM4 密钥
用 OTP 公钥做 SM2 包裹
KEY_IMPORT(target=5, dec_id=0, std=1, 包裹密文)
LOAD_PUBKEY(TEST_D)
EXPORT_KEY(5, 1)         导出临时槽 5 的密钥并比对
0x40 SM4_BULK ECB 加密/解密
```

预期：

```text
KEY_LOAD(0): 0x00
GETPUBKEY(0): 64B 公钥
KEY_IMPORT: 0x00
EXPORT_KEY(5,1): OK
0x40 ECB 加密/解密: OK
结论：全部符合预期
```

- 只写临时槽 5（RAM），不写 OTP。
- `KEY_IMPORT` 的包裹密文长度是 112B。
- 也可以测槽 1：加 `--dec-id 1`，会用 OTP 槽 1 的密钥解密导入。
- 报告：`test_tools/sm4/sm4_report/sm4_key_import_40_report.md`。

---

## 8. 检查清单

```text
不写 OTP 的测试：
[ ] PING 返回 5A 01 00 00 00
[ ] GET_INFO 返回 04 01 00 00 00
[ ] GET_UID type 0/1 均能返回 8B
[ ] SELFTEST 全项 result=00000000
[ ] SM3 0x41：abc / 空消息 / "a" 摘要正确
[ ] SM3 128KB 脚本通过
[ ] SM4 0x40：GENKEY(5) 成功
[ ] SM4 0x40：ECB 加密→解密还原
[ ] SM4 0x40：CBC 加密→解密还原
[ ] SM4 128KB 脚本通过
[ ] SM2 临时槽 3：加密→设备解密还原
[ ] SM2 临时槽 4：签名→验签通过
[ ] 口令 CHECK_PASSWORD / AUTH / LOGOUT 正常

OTP 相关（只读探测和破坏性操作都放到最后）：
[ ] （只读）CHECK_PASSWORD 返回 F8（口令未设置，空片特征）
[ ] （只读）如口令已设置：KEY_LOAD(0/1/2) 三条都返回 F8（三个槽为空）
[ ] （可选，破坏性）SET_PASSWORD 成功，之后 CHECK_PASSWORD 返回 00
[ ] （可选，破坏性）KEY_STORE 3/4/5 成功，之后 KEY_LOAD(0/1/2) 返回 00
[ ] （可选）OTP 槽 0 解密、槽 1 签名验签、槽 2 SM4 回路通过
[ ] （可选）sm4_key_import_40.py 通过（OTP 槽 0/1 密钥导入临时槽 5）
[ ] 测试结束执行 LOGOUT
```

---

## 9. 状态码与失败对照

| STATUS | 含义 |
|---|---|
| `00` | 成功 |
| `FF` | 通用错误；SM2 解密失败实际返回 `FF` |
| `FE` | id/参数/长度非法 |
| `FD` | 权限不足/口令错误 |
| `FC` | 保留码，当前固件不返回 |
| `FA` | OTP 标志异常/密钥校验值不匹配 |
| `F9` | 槽位/口令已存在 |
| `F8` | 槽位/口令未设置，或 RAM 未加载密钥 |
| `01` | 帧错误，保留，当前不主动返回 |
| `02` | 未知命令 |
| `03` | 数据/应答超长 |

常见现象：

| 现象 | 处理 |
|---|---|
| 完全无应答 | 检查 HEX 模式、COM 口、波特率、接线 PN04/PN03、共地 |
| 某条命令后帧错乱 | LEN 与实际 DATA 不一致，等超时后重发 |
| `FE` | id/长度/mode/op/pt_len 非法 |
| `FD` | 未 AUTH、口令错误、OTP 槽未授权 |
| `F8` | 槽未固化，或 `GETPUBKEY` 前忘了 `KEY_LOAD`/`GENKEY` |
| `F9` | 口令或槽位已存在，不要重复写 |
| `FA` | OTP 标志/校验值损坏 |
| `FF` | OTP 读写失败、SM2 解密/签名失败 |
| SM4 结果不对 | data 不是 16 的倍数、IV 不一致、复位后密钥丢失 |
| SM2 解密失败 | std 不一致、密钥不匹配、密文损坏、pt_len>64 |
| SM2 卡死/无应答 | 检查 `pt_len` 是否超过 64；超过会写穿 ROM 栈帧 |

---

## 10. 与原始文档的对应关系

| 原始文档内容 | 本文位置 | 说明 |
|---|---|---|
| PING / GET_INFO / GET_UID / SELFTEST | 第 1 节 | 保留；不写 OTP |
| 空片 OTP 探测与槽位说明 | 第 5.5 节 | CHECK_PASSWORD 为主；口令未设置时 KEY_LOAD 返回 FD 属正常，不能判断槽 |
| SM3 标准向量 | 第 2 节 | 改用 `0x41`，小数据手工，128KB 脚本 |
| SM3 流式 `0x1A/1B/1C` | 不保留 | NO3 已删除 |
| SM4 ECB/CBC 小数据 | 第 3 节 | 改用 `0x40`，小数据手工，128KB 脚本 |
| SM4 临时槽 5 | 第 3 节 | 保留 |
| SM2 临时槽 3/4 | 第 4 节 | 保留 |
| CHECK_PASSWORD / AUTH / LOGOUT | 第 5 节 | 保留 |
| SET_PASSWORD / KEY_STORE / KEY_DESTROY | 第 6 节 | 保留，默认跳过，破坏性 |
| KEY_LOAD / OTP 槽验证 | 第 7 节 | 保留，只读 |
| 已固化芯片附录 | 第 7.5 节 | 保留核心检查 |
| 常见失败对照 | 第 9 节 | 保留并适配 NO3 |

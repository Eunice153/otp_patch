---
name: otp-patch-test-tools
description: Run OTP patch serial tests (SM2/SM3/SM4) safely. Use temporary key slots only; never write OTP without explicit permission.
---

# OTP Patch 串口测试 Skill

## 何时使用

在 `otp_patch` 的串口测试固件上验证 SM2/SM3/SM4 功能、生成测试报告，
或排查串口命令/帧格式问题时使用本 skill。

## 安全红线

1. 不写 OTP。测试只用 `GENKEY` 的临时槽：
   - 3 = `ID_TMP_SM2_DEC`
   - 4 = `ID_TMP_SM2_SIGN`
   - 5 = `ID_TMP_SM4`
2. 禁止发送：
   - `CMD_SET_PASSWORD = 0x05`
   - `CMD_KEY_STORE = 0x16`
   - `CMD_KEY_DESTROY = 0x18`
3. `CMD_KEY_IMPORT = 0x14` 只能导入临时目标槽 3/4/5。
   `sm2_key_import.py` 只导入临时槽 3；它需要芯片已有 OTP SM2
   解密密钥，但没有该密钥时只报告，不写 OTP。
4. 任何需要 OTP 烧写的测试，先停下来向用户确认。

## read_me 文档约定

- `read_me.txt` 中 `/* ... */` 之间的内容是用户自己的总结，
  **禁止修改**：不删除、不改写、不重排、不“纠正”。
- 需要补充说明时，只能写在 `/* ... */` 块外面。
- 这条规则适用于 `test_tools` 下所有 `read_me.txt`。

## 串口约定

```text
请求: 5A CMD LEN_H LEN_L DATA[LEN]
应答: 5A CMD STATUS LEN_H LEN_L DATA[LEN]
```

- `CMD_MAX_DATA = 512`，普通命令单帧 DATA 最大 512B。
- 大数据用 NO3 的 0x40/0x41：4 字节 LEN 的逻辑大帧，
  最大 128KB，主机可拆成 n 次串口 write。
- SM3 流式 `0x1A/0x1B/0x1C` 已删除；大数据统一走 `0x41`。
- SM2 解密明文最大 64B（ROM 栈帧限制）。
- 状态码：`0x00` 成功，`0xFE` 参数/状态错误，`0xFD` 未授权，
  `0x02` 未知命令。

详见 [serial_protocol.md](serial_protocol.md)。

## 环境

- WSL 下 `python3 script.py COM24`：脚本会自动转用 Windows Python
  （默认 `/mnt/d/download/zephyr/python/python.exe`，可用 `WINPY` 覆盖）。
- 运行前关闭占用 COM 口的串口工具。
- 依赖 pyserial。
- 报告默认写 `sm2/sm2_report/`；不要依赖 WSL `/tmp`。

## SM2 工具

| 目录 | 脚本 | 用途 |
|---|---|---|
| `sm2/sm2密钥对生成` | `sm2_keypair.py` | GENKEY + GETPUBKEY + 导出私钥校验 |
| `sm2/sm2加解密` | `sm2_crypt.py` | 设备加密/解密 + 上位机交叉校验 |
| `sm2/sm2加解密密钥导入` | `sm2_key_import.py` | SM2 包裹密钥导入临时槽 3 |
| `sm2/sm2签名验签` | `sm2_sign_verify.py` | 设备签名、设备验签、篡改验签、主机签名设备验签 |

示例：

```bash
cd otp_patch/test_tools
python3 sm2/sm2密钥对生成/sm2_keypair.py COM24
python3 sm2/sm2加解密/sm2_crypt.py COM24
python3 sm2/sm2签名验签/sm2_sign_verify.py COM24
python3 "sm2/sm2加解密密钥导入/sm2_key_import.py" COM24
```

参数、输出和报告格式见 [sm2_tools.md](sm2_tools.md)。

## SM3 工具

| 目录 | 脚本 | 用途 |
|---|---|---|
| `sm3/sm3单帧` | `sm3_oneshot_41.py` | NO3 0x41，最大 128KB |
| `sm3/sm3异常输入` | `sm3_abnormal_41.py` | NO3 0x41 长度边界 |
| `sm3/sm3_speed` | `sm3_speed.py` | NO3 0x41 速率，默认 128KB×3 |

示例：

```bash
cd otp_patch/test_tools
python3 sm3/sm3单帧/sm3_oneshot_41.py COM24
python3 sm3/sm3异常输入/sm3_abnormal_41.py COM24
python3 sm3/sm3_speed/sm3_speed.py COM24
python3 sm3/sm3_speed/sm3_speed.py COM24 --size 64K --runs 5
```

参数、输出和报告格式见 [sm3_tools.md](sm3_tools.md)。

## SM4 工具

| 目录 | 脚本 | 用途 |
|---|---|---|
| `sm4/sm4密钥生成` | `sm4_key_40.py` | GENKEY(5) + 导出/恢复 16B 密钥 + ECB 自检 |
| `sm4/sm4ecb加解密` | `sm4_ecb_40.py` | ECB 加密/解密正确性 |
| `sm4/sm4cbc加解密` | `sm4_cbc_40.py` | CBC 加密/解密正确性 |
| `sm4/sm4密钥导入导出` | `sm4_key_import_40.py` | SM2 包裹 SM4 密钥导入临时槽 5 |
| `sm4/sm4异常输入` | `sm4_abnormal_40.py` | 非法长度/id/mode/op/CBC 参数 |
| `sm4/sm4ecb_speed` | `sm4_ecb_speed.py` | NO3 0x40 ECB 速率，默认 128KB×3 加密+解密 |
| `sm4/sm4cbc_speed` | `sm4_cbc_speed.py` | NO3 0x40 CBC 速率，默认 128KB×3 加密+解密 |

示例：

```bash
cd otp_patch/test_tools
python3 sm4/sm4密钥生成/sm4_key_40.py COM24
python3 sm4/sm4ecb加解密/sm4_ecb_40.py COM24
python3 sm4/sm4cbc加解密/sm4_cbc_40.py COM24
python3 sm4/sm4异常输入/sm4_abnormal_40.py COM24
python3 sm4/sm4密钥导入导出/sm4_key_import_40.py COM24
python3 sm4/sm4ecb_speed/sm4_ecb_speed.py COM24
python3 sm4/sm4cbc_speed/sm4_cbc_speed.py COM24
```

参数、输出和报告格式见 [sm4_tools.md](sm4_tools.md)。

### NO3 大数据 0x40 / 0x41

NO3 固件额外支持一个逻辑大帧：

- `0x40 SM4_BULK`：4 字节长度，最大 128KB；PAYLOAD 是
  `[id, mode, op] + 可选口令 + CBC IV + data`。
- `0x41 SM3_BULK`：4 字节长度，最大 128KB 原始数据，回 32B 摘要。

固件端 128KB×2 缓冲，收齐后只调用一次 Invoke，完整回传。
上位机可以把整个请求拆成任意 n 次串口 write，也可以分 n 次
read 收应答；中间没有帧头、偏移或 ACK。

测试脚本：

```bash
cd otp_patch/test_tools
python3 sm4/sm4ecb加解密/sm4_ecb_40.py COM24 --lengths 131072
python3 sm4/sm4cbc加解密/sm4_cbc_40.py COM24 --lengths 131072
python3 sm3/sm3_speed/sm3_speed.py COM24
```

只对 NO3 固件有效；NO2 没有 0x40/0x41。详见
[serial_protocol.md](serial_protocol.md)。

## 指令自检 / 读取 ID

| 目录 | 脚本 | 用途 |
|---|---|---|
| `指令自检` | `selftest.py` | SELFTEST 0x50，TRNG/SM3/SM4/SM2 KAT |
| `读取id` | `get_uid.py` | GET_UID 0x60，type 0/1 |

```bash
cd otp_patch/test_tools
python3 指令自检/selftest.py COM24
python3 指令自检/selftest.py COM24 --mask 0x0002   # 只跑 SM3 KAT
python3 读取id/get_uid.py COM24 --type all
```

- SELFTEST 只使用 RAM 临时槽，不写 OTP。
- GET_UID 只读 OTP，不写 OTP。
- 当前 NO2 固件复位后 SELFTEST 0x0000/0x0001/0x0002/0x0004/
  0x0008/0x000F/0xFFFF 均返回 result=0x00000000。
- 如果无应答，先复位，再用 `--mask 0x0000` / 单项定位，不要反复发送。
- 报告：`指令自检/selftest_report.md`、`读取id/get_uid_report.md`。

## 调试顺序

1. `GET_INFO` / `PING` 确认串口和固件活着。
2. 确认没有别的工具占用 COM。
3. 超时先检查 LEN 是否与实际数据一致、是否超过 512B。
4. `GETPUBKEY(0/1)` 失败说明 OTP 密钥未配置；不要尝试写 OTP。
5. SM2 解密返回 `FE`：检查 `pt_len` 是否 1..64、密文长度是否
   `96 + pt_len`、槽位是否 3（临时）或 0（OTP）。
6. SM3 大数据摘要错误：确认烧的是 NO3，0x41 是 4 字节 LEN；
   流式 0x1A/0x1B/0x1C 已删除。

详见 [debugging.md](debugging.md) 和 [otp_safety.md](otp_safety.md)。

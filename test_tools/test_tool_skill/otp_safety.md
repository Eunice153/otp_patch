# OTP 安全红线

## 规则

**没有用户明确许可，不允许写 OTP。**

OTP 是一次性可编程（1→0），写错/多写不可恢复，可能永久改变样片。
测试脚本只允许使用 RAM 临时槽。

## 允许

| 操作 | 说明 |
|---|---|
| `GENKEY(3/4/5)` | 生成临时槽密钥到 RAM |
| `GETPUBKEY(0..5)` | 只读公钥 |
| `EXPORT_KEY(id, 1)` | 0x13，通用导出（固件旧名 SM4_EXPORT），只读 |
| `LOAD_PUBKEY(64B)` | 只写 RAM 的包裹公钥 |
| `KEY_IMPORT(target=3/4/5, ...)` | 只写临时目标槽 |
| `KEY_LOAD(0/1, password)` | 只读加载 OTP 密钥到 SRAM，需要口令 |
| `SM2_ENC/DEC/SIGN/VERIFY` | 运算，不写 OTP |
| `CHECK_PASSWORD` / `GET_INFO` / `PING` | 只读/校验 |

## 禁止

| 命令 | 值 | 原因 |
|---|---|---|
| `SET_PASSWORD` | `0x05` | 一次性写 OTP 口令 |
| `KEY_STORE` | `0x16` | 把临时密钥写入 OTP |
| `KEY_DESTROY` | `0x18` | 销毁/擦除 OTP 密钥 |

`common/link.py` 会在发送前拦截这三条命令，直接抛异常。

## KEY_IMPORT 的边界

`KEY_IMPORT` 用 `dec_id=0/1` 的 OTP 私钥解开上位机包裹，然后把明文
密钥写进 `target=3/4/5` 的临时槽。

- **只写临时槽**，不写 OTP。
- SM2 密钥导入临时槽 3，SM4 密钥导入临时槽 5。
- 需要芯片已有 OTP SM2 密钥；没有时脚本停止并报告。
- 不要为了跑通 KEY_IMPORT 去调用 `SET_PASSWORD` / `KEY_STORE`；
  那会写 OTP，必须先获得用户明确授权。

## 如果测试确实需要 OTP 配置

停下来，向用户说明：

1. 需要写哪个 OTP 区域/槽位；
2. 写入内容是否不可逆；
3. 是否使用新样片；
4. 是否有备份/替代测试方案。

获得明确许可后才能执行，并且优先在空片/专用样片上做。

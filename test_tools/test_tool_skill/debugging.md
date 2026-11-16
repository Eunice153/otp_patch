# 调试与常见问题

## 1. WSL 串口

Windows 的 `COMx` 不能被 WSL 原生 Python 打开。脚本检测到命令行里有
`COM` 开头的参数时，自动改用 Windows Python：

```text
/mnt/d/download/zephyr/python/python.exe
```

如果路径不同，用环境变量覆盖：

```bash
WINPY=/mnt/c/.../python.exe python3 sm2/sm2加解密/sm2_crypt.py COM24
```

运行前关闭占用同一个 COM 口的串口助手、烧写工具或其他脚本。

## 2. 报告写到哪里

SM2 脚本默认写：

```text
otp_patch/test_tools/sm2/sm2_report/
```

不要依赖 WSL `/tmp`：Windows 资源管理器看不到 `/tmp`。如果一定要用
`--out /tmp/...`，脚本会用 `wslpath -w` 转成 Windows 路径，实际写入
位置以运行结束打印的“报告已写入”为准。

## 3. 常见错误

### 打开 COM 失败

```text
could not open port COM24
```

- 端口号是否正确。
- 是否被串口助手/烧写工具占用。
- WSL 是否真的转用了 Windows Python（看第一行提示）。

### 命令超时

- 检查 `LEN` 是否和实际 DATA 字节数一致。
- 检查单帧 DATA 是否超过 512B；超过时帧层直接丢弃，不应答。
- 检查波特率是否 115200。
- 设备是否在忙（SM2 运算可能需要几秒）。

### SM2 解密返回 `0xFE`

- `pt_len` 必须在 1..64。
- 密文长度必须是 `96 + pt_len`。
- 临时槽只能用 3；OTP 槽是 0，需要口令。
- 检查 payload 的 4 字节头：`[id, std, pt_len_H, pt_len_L]`。

### `GETPUBKEY(0/1)` 失败

说明 OTP SM2 密钥未配置。此时：

- `sm2_key_import.py` 无法执行导入，会报告“未配置/未执行”。
- **不要**为了测试去调用 `SET_PASSWORD` / `KEY_STORE` 写 OTP。
- 换到已配置 OTP 密钥的样片测试，或先获得用户明确授权。

### SM2 临时密钥丢了

临时槽 3/4/5 在 RAM，复位/掉电后丢失。重新运行脚本会先
`GENKEY`，不需要写 OTP。

### SM3 大数据摘要错误

流式 `0x1A/0x1B/0x1C` 已删除，大数据改用 NO3 的 `0x41`：

- 确认烧的是 NO3；NO2 没有 0x41。
- 0x41 是 4 字节 LEN：`5A 41 LEN0..LEN3 data`。
- LEN 必须等于实际 data 字节数，最大 131072。
- 摘要不一致时先检查 LEN 和实际发送长度。

### SM4 常见错误

- `SM4_CRYPT` 返回 `0xFE`：检查 DATA 是否为 16B 的正整数倍、
  CBC 是否带了 16B IV、id 是否 5（临时）或 2（OTP）。
- ECB/CBC 密文不一致：检查 `EXPORT_KEY(5,1)` 恢复的密钥是否
  和设备槽 5 一致。
- 单帧明文最大 480B（CBC 参数 3B + IV 16B，总帧 ≤512B）。
- 硬件 `SM4_CALC_LEN` 实际只有 1 bit；当前 OTP patch 已按 16B
  逐块处理，多块 ECB/CBC 正常。

### NO3 0x40/0x41 大数据超时/失败

- 确认烧的是 NO3，不是 NO2；NO2 没有 0x40/0x41。
- 0x40/0x41 是 **4 字节长度**：`5A 40/41 LEN0..LEN3`，
  不要按 2 字节发。
- 0x40 先发 `GENKEY(5)`：`5A 11 00 00 01 05`；槽 5 为空返回 `0xF8`。
- SM4 data 必须是 16 的正整数倍，最大 131072B。
- 0x40 的 PAYLOAD 和 0x20 一样：`[id,mode,op] + CBC IV + data`；
  上位机负责传 IV。
- 0x41 的 PAYLOAD 就是 SM3 原始数据，回 32B 摘要。
- 上位机可以把请求拆成 n 次 write，应答分 n 次 read；中间不要
  停太久，否则固件半帧超时会丢弃大帧。
- 115200 下 128KB 单程约 11.4s，脚本超时要大于 20s。

## 4. 当前测试状态（2026-11-16）

在 `otp_main_only_full_test_uart_NO2` + COM24 上：

- SM2 密钥对生成：通过（槽 3/4）。
- SM2 加解密：通过（16/24/32/48/64B）。
- SM2 签名验签：通过（5 组消息，含篡改验签和主机签名）。
- SM2 加解密密钥导入：未执行，当前片子 OTP 解密槽 0 未配置；
  脚本已安全停止，没有写 OTP。
- SM3 单帧 0x10 / 大数据 0x41：通过；流式 0x1A/0x1B/0x1C 已删除。
- SM3 异常输入：10/10 通过。
- SELFTEST 0x50：复位后 0x0000/0x0001/0x0002/0x0004/0x0008/
  0x000F/0xFFFF 全部通过（result=0）。
- GET_UID 0x60：type 1 读到生产信息；type 0 当前为
  `FF FF FF FF FF FF FF FF`（OTP 0x170 未写），读取命令本身成功。
- SM4 密钥生成/ECB/CBC/异常输入：全部通过（临时槽 5）。
- SM4 密钥导入：未执行，当前片子 OTP 解密槽 0 未配置；
  脚本已安全停止，没有写 OTP。

## 5. 建议的排查顺序

```text
1. PING / GET_INFO       确认串口和固件
2. 关掉其他串口工具
3. 检查 LEN 和 512B 上限
4. 检查命令 payload 格式
5. 看 STATUS 和报告里的完整收发 HEX
6. 涉及 OTP 的失败先停下，确认是否有 OTP 密钥
```

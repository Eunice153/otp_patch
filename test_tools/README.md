# otp_patch 串口测试工具

## 目录

```text
test_tools/
├── common/                 # 公共串口/SM2/SM4 参考实现
├── sm2/
│   ├── sm2密钥对生成/
│   ├── sm2加解密/
│   ├── sm2加解密密钥导入/
│   ├── sm2签名验签/
│   └── sm2_report/         # SM2 报告输出
├── sm4/
│   ├── sm4密钥生成/
│   ├── sm4ecb加解密/
│   ├── sm4cbc加解密/
│   ├── sm4密钥导入导出/
│   ├── sm4异常输入/
│   ├── sm4大数据/          # NO3 0x40，最大 128KB
│   ├── sm4ecb_speed/       # NO3 0x40 ECB 速率
│   ├── sm4cbc_speed/       # NO3 0x40 CBC 速率
│   └── sm4_report/         # SM4 报告输出
├── sm3/
│   ├── sm3单帧/            # 0x10 + NO3 0x41
│   ├── sm3异常输入/        # 0x10 + NO3 0x41
│   ├── sm3_speed/          # NO3 0x41 速率，默认 128KB×3
│   └── sm3_report/         # SM3 报告输出
├── 指令自检/               # SELFTEST 0x50
├── 读取id/                 # GET_UID 0x60
└── test_tool_skill/        # 使用说明、协议、调试、安全规则
```

## 安全规则

- 不写 OTP；只用临时槽 3/4/5。
- 禁止 `SET_PASSWORD(0x05)`、`KEY_STORE(0x16)`、`KEY_DESTROY(0x18)`。
- `KEY_IMPORT` 只允许目标临时槽 3/4/5。
- 普通命令单帧 DATA 最大 512B。
- NO3 的 0x40/0x41 是 4 字节 LEN 的逻辑大帧，最大 128KB；
  流式 SM3 已删除。

## 快速开始

```bash
cd otp_patch/test_tools

python3 sm2/sm2密钥对生成/sm2_keypair.py COM24
python3 sm2/sm2加解密/sm2_crypt.py COM24
python3 sm2/sm2签名验签/sm2_sign_verify.py COM24
python3 "sm2/sm2加解密密钥导入/sm2_key_import.py" COM24

python3 sm3/sm3单帧/sm3_oneshot.py COM24
python3 sm3/sm3单帧/sm3_oneshot_41.py COM24
python3 sm3/sm3异常输入/sm3_abnormal.py COM24
python3 sm3/sm3异常输入/sm3_abnormal_41.py COM24
python3 sm3/sm3_speed/sm3_speed.py COM24

python3 指令自检/selftest.py COM24
python3 读取id/get_uid.py COM24

python3 sm4/sm4密钥生成/sm4_key.py COM24
python3 sm4/sm4ecb加解密/sm4_ecb.py COM24
python3 sm4/sm4cbc加解密/sm4_cbc.py COM24
python3 sm4/sm4异常输入/sm4_abnormal.py COM24
python3 sm4/sm4密钥导入导出/sm4_key_import.py COM24
python3 sm4/sm4大数据/sm4_bulk.py COM24 --mode cbc --lengths 131072
python3 sm4/sm4ecb_speed/sm4_ecb_speed.py COM24
python3 sm4/sm4cbc_speed/sm4_cbc_speed.py COM24
```

详细说明从 [test_tool_skill/README.md](test_tool_skill/README.md) 开始。

## SM4 0x40 版本脚本

以下目录在保留原 0x20 脚本的同时，新增了 `*_40.py`
（NO3 0x40 SM4_BULK）和 `read_me_40.txt`：

```text
sm4/sm4密钥生成/sm4_key_40.py
sm4/sm4ecb加解密/sm4_ecb_40.py
sm4/sm4cbc加解密/sm4_cbc_40.py
sm4/sm4密钥导入导出/sm4_key_import_40.py
sm4/sm4异常输入/sm4_abnormal_40.py
sm4/sm4ecb_speed/sm4_ecb_speed.py
sm4/sm4cbc_speed/sm4_cbc_speed.py
```

例如：

```bash
python3 sm4/sm4cbc加解密/sm4_cbc_40.py COM24
python3 sm4/sm4ecb加解密/sm4_ecb_40.py COM24 --lengths 131072
```

原脚本 `sm4_cbc.py` / `sm4_ecb.py` 等仍然保留，NO2/NO3 都能用。

## NO3 大数据 SM4/SM3（0x40/0x41）

NO3 固件支持一个逻辑大帧，使用 4 字节长度，最大 128KB：

- `0x40 SM4_BULK`：PAYLOAD 和 0x20 一样是
  `[id,mode,op] + CBC IV + data`；固件收齐后一次处理并完整回传。
- `0x41 SM3_BULK`：PAYLOAD 就是 SM3 数据，回 32B 摘要。

上位机可以把整个请求拆成任意 n 次串口 write，也可以分 n 次
read 收应答；中间没有帧头、偏移或 ACK。

```bash
cd otp_patch/otp_main_only_full_test_uart_NO3/test_tools
python3 large_bulk.py COM24 --algo sm4 --mode cbc --size 4096 \
    --writes 8 --reads 8 --verify
python3 large_bulk.py COM24 --algo sm4 --mode ecb --size 131072
python3 large_bulk.py COM24 --algo sm3 --size 131072 --writes 16
```

只对 NO3 固件有效；NO2 没有 0x40/0x41。协议细节见
[test_tool_skill/serial_protocol.md](test_tool_skill/serial_protocol.md)
和 NO3 的 `test_tools/large_bulk_read_me.txt`。

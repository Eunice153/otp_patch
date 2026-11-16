# otp_patch 串口测试工具

## 目录

```text
test_tools/
├── common/                 # 公共串口/SM2/SM3/SM4 参考实现
├── sm2/
│   ├── sm2密钥对生成/
│   ├── sm2加解密/
│   ├── sm2加解密密钥导入/
│   ├── sm2签名验签/
│   └── sm2_report/         # SM2 报告输出
├── sm4/
│   ├── sm4密钥生成/        # 0x40
│   ├── sm4ecb加解密/       # 0x40
│   ├── sm4cbc加解密/       # 0x40
│   ├── sm4密钥导入导出/    # 0x40
│   ├── sm4异常输入/        # 0x40
│   ├── sm4ecb_speed/       # 0x40 ECB 速率
│   ├── sm4cbc_speed/       # 0x40 CBC 速率
│   └── sm4_report/         # SM4 报告输出
├── sm3/
│   ├── sm3单帧/            # 0x41
│   ├── sm3异常输入/        # 0x41
│   ├── sm3_speed/          # 0x41 速率
│   └── sm3_report/         # SM3 报告输出
├── 指令自检/               # SELFTEST 0x50
├── 读取id/                 # GET_UID 0x60
└── test_tool_skill/        # 使用说明、协议、调试、安全规则
```

短 SM3（0x10）、短 SM4（0x20）和 SM3 流式测试已删除；
SM3 统一用 `0x41`，SM4 统一用 `0x40`。

## 安全规则

- 测试脚本不写 OTP；只用临时槽 3/4/5。
- 脚本禁止 `SET_PASSWORD(0x05)`、`KEY_STORE(0x16)`、`KEY_DESTROY(0x18)`。
- `KEY_IMPORT` 只允许目标临时槽 3/4/5。
- 普通命令单帧 DATA 最大 512B。
- NO3 的 `0x40/0x41` 是 4 字节 LEN 的逻辑大帧，最大 128KB。

## 快速开始

```bash
cd otp_patch/test_tools

python3 sm2/sm2密钥对生成/sm2_keypair.py COM24
python3 sm2/sm2加解密/sm2_crypt.py COM24
python3 sm2/sm2签名验签/sm2_sign_verify.py COM24
python3 "sm2/sm2加解密密钥导入/sm2_key_import.py" COM24

python3 sm3/sm3单帧/sm3_oneshot_41.py COM24
python3 sm3/sm3异常输入/sm3_abnormal_41.py COM24
python3 sm3/sm3_speed/sm3_speed.py COM24

python3 sm4/sm4密钥生成/sm4_key_40.py COM24
python3 sm4/sm4ecb加解密/sm4_ecb_40.py COM24
python3 sm4/sm4cbc加解密/sm4_cbc_40.py COM24
python3 sm4/sm4异常输入/sm4_abnormal_40.py COM24
python3 sm4/sm4密钥导入导出/sm4_key_import_40.py COM24
python3 sm4/sm4ecb_speed/sm4_ecb_speed.py COM24
python3 sm4/sm4cbc_speed/sm4_cbc_speed.py COM24

python3 指令自检/selftest.py COM24
python3 读取id/get_uid.py COM24 --type all
```

详细说明从 [test_tool_skill/README.md](test_tool_skill/README.md) 开始。

## SM4 0x40 / SM3 0x41

```text
0x40 SM4_BULK：id + mode + op + [口令] + [IV] + data
0x41 SM3_BULK：data
```

- 0x40/0x41 都是 4 字节 LEN。
- 最大 128KB。
- 上位机可以拆成任意 n 次串口 write/read。
- 只对 NO3 固件有效；NO2 没有这两个命令。
- 128KB 用脚本发送，不要手工粘贴。

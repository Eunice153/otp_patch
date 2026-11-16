# OTP Patch 串口测试工具 Skill

本目录是 OTP patch 固件串口测试工具的使用说明、协议约定和调试记录。

## 目录

```text
otp_patch/test_tools/
├── common/                         # 公共串口/SM2/SM4 参考实现
│   ├── link.py                     # 帧格式、512B 上限、禁写 OTP 命令
│   ├── sm2_crypto.py               # 纯 Python SM2 参考实现
│   ├── sm2_tools.py                # SM2 临时槽/私钥导出
│   ├── sm3_tools.py                # SM3 单帧/参考摘要
│   ├── sm4_crypto.py               # 纯 Python SM4 参考实现
│   ├── sm4_tools.py                # SM4 临时槽/密钥恢复
│   ├── paths.py                    # 报告路径
│   └── wsl.py                      # WSL -> Windows Python
├── sm2/
│   ├── sm2密钥对生成/sm2_keypair.py
│   ├── sm2加解密/sm2_crypt.py
│   ├── sm2加解密密钥导入/sm2_key_import.py
│   ├── sm2签名验签/sm2_sign_verify.py
│   └── sm2_report/                 # 所有 SM2 脚本的默认报告目录
├── sm4/
│   ├── sm4密钥生成/sm4_key.py
│   ├── sm4ecb加解密/sm4_ecb.py
│   ├── sm4cbc加解密/sm4_cbc.py
│   ├── sm4密钥导入导出/sm4_key_import.py
│   ├── sm4异常输入/sm4_abnormal.py
│   └── sm4_report/                 # 所有 SM4 脚本的默认报告目录
├── sm3/
│   ├── sm3单帧/sm3_oneshot.py       # 0x10
│   ├── sm3单帧/sm3_oneshot_41.py    # NO3 0x41
│   ├── sm3异常输入/sm3_abnormal.py  # 0x10
│   ├── sm3异常输入/sm3_abnormal_41.py # NO3 0x41
│   └── sm3_report/                 # 所有 SM3 脚本的默认报告目录
├── 指令自检/selftest.py            # SELFTEST 0x50
├── 读取id/get_uid.py               # GET_UID 0x60
└── test_tool_skill/                # 本目录
    ├── README.md
    ├── SKILL.md
    ├── serial_protocol.md
    ├── sm2_tools.md
    ├── sm3_tools.md
    ├── sm4_tools.md
    ├── debugging.md
    └── otp_safety.md
```

## 最重要的规则

1. **不许写 OTP**：脚本只使用临时槽 3/4/5；禁止
   `SET_PASSWORD(0x05)`、`KEY_STORE(0x16)`、`KEY_DESTROY(0x18)`。
2. **普通命令单帧 DATA ≤ 512B**：大数据用 NO3 的
   `0x40/0x41` 逻辑大帧，流式 SM3 `0x1A/0x1B/0x1C` 已删除。
3. **SM2 解密明文 ≤ 64B**：ROM `boot_sm2_decrypt` 栈帧限制。
4. **报告统一放 `sm2/sm2_report/` 或 `sm4/sm4_report/`**，不要写到 `/tmp`。
5. **KEY_IMPORT 只允许目标临时槽 3/4/5**；SM2 导入槽 3、SM4 导入槽 5，
   并且需要芯片已有 OTP SM2 密钥。没有 OTP 密钥时脚本会停止并报告，
   不会自行写 OTP。
6. **read_me 里的 `/* ... */` 块是用户自己的总结，禁止修改**；
   需要补充说明只能写在块外。

## 快速开始

```bash
cd otp_patch/test_tools

# SM2
python3 sm2/sm2密钥对生成/sm2_keypair.py COM24
python3 sm2/sm2加解密/sm2_crypt.py COM24
python3 sm2/sm2签名验签/sm2_sign_verify.py COM24
python3 "sm2/sm2加解密密钥导入/sm2_key_import.py" COM24

# SM3
python3 sm3/sm3单帧/sm3_oneshot.py COM24
python3 sm3/sm3单帧/sm3_oneshot_41.py COM24
python3 sm3/sm3异常输入/sm3_abnormal.py COM24
python3 sm3/sm3异常输入/sm3_abnormal_41.py COM24

# 指令自检 / 读取 ID
python3 指令自检/selftest.py COM24
python3 读取id/get_uid.py COM24

# SM4
python3 sm4/sm4密钥生成/sm4_key.py COM24
python3 sm4/sm4ecb加解密/sm4_ecb.py COM24
python3 sm4/sm4cbc加解密/sm4_cbc.py COM24
python3 sm4/sm4异常输入/sm4_abnormal.py COM24
python3 sm4/sm4密钥导入导出/sm4_key_import.py COM24
```

WSL 下检测到 `COMx` 会自动转用 Windows Python。报告默认写到
对应算法的 `*_report/` 目录。

每个脚本目录下另有 `read_me.txt`，给出该脚本的具体操作步骤、
参数、发送的命令和报告字段。

详细说明见：

- [SKILL.md](SKILL.md) —— 工具使用总则
- [serial_protocol.md](serial_protocol.md) —— 串口帧格式、命令、512B 上限
- [sm2_tools.md](sm2_tools.md) —— SM2 脚本的参数和输出
- [sm3_tools.md](sm3_tools.md) —— SM3 脚本的参数和输出
- [sm4_tools.md](sm4_tools.md) —— SM4 脚本的参数和输出
- [debugging.md](debugging.md) —— WSL/COM/超时/常见错误
- [otp_safety.md](otp_safety.md) —— OTP 安全红线

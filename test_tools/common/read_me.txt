common 公共模块 read_me

本目录不是测试入口，不直接运行。它给 sm2/ 下的脚本提供公共代码：

- wsl.py        WSL + COMx 时转用 Windows Python
- link.py       串口帧格式、512B 上限、禁写 OTP 命令
- sm2_crypto.py 纯 Python SM2 参考实现
- sm2_tools.py  临时槽准备/私钥导出
- paths.py      报告路径

使用方式：直接运行 sm2/ 下各脚本，脚本会自动 import 本目录。

安全规则：
- 只使用临时槽 3/4/5；
- 禁止 SET_PASSWORD(0x05)、KEY_STORE(0x16)、KEY_DESTROY(0x18)；
- 单帧 DATA 最大 512B。

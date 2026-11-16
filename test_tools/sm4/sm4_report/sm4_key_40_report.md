# SM4 密钥生成报告（0x40）

测试时间：2026-11-16 19:03:09

安全说明：只使用临时槽 5（RAM），不发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY，不写 OTP。

说明：本脚本用 NO3 的 `0x40 SM4_BULK` 做 ECB 自检；原 `0x20` 版本 `sm4_key.py` 保留。

| 项目 | 结果 |
|---|---|
| GENKEY(5) | OK |
| LOAD_PUBKEY(TEST_D) | OK |
| EXPORT_KEY(5,1) / 解包 | OK |
| 密钥 K（16B，临时） | `39 65 2C A9 2B 88 25 AB 1A 3F 2B 1D 10 D6 53 B4` |
| 0x40 ECB 加密自检 | OK |
| 0x40 ECB 解密自检 | OK |

结论：全部符合预期

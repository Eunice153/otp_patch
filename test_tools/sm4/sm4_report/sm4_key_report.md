# SM4 密钥生成报告

测试时间：2026-11-16 18:18:20

安全说明：只使用临时槽 5（RAM），不发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY，不写 OTP。

说明：`EXPORT_KEY` 是固件命令 0x13（历史名字 `CMD_SM4_EXPORT`）；SM4 槽返回 112B（64 C1 + 32 C3 + 16 C2）。

| 项目 | 结果 |
|---|---|
| GENKEY(5) | OK |
| LOAD_PUBKEY(TEST_D) | OK |
| EXPORT_KEY(5,1) / 解包 | OK |
| 密钥 K（16B，临时） | `CD 45 B1 7C 20 30 4B 71 FA 8B E4 88 5E F1 D9 A4` |
| ECB 加密自检 | OK |
| ECB 解密自检 | OK |

结论：全部符合预期

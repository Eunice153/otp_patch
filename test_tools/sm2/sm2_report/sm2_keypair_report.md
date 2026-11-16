# SM2 密钥对生成报告

测试时间：2026-11-16 19:47:21

安全说明：只使用临时槽 3/4（RAM），不发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY，不写 OTP。

命令流程：`GENKEY(slot)` → `GETPUBKEY(slot)` → `LOAD_PUBKEY(TEST_D 公钥)` → `EXPORT_KEY(slot, 1)`，上位机用 TEST_D 解出私钥并校验公私钥匹配。

说明：`EXPORT_KEY` 是固件命令 0x13（历史名字 `CMD_SM4_EXPORT`），为通用密钥导出；SM2 槽返回 128B，与 SM4 加密无关。

| 槽位 | GENKEY | 公钥 X | 公钥 Y | LOAD_PUBKEY | 私钥导出 | 公私钥匹配 | 结果 |
|---|---|---|---|---|---|---|---|
| 3 | OK | `FF 7F F3 09 B0 92 FE C6 F6 E4 80 68 BF D3 7F 97 58 2E 84 DD 84 97 E0 48 49 CA 66 C9 B7 F3 AF 92` | `33 7D 72 5E 65 27 1D 07 56 F3 27 81 50 7C 60 03 04 2E BB 70 FE 59 39 31 3C AD 7D BD 15 8D 9A 9C` | OK | OK | OK | 通过 |
| 4 | OK | `BD 19 23 92 3D 0B E4 C0 DA 95 E3 1A 0C 48 15 FB 5A D0 AF F0 51 23 59 F1 E8 55 81 E0 FE CB 50 96` | `3C CA 1A 7C 11 46 F6 CF 05 E1 68 CB CA 51 BB B5 96 34 2A 8D 64 71 3C 5A 6C 69 86 CE 61 AF 83 03` | OK | OK | OK | 通过 |

结论：全部符合预期

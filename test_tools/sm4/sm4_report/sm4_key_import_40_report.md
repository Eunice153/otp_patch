# SM4 密钥导入报告（0x40）

测试时间：2026-11-16 22:20:31

安全说明：`KEY_LOAD` 只读加载 OTP 密钥到 SRAM；`KEY_IMPORT` 只写临时槽 5（RAM）。本脚本不发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY，不写 OTP。

说明：本脚本用 NO3 的 `0x40 SM4_BULK` 做导入后 ECB 验证。

| 项目 | 值 |
|---|---|
| OTP 解密密钥槽 | 0 |
| OTP 密钥加载 (KEY_LOAD) | 0x00 |
| OTP 公钥 | `DA 16 5B 7E 00 69 F0 CA 3F BF A1 C1 9B 34 83 60 FF 76 75 2E 3F AB 93 1C 9C EA 03 1A 7E 36 58 E4 61 D9 49 A2 DE 69 25 DD FC 40 6E 52 4D 93 CE EC 47 A6 DB 1A 6D 58 B3 46 47 2B 5C 48 A9 57 EE 6A` |
| 导入目标 | 临时槽 5 |
| 导入密钥 K | 已校验（不显示；加 --show-key 可显示） |
| 包裹密文（SM2） | `36 97 8F D9 13 F3 94 3C 52 A8 55 17 D1 D5 70 14 26 DA 04 FE 2B F1 88 28 12 0B 7C F5 65 B7 3D C4 4A 6D 98 4C 6B 7F 32 0B E3 85 35 26 24 6F 0C E3 76 A8 9C 87 9E 6B FE E6 AD 2C 42 1E 65 13 53 45 28 40 E9 9F 87 CF 5B 86 EC 9B C7 55 67 DA FC 14 17 78 8B 90 EC 5F DA 2D D8 9C 2D A7 23 3C 91 E5 B7 CA 1E B4 85 2E 9D 27 76 E6 D2 B4 6E BF 9B D6` |
| KEY_IMPORT 状态 | 0x00 |

| 校验项 | 结果 |
|---|---|
| 导出密钥匹配 | OK |
| 0x40 ECB 加密 | OK |
| 0x40 ECB 解密 | OK |

结论：全部符合预期

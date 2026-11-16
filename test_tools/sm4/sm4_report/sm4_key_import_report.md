# SM4 密钥导入报告

测试时间：2026-11-16 15:26:49

安全说明：`KEY_LOAD` 只读加载 OTP 密钥到 SRAM；`KEY_IMPORT` 只写临时槽 5（RAM）。本脚本不发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY，不写 OTP。

| 项目 | 值 |
|---|---|
| OTP 解密密钥槽 | 0 |
| OTP 密钥加载 (KEY_LOAD) | 未提供 --password（跳过 KEY_LOAD） |
| OTP 公钥 | 未加载/读取失败（可加 --password 先 KEY_LOAD） |
| 导入目标 | 临时槽 5 |
| 导入密钥 K | 未导入（候选值已生成；加 --show-key 可显示） |
| KEY_IMPORT 状态 | 未执行 |

| 校验项 | 结果 |
|---|---|
| OTP 公钥 | 未加载/读取失败，未执行导入 |

结论：存在失败/未执行项

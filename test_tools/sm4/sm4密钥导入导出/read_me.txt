SM4 密钥导入导出测试 read_me
/*密钥的导入需要otp槽位有数据需要借助otp槽位 0 1解密导入的密钥*/
一、用途
测试 KEY_IMPORT：上位机生成一个 16B SM4 密钥，用芯片已有 OTP
解密槽公钥做 SM2 包裹，再导入到临时槽 5，然后验证：
1. EXPORT_KEY(5,1) 导出的密钥与导入的密钥一致。
2. 用导入密钥做 SM4 ECB 加密/解密，与 Python 参考实现一致。

二、重要前提
必须已有 OTP SM2 解密密钥（dec_id=0）或签名密钥（dec_id=1），
并且已经通过 KEY_LOAD 把它从 OTP 读进 SRAM。没有时脚本会停止并写
“未加载/未执行”，不会写 OTP。

如果 OTP 密钥已配置但还没有加载到 SRAM，可以加 --password：
    --password 会发送 KEY_LOAD(dec_id, 口令)
    KEY_LOAD 是只读加载 OTP→SRAM，不写 OTP。

本脚本只：
- KEY_LOAD(dec_id)：只读加载 OTP 密钥到 SRAM；
- GETPUBKEY(dec_id)：只读 OTP 公钥；
- KEY_IMPORT(target=5)：只写临时槽 5；
- 不会发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY。

三、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。
4. 确认芯片 OTP 槽 0/1 已有 SM2 密钥；空片无法执行导入。

四、运行命令

进入本目录：
    cd otp_patch/test_tools/sm4/sm4密钥导入导出
    python3 sm4_key_import.py COM24

从 test_tools 根目录：
    python3 sm4/sm4密钥导入导出/sm4_key_import.py COM24

常用参数：
    --dec-id 0|1        OTP 解密槽，默认 0
    --password <口令>   可选：先 KEY_LOAD 只读加载 OTP 密钥到 SRAM
    --key <32位hex>     指定导入的 16B SM4 密钥；不填则随机生成
    --show-key          显示导入/候选密钥
    --out ./xxx.md      改报告路径

示例：
    python3 sm4_key_import.py COM24 --dec-id 0
    python3 sm4_key_import.py COM24 --password "123456789012"
    python3 sm4_key_import.py COM24 --key 0123456789ABCDEFFEDCBA9876543210

五、实际发送的命令
    KEY_LOAD(0/1, 口令)              可选，只读加载 OTP→SRAM
    GETPUBKEY(0) 或 GETPUBKEY(1)    只读 OTP 公钥
    KEY_IMPORT(5, dec_id, 1, 包裹密文)
    LOAD_PUBKEY(TEST_D 公钥)
    EXPORT_KEY(5, 1)
    SM4_CRYPT(id=5, ECB, 加密/解密)

六、报告
默认：
    ../sm4_report/sm4_key_import_report.md

内容：
    OTP 解密槽、OTP 密钥加载状态、OTP 公钥、导入目标、
    导入/候选密钥、包裹密文、KEY_IMPORT 状态、
    导出密钥匹配、ECB 加密/解密结果。

七、当前空片结果
    GETPUBKEY(0): 未加载/未配置；停止（不会写 OTP）
    结论：存在失败/未执行项

如果 OTP 已配置但未加载，先加 --password 触发只读 KEY_LOAD，
或换到已加载 OTP 密钥的样片后重新运行。

八、常见问题
- GETPUBKEY(0/1) 失败：OTP 未配置/未加载；不要尝试 SET_PASSWORD/KEY_STORE。
- KEY_IMPORT 返回 FE：检查 target 是否 5、dec_id 是否 0/1、
  包裹密文长度是否 112B、std 是否 1。
- 导出密钥不匹配：确认包裹用的是 dec_id 对应的 OTP 公钥。
- ECB 失败：检查导入密钥是否 16B、SM4 固件路径是否正常。

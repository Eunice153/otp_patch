SM2 加解密密钥导入测试 read_me
/*这个需要保证使用0 / 1槽位的数据写过otp密钥了。*/


一、用途
测试 KEY_IMPORT：上位机生成一个 SM2 私钥 d，用芯片已有 OTP
解密槽公钥做 SM2 包裹，再导入到临时槽 3，然后验证：
1. GETPUBKEY(3) 与 d 推导的公钥一致。
2. 导出临时槽 3 私钥，与 d 一致。
3. 用导入密钥做 SM2_ENC → SM2_DEC(3) 解密。

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
- KEY_IMPORT(target=3)：只写临时槽 3；
- 不会发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY。

三、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。
4. 确认芯片 OTP 槽 0/1 已有 SM2 密钥；空片无法执行导入。

四、运行命令

进入本目录：
    cd otp_patch/test_tools/sm2/sm2加解密密钥导入
    python3 sm2_key_import.py COM24

从 test_tools 根目录：
    python3 "sm2/sm2加解密密钥导入/sm2_key_import.py" COM24

常用参数：
    --dec-id 0|1        OTP 解密槽，默认 0
    --password <口令>   可选：先 KEY_LOAD 只读加载 OTP 密钥到 SRAM
    --key <64位hex>     指定导入私钥；不填则随机生成
    --show-private      显示导入/候选私钥
    --out ./xxx.md      改报告路径

示例：
    python3 sm2_key_import.py COM24 --dec-id 0
    python3 sm2_key_import.py COM24 --password "123456789012"
    python3 sm2_key_import.py COM24 --key 1234...（32B hex）

五、实际发送的命令
    KEY_LOAD(0/1, 口令)              可选，只读加载 OTP→SRAM
    GETPUBKEY(0) 或 GETPUBKEY(1)    只读 OTP 公钥
    KEY_IMPORT(3, dec_id, 1, 包裹密文)
    GETPUBKEY(3)
    LOAD_PUBKEY(TEST_D 公钥)
    EXPORT_KEY(3, 1)        （固件旧名 SM4_EXPORT）
    SM2_ENC / SM2_DEC(3)

六、报告
默认：
    ../sm2_report/sm2_key_import_report.md

内容：
    OTP 解密槽、OTP 公钥、导入目标、导入/候选私钥、导入/候选公钥、
    包裹密文、KEY_IMPORT 状态、公钥匹配、私钥匹配、解密测试。

七、当前空片结果
    GETPUBKEY(0): 未加载/未配置；停止（不会写 OTP）
    结论：存在失败/未执行项

如果 OTP 已配置但未加载，先加 --password 触发只读 KEY_LOAD，
或换到已加载 OTP 密钥的样片后重新运行。

八、常见问题
- GETPUBKEY(0/1) 失败：OTP 未配置；不要尝试 SET_PASSWORD/KEY_STORE。
- KEY_IMPORT 返回 FE：检查 target 是否 3、dec_id 是否 0/1、
  包裹密文长度是否 128B、std 是否 1。
- 导入后公钥不匹配：确认包裹用的是 dec_id 对应的 OTP 公钥。
- 导入后解密失败：检查 SM2_DEC pt_len 是否 ≤64。



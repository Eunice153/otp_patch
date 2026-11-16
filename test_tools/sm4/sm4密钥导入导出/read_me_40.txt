SM4 密钥导入（0x40 验证）read_me
/*密钥的导入需要otp槽位有数据需要借助otp槽位 0 1解密导入的密钥*/
一、用途

    KEY_LOAD(dec_id, 口令)            可选：只读加载 OTP 密钥到 SRAM
    GETPUBKEY(dec_id)                 只读 OTP 公钥
    上位机生成/指定 16B SM4 密钥
    用 OTP 公钥做 SM2 包裹
    KEY_IMPORT(target=5, dec_id, 1, wrapped)
    EXPORT_KEY(5,1) 导出并比对
    ECB 加密/解密验证导入密钥

最后的 ECB 验证走 NO3 的 0x40。

二、重要前提
必须已有 OTP SM2 解密密钥（dec_id=0）或签名密钥（dec_id=1），
并且已经通过 KEY_LOAD 从 OTP 读进 SRAM。

- 空片会停止，报告“未加载/未执行”，不会写 OTP。
- 如果 OTP 密钥已配置但未加载，可以加 --password：
    --password 触发 KEY_LOAD，只读加载 OTP→SRAM，不写 OTP。
- 本脚本只写临时槽 5（RAM）。

三、运行
进入本目录：
    cd otp_patch/test_tools/sm4/sm4密钥导入导出
    python3 sm4_key_import_40.py COM24

从 test_tools 根目录：
    python3 sm4/sm4密钥导入导出/sm4_key_import_40.py COM24

常用参数：
    --dec-id 0|1        OTP 解密槽，默认 0
    --password <口令>   可选：先 KEY_LOAD 只读加载 OTP 密钥
    --key <32位hex>     指定导入的 16B SM4 密钥
    --show-key          显示导入/候选密钥
    --timeout 30
    --out ./xxx.md

示例：
    python3 sm4_key_import_40.py COM24 --dec-id 0
    python3 sm4_key_import_40.py COM24 --password "123456789012"
    python3 sm4_key_import_40.py COM24 \
        --key 0123456789ABCDEFFEDCBA9876543210

四、实际发送
    KEY_LOAD(0/1, 口令)              可选，只读
    GETPUBKEY(0/1)                   只读
    KEY_IMPORT(5, dec_id, 1, 包裹密文)
    LOAD_PUBKEY(TEST_D)
    EXPORT_KEY(5,1)
    0x40 SM4_BULK ECB 加密/解密

不会发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY，不写 OTP。

五、报告
默认：
    ../sm4_report/sm4_key_import_40_report.md

内容：
    OTP 解密槽、KEY_LOAD 状态、OTP 公钥、导入目标、
    包裹密文、KEY_IMPORT 状态、导出密钥匹配、
    0x40 ECB 加密/解密结果。

六、当前空片
    GETPUBKEY(0): 未加载/未配置；停止，不写 OTP
    结论：存在失败/未执行项

七、常见问题
- GETPUBKEY 失败：OTP 未配置/未加载；不要用 SET_PASSWORD/KEY_STORE 修复。
- KEY_IMPORT 返回 FE：检查 target=5、dec_id=0/1、包裹 112B、std=1。
- 0x40 无应答：确认烧的是 NO3；0x40 是 4 字节 LEN。
- 导出密钥不匹配：确认包裹用 dec_id 对应的 OTP 公钥。

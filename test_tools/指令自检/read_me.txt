指令自检 read_me

一、用途
发送 SELFTEST(0x50) 让设备执行自检：
- bit0: TRNG 自检
- bit1: SM3 KAT（abc）
- bit2: SM4 KAT（标准向量）
- bit3: SM2 KAT（生成/签名/验签）

自检只使用 RAM 临时槽，不写 OTP。

二、运行前
1. 关闭占用 COM 口的串口助手/烧写工具。
2. WSL 下 python3 会自动转 Windows Python。
3. 需要 pyserial。
4. SM2 KAT 会生成临时槽 4 的密钥，需要几秒，脚本超时 30s。

三、运行命令

进入本目录：
    cd otp_patch/test_tools/指令自检
    python3 selftest.py COM24

从 test_tools 根目录：
    python3 指令自检/selftest.py COM24

常用参数：
    --mask 0x000F     只跑 TRNG/SM3/SM4/SM2 四项（默认固件 mask=0xFFFF）
    --mask 0x0001     只跑 TRNG
    --mask 0x0002     只跑 SM3 KAT
    --timeout 5       单次等待超时，单项定位时可用短超时
    --baud 921600
    --out ./xxx.md

四、实际发送的命令
    SELFTEST 0x50
    可选 DATA = [mask_H, mask_L]
    不传 DATA 时固件使用 mask=0xFFFF

应答：
    5A 50 00 00 04 <result 4B 大端>
    result 的 bit=0 表示该项通过

五、报告
默认：
    ./selftest_report.md

内容：
    mask、完整发送/返回、STATUS、result、
    每个 bit 的自检项/是否选择/结果。

六、预期结果
    STATUS=0x00
    result=0x00000000
    结论：全部符合预期

七、常见问题
- 打开 COM 失败：端口被占用。
- result 非 0：对应 bit 的自检失败，例如 bit1=SM3 KAT 失败。
- SM2 KAT 较慢：不要用太短的超时。
- 自检不写 OTP；失败时不要用写 OTP 的方式“修复”。

八、无应答时怎么处理
如果 SELFTEST 无应答：

1. 复位/重新上电；
2. 先用 --mask 0x0000 确认命令通路（应返回 result=0）；
3. 再逐项定位：
   --mask 0x0001  TRNG
   --mask 0x0002  SM3 KAT
   --mask 0x0004  SM4 KAT
   --mask 0x0008  SM2 KAT
4. 如果某一项一跑就无应答，记录该项，不要继续反复发送；
5. 不要用 SET_PASSWORD / KEY_STORE 等写 OTP 方式处理。

当前 NO2 固件复位后实测：
    0x0000 / 0x0001 / 0x0002 / 0x0004 / 0x0008 / 0x000F / 0xFFFF
    均返回 result=0x00000000。


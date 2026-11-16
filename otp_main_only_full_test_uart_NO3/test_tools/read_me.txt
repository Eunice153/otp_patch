一、SM3

流式 0x1A/0x1B/0x1C 已删除，sm3_stream_test.py / sm3_abnormal_test.py 已删除。

请使用 otp_patch/test_tools/sm3/ 下的新测试：

    cd otp_patch/test_tools
    python3 sm3/sm3单帧/sm3_oneshot.py COM24         # 0x10，≤512B
    python3 sm3/sm3单帧/sm3_oneshot_41.py COM24      # NO3 0x41，≤128KB
    python3 sm3/sm3异常输入/sm3_abnormal.py COM24    # 0x10 边界
    python3 sm3/sm3异常输入/sm3_abnormal_41.py COM24 # NO3 0x41 边界

SM3 不使用密钥，不涉及 OTP。

二、SM4

1.用法
python3 sm4_slot_test.py COM24                          # 正确性 + 128KB 速率（运行前询问次数）
python3 sm4_slot_test.py COM24 --runs 3                 # 直接指定 3 次
python3 sm4_slot_test.py COM24 --runs 0                 # 只做正确性
python3 sm4_slot_test.py COM24 --skip-correctness --runs 3   # 只做速率
python3 sm4_slot_test.py COM24 --cbc-rate               # 追加 CBC 128KB 速率

2.说明

- 临时槽 5 的密钥通过 GENKEY(5) + LOAD_PUBKEY + 0x13 导出恢复，不读 OTP
- 正确性长度 16/32/64/256/480 B；单帧 DATA 上限 512 B
- 硬件 CALC_LEN 实际只有 1 bit；OTP patch 的 SM4_enc_dec_process 已按 16 B 逐块调用
  （ECB 加密/解密逐块循环，CBC 单 IV 逐块链式），串口可传任意 16 B 倍数的数据
- 128KB 速率：ECB 按 256 B 分帧；CBC 由上位机管理 IV
- 串口工具不要占用同一个 COM 口

三、SM2

1.用法
python3 sm2_test.py COM24                     # 运行前询问速率次数
python3 sm2_test.py COM24 --runs 0            # 只做 5 组正确性
python3 sm2_test.py COM24 --runs 3            # 5 组正确性 + 20 组 × 3 次速率
python3 sm2_test.py COM24 --skip-correctness --runs 3   # 只做速率

2.说明

- 5 组长度：16/24/32/48/64 B
- SM2 解密明文上限 64 B：ROM boot_sm2_decrypt 固定 352B 栈帧，
  明文缓冲区在 sp+288，超过 64B 会写穿栈帧卡死；新固件 pt_len>64 返回 FE
- 使用临时槽 3（解密）/ 槽 4（签名），不写 OTP
- 私钥通过 LOAD_PUBKEY(TEST_D) + 0x13 导出，仅用于上位机交叉校验
- 串口工具不要占用同一个 COM 口

四、SM2 认证报告

1.用法
python3 sm2_cert_report.py COM24
python3 sm2_cert_report.py COM24 --out /tmp/sm2_report.md

2.输出

- 默认写入脚本同目录 sm2_cert_report.md
- --out /tmp/... 是 WSL 内部路径，Windows 资源管理器看不到；
  可在 Windows 里打开 \\wsl.localhost\Ubuntu-22.04\tmp\...
- 内容：2.1 串口命令接口 / 2.1.1 SM2 算法
  (1) 密钥对生成：槽 3、槽 4 各 5 组，公钥与私钥推导公钥比对
  (2) 加密：5 组固定明文 + 固定 k，上位机独立解密
  (3) 解密：设备密文 + 上位机参考密文，各 5 组
  (4) 签名：5 组 SM3 摘要 + 固定 k，上位机独立验签
  (5) 验证：正常签名 01 / 篡改 00 / 上位机签名 01
- 固定 k = SM3(label) mod (n-1) + 1，报告中记录，便于复算
- 不导出私钥明文，不写 OTP

五、填入 Word 报告

1.用法
python3 fill_sm2_doc.py                 # 填 2.1 并覆盖 公钥-2.doc
python3 fill_sm2_doc.py --no-apply      # 只生成 temp/公钥-2_filled.doc
python3 fill_sm2_doc.py --force         # 忽略 ~$ 锁文件强制覆盖

2.说明

- 读取 sm2_cert_report.md 的 (1)~(5)，生成 temp/sec1~5.html
- 用 Windows Word COM 填进 公钥-2.doc 的 2.1 章节
- 原文档备份：temp/公钥-2_原始备份.doc
- 工作副本：temp/公钥-2_work.doc；输出：temp/公钥-2_filled.doc
- 原文档被 WPS 打开时（存在 ~$公钥-2.doc）会拒绝覆盖
- 目录（TOC）不动，2.1/2.1.1 两行和页码请在 WPS 里手动更新

六、SM4 认证报告

1.用法
python3 sm4_cert_report.py COM24
python3 sm4_cert_report.py COM24 --out /tmp/sm4_report.md

2.输出

- 默认写入脚本同目录 sm4_cert_report.md
- --out /tmp/... 是 WSL 内部路径，Windows 资源管理器看不到；
  可在 Windows 里打开 \\wsl.localhost\Ubuntu-22.04\tmp\...
- 内容：2.1 串口命令接口 / 2.1.1 SM4 算法
  (1) 加密(ECB模式)：5 组，设备密文 vs 独立 Python SM4
  (2) 解密(ECB模式)：5 组，设备明文 vs 原文
  (3) 加密(CBC模式)：固定 IV，设备密文 vs 参考
  (4) 解密(CBC模式)：固定 IV，设备明文 vs 原文
- 5 组长度：16/32/64/256/480 B；明文规则 pt[i] = i & 0xFF
- 密钥：GENKEY(5) 生成临时槽 5 密钥，SM4_EXPORT(5,1) 包裹导出，
  上位机用 TEST_D 做 SM2 解密恢复；不写 OTP
- 报告记录本次密钥 K 和 CBC IV，可用标准 SM4 库复算
- 重新运行 GENKEY(5) 会得到新密钥，报告数据随之变化

七、SM4 非正常输入

1.用法
python3 sm4_abnormal_test.py COM24
python3 sm4_abnormal_test.py COM24 --out ./sm4_abnormal.md

2.覆盖

- 数据长度 0 / 非 16 字节倍数
- 非法 id / mode / op
- CBC 缺 IV，或 IV 后数据不是 16 的倍数
- 默认不含 OTP 槽、未知命令和帧层异常用例

3.输出

- 默认 sm4_abnormal_report.md（脚本同目录，推荐）
- --out /tmp/... 是 WSL 内部路径，Windows 资源管理器看不到；
  可在 Windows 里打开 \\wsl.localhost\Ubuntu-22.04\tmp\...
- 脚本在 WSL 下会自动把 --out 路径转成 Windows 路径，实际写入位置以
  运行结束打印的“报告已写入”为准
- 表格：序号 / 非正常输入 / 完整发送数据 / 完整返回数据 / 设备响应 / 预期 / 结论
- 完整发送/返回数据为整帧 HEX（含帧头）；无应答显示“无（超时）”
- 当前固件：上述非法参数/长度返回 FE；基线 ECB 16B 返回 00
- 脚本只发送 GENKEY(5) 和 SM4_CRYPT，使用临时槽 5，不写 OTP

八、填入 SM4 Word 报告

1.用法
python3 fill_sm4_doc.py

2.说明

- 读取 sm4_cert_report.md 的 (1)~(4)
- 填进 分组-2.doc 的 2.1 串口命令接口 / 2.1.1 SM4 算法
- 只填 2.1，2.2 XXX接口保持原样
- 输出：分组-2_已填.doc；原文档不覆盖
- 表格 7pt、带边框；不做 AutoFit，避免大表格导致 Word OOM
- 目录（TOC）不动，请在 Word/WPS 里手动更新
- 临时文件在 temp_sm4/
- 480 B 行很长，可能跨页
- 重新跑 sm4_cert_report.py 后，需要重跑 fill_sm4_doc.py 更新文档
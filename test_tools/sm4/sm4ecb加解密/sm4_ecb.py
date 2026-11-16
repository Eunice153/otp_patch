#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM4 ECB 加解密正确性测试（临时槽 5，不写 OTP）。

流程：
    GENKEY(5) + LOAD_PUBKEY(TEST_D) + EXPORT_KEY(5,1) 恢复 16B 密钥
    5 组长度：
      ECB 加密 -> 设备密文 vs Python 参考
      ECB 解密 -> 设备明文 vs 原文

报告默认写入 ../../sm4_report/sm4_ecb_report.md。
"""

import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
TEST_TOOLS = os.path.abspath(os.path.join(HERE, "..", ".."))
if TEST_TOOLS not in sys.path:
    sys.path.insert(0, TEST_TOOLS)

from common.wsl import maybe_relaunch

maybe_relaunch(__file__)

from common.link import Link, hex_bytes  # noqa: E402
from common.sm4_crypto import sm4_ecb_encrypt  # noqa: E402
from common.sm4_tools import (  # noqa: E402
    SM4_ECB, SM4_ENCRYPT, SM4_DECRYPT, recover_key, sm4_crypt,
)
from common.paths import default_report, now_str, write_report  # noqa: E402


def dev_crypt(link, op, data):
    res = sm4_crypt(link, SM4_ECB, op, None, data)
    if res is None or res[0] != 0:
        return None
    return res[1]


def main():
    ap = argparse.ArgumentParser(description="SM4 ECB 加解密（临时槽 5，不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--lengths", default="16,32,64,256,480",
                    help="明文长度列表，逗号分隔，最大 480")
    ap.add_argument("--out", default=default_report(__file__, "sm4_ecb_report.md"))
    args = ap.parse_args()

    lens = [int(x, 0) for x in args.lengths.split(",") if x.strip()]
    if not lens or any(n < 16 or n > 480 or n % 16 for n in lens):
        raise SystemExit("长度必须是 16..480 且为 16 的倍数")

    print("[安全] 只使用临时槽 5，不发送写 OTP 命令", flush=True)
    link = Link(args.port, args.baud)
    rows = []
    key = None
    try:
        info = recover_key(link, regenerate=True)
        key = info["key"]
        print("  GENKEY(5): %s" % ("OK" if info["genkey"] else "FAIL"),
              flush=True)
        print("  EXPORT_KEY(5,1)/解包: %s" % (
            "OK" if info["export"] else "FAIL"), flush=True)
        if key:
            print("  密钥 K: %s" % hex_bytes(key), flush=True)
            for i, n in enumerate(lens, 1):
                pt = bytes(x & 0xFF for x in range(n))
                ect = dev_crypt(link, SM4_ENCRYPT, pt)
                ref_ect = sm4_ecb_encrypt(key, pt) if ect is not None else None
                ok_ect = bool(ect is not None and ect == ref_ect)
                edec = (dev_crypt(link, SM4_DECRYPT, ect)
                        if ect is not None else None)
                ok_edec = bool(edec is not None and edec == pt)
                rows.append({"i": i, "n": n, "pt": pt, "ect": ect,
                             "ref_ect": ref_ect, "edec": edec,
                             "ok_ect": ok_ect, "ok_edec": ok_edec})
                print("  第 %d 组（%3d B）：ECB 加密%s ECB 解密%s"
                      % (i, n, "OK" if ok_ect else "FAIL",
                         "OK" if ok_edec else "FAIL"), flush=True)
    finally:
        link.close()

    ok_all = bool(key) and bool(rows) and all(
        r["ok_ect"] and r["ok_edec"] for r in rows)

    def cell(data):
        return "`%s`" % hex_bytes(data) if data is not None else "-"

    md = []
    md.append("# SM4 ECB 加解密报告\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：只使用临时槽 5（RAM），不发送 SET_PASSWORD / "
              "KEY_STORE / KEY_DESTROY，不写 OTP。\n\n")
    md.append("测试参数：\n\n")
    md.append("- 串口：%s，%d bps\n" % (args.port, args.baud))
    md.append("- 密钥 K（16B，临时）：`%s`\n"
              % (hex_bytes(key) if key else "-"))
    md.append("- 长度：%s B\n" % "/".join(str(r["n"]) for r in rows))
    md.append("- 明文规则：`pt[i] = i & 0xFF`\n\n")
    if not rows:
        md.append("密钥准备失败，未执行 ECB 用例。\n\n")
    else:
        md.append("## (1) 加密(ECB)\n\n")
        md.append("| 组 | 明文长度 | 明文 | 设备密文 | 参考密文 | 结论 |\n")
        md.append("|---|---|---|---|---|---|\n")
        for r in rows:
            md.append("| %d | %d | %s | %s | %s | %s |\n"
                      % (r["i"], r["n"], cell(r["pt"]), cell(r["ect"]),
                         cell(r["ref_ect"]), "通过" if r["ok_ect"] else "失败"))
        md.append("\n## (2) 解密(ECB)\n\n")
        md.append("| 组 | 密文长度 | 输入密文 | 设备明文 | 预期明文 | 结论 |\n")
        md.append("|---|---|---|---|---|---|\n")
        for r in rows:
            md.append("| %d | %d | %s | %s | %s | %s |\n"
                      % (r["i"], r["n"], cell(r["ect"]), cell(r["edec"]),
                         cell(r["pt"]), "通过" if r["ok_edec"] else "失败"))
    md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在失败项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if ok_all else "存在失败项"))
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

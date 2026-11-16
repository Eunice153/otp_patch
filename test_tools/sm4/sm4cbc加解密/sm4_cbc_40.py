#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM4 CBC 加解密正确性测试（0x40，临时槽 5，不写 OTP）。

流程：
    GENKEY(5) + LOAD_PUBKEY(TEST_D) + EXPORT_KEY(5,1) 恢复 16B 密钥
    固定 IV：
      0x40 CBC 加密 -> 设备密文 vs Python 参考
      0x40 CBC 解密 -> 设备明文 vs 原文

报告默认写入 ../../sm4_report/sm4_cbc_40_report.md。
"""

import argparse
import hashlib
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
TEST_TOOLS = os.path.abspath(os.path.join(HERE, "..", ".."))
if TEST_TOOLS not in sys.path:
    sys.path.insert(0, TEST_TOOLS)

from common.wsl import maybe_relaunch

maybe_relaunch(__file__)

from common.link import Link, hex_bytes  # noqa: E402
from common.sm4_bulk import DEFAULT_IV, MAX_DATA, bulk_crypt  # noqa: E402
from common.sm4_crypto import sm4_cbc_encrypt  # noqa: E402
from common.sm4_tools import (  # noqa: E402
    SM4_CBC, SM4_ENCRYPT, SM4_DECRYPT, recover_key,
)
from common.paths import default_report, now_str, write_report  # noqa: E402


def dev_crypt(link, op, iv, data, timeout, writes, reads):
    res = bulk_crypt(link, SM4_CBC, op, iv, data,
                     timeout=timeout, writes=writes, reads=reads)
    if res is None or res[0] != 0:
        return None
    return res[1]


def cell(data):
    if data is None:
        return "-"
    if len(data) <= 512:
        return "`%s`" % hex_bytes(data)
    return "`sha256=%s`（%d B）" % (
        hashlib.sha256(data).hexdigest(), len(data))


def main():
    ap = argparse.ArgumentParser(
        description="SM4 CBC 加解密（0x40，临时槽 5，不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--lengths", default="16,32,64,256,480",
                    help="明文长度列表，逗号分隔，最大 131072")
    ap.add_argument("--iv", default=None,
                    help="可选：16B IV hex，默认 00 01 ... 0F")
    ap.add_argument("--timeout", type=float, default=120.0)
    ap.add_argument("--writes", type=int, default=1)
    ap.add_argument("--reads", type=int, default=1)
    ap.add_argument("--out",
                    default=default_report(__file__, "sm4_cbc_40_report.md"))
    args = ap.parse_args()

    lens = [int(x, 0) for x in args.lengths.split(",") if x.strip()]
    if not lens or any(n < 16 or n > MAX_DATA or n % 16 for n in lens):
        raise SystemExit("长度必须是 16..131072 且为 16 的倍数")

    if args.iv:
        iv = bytes.fromhex(args.iv.replace(" ", ""))
        if len(iv) != 16:
            raise SystemExit("--iv 必须是 16B（32 个 hex 字符）")
    else:
        iv = DEFAULT_IV

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
            print("  IV: %s" % hex_bytes(iv), flush=True)
            for i, n in enumerate(lens, 1):
                pt = bytes(x & 0xFF for x in range(n))
                cct = dev_crypt(link, SM4_ENCRYPT, iv, pt,
                                args.timeout, args.writes, args.reads)
                ref_cct = sm4_cbc_encrypt(key, iv, pt) if cct is not None else None
                ok_cct = bool(cct is not None and cct == ref_cct)
                cdec = (dev_crypt(link, SM4_DECRYPT, iv, cct,
                                  args.timeout, args.writes, args.reads)
                        if cct is not None else None)
                ok_cdec = bool(cdec is not None and cdec == pt)
                rows.append({"i": i, "n": n, "pt": pt, "cct": cct,
                             "ref_cct": ref_cct, "cdec": cdec,
                             "ok_cct": ok_cct, "ok_cdec": ok_cdec})
                print("  第 %d 组（%6d B）：0x40 CBC 加密%s 解密%s"
                      % (i, n, "OK" if ok_cct else "FAIL",
                         "OK" if ok_cdec else "FAIL"), flush=True)
    finally:
        link.close()

    ok_all = bool(key) and bool(rows) and all(
        r["ok_cct"] and r["ok_cdec"] for r in rows)

    md = []
    md.append("# SM4 CBC 加解密报告（0x40）\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：只使用临时槽 5（RAM），不发送 SET_PASSWORD / "
              "KEY_STORE / KEY_DESTROY，不写 OTP。\n\n")
    md.append("说明：本脚本用 NO3 的 `0x40 SM4_BULK`。\n\n")
    md.append("测试参数：\n\n")
    md.append("- 串口：%s，%d bps\n" % (args.port, args.baud))
    md.append("- 密钥 K（16B，临时）：`%s`\n"
              % (hex_bytes(key) if key else "-"))
    md.append("- CBC IV：`%s`\n" % hex_bytes(iv))
    md.append("- 长度：%s B\n" % "/".join(str(r["n"]) for r in rows))
    md.append("- 明文规则：`pt[i] = i & 0xFF`\n")
    md.append("- writes/reads：%d / %d\n\n" % (args.writes, args.reads))
    if not rows:
        md.append("密钥准备失败，未执行 CBC 用例。\n\n")
    else:
        md.append("## (1) 加密(CBC)\n\n")
        md.append("| 组 | 明文长度 | 明文 | 设备密文 | 参考密文 | 结论 |\n")
        md.append("|---|---|---|---|---|---|\n")
        for r in rows:
            md.append("| %d | %d | %s | %s | %s | %s |\n"
                      % (r["i"], r["n"], cell(r["pt"]), cell(r["cct"]),
                         cell(r["ref_cct"]), "通过" if r["ok_cct"] else "失败"))
        md.append("\n## (2) 解密(CBC)\n\n")
        md.append("| 组 | 密文长度 | 输入密文 | 设备明文 | 预期明文 | 结论 |\n")
        md.append("|---|---|---|---|---|---|\n")
        for r in rows:
            md.append("| %d | %d | %s | %s | %s | %s |\n"
                      % (r["i"], r["n"], cell(r["cct"]), cell(r["cdec"]),
                         cell(r["pt"]), "通过" if r["ok_cdec"] else "失败"))
    md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在失败项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if ok_all else "存在失败项"))
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

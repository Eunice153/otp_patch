#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM3 单帧（0x10）正确性测试。SM3 不使用密钥，不涉及 OTP。

报告默认写入 ../../sm3_report/sm3_oneshot_report.md。
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

from common.link import Link, CMD_SM3, hex_bytes  # noqa: E402
from common.sm3_tools import oneshot, sm3_ref  # noqa: E402
from common.paths import default_report, now_str, write_report  # noqa: E402

VECTORS = [
    ("空数据", b""),
    ("1 字节 0x61", b"a"),
    ("3 字节 abc", b"abc"),
    ("64 字节 abcd×16", b"abcd" * 16),
    ("512 字节 00..FF×2", bytes(range(256)) * 2),
]


def main():
    ap = argparse.ArgumentParser(description="SM3 单帧正确性（不涉及 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--data", action="append", default=None,
                    help="自定义 hex 数据，可重复；提供后只测这些数据")
    ap.add_argument("--out", default=default_report(__file__, "sm3_oneshot_report.md"))
    args = ap.parse_args()

    vectors = []
    if args.data:
        for s in args.data:
            t = s.strip().replace(" ", "").replace("0x", "")
            vectors.append(("自定义 %d B" % (len(t) // 2), bytes.fromhex(t)))
    else:
        vectors = VECTORS

    print("[安全] SM3 不使用密钥，不发送 OTP 命令", flush=True)
    link = Link(args.port, args.baud)
    rows = []
    try:
        for i, (name, data) in enumerate(vectors, 1):
            if len(data) > 512:
                print("  %2d. %-24s 跳过（%d B > 512）" % (i, name, len(data)),
                      flush=True)
                continue
            res = oneshot(link, data)
            if res is None:
                status, digest, raw = None, None, None
            else:
                status, digest, raw = res[1], res[2], res[3]
            ref = sm3_ref(data)
            ok = bool(status == 0 and digest == ref)
            rows.append({"i": i, "name": name, "data": data, "digest": digest,
                         "ref": ref, "raw": raw, "status": status, "ok": ok})
            print("  %2d. %-24s %s" % (i, name, "OK" if ok else "FAIL"),
                  flush=True)
    finally:
        link.close()

    ok_all = bool(rows) and all(r["ok"] for r in rows)
    md = []
    md.append("# SM3 单帧（0x10）测试报告\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("说明：SM3 不使用密钥，本测试不涉及 OTP。\n\n")
    md.append("| 组 | 名称 | 长度 | 输入 | 设备摘要 | 参考摘要 | 状态 | 结论 |\n")
    md.append("|---|---|---|---|---|---|---|---|\n")
    for r in rows:
        md.append("| %d | %s | %d | `%s` | `%s` | `%s` | %s | %s |\n"
                  % (r["i"], r["name"], len(r["data"]),
                     hex_bytes(r["data"]),
                     hex_bytes(r["digest"]) if r["digest"] else "-",
                     hex_bytes(r["ref"]),
                     "0x%02X" % r["status"] if r["status"] is not None else "timeout",
                     "通过" if r["ok"] else "失败"))
    md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在失败项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if ok_all else "存在失败项"))
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""读取芯片 ID（0x60 GET_UID）。

type 0: OTP 0x170 起始 8 字节唯一标识
type 1: OTP 0x00 起始 8 字节生产信息（LotID + waferid）

只读 OTP，不写 OTP。
报告默认写入本目录 get_uid_report.md。
"""

import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
TEST_TOOLS = os.path.dirname(HERE)
if TEST_TOOLS not in sys.path:
    sys.path.insert(0, TEST_TOOLS)

from common.wsl import maybe_relaunch

maybe_relaunch(__file__)

from common.link import Link, CMD_GET_UID, build_frame, hex_bytes  # noqa: E402
from common.paths import now_str, write_report  # noqa: E402

TYPES = {
    0: "OTP 0x170 唯一标识（UID）",
    1: "OTP 0x00 生产信息（LotID + waferid）",
}


def read_one(link, t, timeout=2.0):
    data = bytes([t])
    sent = build_frame(CMD_GET_UID, data)
    res = link.command(CMD_GET_UID, data, timeout=timeout)
    if res is None:
        return {"type": t, "sent": sent, "raw": None, "status": None,
                "payload": b"", "ok": False}
    return {"type": t, "sent": sent, "raw": res[3], "status": res[1],
            "payload": res[2],
            "ok": bool(res[1] == 0 and len(res[2]) == 8)}


def main():
    ap = argparse.ArgumentParser(description="读取芯片 ID（只读 OTP，不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--timeout", type=float, default=2.0,
                    help="单次读取超时，默认 2s")
    ap.add_argument("--type", default="all", choices=["all", "0", "1"],
                    help="0=UID, 1=生产信息, all=两者都读（默认）")
    ap.add_argument("--out", default=os.path.join(HERE, "get_uid_report.md"))
    args = ap.parse_args()

    types = [0, 1] if args.type == "all" else [int(args.type)]

    print("[安全] GET_UID 只读 OTP，不写 OTP", flush=True)
    link = Link(args.port, args.baud)
    rows = []
    try:
        for t in types:
            row = read_one(link, t, args.timeout)
            rows.append(row)
            print("  type %d %-30s: %s"
                  % (t, TYPES[t],
                     hex_bytes(row["payload"]) if row["ok"]
                     else ("timeout" if row["status"] is None
                           else "status=0x%02X len=%d"
                           % (row["status"], len(row["payload"])))),
                  flush=True)
            if not row["ok"]:
                print("  读取失败，立即关闭串口", flush=True)
                break
    finally:
        link.close()

    ok_all = bool(rows) and all(r["ok"] for r in rows)

    md = []
    md.append("# 读取芯片 ID 报告（GET_UID 0x60）\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：GET_UID 只读 OTP，不写 OTP。\n\n")
    md.append("| type | 说明 | 完整发送数据 | 完整返回数据 | 数据 | 状态 | 结论 |\n")
    md.append("|---|---|---|---|---|---|---|\n")
    for r in rows:
        md.append("| %d | %s | `%s` | %s | `%s` | %s | %s |\n"
                  % (r["type"], TYPES[r["type"]], hex_bytes(r["sent"]),
                     "`%s`" % hex_bytes(r["raw"]) if r["raw"] is not None
                     else "无（超时）",
                     hex_bytes(r["payload"]) if r["payload"] else "-",
                     "0x%02X" % r["status"] if r["status"] is not None
                     else "timeout",
                     "通过" if r["ok"] else "失败"))
    md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在失败项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out, flush=True)
    print("结论：%s" % ("全部符合预期" if ok_all else "存在失败项"), flush=True)
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

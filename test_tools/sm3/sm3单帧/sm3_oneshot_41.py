#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM3 单帧大数据（0x41）正确性测试。SM3 不使用密钥，不涉及 OTP。

0x41 是一个逻辑大帧：
    5A 41 LEN0..LEN3  data
固件收齐后调用一次 Invoke_SM3_cal，返回 32B 摘要。
主机可以一次 write，也可以拆成 n 次 write；应答可以分 n 次 read。

原 0x10 脚本 sm3_oneshot.py 保留不变。
报告默认写入 ../../sm3_report/sm3_oneshot_41_report.md。
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
from common.sm3_bulk import MAX_DATA, bulk_request  # noqa: E402
from common.sm3_tools import sm3_ref  # noqa: E402
from common.paths import default_report, now_str, write_report  # noqa: E402

def pattern(n):
    return bytes(((i * 37 + 0x5A) & 0xFF) for i in range(n))


VECTORS = [
    ("空数据", b""),
    ("1 字节", pattern(1)),
    ("3 字节 abc", b"abc"),
    # SM3 填充边界：55/56、63/64/65、119/120、127/128
    ("55B（1 块边界内）", pattern(55)),
    ("56B（需要 2 块）", pattern(56)),
    ("63B", pattern(63)),
    ("64B", pattern(64)),
    ("65B", pattern(65)),
    ("119B（64+55）", pattern(119)),
    ("120B（64+56）", pattern(120)),
    ("127B（64+63）", pattern(127)),
    ("128B（2 块）", pattern(128)),
    ("512B", bytes(range(256)) * 2),
    ("128KB pattern", pattern(MAX_DATA)),
]


def main():
    ap = argparse.ArgumentParser(
        description="SM3 单帧大数据（0x41，不涉及 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--data", action="append", default=None,
                    help="自定义 hex 数据，可重复；提供后只测这些数据")
    ap.add_argument("--writes", type=int, default=1,
                    help="把整个请求拆成 n 次串口 write")
    ap.add_argument("--reads", type=int, default=1,
                    help="把应答摘要拆成 n 次 read")
    ap.add_argument("--timeout", type=float, default=60.0)
    ap.add_argument("--out",
                    default=default_report(__file__, "sm3_oneshot_41_report.md"))
    args = ap.parse_args()

    if args.data:
        vectors = []
        for s in args.data:
            t = s.strip().replace(" ", "").replace("0x", "")
            data = bytes.fromhex(t)
            if len(data) > MAX_DATA:
                raise SystemExit("自定义数据不能超过 131072B")
            vectors.append(("自定义 %d B" % len(data), data))
    else:
        vectors = VECTORS

    print("[安全] SM3 不使用密钥，不发送 OTP 命令", flush=True)
    print("串口 %s @ %d，writes=%d，reads=%d"
          % (args.port, args.baud, args.writes, args.reads), flush=True)

    link = Link(args.port, args.baud)
    rows = []
    all_ok = True
    try:
        for i, (name, data) in enumerate(vectors, 1):
            ref = sm3_ref(data)
            print("  %2d. %-24s %7d B ..." % (i, name, len(data)), flush=True)
            res = bulk_request(link, data, args.timeout,
                               args.writes, args.reads)
            if res is None:
                got = None
                digest = b""
                status = None
                err = "无应答（超时）"
            else:
                status, digest, raw = res
                got = digest
                err = ""
            ok = (got == ref)
            all_ok = all_ok and ok
            rows.append({"i": i, "name": name, "n": len(data),
                         "ref": ref, "digest": got, "status": status,
                         "ok": ok, "err": err})
            if status is None:
                print("      无应答", flush=True)
            else:
                print("      STATUS=0x%02X，摘要=%s"
                      % (status, "OK" if ok else "FAIL"), flush=True)
                print("      摘要: %s" % hex_bytes(digest), flush=True)
    finally:
        link.close()

    md = []
    md.append("# SM3 单帧大数据测试报告（0x41）\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：SM3 不使用密钥，不涉及 OTP。\n\n")
    md.append("说明：本脚本用 NO3 的 `0x41 SM3_BULK`；原 `0x10` 版本 "
              "`sm3_oneshot.py` 保留。\n\n")
    md.append("| 项目 | 值 |\n|---|---|\n")
    md.append("| 串口 | %s，%d bps |\n" % (args.port, args.baud))
    md.append("| writes / reads | %d / %d |\n" % (args.writes, args.reads))
    md.append("| 报告结论 | %s |\n\n" % (
        "全部符合预期" if all_ok else "存在失败/未执行项"))
    md.append("| 序号 | 用例 | 长度 | STATUS | 设备摘要 | 参考摘要 | 结论 |\n")
    md.append("|---|---|---:|---|---|---|---|\n")
    for r in rows:
        md.append("| %d | %s | %d | %s | %s | %s | %s |\n" % (
            r["i"], r["name"], r["n"],
            "-" if r["status"] is None else "0x%02X" % (r["status"] & 0xFF),
            "`%s`" % hex_bytes(r["digest"]) if r["digest"] else "无",
            "`%s`" % hex_bytes(r["ref"]),
            "符合预期" if r["ok"] else "不符合预期"))
    md.append("\n结论：%s\n" % ("全部符合预期" if all_ok else "存在失败/未执行项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if all_ok else "存在失败/未执行项"))
    return 0 if all_ok else 1


if __name__ == "__main__":
    sys.exit(main())

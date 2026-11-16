#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM3 速率测试（NO3 0x41，默认 128KB × 3 轮）。

测量的是端到端时间：
    主机发送 0x41 大帧 + 128KB 数据
    -> 固件收齐 -> Invoke_SM3_cal -> 32B 摘要
    -> 主机收完摘要

因此 Kbps 包含串口传输时间，不是纯 SM3 运算时间。
115200 8N1 的理论 payload 上限约 92.16 Kbps。

SM3 不使用密钥，不涉及 OTP。
报告默认写入 ../../sm3_report/sm3_speed_report.md。
"""

import argparse
import os
import sys
import time

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


def parse_size(text):
    t = str(text).strip().upper()
    mul = 1
    if t.endswith("K"):
        mul = 1024
        t = t[:-1]
    elif t.endswith("M"):
        mul = 1024 * 1024
        t = t[:-1]
    try:
        n = int(t, 0) * mul
    except ValueError:
        raise argparse.ArgumentTypeError("size 必须是字节数或带 K/M 后缀")
    if n <= 0 or n > MAX_DATA:
        raise argparse.ArgumentTypeError(
            "size 必须在 1..%d（例如 128K 或 131072）" % MAX_DATA)
    return n


def make_data(size):
    return bytes(((i * 37 + 0x5A) & 0xFF) for i in range(size))


def main():
    ap = argparse.ArgumentParser(
        description="SM3 速率测试（NO3 0x41，默认 128KB × 3 轮）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--size", type=parse_size, default=128 * 1024,
                    help="数据大小，默认 128K；可写 64K/128K/131072")
    ap.add_argument("--runs", type=int, default=3,
                    help="轮数，默认 3")
    ap.add_argument("--timeout", type=float, default=120.0)
    ap.add_argument("--no-verify", action="store_true",
                    help="不校验摘要")
    ap.add_argument("--out",
                    default=default_report(__file__, "sm3_speed_report.md"))
    args = ap.parse_args()

    if args.runs <= 0:
        raise SystemExit("--runs 必须大于 0")

    data = make_data(args.size)
    ref = sm3_ref(data)
    print("[安全] SM3 不使用密钥，不发送 OTP 命令", flush=True)
    print("数据大小：%d B（%.1f KiB），轮数：%d"
          % (args.size, args.size / 1024.0, args.runs), flush=True)
    print("测量方式：0x41 端到端（含串口传输）", flush=True)

    link = Link(args.port, args.baud)
    rows = []
    try:
        for i in range(1, args.runs + 1):
            t0 = time.perf_counter()
            res = bulk_request(link, data, timeout=args.timeout)
            dt = time.perf_counter() - t0
            if res is None:
                print("  第 %d 轮：无应答" % i, flush=True)
                rows.append({"i": i, "time": dt, "kbps": 0.0,
                             "ok": False, "err": "无应答"})
                break
            status, digest, raw = res
            ok = (status == 0 and len(digest) == 32)
            if not args.no_verify:
                ok = ok and (digest == ref)
            kbps = (args.size * 8.0) / dt / 1000.0
            rows.append({"i": i, "time": dt, "kbps": kbps,
                         "ok": ok, "err": ""})
            print("  第 %d 轮：%.3f s，%.2f Kbps，STATUS=0x%02X，摘要=%s"
                  % (i, dt, kbps, status, "OK" if ok else "FAIL"),
                  flush=True)
            if not ok:
                break
    finally:
        link.close()

    ok_all = len(rows) == args.runs and all(r["ok"] for r in rows)
    times = [r["time"] for r in rows if r["ok"]]
    avg_t = sum(times) / len(times) if times else 0.0
    avg_kbps = (args.size * 8.0) / avg_t / 1000.0 if avg_t else 0.0

    md = []
    md.append("# SM3 速率测试报告\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：SM3 不使用密钥，不涉及 OTP。\n\n")
    md.append("| 项目 | 值 |\n|---|---|\n")
    md.append("| 串口 | %s，%d bps |\n" % (args.port, args.baud))
    md.append("| 数据大小 | %d B（%.1f KiB） |\n"
              % (args.size, args.size / 1024.0))
    md.append("| 轮数 | %d |\n" % args.runs)
    md.append("| 命令 | 0x41 SM3_BULK（一个逻辑大帧） |\n")
    md.append("| 测量方式 | 端到端，含串口发送/接收 |\n")
    md.append("| 理论 115200 8N1 上限 | 约 92.16 Kbps |\n")
    md.append("| 报告结论 | %s |\n\n" % (
        "全部符合预期" if ok_all else "存在失败/未执行项"))

    md.append("## 运算时间\n\n")
    md.append("| 数据大小 | " + " | ".join(
        "第 %d 次" % r["i"] for r in rows) + " | 平均执行时间 | "
        "杂凑运算平均速率(Kbps) |\n")
    md.append("|---|" + "---:|" * len(rows) + "---:|---:|\n")
    md.append("| %d B | " % args.size + " | ".join(
        "%.3f s" % r["time"] for r in rows) +
        " | %.3f s | %.2f |\n" % (avg_t, avg_kbps))

    md.append("\n## 摘要校验\n\n")
    md.append("| 轮次 | STATUS | 摘要 | 结论 |\n")
    md.append("|---|---|---|---|\n")
    for r in rows:
        md.append("| %d | %s | %s | %s |\n" % (
            r["i"], "0x00" if r["ok"] else "-",
            "参考一致" if r["ok"] else (r["err"] or "不一致"),
            "通过" if r["ok"] else "失败"))
    md.append("\n说明：Kbps = 数据字节数 × 8 / 时间 / 1000；"
              "时间从主机开始发大帧到收完 32B 摘要，包含 UART 传输。\n")

    write_report(args.out, "".join(md))
    print("\n平均执行时间：%.3f s" % avg_t, flush=True)
    print("平均速率：%.2f Kbps" % avg_kbps, flush=True)
    print("报告已写入：%s" % args.out, flush=True)
    print("结论：" + ("全部符合预期" if ok_all else "存在失败/未执行项"))
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

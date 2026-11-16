#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM3 非正常输入测试（0x41，不涉及 OTP）。

0x41 只有一个长度参数：
  - 0..131072：合法
  - 131073..131124：能被 128KB 缓冲收下，但 handler 返回 0xFE
  - >131124：帧层直接丢弃，不应答

本脚本覆盖：
  - 0B 基线
  - 3B 基线
  - 131072B 上限
  - 131073B 超过上限

流式 0x1A/0x1B/0x1C 已删除。
报告默认写入 ../../sm3_report/sm3_abnormal_41_report.md。
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
from common.sm3_bulk import (  # noqa: E402
    MAX_DATA, build_frame, bulk_request, raw_request,
)
from common.sm3_tools import sm3_ref  # noqa: E402
from common.paths import default_report, now_str, write_report  # noqa: E402


def make_data(size):
    return bytes(((i * 37 + 0x5A) & 0xFF) for i in range(size))


def frame_desc(frame):
    if len(frame) <= 512:
        return "`%s`" % hex_bytes(frame)
    return ("`%s ... %s`（%d B, sha256=%s）"
            % (hex_bytes(frame[:16]), hex_bytes(frame[-16:]), len(frame),
               hashlib.sha256(frame).hexdigest()))


def run_case(link, idx, name, data, expect, expect_digest, timeout=60.0):
    sent = build_frame(data)
    req = raw_request if len(data) > MAX_DATA else bulk_request
    res = req(link, data, timeout=timeout)
    if res is None:
        got = None
        raw = None
        resp = "无应答（超时）"
    else:
        got, digest, raw = res
        resp = "status=0x%02X, len=%d" % (got, len(digest))
    digest_ok = True
    if expect_digest is not None:
        digest_ok = bool(res is not None and res[1] == expect_digest)
    ok = (got == expect) and digest_ok
    exp = "0x%02X" % expect
    if expect_digest is not None:
        exp += " + 摘要"
    print("  %2d. %-30s %-28s 预期=%-16s %s"
          % (idx, name, resp, exp, "通过" if ok else "失败"), flush=True)
    print("      发送: %s" % frame_desc(sent), flush=True)
    print("      返回: %s" % (hex_bytes(raw) if raw is not None
                              else "无（超时）"), flush=True)
    return {"idx": idx, "name": name, "sent": sent, "raw": raw,
            "resp": resp, "exp": exp, "ok": ok}


def main():
    ap = argparse.ArgumentParser(
        description="SM3 非正常输入（0x41，不涉及 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--timeout", type=float, default=60.0)
    ap.add_argument("--out",
                    default=default_report(__file__, "sm3_abnormal_41_report.md"))
    args = ap.parse_args()

    d_empty = sm3_ref(b"")
    d_abc = sm3_ref(b"abc")
    data_max = make_data(MAX_DATA)
    d_max = sm3_ref(data_max)
    data_over = make_data(MAX_DATA + 1)
    z64 = bytes(64)
    f64 = bytes([0xFF] * 64)
    s64 = bytes([0x5A] * 64)
    a64 = bytes((0x00 if i % 2 == 0 else 0xFF) for i in range(64))

    print("[安全] SM3 不使用密钥，不发送 OTP 命令", flush=True)
    link = Link(args.port, args.baud)
    rows = []
    try:
        print("\n[SM3 非正常输入（0x41）]", flush=True)
        rows.append(run_case(link, len(rows) + 1, "0x41 空数据（0B 基线）",
                             b"", 0x00, d_empty, args.timeout))
        rows.append(run_case(link, len(rows) + 1, "0x41 abc（3B 基线）",
                             b"abc", 0x00, d_abc, args.timeout))
        rows.append(run_case(link, len(rows) + 1, "内容 64B 全 0x00",
                             z64, 0x00, sm3_ref(z64), args.timeout))
        rows.append(run_case(link, len(rows) + 1, "内容 64B 全 0xFF",
                             f64, 0x00, sm3_ref(f64), args.timeout))
        rows.append(run_case(link, len(rows) + 1,
                             "内容 64B 全 0x5A（帧头字节）",
                             s64, 0x00, sm3_ref(s64), args.timeout))
        rows.append(run_case(link, len(rows) + 1, "内容 64B 00/FF 交替",
                             a64, 0x00, sm3_ref(a64), args.timeout))
        rows.append(run_case(link, len(rows) + 1, "0x41 131072B（上限）",
                             data_max, 0x00, d_max, args.timeout))
        rows.append(run_case(link, len(rows) + 1, "0x41 131073B（超上限）",
                             data_over, 0xFE, None, args.timeout))
    finally:
        link.close()

    ok_all = bool(rows) and all(r["ok"] for r in rows)
    md = []
    md.append("# SM3 非正常输入测试结果（0x41）\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("说明：SM3 不使用密钥，本测试不涉及 OTP。"
              "0x41 是 4 字节 LEN 的逻辑大帧；"
              "原始流式 0x1A/0x1B/0x1C 已删除。\n\n")
    md.append("注意：超过 512B 的发送帧不整段写入报告，只记录长度、"
              "首尾字节和 SHA256；设备返回的摘要完整列出。\n\n")
    md.append("| 序号 | 非正常输入 | 完整发送数据 | 完整返回数据 | "
              "设备响应 | 预期 | 结论 |\n")
    md.append("|---|---|---|---|---|---|---|\n")
    for r in rows:
        md.append("| %d | %s | %s | %s | %s | %s | %s |\n"
                  % (r["idx"], r["name"], frame_desc(r["sent"]),
                     "`%s`" % hex_bytes(r["raw"]) if r["raw"] is not None
                     else "无（超时）",
                     r["resp"], r["exp"], "通过" if r["ok"] else "失败"))
    md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在不符合预期项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if ok_all else "存在不符合预期项"))
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

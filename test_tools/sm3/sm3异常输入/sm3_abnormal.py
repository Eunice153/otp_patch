#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM3 非正常输入测试（0x10，不含流式，不涉及 OTP）。

覆盖：
  - 基线 0x10 "abc"
  - 0x10 空数据
  - 0x10 512B（普通帧上限）
  - 0x10 LEN=513（帧层超过 512，固件丢弃，不应答）

流式 0x1A/0x1B/0x1C 已删除。
报告默认写入 ../../sm3_report/sm3_abnormal_report.md。
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

from common.link import Link, CMD_SM3, build_frame, hex_bytes  # noqa: E402
from common.sm3_tools import sm3_ref  # noqa: E402
from common.paths import default_report, now_str, write_report  # noqa: E402


def raw_exchange(link, frame, timeout):
    """发送任意原始帧，按普通 2 字节 LEN 应答解析；超时返回 None。"""
    ser = link.ser
    ser.reset_input_buffer()
    ser.write(frame)
    ser.flush()
    buf = bytearray()
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        b = ser.read(1)
        if not b:
            continue
        buf.append(b[0])
        start = buf.find(b"\x5A")
        if start < 0:
            buf.clear()
            continue
        if start > 0:
            del buf[:start]
        if len(buf) < 5:
            continue
        need = (buf[3] << 8) | buf[4]
        if len(buf) >= 5 + need:
            return (buf[1], buf[2], bytes(buf[5:5 + need]), bytes(buf[:5 + need]))
    return None


def run_case(link, idx, name, frame, expect, expect_digest=None,
             timeout=2.0):
    res = raw_exchange(link, frame, timeout)
    if res is None:
        got = None
        raw = None
        resp = "无应答（超时）"
    else:
        got = res[1]
        raw = res[3]
        resp = "status=0x%02X, len=%d" % (res[1], len(res[2]))
    digest_ok = True
    if expect_digest is not None:
        digest_ok = bool(res is not None and res[2] == expect_digest)
    ok = (got == expect) and digest_ok
    exp = "无应答" if expect is None else "0x%02X" % expect
    if expect_digest is not None:
        exp += " + 摘要"
    print("  %2d. %-30s %-28s 预期=%-16s %s"
          % (idx, name, resp, exp, "通过" if ok else "失败"), flush=True)
    print("      发送: %s" % hex_bytes(frame), flush=True)
    print("      返回: %s" % (hex_bytes(raw) if raw is not None
                              else "无（超时）"), flush=True)
    return {"idx": idx, "name": name, "sent": frame, "raw": raw,
            "resp": resp, "exp": exp, "ok": ok}


def main():
    ap = argparse.ArgumentParser(
        description="SM3 非正常输入（0x10，不含流式，不涉及 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--out", default=default_report(__file__, "sm3_abnormal_report.md"))
    args = ap.parse_args()

    d_empty = sm3_ref(b"")
    d_abc = sm3_ref(b"abc")
    d_512 = sm3_ref(bytes(x & 0xFF for x in range(512)))
    z64 = bytes(64)
    f64 = bytes([0xFF] * 64)
    s64 = bytes([0x5A] * 64)
    a64 = bytes((0x00 if i % 2 == 0 else 0xFF) for i in range(64))

    print("[安全] SM3 不使用密钥，不发送 OTP 命令", flush=True)
    link = Link(args.port, args.baud)
    rows = []
    try:
        print("\n[SM3 非正常输入（0x10）]", flush=True)
        rows.append(run_case(
            link, len(rows) + 1, '基线：0x10 "abc"',
            build_frame(CMD_SM3, b"abc"), 0x00, d_abc))
        rows.append(run_case(
            link, len(rows) + 1, "0x10 空数据（0 B）",
            build_frame(CMD_SM3, b""), 0x00, d_empty))
        rows.append(run_case(
            link, len(rows) + 1, "0x10 512B（帧上限）",
            build_frame(CMD_SM3, bytes(x & 0xFF for x in range(512))),
            0x00, d_512))
        rows.append(run_case(
            link, len(rows) + 1, "内容 64B 全 0x00",
            build_frame(CMD_SM3, z64), 0x00, sm3_ref(z64)))
        rows.append(run_case(
            link, len(rows) + 1, "内容 64B 全 0xFF",
            build_frame(CMD_SM3, f64), 0x00, sm3_ref(f64)))
        rows.append(run_case(
            link, len(rows) + 1, "内容 64B 全 0x5A（帧头字节）",
            build_frame(CMD_SM3, s64), 0x00, sm3_ref(s64)))
        rows.append(run_case(
            link, len(rows) + 1, "内容 64B 00/FF 交替",
            build_frame(CMD_SM3, a64), 0x00, sm3_ref(a64)))

        # 普通帧 LEN=513，超过 CMD_MAX_DATA=512；固件帧层直接丢弃。
        # 用 513 个 0x00，避免数据中出现 0x5A 被误当帧头。
        frame_513 = bytes([0x5A, CMD_SM3, 0x02, 0x01]) + bytes(513)
        rows.append(run_case(
            link, len(rows) + 1, "0x10 LEN=513（超过 512）",
            frame_513, None, None, timeout=1.0))
        time.sleep(0.05)
    finally:
        link.close()

    ok_all = bool(rows) and all(r["ok"] for r in rows)
    md = []
    md.append("# SM3 非正常输入测试结果（0x10，不含流式）\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("说明：SM3 不使用密钥，本测试不涉及 OTP。"
              "流式 0x1A/0x1B/0x1C 已删除。\n\n")
    md.append("| 序号 | 非正常输入 | 完整发送数据 | 完整返回数据 | "
              "设备响应 | 预期 | 结论 |\n")
    md.append("|---|---|---|---|---|---|---|\n")
    for r in rows:
        md.append("| %d | %s | `%s` | %s | %s | %s | %s |\n"
                  % (r["idx"], r["name"], hex_bytes(r["sent"]),
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

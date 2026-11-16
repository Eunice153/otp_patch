#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM4 非正常输入测试（临时槽 5，不写 OTP）。

覆盖：
  - 数据长度 0 / 非 16 字节倍数
  - 非法 id / mode / op
  - CBC 缺 IV / IV 后数据不是 16 的倍数

不包含 OTP 槽、未知命令和帧层异常用例。
报告默认写入 ../../sm4_report/sm4_abnormal_report.md。
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

from common.link import (  # noqa: E402
    Link, CMD_GENKEY, CMD_SM4_CRYPT, ID_TMP_SM4, build_frame, hex_bytes,
)
from common.paths import default_report, now_str, write_report  # noqa: E402


def run_case(link, idx, name, data, expect, timeout=1.0):
    sent = build_frame(CMD_SM4_CRYPT, data)
    res = link.command(CMD_SM4_CRYPT, data, timeout=timeout)
    if res is None:
        got = None
        raw = None
        resp = "无应答（超时）"
    else:
        got = res[1]
        raw = res[3]
        resp = "status=0x%02X, len=%d" % (res[1], len(res[2]))
    ok = (got == expect)
    exp = "0x%02X" % expect
    print("  %2d. %-30s %-28s 预期=%-8s %s"
          % (idx, name, resp, exp, "通过" if ok else "失败"), flush=True)
    print("      发送: %s" % hex_bytes(sent), flush=True)
    print("      返回: %s" % (hex_bytes(raw) if raw is not None
                              else "无（超时）"), flush=True)
    return {"idx": idx, "name": name, "sent": sent, "raw": raw,
            "resp": resp, "exp": exp, "ok": ok}


def main():
    ap = argparse.ArgumentParser(description="SM4 非正常输入（临时槽 5，不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--out", default=default_report(__file__, "sm4_abnormal_report.md"))
    args = ap.parse_args()

    print("[安全] 只使用临时槽 5 和负向用例，不写 OTP", flush=True)
    link = Link(args.port, args.baud)
    rows = []
    try:
        res = link.command(CMD_GENKEY, bytes([ID_TMP_SM4]))
        if not (res and res[1] == 0):
            print("GENKEY(5) 失败，停止", flush=True)
            return 1
        pt16 = bytes(range(16))
        iv16 = bytes(range(16))

        cases = [
            ("正常 ECB 16B（基线）", bytes([ID_TMP_SM4, 0, 0]) + pt16, 0x00),
            ("数据长度 15B（非 16 倍数）",
             bytes([ID_TMP_SM4, 0, 0]) + pt16[:15], 0xFE),
            ("数据长度 0", bytes([ID_TMP_SM4, 0, 0]), 0xFE),
            ("非法 id=0x00", bytes([0x00, 0, 0]) + pt16, 0xFE),
            ("非法 id=0x06", bytes([0x06, 0, 0]) + pt16, 0xFE),
            ("非法 mode=0x02", bytes([ID_TMP_SM4, 0x02, 0]) + pt16, 0xFE),
            ("非法 op=0x02", bytes([ID_TMP_SM4, 0, 0x02]) + pt16, 0xFE),
            ("CBC 只给 IV、无数据",
             bytes([ID_TMP_SM4, 1, 0]) + iv16, 0xFE),
            ("CBC IV + 15B 数据",
             bytes([ID_TMP_SM4, 1, 0]) + iv16 + pt16[:15], 0xFE),
        ]
        print("\n[SM4 非正常输入]", flush=True)
        for i, (name, data, expect) in enumerate(cases, 1):
            rows.append(run_case(link, i, name, data, expect))
            time.sleep(0.05)
    finally:
        link.close()

    ok_all = bool(rows) and all(r["ok"] for r in rows)
    md = []
    md.append("# SM4 非正常输入测试结果\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：只使用临时槽 5（RAM），不发送 SET_PASSWORD / "
              "KEY_STORE / KEY_DESTROY，不写 OTP。\n\n")
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

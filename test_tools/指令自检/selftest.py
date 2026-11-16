#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""指令自检（0x50 SELFTEST）。

请求: [mask_H, mask_L] 可选；不传时固件默认 mask=0xFFFF
应答: 4B 大端 result，bit=0 表示该项通过：
  bit0 TRNG
  bit1 SM3 KAT
  bit2 SM4 KAT
  bit3 SM2 KAT

自检只使用 RAM 临时槽，不写 OTP。
报告默认写入本目录 selftest_report.md。
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

from common.link import Link, CMD_SELFTEST, build_frame, hex_bytes  # noqa: E402
from common.paths import now_str, write_report  # noqa: E402

BITS = [
    (0, "TRNG 自检"),
    (1, "SM3 KAT (abc)"),
    (2, "SM4 KAT (标准向量)"),
    (3, "SM2 KAT (生成/签名/验签)"),
]


def main():
    ap = argparse.ArgumentParser(description="SELFTEST 指令自检（不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--mask", default=None,
                    help="可选：16 位选择掩码，例如 0x000F；不传则用固件默认 0xFFFF")
    ap.add_argument("--timeout", type=float, default=30.0,
                    help="单次等待应答超时，默认 30s")
    ap.add_argument("--out", default=os.path.join(HERE, "selftest_report.md"))
    args = ap.parse_args()

    if args.mask is not None:
        mask = int(args.mask, 0)
        if not (0 <= mask <= 0xFFFF):
            raise SystemExit("--mask 必须在 0..0xFFFF")
        data = bytes([(mask >> 8) & 0xFF, mask & 0xFF])
        mask_desc = "0x%04X" % mask
    else:
        data = b""
        mask = 0xFFFF
        mask_desc = "0xFFFF（固件默认）"

    print("[安全] SELFTEST 只使用 RAM 临时槽，不写 OTP", flush=True)
    link = Link(args.port, args.baud)
    sent = build_frame(CMD_SELFTEST, data)
    try:
        res = link.command(CMD_SELFTEST, data, timeout=args.timeout)
    finally:
        link.close()

    if res is None:
        status, payload, raw = None, b"", None
    else:
        status, payload, raw = res[1], res[2], res[3]

    result = int.from_bytes(payload, "big") if len(payload) == 4 else None
    ok_all = bool(status == 0 and result == 0)

    print("  发送: %s" % hex_bytes(sent), flush=True)
    print("  返回: %s" % (hex_bytes(raw) if raw is not None else "无（超时）"),
          flush=True)
    print("  mask: %s" % mask_desc, flush=True)
    print("  result: %s" % ("0x%08X" % result if result is not None else "-"),
          flush=True)
    for bit, name in BITS:
        selected = bool(mask & (1 << bit))
        if result is None:
            verdict = "无结果（超时）"
        elif not selected:
            verdict = "未选择"
        elif result & (1 << bit):
            verdict = "FAIL"
        else:
            verdict = "OK"
        print("  bit%d %-24s %s" % (bit, name, verdict), flush=True)
    print("结论：%s" % ("全部符合预期" if ok_all else "存在失败项"), flush=True)

    md = []
    md.append("# 指令自检报告（SELFTEST 0x50）\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：自检只使用 RAM 临时槽，不写 OTP。\n\n")
    md.append("| 项目 | 值 |\n|---|---|\n")
    md.append("| 串口 | %s，%d bps |\n" % (args.port, args.baud))
    md.append("| mask | %s |\n" % mask_desc)
    md.append("| 完整发送数据 | `%s` |\n" % hex_bytes(sent))
    md.append("| 完整返回数据 | %s |\n" % (
        "`%s`" % hex_bytes(raw) if raw is not None else "无（超时）"))
    md.append("| STATUS | %s |\n" % (
        "0x%02X" % status if status is not None else "timeout"))
    md.append("| result | %s |\n" % (
        "0x%08X" % result if result is not None else "-"))
    md.append("\n| bit | 自检项 | 是否选择 | 结果 |\n|---|---|---|---|\n")
    for bit, name in BITS:
        selected = bool(mask & (1 << bit))
        if result is None:
            verdict = "无结果（超时）"
        elif not selected:
            verdict = "未选择"
        elif result & (1 << bit):
            verdict = "FAIL"
        else:
            verdict = "OK"
        md.append("| %d | %s | %s | %s |\n"
                  % (bit, name, "是" if selected else "否", verdict))
    md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在失败项"))
    write_report(args.out, "".join(md))

    print("报告已写入：%s" % args.out, flush=True)
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

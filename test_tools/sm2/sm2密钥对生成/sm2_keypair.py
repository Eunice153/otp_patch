#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM2 密钥对生成测试。

命令流程（只使用临时槽 3/4，不写 OTP）：
    GENKEY(slot) -> GETPUBKEY(slot)
    LOAD_PUBKEY(TEST_D 公钥) -> EXPORT_KEY(slot, 1)
    上位机用 TEST_D 解出私钥 d，并由 d 计算公钥与设备公钥比对。

说明：EXPORT_KEY 就是固件里的 0x13（历史名字 CMD_SM4_EXPORT），
它是通用密钥导出命令，SM2 槽返回 128B，不是 SM4 加密。

报告默认写入 ../../sm2_report/sm2_keypair_report.md。
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

from common.link import (  # noqa: E402
    Link, CMD_GENKEY, CMD_GETPUBKEY, CMD_EXPORT_KEY, CMD_LOAD_PUBKEY,
    ID_TMP_SM2_DEC, ID_TMP_SM2_SIGN, hex_bytes,
)
from common.sm2_crypto import TEST_D, sm2_decrypt, pub_from_priv, test_d_public  # noqa: E402
from common.paths import default_report, now_str, write_report  # noqa: E402


def run_slot(link, slot, show_private):
    row = {
        "slot": slot, "genkey": False, "pub": None, "load": False,
        "export": False, "priv": None, "match": False,
    }
    res = link.command(CMD_GENKEY, bytes([slot]))
    row["genkey"] = bool(res and res[1] == 0)
    print("  GENKEY(%d): %s" % (
        slot, "OK" if row["genkey"] else "FAIL"), flush=True)

    res = link.command(CMD_GETPUBKEY, bytes([slot]))
    if res and res[1] == 0 and len(res[2]) == 64:
        row["pub"] = res[2]
        print("  GETPUBKEY(%d): %s" % (slot, hex_bytes(row["pub"])), flush=True)
    else:
        print("  GETPUBKEY(%d): FAIL %s" % (
            slot, "timeout" if res is None else "status=0x%02X" % res[1]),
            flush=True)
        return row

    res = link.command(CMD_LOAD_PUBKEY, test_d_public())
    row["load"] = bool(res and res[1] == 0)

    res = link.command(CMD_EXPORT_KEY, bytes([slot, 1]))
    if res and res[1] == 0 and len(res[2]) == 128:
        row["export"] = True
        try:
            d = sm2_decrypt(res[2], TEST_D)
            row["priv"] = d
            row["match"] = (pub_from_priv(d) == row["pub"])
        except Exception as e:
            print("  私钥解包失败: %s" % e, flush=True)
    else:
        print("  EXPORT(%d): FAIL %s" % (
            slot, "timeout" if res is None else "status=0x%02X len=%d"
            % (res[1], len(res[2]))), flush=True)

    if show_private and row["priv"] is not None:
        print("  私钥 d(%d): %s" % (slot, hex_bytes(row["priv"])), flush=True)
    print("  公私钥匹配: %s" % ("OK" if row["match"] else "FAIL"), flush=True)
    return row


def main():
    ap = argparse.ArgumentParser(description="SM2 密钥对生成测试（临时槽，不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--slots", default="3,4",
                    help="临时槽位，逗号分隔，默认 3,4")
    ap.add_argument("--show-private", action="store_true",
                    help="报告/控制台显示临时私钥 d（默认不显示）")
    ap.add_argument("--out", default=default_report(__file__, "sm2_keypair_report.md"))
    args = ap.parse_args()

    slots = []
    for s in args.slots.split(","):
        s = s.strip()
        if not s:
            continue
        v = int(s, 0)
        if v not in (ID_TMP_SM2_DEC, ID_TMP_SM2_SIGN):
            raise SystemExit("只允许临时槽 3/4（SM2 解密/签名），不允许槽 %d" % v)
        slots.append(v)
    if not slots:
        raise SystemExit("没有有效槽位")

    print("[安全] 只使用临时槽 %s，不发送写 OTP 命令" % slots, flush=True)
    link = Link(args.port, args.baud)
    rows = []
    try:
        for slot in slots:
            print("\n[槽 %d]" % slot, flush=True)
            rows.append(run_slot(link, slot, args.show_private))
    finally:
        link.close()

    ok_all = all(r["genkey"] and r["pub"] and r["load"]
                 and r["export"] and r["match"] for r in rows)

    md = []
    md.append("# SM2 密钥对生成报告\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：只使用临时槽 3/4（RAM），不发送 SET_PASSWORD / "
              "KEY_STORE / KEY_DESTROY，不写 OTP。\n\n")
    md.append("命令流程：`GENKEY(slot)` → `GETPUBKEY(slot)` → "
              "`LOAD_PUBKEY(TEST_D 公钥)` → `EXPORT_KEY(slot, 1)`，"
              "上位机用 TEST_D 解出私钥并校验公私钥匹配。\n\n")
    md.append("说明：`EXPORT_KEY` 是固件命令 0x13（历史名字 "
              "`CMD_SM4_EXPORT`），为通用密钥导出；SM2 槽返回 128B，"
              "与 SM4 加密无关。\n\n")
    md.append("| 槽位 | GENKEY | 公钥 X | 公钥 Y | LOAD_PUBKEY | 私钥导出 | 公私钥匹配 | 结果 |\n")
    md.append("|---|---|---|---|---|---|---|---|\n")
    for r in rows:
        px = hex_bytes(r["pub"][:32]) if r["pub"] else "-"
        py = hex_bytes(r["pub"][32:]) if r["pub"] else "-"
        ok = (r["genkey"] and r["pub"] and r["load"]
              and r["export"] and r["match"])
        md.append("| %d | %s | `%s` | `%s` | %s | %s | %s | %s |\n"
                  % (r["slot"], "OK" if r["genkey"] else "FAIL", px, py,
                     "OK" if r["load"] else "FAIL",
                     "OK" if r["export"] else "FAIL",
                     "OK" if r["match"] else "FAIL",
                     "通过" if ok else "失败"))
    if args.show_private:
        md.append("\n## 临时私钥（仅测试）\n\n")
        md.append("| 槽位 | d |\n|---|---|\n")
        for r in rows:
            d = hex_bytes(r["priv"]) if r["priv"] is not None else "-"
            md.append("| %d | `%s` |\n" % (r["slot"], d))
    md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在失败项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if ok_all else "存在失败项"))
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

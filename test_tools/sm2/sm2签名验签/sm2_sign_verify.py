#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM2 签名/验签测试（临时槽 4，不写 OTP）。

流程：
    GENKEY(4) -> GETPUBKEY(4)
    设备签名 SM2_SIGN，上位机验签 + 设备验签 + 篡改验签
    上位机签名，设备验签 SM2_VERIFY

报告默认写入 ../../sm2_report/sm2_sign_verify_report.md。
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
    Link, CMD_SM2_SIGN, CMD_SM2_VERIFY, ID_TMP_SM2_SIGN, hex_bytes,
)
from common.sm2_crypto import (  # noqa: E402
    fixed_k, sm3, sm2_sign_host, sm2_verify,
)
from common.sm2_tools import prepare_key  # noqa: E402
from common.paths import default_report, now_str, write_report  # noqa: E402

MESSAGES = [
    b"",
    b"abc",
    b"sm2-sign-test-1",
    b"sm2-sign-test-2",
    b"0123456789abcdef",
]


def verify_dev(link, pub, digest, sig):
    """返回 (status, result)，失败时 result=None。"""
    res = link.command(CMD_SM2_VERIFY, pub + digest + sig)
    if not (res and res[1] == 0 and len(res[2]) == 1):
        return (None, None)
    return (res[1], res[2][0])


def run_one(link, pub, priv, idx, msg):
    digest = sm3(msg)
    row = {"idx": idx, "msg": msg, "digest": digest, "ok": False}

    k_dev = fixed_k("sm2-sign-dev-%d" % idx)
    res = link.command(CMD_SM2_SIGN,
                       bytes([ID_TMP_SM2_SIGN]) + digest + k_dev)
    if not (res and res[1] == 0 and len(res[2]) == 64):
        row["sign_status"] = ("timeout" if res is None
                              else "0x%02X len=%d" % (res[1], len(res[2])))
        return row
    sig = res[2]
    row["k_dev"] = k_dev
    row["sig"] = sig
    row["host_verify"] = sm2_verify(pub, digest, sig)

    _, res_dev = verify_dev(link, pub, digest, sig)
    row["dev_verify"] = (res_dev == 1)

    bad = bytearray(sig)
    bad[0] ^= 1
    _, res_bad = verify_dev(link, pub, digest, bytes(bad))
    row["tamper"] = (res_bad == 0)

    k_host = fixed_k("sm2-sign-host-%d" % idx)
    sig_host = sm2_sign_host(priv, digest, k_host)
    _, res_host = verify_dev(link, pub, digest, sig_host)
    row["k_host"] = k_host
    row["sig_host"] = sig_host
    row["host_sign_dev_verify"] = (res_host == 1)

    row["ok"] = bool(row["host_verify"] and row["dev_verify"]
                     and row["tamper"] and row["host_sign_dev_verify"])
    return row


def main():
    ap = argparse.ArgumentParser(description="SM2 签名/验签测试（临时槽 4，不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--slot", type=lambda x: int(x, 0), default=ID_TMP_SM2_SIGN)
    ap.add_argument("--out", default=default_report(__file__, "sm2_sign_verify_report.md"))
    args = ap.parse_args()

    if args.slot != ID_TMP_SM2_SIGN:
        raise SystemExit("只允许临时签名槽 4；OTP 槽不在本测试范围")

    print("[安全] 只使用临时槽 4，不发送写 OTP 命令", flush=True)
    link = Link(args.port, args.baud)
    rows = []
    try:
        info = prepare_key(link, args.slot, regenerate=True)
        print("  GENKEY(4): %s" % ("OK" if info["genkey"] else "FAIL"), flush=True)
        print("  GETPUBKEY(4): %s" % (
            hex_bytes(info["pub"]) if info["pub"] else "FAIL"), flush=True)
        print("  私钥导出/匹配: %s" % ("OK" if info["match"] else "FAIL"),
              flush=True)
        if info["genkey"] and info["pub"] and info["priv"] and info["match"]:
            for i, msg in enumerate(MESSAGES, 1):
                print("\n[消息 %d: %r]" % (i, msg), flush=True)
                row = run_one(link, info["pub"], info["priv"], i, msg)
                rows.append(row)
                print("  设备签名/主机验签: %s" % (
                    "OK" if row.get("host_verify") else "FAIL"), flush=True)
                print("  设备验签: %s" % (
                    "OK" if row.get("dev_verify") else "FAIL"), flush=True)
                print("  篡改验签(应为 0): %s" % (
                    "OK" if row.get("tamper") else "FAIL"), flush=True)
                print("  主机签名/设备验签: %s" % (
                    "OK" if row.get("host_sign_dev_verify") else "FAIL"),
                    flush=True)
    finally:
        link.close()

    ok_all = bool(rows) and all(r["ok"] for r in rows)

    md = []
    md.append("# SM2 签名验签报告\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：只使用临时槽 4（RAM），不发送 SET_PASSWORD / "
              "KEY_STORE / KEY_DESTROY，不写 OTP。\n\n")
    if not rows:
        md.append("准备阶段失败，未执行签名验签用例。\n\n")
    else:
        md.append("## 设备签名\n\n")
        md.append("| 序号 | 消息 | SM3 摘要 | 设备 k | 设备签名 | 主机验签 | "
                  "设备验签 | 篡改验签(应 0) | 结果 |\n")
        md.append("|---|---|---|---|---|---|---|---|---|\n")
        for r in rows:
            msg_hex = hex_bytes(r["msg"]) if r["msg"] else "（空）"
            md.append("| %d | `%s` | `%s` | `%s` | `%s` | %s | %s | %s | %s |\n"
                      % (r["idx"], msg_hex, hex_bytes(r["digest"]),
                         hex_bytes(r.get("k_dev", b"")),
                         hex_bytes(r.get("sig", b"")),
                         "OK" if r.get("host_verify") else "FAIL",
                         "OK" if r.get("dev_verify") else "FAIL",
                         "OK" if r.get("tamper") else "FAIL",
                         "通过" if r["ok"] else "失败"))
        md.append("\n## 上位机签名 + 设备验签\n\n")
        md.append("| 序号 | 消息 | 上位机 k | 上位机签名 | 设备验签 |\n")
        md.append("|---|---|---|---|---|\n")
        for r in rows:
            msg_hex = hex_bytes(r["msg"]) if r["msg"] else "（空）"
            md.append("| %d | `%s` | `%s` | `%s` | %s |\n"
                      % (r["idx"], msg_hex,
                         hex_bytes(r.get("k_host", b"")),
                         hex_bytes(r.get("sig_host", b"")),
                         "OK" if r.get("host_sign_dev_verify") else "FAIL"))
    md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在失败项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if ok_all else "存在失败项"))
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM2 加解密测试（临时槽 3，不写 OTP）。

流程：
    GENKEY(3) -> GETPUBKEY(3)
    设备加密 SM2_ENC，上位机用导出的私钥解密校验
    设备解密 SM2_DEC（设备密文）
    上位机加密，设备解密 SM2_DEC（上位机密文）

SM2 解密受 ROM boot_sm2_decrypt 352B 栈帧限制，明文最大 64B。
报告默认写入 ../../sm2_report/sm2_crypt_report.md。
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
    Link, CMD_SM2_ENC, CMD_SM2_DEC, ID_TMP_SM2_DEC, hex_bytes,
)
from common.sm2_crypto import (  # noqa: E402
    fixed_k, sm2_decrypt, sm2_encrypt,
)
from common.sm2_tools import prepare_key  # noqa: E402
from common.paths import default_report, now_str, write_report  # noqa: E402


def make_pt(length):
    return bytes((i * 7 + 3) & 0xFF for i in range(length))


def run_one(link, pub, priv, length):
    row = {"length": length, "ok": False}
    pt = make_pt(length)

    k_dev = fixed_k("sm2-crypt-dev-%d" % length)
    res = link.command(CMD_SM2_ENC, bytes([1]) + pub + k_dev + pt)
    if not (res and res[1] == 0 and len(res[2]) == 96 + length):
        row["enc_status"] = "timeout" if res is None else "0x%02X len=%d" % (res[1], len(res[2]))
        return row
    ct_dev = res[2]
    row["k_dev"] = k_dev
    row["ct_dev"] = ct_dev
    try:
        row["host_dec"] = (sm2_decrypt(ct_dev, priv) == pt)
    except Exception:
        row["host_dec"] = False

    res = link.command(CMD_SM2_DEC,
                       bytes([ID_TMP_SM2_DEC, 1,
                              (length >> 8) & 0xFF, length & 0xFF]) + ct_dev)
    if res and res[1] == 0 and len(res[2]) == length:
        row["dev_dec_dev"] = (res[2] == pt)
    else:
        row["dev_dec_dev"] = False
        row["dev_dec_dev_status"] = ("timeout" if res is None
                                     else "0x%02X len=%d" % (res[1], len(res[2])))

    k_host = fixed_k("sm2-crypt-host-%d" % length)
    ct_host = sm2_encrypt(pub, pt, k_host)
    res = link.command(CMD_SM2_DEC,
                       bytes([ID_TMP_SM2_DEC, 1,
                              (length >> 8) & 0xFF, length & 0xFF]) + ct_host)
    if res and res[1] == 0 and len(res[2]) == length:
        row["dev_dec_host"] = (res[2] == pt)
    else:
        row["dev_dec_host"] = False
        row["dev_dec_host_status"] = ("timeout" if res is None
                                      else "0x%02X len=%d" % (res[1], len(res[2])))
    row["k_host"] = k_host
    row["ct_host"] = ct_host
    row["ok"] = bool(row["host_dec"] and row["dev_dec_dev"]
                     and row["dev_dec_host"])
    return row


def main():
    ap = argparse.ArgumentParser(description="SM2 加解密测试（临时槽 3，不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--slot", type=lambda x: int(x, 0), default=ID_TMP_SM2_DEC)
    ap.add_argument("--lengths", default="16,24,32,48,64",
                    help="明文长度列表，逗号分隔，最大 64")
    ap.add_argument("--out", default=default_report(__file__, "sm2_crypt_report.md"))
    args = ap.parse_args()

    if args.slot != ID_TMP_SM2_DEC:
        raise SystemExit("只允许临时解密槽 3；OTP 槽不在本测试范围")
    lengths = [int(x, 0) for x in args.lengths.split(",") if x.strip()]
    if not lengths or any(L < 1 or L > 64 for L in lengths):
        raise SystemExit("明文长度必须在 1..64（ROM SM2 解密栈限制）")

    print("[安全] 只使用临时槽 3，不发送写 OTP 命令", flush=True)
    link = Link(args.port, args.baud)
    rows = []
    try:
        info = prepare_key(link, args.slot, regenerate=True)
        print("  GENKEY(3): %s" % ("OK" if info["genkey"] else "FAIL"), flush=True)
        print("  GETPUBKEY(3): %s" % (
            hex_bytes(info["pub"]) if info["pub"] else "FAIL"), flush=True)
        print("  私钥导出/匹配: %s" % ("OK" if info["match"] else "FAIL"),
              flush=True)
        if not (info["genkey"] and info["pub"] and info["priv"] and info["match"]):
            print("  准备失败，停止加解密测试", flush=True)
        else:
            for L in lengths:
                print("\n[明文 %d B]" % L, flush=True)
                row = run_one(link, info["pub"], info["priv"], L)
                rows.append(row)
                print("  设备加密/上位机解密: %s" % (
                    "OK" if row.get("host_dec") else "FAIL"), flush=True)
                print("  设备解密(设备密文): %s" % (
                    "OK" if row.get("dev_dec_dev") else "FAIL"), flush=True)
                print("  设备解密(上位机密文): %s" % (
                    "OK" if row.get("dev_dec_host") else "FAIL"), flush=True)
    finally:
        link.close()

    ok_all = bool(rows) and all(r["ok"] for r in rows)

    md = []
    md.append("# SM2 加解密报告\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：只使用临时槽 3（RAM），不发送 SET_PASSWORD / "
              "KEY_STORE / KEY_DESTROY，不写 OTP。\n\n")
    if not rows:
        md.append("准备阶段失败，未执行加解密用例。\n\n")
    else:
        md.append("| 组 | 明文长度 | 设备 k | 设备密文 | 设备加密→上位机解密 | "
                  "设备解密(设备密文) | 上位机 k | 上位机密文 | "
                  "设备解密(上位机密文) | 结果 |\n")
        md.append("|---|---|---|---|---|---|---|---|---|---|\n")
        for i, r in enumerate(rows, 1):
            md.append("| %d | %d | `%s` | `%s` | %s | %s | `%s` | `%s` | %s | %s |\n"
                      % (i, r["length"],
                         hex_bytes(r.get("k_dev", b"")),
                         hex_bytes(r.get("ct_dev", b"")),
                         "OK" if r.get("host_dec") else "FAIL",
                         "OK" if r.get("dev_dec_dev") else "FAIL",
                         hex_bytes(r.get("k_host", b"")),
                         hex_bytes(r.get("ct_host", b"")),
                         "OK" if r.get("dev_dec_host") else "FAIL",
                         "通过" if r["ok"] else "失败"))
    md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在失败项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if ok_all else "存在失败项"))
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

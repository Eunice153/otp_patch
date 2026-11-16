#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM4 密钥导入测试（0x40 ECB 验证，临时槽 5，不写 OTP）。

流程：
    KEY_LOAD(dec_id, 口令)            可选：只读加载 OTP 密钥到 SRAM
    GETPUBKEY(dec_id)                 只读 OTP 公钥
    上位机生成/指定 16B SM4 密钥
    用 OTP 公钥做 SM2 包裹
    KEY_IMPORT(target=5, dec_id, 1, wrapped)
    EXPORT_KEY(5,1) 导出并比对
    0x40 ECB 加密/解密验证导入密钥

原 0x20 脚本 sm4_key_import.py 保留不变。
报告默认写入 ../../sm4_report/sm4_key_import_40_report.md。
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
    Link, CMD_KEY_LOAD, CMD_KEY_IMPORT, ID_TMP_SM4, hex_bytes,
)
from common.sm2_crypto import fixed_k, sm2_encrypt  # noqa: E402
from common.sm2_tools import getpub  # noqa: E402
from common.sm4_bulk import bulk_crypt  # noqa: E402
from common.sm4_crypto import sm4_ecb_encrypt  # noqa: E402
from common.sm4_tools import (  # noqa: E402
    SM4_ECB, SM4_ENCRYPT, SM4_DECRYPT, recover_key,
)
from common.paths import default_report, now_str, write_report  # noqa: E402


def main():
    ap = argparse.ArgumentParser(
        description="SM4 密钥导入（0x40 验证，临时槽 5，不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--dec-id", type=lambda x: int(x, 0), default=0,
                    help="OTP 解密密钥槽 0/1，默认 0")
    ap.add_argument("--key", default=None,
                    help="可选：导入的 16B SM4 密钥 hex（32 个 hex 字符）")
    ap.add_argument("--password", default=None,
                    help="可选：OTP 口令；先 KEY_LOAD 只读加载 OTP 密钥到 SRAM")
    ap.add_argument("--show-key", action="store_true",
                    help="报告/控制台显示导入的临时 SM4 密钥")
    ap.add_argument("--timeout", type=float, default=30.0)
    ap.add_argument("--out",
                    default=default_report(__file__, "sm4_key_import_40_report.md"))
    args = ap.parse_args()

    if args.dec_id not in (0, 1):
        raise SystemExit("--dec-id 只能是 OTP SM2 解密槽 0 或签名槽 1")

    if args.key:
        key_hex = args.key.strip().replace(" ", "")
        if key_hex.lower().startswith("0x"):
            key_hex = key_hex[2:]
        key = bytes.fromhex(key_hex)
        if len(key) != 16:
            raise SystemExit("--key 必须是 16B（32 个 hex 字符）")
    else:
        key = os.urandom(16)

    pwd = None
    if args.password is not None:
        pwd = args.password.encode("utf-8")
        if not (12 <= len(pwd) <= 32):
            raise SystemExit("--password 长度必须 12..32 字节")

    print("[安全] KEY_LOAD 只读加载 OTP→SRAM；KEY_IMPORT 目标为临时槽 5；不写 OTP",
          flush=True)
    link = Link(args.port, args.baud)
    row = {"ok": False}
    try:
        if pwd is not None:
            res = link.command(CMD_KEY_LOAD, bytes([args.dec_id]) + pwd)
            row["key_load_status"] = ("timeout" if res is None
                                      else "0x%02X" % res[1])
            row["key_load_ok"] = bool(res and res[1] == 0)
            print("  KEY_LOAD(%d): %s（只读加载 OTP→SRAM）"
                  % (args.dec_id, row["key_load_status"]), flush=True)
        else:
            row["key_load_status"] = "未提供 --password（跳过 KEY_LOAD）"

        otp_pub = getpub(link, args.dec_id)
        if otp_pub is None:
            row["otp_pub"] = None
            print("  GETPUBKEY(%d): 未加载/未配置；如已配置 OTP 密钥，"
                  "用 --password 先 KEY_LOAD（只读）" % args.dec_id,
                  flush=True)
        else:
            row["otp_pub"] = otp_pub
            print("  OTP 公钥(%d): %s"
                  % (args.dec_id, hex_bytes(otp_pub)), flush=True)

            k_wrap = fixed_k("sm4-import-wrap-%d" % args.dec_id)
            wrapped = sm2_encrypt(otp_pub, key, k_wrap)
            row["wrapped"] = wrapped
            print("  包裹密文长度: %d B" % len(wrapped), flush=True)

            res = link.command(CMD_KEY_IMPORT,
                               bytes([ID_TMP_SM4, args.dec_id, 1]) + wrapped)
            row["import_status"] = ("timeout" if res is None
                                    else "0x%02X" % res[1])
            row["import_ok"] = bool(res and res[1] == 0)
            print("  KEY_IMPORT: %s" % row["import_status"], flush=True)

            if row["import_ok"]:
                info = recover_key(link, regenerate=False)
                imported = info["key"]
                row["imported"] = imported
                row["key_match"] = (imported == key)
                print("  EXPORT_KEY(5,1) 密钥匹配: %s" % (
                    "OK" if row["key_match"] else "FAIL"), flush=True)

                pt = bytes(range(16))
                ref_ct = sm4_ecb_encrypt(key, pt)
                res = bulk_crypt(link, SM4_ECB, SM4_ENCRYPT, None, pt,
                                 timeout=args.timeout)
                ok_enc = bool(res and res[0] == 0 and res[1] == ref_ct)
                ok_dec = False
                if ok_enc:
                    res = bulk_crypt(link, SM4_ECB, SM4_DECRYPT, None, ref_ct,
                                     timeout=args.timeout)
                    ok_dec = bool(res and res[0] == 0 and res[1] == pt)
                row["enc_ok"] = ok_enc
                row["dec_ok"] = ok_dec
                print("  0x40 ECB 加密: %s，解密: %s"
                      % ("OK" if ok_enc else "FAIL",
                         "OK" if ok_dec else "FAIL"), flush=True)
                row["ok"] = bool(row["key_match"] and ok_enc and ok_dec)
    finally:
        link.close()

    md = []
    md.append("# SM4 密钥导入报告（0x40）\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：`KEY_LOAD` 只读加载 OTP 密钥到 SRAM；"
              "`KEY_IMPORT` 只写临时槽 5（RAM）。"
              "本脚本不发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY，不写 OTP。\n\n")
    md.append("说明：本脚本用 NO3 的 `0x40 SM4_BULK` 做导入后 ECB 验证；"
              "原 `0x20` 版本 `sm4_key_import.py` 保留。\n\n")
    md.append("| 项目 | 值 |\n|---|---|\n")
    md.append("| OTP 解密密钥槽 | %d |\n" % args.dec_id)
    md.append("| OTP 密钥加载 (KEY_LOAD) | %s |\n"
              % row.get("key_load_status", "未执行"))
    otp_pub = row.get("otp_pub")
    md.append("| OTP 公钥 | %s |\n" % (
        "`%s`" % hex_bytes(otp_pub) if otp_pub
        else "未加载/读取失败（可加 --password 先 KEY_LOAD）"))
    md.append("| 导入目标 | 临时槽 5 |\n")
    if args.show_key:
        md.append("| 导入/候选密钥 K | `%s` |\n" % hex_bytes(key))
    elif row.get("import_ok"):
        md.append("| 导入密钥 K | 已校验（不显示；加 --show-key 可显示） |\n")
    else:
        md.append("| 导入密钥 K | 未导入（候选值已生成；加 --show-key 可显示） |\n")
    if row.get("wrapped"):
        md.append("| 包裹密文（SM2） | `%s` |\n" % hex_bytes(row["wrapped"]))
    md.append("| KEY_IMPORT 状态 | %s |\n" % row.get("import_status", "未执行"))
    md.append("\n| 校验项 | 结果 |\n|---|---|\n")
    if row.get("otp_pub") is None:
        md.append("| OTP 公钥 | 未加载/读取失败，未执行导入 |\n")
    else:
        md.append("| 导出密钥匹配 | %s |\n" % (
            "OK" if row.get("key_match") else "FAIL"))
        md.append("| 0x40 ECB 加密 | %s |\n" % (
            "OK" if row.get("enc_ok") else "FAIL"))
        md.append("| 0x40 ECB 解密 | %s |\n" % (
            "OK" if row.get("dec_ok") else "FAIL"))
    md.append("\n结论：%s\n" % ("全部符合预期" if row["ok"] else "存在失败/未执行项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if row["ok"] else "存在失败/未执行项"))
    return 0 if row["ok"] else 1


if __name__ == "__main__":
    sys.exit(main())

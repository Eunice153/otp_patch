#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM2 加解密密钥导入测试（临时槽 3，不写 OTP）。

流程：
    GETPUBKEY(dec_id) 读取 OTP 解密槽公钥（只读）
    上位机生成新私钥 d，并用 OTP 公钥做 SM2 包裹
    KEY_IMPORT(target=3, dec_id, ct) 导入临时槽 3
    GETPUBKEY(3) 比对公钥
    LOAD_PUBKEY(TEST_D) + EXPORT_KEY(3,1) 导出私钥比对
    SM2_ENC -> SM2_DEC(3) 验证导入密钥可用于解密

注意：KEY_IMPORT 只写临时槽 3；脚本不会写 OTP。若 OTP 解密槽
未配置，脚本会停止并报告，不会尝试 SET_PASSWORD / KEY_STORE。
报告默认写入 ../../sm2_report/sm2_key_import_report.md。
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
    Link, CMD_GETPUBKEY, CMD_KEY_IMPORT, CMD_KEY_LOAD,
    CMD_SM2_ENC, CMD_SM2_DEC, ID_TMP_SM2_DEC, hex_bytes,
)
from common.sm2_crypto import (  # noqa: E402
    N_CURVE, fixed_k, pub_from_priv, rand_k, sm2_encrypt,
)
from common.sm2_tools import export_priv, getpub  # noqa: E402
from common.paths import default_report, now_str, write_report  # noqa: E402


def main():
    ap = argparse.ArgumentParser(description="SM2 加解密密钥导入（临时槽 3，不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--target", type=lambda x: int(x, 0), default=ID_TMP_SM2_DEC,
                    help="导入目标临时槽，默认 3")
    ap.add_argument("--dec-id", type=lambda x: int(x, 0), default=0,
                    help="OTP 解密密钥槽 0/1，默认 0")
    ap.add_argument("--key", default=None,
                    help="可选：导入的 32B 私钥 hex；不填则随机生成")
    ap.add_argument("--password", default=None,
                    help="可选：OTP 口令；先 KEY_LOAD 只读加载 OTP 密钥到 SRAM")
    ap.add_argument("--show-private", action="store_true",
                    help="报告/控制台显示导入的临时私钥")
    ap.add_argument("--out", default=default_report(__file__, "sm2_key_import_report.md"))
    args = ap.parse_args()

    if args.target != ID_TMP_SM2_DEC:
        raise SystemExit("加解密密钥导入只允许目标临时槽 3")
    if args.dec_id not in (0, 1):
        raise SystemExit("--dec-id 只能是 OTP SM2 解密槽 0 或签名槽 1")

    pwd = None
    if args.password is not None:
        pwd = args.password.encode("utf-8")
        if not (12 <= len(pwd) <= 32):
            raise SystemExit("--password 长度必须 12..32 字节")

    if args.key:
        key_hex = args.key.strip().replace(" ", "")
        if key_hex.lower().startswith("0x"):
            key_hex = key_hex[2:]
        d = bytes.fromhex(key_hex)
        if len(d) != 32:
            raise SystemExit("--key 必须是 32B（64 个 hex 字符）")
        if not (1 <= int.from_bytes(d, "big") < N_CURVE):
            raise SystemExit("--key 超出 SM2 私钥范围")
    else:
        d = rand_k()
    pub_new = pub_from_priv(d)

    print("[安全] KEY_LOAD 只读加载 OTP→SRAM；KEY_IMPORT 目标为临时槽 3；不写 OTP",
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
            print("  OTP 解密公钥(%d): %s" % (args.dec_id, hex_bytes(otp_pub)),
                  flush=True)

            k_wrap = fixed_k("sm2-import-wrap-%d" % args.dec_id)
            wrapped = sm2_encrypt(otp_pub, d, k_wrap)
            row["k_wrap"] = k_wrap
            row["wrapped"] = wrapped
            print("  包裹密文长度: %d B" % len(wrapped), flush=True)

            res = link.command(CMD_KEY_IMPORT,
                               bytes([args.target, args.dec_id, 1]) + wrapped)
            row["import_status"] = ("timeout" if res is None
                                    else "0x%02X" % res[1])
            row["import_ok"] = bool(res and res[1] == 0)
            print("  KEY_IMPORT: %s" % row["import_status"], flush=True)

            if row["import_ok"]:
                dev_pub = getpub(link, args.target)
                row["dev_pub"] = dev_pub
                row["pub_match"] = (dev_pub == pub_new)
                print("  GETPUBKEY(3) 匹配: %s" % (
                    "OK" if row["pub_match"] else "FAIL"), flush=True)

                d_export = export_priv(link, args.target)
                row["d_export"] = d_export
                row["export_match"] = (d_export == d)
                print("  导出私钥匹配: %s" % (
                    "OK" if row["export_match"] else "FAIL"), flush=True)

                pt = b"import-test-1234"
                k_enc = fixed_k("sm2-import-decrypt")
                res = link.command(CMD_SM2_ENC,
                                   bytes([1]) + pub_new + k_enc + pt)
                if res and res[1] == 0 and len(res[2]) == 96 + len(pt):
                    ct = res[2]
                    row["ct"] = ct
                    res = link.command(CMD_SM2_DEC,
                                       bytes([args.target, 1, 0, len(pt)]) + ct)
                    row["dec_ok"] = bool(res and res[1] == 0 and res[2] == pt)
                else:
                    row["dec_ok"] = False
                print("  导入密钥解密测试: %s" % (
                    "OK" if row["dec_ok"] else "FAIL"), flush=True)

                row["ok"] = bool(row["pub_match"] and row["export_match"]
                                 and row["dec_ok"])
    finally:
        link.close()

    md = []
    md.append("# SM2 加解密密钥导入报告\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：`KEY_LOAD` 只读加载 OTP 密钥到 SRAM；`GETPUBKEY` 只读公钥；"
              "`KEY_IMPORT` 只写临时槽 3（RAM）。"
              "本脚本不发送 SET_PASSWORD / KEY_STORE / KEY_DESTROY，不写 OTP。\n\n")
    md.append("| 项目 | 值 |\n|---|---|\n")
    md.append("| OTP 解密密钥槽 | %d |\n" % args.dec_id)
    md.append("| OTP 密钥加载 (KEY_LOAD) | %s |\n"
              % row.get("key_load_status", "未执行"))
    otp_pub = row.get("otp_pub")
    md.append("| OTP 公钥 | %s |\n" % (
        "`%s`" % hex_bytes(otp_pub) if otp_pub
        else "未加载/读取失败（可加 --password 先 KEY_LOAD）"))
    md.append("| 导入目标 | 临时槽 %d |\n" % args.target)
    if args.show_private:
        md.append("| 导入私钥 d | `%s` |\n" % hex_bytes(d))
    elif row.get("import_ok"):
        md.append("| 导入私钥 d | 已校验（不显示；加 --show-private 可显示） |\n")
    else:
        md.append("| 导入私钥 d | 未导入（候选值已生成；加 --show-private 可显示） |\n")
    md.append("| %s | `%s` |\n"
              % ("导入公钥" if row.get("import_ok") else "候选导入公钥",
                 hex_bytes(pub_new)))
    if row.get("wrapped"):
        md.append("| 包裹密文（SM2） | `%s` |\n" % hex_bytes(row["wrapped"]))
    md.append("| KEY_IMPORT 状态 | %s |\n" % row.get("import_status", "未执行"))
    md.append("\n| 校验项 | 结果 |\n|---|---|\n")
    if row.get("otp_pub") is None:
        md.append("| OTP 解密公钥 | 未加载/读取失败，未执行导入 |\n")
    else:
        md.append("| GETPUBKEY(目标) 公钥匹配 | %s |\n" % (
            "OK" if row.get("pub_match") else "FAIL"))
        md.append("| 导出私钥匹配 | %s |\n" % (
            "OK" if row.get("export_match") else "FAIL"))
        md.append("| 导入密钥解密测试 | %s |\n" % (
            "OK" if row.get("dec_ok") else "FAIL"))
    md.append("\n结论：%s\n" % ("全部符合预期" if row["ok"] else "存在失败/未执行项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if row["ok"] else "存在失败/未执行项"))
    return 0 if row["ok"] else 1


if __name__ == "__main__":
    sys.exit(main())

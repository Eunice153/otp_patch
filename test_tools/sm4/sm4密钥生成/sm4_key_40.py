#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM4 密钥生成/导出测试（0x40 ECB 自检，临时槽 5，不写 OTP）。

流程：
    GENKEY(5)
    LOAD_PUBKEY(TEST_D 公钥)
    EXPORT_KEY(5, 1)
    上位机用 TEST_D 解出 16B SM4 密钥
    用 0x40 SM4_BULK 做 ECB 加密/解密自检

报告默认写入 ../../sm4_report/sm4_key_40_report.md。
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
    Link, CMD_GENKEY, CMD_LOAD_PUBKEY, CMD_EXPORT_KEY, ID_TMP_SM4, hex_bytes,
)
from common.sm2_crypto import TEST_D, sm2_decrypt, test_d_public  # noqa: E402
from common.sm4_bulk import bulk_crypt  # noqa: E402
from common.sm4_crypto import sm4_ecb_encrypt  # noqa: E402
from common.sm4_tools import SM4_ECB, SM4_ENCRYPT, SM4_DECRYPT  # noqa: E402
from common.paths import default_report, now_str, write_report  # noqa: E402


def main():
    ap = argparse.ArgumentParser(
        description="SM4 密钥生成/导出（0x40 自检，临时槽 5，不写 OTP）")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--timeout", type=float, default=30.0)
    ap.add_argument("--out",
                    default=default_report(__file__, "sm4_key_40_report.md"))
    args = ap.parse_args()

    print("[安全] 只使用临时槽 5，不发送写 OTP 命令", flush=True)
    link = Link(args.port, args.baud)
    row = {"genkey": False, "load": False, "export": False,
           "key": None, "enc_ok": False, "dec_ok": False}
    try:
        res = link.command(CMD_GENKEY, bytes([ID_TMP_SM4]))
        row["genkey"] = bool(res and res[1] == 0)
        print("  GENKEY(5): %s" % ("OK" if row["genkey"] else "FAIL"),
              flush=True)

        res = link.command(CMD_LOAD_PUBKEY, test_d_public())
        row["load"] = bool(res and res[1] == 0)
        print("  LOAD_PUBKEY(TEST_D): %s" % ("OK" if row["load"] else "FAIL"),
              flush=True)

        res = link.command(CMD_EXPORT_KEY, bytes([ID_TMP_SM4, 1]))
        if res and res[1] == 0 and len(res[2]) == 112:
            try:
                key = sm2_decrypt(res[2], TEST_D)
                if len(key) == 16:
                    row["key"] = key
                    row["export"] = True
            except Exception as e:
                print("  导出密钥解包失败: %s" % e, flush=True)
        print("  EXPORT_KEY(5,1): %s" % ("OK" if row["export"] else "FAIL"),
              flush=True)

        if row["key"] is not None:
            print("  密钥 K: %s" % hex_bytes(row["key"]), flush=True)
            pt = bytes(range(16))
            ref_ct = sm4_ecb_encrypt(row["key"], pt)
            res = bulk_crypt(link, SM4_ECB, SM4_ENCRYPT, None, pt,
                             timeout=args.timeout)
            row["enc_ok"] = bool(res and res[0] == 0 and res[1] == ref_ct)
            if row["enc_ok"]:
                res = bulk_crypt(link, SM4_ECB, SM4_DECRYPT, None, ref_ct,
                                 timeout=args.timeout)
                row["dec_ok"] = bool(res and res[0] == 0 and res[1] == pt)
            print("  0x40 ECB 加密自检: %s"
                  % ("OK" if row["enc_ok"] else "FAIL"), flush=True)
            print("  0x40 ECB 解密自检: %s"
                  % ("OK" if row["dec_ok"] else "FAIL"), flush=True)
    finally:
        link.close()

    ok_all = bool(row["genkey"] and row["load"] and row["export"]
                  and row["enc_ok"] and row["dec_ok"])

    md = []
    md.append("# SM4 密钥生成报告（0x40）\n\n")
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：只使用临时槽 5（RAM），不发送 SET_PASSWORD / "
              "KEY_STORE / KEY_DESTROY，不写 OTP。\n\n")
    md.append("说明：本脚本用 NO3 的 `0x40 SM4_BULK` 做 ECB 自检；"
              "本脚本使用 NO3 的 `0x40 SM4_BULK`。\n\n")
    md.append("| 项目 | 结果 |\n|---|---|\n")
    md.append("| GENKEY(5) | %s |\n" % ("OK" if row["genkey"] else "FAIL"))
    md.append("| LOAD_PUBKEY(TEST_D) | %s |\n" % ("OK" if row["load"] else "FAIL"))
    md.append("| EXPORT_KEY(5,1) / 解包 | %s |\n"
              % ("OK" if row["export"] else "FAIL"))
    md.append("| 密钥 K（16B，临时） | `%s` |\n"
              % (hex_bytes(row["key"]) if row["key"] else "-"))
    md.append("| 0x40 ECB 加密自检 | %s |\n"
              % ("OK" if row["enc_ok"] else "FAIL"))
    md.append("| 0x40 ECB 解密自检 | %s |\n"
              % ("OK" if row["dec_ok"] else "FAIL"))
    md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在失败项"))
    write_report(args.out, "".join(md))

    print("\n报告已写入：%s" % args.out)
    print("结论：" + ("全部符合预期" if ok_all else "存在失败项"))
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())

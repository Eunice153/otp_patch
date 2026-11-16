#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
SM4 正确性验证报告生成器（串口命令接口）

生成认证报告 "2. 正确性验证 / 2.1 串口命令接口 / 2.1.1 SM4 算法" 所需数据：

  (1) 加密(ECB模式)：5 组明文，设备加密，独立 Python SM4 参考实现比对
  (2) 解密(ECB模式)：设备解密，与原文比对
  (3) 加密(CBC模式)：固定 IV，设备加密，独立参考实现比对
  (4) 解密(CBC模式)：设备解密，与原文比对

密钥：GENKEY(5) 生成临时 SM4 密钥，LOAD_PUBKEY(TEST_D) + SM4_EXPORT(5,1)
      导出包裹，上位机用 TEST_D 做 SM2 解密恢复 16B 密钥。
      只用临时槽 5，不写 OTP。

默认输出：脚本同目录 sm4_cert_report.md

用法：
    python3 sm4_cert_report.py COM24
    python3 sm4_cert_report.py COM24 --out /tmp/sm4_report.md
"""

import argparse
import codecs
import os
import subprocess
import sys
import time


def _win_out_args(argv):
    """WSL 下把 --out 路径转成 Windows 路径，防止 /tmp 被解释成 C:\\tmp。"""
    def conv(p):
        try:
            return subprocess.check_output(
                ["wslpath", "-w", os.path.abspath(p)], text=True
            ).strip()
        except Exception:
            return p

    out = []
    i = 0
    while i < len(argv):
        a = argv[i]
        if a == "--out" and i + 1 < len(argv):
            out += [a, conv(argv[i + 1])]
            i += 2
        elif a.startswith("--out="):
            out.append("--out=" + conv(a[6:]))
            i += 1
        else:
            out.append(a)
            i += 1
    return out


# WSL：COMx 属于 Windows，Linux Python 打不开，自动转用 Windows Python
if os.name == "posix" and any(a.upper().startswith("COM") for a in sys.argv[1:]):
    _WINPY = os.environ.get("WINPY", "/mnt/d/download/zephyr/python/python.exe")
    if os.path.exists(_WINPY):
        try:
            _script_win = subprocess.check_output(
                ["wslpath", "-w", os.path.abspath(__file__)], text=True
            ).strip()
            sys.stderr.write("检测到 WSL + COM 口，转用 Windows Python：%s\n" % _WINPY)
            sys.stderr.flush()
            _p = subprocess.Popen([_WINPY, "-u", _script_win] + _win_out_args(sys.argv[1:]),
                                  stdout=subprocess.PIPE,
                                  stderr=subprocess.STDOUT)
            try:
                _decoder = codecs.getincrementaldecoder("gbk")(errors="replace")
                while True:
                    _chunk = os.read(_p.stdout.fileno(), 4096)
                    if not _chunk:
                        break
                    sys.stdout.write(_decoder.decode(_chunk))
                    sys.stdout.flush()
                sys.stdout.write(_decoder.decode(b"", final=True))
                sys.stdout.flush()
            except KeyboardInterrupt:
                sys.stderr.write("\n中止，正在关闭串口...\n")
                _p.kill()
                raise
            finally:
                _p.wait()
            sys.exit(_p.returncode)
        except Exception as _e:
            sys.stderr.write("转用 Windows Python 失败：%s\n" % _e)
            sys.stderr.write("将按 Linux 原生方式继续尝试。\n")

import sm4_slot_test as t

LENS = (16, 32, 64, 256, 480)
IV = bytes(range(16))


def hx(data):
    return " ".join("%02X" % b for b in data)


def verdict(ok):
    return "通过" if ok else "失败"


def make_pt(n):
    return bytes(i & 0xFF for i in range(n))


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    ap = argparse.ArgumentParser(description="SM4 正确性验证报告生成器")
    ap.add_argument("port", help="串口，例如 COM24 或 /dev/ttyUSB0")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--out", default=os.path.join(here, "sm4_cert_report.md"),
                    help="输出 Markdown 路径")
    args = ap.parse_args()

    link = t.Link(args.port, args.baud)
    try:
        print("[1/2] 恢复临时槽 5 的 SM4 密钥 ...", flush=True)
        key = t.recover_key(link)
        print("      密钥: " + hx(key), flush=True)

        rows = []
        failures = []
        print("[2/2] 5 组 ECB/CBC 加解密 ...", flush=True)
        for i, n in enumerate(LENS, 1):
            pt = make_pt(n)

            # ECB
            ect = t.sm4_crypt(link, 0, 0, None, pt)
            ref_ect = t.sm4_ecb_encrypt(key, pt)
            ok_ect = (len(ect) == n and ect == ref_ect)

            edec = t.sm4_crypt(link, 0, 1, None, ect)
            ok_edec = (len(edec) == n and edec == pt)

            # CBC
            cct = t.sm4_crypt(link, 1, 0, IV, pt)
            ref_cct = t.sm4_cbc_encrypt(key, IV, pt)
            ok_cct = (len(cct) == n and cct == ref_cct)

            cdec = t.sm4_crypt(link, 1, 1, IV, cct)
            ok_cdec = (len(cdec) == n and cdec == pt)

            if not all((ok_ect, ok_edec, ok_cct, ok_cdec)):
                failures.append(i)
            rows.append((i, n, pt, ect, ref_ect, edec,
                         cct, ref_cct, cdec,
                         ok_ect, ok_edec, ok_cct, ok_cdec))
            print("      第 %d 组（%3d B）：ECB 加密%s ECB 解密%s CBC 加密%s CBC 解密%s"
                  % (i, n, verdict(ok_ect), verdict(ok_edec),
                     verdict(ok_cct), verdict(ok_cdec)), flush=True)

        md = []
        md.append("# 2. 正确性验证\n\n")
        md.append("## 2.1 串口命令接口\n\n")
        md.append("### 2.1.1 SM4 算法\n\n")
        md.append("**测试条件**\n\n")
        md.append("- 测试时间：%s\n" % time.strftime("%Y-%m-%d %H:%M:%S"))
        md.append("- 串口：%s，%d bps，8N1\n" % (args.port, args.baud))
        md.append("- 密钥位置：临时槽 5（RAM），不写入 OTP；密钥每次运行随机生成\n")
        md.append("- 参考实现：独立的 Python SM4 实现（ECB/CBC）\n")
        md.append("- 5 组长度：16/32/64/256/480 B；明文规则 `pt[i] = i & 0xFF`\n")
        md.append("- CBC IV：`%s`\n\n" % hx(IV))
        md.append("**测试参数**\n\n")
        md.append("- 密钥 K（16 B）：`%s`\n\n" % hx(key))

        md.append("#### (1) 加密(ECB模式)\n\n")
        md.append("| 组 | 明文长度 | 明文 | 设备密文 | 参考实现密文 | 结论 |\n")
        md.append("|---|---|---|---|---|---|\n")
        for (i, n, pt, ect, ref_ect, edec,
             cct, ref_cct, cdec, ok_ect, ok_edec, ok_cct, ok_cdec) in rows:
            md.append("| %d | %d B | `%s` | `%s` | `%s` | %s |\n"
                      % (i, n, hx(pt), hx(ect), hx(ref_ect), verdict(ok_ect)))
        md.append("\n")

        md.append("#### (2) 解密(ECB模式)\n\n")
        md.append("| 组 | 密文长度 | 输入密文 | 设备明文 | 预期明文 | 结论 |\n")
        md.append("|---|---|---|---|---|---|\n")
        for (i, n, pt, ect, ref_ect, edec,
             cct, ref_cct, cdec, ok_ect, ok_edec, ok_cct, ok_cdec) in rows:
            md.append("| %d | %d B | `%s` | `%s` | `%s` | %s |\n"
                      % (i, n, hx(ect), hx(edec), hx(pt), verdict(ok_edec)))
        md.append("\n")

        md.append("#### (3) 加密(CBC模式)\n\n")
        md.append("| 组 | 明文长度 | 明文 | 设备密文 | 参考实现密文 | 结论 |\n")
        md.append("|---|---|---|---|---|---|\n")
        for (i, n, pt, ect, ref_ect, edec,
             cct, ref_cct, cdec, ok_ect, ok_edec, ok_cct, ok_cdec) in rows:
            md.append("| %d | %d B | `%s` | `%s` | `%s` | %s |\n"
                      % (i, n, hx(pt), hx(cct), hx(ref_cct), verdict(ok_cct)))
        md.append("\n")

        md.append("#### (4) 解密(CBC模式)\n\n")
        md.append("| 组 | 密文长度 | 输入密文 | 设备明文 | 预期明文 | 结论 |\n")
        md.append("|---|---|---|---|---|---|\n")
        for (i, n, pt, ect, ref_ect, edec,
             cct, ref_cct, cdec, ok_ect, ok_edec, ok_cct, ok_cdec) in rows:
            md.append("| %d | %d B | `%s` | `%s` | `%s` | %s |\n"
                      % (i, n, hx(cct), hx(cdec), hx(pt), verdict(ok_cdec)))
        md.append("\n")

        md.append("### 结论\n\n")
        if failures:
            md.append("存在失败项：第 %s 组。\n"
                      % "、".join(str(x) for x in failures))
        else:
            md.append("5 组 ECB/CBC 加密、解密结果均正确，"
                      "SM4 算法串口命令接口正确性验证通过。\n")

        with open(args.out, "w", encoding="utf-8", newline="\n") as f:
            f.write("".join(md))

        print("\n报告已写入：%s" % args.out)
        print("结论：" + ("全部通过" if not failures else "存在失败项"))
        return 0 if not failures else 1
    finally:
        link.close()


if __name__ == "__main__":
    sys.exit(main())

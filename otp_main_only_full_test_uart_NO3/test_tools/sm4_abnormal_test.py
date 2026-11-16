#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
SM4 非正常输入测试：发送非法/异常 SM4 命令，记录设备响应。

覆盖：
  - 数据长度为 0 / 非 16 字节倍数
  - 非法 id / mode / op
  - CBC 缺 IV / IV 后数据不是 16 的倍数

输出：
  - 控制台表格（含每次完整发送/返回帧）
  - 默认 sm4_abnormal_report.md
    列：序号 / 非正常输入 / 完整发送数据 / 完整返回数据 /
        设备响应 / 预期 / 结论

安全：
  只用临时槽 5（GENKEY(5)，RAM）和 SM4_CRYPT 负向用例；
  不发送 OTP 槽命令，不调用 SET_PASSWORD / KEY_STORE / KEY_IMPORT，
  不写 OTP。

用法：
    python3 sm4_abnormal_test.py COM24
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

SOF = 0x5A
CMD_GENKEY = 0x11
CMD_SM4_CRYPT = 0x20


def hex_bytes(data):
    return " ".join("%02X" % b for b in data)


def build_frame(cmd, data=b"", declared_len=None):
    if declared_len is None:
        declared_len = len(data)
    return bytes([SOF, cmd,
                  (declared_len >> 8) & 0xFF, declared_len & 0xFF]) + data


def raw_command(link, cmd, data=b"", declared_len=None, timeout=1.0):
    """发送原始帧；返回 (cmd, status, data, raw)，无应答返回 None。"""
    frame = build_frame(cmd, data, declared_len)
    link.ser.reset_input_buffer()
    link.ser.write(frame)
    link.ser.flush()

    buf = bytearray()
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        b = link.ser.read(1)
        if not b:
            continue
        buf.append(b[0])
        start = buf.find(bytes([SOF]))
        if start < 0:
            buf.clear()
            continue
        if start > 0:
            del buf[:start]
        if len(buf) < 5:
            continue
        need = (buf[3] << 8) | buf[4]
        if len(buf) >= 5 + need:
            return (buf[1], buf[2], bytes(buf[5:5 + need]),
                    bytes(buf[:5 + need]))
    return None


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    ap = argparse.ArgumentParser(description="SM4 非正常输入测试")
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--out", default=os.path.join(here, "sm4_abnormal_report.md"))
    args = ap.parse_args()

    link = t.Link(args.port, args.baud)
    try:
        print("[安全] 只使用临时槽 5 和负向用例，不写 OTP", flush=True)
        # 先保证临时槽 5 有密钥（正常基线用）
        print("[准备] GENKEY(5) ...", flush=True)
        raw_command(link, CMD_GENKEY, bytes([5]), timeout=2.0)

        pt16 = bytes(range(16))
        iv16 = bytes(range(16))

        cases = []

        def add(name, cmd, data=b"", declared_len=None,
                expect=None, timeout=1.0, note=""):
            cases.append({
                "name": name, "cmd": cmd, "data": data,
                "declared_len": declared_len,
                "expect": expect, "timeout": timeout, "note": note,
            })

        # 正常基线
        add("正常 ECB 16B（基线）", CMD_SM4_CRYPT,
            bytes([5, 0, 0]) + pt16, expect=0x00)

        # 算法参数/长度异常
        add("数据长度 15B（非 16 倍数）", CMD_SM4_CRYPT,
            bytes([5, 0, 0]) + pt16[:15], expect=0xFE)
        add("数据长度 0", CMD_SM4_CRYPT,
            bytes([5, 0, 0]), expect=0xFE)
        add("非法 id=0x00", CMD_SM4_CRYPT,
            bytes([0x00, 0, 0]) + pt16, expect=0xFE)
        add("非法 id=0x06", CMD_SM4_CRYPT,
            bytes([0x06, 0, 0]) + pt16, expect=0xFE)
        add("非法 mode=0x02", CMD_SM4_CRYPT,
            bytes([5, 0x02, 0]) + pt16, expect=0xFE)
        add("非法 op=0x02", CMD_SM4_CRYPT,
            bytes([5, 0, 0x02]) + pt16, expect=0xFE)

        # CBC 异常
        add("CBC 只给 IV、无数据", CMD_SM4_CRYPT,
            bytes([5, 1, 0]) + iv16, expect=0xFE)
        add("CBC IV + 15B 数据", CMD_SM4_CRYPT,
            bytes([5, 1, 0]) + iv16 + pt16[:15], expect=0xFE)

        rows = []
        ok_all = True
        print("\n[SM4 非正常输入]", flush=True)
        for idx, c in enumerate(cases, 1):
            sent = build_frame(c["cmd"], c["data"], c["declared_len"])
            res = raw_command(link, c["cmd"], c["data"],
                              declared_len=c["declared_len"],
                              timeout=c["timeout"])
            if res is None:
                got = None
                resp = "无应答（超时）"
                raw_resp = None
            else:
                got = res[1]
                resp = "status=0x%02X, len=%d" % (res[1], len(res[2]))
                raw_resp = res[3]
            ok = (got == c["expect"])
            if not ok:
                ok_all = False
            exp = "无应答" if c["expect"] is None else "0x%02X" % c["expect"]
            print("  %2d. %-30s %-28s 预期=%-8s %s"
                  % (idx, c["name"], resp, exp, "通过" if ok else "失败"),
                  flush=True)
            print("      发送: %s" % hex_bytes(sent), flush=True)
            print("      返回: %s" % (hex_bytes(raw_resp)
                                      if raw_resp is not None else "无（超时）"),
                  flush=True)
            rows.append((idx, c["name"], sent, raw_resp, resp, exp, ok))
            time.sleep(0.05)

        md = []
        md.append("# SM4 非正常输入测试结果\n\n")
        md.append("测试时间：%s\n\n" % time.strftime("%Y-%m-%d %H:%M:%S"))
        md.append("说明：基线使用 GENKEY(5) 生成的临时槽 5 密钥（RAM），"
                  "密文每次运行会变化；本测试只发送 GENKEY(5) 和 "
                  "SM4_CRYPT，不发送 OTP 槽命令，不写 OTP。\n\n")
        md.append("| 序号 | 非正常输入 | 完整发送数据 | 完整返回数据 | 设备响应 | 预期 | 结论 |\n")
        md.append("|---|---|---|---|---|---|---|\n")
        for idx, name, sent, raw_resp, resp, exp, ok in rows:
            sent_cell = "`%s`" % hex_bytes(sent)
            resp_cell = ("`%s`" % hex_bytes(raw_resp)
                         if raw_resp is not None else "无（超时）")
            md.append("| %d | %s | %s | %s | %s | %s | %s |\n"
                      % (idx, name, sent_cell, resp_cell, resp, exp,
                         "通过" if ok else "失败"))
        md.append("\n结论：%s\n" % ("全部符合预期" if ok_all else "存在不符合预期项"))
        with open(args.out, "w", encoding="utf-8", newline="\n") as f:
            f.write("".join(md))

        print("\n报告已写入：%s" % args.out)
        print("结论：" + ("全部符合预期" if ok_all else "存在不符合预期项"))
        return 0 if ok_all else 1
    finally:
        link.close()


if __name__ == "__main__":
    sys.exit(main())

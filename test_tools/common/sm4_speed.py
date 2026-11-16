#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM4 ECB/CBC 速率测试公共实现（NO3 0x40）。

默认：128KB、3 轮、加密+解密。
也可以 --op enc 只测加密，或 --op dec 只测解密。

测量的是端到端时间：
    主机发送 0x40 大帧 + data
    -> 固件收齐 -> Invoke_SM4_enc_dec_process
    -> 主机收完整结果

Kbps 包含 UART 传输，不是纯 SM4 运算时间。
"""

import argparse
import time

from common.link import Link, hex_bytes
from common.paths import default_report, now_str, write_report
from common.sm4_bulk import DEFAULT_IV, bulk_crypt
from common.sm4_crypto import sm4_cbc_encrypt, sm4_ecb_encrypt
from common.sm4_tools import (
    SM4_CBC, SM4_DECRYPT, SM4_ECB, SM4_ENCRYPT, recover_key,
)

MAX_DATA = 131072


def parse_size(text):
    t = str(text).strip().upper()
    mul = 1
    if t.endswith("K"):
        mul = 1024
        t = t[:-1]
    elif t.endswith("M"):
        mul = 1024 * 1024
        t = t[:-1]
    try:
        n = int(t, 0) * mul
    except ValueError:
        raise argparse.ArgumentTypeError("size 必须是字节数或带 K/M 后缀")
    if n <= 0 or n > MAX_DATA or (n % 16) != 0:
        raise argparse.ArgumentTypeError(
            "size 必须在 16..%d 且为 16 的倍数" % MAX_DATA)
    return n


def make_data(size):
    return bytes(((i * 37 + 0x5A) & 0xFF) for i in range(size))


def one_round(link, mode, op, iv, data, timeout):
    t0 = time.perf_counter()
    res = bulk_crypt(link, mode, op, iv, data, timeout=timeout)
    dt = time.perf_counter() - t0
    return dt, res


def run_op(link, mode, op, iv, data, ref_out, runs, timeout, verify):
    rows = []
    for i in range(1, runs + 1):
        dt, res = one_round(link, mode, op, iv, data, timeout)
        if res is None:
            rows.append({"i": i, "time": dt, "ok": False, "err": "无应答"})
            print("  第 %d 轮：无应答" % i, flush=True)
            break
        status, out, raw = res
        ok = (status == 0 and len(out) == len(ref_out))
        if verify:
            ok = ok and (out == ref_out)
        rows.append({"i": i, "time": dt, "ok": ok, "err": ""})
        kbps = (len(data) * 8.0) / dt / 1000.0
        print("  第 %d 轮：%.3f s，%.2f Kbps，STATUS=0x%02X，%s"
              % (i, dt, kbps, status,
                 "结果 OK" if ok else "结果 FAIL"), flush=True)
        if not ok:
            break
    return rows


def render_table(label, data_size, rows, rate_label):
    md = []
    md.append("## %s\n\n" % label)
    md.append("| 数据大小 | " + " | ".join(
        "第 %d 次" % r["i"] for r in rows) +
        " | 平均执行时间 | %s(Kbps) |\n" % rate_label)
    md.append("|---|" + "---:|" * len(rows) + "---:|---:|\n")
    times = [r["time"] for r in rows if r["ok"]]
    avg_t = sum(times) / len(times) if times else 0.0
    avg_kbps = (data_size * 8.0) / avg_t / 1000.0 if avg_t else 0.0
    md.append("| %d B | " % data_size + " | ".join(
        "%.3f s" % r["time"] for r in rows) +
        " | %.3f s | %.2f |\n\n" % (avg_t, avg_kbps))
    return md, avg_t, avg_kbps


def speed_main(mode, report_name, script_file):
    mode_name = "ECB" if mode == SM4_ECB else "CBC"
    ap = argparse.ArgumentParser(
        description="SM4 %s 速率测试（NO3 0x40，默认 128KB×3 加密+解密）"
                    % mode_name)
    ap.add_argument("port", help="串口，例如 COM24")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--size", type=parse_size, default=128 * 1024,
                    help="数据大小，默认 128K；可写 64K/128K/131072")
    ap.add_argument("--runs", type=int, default=3, help="轮数，默认 3")
    ap.add_argument("--op", choices=["dec", "enc", "both"], default="both",
                    help="测解密/加密/两者（默认 both）")
    ap.add_argument("--iv", default=None,
                    help="CBC IV，16B hex，默认 00 01 ... 0F")
    ap.add_argument("--timeout", type=float, default=120.0)
    ap.add_argument("--no-genkey", action="store_true",
                    help="不重新 GENKEY(5)，使用现有临时密钥")
    ap.add_argument("--no-verify", action="store_true",
                    help="不比对 Python 参考结果")
    ap.add_argument("--out",
                    default=default_report(script_file, report_name))
    args = ap.parse_args()

    if args.runs <= 0:
        raise SystemExit("--runs 必须大于 0")
    if args.iv:
        iv = bytes.fromhex(args.iv.replace(" ", ""))
        if len(iv) != 16:
            raise SystemExit("--iv 必须是 16B")
    else:
        iv = DEFAULT_IV if mode == SM4_CBC else None

    data = make_data(args.size)
    print("[安全] 只使用临时槽 5，不发送写 OTP 命令", flush=True)
    print("模式：%s，数据：%d B，轮数：%d，op=%s"
          % (mode_name, args.size, args.runs, args.op), flush=True)
    print("测量方式：0x40 端到端（含串口传输）", flush=True)

    link = Link(args.port, args.baud)
    results = {}
    key = None
    ref_ct = None
    try:
        info = recover_key(link, regenerate=not args.no_genkey)
        key = info["key"]
        print("  GENKEY(5): %s" % ("OK" if info["genkey"] else
                                  ("SKIP" if args.no_genkey else "FAIL")),
              flush=True)
        print("  EXPORT_KEY(5,1)/解包: %s"
              % ("OK" if info["export"] else "FAIL"), flush=True)
        if not info["export"] or key is None:
            raise SystemExit("无法恢复临时槽 5 密钥，停止；未写 OTP")

        print("  密钥 K: %s" % hex_bytes(key), flush=True)
        if mode == SM4_CBC:
            print("  IV: %s" % hex_bytes(iv), flush=True)
        ref_ct = (sm4_ecb_encrypt(key, data) if mode == SM4_ECB
                  else sm4_cbc_encrypt(key, iv, data))

        if args.op in ("enc", "both"):
            print("[加密 %s]" % mode_name, flush=True)
            results["enc"] = run_op(link, mode, SM4_ENCRYPT, iv, data,
                                    ref_ct, args.runs, args.timeout,
                                    not args.no_verify)
        if args.op in ("dec", "both"):
            print("[解密 %s]" % mode_name, flush=True)
            results["dec"] = run_op(link, mode, SM4_DECRYPT, iv, ref_ct,
                                    data, args.runs, args.timeout,
                                    not args.no_verify)
    finally:
        link.close()

    ok_all = bool(results)
    for rows in results.values():
        ok_all = ok_all and len(rows) == args.runs and all(
            r["ok"] for r in rows)

    md = []
    md.append("# SM4 %s 速率测试报告\n\n" % mode_name)
    md.append("测试时间：%s\n\n" % now_str())
    md.append("安全说明：只使用 RAM 临时槽 5，不写 OTP。\n\n")
    md.append("| 项目 | 值 |\n|---|---|\n")
    md.append("| 串口 | %s，%d bps |\n" % (args.port, args.baud))
    md.append("| 模式 | %s |\n" % mode_name)
    md.append("| 数据大小 | %d B（%.1f KiB） |\n"
              % (args.size, args.size / 1024.0))
    md.append("| 轮数 | %d |\n" % args.runs)
    md.append("| op | %s |\n" % args.op)
    if mode == SM4_CBC:
        md.append("| IV | `%s` |\n" % hex_bytes(iv))
    md.append("| 恢复密钥 K | `%s` |\n"
              % (hex_bytes(key) if key else "-"))
    md.append("| 命令 | 0x40 SM4_BULK（一个逻辑大帧） |\n")
    md.append("| 测量方式 | 端到端，含串口发送/接收 |\n")
    md.append("| 理论 115200 8N1 上限 | 约 92.16 Kbps |\n")
    md.append("| 报告结论 | %s |\n\n" % (
        "全部符合预期" if ok_all else "存在失败/未执行项"))

    if "enc" in results:
        table, avg_t, avg_kbps = render_table(
            "加密(%s)" % mode_name, args.size, results["enc"],
            "加密平均速率")
        md.extend(table)
        print("\n加密平均执行时间：%.3f s" % avg_t, flush=True)
        print("加密平均速率：%.2f Kbps" % avg_kbps, flush=True)
    if "dec" in results:
        table, avg_t, avg_kbps = render_table(
            "解密(%s)" % mode_name, args.size, results["dec"],
            "解密平均速率")
        md.extend(table)
        print("\n解密平均执行时间：%.3f s" % avg_t, flush=True)
        print("解密平均速率：%.2f Kbps" % avg_kbps, flush=True)

    md.append("说明：Kbps = 数据字节数 × 8 / 时间 / 1000；"
              "时间从主机开始发大帧到收完结果，包含 UART 传输。\n")
    write_report(args.out, "".join(md))
    print("报告已写入：%s" % args.out, flush=True)
    print("结论：" + ("全部符合预期" if ok_all else "存在失败/未执行项"))
    return 0 if ok_all else 1

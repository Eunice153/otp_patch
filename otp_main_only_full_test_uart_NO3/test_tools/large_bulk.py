#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""NO3 大数据单帧测试：0x40 SM4 / 0x41 SM3。

一个逻辑大帧：5A CMD LEN0..LEN3 PAYLOAD
上位机可以把请求拆成任意 n 次串口 write，也可以分 n 次 read 收应答；
固件按 4 字节 LEN 连续收齐后只处理一次，收齐后只回一帧。

只使用 RAM 临时槽 5，不写 OTP。
"""

import argparse
import os
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
COMMON_ROOT = os.path.abspath(os.path.join(HERE, "..", "..", "test_tools"))
if COMMON_ROOT not in sys.path:
    sys.path.insert(0, COMMON_ROOT)

from common.wsl import maybe_relaunch  # noqa: E402
from common.link import Link, CMD_GENKEY, ID_TMP_SM4, hex_bytes  # noqa: E402
from common.sm3_tools import sm3_ref  # noqa: E402
from common.sm4_tools import recover_key  # noqa: E402
from common.sm4_crypto import (  # noqa: E402
    sm4_ecb_encrypt, sm4_ecb_decrypt, sm4_cbc_encrypt, sm4_cbc_decrypt,
)

SOF = 0x5A
CMD_SM4_BULK = 0x40
CMD_SM3_BULK = 0x41
MAX_DATA = 131072
DEFAULT_IV = bytes(range(16))

SM4_ECB = 0
SM4_CBC = 1
SM4_ENCRYPT = 0
SM4_DECRYPT = 1


def build_frame(cmd, payload):
    return bytes([SOF, cmd]) + len(payload).to_bytes(4, "big") + payload


def read_exact(ser, n, timeout, reads=1):
    """按 reads 次 read 收 n 字节，模拟上位机分多次接收。"""
    buf = bytearray()
    deadline = time.monotonic() + timeout
    step = max(1, (n + reads - 1) // max(1, reads)) if n else 1
    while len(buf) < n:
        if time.monotonic() >= deadline:
            raise TimeoutError("等待 %dB 超时，已收到 %d B" % (n, len(buf)))
        want = min(step, n - len(buf))
        chunk = ser.read(want)
        if chunk:
            buf += chunk
    return bytes(buf)


def read_response(ser, cmd, timeout, reads=1):
    """扫描 5A cmd，读 status + 4B LEN + DATA。"""
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        b = ser.read(1)
        if not b or b[0] != SOF:
            continue
        b2 = ser.read(1)
        if not b2 or b2[0] != cmd:
            continue
        rest = read_exact(ser, 5, max(0.1, deadline - time.monotonic()))
        status = rest[0]
        length = int.from_bytes(rest[1:5], "big")
        data = read_exact(ser, length, max(0.1, deadline - time.monotonic()),
                          reads)
        raw = bytes([SOF, cmd]) + rest + data
        return status, data, raw
    raise TimeoutError("等待 0x%02X 应答超时" % cmd)


def bulk_request(link, cmd, payload, timeout, writes=1, reads=1):
    frame = build_frame(cmd, payload)
    ser = link.ser
    old_wt = ser.write_timeout
    ser.write_timeout = max(1.0, timeout)
    try:
        ser.reset_input_buffer()
        if writes <= 1 or len(frame) <= 1:
            ser.write(frame)
        else:
            step = max(1, (len(frame) + writes - 1) // writes)
            for i in range(0, len(frame), step):
                ser.write(frame[i:i + step])
        ser.flush()
    finally:
        ser.write_timeout = old_wt
    return read_response(ser, cmd, timeout, reads)


def make_data(size):
    return bytes(((i * 37 + 0x5A) & 0xFF) for i in range(size))


def brief(data, n=16):
    if len(data) <= n * 2:
        return hex_bytes(data)
    return "%s ... %s（共 %d B）" % (
        hex_bytes(data[:n]), hex_bytes(data[-n:]), len(data))


def main():
    maybe_relaunch(__file__)

    ap = argparse.ArgumentParser(description="NO3 大数据单帧 0x40/0x41")
    ap.add_argument("port")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--algo", choices=["sm3", "sm4"], default="sm4")
    ap.add_argument("--mode", choices=["ecb", "cbc"], default="cbc")
    ap.add_argument("--op", choices=["enc", "dec", "both"], default="both")
    ap.add_argument("--size", type=int, default=4096)
    ap.add_argument("--in", dest="infile")
    ap.add_argument("--out", dest="outfile")
    ap.add_argument("--iv", default=None, help="CBC IV hex，默认 00 01 ... 0F")
    ap.add_argument("--writes", type=int, default=1,
                    help="把请求拆成 n 次串口 write")
    ap.add_argument("--reads", type=int, default=1,
                    help="把应答数据拆成 n 次 read")
    ap.add_argument("--verify", action="store_true")
    ap.add_argument("--no-genkey", action="store_true")
    ap.add_argument("--timeout", type=float, default=120.0)
    args = ap.parse_args()

    if args.infile:
        with open(args.infile, "rb") as f:
            data = f.read()
    else:
        if args.size < 0 or args.size > MAX_DATA:
            raise SystemExit("--size 必须在 0..131072")
        data = make_data(args.size)

    if len(data) > MAX_DATA:
        raise SystemExit("数据超过 131072B")

    if args.iv:
        iv = bytes.fromhex(args.iv.replace(" ", ""))
        if len(iv) != 16:
            raise SystemExit("--iv 必须是 16B")
    else:
        iv = DEFAULT_IV

    print("串口 %s @ %d，algo=%s，输入 %d B，writes=%d，reads=%d"
          % (args.port, args.baud, args.algo.upper(), len(data),
             args.writes, args.reads))

    link = Link(args.port, args.baud)
    try:
        if args.algo == "sm3":
            payload = data
            st, out, raw = bulk_request(link, CMD_SM3_BULK, payload,
                                        args.timeout, args.writes, args.reads)
            print("SM3：STATUS=0x%02X，返回 %d B" % (st & 0xFF, len(out)))
            print("  摘要：%s" % hex_bytes(out))
            if st != 0 or len(out) != 32:
                raise SystemExit("SM3 失败")
            if args.verify:
                ref = sm3_ref(data)
                print("  与参考实现：%s" % ("一致" if ref == out else "不一致"))
                if ref != out:
                    raise SystemExit(1)
            if args.outfile:
                with open(args.outfile, "wb") as f:
                    f.write(out)
            return

        if len(data) == 0 or (len(data) % 16) != 0:
            raise SystemExit("SM4 数据必须是 16 的正整数倍")

        mode = SM4_ECB if args.mode == "ecb" else SM4_CBC
        if not args.no_genkey:
            res = link.command(CMD_GENKEY, bytes([ID_TMP_SM4]))
            if res is None or res[1] != 0:
                raise SystemExit("GENKEY(5) 失败：%r" % (res,))
            print("GENKEY(5) OK")

        key = None
        if args.verify:
            info = recover_key(link, regenerate=False)
            if not info["export"]:
                raise SystemExit("导出临时槽 5 密钥失败：%r" % (info,))
            key = info["key"]
            print("已导出临时槽 5 密钥：%s" % hex_bytes(key))

        expected_plain = data if args.op in ("enc", "both") else None
        cipher = None

        if args.op in ("enc", "both"):
            payload = bytes([ID_TMP_SM4, mode, SM4_ENCRYPT]) + \
                      (iv if mode == SM4_CBC else b"") + data
            st, out, raw = bulk_request(link, CMD_SM4_BULK, payload,
                                        args.timeout, args.writes, args.reads)
            print("加密：STATUS=0x%02X，返回 %d B" % (st & 0xFF, len(out)))
            print("  返回数据：%s" % brief(out))
            if st != 0 or len(out) != len(data):
                raise SystemExit("加密失败")
            cipher = out
            if args.verify:
                if mode == SM4_ECB:
                    ref = sm4_ecb_encrypt(key, data)
                else:
                    ref = sm4_cbc_encrypt(key, iv, data)
                print("  与参考实现：%s" % ("一致" if ref == out else "不一致"))
                if ref != out:
                    raise SystemExit(1)
            if args.outfile:
                with open(args.outfile, "wb") as f:
                    f.write(cipher)
                print("  已写入 %s" % args.outfile)

        if args.op in ("dec", "both"):
            if cipher is None:
                cipher = data
            payload = bytes([ID_TMP_SM4, mode, SM4_DECRYPT]) + \
                      (iv if mode == SM4_CBC else b"") + cipher
            st, out, raw = bulk_request(link, CMD_SM4_BULK, payload,
                                        args.timeout, args.writes, args.reads)
            print("解密：STATUS=0x%02X，返回 %d B" % (st & 0xFF, len(out)))
            print("  返回数据：%s" % brief(out))
            if st != 0:
                raise SystemExit("解密失败")
            if expected_plain is not None and out != expected_plain:
                raise SystemExit("解密结果与原始数据不一致")
            if expected_plain is not None:
                print("  解密结果与原始数据：一致")
            if args.verify:
                if mode == SM4_ECB:
                    ref = sm4_ecb_decrypt(key, cipher)
                else:
                    ref = sm4_cbc_decrypt(key, iv, cipher)
                print("  与参考实现：%s" % ("一致" if ref == out else "不一致"))
                if ref != out:
                    raise SystemExit(1)
            if args.op == "dec" and args.outfile:
                with open(args.outfile, "wb") as f:
                    f.write(out)
                print("  已写入 %s" % args.outfile)

        print("完成")
    finally:
        link.close()


if __name__ == "__main__":
    main()

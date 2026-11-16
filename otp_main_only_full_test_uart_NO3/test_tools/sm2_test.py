#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
SM2 串口验证 / 20 组运算速率测试

正确性：
    5 组不同长度（16/24/32/48/64 字节；SM2 解密受 ROM 限制最大 64 B）
    每组做：加密 -> 外部解密校验 -> 设备解密校验
            签名 -> 外部验签 -> 设备验签 -> 篡改验签
    SM2 私钥通过 LOAD_PUBKEY + 0x13 导出（SM2 包裹）后在上位机恢复，
    用来对设备加密结果做独立校验。

速率：
    密钥对生成 / 加密 / 解密 / 签名 / 验证，各 20 组 × 3 次，
    记录第一次/第二次/第三次、平均执行时间和平均速率。

用法：
    python3 sm2_test.py COM24
    python3 sm2_test.py COM24 --runs 3
    python3 sm2_test.py COM24 --runs 0            # 只做正确性
    python3 sm2_test.py COM24 --skip-correctness  # 只做速率
"""

import argparse
import codecs
import atexit
import hashlib
import os
import subprocess
import sys
import time

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
            _p = subprocess.Popen([_WINPY, "-u", _script_win] + sys.argv[1:],
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

try:
    import serial
except ImportError:
    sys.exit("缺少 pyserial，请先执行：pip install pyserial")

SOF = 0x5A

CMD_GENKEY = 0x11
CMD_GETPUBKEY = 0x12
CMD_EXPORT = 0x13
CMD_LOAD_PUBKEY = 0x15
CMD_SM2_ENC = 0x23
CMD_SM2_DEC = 0x24
CMD_SM2_SIGN = 0x30
CMD_SM2_VERIFY = 0x31

ID_TMP_DEC = 3
ID_TMP_SIGN = 4

# --------------------------------------------------------------------------
# SM2 参考实现（GB/T 32918）
# --------------------------------------------------------------------------
P_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF
A_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFC
B_CURVE = 0x28E9FA9E9D9F5E344D5A9E4BCF6509A7F39789F515AB8F92DDBCBD414D940E93
N_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFF7203DF6B21C6052B53BBF40939D54123
GX = 0x32C4AE2C1F1981195F9904466A39C9948FE30BBFF2660BE1715A4589334C74C7
GY = 0xBC3736A2F4F6779C59BDCEE36B692153D0A9877CC62A474002DF32E52139F0A0

# 仅用于“导出包裹”的测试密钥；正式产品不要使用固定密钥
TEST_D = 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF


def _inv(x):
    return pow(x, P_CURVE - 2, P_CURVE)


def ec_add(P, Q):
    if P is None:
        return Q
    if Q is None:
        return P
    x1, y1 = P
    x2, y2 = Q
    if x1 == x2:
        if (y1 + y2) % P_CURVE == 0:
            return None
        lam = (3 * x1 * x1 + A_CURVE) * _inv(2 * y1 % P_CURVE) % P_CURVE
    else:
        lam = (y2 - y1) * _inv((x2 - x1) % P_CURVE) % P_CURVE
    x3 = (lam * lam - x1 - x2) % P_CURVE
    return (x3, (lam * (x1 - x3) - y1) % P_CURVE)


def ec_mul(k, P):
    R = None
    while k:
        if k & 1:
            R = ec_add(R, P)
        P = ec_add(P, P)
        k >>= 1
    return R


def sm3(data):
    return hashlib.new("sm3", data).digest()


def kdf(z, klen):
    out = b""
    ctr = 1
    while len(out) < klen:
        out += sm3(z + ctr.to_bytes(4, "big"))
        ctr += 1
    return out[:klen]


def sm2_decrypt(ct, d):
    """std=1：C1(64) || C3(32) || C2(N)"""
    C1 = (int.from_bytes(ct[:32], "big"), int.from_bytes(ct[32:64], "big"))
    C3 = ct[64:96]
    C2 = ct[96:]
    S = ec_mul(d, C1)
    x2 = S[0].to_bytes(32, "big")
    y2 = S[1].to_bytes(32, "big")
    t = kdf(x2 + y2, len(C2))
    pt = bytes(a ^ b for a, b in zip(C2, t))
    if sm3(x2 + pt + y2) != C3:
        raise ValueError("C3 校验失败")
    return pt


def sm2_verify(pub, digest, sig):
    X = int.from_bytes(pub[:32], "big")
    Y = int.from_bytes(pub[32:64], "big")
    r = int.from_bytes(sig[:32], "big")
    s = int.from_bytes(sig[32:64], "big")
    if not (1 <= r < N_CURVE and 1 <= s < N_CURVE):
        return False
    e = int.from_bytes(digest, "big")
    t = (r + s) % N_CURVE
    if t == 0:
        return False
    P = ec_add(ec_mul(s, (GX, GY)), ec_mul(t, (X, Y)))
    if P is None:
        return False
    return (e + P[0]) % N_CURVE == r


def pub_from_priv(d):
    P = ec_mul(d, (GX, GY))
    return P[0].to_bytes(32, "big") + P[1].to_bytes(32, "big")


def rand_k():
    while True:
        k = int.from_bytes(os.urandom(32), "big")
        if 1 <= k < N_CURVE:
            return k.to_bytes(32, "big")


# --------------------------------------------------------------------------
# 串口
# --------------------------------------------------------------------------
def build(cmd, data=b""):
    if len(data) > 0xFFFF:
        raise ValueError("DATA 太长")
    return bytes([SOF, cmd, (len(data) >> 8) & 0xFF, len(data) & 0xFF]) + data


class Link:
    def __init__(self, port, baud):
        self.ser = serial.Serial(port, baud, timeout=0.05, write_timeout=1.0)
        self.ser.reset_input_buffer()
        atexit.register(self.close)

    def close(self):
        try:
            if self.ser.is_open:
                self.ser.close()
        except Exception:
            pass

    def command(self, cmd, data=b"", timeout=5.0):
        self.ser.reset_input_buffer()
        self.ser.write(build(cmd, data))
        self.ser.flush()

        buf = bytearray()
        deadline = time.monotonic() + timeout
        while time.monotonic() < deadline:
            b = self.ser.read(1)
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
                return buf[1], buf[2], bytes(buf[5:5 + need])
        raise TimeoutError("命令 0x%02X 无应答" % cmd)


def check(name, cond):
    print("  %-28s %s" % (name, "通过" if cond else "失败"))
    return bool(cond)


# --------------------------------------------------------------------------
# 设备命令
# --------------------------------------------------------------------------
def genkey(link, slot):
    cmd, status, _ = link.command(CMD_GENKEY, bytes([slot]))
    if cmd != CMD_GENKEY or status != 0:
        raise RuntimeError("GENKEY(%d) 失败 cmd=%02X status=%02X" % (slot, cmd, status))


def getpub(link, slot):
    cmd, status, pub = link.command(CMD_GETPUBKEY, bytes([slot]))
    if cmd != CMD_GETPUBKEY or status != 0 or len(pub) != 64:
        raise RuntimeError("GETPUBKEY(%d) 失败 cmd=%02X status=%02X len=%d"
                           % (slot, cmd, status, len(pub)))
    return pub


def export_wrapped(link, slot):
    """用 LOAD_PUBKEY + 0x13 导出密钥（SM2 包裹），上位机解密恢复"""
    P = ec_mul(TEST_D, (GX, GY))
    Pbytes = P[0].to_bytes(32, "big") + P[1].to_bytes(32, "big")
    cmd, status, _ = link.command(CMD_LOAD_PUBKEY, Pbytes)
    if cmd != CMD_LOAD_PUBKEY or status != 0:
        raise RuntimeError("LOAD_PUBKEY 失败 cmd=%02X status=%02X" % (cmd, status))

    cmd, status, ct = link.command(CMD_EXPORT, bytes([slot, 1]))
    if cmd != CMD_EXPORT or status != 0:
        raise RuntimeError("EXPORT(%d) 失败 cmd=%02X status=%02X" % (slot, cmd, status))
    # SM2 槽导出 32B 私钥 -> 128B
    if len(ct) != 128:
        raise RuntimeError("EXPORT(%d) 期望 128B，实际 %d" % (slot, len(ct)))
    return sm2_decrypt(ct, TEST_D)


def recover_priv(link, slot):
    key = export_wrapped(link, slot)
    d = int.from_bytes(key, "big")
    pub_calc = pub_from_priv(d)
    pub_dev = getpub(link, slot)
    if pub_calc != pub_dev:
        raise RuntimeError("槽 %d 私钥恢复校验失败" % slot)
    return d


def sm2_enc_dev(link, pub, k, pt):
    payload = bytes([1]) + pub + k + pt
    cmd, status, ct = link.command(CMD_SM2_ENC, payload)
    if cmd != CMD_SM2_ENC or status != 0:
        raise RuntimeError("SM2_ENC 失败 cmd=%02X status=%02X" % (cmd, status))
    if len(ct) != 96 + len(pt):
        raise RuntimeError("SM2_ENC 期望 %d B，实际 %d" % (96 + len(pt), len(ct)))
    return ct


def sm2_dec_dev(link, slot, ct, pt_len):
    payload = bytes([slot, 1, (pt_len >> 8) & 0xFF, pt_len & 0xFF]) + ct
    cmd, status, pt = link.command(CMD_SM2_DEC, payload)
    if cmd != CMD_SM2_DEC or status != 0:
        raise RuntimeError("SM2_DEC 失败 cmd=%02X status=%02X" % (cmd, status))
    if len(pt) != pt_len:
        raise RuntimeError("SM2_DEC 期望 %d B，实际 %d" % (pt_len, len(pt)))
    return pt


def sm2_sign_dev(link, slot, digest, k):
    payload = bytes([slot]) + digest + k
    cmd, status, sig = link.command(CMD_SM2_SIGN, payload)
    if cmd != CMD_SM2_SIGN or status != 0 or len(sig) != 64:
        raise RuntimeError("SM2_SIGN 失败 cmd=%02X status=%02X len=%d"
                           % (cmd, status, len(sig)))
    return sig


def sm2_verify_dev(link, pub, digest, sig):
    cmd, status, res = link.command(CMD_SM2_VERIFY, pub + digest + sig)
    if cmd != CMD_SM2_VERIFY or status != 0 or len(res) != 1:
        raise RuntimeError("SM2_VERIFY 失败 cmd=%02X status=%02X len=%d"
                           % (cmd, status, len(res)))
    return res[0]


# --------------------------------------------------------------------------
# 正确性
# --------------------------------------------------------------------------
def test_correctness(link):
    print("\n[1] SM2 正确性（5 组：16/24/32/48/64 字节，解密上限 64 B）")

    genkey(link, ID_TMP_DEC)
    genkey(link, ID_TMP_SIGN)
    pub_dec = getpub(link, ID_TMP_DEC)
    pub_sign = getpub(link, ID_TMP_SIGN)
    print("  槽 3 公钥: " + pub_dec.hex(" ").upper())
    print("  槽 4 公钥: " + pub_sign.hex(" ").upper())

    d_dec = recover_priv(link, ID_TMP_DEC)
    d_sign = recover_priv(link, ID_TMP_SIGN)
    print("  临时槽 3/4 私钥导出并校验通过")

    ok = True
    # 回归：pt_len=65 的短帧必须返回 FE，不能无应答
    # （新固件由 h_sm2_dec 的 pt_len>64 检查直接拒绝）
    cmd, status, _ = link.command(CMD_SM2_DEC, bytes([ID_TMP_DEC, 1, 0, 65]))
    ok &= check("SM2 pt_len=65 拒绝", cmd == CMD_SM2_DEC and status == 0xFE)

    # 注意：ROM 的 boot_sm2_decrypt 栈帧 352B，明文缓冲区在 sp+288，
    # 最多只能放 64B；超过 64B 会写穿栈帧导致卡死。
    # 所以解密验证的长度必须 <= 64。
    for L in (16, 24, 32, 48, 64):
        pt = bytes((i * 7 + 3) & 0xFF for i in range(L))
        digest = sm3(pt)

        # 加密 -> 外部解密校验 -> 设备解密校验
        ct = sm2_enc_dev(link, pub_dec, rand_k(), pt)
        try:
            ext_pt = sm2_decrypt(ct, d_dec)
            ok &= check("SM2 加密外部校验 %3d B" % L, ext_pt == pt)
        except Exception as e:
            print("  %-28s 失败（%s）" % ("SM2 加密外部校验 %3d B" % L, e))
            ok = False

        dev_pt = sm2_dec_dev(link, ID_TMP_DEC, ct, L)
        ok &= check("SM2 解密 %3d B" % L, dev_pt == pt)

        # 签名 -> 外部验签 -> 设备验签 -> 篡改验签
        sig = sm2_sign_dev(link, ID_TMP_SIGN, digest, rand_k())
        ok &= check("SM2 签名外部验签 %3d B" % L, sm2_verify(pub_sign, digest, sig))
        ok &= check("SM2 设备验签 %3d B" % L,
                    sm2_verify_dev(link, pub_sign, digest, sig) == 1)

        bad_sig = bytearray(sig)
        bad_sig[0] ^= 0xFF
        ok &= check("SM2 篡改验签 %3d B" % L,
                    sm2_verify_dev(link, pub_sign, digest, bytes(bad_sig)) == 0)

    return ok


# --------------------------------------------------------------------------
# 速率
# --------------------------------------------------------------------------
def _run_batch(fn, groups):
    t0 = time.perf_counter()
    for _ in range(groups):
        fn()
    return time.perf_counter() - t0


def _print_rate(name, times, unit, bits_per_group=None, groups=20):
    avg_time = sum(times) / len(times)
    print("\n    %s：" % name)
    for i, t in enumerate(times):
        print("      第 %d 次: %.3f s" % (i + 1, t))
    print("      平均执行时间: %.3f s" % avg_time)
    if bits_per_group is not None:
        rate = groups * bits_per_group / avg_time / 1000.0
        print("      平均速率: %.1f Kbps" % rate)
    else:
        print("      平均速率: %.1f %s" % (groups / avg_time, unit))


def test_rate(link, runs, groups=20):
    print("\n[2] SM2 速率（%d 组 × %d 次）" % (groups, runs))
    if runs <= 0:
        print("    （--runs 0，跳过速率测试）")
        return True

    # 准备密钥和一条固定数据
    genkey(link, ID_TMP_DEC)
    genkey(link, ID_TMP_SIGN)
    pub_dec = getpub(link, ID_TMP_DEC)
    pub_sign = getpub(link, ID_TMP_SIGN)

    L = 16
    pt = bytes((i * 7 + 3) & 0xFF for i in range(L))
    digest = sm3(pt)
    ct = sm2_enc_dev(link, pub_dec, rand_k(), pt)
    sig = sm2_sign_dev(link, ID_TMP_SIGN, digest, rand_k())

    # 加密
    times = []
    for _ in range(runs):
        times.append(_run_batch(
            lambda: sm2_enc_dev(link, pub_dec, rand_k(), pt), groups))
    _print_rate("加密", times, "Kbps", bits_per_group=L * 8, groups=groups)

    # 解密
    times = []
    for _ in range(runs):
        times.append(_run_batch(
            lambda: sm2_dec_dev(link, ID_TMP_DEC, ct, L), groups))
    _print_rate("解密", times, "Kbps", bits_per_group=L * 8, groups=groups)

    # 签名
    times = []
    for _ in range(runs):
        times.append(_run_batch(
            lambda: sm2_sign_dev(link, ID_TMP_SIGN, digest, rand_k()), groups))
    _print_rate("签名", times, "次/秒", groups=groups)

    # 验证
    times = []
    for _ in range(runs):
        times.append(_run_batch(
            lambda: sm2_verify_dev(link, pub_sign, digest, sig), groups))
    _print_rate("验证", times, "次/秒", groups=groups)

    # 密钥对生成（放最后，避免覆盖前面用的槽 3）
    times = []
    for _ in range(runs):
        t0 = time.perf_counter()
        for _ in range(groups):
            genkey(link, ID_TMP_DEC)
            getpub(link, ID_TMP_DEC)
        times.append(time.perf_counter() - t0)
    _print_rate("密钥对生成", times, "对/秒", groups=groups)

    return True


def main():
    ap = argparse.ArgumentParser(description="SM2 串口验证 / 20 组运算速率测试")
    ap.add_argument("port", help="串口，例如 COM24 或 /dev/ttyUSB0")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--runs", type=int, default=None,
                    help="速率测试每种操作跑几次（0=跳过；不指定则询问）")
    ap.add_argument("--skip-correctness", action="store_true")
    ap.add_argument("--groups", type=int, default=20,
                    help="每种速率测试的组数（默认 20）")
    args = ap.parse_args()

    if args.runs is None:
        try:
            sys.stdout.write("速率测试每种操作跑几次？(0=跳过，回车默认 3): ")
            sys.stdout.flush()
            s = input().strip()
            args.runs = int(s) if s else 3
        except (EOFError, ValueError):
            args.runs = 3
        print("本次速率测试每种操作次数: %d" % args.runs)

    link = Link(args.port, args.baud)
    try:
        ok = True
        if not args.skip_correctness:
            ok &= test_correctness(link)
        ok &= test_rate(link, args.runs, args.groups)
        print("\n结论: " + ("全部通过" if ok else "存在失败项"))
        return 0 if ok else 1
    finally:
        link.close()


if __name__ == "__main__":
    sys.exit(main())

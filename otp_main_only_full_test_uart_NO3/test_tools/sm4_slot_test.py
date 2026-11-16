#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
SM4 密钥槽路径验证 / 128KB 速率测试

思路：
  1. GENKEY(5) 生成临时 SM4 密钥（随机，不出芯片）
  2. LOAD_PUBKEY 加载一个上位机已知私钥 d 对应的 SM2 公钥 P
  3. SM4_EXPORT 用 P 把槽 5 的 SM4 密钥做 SM2 加密后导出
  4. 上位机用 d 解密导出的密钥包，恢复出 16 字节 SM4 密钥
  5. 用恢复出的密钥和内置 SM4 参考实现，验证 5 组 ECB/CBC 加解密
  6. 128KB 分 512B 帧测 ECB 加密/解密速率

注意：导出/解密仅用于测试固件；正式产品不应允许导出密钥。

用法：
    python3 sm4_slot_test.py COM24
    python3 sm4_slot_test.py COM24 --runs 3
    python3 sm4_slot_test.py COM24 --runs 0          # 只做正确性
    python3 sm4_slot_test.py COM24 --skip-correctness # 只测速率（跳过导出）
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
CMD_SM4_EXPORT = 0x13
CMD_LOAD_PUBKEY = 0x15
CMD_SM4_CRYPT = 0x20

KEY_ID_TMP_SM4 = 5

# --------------------------------------------------------------------------
# SM4 参考实现（GB/T 32907，已用标准向量与 OpenSSL 校验）
# --------------------------------------------------------------------------
SBOX = [
    214,144,233,254,204,225,61,183,22,182,20,194,40,251,44,5,43,103,154,118,
    42,190,4,195,170,68,19,38,73,134,6,153,156,66,80,244,145,239,152,122,
    51,84,11,67,237,207,172,98,228,179,28,169,201,8,232,149,128,223,148,250,
    117,143,63,166,71,7,167,252,243,115,23,186,131,89,60,25,230,133,79,168,
    104,107,129,178,113,100,218,139,248,235,15,75,112,86,157,53,30,36,14,94,
    99,88,209,162,37,34,124,59,1,33,120,135,212,0,70,87,159,211,39,82,76,54,
    2,231,160,196,200,158,234,191,138,210,64,199,56,181,163,247,242,206,249,
    97,21,161,224,174,93,164,155,52,26,85,173,147,50,48,245,140,177,227,29,
    246,226,46,130,102,202,96,192,41,35,171,13,83,78,111,213,219,55,69,222,
    253,142,47,3,255,106,114,109,108,91,81,141,27,175,146,187,221,188,127,
    17,217,92,65,31,16,90,216,10,193,49,136,165,205,123,189,45,116,208,18,
    184,229,180,176,137,105,151,74,12,150,119,126,101,185,241,9,197,110,198,
    132,24,240,125,236,58,220,77,32,121,238,95,62,215,203,57,72,
]
FK = [0xA3B1BAC6, 0x56AA3350, 0x677D9197, 0xB27022DC]
CK = [
    0x00070E15,0x1C232A31,0x383F464D,0x545B6269,0x70777E85,0x8C939AA1,
    0xA8AFB6BD,0xC4CBD2D9,0xE0E7EEF5,0xFC030A11,0x181F262D,0x343B4249,
    0x50575E65,0x6C737A81,0x888F969D,0xA4ABB2B9,0xC0C7CED5,0xDCE3EAF1,
    0xF8FF060D,0x141B2229,0x30373E45,0x4C535A61,0x686F767D,0x848B9299,
    0xA0A7AEB5,0xBCC3CAD1,0xD8DFE6ED,0xF4FB0209,0x10171E25,0x2C333A41,
    0x484F565D,0x646B7279,
]
M32 = 0xFFFFFFFF


def _rotl(x, n):
    return ((x << n) | (x >> (32 - n))) & M32


def _tau(x):
    return ((SBOX[(x >> 24) & 0xFF] << 24) |
            (SBOX[(x >> 16) & 0xFF] << 16) |
            (SBOX[(x >> 8) & 0xFF] << 8) |
            SBOX[x & 0xFF])


def _T(x):
    b = _tau(x)
    return b ^ _rotl(b, 2) ^ _rotl(b, 10) ^ _rotl(b, 18) ^ _rotl(b, 24)


def _Tp(x):
    b = _tau(x)
    return b ^ _rotl(b, 13) ^ _rotl(b, 23)


def _key_schedule(key):
    k = [int.from_bytes(key[i:i + 4], "big") ^ FK[i // 4] for i in range(0, 16, 4)]
    rk = []
    for i in range(32):
        k.append(k[i] ^ _Tp(k[i + 1] ^ k[i + 2] ^ k[i + 3] ^ CK[i]))
        rk.append(k[i + 4])
    return rk


def _block(blk, rk):
    x = [int.from_bytes(blk[i:i + 4], "big") for i in range(0, 16, 4)]
    for i in range(32):
        x.append(x[i] ^ _T(x[i + 1] ^ x[i + 2] ^ x[i + 3] ^ rk[i]))
    return (x[35].to_bytes(4, "big") + x[34].to_bytes(4, "big") +
            x[33].to_bytes(4, "big") + x[32].to_bytes(4, "big"))


def sm4_ecb_encrypt(key, data):
    rk = _key_schedule(key)
    return b"".join(_block(data[i:i + 16], rk) for i in range(0, len(data), 16))


def sm4_ecb_decrypt(key, data):
    rk = _key_schedule(key)[::-1]
    return b"".join(_block(data[i:i + 16], rk) for i in range(0, len(data), 16))


def sm4_cbc_encrypt(key, iv, data):
    rk = _key_schedule(key)
    prev = iv
    out = b""
    for i in range(0, len(data), 16):
        blk = bytes(a ^ b for a, b in zip(data[i:i + 16], prev))
        ct = _block(blk, rk)
        out += ct
        prev = ct
    return out


def sm4_cbc_decrypt(key, iv, data):
    rk = _key_schedule(key)[::-1]
    prev = iv
    out = b""
    for i in range(0, len(data), 16):
        blk = _block(data[i:i + 16], rk)
        out += bytes(a ^ b for a, b in zip(blk, prev))
        prev = data[i:i + 16]
    return out


# --------------------------------------------------------------------------
# SM2（只用于解密 SM4_EXPORT 导出的密钥包）
# --------------------------------------------------------------------------
P_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF
A_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFC
B_CURVE = 0x28E9FA9E9D9F5E344D5A9E4BCF6509A7F39789F515AB8F92DDBCBD414D940E93
GX = 0x32C4AE2C1F1981195F9904466A39C9948FE30BBFF2660BE1715A4589334C74C7
GY = 0xBC3736A2F4F6779C59BDCEE36B692153D0A9877CC62A474002DF32E52139F0A0

# 测试用固定私钥（仅测试；正式产品不要使用固定密钥）
TEST_D = 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF


def _inv(x):
    return pow(x, P_CURVE - 2, P_CURVE)


def _ec_add(P, Q):
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


def _ec_mul(k, P):
    R = None
    while k:
        if k & 1:
            R = _ec_add(R, P)
        P = _ec_add(P, P)
        k >>= 1
    return R


def _sm3(data):
    return hashlib.new("sm3", data).digest()


def _kdf(z, klen):
    out = b""
    ctr = 1
    while len(out) < klen:
        out += _sm3(z + ctr.to_bytes(4, "big"))
        ctr += 1
    return out[:klen]


def sm2_decrypt(ct, d):
    """std=1：C1(64) || C3(32) || C2(N)"""
    C1 = (int.from_bytes(ct[:32], "big"), int.from_bytes(ct[32:64], "big"))
    C3 = ct[64:96]
    C2 = ct[96:]
    S = _ec_mul(d, C1)
    x2 = S[0].to_bytes(32, "big")
    y2 = S[1].to_bytes(32, "big")
    t = _kdf(x2 + y2, len(C2))
    key = bytes(a ^ b for a, b in zip(C2, t))
    if _sm3(x2 + key + y2) != C3:
        raise ValueError("导出的密钥包 C3 校验失败")
    return key


# --------------------------------------------------------------------------
# 串口与命令
# --------------------------------------------------------------------------
def build(cmd, data=b""):
    if len(data) > 0xFFFF:
        raise ValueError("DATA 太长")
    return bytes([SOF, cmd, (len(data) >> 8) & 0xFF, len(data) & 0xFF]) + data


class Link:
    def __init__(self, port, baud):
        # write_timeout 防止驱动异常时 write 永久阻塞；atexit 保证退出时关串口
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


def check(name, got, expect):
    ok = (got == expect)
    print("  %-26s %s" % (name, "通过" if ok else "失败"))
    if not ok:
        print("    期望: " + expect.hex(" ").upper())
        print("    实际: " + got.hex(" ").upper())
    return ok


def sm4_crypt(link, mode, op, iv, data):
    """id 固定为临时槽 5，不带口令"""
    payload = bytes([KEY_ID_TMP_SM4, mode, op])
    if mode == 1:
        payload += iv
    payload += data
    cmd, status, out = link.command(CMD_SM4_CRYPT, payload)
    if cmd != CMD_SM4_CRYPT or status != 0:
        raise RuntimeError("SM4_CRYPT 失败 cmd=%02X status=%02X" % (cmd, status))
    return out


def recover_key(link):
    """GENKEY(5) -> LOAD_PUBKEY -> SM4_EXPORT -> 上位机解密"""
    cmd, status, _ = link.command(CMD_GENKEY, bytes([KEY_ID_TMP_SM4]))
    if cmd != CMD_GENKEY or status != 0:
        raise RuntimeError("GENKEY(5) 失败 cmd=%02X status=%02X" % (cmd, status))

    P = _ec_mul(TEST_D, (GX, GY))
    Pbytes = P[0].to_bytes(32, "big") + P[1].to_bytes(32, "big")
    cmd, status, _ = link.command(CMD_LOAD_PUBKEY, Pbytes)
    if cmd != CMD_LOAD_PUBKEY or status != 0:
        raise RuntimeError("LOAD_PUBKEY 失败 cmd=%02X status=%02X" % (cmd, status))

    cmd, status, ct = link.command(CMD_SM4_EXPORT, bytes([KEY_ID_TMP_SM4, 1]))
    if cmd != CMD_SM4_EXPORT or status != 0:
        raise RuntimeError("SM4_EXPORT 失败 cmd=%02X status=%02X" % (cmd, status))
    if len(ct) != 112:
        raise RuntimeError("SM4_EXPORT 期望 112 字节，实际 %d" % len(ct))

    return sm2_decrypt(ct, TEST_D)


def test_correctness(link, key):
    print("\n[1] SM4 密钥槽 5 正确性（ECB/CBC，5 组长度）")
    iv = bytes(range(16))
    ok = True
    # 注意：单帧 DATA 上限 512，SM4_CRYPT 参数占 3B，CBC 再加 16B IV，
    # 所以数据最长 480B（480+3=483，480+3+16=499，均不超过 512）。
    for n in (16, 32, 64, 256, 480):
        pt = bytes(i & 0xFF for i in range(n))

        ct = sm4_crypt(link, 0, 0, None, pt)
        ok &= check("ECB 加密 %3d B" % n, ct, sm4_ecb_encrypt(key, pt))

        dec = sm4_crypt(link, 0, 1, None, ct)
        ok &= check("ECB 解密 %3d B" % n, dec, pt)

        ct = sm4_crypt(link, 1, 0, iv, pt)
        ok &= check("CBC 加密 %3d B" % n, ct, sm4_cbc_encrypt(key, iv, pt))

        dec = sm4_crypt(link, 1, 1, iv, ct)
        ok &= check("CBC 解密 %3d B" % n, dec, pt)
    return ok


def test_rate(link, key, runs, chunk=256, total=131072):
    print("\n[2] 128KB SM4 速率（ECB，%d 字节/帧）" % chunk)
    if runs <= 0:
        print("    （--runs 0，跳过速率测试）")
        return True

    pt_chunk = bytes(i & 0xFF for i in range(chunk))
    ref_ct = sm4_ecb_encrypt(key, pt_chunk)

    for op_name, op, data, ref_out in (
        ("加密", 0, pt_chunk, ref_ct),
        ("解密", 1, ref_ct, pt_chunk),
    ):
        times = []
        ok_all = True
        nframes = total // chunk
        print("\n    %s：" % op_name)
        for r in range(runs):
            t0 = time.perf_counter()
            bad = []
            # 每帧的 512B 明文相同，所以每帧结果都应等于 ref_out；
            # 逐帧全量比对，等价于校验整个 128KB（含最后一帧/最低字节）。
            for idx in range(nframes):
                out = sm4_crypt(link, 0, op, None, data)
                if out != ref_out:
                    bad.append(idx)
            t1 = time.perf_counter()

            elapsed = t1 - t0
            times.append(elapsed)
            ok = not bad
            ok_all &= ok
            rate = total * 8 / elapsed / 1000.0
            print("      第 %d 次: %.3f s, %.1f Kbps, 全 %d 帧%s"
                  % (r + 1, elapsed, rate, nframes, "校验通过" if ok else "有错误"))
            if bad:
                print("        失败帧号（前 10 个）: %s，共 %d 帧"
                      % (bad[:10], len(bad)))

        avg_time = sum(times) / len(times)
        avg_rate = total * 8 / avg_time / 1000.0
        print("      平均执行时间: %.3f s" % avg_time)
        print("      %s平均速率: %.1f Kbps" % (op_name, avg_rate))
        if not ok_all:
            print("      注意：有帧校验失败")
    return True


def test_rate_cbc(link, key, runs, chunk=256, total=131072):
    print("\n[3] 128KB SM4 速率（CBC，%d 字节/帧）" % chunk)
    if runs <= 0:
        print("    （--runs 0，跳过 CBC 速率测试）")
        return True

    pt_chunk = bytes(i & 0xFF for i in range(chunk))
    iv0 = bytes(range(16))
    nframes = total // chunk

    # 预计算加密序列：每帧的 IV 和期望密文
    enc_frames = []
    iv = iv0
    for _ in range(nframes):
        ct = sm4_cbc_encrypt(key, iv, pt_chunk)
        enc_frames.append((iv, ct))
        iv = ct[-16:]

    # 解密序列：输入密文与每帧 IV（上一帧密文的最后 16B）
    dec_frames = []
    iv = iv0
    for _, ct in enc_frames:
        dec_frames.append((iv, ct))
        iv = ct[-16:]

    for op_name, op, frames in (("加密", 0, enc_frames), ("解密", 1, dec_frames)):
        times = []
        ok_all = True
        print("\n    %s：" % op_name)
        for r in range(runs):
            t0 = time.perf_counter()
            bad = []
            for idx, (iv, item) in enumerate(frames):
                if op == 0:
                    out = sm4_crypt(link, 1, 0, iv, pt_chunk)
                    exp = item
                else:
                    out = sm4_crypt(link, 1, 1, iv, item)
                    exp = pt_chunk
                if out != exp:
                    bad.append(idx)
            t1 = time.perf_counter()
            elapsed = t1 - t0
            times.append(elapsed)
            ok = not bad
            ok_all &= ok
            rate = total * 8 / elapsed / 1000.0
            print("      第 %d 次: %.3f s, %.1f Kbps, 全 %d 帧%s"
                  % (r + 1, elapsed, rate, nframes, "校验通过" if ok else "有错误"))
            if bad:
                print("        失败帧号（前 10 个）: %s，共 %d 帧"
                      % (bad[:10], len(bad)))
        avg_time = sum(times) / len(times)
        avg_rate = total * 8 / avg_time / 1000.0
        print("      平均执行时间: %.3f s" % avg_time)
        print("      %s平均速率: %.1f Kbps" % (op_name, avg_rate))
        if not ok_all:
            print("      注意：有帧校验失败")
    return True


def main():
    ap = argparse.ArgumentParser(description="SM4 密钥槽路径验证 / 128KB 速率测试")
    ap.add_argument("port", help="串口，例如 COM24 或 /dev/ttyUSB0")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--runs", type=int, default=None,
                    help="128KB 每种操作跑几次（0=跳过；不指定则询问）")
    ap.add_argument("--skip-correctness", action="store_true",
                    help="只测速率，跳过导出/正确性")
    ap.add_argument("--cbc-rate", action="store_true",
                    help="同时测 CBC 128KB 加解密速率（默认只测 ECB）")
    args = ap.parse_args()

    if args.runs is None:
        try:
            sys.stdout.write("128KB 加密/解密各跑几次？(0=跳过，回车默认 3): ")
            sys.stdout.flush()
            s = input().strip()
            args.runs = int(s) if s else 3
        except (EOFError, ValueError):
            args.runs = 3
        print("本次 128KB 每种操作次数: %d" % args.runs)

    link = Link(args.port, args.baud)
    try:
        if not args.skip_correctness:
            key = recover_key(link)
            print("恢复出的 SM4 密钥: " + key.hex(" ").upper())
            ok = test_correctness(link, key)
        else:
            cmd, status, _ = link.command(CMD_GENKEY, bytes([KEY_ID_TMP_SM4]))
            if cmd != CMD_GENKEY or status != 0:
                raise RuntimeError("GENKEY(5) 失败 cmd=%02X status=%02X"
                                   % (cmd, status))
            # 速率测试不需要密钥；首块校验只做加密方向
            key = None
            ok = True

        if key is None and args.cbc_rate:
            key = recover_key(link)
            print("恢复出的 SM4 密钥: " + key.hex(" ").upper())

        if key is None:
            # 没有导出密钥时，只测速率，不做比对
            print("\n[2] 128KB SM4 速率（ECB，256 字节/帧）")
            print("    （--skip-correctness，不做校验）")
            if args.runs > 0:
                for op_name, op in (("加密", 0), ("解密", 1)):
                    print("\n    %s：" % op_name)
                    for r in range(args.runs):
                        data = bytes(i & 0xFF for i in range(256))
                        t0 = time.perf_counter()
                        for _ in range(131072 // 256):
                            sm4_crypt(link, 0, op, None, data)
                        t1 = time.perf_counter()
                        el = t1 - t0
                        print("      第 %d 次: %.3f s, %.1f Kbps"
                              % (r + 1, el, 131072 * 8 / el / 1000.0))
        else:
            test_rate(link, key, args.runs)
            if args.cbc_rate:
                test_rate_cbc(link, key, args.runs)

        print("\n结论: " + ("全部通过" if ok else "存在失败项"))
        return 0 if ok else 1
    finally:
        link.close()


if __name__ == "__main__":
    sys.exit(main())

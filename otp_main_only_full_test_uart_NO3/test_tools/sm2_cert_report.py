#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
SM2 正确性验证报告生成器（串口命令接口）

生成认证报告 "2. 正确性验证 / 2.1 串口命令接口 / 2.1.1 SM2 算法" 所需的数据：

  (1) 密钥对生成：槽 3、槽 4 各 5 组
      GENKEY -> GETPUBKEY -> LOAD_PUBKEY(TEST_D) + EXPORT
      上位机解出私钥 d，计算 P=dG，与设备公钥比对
  (2) 加密：5 组固定明文 + 固定 k，设备加密，上位机独立解密校验
  (3) 解密：5 组设备密文 -> 设备解密；再用上位机参考实现加密 -> 设备解密
  (4) 签名：5 组 SM3 摘要 + 固定 k，设备签名，上位机独立验签
  (5) 验证：设备验签正常签名(01)、篡改签名(00)、上位机签名(01)

输出：默认写到脚本同目录的 sm2_cert_report.md

用法：
    python3 sm2_cert_report.py COM24
    python3 sm2_cert_report.py COM24 --out /tmp/sm2_report.md
"""

import argparse
import atexit
import hashlib
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
                for _line in _p.stdout:
                    sys.stdout.write(_line.decode("gbk", errors="replace"))
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


# --------------------------------------------------------------------------
# 命令字 / 槽位
# --------------------------------------------------------------------------
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

# 5 组明文长度；SM2 解密受 ROM boot_sm2_decrypt 限制，最大 64 B
LENS = (16, 24, 32, 48, 64)

# 仅用于“导出包裹”的测试密钥；正式产品不要使用固定密钥
TEST_D = 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF


# --------------------------------------------------------------------------
# SM2 参考实现（GB/T 32918，独立于设备 C 代码）
# --------------------------------------------------------------------------
P_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF
A_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFC
B_CURVE = 0x28E9FA9E9D9F5E344D5A9E4BCF6509A7F39789F515AB8F92DDBCBD414D940E93
N_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFF7203DF6B21C6052B53BBF40939D54123
GX = 0x32C4AE2C1F1981195F9904466A39C9948FE30BBFF2660BE1715A4589334C74C7
GY = 0xBC3736A2F4F6779C59BDCEE36B692153D0A9877CC62A474002DF32E52139F0A0
G = (GX, GY)


def _inv_p(x):
    return pow(x % P_CURVE, P_CURVE - 2, P_CURVE)


def _inv_n(x):
    return pow(x % N_CURVE, N_CURVE - 2, N_CURVE)


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
        lam = (3 * x1 * x1 + A_CURVE) * _inv_p(2 * y1) % P_CURVE
    else:
        lam = (y2 - y1) * _inv_p(x2 - x1) % P_CURVE
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


def fixed_k(label):
    """从标签推导固定且合法的 k，便于报告复算。"""
    h = sm3(label.encode("utf-8"))
    k = int.from_bytes(h, "big") % (N_CURVE - 1) + 1
    return k.to_bytes(32, "big")


def pub_from_priv(d):
    P = ec_mul(int(d), G)
    return P[0].to_bytes(32, "big") + P[1].to_bytes(32, "big")


def sm2_encrypt(pub, pt, k):
    """std=1：C1(64) || C3(32) || C2(N)"""
    k = int.from_bytes(k, "big") if isinstance(k, (bytes, bytearray)) else int(k)
    P = (int.from_bytes(pub[:32], "big"), int.from_bytes(pub[32:64], "big"))
    C1 = ec_mul(k, G)
    S = ec_mul(k, P)
    x2 = S[0].to_bytes(32, "big")
    y2 = S[1].to_bytes(32, "big")
    t = kdf(x2 + y2, len(pt))
    C2 = bytes(a ^ b for a, b in zip(pt, t))
    C3 = sm3(x2 + pt + y2)
    return C1[0].to_bytes(32, "big") + C1[1].to_bytes(32, "big") + C3 + C2


def sm2_decrypt(ct, d):
    """std=1：C1(64) || C3(32) || C2(N)"""
    C1 = (int.from_bytes(ct[:32], "big"), int.from_bytes(ct[32:64], "big"))
    C3 = ct[64:96]
    C2 = ct[96:]
    S = ec_mul(int(d), C1)
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
    P = ec_add(ec_mul(s, G), ec_mul(t, (X, Y)))
    if P is None:
        return False
    return (e + P[0]) % N_CURVE == r


def sm2_sign_host(d, digest, k):
    """上位机参考签名，用于交叉验证设备验签。"""
    d = int(d)
    k = int.from_bytes(k, "big") if isinstance(k, (bytes, bytearray)) else int(k)
    e = int.from_bytes(digest, "big")
    P = ec_mul(k, G)
    r = (e + P[0]) % N_CURVE
    if r == 0 or (r + k) % N_CURVE == 0:
        raise ValueError("SM2 签名 r 非法")
    s = (_inv_n(1 + d) * (k - r * d)) % N_CURVE
    if s == 0:
        raise ValueError("SM2 签名 s 非法")
    return r.to_bytes(32, "big") + s.to_bytes(32, "big")


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

    def command(self, cmd, data=b"", timeout=10.0):
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


# --------------------------------------------------------------------------
# 设备命令
# --------------------------------------------------------------------------
def genkey(link, slot):
    cmd, status, _ = link.command(CMD_GENKEY, bytes([slot]))
    if cmd != CMD_GENKEY or status != 0:
        raise RuntimeError("GENKEY(%d) 失败 cmd=%02X status=%02X"
                           % (slot, cmd, status))


def getpub(link, slot):
    cmd, status, pub = link.command(CMD_GETPUBKEY, bytes([slot]))
    if cmd != CMD_GETPUBKEY or status != 0 or len(pub) != 64:
        raise RuntimeError("GETPUBKEY(%d) 失败 cmd=%02X status=%02X len=%d"
                           % (slot, cmd, status, len(pub)))
    return pub


def export_wrapped(link, slot):
    """用 LOAD_PUBKEY + 0x13 导出密钥（SM2 包裹），上位机解密恢复"""
    P = ec_mul(TEST_D, G)
    Pbytes = P[0].to_bytes(32, "big") + P[1].to_bytes(32, "big")
    cmd, status, _ = link.command(CMD_LOAD_PUBKEY, Pbytes)
    if cmd != CMD_LOAD_PUBKEY or status != 0:
        raise RuntimeError("LOAD_PUBKEY 失败 cmd=%02X status=%02X" % (cmd, status))

    cmd, status, ct = link.command(CMD_EXPORT, bytes([slot, 1]))
    if cmd != CMD_EXPORT or status != 0:
        raise RuntimeError("EXPORT(%d) 失败 cmd=%02X status=%02X"
                           % (slot, cmd, status))
    if len(ct) != 128:
        raise RuntimeError("EXPORT(%d) 期望 128B，实际 %d" % (slot, len(ct)))
    return sm2_decrypt(ct, TEST_D)


def recover_pair(link, slot):
    """返回 (私钥 int, 设备公钥 64B, 私钥推导公钥 64B)"""
    pub = getpub(link, slot)
    d = int.from_bytes(export_wrapped(link, slot), "big")
    return d, pub, pub_from_priv(d)


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
# 报告辅助
# --------------------------------------------------------------------------
def hx(data):
    return " ".join("%02X" % b for b in data)


def verdict(ok):
    return "通过" if ok else "失败"


def make_pt(L):
    return bytes((i * 7 + 3) & 0xFF for i in range(L))


def build_report(args, key3_rows, key4_rows, pub3, enc_rows,
                 dec_rows, sign_rows, ver_rows, failures):
    md = []
    md.append("# 2. 正确性验证\n\n")
    md.append("## 2.1 串口命令接口\n\n")
    md.append("### 2.1.1 SM2 算法\n\n")
    md.append("**测试条件**\n\n")
    md.append("- 测试时间：%s\n" % time.strftime("%Y-%m-%d %H:%M:%S"))
    md.append("- 串口：%s，%d bps，8N1\n" % (args.port, args.baud))
    md.append("- 密钥位置：临时槽 3（解密）、临时槽 4（签名），均位于 RAM，不写入 OTP\n")
    md.append("- 明文生成规则：`pt[i] = (i*7 + 3) & 0xFF`\n")
    md.append("- 参考实现：独立的 Python GB/T 32918 实现；SM3 使用 hashlib（OpenSSL）\n")
    md.append("- SM2 解密明文长度上限：64 B（ROM boot_sm2_decrypt 栈帧限制）\n\n")

    md.append("#### (1) 密钥对生成\n\n")
    md.append("命令：`GENKEY(id)` → `GETPUBKEY(id)`；再 `LOAD_PUBKEY(TEST_D 公钥)` + "
              "`EXPORT(id, 1)` 导出私钥包裹，上位机用 TEST_D 解出私钥 d 后计算 "
              "`P = dG`，与设备公钥比较。\n\n")

    for title, rows in (("槽 3（解密密钥对）", key3_rows),
                        ("槽 4（签名密钥对）", key4_rows)):
        md.append("**%s**\n\n" % title)
        md.append("| 组 | 设备公钥（64 B） | 导出私钥推导公钥（64 B） | 是否一致 | 结论 |\n")
        md.append("|---|---|---|---|---|\n")
        for i, pub, derived, ok in rows:
            md.append("| %d | `%s` | `%s` | %s | %s |\n"
                      % (i, hx(pub), hx(derived), "是" if ok else "否", verdict(ok)))
        md.append("\n")

    md.append("#### (2) 加密\n\n")
    md.append("加密使用槽 3 第 5 组密钥对，公钥：`%s`。\n\n" % hx(pub3))
    md.append("| 组 | 明文长度 | 明文 | k（32 B） | 设备密文（96+L B） | 上位机解密校验 | 结论 |\n")
    md.append("|---|---|---|---|---|---|---|\n")
    for i, L, pt, k, ct, ok in enc_rows:
        md.append("| %d | %d B | `%s` | `%s` | `%s` | %s | %s |\n"
                  % (i, L, hx(pt), hx(k), hx(ct),
                     "与明文一致" if ok else "与明文不一致", verdict(ok)))
    md.append("\n")

    md.append("#### (3) 解密\n\n")
    md.append("每组两种密文：设备加密产生的密文；上位机参考实现用同一槽 3 公钥、"
              "另一固定 k 加密产生的密文。\n\n")
    md.append("| 组 | 密文来源 | 输入密文 | 设备输出明文 | 与原文比较 | 结论 |\n")
    md.append("|---|---|---|---|---|---|\n")
    for i, source, ct, out, expected, ok in dec_rows:
        md.append("| %d | %s | `%s` | `%s` | %s | %s |\n"
                  % (i, source, hx(ct), hx(out),
                     "一致" if ok else "不一致", verdict(ok)))
    md.append("\n")

    md.append("#### (4) 签名\n\n")
    md.append("签名使用槽 4 第 5 组密钥对；摘要为对应明文的 SM3。\n\n")
    md.append("| 组 | 明文长度 | 摘要（32 B） | k（32 B） | 设备签名（64 B） | 上位机验签 | 结论 |\n")
    md.append("|---|---|---|---|---|---|---|\n")
    for i, L, digest, k, sig, ok in sign_rows:
        md.append("| %d | %d B | `%s` | `%s` | `%s` | %s | %s |\n"
                  % (i, L, hx(digest), hx(k), hx(sig),
                     "通过" if ok else "失败", verdict(ok)))
    md.append("\n")

    md.append("#### (5) 验证（验签）\n\n")
    md.append("每组对三份签名做设备验签：设备生成的签名、篡改 1 字节后的签名、"
              "上位机用槽 4 私钥生成的签名。预期结果分别为 `01`、`00`、`01`。\n\n")
    md.append("| 组 | 设备签名 → 设备验签 | 篡改 1 字节 → 设备验签 | 上位机签名 → 设备验签 | 结论 |\n")
    md.append("|---|---|---|---|---|\n")
    for i, r1, r2, r3, ok in ver_rows:
        md.append("| %d | `%02X` | `%02X` | `%02X` | %s |\n"
                  % (i, r1, r2, r3, verdict(ok)))
    md.append("\n")

    md.append("### 结论\n\n")
    if failures:
        md.append("存在失败项：%s。\n" % "；".join(failures))
    else:
        md.append("5 组密钥对生成、加密、解密、签名、验证结果均正确，"
                  "SM2 算法串口命令接口正确性验证通过。\n")
    return "".join(md)


# --------------------------------------------------------------------------
# 主流程
# --------------------------------------------------------------------------
def main():
    ap = argparse.ArgumentParser(description="SM2 正确性验证报告生成器")
    ap.add_argument("port", help="串口，例如 COM24 或 /dev/ttyUSB0")
    ap.add_argument("--baud", type=int, default=115200)
    ap.add_argument("--out", default=None,
                    help="输出 Markdown 路径（默认脚本同目录 sm2_cert_report.md）")
    args = ap.parse_args()

    out_path = args.out or os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "sm2_cert_report.md")

    link = Link(args.port, args.baud)
    try:
        failures = []

        # (1) 密钥对生成：槽 3、槽 4 各 5 组
        key3_rows = []
        d3 = pub3 = None
        print("[1/5] 密钥对生成：槽 3（5 组）...", flush=True)
        for i in range(5):
            genkey(link, ID_TMP_DEC)
            d, pub, derived = recover_pair(link, ID_TMP_DEC)
            ok = (pub == derived)
            if not ok:
                failures.append("槽 3 第 %d 组密钥对不一致" % (i + 1))
            key3_rows.append((i + 1, pub, derived, ok))
            d3, pub3 = d, pub
            print("      第 %d 组：%s" % (i + 1, verdict(ok)), flush=True)

        key4_rows = []
        d4 = pub4 = None
        print("[1/5] 密钥对生成：槽 4（5 组）...", flush=True)
        for i in range(5):
            genkey(link, ID_TMP_SIGN)
            d, pub, derived = recover_pair(link, ID_TMP_SIGN)
            ok = (pub == derived)
            if not ok:
                failures.append("槽 4 第 %d 组密钥对不一致" % (i + 1))
            key4_rows.append((i + 1, pub, derived, ok))
            d4, pub4 = d, pub
            print("      第 %d 组：%s" % (i + 1, verdict(ok)), flush=True)

        # (2) 加密：设备加密 -> 上位机独立解密
        print("[2/5] 加密（5 组）...", flush=True)
        enc_rows = []
        dev_cts = []
        for i, L in enumerate(LENS):
            pt = make_pt(L)
            k = fixed_k("LS-SM2-ENC-%d" % (i + 1))
            ct = sm2_enc_dev(link, pub3, k, pt)
            ext_pt = sm2_decrypt(ct, d3)
            ok = (ext_pt == pt)
            if not ok:
                failures.append("加密第 %d 组外部解密不一致" % (i + 1))
            enc_rows.append((i + 1, L, pt, k, ct, ok))
            dev_cts.append(ct)
            print("      第 %d 组（%d B）：%s" % (i + 1, L, verdict(ok)), flush=True)

        # (3) 解密：设备密文、上位机参考密文都交给设备解
        print("[3/5] 解密（5 组 × 2 种密文）...", flush=True)
        dec_rows = []
        for i, L in enumerate(LENS):
            pt = make_pt(L)
            expected = pt

            out = sm2_dec_dev(link, ID_TMP_DEC, dev_cts[i], L)
            ok = (out == expected)
            if not ok:
                failures.append("解密第 %d 组（设备密文）不一致" % (i + 1))
            dec_rows.append((i + 1, "设备加密密文", dev_cts[i], out, expected, ok))
            print("      第 %d 组（%d B，设备密文）：%s"
                  % (i + 1, L, verdict(ok)), flush=True)

            k = fixed_k("LS-SM2-DEC-HOST-%d" % (i + 1))
            host_ct = sm2_encrypt(pub3, pt, k)
            out2 = sm2_dec_dev(link, ID_TMP_DEC, host_ct, L)
            ok2 = (out2 == expected)
            if not ok2:
                failures.append("解密第 %d 组（上位机参考密文）不一致" % (i + 1))
            dec_rows.append((i + 1, "上位机参考密文", host_ct, out2, expected, ok2))
            print("      第 %d 组（%d B，上位机密文）：%s"
                  % (i + 1, L, verdict(ok2)), flush=True)

        # (4)(5) 签名 / 验证
        print("[4/5] 签名（5 组）...", flush=True)
        sign_rows = []
        sigs = []
        digests = []
        for i, L in enumerate(LENS):
            pt = make_pt(L)
            digest = sm3(pt)
            k = fixed_k("LS-SM2-SIGN-%d" % (i + 1))
            sig = sm2_sign_dev(link, ID_TMP_SIGN, digest, k)
            ok = sm2_verify(pub4, digest, sig)
            if not ok:
                failures.append("签名第 %d 组上位机验签失败" % (i + 1))
            sign_rows.append((i + 1, L, digest, k, sig, ok))
            sigs.append(sig)
            digests.append(digest)
            print("      第 %d 组（%d B）：%s" % (i + 1, L, verdict(ok)), flush=True)

        print("[5/5] 验证（5 组 × 3 种签名）...", flush=True)
        ver_rows = []
        for i, L in enumerate(LENS):
            digest = digests[i]
            sig = sigs[i]

            r1 = sm2_verify_dev(link, pub4, digest, sig)

            bad = bytearray(sig)
            bad[0] ^= 0xFF
            r2 = sm2_verify_dev(link, pub4, digest, bytes(bad))

            kh = fixed_k("LS-SM2-VERIFY-HOST-%d" % (i + 1))
            host_sig = sm2_sign_host(d4, digest, kh)
            r3 = sm2_verify_dev(link, pub4, digest, host_sig)

            ok = (r1 == 1 and r2 == 0 and r3 == 1)
            if not ok:
                failures.append("验证第 %d 组结果异常（%02X/%02X/%02X）"
                                % (i + 1, r1, r2, r3))
            ver_rows.append((i + 1, r1, r2, r3, ok))
            print("      第 %d 组：设备签名=%02X 篡改=%02X 上位机签名=%02X %s"
                  % (i + 1, r1, r2, r3, verdict(ok)), flush=True)

        md = build_report(args, key3_rows, key4_rows, pub3, enc_rows,
                          dec_rows, sign_rows, ver_rows, failures)
        with open(out_path, "w", encoding="utf-8", newline="\n") as f:
            f.write(md)

        print("\n报告已写入：%s" % out_path)
        print("结论：" + ("全部通过" if not failures else "存在失败项"))
        return 0 if not failures else 1
    finally:
        link.close()


if __name__ == "__main__":
    sys.exit(main())

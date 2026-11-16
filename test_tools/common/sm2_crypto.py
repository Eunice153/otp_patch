#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""纯 Python SM2 参考实现（GB/T 32918），用于交叉校验设备结果。

不依赖设备私钥；仅用公开参数和测试密钥 TEST_D 做导出包裹的解包。
"""

import hashlib
import os

P_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFF
A_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFFFFFFFFFC
B_CURVE = 0x28E9FA9E9D9F5E344D5A9E4BCF6509A7F39789F515AB8F92DDBCBD414D940E93
N_CURVE = 0xFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFF7203DF6B21C6052B53BBF40939D54123
GX = 0x32C4AE2C1F1981195F9904466A39C9948FE30BBFF2660BE1715A4589334C74C7
GY = 0xBC3736A2F4F6779C59BDCEE36B692153D0A9877CC62A474002DF32E52139F0A0
G = (GX, GY)

# 仅用于导出包裹的测试密钥；正式产品不要使用固定密钥
TEST_D = 0x1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF


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


def pub_from_priv(d):
    d = int.from_bytes(d, "big") if isinstance(d, (bytes, bytearray)) else int(d)
    P = ec_mul(d, G)
    if P is None:
        raise ValueError("非法私钥")
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
    return (C1[0].to_bytes(32, "big") + C1[1].to_bytes(32, "big")
            + C3 + C2)


def sm2_decrypt(ct, d):
    """std=1：C1(64) || C3(32) || C2(N)"""
    d = int.from_bytes(d, "big") if isinstance(d, (bytes, bytearray)) else int(d)
    C1 = (int.from_bytes(ct[:32], "big"), int.from_bytes(ct[32:64], "big"))
    C3 = ct[64:96]
    C2 = ct[96:]
    S = ec_mul(d, C1)
    if S is None:
        raise ValueError("C1 非法")
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
    d = int.from_bytes(d, "big") if isinstance(d, (bytes, bytearray)) else int(d)
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


def rand_k():
    while True:
        k = int.from_bytes(os.urandom(32), "big")
        if 1 <= k < N_CURVE:
            return k.to_bytes(32, "big")


def fixed_k(label):
    """从标签推导固定且合法的 k，便于报告复算。"""
    h = sm3(label.encode("utf-8"))
    k = int.from_bytes(h, "big") % (N_CURVE - 1) + 1
    return k.to_bytes(32, "big")


def test_d_public():
    return pub_from_priv(TEST_D)

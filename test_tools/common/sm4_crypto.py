#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""纯 Python SM4 参考实现（GB/T 32907）。

只用于交叉校验设备结果，不包含任何 OTP 操作。
"""

SBOX = [
    214, 144, 233, 254, 204, 225, 61, 183, 22, 182, 20, 194, 40, 251, 44, 5,
    43, 103, 154, 118, 42, 190, 4, 195, 170, 68, 19, 38, 73, 134, 6, 153,
    156, 66, 80, 244, 145, 239, 152, 122, 51, 84, 11, 67, 237, 207, 172, 98,
    228, 179, 28, 169, 201, 8, 232, 149, 128, 223, 148, 250, 117, 143, 63,
    166, 71, 7, 167, 252, 243, 115, 23, 186, 131, 89, 60, 25, 230, 133, 79,
    168, 104, 107, 129, 178, 113, 100, 218, 139, 248, 235, 15, 75, 112, 86,
    157, 53, 30, 36, 14, 94, 99, 88, 209, 162, 37, 34, 124, 59, 1, 33, 120,
    135, 212, 0, 70, 87, 159, 211, 39, 82, 76, 54, 2, 231, 160, 196, 200,
    158, 234, 191, 138, 210, 64, 199, 56, 181, 163, 247, 242, 206, 249, 97,
    21, 161, 224, 174, 93, 164, 155, 52, 26, 85, 173, 147, 50, 48, 245, 140,
    177, 227, 29, 246, 226, 46, 130, 102, 202, 96, 192, 41, 35, 171, 13, 83,
    78, 111, 213, 219, 55, 69, 222, 253, 142, 47, 3, 255, 106, 114, 109,
    108, 91, 81, 141, 27, 175, 146, 187, 221, 188, 127, 17, 217, 92, 65, 31,
    16, 90, 216, 10, 193, 49, 136, 165, 205, 123, 189, 45, 116, 208, 18, 184,
    229, 180, 176, 137, 105, 151, 74, 12, 150, 119, 126, 101, 185, 241, 9,
    197, 110, 198, 132, 24, 240, 125, 236, 58, 220, 77, 32, 121, 238, 95,
    62, 215, 203, 57, 72,
]
FK = [0xA3B1BAC6, 0x56AA3350, 0x677D9197, 0xB27022DC]
CK = [
    0x00070E15, 0x1C232A31, 0x383F464D, 0x545B6269, 0x70777E85, 0x8C939AA1,
    0xA8AFB6BD, 0xC4CBD2D9, 0xE0E7EEF5, 0xFC030A11, 0x181F262D, 0x343B4249,
    0x50575E65, 0x6C737A81, 0x888F969D, 0xA4ABB2B9, 0xC0C7CED5, 0xDCE3EAF1,
    0xF8FF060D, 0x141B2229, 0x30373E45, 0x4C535A61, 0x686F767D, 0x848B9299,
    0xA0A7AEB5, 0xBCC3CAD1, 0xD8DFE6ED, 0xF4FB0209, 0x10171E25, 0x2C333A41,
    0x484F565D, 0x646B7279,
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
    k = [int.from_bytes(key[i:i + 4], "big") ^ FK[i // 4]
         for i in range(0, 16, 4)]
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
    return b"".join(_block(data[i:i + 16], rk)
                    for i in range(0, len(data), 16))


def sm4_ecb_decrypt(key, data):
    rk = _key_schedule(key)[::-1]
    return b"".join(_block(data[i:i + 16], rk)
                    for i in range(0, len(data), 16))


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

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""NO3 0x40 SM4_BULK 串口辅助（大数据/小数据都可用）。

0x40 是一个逻辑大帧：
    5A 40 LEN0..LEN3  [id, mode, op] + [CBC IV] + data

主机可以把整个请求拆成任意 n 次 write；应答可以分 n 次 read。
固件按 4 字节 LEN 收齐后只处理一次，收齐后只回一帧。

本模块不写 OTP。
"""

import time

from common.link import ID_TMP_SM4
from common.sm4_tools import SM4_CBC, SM4_ECB

SOF = 0x5A
CMD_SM4_BULK = 0x40
MAX_DATA = 131072
DEFAULT_IV = bytes(range(16))


def build_frame(payload):
    return (bytes([SOF, CMD_SM4_BULK]) +
            len(payload).to_bytes(4, "big") + payload)


def build_payload(mode, op, iv, data, slot=ID_TMP_SM4):
    payload = bytes([slot, mode, op])
    if mode == SM4_CBC:
        if iv is None or len(iv) != 16:
            raise ValueError("CBC IV 必须是 16B")
        payload += iv
    payload += data
    return payload


def read_exact(ser, n, timeout, reads=1):
    buf = bytearray()
    deadline = time.monotonic() + timeout
    step = max(1, (n + reads - 1) // max(1, reads)) if n else 1
    while len(buf) < n:
        if time.monotonic() >= deadline:
            raise TimeoutError("等待 %dB 超时，已收到 %d B" % (n, len(buf)))
        chunk = ser.read(min(step, n - len(buf)))
        if chunk:
            buf += chunk
    return bytes(buf)


def read_response(ser, timeout, reads=1):
    """扫描 5A 40，返回 (status, data, raw)。"""
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        b = ser.read(1)
        if not b or b[0] != SOF:
            continue
        b2 = ser.read(1)
        if not b2 or b2[0] != CMD_SM4_BULK:
            continue
        rest = read_exact(ser, 5, max(0.1, deadline - time.monotonic()))
        status = rest[0]
        length = int.from_bytes(rest[1:5], "big")
        data = read_exact(ser, length, max(0.1, deadline - time.monotonic()),
                          reads)
        return status, data, bytes([SOF, CMD_SM4_BULK]) + rest + data
    raise TimeoutError("等待 0x40 应答超时")


def bulk_request(link, payload, timeout=120.0, writes=1, reads=1):
    """发送任意 0x40 PAYLOAD，返回 (status, data, raw)；超时返回 None。"""
    frame = build_frame(payload)
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
    except Exception:
        return None
    finally:
        ser.write_timeout = old_wt
    try:
        return read_response(ser, timeout, reads)
    except TimeoutError:
        return None


def bulk_crypt(link, mode, op, iv, data, slot=ID_TMP_SM4,
               timeout=120.0, writes=1, reads=1):
    """0x40 SM4 加解密；返回 (status, data, raw) 或 None。"""
    if len(data) == 0 or len(data) > MAX_DATA or (len(data) % 16) != 0:
        raise ValueError("SM4 data 必须是 1..131072 且为 16 的倍数")
    payload = build_payload(mode, op, iv, data, slot)
    return bulk_request(link, payload, timeout, writes, reads)


def raw_crypt(link, payload, timeout=1.0, writes=1, reads=1):
    """0x40 任意 PAYLOAD（异常用例）；返回 (status, data, raw) 或 None。"""
    return bulk_request(link, payload, timeout, writes, reads)

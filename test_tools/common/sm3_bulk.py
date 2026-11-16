#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""NO3 0x41 SM3_BULK 串口辅助。

0x41 是一个逻辑大帧：
    5A 41 LEN0..LEN3  data
主机可以拆成任意 n 次 write；应答可以分 n 次 read。
固件收齐 4 字节 LEN 指定的数据后调用一次 Invoke_SM3_cal。
"""

import time

SOF = 0x5A
CMD_SM3_BULK = 0x41
MAX_DATA = 131072
# cmd_uart.c 的大帧缓冲：52B 额外头 + 131072B 数据。
# 异常测试可以发到 131124B，让 handler 返回 0xFE。
MAX_BUFFER = 131124


def build_frame(data):
    return (bytes([SOF, CMD_SM3_BULK]) +
            len(data).to_bytes(4, "big") + data)


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
    """扫描 5A 41，返回 (status, data, raw)。"""
    deadline = time.monotonic() + timeout
    while time.monotonic() < deadline:
        b = ser.read(1)
        if not b or b[0] != SOF:
            continue
        b2 = ser.read(1)
        if not b2 or b2[0] != CMD_SM3_BULK:
            continue
        rest = read_exact(ser, 5, max(0.1, deadline - time.monotonic()))
        status = rest[0]
        length = int.from_bytes(rest[1:5], "big")
        data = read_exact(ser, length, max(0.1, deadline - time.monotonic()),
                          reads)
        return status, data, bytes([SOF, CMD_SM3_BULK]) + rest + data
    raise TimeoutError("等待 0x41 应答超时")


def _send_request(link, data, timeout, writes, reads):
    frame = build_frame(data)
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


def bulk_request(link, data, timeout=60.0, writes=1, reads=1):
    """正常 0x41：data 最大 131072B。"""
    if len(data) > MAX_DATA:
        raise ValueError("SM3 数据最大 131072B")
    return _send_request(link, data, timeout, writes, reads)


def raw_request(link, data, timeout=60.0, writes=1, reads=1):
    """异常边界：允许发到 128KB 缓冲上限 131124B。"""
    if len(data) > MAX_BUFFER:
        raise ValueError("SM3 异常测试数据最大 131124B")
    return _send_request(link, data, timeout, writes, reads)

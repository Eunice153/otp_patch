#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""串口协议公共层。

帧格式：
    请求: 5A CMD LEN_H LEN_L DATA[LEN]
    应答: 5A CMD STATUS LEN_H LEN_L DATA[LEN]

单帧 DATA 上限 CMD_MAX_DATA = 512B。超过时上位机必须分帧。
本模块禁止发送写/销毁 OTP 的命令（SET_PASSWORD / KEY_STORE /
KEY_DESTROY）；测试只用 GENKEY 的临时槽 3/4/5 和临时目标 KEY_IMPORT。
"""

import atexit
import time

SOF = 0x5A
CMD_MAX_DATA = 512

# 命令码
CMD_PING = 0x01
CMD_AUTH = 0x02
CMD_LOGOUT = 0x03
CMD_GET_INFO = 0x04
CMD_SET_PASSWORD = 0x05
CMD_CHECK_PASSWORD = 0x06

CMD_SM3 = 0x10
CMD_GENKEY = 0x11
CMD_GETPUBKEY = 0x12
# 0x13 是通用密钥导出命令；固件里历史名字是 CMD_SM4_EXPORT，
# 但它对 SM2/SM4 槽都适用，不是“SM4 加密”。
CMD_EXPORT_KEY = 0x13
CMD_SM4_EXPORT = CMD_EXPORT_KEY  # 旧名兼容
CMD_KEY_IMPORT = 0x14
CMD_LOAD_PUBKEY = 0x15
CMD_KEY_STORE = 0x16
CMD_KEY_LOAD = 0x17
CMD_KEY_DESTROY = 0x18

CMD_SM4_CRYPT = 0x20
CMD_SM2_ENC = 0x23
CMD_SM2_DEC = 0x24
CMD_SM2_SIGN = 0x30
CMD_SM2_VERIFY = 0x31

CMD_SELFTEST = 0x50
CMD_GET_UID = 0x60

# 槽位
ID_OTP_SM2_DEC = 0
ID_OTP_SM2_SIGN = 1
ID_OTP_SM4 = 2
ID_TMP_SM2_DEC = 3
ID_TMP_SM2_SIGN = 4
ID_TMP_SM4 = 5

TMP_SLOTS = (ID_TMP_SM2_DEC, ID_TMP_SM2_SIGN, ID_TMP_SM4)

# 这些命令会写/销毁 OTP；测试脚本禁止发送。
OTP_WRITE_CMDS = {
    CMD_SET_PASSWORD,
    CMD_KEY_STORE,
    CMD_KEY_DESTROY,
}


def build_frame(cmd, data=b""):
    if len(data) > CMD_MAX_DATA:
        raise ValueError("单帧 DATA 超过 %d B，请分帧" % CMD_MAX_DATA)
    return bytes([SOF, cmd,
                  (len(data) >> 8) & 0xFF, len(data) & 0xFF]) + data


def hex_bytes(data):
    return " ".join("%02X" % b for b in data)


class Link:
    def __init__(self, port, baud=115200):
        try:
            import serial
        except ImportError:
            raise SystemExit("缺少 pyserial，请先执行：pip install pyserial")
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
        """发一帧，返回 (cmd, status, data, raw)；超时返回 None。

        写 OTP 的命令会被直接拒绝，避免误操作。
        """
        if cmd in OTP_WRITE_CMDS:
            raise RuntimeError("禁止发送写/销毁 OTP 命令 0x%02X" % cmd)

        frame = build_frame(cmd, data)
        self.ser.reset_input_buffer()
        self.ser.write(frame)
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
                return (buf[1], buf[2],
                        bytes(buf[5:5 + need]), bytes(buf[:5 + need]))
        return None

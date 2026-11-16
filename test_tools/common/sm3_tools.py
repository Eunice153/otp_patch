#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM3 公共辅助：单帧、参考摘要。"""

import hashlib

from common.link import CMD_SM3


def sm3_ref(data):
    try:
        return hashlib.new("sm3", data).digest()
    except ValueError:
        raise SystemExit("当前 Python 的 hashlib 不支持 SM3")


def oneshot(link, data, timeout=10.0):
    """0x10 单帧；返回 (cmd, status, digest, raw) 或 None。"""
    return link.command(CMD_SM3, data, timeout=timeout)

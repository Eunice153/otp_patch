#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM2 临时槽准备/私钥导出辅助。"""

from common.link import (
    CMD_GENKEY, CMD_GETPUBKEY, CMD_EXPORT_KEY, CMD_LOAD_PUBKEY,
)
from common.sm2_crypto import (
    TEST_D, sm2_decrypt, pub_from_priv, test_d_public,
)


def genkey(link, slot):
    res = link.command(CMD_GENKEY, bytes([slot]))
    return bool(res and res[1] == 0)


def getpub(link, slot):
    res = link.command(CMD_GETPUBKEY, bytes([slot]))
    if res and res[1] == 0 and len(res[2]) == 64:
        return res[2]
    return None


def export_priv(link, slot):
    """LOAD_PUBKEY(TEST_D) + EXPORT(slot,1) -> 32B 私钥；失败返回 None。"""
    res = link.command(CMD_LOAD_PUBKEY, test_d_public())
    if not (res and res[1] == 0):
        return None
    res = link.command(CMD_EXPORT_KEY, bytes([slot, 1]))
    if not (res and res[1] == 0 and len(res[2]) == 128):
        return None
    try:
        return sm2_decrypt(res[2], TEST_D)
    except Exception:
        return None


def prepare_key(link, slot, regenerate=True):
    """准备临时槽密钥并导出私钥做匹配校验。

    返回 dict: genkey/pub/priv/match，失败项为 None/False。
    """
    info = {"slot": slot, "genkey": False, "pub": None,
            "priv": None, "match": False}
    if regenerate:
        info["genkey"] = genkey(link, slot)
    info["pub"] = getpub(link, slot)
    info["priv"] = export_priv(link, slot)
    if info["pub"] is not None and info["priv"] is not None:
        info["match"] = (pub_from_priv(info["priv"]) == info["pub"])
    return info

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM4 临时槽辅助：密钥导出恢复、SM4_CRYPT 组帧。"""

from common.link import (
    CMD_GENKEY, CMD_LOAD_PUBKEY, CMD_EXPORT_KEY, CMD_SM4_CRYPT,
    ID_TMP_SM4,
)
from common.sm2_crypto import TEST_D, sm2_decrypt, test_d_public

SM4_ECB = 0
SM4_CBC = 1
SM4_ENCRYPT = 0
SM4_DECRYPT = 1


def recover_key(link, regenerate=True):
    """GENKEY(5) + LOAD_PUBKEY(TEST_D) + EXPORT_KEY(5,1) -> 16B SM4 密钥。

    返回 dict: genkey/load/export/key，失败项为 False/None。
    """
    info = {"genkey": False, "load": False, "export": False, "key": None}
    if regenerate:
        res = link.command(CMD_GENKEY, bytes([ID_TMP_SM4]))
        info["genkey"] = bool(res and res[1] == 0)

    res = link.command(CMD_LOAD_PUBKEY, test_d_public())
    info["load"] = bool(res and res[1] == 0)

    res = link.command(CMD_EXPORT_KEY, bytes([ID_TMP_SM4, 1]))
    if res and res[1] == 0 and len(res[2]) == 112:
        try:
            key = sm2_decrypt(res[2], TEST_D)
            if len(key) == 16:
                info["key"] = key
                info["export"] = True
        except Exception:
            pass
    return info


def sm4_crypt(link, mode, op, iv, data, slot=ID_TMP_SM4, timeout=10.0):
    """发送 SM4_CRYPT，返回 (status, data, raw) 或 None。

    mode: 0=ECB, 1=CBC；op: 0=加密, 1=解密。
    CBC 时 iv 必须 16B。data 必须是 16 的倍数。
    """
    if mode not in (SM4_ECB, SM4_CBC):
        raise ValueError("SM4 mode 只能是 0/1")
    if op not in (SM4_ENCRYPT, SM4_DECRYPT):
        raise ValueError("SM4 op 只能是 0/1")
    if len(data) == 0 or (len(data) % 16) != 0:
        raise ValueError("SM4 data 长度必须是 16 的正整数倍")

    payload = bytes([slot, mode, op])
    if mode == SM4_CBC:
        if iv is None or len(iv) != 16:
            raise ValueError("CBC IV 必须是 16B")
        payload += iv
    payload += data
    if len(payload) > 512:
        raise ValueError("SM4_CRYPT 单帧 DATA 超过 512B，请分帧")

    res = link.command(CMD_SM4_CRYPT, payload, timeout=timeout)
    if res is None:
        return None
    return res[1], res[2], res[3]

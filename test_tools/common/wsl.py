#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""WSL -> Windows Python 自动切换。

Windows 的 COMx 不能被 WSL 原生 Python 打开，检测到 COM 口时把脚本
重新交给 Windows Python 执行。``--out`` 路径会用 wslpath 转成 Windows
路径，避免 /tmp 被解释成 C:\\tmp。
"""

import codecs
import os
import subprocess
import sys

DEFAULT_WINPY = "/mnt/d/download/zephyr/python/python.exe"


def win_path(path):
    try:
        return subprocess.check_output(
            ["wslpath", "-w", os.path.abspath(path)], text=True
        ).strip()
    except Exception:
        return path


def win_args(argv):
    out = []
    i = 0
    while i < len(argv):
        a = argv[i]
        if a == "--out" and i + 1 < len(argv):
            out += [a, win_path(argv[i + 1])]
            i += 2
        elif a.startswith("--out="):
            out.append("--out=" + win_path(a[6:]))
            i += 1
        else:
            out.append(a)
            i += 1
    return out


def maybe_relaunch(script_file, argv=None):
    """WSL + COMx 时转用 Windows Python；非 WSL/非 COM 直接返回。"""
    if os.name != "posix":
        return
    argv = sys.argv[1:] if argv is None else argv
    if not any(a.upper().startswith("COM") for a in argv):
        return

    winpy = os.environ.get("WINPY", DEFAULT_WINPY)
    if not os.path.exists(winpy):
        return

    try:
        script_win = subprocess.check_output(
            ["wslpath", "-w", os.path.abspath(script_file)], text=True
        ).strip()
        sys.stderr.write("检测到 WSL + COM 口，转用 Windows Python：%s\n" % winpy)
        sys.stderr.flush()
        proc = subprocess.Popen(
            [winpy, "-u", script_win] + win_args(argv),
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
        )
        decoder = codecs.getincrementaldecoder("gbk")(errors="replace")
        try:
            while True:
                chunk = os.read(proc.stdout.fileno(), 4096)
                if not chunk:
                    break
                sys.stdout.write(decoder.decode(chunk))
                sys.stdout.flush()
            sys.stdout.write(decoder.decode(b"", final=True))
            sys.stdout.flush()
        except KeyboardInterrupt:
            sys.stderr.write("\n中止，正在关闭串口...\n")
            proc.kill()
            raise
        finally:
            proc.wait()
        sys.exit(proc.returncode)
    except SystemExit:
        raise
    except Exception as e:
        sys.stderr.write("转用 Windows Python 失败：%s\n" % e)
        sys.stderr.write("将按原生 Python 继续尝试。\n")

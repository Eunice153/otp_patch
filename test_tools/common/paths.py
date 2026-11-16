#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""报告路径工具。

脚本位于 test_tools/<family>/<子目录>/，报告统一放到
test_tools/<family>/<family>_report/。
例如：
    test_tools/sm2/sm2密钥对生成/  -> test_tools/sm2/sm2_report/
    test_tools/sm4/sm4加解密/      -> test_tools/sm4/sm4_report/
"""

import os
import time


def report_dir(script_file):
    here = os.path.dirname(os.path.abspath(script_file))
    family_root = os.path.dirname(here)
    family = os.path.basename(family_root)
    return os.path.join(family_root, family + "_report")


def sm2_report_dir(script_file):
    return report_dir(script_file)


def sm4_report_dir(script_file):
    return report_dir(script_file)


def default_report(script_file, filename):
    return os.path.join(report_dir(script_file), filename)


def now_str():
    return time.strftime("%Y-%m-%d %H:%M:%S")


def write_report(path, text):
    d = os.path.dirname(os.path.abspath(path))
    if d and not os.path.isdir(d):
        os.makedirs(d, exist_ok=True)
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write(text)

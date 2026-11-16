#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""SM4 CBC 速率测试（NO3 0x40，默认 128KB×3 加密+解密）。"""

import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
TEST_TOOLS = os.path.abspath(os.path.join(HERE, "..", ".."))
if TEST_TOOLS not in sys.path:
    sys.path.insert(0, TEST_TOOLS)

from common.wsl import maybe_relaunch  # noqa: E402

maybe_relaunch(__file__)

from common.sm4_speed import speed_main  # noqa: E402
from common.sm4_tools import SM4_CBC  # noqa: E402


if __name__ == "__main__":
    sys.exit(speed_main(SM4_CBC, "sm4_cbc_speed_report.md", __file__))

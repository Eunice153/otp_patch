#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
把 sm2_cert_report.md 的 (1)~(5) 内容填进 公钥-2.doc 的 2.1 章节。

流程：
  1. 解析 sm2_cert_report.md，生成 temp/sec1.html ~ sec5.html
  2. 备份 公钥-2.doc 到 temp/公钥-2_原始备份.doc
  3. 用 Windows Word COM 打开文档，写入 temp/公钥-2_filled.doc
  4. 默认把 filled 覆盖回 公钥-2.doc（可用 --no-apply 只生成 temp 文件）

依赖：
  - Windows 侧有 Word/WPS 的 Word.Application COM
  - WSL 下可调用 powershell.exe

用法：
  python3 fill_sm2_doc.py
  python3 fill_sm2_doc.py --no-apply
  python3 fill_sm2_doc.py --doc 公钥-2.doc --report sm2_cert_report.md
"""

import argparse
import html
import os
import re
import shutil
import subprocess
import sys


CSS = """
body { font-family: "宋体", SimSun, serif; font-size: 9pt; }
p { margin: 3pt 0; }
table { border-collapse: collapse; width: 100%; }
th, td { border: 0.5pt solid #000000; padding: 1pt 2pt;
         font-size: 7.5pt; vertical-align: top; }
th { background: #EFEFEF; font-weight: bold; }
"""


def clean(text):
    return html.escape(text.replace("`", "").strip(), quote=False)


def parse_report(path):
    lines = open(path, encoding="utf-8").read().splitlines()
    sections = {}
    current = None
    blocks = []
    i = 0
    while i < len(lines):
        line = lines[i]
        m = re.match(r"^#### \((\d)\)", line)
        if m:
            if current is not None:
                sections[current] = blocks
            current = int(m.group(1))
            blocks = []
            i += 1
            continue
        if current is not None and line.startswith("### "):
            sections[current] = blocks
            current = None
            blocks = []
            i += 1
            continue
        if current is None:
            i += 1
            continue
        if not line.strip():
            i += 1
            continue

        if line.startswith("|"):
            table_lines = []
            while i < len(lines) and lines[i].startswith("|"):
                table_lines.append(lines[i])
                i += 1
            rows = []
            for tl in table_lines:
                cells = [c.strip() for c in tl.strip().strip("|").split("|")]
                if all(re.fullmatch(r":?-{3,}:?", c) for c in cells):
                    continue
                rows.append(cells)
            if rows:
                blocks.append(("table", rows[0], rows[1:]))
            continue

        if line.startswith("**") and line.endswith("**"):
            blocks.append(("bold", line.strip("*")))
        else:
            blocks.append(("p", line))
        i += 1

    if current is not None:
        sections[current] = blocks
    return sections


def blocks_to_html(blocks):
    out = ['<html><head><meta charset="utf-8"><style>%s</style></head><body>' % CSS]
    for block in blocks:
        kind = block[0]
        if kind == "p":
            out.append("<p>%s</p>" % clean(block[1]))
        elif kind == "bold":
            out.append("<p><b>%s</b></p>" % clean(block[1]))
        elif kind == "table":
            header, rows = block[1], block[2]
            out.append("<table>")
            out.append("<tr>" + "".join("<th>%s</th>" % clean(c)
                                        for c in header) + "</tr>")
            for row in rows:
                if len(row) < len(header):
                    row = row + [""] * (len(header) - len(row))
                elif len(row) > len(header):
                    row = row[:len(header)]
                out.append("<tr>" + "".join("<td>%s</td>" % clean(c)
                                            for c in row) + "</tr>")
            out.append("</table>")
    out.append("</body></html>")
    return "\n".join(out)


PS_SCRIPT = r'''
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = 'Stop'

$docPath = $args[0]
$tempDir = $args[1]
$outPath = $args[2]

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0

try {
    $doc = $word.Documents.Open($docPath, $false, $false)

    # 找到正文里的 2.1.1 算法标题（跳过目录 TOC 项）
    $anchor = 0
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        if ($p.Style.NameLocal -like "TOC*") { continue }
        $t = $p.Range.Text.Trim()
        if ($t -match "^2\.1\.1.*算法") { $anchor = $i; break }
    }
    if ($anchor -eq 0) { throw "找不到正文中的 2.1.1 算法标题" }

    $names = @("密钥对生成", "加密", "解密", "签名", "验证")
    for ($k = 0; $k -lt 5; $k++) {
        $h = $doc.Paragraphs.Item($anchor + 1 + 2 * $k).Range.Text.Trim()
        if ($h -ne $names[$k]) {
            throw ("文档结构不匹配：期望 " + $names[$k] + "，实际 " + $h)
        }
        $phText = $doc.Paragraphs.Item($anchor + 2 + 2 * $k).Range.Text.Trim()
        if ($phText -ne "") {
            throw ("填写位非空（可能已经填写过）：" + $names[$k])
        }
    }

    # 2.1 接口名 / 算法名
    $p = $doc.Paragraphs.Item($anchor - 1)
    if ($p.Range.Text.Trim() -eq "XX接口") {
        $r = $p.Range
        $r.MoveEnd(1, -1) | Out-Null
        $r.Text = "串口命令接口"
    }
    $p = $doc.Paragraphs.Item($anchor)
    if ($p.Range.Text.Trim() -eq "2.1.1 XX算法") {
        $r = $p.Range
        $r.MoveEnd(1, -1) | Out-Null
        $r.Text = "2.1.1 SM2 算法"
    }

    $t0 = $doc.Tables.Count

    # 从最后一个填写位往前插，避免段落索引变化
    for ($k = 4; $k -ge 0; $k--) {
        $idx = $anchor + 2 + 2 * $k
        $htmlPath = Join-Path $tempDir ("sec" + ($k + 1) + ".html")
        if (-not (Test-Path $htmlPath)) { throw ("缺少 " + $htmlPath) }
        $html = $word.Documents.Open($htmlPath, $false, $true)
        $r = $doc.Paragraphs.Item($idx).Range
        $r.Collapse(1)
        $r.FormattedText = $html.Content.FormattedText
        $html.Close($false)
    }

    $t1 = $doc.Tables.Count
    $newTables = $t1 - $t0

    # 只格式化新插入的表：这些表的表头首格都是“组”
    for ($i = 1; $i -le $doc.Tables.Count; $i++) {
        $tbl = $doc.Tables.Item($i)
        if ($tbl.Cell(1,1).Range.Text.Trim() -ne "组") { continue }
        $tbl.Range.Font.Name = "宋体"
        $tbl.Range.Font.Size = 7.5
        $tbl.Borders.InsideLineStyle = 1
        $tbl.Borders.OutsideLineStyle = 1
        $tbl.Rows.Item(1).Range.Font.Bold = $true
        $tbl.Rows.Item(1).HeadingFormat = $true
        $tbl.Rows.Alignment = 1
        $tbl.AutoFitBehavior(1)
    }

    # 粘贴进来的网页样式段落统一改成正文
    $normal = $doc.Styles.Item(-1)
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        try {
            if ($p.Style.NameLocal -match "网站|Web") { $p.Style = $normal }
        } catch {}
    }

    # 目录（TOC）是 WPS 生成的域，COM 整体更新或修改域结果会打乱目录；
    # 这里不动目录，2.1/2.1.1 两行和页码请最后在 WPS 里手动“更新域”。

    $doc.SaveAs([ref]$outPath, [ref]0)
    $doc.Close($false)
    Write-Output ("OK anchor=" + $anchor + " tables=" + $t0 + "->" + $t1 + " out=" + $outPath)
}
finally {
    $word.Quit()
}
'''


def winpath(path):
    return subprocess.check_output(["wslpath", "-w", os.path.abspath(path)],
                                   text=True).strip()


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    ap = argparse.ArgumentParser(description="把 SM2 报告填入 公钥-2.doc")
    ap.add_argument("--doc", default=os.path.join(here, "公钥-2.doc"))
    ap.add_argument("--report", default=os.path.join(here, "sm2_cert_report.md"))
    ap.add_argument("--temp", default=os.path.join(here, "temp"))
    ap.add_argument("--no-apply", action="store_true",
                    help="只生成 temp/公钥-2_filled.doc，不覆盖原文档")
    ap.add_argument("--force", action="store_true",
                    help="忽略 ~$ 锁文件检查，强制覆盖原文档")
    args = ap.parse_args()

    os.makedirs(args.temp, exist_ok=True)

    if not os.path.exists(args.report):
        sys.exit("找不到报告文件：%s" % args.report)
    if not os.path.exists(args.doc):
        sys.exit("找不到文档：%s" % args.doc)

    # 1. 解析报告，生成 HTML
    sections = parse_report(args.report)
    for n in range(1, 6):
        if n not in sections:
            sys.exit("报告里缺少第 (%d) 节" % n)
        path = os.path.join(args.temp, "sec%d.html" % n)
        with open(path, "w", encoding="utf-8", newline="\n") as f:
            f.write(blocks_to_html(sections[n]))
        print("生成 %s（%d 个块）" % (path, len(sections[n])))

    # 缓存报告副本
    shutil.copy2(args.report, os.path.join(args.temp, "sm2_cert_report.md"))

    # 2. 备份原文档
    backup = os.path.join(args.temp, "公钥-2_原始备份.doc")
    if not os.path.exists(backup):
        shutil.copy2(args.doc, backup)
        print("已备份原文档：%s" % backup)
    else:
        print("备份已存在：%s" % backup)

    # 3. 复制工作副本（原文件可能正被 WPS 打开，直接开原文件会卡住）
    work = os.path.join(args.temp, "公钥-2_work.doc")
    shutil.copy2(args.doc, work)
    print("工作副本：%s" % work)

    # 4. 写 PowerShell 脚本并执行
    ps1 = os.path.join(args.temp, "fill_doc.ps1")
    with open(ps1, "w", encoding="utf-8-sig", newline="\n") as f:
        f.write(PS_SCRIPT)

    filled = os.path.join(args.temp, "公钥-2_filled.doc")
    if os.path.exists(filled):
        os.remove(filled)

    cmd = [
        "powershell.exe", "-NoProfile", "-ExecutionPolicy", "Bypass",
        "-File", winpath(ps1), winpath(work), winpath(args.temp),
        winpath(filled),
    ]
    print("调用 Word COM 填充...")
    r = subprocess.run(cmd, text=True, capture_output=True)
    sys.stdout.write(r.stdout)
    sys.stderr.write(r.stderr)
    if r.returncode != 0:
        sys.exit("Word COM 填充失败（returncode=%d）" % r.returncode)
    if not os.path.exists(filled):
        sys.exit("未生成 filled 文档")

    # 5. 覆盖原文档；原文档被 Word/WPS 打开时拒绝覆盖
    lock = os.path.join(os.path.dirname(os.path.abspath(args.doc)),
                        "~$" + os.path.basename(args.doc))
    if not args.no_apply:
        if os.path.exists(lock) and not args.force:
            sys.exit("检测到文档正被 Word/WPS 打开（%s），请先关闭再运行；"
                     "结果已生成：%s；如确认可强制覆盖，加 --force" % (lock, filled))
        shutil.copy2(filled, args.doc)
        print("已覆盖原文档：%s" % args.doc)
    else:
        print("未覆盖原文档（--no-apply），结果在：%s" % filled)


if __name__ == "__main__":
    main()

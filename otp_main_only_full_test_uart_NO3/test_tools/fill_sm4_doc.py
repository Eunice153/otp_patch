#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
把 sm4_cert_report.md 的 (1)~(4) 填进 分组-2.doc 的 2.1 SM4 接口。

- 只填 2.1 的 (1) 加密(ECB) / (2) 解密(ECB) / (3) 加密(CBC) / (4) 解密(CBC)
- 2.2 保持原样
- 输出：分组-2_已填.doc（不覆盖原文档）
- 需要 Windows Word/WPS 的 Word.Application COM

用法：
    python3 fill_sm4_doc.py
    python3 fill_sm4_doc.py --doc 分组-2.doc --report sm4_cert_report.md
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
         font-size: 7pt; vertical-align: top; }
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

    # 找到正文里的 2.1.1 算法标题（跳过目录 TOC）
    $anchor = 0
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        $style = $p.Style.NameLocal
        if ($style -like "TOC*" -or $style -like "目录*") { continue }
        $t = $p.Range.Text.Trim()
        if ($t -eq "2.1.1 XX算法" -or $t -eq "2.1.1 SM4 算法") {
            $anchor = $i
            break
        }
    }
    if ($anchor -eq 0) { throw "找不到正文中的 2.1.1 XX算法 / 2.1.1 SM4 算法" }

    $names = @("加密(ECB模式)", "解密(ECB模式)", "加密(CBC模式)", "解密(CBC模式)")
    for ($k = 0; $k -lt 4; $k++) {
        $h = $doc.Paragraphs.Item($anchor + 1 + 2 * $k).Range.Text.Trim()
        if ($h -ne $names[$k]) {
            throw ("文档结构不匹配：期望 " + $names[$k] + "，实际 " + $h)
        }
        $phText = $doc.Paragraphs.Item($anchor + 2 + 2 * $k).Range.Text.Trim()
        if ($phText -ne "") {
            throw ("填写位非空（可能已填写过）：" + $names[$k])
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
        $r.Text = "2.1.1 SM4 算法"
    }

    $t0 = $doc.Tables.Count

    # 从最后一个填写位往前插，避免段落索引变化
    for ($k = 3; $k -ge 0; $k--) {
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

    # 只格式化新表：SM4 的 4 张表都是 6 行 × 6 列
    # 不做 AutoFitBehavior，避免大表格导致 Word OOM
    for ($i = 1; $i -le $doc.Tables.Count; $i++) {
        $tbl = $doc.Tables.Item($i)
        if ($tbl.Rows.Count -ne 6 -or $tbl.Columns.Count -ne 6) { continue }
        $tbl.Range.Font.Name = "SimSun"
        $tbl.Range.Font.Size = 7
        $tbl.Borders.InsideLineStyle = 1
        $tbl.Borders.OutsideLineStyle = 1
        $tbl.Rows.Item(1).Range.Font.Bold = $true
        $tbl.Rows.Item(1).HeadingFormat = $true
        $tbl.Rows.Alignment = 1
        $tbl.PreferredWidthType = 2
        $tbl.PreferredWidth = 100
    }

    # 粘贴进来的网页样式段落统一改成正文
    $normal = $doc.Styles.Item(-1)
    for ($i = 1; $i -le $doc.Paragraphs.Count; $i++) {
        $p = $doc.Paragraphs.Item($i)
        try {
            if ($p.Style.NameLocal -match "网站|Web") { $p.Style = $normal }
        } catch {}
    }

    # 目录不自动更新（WPS COM 整体更新会打乱目录）
    $doc.SaveAs([ref]$outPath, [ref]0)
    $doc.Close($false)
    Write-Output ("OK anchor=" + $anchor + " tables=" + $t0 + "->" + $t1 + " out=" + $outPath)
}
finally {
    try { $word.Quit() } catch {}
}
'''


def winpath(path):
    return subprocess.check_output(["wslpath", "-w", os.path.abspath(path)],
                                   text=True).strip()


def main():
    here = os.path.dirname(os.path.abspath(__file__))
    ap = argparse.ArgumentParser(description="把 SM4 报告填入 分组-2.doc")
    ap.add_argument("--doc", default=os.path.join(here, "分组-2.doc"))
    ap.add_argument("--report", default=os.path.join(here, "sm4_cert_report.md"))
    ap.add_argument("--temp", default=os.path.join(here, "temp_sm4"))
    ap.add_argument("--out", default=os.path.join(here, "分组-2_已填.doc"))
    args = ap.parse_args()

    os.makedirs(args.temp, exist_ok=True)

    if not os.path.exists(args.report):
        sys.exit("找不到报告文件：%s" % args.report)
    if not os.path.exists(args.doc):
        sys.exit("找不到文档：%s" % args.doc)

    sections = parse_report(args.report)
    for n in range(1, 5):
        if n not in sections:
            sys.exit("报告里缺少第 (%d) 节" % n)
        path = os.path.join(args.temp, "sec%d.html" % n)
        with open(path, "w", encoding="utf-8", newline="\n") as f:
            f.write(blocks_to_html(sections[n]))
        print("生成 %s（%d 个块）" % (path, len(sections[n])))

    # 把报告里的测试条件/参数加到第 (1) 节开头
    lines = open(args.report, encoding="utf-8").read().splitlines()
    serial = key = iv = ""
    for line in lines:
        if line.startswith("- 串口："):
            serial = line[5:].strip()
        elif line.startswith("- 密钥 K"):
            key = line.split("：", 1)[1].strip().strip("`") if "：" in line else ""
        elif line.startswith("- CBC IV"):
            iv = line.split("：", 1)[1].strip().strip("`") if "：" in line else ""
    if serial or key or iv:
        extra = []
        if serial:
            extra.append("测试条件：%s；密钥为临时槽 5，参考实现为独立 Python SM4。" % serial)
        if key:
            extra.append("测试参数：密钥 K = %s；CBC IV = %s。" % (key, iv))
        if extra:
            sec1_path = os.path.join(args.temp, "sec1.html")
            s = open(sec1_path, encoding="utf-8").read()
            add = "".join("<p>%s</p>" % clean(x) for x in extra)
            s = s.replace("<body>", "<body>" + add, 1)
            open(sec1_path, "w", encoding="utf-8", newline="\n").write(s)
            print("已在第 (1) 节加入测试条件/参数")

    # 工作副本，避免原文档被占用
    work = os.path.join(args.temp, "分组-2_work.doc")
    shutil.copy2(args.doc, work)

    ps1 = os.path.join(args.temp, "fill_sm4_doc.ps1")
    with open(ps1, "w", encoding="utf-8-sig", newline="\n") as f:
        f.write(PS_SCRIPT)

    filled = os.path.join(args.temp, "分组-2_filled.doc")
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

    shutil.copy2(filled, args.out)
    print("已生成：%s" % args.out)


if __name__ == "__main__":
    main()

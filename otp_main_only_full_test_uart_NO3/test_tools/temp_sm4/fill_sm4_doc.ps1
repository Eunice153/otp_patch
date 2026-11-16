
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

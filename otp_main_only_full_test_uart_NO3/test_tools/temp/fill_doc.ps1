
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

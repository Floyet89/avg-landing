# Erzeugt og.png (1200x630) fuer Social-Vorschauen. Einmalig ausfuehren, Ergebnis wird mit deployed.
Add-Type -AssemblyName System.Drawing

$W = 1200; $H = 630
$bmp = New-Object System.Drawing.Bitmap($W, $H)
$g   = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

function C([string]$hex) { [System.Drawing.ColorTranslator]::FromHtml($hex) }

# --- Hintergrund: flach, damit das PNG klein bleibt ---
$g.Clear((C "#0F1B2F"))

# --- Kompass ---
$cx = 300.0; $cy = 315.0; $r = 130.0
$ringCol = C "#456394"
$pen = New-Object System.Drawing.Pen($ringCol, 22)
$pen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$pen.EndCap   = [System.Drawing.Drawing2D.LineCap]::Round

$box = New-Object System.Drawing.RectangleF(($cx - $r), ($cy - $r), (2 * $r), (2 * $r))
$g.DrawArc($pen, $box, 294, 49)
$g.DrawArc($pen, $box, 17, 56)
$g.DrawArc($pen, $box, 107, 56)
$g.DrawArc($pen, $box, 197, 49)

# Buchstaben A / G / V auf dem Ring
$fLetter = New-Object System.Drawing.Font("Segoe UI", 60, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$bLetter = New-Object System.Drawing.SolidBrush($ringCol)
$fmt = New-Object System.Drawing.StringFormat
$fmt.Alignment = [System.Drawing.StringAlignment]::Center
$fmt.LineAlignment = [System.Drawing.StringAlignment]::Center
$g.DrawString("A", $fLetter, $bLetter, (New-Object System.Drawing.PointF(($cx - $r), $cy)), $fmt)
$g.DrawString("G", $fLetter, $bLetter, (New-Object System.Drawing.PointF(($cx + $r), $cy)), $fmt)
$g.DrawString("V", $fLetter, $bLetter, (New-Object System.Drawing.PointF($cx, ($cy + $r + 4))), $fmt)

# Gruener Kreis mit Plus
$rp = 34.5
$g.FillEllipse((New-Object System.Drawing.SolidBrush((C "#7F9E7F"))), ($cx - $rp), ($cy - $r - $rp), (2 * $rp), (2 * $rp))
$penPlus = New-Object System.Drawing.Pen((C "#F2EFE8"), 9.3)
$penPlus.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
$penPlus.EndCap   = [System.Drawing.Drawing2D.LineCap]::Round
$py = $cy - $r
$g.DrawLine($penPlus, $cx, ($py - 17.3), $cx, ($py + 17.3))
$g.DrawLine($penPlus, ($cx - 17.3), $py, ($cx + 17.3), $py)

# Nadel, um 37 Grad gedreht
$state = $g.Save()
$g.TranslateTransform($cx, $cy)
$g.RotateTransform(37)
$ptsL = @(
  (New-Object System.Drawing.PointF(0, -125.9)),
  (New-Object System.Drawing.PointF(-38.6, 12.2)),
  (New-Object System.Drawing.PointF(0, 125.9))
)
$ptsR = @(
  (New-Object System.Drawing.PointF(0, -125.9)),
  (New-Object System.Drawing.PointF(38.6, 12.2)),
  (New-Object System.Drawing.PointF(0, 125.9))
)
$g.FillPolygon((New-Object System.Drawing.SolidBrush((C "#A9BCDC"))), $ptsL)
$g.FillPolygon((New-Object System.Drawing.SolidBrush((C "#38578A"))), $ptsR)
$g.Restore($state)

# --- Wortmarke ---
$x = 545.0
$fThin = New-Object System.Drawing.Font("Segoe UI Light", 66, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$fBold = New-Object System.Drawing.Font("Segoe UI", 66, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$bThin = New-Object System.Drawing.SolidBrush((C "#C9D2E2"))
$bBold = New-Object System.Drawing.SolidBrush((C "#F2EFE8"))

$g.DrawString("Ambulante",      $fThin, $bThin, $x, 168)
$g.DrawString("Versorgungs-",   $fBold, $bBold, ($x - 4), 246)
$g.DrawString("gemeinschaft",   $fBold, $bBold, ($x - 4), 324)

# Trennlinie + Datum
$penRule = New-Object System.Drawing.Pen((C "#2C4670"), 2)
$g.DrawLine($penRule, $x, 428, ($x + 300), 428)

$fDate = New-Object System.Drawing.Font("Consolas", 21, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$bDate = New-Object System.Drawing.SolidBrush((C "#8FA3C4"))
$dot = [char]0x00B7
$ae = [char]0x00C4
$g.DrawString("GEMEINSAM AN DER PRIM" + $ae + "RVERSORGUNG", $fDate, $bDate, $x, 456)

$out = Join-Path $PSScriptRoot "og.png"
$bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
Write-Output "geschrieben: $out"

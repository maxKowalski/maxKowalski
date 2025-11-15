Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
xelatex -jobname="MaximilianKowalski" resume.tex

$pdf = Join-Path $PSScriptRoot "MaximilianKowalski.pdf"
if (Test-Path $pdf) { Start-Process -FilePath "code" -ArgumentList "--reuse-window",$pdf }
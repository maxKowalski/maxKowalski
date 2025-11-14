<#
resume/setup-latex.ps1

Detects whether `pdflatex` is available and attempts to install a LaTeX
distribution on Windows using `winget` or `choco`. If elevation is required
the script can relaunch itself as Administrator.

Usage: Run from PowerShell:
  powershell -ExecutionPolicy Bypass -File .\setup-latex.ps1
#>

param(
    [switch]$Force
)

function Test-Admin {
    $current = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $current.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

Write-Host "Checking for pdflatex on PATH..."
$pdflatex = Get-Command pdflatex -ErrorAction SilentlyContinue
if ($pdflatex) {
    Write-Host "pdflatex found at: $($pdflatex.Path)"
    exit 0
}

Write-Host "pdflatex not found. Preparing to install a LaTeX distribution."

if (-not (Test-Admin)) {
    Write-Host "This script is not running as Administrator. Some installers require elevation."
    if (-not $Force) {
        $answer = Read-Host "Relaunch elevated and continue installation? (Y/n)"
        if ($answer -in @('', 'y', 'Y')) {
            Start-Process -FilePath "powershell" -ArgumentList "-ExecutionPolicy Bypass -NoProfile -File `"$PSCommandPath`" -Force" -Verb RunAs
            exit 0
        }
    }
}

$winget = Get-Command winget -ErrorAction SilentlyContinue
$choco = Get-Command choco -ErrorAction SilentlyContinue

if ($winget) {
    Write-Host "Found winget. Trying to install MiKTeX via winget..."
    try {
        & winget install --id MiKTeX.MiKTeX -e --accept-package-agreements --accept-source-agreements
    } catch {
        Write-Host "winget installation attempt failed or package id not available. Trying install by name..."
        try { & winget install MiKTeX } catch { }
    }
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Installation triggered via winget. After installation, restart your shell and re-run `pdflatex --version`."
        exit 0
    }
    Write-Host "winget attempts did not succeed or returned non-zero exit code."
}

if ($choco) {
    Write-Host "Found Chocolatey. Trying to install MiKTeX via choco..."
    try {
        & choco install miktex -y
    } catch {
        Write-Host "choco installation failed or is unavailable."
    }
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Installation triggered via Chocolatey. After installation, restart your shell and re-run `pdflatex --version`."
        exit 0
    }
}

Write-Host "Automatic installation did not complete. Please install one of the following distributions manually:"
Write-Host " - MiKTeX (recommended on Windows): https://miktex.org/download"
Write-Host " - TeX Live: https://tug.org/texlive/windows.html"
Write-Host "After installing, restart your shell and verify with: pdflatex --version"
exit 2

# Build and open resume.tex
# The script lives in the `resume` folder; use the script root as the resume dir
$resumeDir = $PSScriptRoot
$texFile = Join-Path $resumeDir "resume.tex"
$pdfFile = Join-Path $resumeDir "resume.pdf"

# Change to resume directory
Push-Location $resumeDir

try {
    # Determine which LaTeX engine is available
    $xelatex = Get-Command xelatex -ErrorAction SilentlyContinue
    $pdflatex = Get-Command pdflatex -ErrorAction SilentlyContinue

    if ($xelatex) {
        $latexCmd = "xelatex"
    } elseif ($pdflatex) {
        $latexCmd = "pdflatex"
    } else {
        Write-Host "[ERROR] No LaTeX engine found (xelatex or pdflatex)."
        Write-Host "Run the setup script: `resume\setup-latex.ps1` or install MiKTeX/TeXLive."
        exit 1
    }

    Write-Host "Compiling resume.tex using: $latexCmd"

    # If an old PDF exists, remove it so the viewer receives a fresh file
    if (Test-Path $pdfFile) {
        try { Remove-Item -LiteralPath $pdfFile -Force -ErrorAction SilentlyContinue } catch {}
    }

    # Run the engine twice to resolve cross-references/TOC
    & $latexCmd -interaction=nonstopmode resume.tex 2>&1 | Out-Null
    & $latexCmd -interaction=nonstopmode resume.tex 2>&1 | Out-Null

    # Check if PDF was created
    if (Test-Path $pdfFile) {
        Write-Host "[SUCCESS] Resume compiled successfully: $pdfFile"

        # Clean up common LaTeX auxiliary files to keep the folder tidy
        $auxPatterns = @(
            '*.aux', '*.log', '*.out', '*.toc', '*.lof', '*.lot',
            '*.bbl', '*.blg', '*.synctex.gz', '*.xdv', '*.fls', '*.fdb_latexmk'
        )
        foreach ($pat in $auxPatterns) {
            $files = Get-ChildItem -Path $resumeDir -Filter $pat -File -ErrorAction SilentlyContinue
            foreach ($f in $files) {
                try {
                    Remove-Item -LiteralPath $f.FullName -Force -ErrorAction SilentlyContinue
                } catch {
                    # If removal fails, continue without stopping the build
                }
            }
        }

        Write-Host "Resume PDF is ready at: $pdfFile"
    } else {
        Write-Host "[ERROR] Failed to compile resume. Check your LaTeX installation and logs."
        exit 1
    }
} catch {
    Write-Host "[ERROR] Exception: $_"
    exit 1
} finally {
    Pop-Location
}

# Build and open resume.tex
$resumeDir = Join-Path $PSScriptRoot "resume"
$texFile = Join-Path $resumeDir "resume.tex"
$pdfFile = Join-Path $resumeDir "resume.pdf"

# Change to resume directory
Push-Location $resumeDir

try {
    # Compile LaTeX to PDF (using xelatex)
    Write-Host "Compiling resume.tex..."
    xelatex -interaction=nonstopmode resume | Out-Null
    
    # Check if PDF was created
    if (Test-Path $pdfFile) {
        Write-Host "[SUCCESS] Resume compiled successfully: $pdfFile"
        # Open the PDF
        Start-Process $pdfFile
        Write-Host "Opening resume in default PDF viewer..."
    } else {
        Write-Host "[ERROR] Failed to compile resume. Check your LaTeX installation."
        exit 1
    }
} catch {
    Write-Host "[ERROR] Exception: $_"
    exit 1
} finally {
    Pop-Location
}

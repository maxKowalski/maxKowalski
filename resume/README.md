# Max Kowalski Portfolio

Personal portfolio and resume for Maximilian Kowalski, Mechanical & Robotics Engineer.

## Project Structure

```
maxKowalski/
├── index.html          # Portfolio website
├── resume/
│   ├── resume.tex      # LaTeX resume source
│   ├── resume.pdf      # Compiled resume (generated)
│   ├── awesome-cv.cls  # Resume template class
│   ├── fontawesome.sty  # Font Awesome support
│   └── fonts/          # Custom fonts (Roboto, Source Sans Pro, FontAwesome)
├── build-resume.ps1    # Build script for resume compilation
└── README.md           # This file
```

## Building the Resume

### Prerequisites

- **MiKTeX** (or compatible LaTeX distribution with XeLaTeX)
- **Windows PowerShell 5.1+**

Install MiKTeX from: https://miktex.org/

### Quick Start

**Option 1: VS Code Build Task (Recommended)**
- Press `Ctrl+Shift+B` in VS Code
- Automatically compiles `resume.tex` and opens the PDF

**Option 2: PowerShell Script**
```powershell
.\build-resume.ps1
```

This will:
1. Compile `resume/resume.tex` using XeLaTeX
2. Generate `resume/resume.pdf`
3. Open the PDF in your default viewer

### Manual Compilation

```powershell
cd resume
xelatex -interaction=nonstopmode resume
```

## Resume Details

- **Template**: Awesome-CV (Modified)
- **Compiler**: XeLaTeX
- **Fonts**: Roboto, Source Sans Pro, FontAwesome
- **Output**: Single-page PDF

## Editing the Resume

Edit `resume/resume.tex` in any text editor:
- LaTeX syntax with Awesome-CV commands
- Compile after changes using the build script
- Custom fonts are automatically loaded from `resume/fonts/`

## Troubleshooting

**"PDF not created"**
- Ensure XeLaTeX is installed: `xelatex --version`
- Check for LaTeX syntax errors in `resume.tex`
- Verify fonts folder exists with required font files

**"Compilation fails"**
- Run with verbose mode: `xelatex -interaction=errorstopmode resume`
- Check the generated `.log` file for specific errors

**"Fonts not loading"**
- Ensure all `.ttf` and `.otf` files are in `resume/fonts/`
- Run MiKTeX Update Wizard to refresh font cache

## Portfolio Website

View the portfolio at `index.html` - open in any web browser.

---

**Last Updated**: November 13, 2025

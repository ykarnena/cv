# mycv.cls — Minimal LaTeX CV class

A clean, readable CV/Resume class with simple commands for sections and entries.

## Features
- Lightweight: built on `article`, minimal dependencies
- Theming: `theme=light` (default) or `theme=dark`
- Simple API: `\makecvheader`, `\cvsection`, `\cventry`, `\cvitem`, `\cvskill`, `\cvbullets`
- Works with pdfLaTeX, XeLaTeX, or LuaLaTeX

## Files
- `mycv.cls`: the class
- `example.tex`: sample CV using the class

## Usage
Place `mycv.cls` next to your `.tex` file and start with:

```tex
\documentclass[11pt,a4paper]{mycv}
\name{Jane Doe}
\tagline{Senior Software Engineer}
\contacts{jane.doe@example.com | example.com | +1 555 123 4567}
\begin{document}
\makecvheader
\section{Experience}
% ...
\end{document}
```

### Commands
- `\name{<text>}`: Set your name
- `\tagline{<text>}`: Short role/summary
- `\contacts{<text>}`: Contact line (supports `\href{}`)
- `\cventry{dates}{title}{org}{location}{desc}`: Work/edu entry
- `\cvitem{label}{content}`: Simple labeled row
- `\cvskill{area}{keywords}`: Two-column skill row
- `\cvbullets{\item ...}`: Compact bullet list inside descriptions

### Themes
Pass `theme=dark` to switch to a dark palette:

```tex
\documentclass[11pt,letterpaper]{mycv}
\PassOptionsToClass{theme=dark}{mycv}
```

## Build
From Windows PowerShell in this folder:

```powershell
pdflatex example.tex
```

For best typography with system fonts, use XeLaTeX or LuaLaTeX:

```powershell
xelatex example.tex
```

Run twice if you add references or TOC (not typical for CVs).

## License
MIT

# cv
A repository to store the CV Template and CV contents implemented in LaTeX.

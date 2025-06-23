\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2023/10/01 A class for writing CVs and resumes]

% Options
\LoadClass{report}
\DeclareOption{a4paper}{\setlength{\paperwidth}{210mm}\setlength{\paperheight}{297mm}\ClassInfo{cv}{A4 paper size selected}}
\DeclareOption{letterpaper}{\setlength{\paperwidth}{216mm}\setlength{\paperheight}{279mm}\ClassInfo{cv}{Letter paper size selected}}
\DeclareOption{landscape}{\setlength{\textwidth}{297mm}\setlength{\textheight}{210mm}\ClassInfo{cv}{Landscape orientation selected}}
\DeclareOption{portrait}{\setlength{\textwidth}{210mm}\setlength{\textheight}{297mm}\ClassInfo{cv}{Portrait orientation selected}}
\DeclareOption{10pt}{\renewcommand{\normalsize}{\fontsize{10}{12}\selectfont}\ClassInfo{cv}{10pt font size selected}}
\DeclareOption{11pt}{\renewcommand{\normalsize}{\fontsize{11}{13}\selectfont}\ClassInfo{cv}{11pt font size selected}}
\DeclareOption{12pt}{\renewcommand{\normalsize}{\fontsize{12}{14}\selectfont}\ClassInfo{cv}{12pt font size selected}}
\DeclareOption{twocolumn}{\setlength{\columnsep}{20pt}\setlength{\columnseprule}{0pt}\ClassInfo{cv}{Two-column layout selected}}
\DeclareOption{onecolumn}{\setlength{\columnsep}{0pt}\setlength{\columnseprule}{0pt}\ClassInfo{cv}{One-column layout selected}}
\DeclareOption{draft}{\overfullrule=5pt\ClassInfo{cv}{Draft mode selected}}
\DeclareOption{final}{\overfullrule=0pt\ClassInfo{cv}{Final mode selected}}
\DeclareOption{english}{\def\lang{english}\ClassInfo{cv}{English language selected}}
\DeclareOption{german}{\def\lang{german}\ClassInfo{cv}{German language selected}}

\ExecuteOptions{a4paper,12pt,english}
\ProcessOptions\relax

% Engine detection
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}

\newif\ifcv@xetexorluatex
\ifxetex
  \cv@xetexorluatextrue
  \ClassInfo{cv}{Using XeLaTeX engine}
\else
  \ifluatex
    \cv@xetexorluatextrue
    \ClassInfo{cv}{Using LuaLaTeX engine}
  \else
    \cv@xetexorluatexfalse
    \ClassInfo{cv}{Using pdfLaTeX engine}
  \fi
\fi

\ifcv@xetexorluatex
  \RequirePackage{fontspec}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{textcomp}
  \RequirePackage{lmodern}
\fi

% Font selection using xstring
\RequirePackage{xstring}

% Font setup commmand \setcvfont limited to helvetica, arial, times, courier
% and computer modern. If using XeLaTeX or LuaLaTeX, it sets
% the main font to the specified one. If using pdfLaTeX, it imports the packages
% helvet, arial, times, courier, or cmr and sets the default font family to the specified one.

\newcommand{\setcvfont}[1]{%
  \ifcv@xetexorluatex
    % XeLaTeX / LuaLaTeX: set the actual font
    \setmainfont{#1}
    \ClassInfo{cv}{Using system font '#1' with fontspec}
  \else
    % pdfLaTeX-safe fonts
    \IfStrEq{#1}{helvetica}{%
      \RequirePackage{helvet}
      \renewcommand{\familydefault}{\sfdefault} % Use sans-serif family globally
      \ClassInfo{cv}{Helvetica font selected (via \familydefault)}%
    }{%
    \IfStrEq{#1}{arial}{%
      \RequirePackage{helvet} % Fallback to Helvetica (Arial-compatible)
      \renewcommand{\familydefault}{\sfdefault}
      \ClassInfo{cv}{Arial (substituted by Helvetica) selected}%
    }{%
    \IfStrEq{#1}{times}{%
      \RequirePackage{mathptmx} % Better Times support
      \renewcommand{\familydefault}{\rmdefault}
      \ClassInfo{cv}{Times font selected}%
    }{%
    \IfStrEq{#1}{courier}{%
      \RequirePackage{courier}
      \renewcommand{\familydefault}{\ttdefault}
      \ClassInfo{cv}{Courier font selected}%
    }{%
    \IfStrEq{#1}{cmr}{%
      \renewcommand{\familydefault}{\rmdefault}
      \ClassInfo{cv}{Computer Modern Roman font selected}%
    }{%
      \ClassWarning{cv}{Unknown font '#1'. Using Computer Modern.}%
      \renewcommand{\familydefault}{\rmdefault}
    }}}}}%
  \fi
}

% --- Color Setup ---
\RequirePackage{xcolor}

% Default color
\colorlet{cvcolor}{gray}

% Colors:
\definecolor{cvjet}{RGB}{42,45,29} % Jet black
\definecolor{cvroyalpurple}{RGB}{111,83,146} % Royal purple
\definecolor{cvcornflowerblue}{RGB}{44,68,111} % Cornflower blue

% Use the above defined colors for the cvcolor for heading and section titles as \setcvcolor command
\newcommand{\setcvcolor}[1]{%
    \IfStrEq{#1}{cvjet}{%
        \colorlet{cvcolor}{cvjet}%
        \ClassInfo{cv}{Color set to cvjet (Jet black)}%
    }{%
    \IfStrEq{#1}{cvroyalpurple}{%
        \colorlet{cvcolor}{cvroyalpurple}%
        \ClassInfo{cv}{Color set to cvroyalpurple (Royal purple)}%
    }{%
    \IfStrEq{#1}{cvcornflowerblue}{%
        \colorlet{cvcolor}{cvcornflowerblue}%
        \ClassInfo{cv}{Color set to cvcornflowerblue (Cornflower blue)}%
    }{%
        \colorlet{cvcolor}{gray} % Default color
        \ClassWarning{cv}{Unknown color '#1'. Using default gray.}%
    }}}%
}

% Apply cvcolor to section headings
\usepackage{sectsty}
\sectionfont{\color{cvcolor}} % Set section font color
\subsectionfont{\color{cvcolor}} % Set subsection font color
\subsubsectionfont{\color{cvcolor}} % Set subsubsection font color

% Set default CV data commands
\newcommand{\cvname}[1]{\def\@cvname{#1}
\ClassInfo{cv}{CV name set to '#1'}}
\newcommand{\cvemail}[1]{\def\@cvemail{#1}
\ClassInfo{cv}{CV email set to '#1'}}
\newcommand{\cvphone}[1]{\def\@cvphone{#1}
\ClassInfo{cv}{CV phone set to '#1'}}
\newcommand{\cvaddress}[1]{\def\@cvaddress{#1}
\ClassInfo{cv}{CV address set to '#1'}}
\newcommand{\cvwebsite}[1]{\def\@cvwebsite{#1}
\ClassInfo{cv}{CV website set to '#1'}}
\newcommand{\cvsummary}[1]{\def\@cvsummary{#1}
\ClassInfo{cv}{CV summary set to '#1'}}
\newcommand{\cvnationality}[1]{\def\@cvnationality{#1}}
\ClassInfo{cv}{CV Nationality set to '#1'}
\newcommand{\cvlocation}[1]{\def\@cvlocation{#1}
\ClassInfo{cv}{CV location set to '#1'}}
\newcommand{\cvpicturelocation}[1]{\def\@cvpicturelocation{#1}}
\ClassInfo{cv}{CV picture location set to '#1'}
\newcommand{\cvdateofbirth}[1]{\def\@cvdateofbirth{#1}}

% CV Header
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{fontawesome5} % For icons like phone, email, etc.
\pagestyle{fancy}
\fancyhf{} % Clear all header and footer fields
\newcommand{\makecvheader}{%
    % Verify that the name, email and address are set
    \ifx\@cvname\undefined
        \ClassError{cv}{CV name is not set. Use \cvname command to set it.}{}%
    \fi
    \ifx\@cvemail\undefined
        \ClassError{cv}{CV email is not set. Use \cvemail command to set it.}{}%
    \fi
    \ifx\@cvaddress\undefined
        \ClassError{cv}{CV address is not set. Use \cvaddress command to set it.}{}%
    \fi

    % If german language option is selected then warn if nationality, picture is not set.
    \ifx\lang\german
        \ifx\@cvnationality\undefined
            \ClassWarning{cv}{CV would be better with Nationality. Use \cvaddress to set it.}{}%
        \fi
        \ifx\@cvpicturelocation\undefined
            \ClassWarning{cv}{CV would be better with a picture. Use \cvpicturelocation to set it.}{}%
        \fi
    \fi

    % Header content
    \fancyhead[L]{
        % Display large name with cvcolor within an aligned hbox
        \begin{minipage}[t]{0.7\textwidth}
            \raggedleft
            {\Large\color{cvcolor}\@cvname}\\[1ex]
            {\@cvaddress}\\
            {\faenvelope\ \@email}\\
            {\fatelephone\ \@cvphone}\\
            \ifx\@cvwebsite\undefined
                % If website is not set, do not display it
                \ClassWarning{cv}{CV would be better with a website. Use \cvwebsite to set it.}{}%
            \else
                {\faweb\ \@cvwebsite}\\
            \fi
            \ifx\@cvdateofbirth\undefined
                % If date of birth is not set, do not display it
                \ClassWarning{cv}{CV would be better with Date of Birth. Use \cvdateofbirth to set it.}{}%
            \else
                {\faday\ \@cvdateofbirth}\\
            \ifx\@cvnationality\undefined
                % If 
                \ClassWarning{cv}{CV would be better with Nationality. Use \cvnationality to set it.}{}%
            \else
                {\faflag\ \@cvnationality}\\
            \fi

            
    }
}
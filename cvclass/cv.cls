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
% Define the german flag before options are processed
\newif\ifcv@german
\cv@germanfalse % default

\DeclareOption{german}{
  \def\lang{german}
  \cv@germantrue
  \ClassInfo{cv}{German language selected}
}


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
\newcommand{\cvnationality}[1]{\def\@cvnationality{#1}}
\ClassInfo{cv}{CV Nationality set to '#1'}
\newcommand{\cvlocation}[1]{\def\@cvlocation{#1}
\ClassInfo{cv}{CV location set to '#1'}}
\newcommand{\cvpicturelocation}[1]{\def\@cvpicturelocation{#1}}
\ClassInfo{cv}{CV picture location set to '#1'}
\newcommand{\cvdateofbirth}[1]{\def\@cvdateofbirth{#1}}

\newcommand{\@cvpagemargin}{margin=2.5cm}
\newcommand{\cvpagemargin}[1]{\renewcommand{\@cvpagemargin}{#1}}
% CV Header

\newcommand{\@headerseparation}{20pt}
\newcommand{\cvheadersep}[1]{\renewcommand{\@headerseparation}{#1}}

\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[includehead]{geometry}
\RequirePackage{fontawesome5} % For icons like phone, email, etc.
\RequirePackage{calc}

% Verification of fields
\newcommand{\cvcheckfields}{
  \@ifundefined{@cvname}{%
    \ClassError{cv}{Required field cvname not set}{Please provide your name using '\cvname\{...\}'}%
  }{}
  \@ifundefined{@cvemail}{%
    \ClassError{cv}{Required field cvemail not set}{Please provide your email using '\cvemail\{...\}'}%
  }{}
  \@ifundefined{@cvphone}{%
    \ClassError{cv}{Required field cvphone not set}{Please provide your phone number using '\cvphone\{...\}'}%
  }{}
  \@ifundefined{@cvaddress}{%
    \ClassError{cv}{Required field cvaddress not set}{Please provide your phone number using '\cvaddress\{...\}'}%
  }{}
  \ifcv@german
    \@ifundefined{@cvnationality}{%
      \ClassWarning{cv}{Nationality is required for German CVs but not set}%
    }{}
    \@ifundefined{@cvdateofbirth}{%
      \ClassWarning{cv}{Date of birth is required for German CVs but not set}%
    }{}
  \fi
}

\AtEndPreamble{
  \cvcheckfields
}

\AtBeginDocument{
	\newsavebox{\cvbiodatahdr}
	\sbox{\cvbiodatahdr}{%
  		\begin{minipage}{0.55\textwidth}
    			\begin{flushleft}
    			\textbf{\textcolor{cvcolor}{\LARGE \@cvname}}\\[5pt]
			\@cvaddress\\
			\faIcon{envelope}~\href{mailto:\@cvemail}\@cvemail\\
			\faIcon{mobile-alt}~\href{tel:\@cvphone}\@cvphone\\
			% -- Insert code for optional fields such as nationality and date of birth here. They must be rendered on basis of the lanugage --%
			\@ifundefined{@cvnationality}{}{%
  				\ifcv@german
    					\textcolor{cvcolor!80}{{Staatsangehörigkeit:}} \@cvnationality\\
  				\else
    					\textcolor{cvcolor!80}{{Nationality:}} \@cvnationality\\
  				\fi
			}

			% Optional: date of birth
			\@ifundefined{@cvdateofbirth}{}{%
  			\ifcv@german
    				\textcolor{cvcolor!80}{{Geburtsdatum:}} \@cvdateofbirth\\
  			\else
    				\textcolor{cvcolor!80}{{Date of Birth:}} \@cvdateofbirth\\
  			\fi
			}
			\@ifundefined{@cvwebsite}{}{%
				\faIcon{globe}~\href{\@cvwebsite}{\@cvwebsite}%
			}
    			\end{flushleft}
  		\end{minipage}%
	}

	\newlength{\cvheaderboxheight}
	\settototalheight{\cvheaderboxheight}{\usebox{\cvbiodatahdr}}
	\setlength{\headheight}{\cvheaderboxheight}
	\setlength{\headsep}{\@headerseparation}
	
	\expandafter\geometry\expandafter{\@cvpagemargin, headheight=\the\headheight, headsep=\the\headsep}

	\pagestyle{fancy}
	\fancyhf{} % clear all header/footer fields

	% Use the saved box as the header
	\fancyhead[L]{\usebox{\cvbiodatahdr}}

	\fancyhead[R]{
		\begin{minipage}{0.4\textwidth}
			\begin{flushright}
			
			\end{flushright}
		\end{minipage}
	}
	\renewcommand{\headrulewidth}{0pt}
}

\newenvironment{cvsummary}{%
  \section*{\ifcv@german Zusammenfassung\else Summary\fi}%
}{}
% cv.cls -- a simple CV class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mycv}[2025/09/08 A Custom CV class]

% =========================
% Options
% =========================
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=cv,
  prefix=cv@
}

% Custom options
\DeclareStringOption[en]{lang}       % default is en
\DeclareStringOption[industry]{target} % default is industry

% Forward unknown options to article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}

% Process *all* options now
\ProcessKeyvalOptions*   % handles kvoptions
\ProcessOptions\relax    % handles class options (12pt, a4paper, etc.)

% =========================
% Load base class
% =========================
\LoadClass{article}


% -------------------------
% Debug output (remove later)
% -------------------------
\typeout{[cv.cls] Loading CV class...}
\typeout{  -> Language: \cv@lang}
\typeout{  -> Target:   \cv@target}


% =========================
% Packages
% =========================
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{geometry}
\RequirePackage{xcolor}
\RequirePackage{ifthen}
\RequirePackage{enumitem} % for better lists
\RequirePackage{etoolbox}
\RequirePackage{titlesec}
\RequirePackage{graphicx} % for \includegraphics
\RequirePackage{etoolbox}  % Enables \ifstrequal for reliable string comparisons
\RequirePackage{lastpage} % To compute the total number of pages
\RequirePackage{fancyhdr}
\RequirePackage{fontawesome5} % modern FontAwesome 5 icons
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{longtable}
\RequirePackage{calc}
\RequirePackage{needspace}
\RequirePackage{array}
\RequirePackage{accsupp}

% =========================
% Language setup
% =========================
\ifthenelse{\equal{\cv@lang}{de}}{%
	\RequirePackage[ngerman]{babel}
	\geometry{left=2cm,right=2cm,top=2cm,bottom=2cm}
	\ClassInfo{cv}{Language mode: German}
	\newcommand{\cvlang}
}{%
	\RequirePackage[english]{babel}
	\geometry{left=2cm,right=2cm,top=2cm,bottom=2cm}
	\ClassInfo{cv}{Language mode: English}
}


% =========================
% CV Font based on CV Target
% =========================
% Font selection
\ifthenelse{\equal{\cv@target}{industry}}{%
	% Helvetica for industry
	\RequirePackage[scaled=0.95]{helvet}
	\renewcommand*\familydefault{\sfdefault}
	\ClassInfo{cv}{Industry mode: Helvetica selected}
}{%
	\RequirePackage{palatino} % academic elegance
	\ClassInfo{cv}{Academic mode: using Palatino}
}

% =========================
% CV Color Palette
% =========================
\definecolor{jetblack}{HTML}{2A2D31}         % Jet Black
\definecolor{royalpurple}{HTML}{6F5392}     % Royal Purple
\definecolor{darkcornflowerblue}{HTML}{2C446F} % Dark Cornflower Blue
\definecolor{egyptianblue}{HTML}{20349F} % Egyptian Blue
\definecolor{slategray}{HTML}{6C7F93} % Slate Gray
\definecolor{bluegray}{HTML}{799ACC} % Blue Gray
\definecolor{bluegreen}{HTML}{359EBF} % Blue Green
\definecolor{viridiangreen}{HTML}{468F92} % Viridian Green
\definecolor{opal}{HTML}{B2D1C9} % Opal
\definecolor{darkseagreen}{HTML}{90AE85} % Dark Sea Green
\definecolor{ferngreen}{HTML}{647C41} % Fern Green
\definecolor{castletongreen}{HTML}{005842} % Castleton Green
\definecolor{bronze}{HTML}{CD853F} % Bronze
\definecolor{kobe}{HTML}{7A3516} % Kobe
\definecolor{upmaroon}{HTML}{770B0E} % UP Maroon
\definecolor{linkedinblue}{HTML}{0072B1} % LinkedIn Blue

% Macro to select colors
\newcommand{\cvcolorsetup}[3][]{%
	% If optional argument is empty, use defaults
	\ifx&#1&%
		\colorlet{cvprimary}{darkcornflowerblue}
		\colorlet{cvsecondary}{jetblack}
		\colorlet{cvaccent}{bluegray}
	\else
	% Otherwise, use user-supplied colors (comma-separated or individually)
	% #1 = primary, #2 = secondary, #3 = accent
		\colorlet{cvprimary}{#1}
		\colorlet{cvsecondary}{#2}
		\colorlet{cvaccent}{#3}
	\fi
}

% Automatically set default colors on class load
\cvcolorsetup{}

% =========================
% General font settings
% =========================
\setlength{\parskip}{0.3em} % small space
\setlength{\parindent}{0pt} % no indentation

% =========================
% Section styling
% =========================
% Section formatting with horizontal rule
\titleformat{\section}
	{\color{cvsecondary}\Large\bfseries} % Jet Black, bold, large
	{} % no numbering
	{0pt} % separation between label and title
	{} % before-code
	[\vspace{-1em}\color{cvsecondary}\rule{\linewidth}{1.5pt}] % after-code: horizontal rule

% Spacing control
\titlespacing*{\section}
	{0pt}    % left margin
	{0.0em}  % space before section (top)
	{0.0em}  % space after title (before after-code)

% =========================
% Diagnostics
% =========================
\typeout{[cv.cls] Loading CV class...}
\ClassInfo{cv}{Language option selected = \cv@lang}

% Example: warn if user picked unsupported font size
\ifthenelse{\equal{\@ptsize}{2}}{ % 12pt in article means @ptsize=2
	\ClassInfo{cv}{Using 12pt font size}
}{
	\ClassWarning{cv}{Non-12pt font size detected. Make sure your layout still looks good.}
}

% =========================
% Custom CV Data commands
% =========================
\newcommand{\name}[1]{\def\@cvname{#1}}
\newcommand{\address}[1]{\def\@cvaddress{#1}}
\newcommand{\telephone}[1]{\def\@cvtelephone{#1}}
\newcommand{\mobile}[1]{\def\@cvmobile{#1}}
\newcommand{\email}[1]{\def\@cvemail{#1}}
\newcommand{\linkedin}[1]{\def\@cvlinkedin{#1}}
\newcommand{\github}[1]{\def\@cvgithub{#1}}
\newcommand{\nationality}[1]{\def\@cvnationality{#1}}
\newcommand{\dateofbirth}[1]{\def\@cvdateofbirth{#1}}
\newcommand{\profilepicture}[1]{\def\@cvprofilepicture{#1}}

% =========================
% CV Header Separation settings
% =========================
\newlength{\headerpagesep}            % allocate a new length
\setlength{\headerpagesep}{0.75cm}       % default value (you choose)

% user-facing setter
\newcommand{\setheaderpagesep}[1]{\setlength{\headerpagesep}{#1}}

% The header bottom separation
\newlength{\headersep}
\setlength{\headersep}{0.5cm} % Default value

% user-facing setter
\newcommand{\setheadersep}[1]{\setlength{\headersep}{#1}}

% =========================
% Make CV Header
% =========================
% Disable Hyperlink coloring
\hypersetup{
	colorlinks=false                   % do not color links (optional)
}

% Optional Metadata and functions
\newif\ifcv@additionalsymbols
\cv@additionalsymbolsfalse % default: use text labels

\newcommand{\useadditionaldatasymbols}{%
  \cv@additionalsymbolstrue
}

% default key-value options
\edef\cvprofilegraphicsoptions{width=3cm,keepaspectratio}

% allow user override
\newcommand{\setcvprofilepictureoptions}[1]{\edef\cvprofilegraphicsoptions{#1}}

% Function to generate the CV header
\newcommand{\makecvheader}{%
	\vspace*{-\dimexpr\topskip + \headsep + \topmargin + 1in - \headerpagesep\relax} % Adjust the border 
	\noindent
	\begin{tabular}{@{}p{0.7\textwidth}@{}p{0.3\textwidth}@{}}
		\vtop{\vfill
			\begin{minipage}[t]{0.7\textwidth}
			{\Huge\bfseries\textcolor{cvprimary}\@cvname}\par
			{\textcolor{cvsecondary}\@cvaddress

			% Personal Info Info
			\ifcv@additionalsymbols
				\ifx\@cvnationality\@empty
					\ifx\@cvdateofbirth\@empty
					\else
						\textcolor{cvaccent}{\faBirthdayCake}\ \@cvdateofbirth\par
					\fi
				\else
					\ifx\@cvdateofbirth\@empty
						\textcolor{cvaccent}{\faIdCard}\ \@cvnationality\par
					\else
						\textcolor{cvaccent}{\faIdCard}\ \@cvnationality\ \textcolor{cvaccent}{\faBirthdayCake}\ \@cvdateofbirth\par
					\fi
				\fi
			\else
				\ifthenelse{\equal{\cv@lang}{de}}{%
					\ifx\@cvnationality\@empty
					\else
						Staatsangehörigkeit:\  \@cvnationality\par
					\fi
					\ifx\@cvdateofbirth\@empty
					\else
						Geburtsdatum:\ \@cvdateofbirth\par
					\fi
				}%
				{%
					\ifx\@cvnationality\@empty
					\else
						Nationality:\  \@cvnationality\par
					\fi
					\ifx\@cvdateofbirth\@empty
					\else
						Date of Birth:\ \@cvdateofbirth\par
					\fi
				}%
			\fi
			
			% Render Telephone
			\ifx\@cvtelephone\@empty\else
				\textcolor{cvaccent}{\faPhone}\ \href{tel:\@cvtelephone}{\@cvtelephone}\par
			\fi

			% Render Mobile Info
			\ifx\@cvmobile\@empty\else
				\textcolor{cvaccent}{\faMobile}\ \href{tel:\@cvmobile}{\@cvmobile}\par
			\fi

			% Render Email Info
			\ifx\@cvemail\@empty\else
				\textcolor{cvaccent}{\faEnvelope}\ \href{mailto:\@cvemail}{\@cvemail}\par
			\fi
			
			% Render other socials
			\ifx\@cvlinkedin\@empty
				\ifx\@cvgithub\@empty
				\else
					\faGithub\ \@cvgithub
				\fi
			\else
				\ifx\@cvgithub\empty
					\textcolor{linkedinblue}{\faLinkedin}\ \@cvlinkedin
				\else
					\textcolor{linkedinblue}{\faLinkedin}\ \@cvlinkedin\ \faGithub\ \@cvgithub
				\fi
			\fi
			}
			\end{minipage}
		} & 
		\vtop{\vfill
		\begin{minipage}[t]{0.3\textwidth}
			\hfill
			\expandafter\includegraphics\expandafter[\cvprofilegraphicsoptions]{\@cvprofilepicture}
		\end{minipage}
		}
	\end{tabular}
	%\vspace{-1em} % negative space to pull content up
	\vspace{\headersep}%
}

%% Setup Footer %%

\pagestyle{fancy}          % use fancyhdr
\fancyhf{}                 % clear all header and footer fields

% Footer: left empty, right = page / total pages
\fancyfoot[R]{%
	{\color{cvaccent}\thepage}%
	/%
	{\color{cvsecondary}\pageref{LastPage}}%
}

\renewcommand{\headrulewidth}{0pt}  % no header line
\renewcommand{\footrulewidth}{0pt}  % optional: no footer line

\makeatletter
\def\@cvtelephone{}
\def\@cvmobile{}
\def\@cvemail{}
\def\@cvlinkedin{}
\def\@cvgithub{}
\def\@cvnationality{}
\def\@cvdateofbirth{}
\def\@cvprofilepicture{}
\makeatother

% =========================
% Table length handling utilities
% =========================
% Define column lengths with defaults
\newlength{\cvleftcol}
\newlength{\cvsepcol}
\newlength{\cvrightcol}

% defaults
\setlength{\cvleftcol}{0.13\textwidth}
\setlength{\cvsepcol}{0.05\textwidth}
\setlength{\cvrightcol}{\textwidth - \cvleftcol - \cvsepcol}

% Functions to adjust later
\newcommand{\setleftcol}[1]{%
  \setlength{\cvleftcol}{#1}%
  \setlength{\cvrightcol}{\textwidth - \cvleftcol - \cvsepcol}%
}
\newcommand{\setsepcol}[1]{%
  \setlength{\cvsepcol}{#1}%
  \setlength{\cvrightcol}{\textwidth - \cvleftcol - \cvsepcol}%
}
\newcommand{\setcolwidths}[2]{%
  \setlength{\cvleftcol}{#1}%
  \setlength{\cvsepcol}{#2}%
  \setlength{\cvrightcol}{\textwidth - \cvleftcol - \cvsepcol}%
}

\newcommand{\setdefaultcolwidths}{%
	\setlength{\cvleftcol}{0.13\textwidth}
	\setlength{\cvsepcol}{0.05\textwidth}
	\setlength{\cvrightcol}{\textwidth - \cvleftcol - \cvsepcol}
}

% =========================
% Professional Experience Environment
% =========================
% Setup Environment
\makeatletter
\newenvironment{profexperience}
{%
	% Fully expand the macro before comparing
	\edef\tempa{\cv@lang}%
	\ifdefstring{\tempa}{de}{%
		\Needspace{5\baselineskip} % ensure at least 5 lines fit
		\section{Berufserfahrung}%
	}{%
		\Needspace{5\baselineskip} % ensure at least 5 lines fit
		\section{Professional Experience}%
	}%

}%
{%
}%
\makeatother


% =========================
% Date Range display utility
% =========================
%\newlength{\monthwidth}
%\settowidth{\monthwidth}{Sep}   % or the widest month abbreviation
%\newlength{\yearwidth}
%\settowidth{\yearwidth}{20}     % 2-digit year
%\newlength{\separatorlen}
%\settowidth{\ }
%\newcommand{\daterange}[4]{%
%\ifthenelse{\equal{#3}{Present} \OR \equal{#3}{Heute}}%
%	{%
%		\begin{tabular}{@{}p{\monthwidth}p{\separatorlen}p{\yearwidth}@{\, -- \,}l@{}}
%			#1 & & #2 & #3
%		\end{tabular}
%	}{%
%		\begin{tabular}{@{}p{\monthwidth}p{\separatorlen}p{\yearwidth}@{\, -- \,}p{\monthwidth}p{\separatorlen}p{\yearwidth}@{}}%
%    			#1 & & #2 & #3 & & #4%
%  		\end{tabular}%
%}%
%}%

% =========================
% Professional Experience Entry
% =========================
\newenvironment{experienceentry}[3]{%
	\begin{tabular}{@{}p{\cvleftcol}@{}p{\cvsepcol}@{}p{\cvrightcol}@{}}
		\def\currentcompany{#2}
		\def\currentcompanyloc{#3}
		\def\currentcompanydate{#1}
		#1&& \textbf{\textcolor{cvsecondary}{#2}} -- #3 \newline
}
{%
	\end{tabular}\vspace{-0.75\baselineskip}
}



% =========================
% Itemize customization
% =========================
% Custom hollow circle bullet
\newcommand{\hollowcircle}{\textcolor{cvaccent}{\scalebox{1.25}{$\circ$}}}

% Set up itemize with reduced spacing and hollow circle bullets
\setlist[itemize,1]{%
    label=\hollowcircle,           % Use hollow circle as bullet
    itemsep=0.1em,                 % Space between items
    parsep=0em,                    % Space between paragraphs within items
    topsep=0.25em,                  % Space before/after the list
    partopsep=0em,                 % Extra space when list starts new paragraph
    leftmargin=1.1em               % Left margin for bullets
}

% =========================
% Role Description Entry
% =========================
\newenvironment{role}[2]{
%	\vspace{0.75em}
	\emph{#1}\hfill\ifstrempty{#2}{
	}{
	(#2)
	}%
%	\vspace{-0.5\baselineskip}
	\begin{itemize}
}{
	\end{itemize}
}

% =========================
% Academics Section Environment
% =========================
% Setup Environment
\makeatletter
\newenvironment{academics}{%
	% Fully expand the macro before comparing
	\edef\tempa{\cv@lang}%
	\ifdefstring{\tempa}{de}{%
		\Needspace{5\baselineskip} % ensure at least 5 lines fit
		\section{Akademischer Werdegang}%
	}{%
		\Needspace{5\baselineskip} % ensure at least 5 lines fit
		\section{Education}%
	}%

}{%
}%
\makeatother

% =========================
% Academics Entry Environment
% =========================
% Setup Environment
\makeatletter
\newenvironment{acadentry}[6]{%
	% Expand the macro before comparision
	\edef\tempa{\cv@lang}%
	
	% Add entry
	\begin{tabular}{@{}p{\cvleftcol}@{}p{\cvsepcol}@{}p{\cvrightcol}@{}}
		\raggedright #1 && \textbf{\textcolor{cvsecondary}{#2}} -- {#3}\newline
		\emph{#4}\newline
		\ifdefstring{\tempa}{de}{%
			\ifstrempty{#5}{}{%
				\textbf{\underline{Schwerpunkt}}: #5
			}%
			\ifstrempty{#6}{}{%
				(Gesamtnote -- {#6})
			}%
		}{%
			\ifstrempty{#5}{}{%
				\textbf{\underline{Major}}: #5
			}%
			\ifstrempty{#6}{}{%
				(Total Grade -- {#6})
			}%
		}
}{%
	\end{tabular}\vspace{0.25em}
}
\makeatother

% =========================
% Skills Environment
% =========================
% Setup environment
\makeatletter
\newenvironment{skills}{%
	% Fully expand the macro before comparing
	\edef\tempa{\cv@lang}%
	\ifdefstring{\tempa}{de}{%
		\Needspace{5\baselineskip} % ensure at least 5 lines fit
		\section{Kenntnisse}%
	}{%
		\Needspace{5\baselineskip} % ensure at least 5 lines fit
		\section{Skills}%
	}%
	\begin{tabular}{@{}p{\cvleftcol}@{}p{\cvsepcol}@{}p{\cvrightcol}@{}}
}{%
	\end{tabular}\vspace{0.25em}
}
\makeatother

% =========================
% Skills Entry Macro
% =========================
\newcommand{\skillentry}[2]{%
	% #1 -> Skill Type, #2 -> Skills List
	\raggedright\textbf{\textcolor{cvsecondary}{#1}}:&& #2\\
}

% =========================
% Generic CV Table Environment
% =========================
\newenvironment{cvtable}{%
	\begin{tabular}{@{}p{\cvleftcol}@{}p{\cvsepcol}@{}p{\cvrightcol}@{}}
}{%
	\end{tabular}
}

\endinput

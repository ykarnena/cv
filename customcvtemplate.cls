\ProvidesClass{customcvtemplate}

% Load additional packages
\RequirePackage{xcolor}        
\RequirePackage{fontawesome5}  
\RequirePackage{geometry}      
\RequirePackage{xkeyval}
\RequirePackage{etoolbox}  % Enables \ifstrequal for reliable string comparisons
\RequirePackage{graphicx}


% Default value (in case no option is given)
\def\customcvtemplate@cvlocation{en}

% Declare direct language options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{moderncv}}
\DeclareOptionX{en}{\def\customcvtemplate@cvlocation{en}}
\DeclareOptionX{de}{\def\customcvtemplate@cvlocation{de}}


% Process options
\ProcessOptionsX\relax

\typeout{Final cvlocation: \customcvtemplate@cvlocation}

\newcommand*{\nationality}[1]{\def\@nationality{#1}}
\newcommand*{\dateofbirth}[1]{\def\@dateofbirth{#1}}
\newcommand*{\profilepicture}[2]{
\def\@profilepicture{#1}
\def\@profilepicturescale{#2}
}

\LoadClassWithOptions{moderncv}

\AtEndOfClass{
	\newcommand*{\localedob}{%
		\ifthenelse{\equal{\customcvtemplate@cvlocation}{de}}%
			{Geburtsdatum: }%
			{Date of Birth: }%
  	}
	\newcommand*{\localenationality}{
		\ifthenelse{\equal{\customcvtemplate@cvlocation}{de}}
			{Staatsangehörigkeit: }
			{Nationality: }
	}
}
% Custom page geometry
\geometry{left=2cm, right=2cm, top=1.5cm, bottom=1.5cm}

\renewcommand*{\makecvtitle}{
	% Preprocessing
	\def\phonesdetails{}%
    	\collectionloop{phones}{% the key holds the phone type (=symbol command prefix), the item holds the number
      		\protected@edef\phonesdetails{\phonesdetails\protect\makenewline\csname\collectionloopkey phonesymbol\endcsname\collectionloopitem}}%
    	\def\socialsdetails{}%
    	\collectionloop{socials}{% the key holds the social type (=symbol command prefix), the item holds the link
      		\protected@edef\socialsdetails{\socialsdetails\protect\makenewline\csname\collectionloopkey socialsymbol\endcsname\collectionloopitem}}%
	
	\noindent
	\begin{tabular}{@{}p{0.7\textwidth}@{}p{0.3\textwidth}@{}}
	\vtop{\vfill
	\begin{minipage}[t]{0.7\textwidth}
	
		\namestyle{\@firstname\ \@lastname} \\
		\addressfont\color{color2}%
		\ifthenelse{\isundefined{\@addressstreet}}{}{\makenewline\addresssymbol\@addressstreet%
          	\ifthenelse{\equal{\@addresscity}{}}{}{, \@addresscity}% if \addresstreet is defined, \addresscity and addresscountry will always be defined but could be empty
          	\ifthenelse{\equal{\@addresscountry}{}}{}{, \@addresscountry}}%
        		\phonesdetails% needs to be pre-rendered as loops and tabulars seem to conflict
        		\ifthenelse{\isundefined{\@email}}{}{\makenewline\emailsymbol\emaillink{\@email}}%
        		\ifthenelse{\isundefined{\@homepage}}{}{\makenewline\homepagesymbol\httplink{\@homepage}}%
        		\socialsdetails% needs to be pre-rendered as loops and tabulars seem to conflict
        		\ifthenelse{\isundefined{\@extrainfo}}{}{\makenewline\@extrainfo}%
		\ifthenelse{\isundefined{\@nationality}}{}{\makenewline \localenationality\@nationality}%
		\ifthenelse{\isundefined{\@nationality}}{}{\makenewline \localedob\@dateofbirth}
		%\vphantom{This content height will be matched by the image on the right.}  % Phantom box for height calculation&
	
	\end{minipage}}&
	\begin{minipage}[t]{0.3\textwidth}
	
		\ifthenelse{\isundefined{\@profilepicture}}{}
		{
			\vtop{\null
			\hfill
			\vspace{-1mm}
			\includegraphics[scale=\@profilepicturescale]{\@profilepicture}}
		}
	
	\end{minipage}
	\end{tabular}
}

\newcommand*{\cventrycompany}[2]{\hintstyle{#1} -- {#2}}

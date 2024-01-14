
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mitthesis}[1999/10/20]

\def\mystretch{1.5}		% Double spacing hack
\DeclareOption{doublespace}{}	% This is default
				% So we do not read this style twice
\DeclareOption{singlespace}{		% If he explicitly wants single spacing
    \typeout{Single spaced}
    \def\mystretch{1}}	

%% `vi' and `upcase' document style options.  Krishna Sethuraman (1990)
\newcount\vithesis
\DeclareOption{vi}{\typeout{Course VI/VIII thesis style.}\advance\vithesis by1}
\vithesis=0

\DeclareOption{upcase}{\typeout{Uppercase cover page.}
	\gdef\choosecase#1{\uppercase\expandafter{#1}}}
\def\choosecase#1{#1}

%% leftblank option by Kevin Fu
\newif\if@leftblank \@leftblankfalse

\DeclareOption{leftblank}{\typeout{Intentionally Leaving Pages Blank}
\@leftblanktrue}

%  Thesis looks much like report
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass{report}

% If the user wants single spacing, set baselinestretch=1.

\usepackage{setspace}

% Note - doublespace.sty has some float-related troubles in
% combination with graphics or color, and is not officially compliant
% with 2e.  setspace is a replacement which is 2e-compliant.

% Read the doublespace style that we got from Rochester:
%\input setdoublespace.sty 		

\def\baselinestretch{\mystretch}	% Double spacing hack

%%%%%%%  Set up margins and formatting params %%%

% Margins.
%  Note we want 1in top margin assuming no header line, so push header
%	into 1in margin.
%  Draft mode brings the header back down.

\setlength{\oddsidemargin}{0.25in}	% 1.25in left margin 
\setlength{\evensidemargin}{0.25in}	% 1.25in left margin (even pages)
\setlength{\topmargin}{0.0in}		% 1in top margin
\setlength{\textwidth}{6.0in}		% 6.0in text - 1.25in rt margin
\setlength{\textheight}{9in}		% Body ht for 1in margins
\addtolength{\topmargin}{-\headheight}	% No header, so compensate
\addtolength{\topmargin}{-\headsep}	% for header height and separation

% The next two macros compensate page style for headers and footers
% We only need them in page styles that USE headers and footers.
    % If we have a header, it must be 1in from top of page.
\def\pulldownheader{			% Shift header down 1in from top
    \addtolength{\topmargin}{\headheight}	
    \addtolength{\topmargin}{\headsep}	
    \addtolength{\textheight}{-\headheight}
    \addtolength{\textheight}{-\headsep}
}
    % If we have a footer, put it 1in up from bottom
\def\pullupfooter{				% Shift footer up
    \addtolength{\textheight}{-\footskip}
%    \addtolength{\textheight}{-\footheight}  %footheight doesn't
%    						exist in 2e
}

%%%%%%%  End of margins and formatting params %%%

%%%%%%%  Fix various header and footer problems %%%

% Draft mark on the right side of left pages (outside)
% this mark is also the only one visible on single sided.
\newcommand{\draftrmark}{**DRAFT**} 
% Draft mark on the left side of right pages (outside)
\newcommand{\draftlmark}{**DRAFT**} % 

% Macros to make changing the Draft easier
\newcommand{\drmark}[1]{\renewcommand{\draftrmark}{#1}}
\newcommand{\dlmark}[1]{\renewcommand{\draftlmark}{#1}}
\newcommand{\dmark}[1]{\drmark{#1}\dlmark{#1}}

% Format for draft of thesis.  Define our own PageStyle -
% Just like headings, but has foot lines with the date and warning

\if@twoside         % If two-sided printing.
\def\ps@drafthead{
    \let\@mkboth\markboth
    \def\@oddfoot{\rm \today \hfil \sc \draftrmark}
    \def\@evenfoot{\sc \draftlmark \hfil \rm \today }
    \def\@evenhead{\rm \thepage\hfil \sl \leftmark}
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}
  \def\chaptermark##1{\markboth {\uppercase{\ifnum \c@secnumdepth >\m@ne
	\@chapapp\ \thechapter. \ \fi ##1}}{}}
    \def\sectionmark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\z@
	\thesection. \ \fi ##1}}}
    \pulldownheader				% Bring header down from edge
    \pullupfooter				% Bring footer up
}
\else               % If one-sided printing.
\def\ps@drafthead{
    \let\@mkboth\markboth
    \def\@oddfoot{\rm \today \hfil \sc \draftrmark}
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}
    \def\chaptermark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
	\@chapapp\ \thechapter. \ \fi ##1}}}
    \pulldownheader				% Bring header down from edge
    \pullupfooter				% Bring footer up
}
\fi

% I redefine these formats that were defined in report.sty
% Definition of 'headings' page style 
%  Note the use of ##1 for parameter of \def\chaptermark inside the
%  \def\ps@headings.
%

\if@twoside					% If two-sided printing.
\def\ps@headings{\let\@mkboth\markboth
    \def\@oddfoot{}
    \def\@evenfoot{}		% No feet.
    \def\@evenhead{\rm \thepage\hfil \sl \leftmark}	% Left heading.
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}	% Right heading.
    \def\chaptermark##1{\markboth {\uppercase{\ifnum \c@secnumdepth >\m@ne
	\@chapapp\ \thechapter. \ \fi ##1}}{}}	
    \def\sectionmark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\z@
	\thesection. \ \fi ##1}}}
    \pulldownheader				% Bring header down from edge
}
\else						% If one-sided printing.
\def\ps@headings{\let\@mkboth\markboth
    \def\@oddfoot{}
    \def\@evenfoot{}		%     No feet.
    \def\@oddhead{\hbox {}\sl \rightmark \hfil \rm\thepage}	% Heading.
    \def\chaptermark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
	\@chapapp\ \thechapter. \ \fi ##1}}}
    \pulldownheader				% Bring header down from edge
}
\fi

% Redefinition of 'myheadings' page style.  
%
\def\ps@myheadings{\let\@mkboth\@gobbletwo
    \def\@oddfoot{}
    \def\@evenfoot{}
    \def\sectionmark##1{}
    \def\subsectionmark##1{}
    \def\@evenhead{\rm \thepage\hfil\sl\leftmark\hbox {}}	%
    \def\@oddhead{\hbox{}\sl\rightmark \hfil \rm\thepage}	%
    \pulldownheader				% Bring header down from edge
}						
\thispagestyle{empty}
% Redefine '/chapter' to always start on an odd page.
% Should make no difference in singleside mode.
%

% If using the report style, use - instead of . in the figure number.
\@ifundefined{thechapter}{}{\def\thefigure{\thechapter-\arabic{figure}}}

\def\maketitle{\begin{titlepage}
\large
{\def\baselinestretch{1.2}\Large\bf \choosecase{\@title} \par}\par
\choosecase{\textbf{\size \textbf{}
}}
\\
\vspace{15mm}
\par

\begin{center}
   \includegraphics[width=5cm, height=5cm]{JSSLOGO.png} 
\end{center}
\par
%\choosecase{\size \textbf{in Partial Fulfillment of the Requirements}}
\\
% Please add the following required packages to your document preamble:
% \usepackage{graphicx}
\par
% Please add the following required packages to your document preamble:
% \usepackage{graphicx}

%\choosecase{\size\textbf{for the Degree of}}
\par
%\choosecase{\bigbigsize \textbf{DOCTOR OF PHILOSOPHY}} 
\\
%\choosecase{\size \textbf{in}}
\\
\vspace{25mm}
\par
\choosecase{\bigsize \textbf{Mini Project/Internship Assessment (BCC 351)}}
\par
\title{TITLE}

\par
COURSE: B.Tech.
\par
SEMESTER:III
\par
by
\par
\choosecase{\bigsize\textbf{Student Name}}\\
\choosecase{\normal(\textbf{Roll No.})}\par
%\choosecase{\normal\textbf{Under the Supervision of}}
\par


\par
%\begin{center}
 %  \includegraphics[width=5cm, height=5cm]{JSSLOGO.png} 
%\end{center}
\par
%\choosecase{to the}\par
\choosecase{\textbf{Department of Computer Science and Engineering }}\\
\choosecase{\textbf{ JSS ACADEMY OF TECHNICAL EDUCATION\\ C-20/1, SECTOR-62, NOIDA}}\\
\choosecase{\size\textbf{December, 2023}}
\par

%\choosecase{of}
%\par
%\choosecase{\@degree}\\
%\\
%\par
%at the
%\par

%\par\MIT\par
%\@degreemonth\ \@degreeyear
%\par
%\@copyrightnotice
%\par
%\vskip 2\baselineskip
%\signature{}{\@author \\ \@department \\ %\@thesisdate}
%\par
%\vfill
%\vfill
%\unvbox\@titlesupervisor
%\par
%\vfill
%\signature{Accepted by}{\@chairmanname \\ \@chairmantitle}
%\vfill
\end{titlepage}}

% this environment should probably be called abstract,
% but we want people to also be able to get at the more
% basic abstract environment
\def\abstractpage{
\begin{center}{\large{\bf \@title} \\(Dr. Vimal Gupta)
%by \\
\@author 
\\[\baselineskip]}
\par
\def\baselinestretch{1}\@normalsize
%Submitted to the \@department \\
%on \@thesisdate, in partial fulfillment of the \\
%requirements for the \@degreeword\ of \\
%\@degree
\end{center}
\par
\begin{abstract}}

%% Changed from \unvbox to \unvcopy for use with multiple copies of abstract
%% page.
%% Krishna Sethuraman (1990)
%\def\endabstractpage{\end{abstract}\noindent
% \unvcopy\@abstractsupervisor\newpage }

%% This counter is used to save the page number for the second copy of
%% the abstract.
\newcounter{savepage}

\def\titlepage{\cleardoublepage\centering
  \thispagestyle{}
  \parindent 0pt \parskip 10pt plus 1fil minus 1fil
  \def\baselinestretch{1}\@normalsize\vbox to \vsize\bgroup\vbox to 9in\bgroup}
% The \kern0pt pushes any depth into the height.  Thanks to Richard Stone.
\def\endtitlepage{\par\kern 0pt\egroup\vss\egroup\newpage}

\def\abstract{\section*{\size ABSTRACT}\small\def\baselinestretch{1}\@normalsize}

\def\endabstract{\par}


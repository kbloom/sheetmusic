\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{songbook}[2026/02/10 Song book made up of sheet music PDFs from MuseScore]

\LoadClass{memoir}

\RequirePackage{pdfpages}
\RequirePackage{polyglossia}
\RequirePackage{hyperref}
\RequirePackage{ifoddpage}
\RequirePackage{veelo-title}
\RequirePackage{fontspec}

\setmainfont{Frank Ruehl CLM}
\setmonofont{Miriam Mono CLM}
\setsansfont{Simple CLM}

\setsecnumdepth{none}

% Work around broken \nameref interaction between memoir and hyperref
% from https://tex.stackexchange.com/a/648577
\RenewDocumentCommand\nameref{s}
    {\IfBooleanTF{#1}{\@namerefstar}{\T@nameref}}

\makepagestyle{musicbook}
\makeevenfoot{musicbook}{\thepage}{}{}
\makeoddfoot{musicbook}{}{}{\thepage}
\setlength{\headwidth}{\paperwidth}
\makerunningwidth{musicbook}{\headwidth}
\aliaspagestyle{chapter}{musicbook}


\setdefaultlanguage{english}
\setotherlanguage{hebrew}

% Takes 2 arguments
%  #1: The display name for the table of contents
%  #2: The PDF file to include. This PDF name is used as a label for cross references.
\NewDocumentCommand{\song}{m m}{\includepdf[pages=-,offset=3mm 0,pagecommand={\thispagestyle{musicbook}},addtotoc={1,section,1,#1,#2}]{#2}}

\NewDocumentCommand{\songref}{m}{\nameref{#1}, page \pageref{#1}}

\DeclareKeys[facingpages]{
   onepage .store = \fp@onepage ,
   twopage .store = \fp@twopage ,
}
\NewDocumentCommand{\forcefacingpages}{m}{%
   \SetKeys[facingpages]{#1}
   \checkoddpage
   \ifoddpage
     \fp@onepage
     \fp@twopage
   \else
     \fp@twopage
     \fp@onepage
   \fi
}

\usepackage{enumitem}
\setlist[itemize,1]{label={\fontfamily{cmr}\fontencoding{T1}\selectfont\textbullet}}

\chapterstyle{veelo-title}




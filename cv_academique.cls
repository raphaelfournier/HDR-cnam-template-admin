% Classe pour produire un CV académique pour recrutement
% Auteur : Guillaume Cabanac (cabanac@irit.fr), à partir d'un code de Cécile Favre (cecile.favre@univ-lyon2.fr)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv_academique}[2008/12/22 CV académique]
%\LoadClass[a4paper,twoside]{article}
\LoadClass[a4paper,11pt]{article}

% pour inclure des pdf avec un version récente
%\RequirePackage{ifpdf}
%\ifpdf
	%\pdfminorversion=6
%\fi
%\pdfminorversion 6

%<<< Packages

\usepackage[T1]{fontenc}
\usepackage[TS1,T1]{fontenc} % load TS1 so luainputenc will know
\usepackage{luacode}
\usepackage[utf8]{luainputenc}
\usepackage{newunicodechar}
\newunicodechar{⋅}{\cdot}

%\usepackage{fontspec}
%\usepackage[charter]{mathdesign}  % sets the math font
%\usepackage{XCharter}
%\usepackage{fontspec}
%\setmainfont{Charis SIL}  
%\usepackage[utf8]{inputenc}
%%\usepackage{cite}
\usepackage{amssymb}
\usepackage[cmex10]{amsmath}
\usepackage{lmodern,charter,soul,relsize,courier}

\usepackage[DIV=14]{typearea}
\usepackage[english,francais]{babel}
\usepackage[svgnames,x11names]{xcolor} % Maroon, {\color{Blue4} texte}, [svgnames] pour Maroon
%\usepackage[normalem]{ulem}   % uline

% hhline pour faire lignes non continues dans tab. cline ne marchait pas avec colortbl (http://www.tug.org.in/tutorial/chap08-scr.pdf)
\usepackage{graphicx,pifont,lastpage,hhline,tabularx,multicol,colortbl,nextpage,units,arydshln} % \hhline{~*{5}{-}}

%\usepackage[square,sort,comma,numbers]{natbib}
%\usepackage[resetlabels]{multibib}
\usepackage{csquotes}
\usepackage[backend=biber,style=numeric,defernumbers=true]{biblatex}

%\usepackage{natbib,bibunits}
%\usepackage{biblatex}
%\addbibresource{biblio.bib}

%\renewcommand\bibsection{\subsection{\refname}}
%\bibliographyunit[\section]
%\defaultbibliography{publications}
%\defaultbibliographystyle{unsrt_acceptance}

%\setlength{\parindent}{0cm}
%\setlength{\parskip}{6pt}

% (LaTeX Companion, p. 868) les indications "plus" et "minus" permettent d'éviter que les références soient
% coupées (une partie sur une page, l'autre sur la page suivante). Information capitale pr la thèse :)
% Max je t'ai eu !!!! toi qui critiques LaTeX sur ce point-là !!

%\setlength{\bibsep}{8pt plus 4pt minus 4pt}  

% rajout d'un espace vertical après section
\usepackage{titlesec}
\titlespacing*{\section}{0pt}{16pt}{16pt} %gauche-avant-apres
\titlespacing*{\subsection}{0pt}{30pt}{12pt} %gauche-avant-apres
\setcounter{tocdepth}{1}		% un seul niveau hiérarchique dans la TDM
\setcounter{secnumdepth}{-2}	% titres non numérotés avec \section, mais présents quand même dans la TDM (p. 26) 

%\setlength{\fboxrule}{2pt}

%\usepackage[hyphens]{url}
\usepackage{xspace}
\usepackage[autolanguage,np]{numprint}
\usepackage[tight,footnotesize]{subfigure}
\usepackage{calc}
\usepackage{multirow}
\usepackage{array}
\usepackage{comment}
\usepackage[framemethod=TikZ]{mdframed}
%\usepackage[textwidth=5cm,textsize=footnotesize,backgroundcolor=red!40,linecolor=red!40,colorinlistoftodos]{todonotes}

\usepackage{pdfpages} % permet d'inclure des PDF entiers avec la commande \includepdf

% ne marche pas 
%\DeclareGraphicsExtensions{.pdf,.jpg}

\usepackage[
	%pdftitle={Curriculum vitae académique de Guillaume Cabanac},
	%pdfauthor={Guillaume Cabanac, docteur en informatique},
	%pdfsubject={Curriculum vitae académique de Guillaume Cabanac},
	pdfkeywords={document, organisation, annotation.},
%	pdfpagelayout=TwoColumnRight
]{hyperref}
%>>>

%<<< Variables
\newcommand{\pageXsurY}{{\small\upshape page {\thepage} sur \pageref{LastPage}}}

% numérotation des pages. Comme le document n'est pas twoside, il n'y a pas de distinction
% entre even foot et odd foot => j'ai mis la meme commande pr les deux (cf. TC227)
\makeatletter
	\newcommand{\ps@numerotationPages}{%
		\renewcommand{\@evenfoot}{\pageXsurY\hfil}
		\renewcommand{\@oddfoot}{\hfil\pageXsurY}}
	\newcommand{\ps@numerotationVersion}{\renewcommand{\@oddfoot}{\hfil{\small version du \today}}}
	\newcommand{\ps@numerotationPagesEncadree}{%
		\renewcommand{\@evenfoot}{\fcolorbox{black}{lightgray}{\textbf{\pageXsurY}\hfil}}
		\renewcommand{\@oddfoot}{\hfil\fcolorbox{black}{lightgray}{\textbf{\pageXsurY}}}}
\makeatother

% espace entre les lignes d'un tableau
\newlength{\eol}\setlength{\eol}{10pt}
\setlength{\extrarowheight}{2pt}

\newcommand{\ligne}[1]{\rule[0.4ex]{\textwidth}{#1}\\}

\newenvironment{entree}[1]
	{\hspace{3mm}\noindent{\large\textsf{#1}}\\\ligne{0.1mm}}
	{\vspace{5mm}}

\newenvironment{entreeTab}[1]
	{\subsection{#1}\begin{tabular}{p{2.7cm}p{0.2cm}p{12cm}}}
	{\end{tabular}}

\newcommand{\ligneEntreeTab}[2]{\textsf{#1} & & #2\\[4pt]}

\newcommand{\publis}[2]{%
	\begin{bibunit}
		\renewcommand{\refname}{#1}
		\renewcommand\bibsection{\subsection{\refname}}
		\nocite{#2}
		{\small\putbib}
	\end{bibunit}
}

% ------------------- Enseignements ---------------------------------------
\newenvironment{enseignements}
	{\noindent\begin{tabularx}{\linewidth}{>{\sffamily}l>{\sffamily}lX}}
	{\end{tabularx}}
	
\newcommand{\enseignement}[7]{%
	#1 & \multicolumn{2}{l}{\textsc{#2}}\\
	   & formation & #3\\
	   & responsable & #4\\
	   & charge & #5\\
	   & contenu & #6\\
      & implication & #7\\[\eol]}

\newcommand{\enseignementSansImplication}[6]{%
	#1 & \multicolumn{2}{l}{\textsc{#2}}\\
	   & formation & #3\\
	   & responsable & #4\\
	   & charge & #5\\
	   & contenu & #6\\[\eol]}

%\cline{2-3}

% ------------------- Stagiaires ---------------------------------------
\newcommand{\stagiaire}[5]{%
	#1 & \multicolumn{2}{l}{\textsc{#3}}\\
	{\small\emph{#2}}   & stagiaire & #4\\
	   			& réalisation & #5\\[\eol]}

% -------------------- Lettres -------------------------------------------
\newcommand{\encadrer}[3]{%
\clearpage\subsection{#3}\label{#1}
\enlargethispage{3\baselineskip}
\begin{figure}[!b]\centering
	\fbox{\includegraphics[width=.965\linewidth]{#2}}
\end{figure}}

\newcommand{\inclure}[3]{%
\label{#1}
\includepdf[noautoscale=true,pagecommand={\thispagestyle{numerotationPagesEncadree}},pages=-]{#2}
}

% \cleardoublepage ne marche qu'avec la classe report. Or ici c'est la classe article
% Il a donc fallu trouver un moyen de sauter une page...
%\renewcommand{\cleardoublepage}{\cleartooddpage[\thispagestyle{empty}]}

\newenvironment{listeDecalee}[1]
{	\begin{flushright}
		\begin{minipage}{#1\linewidth}
			\begin{itemize}
}
{			\end{itemize}
		\end{minipage}
	\end{flushright}
}

\newcommand{\anglais}[1]{\selectlanguage{english}#1\selectlanguage{francais}}
%>>>

% vim: set fdm=marker fmr=<<<,>>> fdl=0:

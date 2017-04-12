\ProvidesClass{materialcv}[2017/04/02 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

% Packages
\RequirePackage{fontspec}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{pagecolor}
\RequirePackage{tikz}
\usetikzlibrary{shadows.blur}
\RequirePackage[absolute, overlay]{textpos}
\RequirePackage[top=.25cm, bottom=.25cm, left=6.75cm, right=.25cm, nohead, nofoot]{geometry}
\RequirePackage{array}
\RequirePackage{ifthen}
\RequirePackage{graphicx}
\RequirePackage[breakable]{tcolorbox}
\tcbuselibrary{skins}
\RequirePackage{multirow}

% Fonts
\setmainfont{Roboto}

\DeclareGraphicsExtensions{.pdf,.png,.jpg}

\RequirePackage{hyperref}
\hypersetup{
	pdftitle={},
	pdfauthor={},
	pdfsubject={},
	pdfkeywords={CV, candidate, HR},
	hidelinks
}

% Material Color Palette
\definecolor{red500}{HTML}{F44336}
\definecolor{pink500}{HTML}{E91E63}
\definecolor{purple500}{HTML}{9C27B0}
\definecolor{deeppurple500}{HTML}{673AB7}
\definecolor{indigo500}{HTML}{3F51B5}
\definecolor{blue500}{HTML}{2196F3}
\definecolor{lightblue500}{HTML}{03A9F4}
\definecolor{cyan500}{HTML}{00BCD4}
\definecolor{teal500}{HTML}{009688}
\definecolor{green500}{HTML}{4CAF50}
\definecolor{lime500}{HTML}{CDDC39}
\definecolor{yellow500}{HTML}{FFEB3B}
\definecolor{amber500}{HTML}{FFC107}
\definecolor{orange500}{HTML}{FF9800}
\definecolor{deeporange500}{HTML}{FF5722}
\definecolor{brown500}{HTML}{795548}
\definecolor{grey500}{HTML}{9E9E9E}
\definecolor{bluegrey500}{HTML}{607D8B}
\definecolor{grey400}{HTML}{BDBDBD}
\definecolor{grey300}{HTML}{E0E0E0}

\pagecolor{grey400}

\RequirePackage{smartdiagram}
% Thanks to https://www.reddit.com/user/TransientEmber who contributed the code to automatically exclude the \hlcolor from the list of colors for the bubble diagram
\ExplSyntaxOn
\clist_clear_new:N \g__sd_colors_clist
\NewDocumentCommand{\ColorListExclude}{m}{
	% return all the colors except the one specified
	% 1. Make a list with all the colors
	\clist_gset:Nn \g__sd_colors_clist {
		red500, teal500, yellow500, green500, orange500, indigo500, cyan500, purple500, lime500, deeppurple500, blue500, amber500, pink500, deeporange500, brown500, grey500, lightblue500, bluegrey500
	}
	% Now remove the specified color
	\exp_args:NNx \clist_gremove_all:Nn \g__sd_colors_clist {#1}
	% And, finally, expand to the contents of the list separated by commas
	\exp_args:Nx \smartdiagramset{
		set~color~list = {\clist_use:Nn \g__sd_colors_clist {,}},
	}
}
\ExplSyntaxOff

\smartdiagramset{
	bubble center node font = \footnotesize,
	bubble node font = \footnotesize,
	bubble center node size = 2cm,
	bubble node size = 1.5cm,
	distance center/other bubbles = 5mm,
	distance text center bubble = 5mm,
	bubble center node color = \hlcolor,
	bubble fill opacity = 0.87,
	bubble text opacity = 1,
}

\newcommand{\cvportrait}[1]{\renewcommand{\cvportrait}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvxing}[1]{\renewcommand{\cvxing}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvwebsite}[1]{\renewcommand{\cvwebsite}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvemail}[1]{\renewcommand{\cvemail}{#1}}

\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\tabcolsep}{0pt}
\newlength{\sidebarwidth}
\setlength{\sidebarwidth}{.33\paperwidth}

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}

\newcommand{\profilesection}[1]{%
	{\color{black!38}\hspace{-5mm}\parbox{\sidebarwidth}{\hrulefill}}
	{\color{black!54}\textbf{#1}}

	\vspace{3mm}
}

% Environment to create section cards
\newenvironment{cvsection}[1]{%
		\def\arraystretch{1.75}%
		\begin{tcolorbox}[arc=0pt, grow to left by=1cm, left=1.75cm, enhanced, colback=white, toprule=0mm, rightrule=0mm, bottomrule=0mm, drop fuzzy midday shadow]
			{\Large\color{\hlcolor} #1}

			\vspace{.25cm}
			\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
			\end{tabular*}
		\end{tcolorbox}
}

\newcommand{\cvitem}[5]{%
	\parbox[t]{.155\textwidth}{#1} & \parbox[t]{.83\textwidth}{%
		\textbf{#2} \hfill {\footnotesize#3}\\
		\ifblank{#4}{#5}{\ifblank{#5}{{\small #4}}{{\small #4}\\#5}}
	}
}

% Command for printing skill progress bars
\newcommand\interests[1]{
	\renewcommand{\interests}{
		\begin{tikzpicture}
			\foreach [count=\i] \name/\value in {#1}{
				\draw[fill=grey500,grey500] (0,\i) rectangle (6,\i+0.4);
				\draw[fill=white,\hlcolor](0,\i) rectangle (\value,\i+0.4);
				\node [above right] at (0,\i+0.4) {\name};
			}
		\end{tikzpicture}
	}
}

% Adjusts the size of the wheel:
\def\innerradius{1cm}
\def\outerradius{3cm}

% Command for printing the language circle diagram
\newcommand{\languages}[1]{
	\renewcommand{\languages}{
		\pgfmathsetmacro{\totalnum}{0}
		\foreach \value/\colour/\name in {#1} {
			\pgfmathparse{\value+\totalnum}
			\global\let\totalnum=\pgfmathresult
		}
		\begin{tikzpicture}
			\clip[draw=none] (0,0) circle (\outerradius);
			\pgfmathsetmacro{\wheelwidth}{\outerradius-\innerradius}
			\pgfmathsetmacro{\midradius}{(\outerradius+\innerradius)/2}
			\begin{scope}[rotate=90]
				\pgfmathsetmacro{\cumnum}{0}
				\foreach \value/\colour/\name in {#1} {
					\pgfmathsetmacro{\newcumnum}{\cumnum + \value/\totalnum*360}
					\pgfmathsetmacro{\percentage}{\value/\totalnum*100}
					\pgfmathsetmacro{\midangle}{-(\cumnum+\newcumnum)/2}
					\pgfmathparse{(-\midangle<180?"west":"east")}
					\edef\textanchor{\pgfmathresult}
					\fill[\colour!87] (-\cumnum:\outerradius) arc%
					(-\cumnum:-(\newcumnum):\outerradius) -- (-\newcumnum:\innerradius) arc%
					(-\newcumnum:-(\cumnum):\innerradius) -- cycle;
					\draw (\midangle:\midradius pt) node {\textbf{\name}};
					\global\let\cumnum=\newcumnum
				}
			\end{scope}
			%\draw[grey500!87] (0,0) circle (\outerradius) circle (\innerradius);
		\end{tikzpicture}
	}
}

\newcommand{\makeprofile}{
	\begin{tikzpicture}[remember picture,overlay]
		\node [rectangle, fill=grey300, anchor=north west, minimum width=\sidebarwidth,%
		minimum height=\paperheight, blur shadow={shadow blur steps=16,shadow xshift=0pt,%
		shadow yshift=-5mm, shadow blur radius=.5cm}] (sidebar) at (current page.north west){};%
	\end{tikzpicture}
	\begin{textblock}{6}(.5, .5)
		\ifthenelse{\equal{\cvportrait}{}}{
			{\Huge\color{\hlcolor}\cvname}
		}{% Possibly portrait and name
			\begin{tabular}{m{.3\textwidth} @{\hskip .04\textwidth} m{.6\textwidth}}
			\begin{tikzpicture}
				\clip[draw=none] (0,0) circle (.5\hsize);
				\node (portrait) at (0,0){\includegraphics[width=\hsize]{\cvportrait}};
			\end{tikzpicture}
			& {\Huge\color{\hlcolor}\cvname}
			\end{tabular}
		}

		% Job title
		\vspace{2mm}
		{\Large\color{black!54}\cvjobtitle}

		% Contact data
		\vspace{5mm}
		\begin{tabular}{m{.15\textwidth} @{\hskip .05\textwidth} m{.75\textwidth}}
			\ifthenelse{\equal{\cvlinkedin}{}}{}{%
				\includegraphics[width=\hsize]{img/linkedin} &%
				\href{\cvlinkedin}{/\StrBehind[3]{\cvlinkedin}{/}}\\%
			}
			\ifthenelse{\equal{\cvxing}{}}{}{%
				\includegraphics[width=\hsize]{img/xing} &%
				\href{\cvxing}{/\StrBehind[3]{\cvxing}{/}}\\%
			}
			\ifthenelse{\equal{\cvnumberphone}{}}{}{%
				\includegraphics[width=\hsize]{img/phone} & \cvnumberphone\\%
			}
			\ifthenelse{\equal{\cvwebsite}{}}{}{%
				\includegraphics[width=\hsize]{img/web} &%
				\href{\cvwebsite}{\StrBehind[2]{\cvwebsite}{/}}\\%
			}
			\ifthenelse{\equal{\cvaddress}{}}{}{%
				\includegraphics[width=\hsize]{img/location} & \cvaddress\\%
			}
			\ifthenelse{\equal{\cvemail}{}}{}{%
				\includegraphics[width=\hsize]{img/email} & \href{mailto:\cvemail}{\cvemail}\\%
			}
		\end{tabular}

		\profilesection{Skills}
		\ColorListExclude{\hlcolor}
		\resizebox{\textwidth}{!}{\skills}

		\profilesection{Interests}
		\interests

		\profilesection{Languages}
		\languages
	\end{textblock}
}

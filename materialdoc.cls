\ProvidesClass{materialdoc}[2020/10/01 Material document class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

% Packages
\RequirePackage{fontspec}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{pagecolor}
\RequirePackage{tikz}
\usetikzlibrary{shadows.blur}
\RequirePackage[absolute, overlay]{textpos}
\RequirePackage[margin=.25cm, nohead, nofoot]{geometry}
\RequirePackage{array}
\RequirePackage{ifthen}
\RequirePackage[breakable]{tcolorbox}
\tcbuselibrary{skins}

% Fonts
\setmainfont{Roboto}

\DeclareGraphicsExtensions{.pdf,.png,.jpg}

\RequirePackage{hyperref}
\hypersetup{
	pdftitle={},
	pdfauthor={},
	pdfsubject={},
	pdfkeywords={cover letter, candidate, HR},
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

\setlength{\parindent}{0pt}
\setlength{\tabcolsep}{0pt}
\newlength{\headerheight}
\setlength{\headerheight}{5cm}

\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\setlength{\parskip}{\baselineskip}

\newcommand{\cvportrait}[1]{\renewcommand{\cvportrait}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvemail}[1]{\renewcommand{\cvemail}{#1}}

\newcommand{\makeheader}{
	\begin{tikzpicture}[remember picture,overlay]
		\node [rectangle, fill=grey300, anchor=north west,%
		minimum width=\paperwidth, minimum height=\headerheight,%
		blur shadow={shadow blur steps=16, xshift=-.5cm, yshift=-2.5cm,%
		shadow blur radius=.5cm}] (header) at (current page.north west){};
	\end{tikzpicture}
	\begin{textblock}{8}(.5, .5)
		\ifthenelse{\equal{\cvportrait}{}}{
			{\Huge\color{\hlcolor}\cvname}
		}{% Possibly portrait and name
			\begin{tabular}{m{2cm} @{\hskip .04\textwidth} m{5cm}}
			\begin{tikzpicture}
				\clip[draw=none] (0,0) circle (.5\hsize);
				\node (portrait) at (0,0){\includegraphics[width=\hsize]{\cvportrait}};
			\end{tikzpicture}
			& {\Huge\color{\hlcolor}\cvname}
			\end{tabular}
		}

		% Job title
		\vspace{2mm}
		{\LARGE\color{black!54}\cvjobtitle}

	% Contact data
	\end{textblock}
	\begin{textblock}{11}(10.5,.5)
		\begin{tabular}{r @{\hskip .03\textwidth} m{1.1cm}}
			{\large\cvnumberphone} & \includegraphics[width=\hsize]{img/phone}\\%
			{\large\cvaddress} & \includegraphics[width=\hsize]{img/location}\\%
			{\large\href{mailto:\cvemail}{\cvemail}} & \includegraphics[width=\hsize]{img/email}\\%
		\end{tabular}
	\end{textblock}
}

\pagestyle{empty}

\newenvironment{content}{
	\begin{tcolorbox}[arc=0pt, enhanced, breakable, colback=white,%
		boxrule=0mm, drop fuzzy midday shadow, height fill=maximum,%
		height fixed for=all]
}{
	\end{tcolorbox}
}
\AtBeginDocument{
	\begin{tcolorbox}[arc=0pt, enhanced, breakable, colback=white,%
		boxrule=0mm, drop fuzzy midday shadow, height fill=maximum,%
		height fixed for=all]
}
\AtEndDocument{\end{tcolorbox}}

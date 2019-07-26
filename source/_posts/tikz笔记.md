---
title: tikz笔记
updated: 1556721524
date: 2019-03-21 21:16:17
tags:
 - latex
---

overleaf:`https://www.overleaf.com/learn/latex/LaTeX_Graphics_using_TikZ:_A_Tutorial_for_Beginners_(Part_3)%E2%80%94Creating_Flowcharts`

<embed src="venn.pdf#zoom=100&scrollbar=0&toolbar=0" class="tikz_sample">

```tex
\begin{tikzpicture}[very thick]
\draw[style={draw=blue!50, fill=blue!20,}] (0,0) ellipse [x radius=2cm, y radius=2cm];
\coordinate [label=center:{$G$}] (A) at (-1.2,0);
\draw[style={draw=red!50, fill=red!20, opacity=0.7,}] (0.2,-0.7) ellipse [x radius=1.2cm, y radius=1.1cm];
\coordinate [label=center:{$N$}] (A) at (0.2,-0.9);
\draw[style={draw=green!50, fill=green!20, opacity=0.7,}] (0.2,0.7) ellipse [x radius=1.2cm, y radius=1.1cm];
\coordinate [label=center:{$H$}] (A) at (0.2,0.9);
\coordinate [label=center:{$H\cap N$}] (A) at (0.2,0);
\end{tikzpicture}
```

<embed src="graph.pdf#zoom=100&scrollbar=0&toolbar=0" class="tikz_sample">

```tex
\begin{tikzpicture}[
%overlay, remember picture
]
\coordinate (a0) at (  0.3, 0.2);
\coordinate (b0) at (  3.3, 1.2);
\coordinate (c0) at (  4.1,-1.3);
\coordinate (d0) at (  8.1,-0.3);
\draw (c0) -- (a0);
\draw (c0) -- (d0);
\draw[style={draw=green!50, fill=green!20,}](a0)ellipse[radius=1];
\draw[style={draw=green!50, fill=green!20,}](b0)ellipse[radius=1];
\draw[style={draw=green!50, fill=green!20,}](c0)ellipse[radius=1.3];
\draw[style={draw=green!50, fill=green!20,}](d0)ellipse[radius=1.3];

%\draw[style={draw=red!50, fill=red!20,}] (2,-4) ellipse [radius=0.2];
%\coordinate [label=center:{表示牛逼的点}] (info1) at (2,-5);
%\draw[style={draw=blue!50, fill=blue!20,}] (8,-4) ellipse [radius=0.2];
%\coordinate [label=center:{表示不牛逼的点}] (info2) at (8,-5);
\coordinate (a1) at ( 0  , 0  );
\coordinate (b1) at ( 0  , 0.7);
\coordinate (c1) at ( 0.8, 0.5);
\coordinate (d1) at ( 0.5,-0.2);
\draw (a1) -- (b1);
\draw (a1) -- (c1);
\draw (a1) -- (d1);
\coordinate (a2) at ( 0  +3, 0  +1);
\coordinate (b2) at ( 0  +3, 0.7+1);
\coordinate (c2) at ( 0.8+3, 0.5+1);
\coordinate (d2) at ( 0.5+3,-0.2+1);
\draw (a2) -- (b2);
\draw (a2) -- (c2);
\draw (a2) -- (d2);
\coordinate (a3) at (-3.9+8,-1.1);
\coordinate (b3) at (-3.2+8,-2.0);
\coordinate (c3) at (-4.5+8,-0.9);
\coordinate (d3) at (-4.4+8,-2.1);
\coordinate (e3) at (-3.0+8,-1.1);
\draw (a3) -- (b3);
\draw (a3) -- (c3);
\draw (a3) -- (d3);
\draw (a3) -- (e3);
\coordinate (a4) at (12-3.9,-1.1+1);
\coordinate (b4) at (12-3.2,-2.0+1);
\coordinate (c4) at (12-4.5,-0.9+1);
\coordinate (d4) at (12-4.4,-2.1+1);
\coordinate (e4) at (12-3.0,-1.1+1);
\draw (a4) -- (b4);
\draw (a4) -- (c4);
\draw (a4) -- (d4);
\draw (a4) -- (e4);

\draw[style={draw=blue!50, fill=blue!20,}](a1)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](b1)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](c1)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](d1)ellipse[radius=0.2];

\draw[style={draw= red!50, fill= red!20,}](a2)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](b2)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](c2)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](d2)ellipse[radius=0.2];

\draw[style={draw= red!50, fill= red!20,}](a3)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](b3)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](c3)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](d3)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](e3)ellipse[radius=0.2];

\draw[style={draw=blue!50, fill=blue!20,}](a4)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](b4)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](c4)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](d4)ellipse[radius=0.2];
\draw[style={draw=blue!50, fill=blue!20,}](e4)ellipse[radius=0.2];
\end{tikzpicture}
```

<embed src="arrow_label.pdf#zoom=100&scrollbar=0&toolbar=0" class="tikz_sample">

 - [label参考](https://tex.stackexchange.com/questions/354191/label-following-arrow-in-tikz)
 - [label位置](https://tex.stackexchange.com/questions/58878/tikz-set-node-label-position-more-precisely)

```tex
\begin{tikzpicture}[
a/.style={circle,draw=blue!50,fill=blue!20,very thick,minimum size=10mm},
b/.style={circle,draw=green!50,fill=green!20,very thick,minimum size=10mm}
]
\node[a,label={[shift={(0,-2)}]1}] (n1) at (0, 0){a};
\node[a,label={[shift={(0,-2)}]2}] (n2) at (2, 0){a};
\node[b,label={[shift={(0,-2)}]3}] (n3) at (4, 0){b};
\node[a,label={[shift={(0,-2)}]4}] (n4) at (6, 0){a};
\node[b,label={[shift={(0,-2)}]5}] (n5) at (8, 0){b};
\draw[->,thick](n1) to (n2);
\draw[->,thick](n2) to (n3);
\draw[->,thick](n3) to (n4);
\draw[->,thick](n4) to (n5);
\draw[shorten >= 0pt,->,thick](n2) to[in=150,out=30,loop,looseness=4.8]node[midway,above]{a}(n2);
\draw[->,thick](n4) to[in=-30,out=-150]node[midway,below]{a}(n2);
\end{tikzpicture}
```

```tex
\newfontfamily\DejaVu{DejaVu Sans Mono for Powerline}
\def\Font#1{\fontsize{#1}{\baselineskip}\DejaVu\textbf}
\begin{tikzpicture}[remember picture, overlay]
  \node [shift={(0cm,-3cm)}]  at (current page.north west)
  {%
  \begin{tikzpicture}[remember picture, overlay]
    \draw [fill=gray] (0,3) -- (3,3) -- (0,0) -- cycle ;
    \draw [fill=white] (0,3) -- (2,3) -- (0,1) -- cycle ;
    \draw (0,0) to node[midway, above, rotate=45] {\textcolor{white}{\Font{9}{fork me on github}}} (3,3) ;
    \draw (0,1) to node[midway, above, rotate=45] {\includegraphics[width=.05\textwidth]{pictures/github}} (2,3) ;
  \end{tikzpicture}
  };
\end{tikzpicture}
```

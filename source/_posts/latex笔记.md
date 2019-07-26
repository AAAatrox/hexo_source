---
title: latex笔记
updated: 1554033278
date: 2019-01-20 10:54:38
tags:
 - latex
---

> 以下均只用`CTeX`使用过

## 调整行距，x为倍数

```tex
\renewcommand{\baselinestretch}{x}\normalsize
```

## 修改页边距,[详细](http://blog.sina.com.cn/s/blog_531bb7630101832g.html)

```tex
\usepackage{geometry}
\geometry{a4paper,left=2cm,right=2cm,top=1cm,bottom=1cm}
```

## 页码,[更多](https://blog.csdn.net/japinli/article/details/51418977)

```tex
\pagestyle{type(不要页码就写empty)}
```
### 设置样式

```tex
\thispagestyle{type}
```

## 特定位置横线:

```tex
\cline{x-y}
```

## 合并行?

```tex
\multirow{num}{width(通常为*)}{文字} (要\usepackage{multirow})
```

## 下几行被合并的内容`~`?

```tex
和并列\multicolumn{num}{|c|(这里是格式吗)}{文字}
```

## 调整表格行距的骚操作:

```tex
\usepackage{booktabs}
\specialrule{0em}{0pt}{3pt}
{线宽}{与上方距离}{与下方距离}(线宽为0则透明)
```

## `section`取消标号同时保持链接(用一次即可)

```tex
\setcounter{secnumdepth}{-number}
```

## 颜色网站[colors](http://latexcolor.com/)

```tex
\definecolor{brightpink}{rgb}{1.0, 0.0, 0.5}
```
### 背景颜色

```tex
\pagecolor{ao}
\pagecolor[rgb]{0.0 0.0 0.0}
```

## 正文取消缩进

```tex
\raggedright
```
## `section`取消缩进

```tex
\CTEXsetup[format={\Large\bfseries}]{section}
```
### 不要用`bftext`

## 链接(任意)

```tex
\hyperlink{target}{show}
\hypertarget{target}{show}
```
### 设定(`tableofcontents`到`section`)

```tex
\usepackage[colorlinks,linkcolor=green,anchorcolor=blue,citecolor=green,CJKbookmarks=True]{hyperref}
\tableofcontents
```

## 超链接

[overleaf](https://www.overleaf.com/learn/latex/Hyperlinks)

 ---

> 以下经过`TexLive`使用过

## 页面大小与页边距

```tex
\usepackage{geometry}
\special{papersize=1cm,1cm}
\begin{document}
...
```

## 插入c代码

```tex
\usepackage{listings}
\usepackage{fontspec}
\newfontfamily\DejaVu{DejaVu Sans Mono for Powerline}
\def\codes{\DejaVu\small}
\lstset{
    language={[ANSI]C},
    %行号
    numbers=left,
    rulesepcolor=\color{red!20!green!20!blue!20},
    escapeinside=``,
    %背景色
    %backgroundcolor=\color[RGB]{245,245,244},
    %样式
    basicstyle=\codes,
    keywordstyle=\color{blue}\bf\codes,
    identifierstyle=\bf\codes,
    numberstyle=\color[RGB]{0,192,192}\bf\codes,
    commentstyle=\color[RGB]{96,96,96}\codes,
    stringstyle=\color[RGB]{128,0,0}\codes,
    %显示空格
    showstringspaces=false
    extendedchars=false %这一条命令可以解决代码跨页时，章节标题，页眉等汉字不显示的问题
}
```

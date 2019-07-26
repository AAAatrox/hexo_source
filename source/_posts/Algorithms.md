---
title: Algorithms
updated: 1560857979
date: 2019-03-30 10:13:19
tags:
categories:
 - 问题求解
latex:
 - 2
---

## 31 数论算法

### 31.3 模运算

#### 欧拉函数

$\mathbb{Z}\_n^\*$的规模表示为$\phi(n)$,称为**欧拉phi函数**,满足下式
$$\phi(n)=n\prod\_{\text{$p:p$是素数且$p|n$}}(1-\dfrac{1}{p})$$

### 31.4 求解模线性方程

#### 定理 31.20

对任意正整数$a$和$n$,如果$d=\gcd(a,n)$,则在$\mathbb{Z}\_n$中
$$\langle a\rangle=\langle d\rangle=\\{0,d,2d,...,((n/d)-1)d\\}$$
因此$|\langle a\rangle|=n/d$

#### 推论 31.21

当且仅当$d|b$时,方程$ax\equiv b(\mod n)$对于未知量$x$有解,这里$d=\gcd(a,n)$

#### 推论 31.22

方程$ax\equiv b(\mod n)$
- 或者对模$n$有$d$个不同的解
- 或者无解
这里$d=\gcd(a,n)$

#### 定理 31.23

令$d=\gcd(a,n)$,假设对某些整数$x'$和$y'$,有$d=ax'+ny'$(例如Extended-Euclid所计算出的结果).如果$d|b$,则方程$ax\equiv b(\mod n)$有一个解的值为$x\_0$,这里
$$x\_0=x'(b/d)\mod n$$

#### 定理 31.24

假设方程$ax\equiv b(\mod n)$有解(即$d|b$,这里$d=\gcd(a,n)$),且$x\_0$是该方程的任意一个解.因此,该方程对模$n$恰有$d$个不同的解,分别为$x\_i=x\_0+i(n/d),i=0,1,...,d-1$

#### 推论 31.25

对任意$n>1$,如果$\gcd(a,n)=1$,则方程$ax\equiv b(\mod n)$对模$n$有唯一解

#### 推论 31.26

对任意$n>1$,如果$\gcd(a,n)=1$,则方程$ax\equiv1(\mod n)$对模$n$有唯一解;否则方程无解

### 31.5 中国余数定理

#### 定理 31.27 中国余数定理

令$n=n\_1n\_2...n\_k$,其中因子$n\_i$两两互质.考虑以下对应关系
$$a\leftrightarrow(a\_1,a\_2,...,a\_k)\qquad(31.27)$$
这里$a\in\mathbb{Z}\_n,a\_i\in\mathbb{Z}\_{n\_i}$,而且对$i=1,2,...,k$
$$a\_i=a\mod n\_i$$
因此映射(31.27)是一个在$\mathbb{Z}\_n$与笛卡尔积$\mathbb{Z}\_{n\_1}\times\mathbb{Z}\_{n\_2}\times...\times\mathbb{Z}\_{n\_k}$之间的双射.通过在合适的系统中对每个坐标位置独立地执行操作,对$\mathbb{Z}\_n$中元素所执行的运算可以等价地作用于对应的$k$元组.也就是说,如果
$$a\leftrightarrow(a\_1,a\_2,...,a\_k)$$
$$b\leftrightarrow(b\_1,b\_2,...,b\_k)$$
那么
$$(a+b)\mod n\leftrightarrow((a\_1+b\_1)\mod n\_1,...,(a\_k+b\_k)\mod n\_k)$$
$$(a-b)\mod n\leftrightarrow((a\_1-b\_1)\mod n\_1,...,(a\_k-b\_k)\mod n\_k)$$
$$(ab)\mod n\leftrightarrow((a\_1b\_1)\mod n\_1,...,(a\_kb\_k)\mod n\_k)$$

#### 推论 31.28

如果$n\_1,n\_2,...,n\_k$两两互质,且$n=n\_1n\_2...n\_k$,则对任意整数$a\_1,a\_2,...,a\_k$,关于未知量$x$的联立方程组
$$x\equiv a\_i(\mod n\_i),i=1,2,...,k$$
对模$n$有唯一解

#### 推论 31.29

如果$n\_1,n\_2,...,n\_k$两两互质,$n=n\_1n\_2...n\_k$,则对所有整数$x$和$a$
$$x\equiv a(\mod n\_i)$$
(其中$i=1,2,...,k$)当且仅当
$$x\equiv a(\mod n)$$

### 31.6 元素的幂

#### 定理 31.30 欧拉定理

对于任意整数$n>1,a^{\phi(n)}\equiv1(\mod n)$对所有$a\in\mathbb{Z}\_n^\*$都成立

#### 定理 31.31 费马定理

如果$p$是素数,则$a^{p-1}\equiv1(\mod p)$对所有$a\in\mathbb{Z}\_p^\*$都成立

#### 定理 31.32

> 如果ord$\_n(g)=|\mathbb{Z}\_n^\*|$,则对模$n,\mathbb{Z}\_n^\*$中的每个元素都是$g$的一个幂,且$g$是$\mathbb{Z}\_n^\*$的一个**原根**或**生成元**.如果$\mathbb{Z}\_n^\*$包含一个原根,就称$\mathbb{Z}\_n^\*$是**循环的**

对所有的素数$p>2$和所有正整数$e$,使得$\mathbb{Z}\_n^\*$是循环群的$n>1$的值为$2,4,p^e,2p^e$

#### 定理 31.33 离散对数定理

如果$g$是$\mathbb{Z}\_n^\*$的一个原根,则当且仅当等式$x\equiv y(\mod\phi(n))$成立时,有等式$g^x\equiv g^y(\mod n)$成立

#### 定理 31.34

如果$p$是一个奇素数且$e\ge1$,则方程
$$x^2\equiv1(\mod p^e)$$
仅有两个解,即$x=1,x=-1$

#### 推论 31.35

如果对模$n$存在1的非平凡平方根,则$n$是合数

## 34 NP完全性

### 34.4 NP完全性的证明

#### 引理 34.8

如果语言$L$是一种满足对任意$L\in$NPC都有$L'\le\_PL$的语言,则$L$是NP难度的.此外,如果$L\in$NP,则$L\in$NPC

#### 公式可满足性

$$ SAT=\\{\langle\varphi\rangle: \text{$\varphi$是一个可满足的布尔公式}\\} $$

#### 3-CNF-SAT 3-CNF可满足性

布尔公式中的一个**文字**(literal)是指一个变量或变量的非.如果一个布尔公式可以表示为所有子句的与,并且每个子句都是一个或多个文字的或,则该布尔公式为**合取范式**,CNF(conjunctive normal form).如果公式中每个子句恰好都有三个不同的文字,则称该布尔公式为3**合取范式**,3-CNF,例如
$$ (x\_1\vee\lnot x\_1\vee\lnot x\_2)\wedge(x\_3\vee x\_2\vee x\_4)\wedge(\lnot x\_1\vee\lnot x\_3\vee\lnot x\_4) $$
就是一个3合取范式,第一个子句包含3个文字$x\_1,\lnot x\_1$和$\lnot x\_2$

---
title: Discrete Mathematics for CS
updated: 1554034967
date: 2019-03-30 21:34:48
tags:
categories:
 - 问题求解
---

### 2.2 Inverses and Greatest Common Divisors

#### Lemma 2.8

The equation 
$$ a{\cdot}\_nx = 1 $$ 
has a solution in $\mathbb{Z}\_{n}$ if and only there exist integers $x$ and $y$ such that
$$ ax + ny = 1 $$

#### Corollary 2.10

If $a\in\mathbb{Z}\_{n}$ and $x$ and $y$ are integers such that $ax + ny = 1$, then the multiplicative inverse of $a$ in $\mathbb{Z}\_{n}$ is $x$ mod $n$

#### Lemma 2.11

Given $a$ and $n$, if there exist integers $x$ and $y$ such that $ax+ny=1$, then $\gcd(a,n)=1$

#### Lemma 2.13

If $j,k,q$, and $r$ are positive integers such that $k=jq+r$, then
$$ \gcd(j,k) = \gcd(r,j) $$

#### Euclid's extended GCD algorithm

- 本书版

```c
void gcd_cs(int j, int k, int ans[3])// j < k(为什么?)且j, k为正数
{
  int i = 0;
  int q[MAXI], j_arr[MAXI];
  int r = 0;
  if (j == k)
  {
    ans[0] = j, ans[1] = 1, ans[2] = 0;
    return;
  }
  else
    j_arr[i] = j;
  do
  {
    q[i] = k / j_arr[i];// low(k / j[i])
    r = k % j_arr[i];
    k = j_arr[i];
    j_arr[i + 1] = r;
    i ++;
  }
  while (r != 0);
  i --;
  int gcd = j_arr[i];// 已经找到gcd(j, k),现找x, y
  int y[MAXI], x[MAXI];
  y[i] = 0, x[i] = 1;
  i --;
  while (i >= 0)
  {
    y[i] = x[i + 1];
    x[i] = y[i + 1] - q[i] * x[i + 1];
    i --;
  }
  ans[0] = gcd, ans[1] = x[0], ans[2] = y[0];
  return;
}
```

- 算法导论版

```c
void gcd_tc(int a, int b, int ans[3])
{
  if (b == 0)
  {
    ans[0] = a, ans[1] = 1, ans[2] = 0;
    return;
  }
  else
  {
    gcd_tc(b, a % b, ans);
    int temp = ans[1];
    ans[1] = ans[2], ans[2] = temp - (a / b) * ans[2];
    return;
  }
}
```

#### Theorem 2.15

Two positive integers $j$ and $k$ have greatest common divisor 1 iff there are integers $x$ and $y$ such that $hx+ky=1$

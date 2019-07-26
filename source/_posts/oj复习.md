---
title: oj复习
updated: 1560955052
date: 2019-06-16 10:09:03
tags:
categories:
 - 问题求解
---

## 模拟退火

### poj2069


```cpp
#include <stdio.h>
#include <assert.h>
#include <math.h>

const int MAXN = 31;

struct fuck {
  double x, y, z;
} p[MAXN], ans;

int n;
double radius;

void SA();
double dis(fuck a, fuck b);

int main()
{
  int i = 0;
  while (~scanf("%d", &n)) {
    if (n == 0) break;
    for (i = 0; i < n; i ++) {
      scanf("%lf%lf%lf", &p[i].x, &p[i].y, &p[i].z);
    }
    SA();
    printf("%.5lf\n", radius);
  }
  return 0;
}

void SA()
{
  ans.x = ans.y = ans.z = 0;
  int max_p = -1;
  int i = 0;
  for (double t = 100; t > 0.0000001; t *= 0.99) {
    radius = 0;
    for (i = 0; i < n; i ++) {
      double tmp_dis = dis(ans, p[i]);
      if (tmp_dis > radius) {
        max_p = i;
        radius = tmp_dis;
      }
    }
    ans.x -= (ans.x - p[max_p].x) / radius * t;
    ans.y -= (ans.y - p[max_p].y) / radius * t;
    ans.z -= (ans.z - p[max_p].z) / radius * t;
  }
}

double dis(fuck a, fuck b)
{
  return sqrt((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y) + (a.z - b.z)*(a.z - b.z));
}

```

### p4035

```cpp
#include <stdio.h>
#include <assert.h>
#include <math.h>

const int MAXN = 12;

struct fuck {
  double num[MAXN];
} point[MAXN], center, delta;

int n;

void SA();
double dis(fuck a, fuck b);

int main()
{
  int i = 0, j = 0;
  scanf("%d", &n);
  for (i = 0; i < n + 1; i ++) {
    for (j = 0; j < n; j ++) {
      scanf("%lf", &point[i].num[j]);
    }
  }
  SA();
  for (i = 0; i < n; i ++) {
    printf("%.3lf%c", center.num[i], i == n - 1 ? '\n' : ' ');
  }
  return 0;
}

void SA()
{
  int i = 0, j = 0;
  for (i = 0; i < n; i ++) {
    center.num[i] = 0;
  }

  for (double t = 10000; t > 0.0001; t *= 0.99995) {
    double ave = 0;
    double each_dis[MAXN];
    for (i = 0; i < n + 1; i ++) {
      each_dis[i] = dis(center, point[i]);
      ave += each_dis[i];
    }
    ave /= n + 1;

    for (i = 0; i < n; i ++) {
      delta.num[i] = 0;
    }
    for (i = 0; i < n + 1; i ++) {
      for (j = 0; j < n; j ++) {
        delta.num[j] += (ave - each_dis[i]) / (ave) * (center.num[j] - point[i].num[j]);
      }
    }
    for (i = 0; i < n; i ++) {
     center.num[i] += t * delta.num[i];
    }
  }
}

double dis(fuck a, fuck b)
{
  int i = 0;
  double ans = 0;
  for (i = 0; i < n; i ++) {
    ans += (a.num[i] - b.num[i]) * (a.num[i] - b.num[i]);
  }
  return sqrt(ans);
}
```

## 素数判定

### p3383

- 增大步长

```cpp
#include <stdio.h>
#include <assert.h>

int n;

int is_prime(int a);

int main()
{
  scanf("%d%d", &n, &n);
  while (n --) {
    int test = 0;
    scanf("%d", &test);
    printf("%s\n", is_prime(test) ? "Yes" : "No");
  }
  return 0;
}

int is_prime(int a)
{
  if (a == 1) return 0;
  if (a == 2 || a == 3) return 1;
  if ((a % 6 != 1) && (a % 6 != 5)) return 0;
  for (int i = 5; i * i <= a; i += 6) {
    if (a % i == 0) return 0;
    if (a % (i + 2) == 0) return 0;
  }
  return 1;
}
```

- `Miller-Rabin`

```cpp
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int my_exp(long long a, int b, int m);
int MR(int a);

int n;
int num[] = {2, 3, 5, 7, 11, 13, 17, 19};

int main()
{
  scanf("%d%d", &n, &n);
  while (n --) {
    int test = 0;
    scanf("%d", &test);
    printf("%s\n", MR(test) ? "Yes" : "No");
  }
  return 0;
}

int my_exp(long long a, int b, int m)
{// a^b % m
  long long ans = 1;
  while (b) {
    if (b & 1) {
      ans = ans * a % m;
    }
    a = (long long)a * a % m;
    b >>= 1;
  }
  return (int)ans;
}

int MR(int a)
{
  if (a == 1) return 0;// 特判
  // 计算 a - 1 == 2^t * u
  int u = a - 1;
  int t = 0;
  while (u % 2 == 0) {
    u >>= 1;

    t ++;
  }
  assert(u % 2 == 1);
  // witness
  for (int i = 0; i < (int)(sizeof(num) / sizeof(int)); i ++)
  {
    if (a == num[i]) return 1;// 特判
    int x = my_exp(num[i], u, a);
    for (int j = 1; j <= t; j ++) {
      int last = x;
      x = (int)((long long)last * last % a);
      if ((x == 1) && (last != 1) && (last != a - 1)) return 0;
    }
    if (x != 1) return 0;
  }
  return 1;
}
```

### poj3641

```cpp
#include <stdio.h>
#include <assert.h>

long long my_exp(long long a, long long b, long long m);
int MR(long long a);

int p, a;
int num[] = {2, 3, 5, 7, 11, 13, 17, 19};

int main()
{
  while (~scanf("%d%d", &p, &a)) {
    if ((p == 0) && (a == 0)) break;
    if (my_exp(a, p, p) == a && MR(p) == 0) {
      printf("yes\n");
    } else {
      printf("no\n");
    }
  }
  return 0;
}

long long my_exp(long long a, long long b, long long m)
{
  long long ans = 1;
  while (b) {
    if (b & 1) {
      ans = ans * a % m;
    }
    a = a * a % m;
    b >>= 1;
  }
  return ans;
}

int MR(long long a)
{
  if (a == 1) return 0;
  // a - 1 = 2^t * u
  long long u = a - 1;
  int t = 0;
  while (u % 2 == 0) {
    u /= 2;
    t ++;
  }
  assert(u % 2 == 1);
  // witness
  for (int i = 0; i < (int)(sizeof(num)/sizeof(int)); i ++) {
    if (a == num[i]) return 1;
    long long x = my_exp(num[i], u, a);
    for (int j = 0; j < t; j ++) {
      long long last = x;
      x = x * x % a;
      if (x == 1 && last != 1 && last != a - 1) return 0;
    }
    if (x != 1) return 0;
  }
  return 1;
}
```

### hdoj2138

> 多组cases

## KMP

### p3375

```cpp
#include <stdio.h>
#include <string.h>
#include <assert.h>

const int MAXN = 1000001;
const int MAXM = 1000001;

int next[MAXM];
char s1[MAXN];
char s2[MAXM];
int s1_len, s2_len;

void pre();
void kmp();

int main()
{
  scanf("%s%s", s1, s2);
  pre();
  kmp();
  for (int i = 0; i < s2_len; i ++) {
    printf("%d%c", next[i], i == s2_len - 1 ? '\n' : ' ');
  }
  return 0;
}

void pre()
{
  s2_len = strlen(s2);
  int len = 0;
  int i = 1;
  next[0] = 0;
  while (i < s2_len) {
    if (s2[i] == s2[len]) {// 增加长度
      len ++;
      next[i] = len;
      i ++;
    } else {
      while (len > 0) {
        len = next[len - 1];
        if (s2[i] == s2[len]) {
          len ++;
          next[i] = len;
          i ++;
          break;
        }
      }
      if (len == 0) {// 没有找到匹配
        next[i] = len;
        i ++;
      }
    }
  }
}

void kmp()
{
  s1_len = strlen(s1);
  int i = 0, j = 0;
  while (i < s1_len) {
    if (s1[i] == s2[j]) {
      i ++;
      j ++;
      if (j == s2_len) {// 找到匹配
        printf("%d\n", i + 1 - s2_len);
        j = next[j - 1];
      }
    } else {
      int found = 0;
      while (j > 0) {
        j = next[j - 1];
        if (s1[i] == s2[j]) {
          i ++;
          j ++;
          if (j == s2_len) {// 找到匹配
            printf("%d\n", i);
            j = next[j - 1];
            found = 1;
          }
          break;
        }
      }
      if (j == 0 && found == 0) {
        i ++;
      }
    }
  }
}
```

### poj3461

```cpp
#include <string.h>
#include <stdio.h>
#include <assert.h>

const int MAXN = 1000010;

char W[MAXN];
char T[MAXN];
int next[MAXN];
int n;
int wlen, tlen;

void prefix();
void kmp();

int main()
{
  scanf("%d", &n);
  while (n --) {
    scanf("%s%s", W, T);
    prefix();
    kmp();
  }
}

void prefix()
{
  wlen = strlen(W);
  int i = 1, j = 0;
  next[0] = 0;
  while (i < wlen) {
    while (j > 0 && W[j] != W[i]) j = next[j - 1];
    if (W[j] == W[i]) {
      j ++;
      next[i] = j;
    } else {
      next[i] = 0;
    }
    i ++;
  }
}

void kmp()
{
  tlen = strlen(T);
  int i = 0, j = 0;
  int ans = 0;
  while (i < tlen) {
    while (j > 0 && W[j] != T[i]) {
      j = next[j - 1];
    }
    if (W[j] == T[i]) j ++;
    if (j == wlen) {
      ans ++;
      j = next[j - 1];
    }
    i ++;
  }
  printf("%d\n", ans);
}
```

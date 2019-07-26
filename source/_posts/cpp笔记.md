---
title: cpp笔记
updated: 1558353358
date: 2019-01-20 11:04:48
tags:
 - cpp
---

## 二分搜索，默认升序

```cpp
lower_bound(a,a + n,b,cmp)
```

前闭后开`[first, last)`区间进行二分查找，返回大于或等于val的第一个元素位置
如果所有元素都小于val，则返回last的位置，且last的位置是越界的

```cpp
upper_bound(a,a + n,b,cmp)
```

返回序列`[first, last)`中的第一个大于值val的位置

```cpp
binary_search(a,a + n,b,cmp)
```

在已排序的`[first, last)`中寻找元素val，如果`[first, last)`内有等于val的元素，它会返回true，否则返回false，它不返回查找位置

## 全排列，默认next升序

```cpp
next_permutation(a, a + n, b, cmp);
prev_permutation(a, a + n, b, cmp);
```

循环？

## 运算符重载？

### `=`重载的例子（`class`之外）

```cpp
sb& sb::operator=(const sb& a)
{
  if (this == &a)
    return *this;
  x = a.y;
  y = a.x;
  return *this;
}
```

### `==`重载

```cpp
bool operator==(sb a, sb b)
{
  if (a.x == b.x&&a.y == b.y)
    return 1;
  return 0;
}
```

## 浮点数精度控制

```cpp
cout << fixed << setprecision(9) << a << endl;
cout << setiosflags(ios::scientific) << setprecision(4) << a << endl;
```

## `vector`使用

```cpp
vector <fuck> edge[100];
edge[1].push_back(temp);
for (int i = 0; i < edge[1].size(); i ++)
{
  edge[1].at(i).u = 1;
}
edge[1].clear();
```

## `queue`和`priority_queue`

```cpp
struct vfuck
{
  long long dis;
}vnode[50001];
struct cmp
{
  bool operator()(vfuck a, vfuck b)
  {
    return a.dis > b.dis;
  }
};
priority_queue <vfuck, vector<vfuck>, cmp> pq;// 最小堆
while (pq.empty() == 0)
{
  tmp = pq.top();
  pq.push(tmp);
  pq.pop();
}
```

## stack

```cpp

```

## map

### 赋值/输出

```cpp
map <string, int> fuck;
map <string, int>::iter;
for (iter = fuck.begin(); iter != fuck.end(); iter ++)
{
  fuck["***"] = 1;
  cout << iter->first << iter->second;
}
```

### 其他

[cnblog](https://www.cnblogs.com/fnlingnzb-learner/p/5833051.html)

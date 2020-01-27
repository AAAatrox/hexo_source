---
title: leetcode128
updated: 1580044807
date: 2020-01-24 11:43:13
tags:
- leetcode
- hash表
- 并查集
---

# 题解

# c++ hash表

- `unordered_map`

```cpp
#include <stdio.h>
#include <unordered_map>

#define GREEN(format, ...) \
  printf("\033[1;32m" format "\33[0m\n", ## __VA_ARGS__)

using namespace std;

int main()
{
  unordered_map<int, int> my_map;
  pair<int, int> my_pair (2147483647, 1);
  my_map.insert(my_pair);
  if (my_map.count(2147483647) > 0) {
    GREEN("%d", my_map[2147483647]);
  }
  return 0;
}
```

- `unordered_set`

**TODO**

# debug

- 同`father`的并查集合并
- 判重

---
title: leetcode99
date: 2020-01-23 10:41:10
tags:
- leetcode
- 二叉树
- morris
---

# 解法

[参考:cnblog](https://www.cnblogs.com/grandyang/p/4298069.html)

中序遍历+排序

# Morris算法

[参考:cnblog](https://www.cnblogs.com/AnnieKim/archive/2013/06/15/morristraversal.html)

1. 如果`cur->left == NULL`,输出`cur`,并将`cur = cur->right`
2. 如果`cur->left != NULL`,在`cur`的左子树中找到前驱节点`prev`
  1. 如果`prev->right == NULL`,将`prev->right = cur`,并且`cur = cur->left`
  2. 如果`prev->right == cur`,将`prev->right = NULL`(恢复树的形状),输出`cur`,并且`cur = cur->right`
3. 重复1,2直到`cur == NULL`

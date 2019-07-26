---
title: gcc笔记
updated: 1554459508
date: 2019-04-03 18:36:07
tags:
 - gcc
---

## 参数

- `-ldl`:[libdl](http://refspecs.linuxbase.org/LSB_3.1.1/LSB-Core-generic/LSB-Core-generic/libdl.html)

the dynamic linking library,如果程序中使用`dlopen`,`dlsym`,`dlclose`,`dlerror`\*\*加载动态库,需要设置选项`-ldl`

## 查看可执行文件以来的动态链接库

```bash
ldd a.out
```

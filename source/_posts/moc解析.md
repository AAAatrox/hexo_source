---
title: moc解析
updated: 1555751704
date: 2019-04-20 09:45:48
tags:
 - visualstuidio
 - live2d
 - Csharp
---

> 对于visual stuidio的`C#`缺少引用,解决方法:
 - 重进
 - 自动添加引用

## wzhgba的[CubismLite](https://onedrive.live.com/redir?resid=BF245E76A574F404%2112643)

其中的c++部分可以删掉,只保留C#的部分.要求visual studio 2013+

### 使用

主函数是`Program.cs`,如果显示`v120_xp`未安装是因为原作者使用的是vs2013,可重定向项目,修改`windows SDK`版本

### TODO
- 作者是直接根据官方模型的`id`来进行解析的,所以对非官方模型以及`cmo3`转`moc`的解析会失败
- 貌似只能解析`moc`文件的`PARM`参数

## UlyssesWu的[FreeLive](https://github.com/UlyssesWu/FreeLive)

### 报错

- 目录无效

```
copy "...\*.dll" "...\*.pdb" exited with code 1
```

创建后面那一个文件夹即可

- 源无效

把`nuget`源改成`https://api.nuget.org/v3/index.json`

### TODO

- 在提取`cmox`文件的时候没有解决重名的问题

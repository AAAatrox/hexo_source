---
title: vundle笔记
updated: 1552100994
date: 2019-02-20 10:02:49
tags:
 - vim
 - vundle
---

## 命令

现在官方推荐使用`PluginXX`,不再推荐使用`Bundle`,而且原先是`call vundle#rc`,现在是`call vundle#begin()`和`call vundle#end()`

```
:PluginList "列举出已经安装的所有插件
:PluginInstall "安装列表中全部插件
:PluginInstall! "更新列表中全部插件
:PluginSearch foo "查找foo插件
:PluginSearch! foo "刷新foo插件缓存
:PluginClean "清除(vundle)列表中没有的插件
:PluginClean! "(慎用)会将vim-plug的插件清除
```

- [vimrc](https://blog.csdn.net/zhangpower1993/article/details/52184581)

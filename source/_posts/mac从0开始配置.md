---
title: mac从0开始配置
updated: 1552923045
date: 2019-01-20 10:33:56
tags:
 - mac
 - brew
 - git
---

## 乱七八糟的软件
 - qq
 - qq浏览器
 - iterm2
 - The Uarchiver
 - sublime
 - fliqlo
 - macvim
 - mactex
 - Spectacle
 - dukto:mac,linux,windows互传软件

## git

 - 会自动提示安装命令行工具

## brew

 - 权限问题
```bash
sudo chown -R $(whoami) /usr/loacal
```

## 升级后出现的问题

### xcode-select

#### 问题
```
xcrun: error: invalid active developer path (/Library/Developer/CommandLineTools), missing xcrun at: /Library/Developer/CommandLineTools/usr/bin/xcrun
```

#### 解决
```
xcode-select --install
```

## 安装refind
[CSDN](https://blog.csdn.net/xiaoshaxs/article/details/52016628)

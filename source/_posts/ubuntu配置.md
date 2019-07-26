---
title: ubuntu配置
updated: 1554459508
date: 2019-01-22 17:03:21
tags:
- Linux
- ubuntu
- grub
- hyper
---

## 瞎JB分盘

1. 安装失败 

- `swap`:1024M,主分区
- `/`:10G,主分区
- `/boot`:128M,主分区
- `/home`:剩余,主分区

2. 安装成功

- `swap`:4096M,逻辑分区
- `/`:剩余,主分区

3. 未知

- `swap`:4096M,逻辑分区
- `/boot`:200M,主分区
- `/`:10G,主分区
- `/home`:剩余,逻辑分区

4. 未知

- `/`:全部,主分区

## 乱七八糟的软件

- hyper
- chrome
- [sublime](https://www.sublimetext.com/docs/3/linux_repositories.html)
- dukto:3系统互传软件
- Indicator Stickynotes
- QQ(见下)
- [Typora](http://support.typora.io/Typora-on-Linux/)

## 搜狗输入法

[CSDN](https://blog.csdn.net/qq_32782339/article/details/79489851)

## grub配置

 - 位置

/etc/default/grub

- 内容修改

```
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
```

- 生效设置

```bash
sudo grub-set-default 2
sudo update-grub
```

> 数字任意

## hyper$^{TM}$

转移.hyper.js到~/.hyper.js

## 时间配置

```bash
sudo apt-get install ntpdate
sudo ntpdate time.windows.com
sudo hwclock --localtime --systohc
```

## 安装以下软件

- QQ
- TIM
- QQ轻聊版
- 微信
- Foxmail
- 百度网盘
- 360压缩
- WinRAR
- 迅雷极速版

[详细](https://www.lulinux.com/archives/1319),[github](https://github.com/wszqkzqk/deepin-wine-ubuntu)

### 软件的文件存放位置

- QQ:

`/home/lynx/.deepinwine/Deepin-QQ/dosdevices/c:/users/lynx/My Documents/Tencent Files/$account/FileRecv`

## `gnome-shell-entensions`

- [sysgeek](https://www.sysgeek.cn/things-installing-ubuntu-18-10/)
- [linux.cn](https://linux.cn/article-9447-1.html)

[chrome浏览器插件](https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep/related)

### 解决`显示应用程序`2个dock

```bash
cd /usr/share/gnome-shell/extensions
sudo rm -rf ubuntu-dock@ubuntu.com
```

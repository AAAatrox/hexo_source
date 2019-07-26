---
title: ssh笔记
updated: 1552923045
date: 2019-02-17 10:52:27
tags:
 - Linux
 - mac
 - termux
 - ssh
 - windows
---

## Linux

准备

```bash
sudo apt-get install openssh-server
sudo apt-get install net-tools
sudo ifconfig
```

配置文件:`/etc/ssh/sshd_config`

检查

```bash
netstat -tlp
```

```bash
ps -e|grep ssh
```

## mac

`设置`$\to$`共享`$\to$`远程登录`

## termux

```bash
pkg install openssh
sshd
sshd -p 22222
whoami
passwd
```

## ~~windows~~

- 安装`freeSSHd`
- `Users`$\to$`Add`,设置密码
- 开启`Shell`等
- powershell:`ipconfig`

> windows真他妈没卵用

---
title: termux从0开始配置
updated: 1553871937
date: 2019-01-20 11:00:15
tags:
 - termux
 - Linux
 - zsh
 - tmux
---

- [参考](https://www.sqlsec.com/2018/05/termux.html)
- [参考](https://zhuanlan.zhihu.com/p/32338964)

## 在home生成storage

```bash
termux-setup-storage
```

## 软链接

```bash
ln -s /data/data/com.termux/files/home/storage/shared/... 名字
```

## 某版本zsh

```bash
sh - O "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)"
```

### 颜色及字体重新配置

```bash
$HOME/.termux/colors.sh
$HOME/.termux/fonts.sh
```

- 一键配置

```bash
git clone https://github.com/NiaBie/termux.git
mv termux termux
```

## oh-my-tmux

```bash
cd ~
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf .tmux.conf
cp .tmux/.tmux.conf.local .
```

## 修改源

```
export EDITOR=vi
apt edit-sources
```

`http://mirrors.tuna.tsinghua.edu.cn/termux`

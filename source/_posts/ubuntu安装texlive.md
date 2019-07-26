---
title: ubuntu安装texlive
updated: 1551018203
date: 2019-02-13 19:06:31
tags:
 - ubuntu
 - latex
---

## 安装texlive

[清华镜像](https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/Images/)

### 安装

```bash
sudo apt-get install perl-tk
sudo mount -o loop texlive.iso /mnt
cd /mnt
sudo ./install-tl -gui
```

### 配置

.bashrc/.zshrc添加

```
PATH=$PATH:/usr/local/texlive/2018/bin/x86_64-linux
```

其余见[mactex配置](https://niabie.github.io/2019/02/13/mactex%E9%85%8D%E7%BD%AE/),pdf打开方式`open - a Preview.app`$\to$`evince`

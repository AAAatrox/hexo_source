---
title: ubuntu使用
updated: 1561108590
date: 2019-02-25 22:26:14
tags:
 - ubuntu
---

## 在文件夹中执行脚本

在`文件`$\to$`首选项`$\to$`行为`$\to$`可执行文本文件`

## 快捷键

不要出现`fn`+`super`的组合

截屏:

- 复制截图到剪切板:`ctrl`+`print`
- 复制窗口截图到剪切板:`ctrl`+`alt`+`print`
- 复制选区截图到剪切板:`shift`+`ctrl`+`print`
- 保存截图到`图片`:`print`
- 保存窗口截图到`图片`:`alt`+`print`
- 保存选区截图到`图片`:`shift`+`print`
- 录屏:`shift`+`ctrl`+`alt`+`r`

## 热点

```bash
nm-connection-editor
```

`设置`$\to$`wifi`$\to$`打开wifi热点`

## gif录屏

- byzanz

```bash
sudo apt install byzanz 
byzanz-record --duration=50 --delay=3 --x=1030 --y=100 --height=500 demo1.gif
```

## 桌面便签(Indicator Stickynotes)

```bash
sudo add-apt-repository ppa:umang/indicator-stickynotes
sudo apt-get update
sudo apt-get install indicator-stickynotes
```

## 笔记本行为设定

- 合盖不休眠:`/etc/systemd/logind.conf`

```conf
HandleLidSwitch=ignore
```

[CSDN](https://blog.csdn.net/xiaoxiao133/article/details/82847936)

## 屏幕管理

- arandr

```bash
sudo apt install arandr
```

## 密钥环

`密码和密钥`$\to$`默认密钥环`$\overset{\mbox{右键}}{\to}$`更改密码`$\to$空白

## 镜像源

`/etc/apt/sources.list`

- 中科大

```
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
```

- 清华

```
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
```

- 网易

```
deb http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse
```

- 阿里

```
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
```

## apt

- [apt与apt-get区别](https://www.sysgeek.cn/apt-vs-apt-get/)
- [apt-get示例](https://linux.cn/article-4933-1.html)

## 系统监视器安装

```bash
sudo apt install gnome-system-monitor
```

## 重启`gnome-shell`

`alt+f2`$\to$`r`

## 误删`PATH`救急

- Linux通用?

```bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$PATH
```

> 不要忘记加`:PATH`

## 一个解决包依赖问题的软件

```bash
sudo apt install aptitude
```

- (示例)卸载libreoffice

```bash
sudo aptitude purge libreoffice6.0
```

## 安装字体

```bash
sudo mkdir /usr/share/fonts/{name}
sudo cp {font}.ttf /usr/share/fonts/{name}
cd /usr/share/fonts/{name}
sudo mkfontscale
sudo mkfontdir
sudo fc-cache -fv
```

## 图像转换

```bash
sudo apt install sam2p
sam2p shit.png shit.gif
```

## 图像编辑

```bash
sudo apt install gimp
```

> `krita`

## 字体编辑

```bash
sudo add-apt-repository ppa:fontforge/fontforge
sudo apt-get update
sudo apt-get install fontforge
```

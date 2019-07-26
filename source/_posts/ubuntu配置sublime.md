---
title: ubuntu配置sublime
updated: 1553507200
date: 2019-02-20 07:50:52
tags:
 - ubuntu
 - Linux
 - sublime
---

## [安装](https://www.sublimetext.com/docs/3/linux_repositories.html)

Install the GPG key:

```bash
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
```

Ensure apt is set up to work with https sources:

```bash
sudo apt-get install apt-transport-https
```

Select the channel to use:

- Stable

```bash
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
```

- Dev

```bash
echo "deb https://download.sublimetext.com/ apt/dev/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
```

Update apt sources and install Sublime Text

```bash
sudo apt-get update
sudo apt-get install sublime-text
```

### [sublime-merge](https://www.sublimemerge.com/docs/linux_repositories)

在之前的基础上

```bash
sudo apt-get install sublime-merge
```

## 不能输入中文

### 在终端输入`subl`后能输入中文

[简书](https://www.jianshu.com/p/bf05fb3a4709)

### 固定到收藏夹

参考:[CSDN](https://blog.csdn.net/jpch89/article/details/81739176)

创建`sublime.sh`:

```bash
#!/bin/bash
LD_PRELOAD=/opt/sublime_text/libsublime-imfix.so subl
```

创建`my_sublime.desktop`:

```desktop
[Desktop Entry]
Name = my_sublime
Icon = 还没有
Type = Application
Exec = path_to/sublime.sh
```

修改`my_sublime.desktop`的权限,然后

```bash
sudo cp my_sublime.desktop /usr/share/applications/
```

将`my_sublime`添加到收藏夹

## latex

1. 安装texlive

2. 安装latex-tools

3. `Preference`$\to$`Packages Settings`$\to$`LaTeXTools`

```
"linux" : {
    // Path used when invoking tex & friends; MUST include $PATH
    "texpath" : "$PATH:/usr/local/texlive/2018/bin/x86_64-linux",
          }
```

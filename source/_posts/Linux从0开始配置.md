---
title: Linux从0开始配置
updated: 1554475061
date: 2019-01-20 10:29:32
tags:
 - Linux
 - powerline
 - zsh
 - vim
 - git
 - pip
---

## git

1. 全局设置

```bash
git config --global user.name "Lynx" # your student ID and name
git config --global user.email "1197225628@qq.com"   # your email
git config --global core.editor vim                 # your favorite editor
git config --global color.ui true
```

## powerline

1. python安装pip

[菜鸟教程](http://www.runoob.com/w3cnote/python-pip-install-usage.html)

```bash
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py
# or
sudo apt-get install python3-pip
```

2. pip安装powerline

[详细](http://cenalulu.github.io/linux/mac-powerline/)

```bash
pip install powerline-status
```

3. pip安装powerline-gitstatus

[github](https://github.com/jaspernbrouwer/powerline-gitstatus)

```bash
sudo apt install powerline-gitstatus
# or
pip install powerline-gitstatus
```

4. 复制配置文件
```bash
git clone https://github.com/NiaBie/powerline.git
mv powerline .config/
```

5. 安装powerline字体

[详细](http://cenalulu.github.io/linux/mac-powerline/)

```bash
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
```

6. 修改终端字体设置

7. 找不到`powerline-config`

```bash
export PATH=$pathtopowerline-config:PATH
```

## vim

1. 转移.vimrc,修改powerline相对路径

 安装支持python的vim(查看`vim --version`),[详细](http://cenalulu.github.io/linux/mac-powerline/):

 - macOS

 ```bash
 brew install vim --with-python
 ```

 - Linux

 ```bash
 sudo apt install vim-gnome
 ```

2. 复制插件(`branch clean`)
```bash
git clone https://github.com/NiaBie/my_vim.git
mv my_vim .vim
```

- 注意`ubuntu`默认只装了`vi`而不是`vim`

- ~~插件包含:~~推荐插件

    - vim的gitdiff标识[vim-gitgutter](https://www.diycode.cc/projects/airblade/vim-gitgutter)
    - 彩虹括号升级版[rainbow](https://github.com/luochen1990/rainbow)
    - 插件管理器[vim-plug](https://github.com/junegunn/vim-plug)
    - 魔改自`tokyo-metro`的配色`my.vim` 
    - 手写的仿sublime补全插件[vim-sb-complete](htts://github.com/niabie/vim-sb-complete)

3. 修改rtp

## zsh

1. 安装zsh

2. wget安装oh-my-zsh
```
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" 
```

3. 转移.zshrc,修改powerline相对路径

4. 安装zsh-syntax-highlighting

 [详细](https://blog.csdn.net/caiqiiqi/article/details/52139288)

 - macOS

 ```bash
 brew install zsh-syntax-highlighting
 ```

 然后将`source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh`加到`.zshrc`

 - oh-my-zsh

 ```bash
 git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
my zsh-syntax-highlighting .config/zsh/zsh-syntax-highlighting
 ```

 然后将`source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.git`加到`.zshrc`


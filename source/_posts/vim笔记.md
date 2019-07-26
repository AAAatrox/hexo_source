---
title: vim笔记
updated: 1553608999
date: 2019-01-20 10:46:19
tags:
 - vim
---

- 粘贴不覆盖缓冲区
 
```
nnoremap y "ay
vnoremap y "ay
nnoremap p "ap
vnoremap p "ap
nnoremap d "ad
vnoremap d "ad
```

## 多屏

 - 切换屏幕
 
 ```
 <C-W>h "左
 <C-W>j "下
 <C-W>k "上
 <C-W>l "右
 ```
 
 - 在分屏打开文件
 
 ```
 :vsp filename "左右
 :sp filename "上下
 ```
 
 - 关闭多屏
 
 ```
 <C-W>c "关闭当前
 <C-W>w "保留当前
 ```
 
[参考](https://www.cnblogs.com/ini_always/archive/2011/09/21/2184446.html)

 - 分屏互换
 
 ```
 <C-W>x
 <C-w>r
 ```
 
[详细](https://www.cnblogs.com/bkylee/p/6120060.html)

- 宏录制

```
qa
你的操作
q
@a
7@a
@@
```
 
- 折叠常用命令

```
zi
zm
zc
zC
zo
zO
```

[详细](http://www.cnblogs.com/welkinwalker/archive/2011/05/30/2063587.html)

- 大小写

vmode下

```
u
<S-U>
```

- 搜索区分大小写

```
:set noignorecase
```

## 关于高亮

 - 解决突然失效
 
 ```
 :set syntax=c
 :set filetype=sh
 ```
 
 - 修改colorscheme
 
 ```
 :colorscheme $scheme
 ```
 
 - 设置c缩进
 
 ```
 :set cindent
 ```
 
## 增加系统剪切板功能

 - 查看是否有该功能
 
 ```bash
 vim --version | grep "clipboard"
 ```
 
 `clipboard`之前有`-`说明不支持
 
 - 安装
 
 ```bash
 sudo apt-get install vim-gnome
 ```
 
 - 复制到系统剪切板
 
 `vmode`下`"`+`+`+`<S-y>`

## 与tmux颜色冲突

[stackoverflow](http://stackoverflow.com/a/15378816/390643)
[github](https://gist.github.com/limingjie/4975c36d13d0927613e6)

 - tmux:`~/.tmux.conf`
 
 ```conf
 set -g default-terminal "screen-256color"
 ```
 
 - screen:`~/.screenrc`
 
 ```vim
 term "screen-256color"
 ```
 
 - vim:`~/.vimrc`
 
 ```vim
 if &term == "screen"
   set t_Co = 256
 endif
 ```

- 自动加载

```vim
au FileType * call MyView()
fun! MyView()
  if (&filetype != "")
    au VimLeave * silent mkview
    au VimEnter * silent loadview
  endif
endfun
```

- 语言设定

```vim
lan en_US.utf-8" 自己<c-d>看有什么
```

## 一些乱七八糟的东西

`rm -rf .vim/view`,解决以下毛病

- 按键乱映射

## markdown格式下的高亮问题

- `*`:数学公式中使用`\ast`
- `<`:左右要加空格

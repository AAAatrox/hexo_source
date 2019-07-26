---
title: mactex配置
updated: 1551018203
date: 2019-02-13 12:10:24
tags:
 - latex
 - mac
 - vim
---

## mac安装gvim
```bash
brew install macvim
```

转移.gvimrc

## 安装vim-latex

自行从`sourceforge`下载

### 修改配置

> ~/.vim/ftplugin/latex-suite/texrc

 - 默认生成格式`dvi`$\to$`pdf`

 - 默认调用的编译程序`pdflatex`$\to$`xelatex`

 - 默认`pdf`查看程序`xpdf`$\to$`open`

[CSDN](https://blog.csdn.net/iscape/article/details/6880957)

## vimrc

### 启用`vim-latex`

[简书](https://www.jianshu.com/p/fde4e8fbb049)

### 解决`\lv`报错

[sourceforge](https://sourceforge.net/p/vim-latex/mailman/message/25265559/)

> In Vim, just type `:echo(has("unix"))` and `:echo(has("macunix"))` to check the value of these settings. The Mac OS X bundled Vim declares itself only as unix, while MacVim declares itself as both unix and macunix. MacVim is also compiled with more options, like ruby support, and it provides a GUI (the VimLatex menus can be handy) and better OS integration (like simple copy/paste between Vim and other apps). But make sure to use the latest snapshot on Snow Leopard, as the stable is not stable :)

> Generally, its better to set options in .vimrc (in your home folder) than modifying vim-latex itself, since that makes updating vim-latex easier. Just put
```
let g:Tex_ViewRule_pdf = 'open -a Preview.app' 
```
> in your $HOME/.vimrc (~/.vimrc that is). If you need to detect mac (say you want to sync the .vimrc between different computers), don't rely on has("macunix"), but use something like this:
```
if has("unix") && match(system("uname"),'Darwin') != -1
    " It's a Mac!
    let g:Tex_ViewRule_pdf = 'open -a Preview.app' 
endif      
```
> Dan Michael

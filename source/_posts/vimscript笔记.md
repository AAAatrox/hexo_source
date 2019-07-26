---
title: vimscript笔记
updated: 1554127361
date: 2019-03-09 16:16:27
tags:
 - vim
---

## 资料

- [ENG手册](http://vimdoc.sourceforge.net/htmldoc/autocmd.html#VimEnter)
- [vim中文帮助文档](http://vimcdoc.sourceforge.net/doc/usr_41.html)
- [笨办法学vimscript](http://learnvimscriptthehardway.onefloweroneworld.com/)
- [Google Vimscript Guide](https://google.github.io/styleguide/vimscriptfull.xml#Functions)
- [viml语言编程](http://lymslive.top/book/vimllearn/vm.cgi?p=content)

## 函数

### 函数调用

- 调用:`:call $func($para)`
- 映射到按键(返回函数的返回值)

```vim
inoremap <expr><tab> Func()
inoremap <tab> <c-r>=Func()<cr>
inoremap <tab> <esc>:call Func()<cr>a
```

### 外部函数调用

在`file.vim`中定义

```vim
function file#main()
...
endfunction
```

在其他文件

```vim
call file#main()
```

### 系统函数

- `:help functions`

- `:expand("<cword>")`:以字符串的形式返回当前光标下的词

## 命令

### 自定义命令

```vim
command! On call MyFunction()
```

## 变量

### 变量的作用域

- `g`:全局
- `s`:当前脚本
- `w`:当前窗口
- `t`:当前的编辑器选项卡
- `b`:缓冲区
- `l`:当前的函数
- `a`:当前函数的一个参数
- `v`:vim的预定义变量

### 访问变量

- `&` `var`:一个vim选项
- `&l:` `var`:本地变量(局部变量)
- `&g:` `var`:全局变量
- `@` `var`:寄存器
- `$` `var`:环境变量

### 特殊字符/按键

- 帮助:`:help keycodes`

- `<cword>`:光标下的单词
- [获取文件名](http://www.bagualu.net/wordpress/archives/2279)
 - expand('%'):当前文件名
 - expand('%:e'):扩展名
 - expand('%:r?'):去除扩展名?
 - expand('%:p'):完整路径
 - expand('%:h'):当前目录

- 打印一些特殊符号(例)
 - `<c-v>`:`:iunmap <c-v>`(如果有)$\to$`<c-v>`(准备输入特殊字符)$\to$`<c-v>`(输入真的`CTRL+V`)

 ---

## 关于`vim-sb-complete`

地址

-[https://github.com/NiaBie/vim-sb-complete1](https://github.com/NiaBie/vim-sb-complete1)
-[https://github.com/NiaBie/vim-sb-complete2](https://github.com/NiaBie/vim-sb-complete2)
-[https://github.com/NiaBie/vim-sb-complete3](https://github.com/NiaBie/vim-sb-complete3)

### 手册查询

- `complete-items`
- `complete`: 菜单
- `ins-completion`
 - `completefunc`
 - `omnifunc`

### 踩过的坑

- `getline`最后没有换行符
- `match`返回的是匹配的位置

### 字符及转义

```
let g:sbcom_isword = ["[0-9a-zA-Z:_]"]
let g:sbcom_issplit = ["`", "\\~", "!", "@", "#", "\\$", "%", "\\^", "&", "*", "(", ")", "-", "=", "+", "[", "{", "]", "}", "\\", "|", ";", "\'", "\"", ",", "<", "\\.", ">", "/", "?", " ", "\t", "\n"]

```

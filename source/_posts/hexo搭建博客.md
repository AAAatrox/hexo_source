---
title: hexo搭建博客
updated: 1553085822
date: 2019-01-20 10:36:26
tags:
 - hexo
 - git
---

## git全局配置
```bash
git config --global user.name "Lynx" # your student ID and name
git config --global user.email "1197225628@qq.com"   # your email
git config --global core.editor vim                 # your favorite editor
git config --global color.ui true
```

## 安装node.js

## 安装npm和hexo,搭建博客

[知乎](https://zhuanlan.zhihu.com/p/34654952)

 - ubuntu
```bash
sudo apt-get install nodejs
sudo apt-get install npm
```

### 简要过程

```bash
hexo init
sudo npm install
npm install hexo-deployer-git --save
```

## 设置tags和categories

[CSDN](https://blog.csdn.net/Winter_chen001/article/details/79719154)

## 插入图片

[CSDN](https://blog.csdn.net/Sugar_Rainbow/article/details/57415705)

## 搜索功能(只适用Next主题)

[CSDN](https://blog.csdn.net/ganzhilin520/article/details/79047983)

## 新建页面

```bash
hexo n page "name"
```

`blog/theme/next/_config.yml`

```
menu:
  menu_name: position || icon_name
```

## 字体样式修改

> 修改不同位置加载速度不同

1. 位置:`blog/themes/next/source/css/_variables/base.styl`

 - `font-size-base`
 - `code-font-size`
 - `font-family-base`

2. 位置:`blog/themes/next/_config`

 - `font`

## 自定义端口

```bash
hexo s -p 99999999
```

局域网访问:`${IP}:$port`

## 急救

- 显示`Cannot GET /`

```bash
sudo npm install
```

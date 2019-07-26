---
title: npm笔记
updated: 1553700971
date: 2019-03-05 19:07:18
tags:
 - npm
 - unpkg
---

- 查看已安装软件

```bash
sudo npm list -g --depth=0
```

## 创建到发布

- [比较详细的教程:cnblogs](https://www.cnblogs.com/penghuwan/p/6973702.html)
- [教程索引:简书](https://www.jianshu.com/p/60ac7fe6edce)

```bash
npm init
npm login
...
npm publish
```

## 安装

切换到你要安装npm包的目录

```bash
sudo npm init
...
sudo npm i $package
```

## 常见问题

`no_perms Private mode enable, only admin can publish this module`:[简书](https://www.jianshu.com/p/0916afb4acba),[cnblogs](http://www.cnblogs.com/mengff/p/5486533.html)

## npm脚本

- [阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/10/npm_scripts.html)

 ---

## npm使用unpkg([官网翻译](https://yq.aliyun.com/articles/592213))

### unpkg 是什么

unpkg 是一个内容源自 npm 的全球快速 CDN.

> 注:它部署在cloudflare上,在大陆地区访问到的是香港节点.它支持h/2和很多新特性,如果不考虑网络延迟的原因,性能优化较为出色.在国内一些互联网公司也有镜像,例如知乎和饿了么

它能以快速而简单的方式提供任意包、任意文件,通过类似这样的URL:`unpkg.com/:package@:version/:file`

### 怎样使用unpkg

使用固定的版本号:

`unpkg.com/react @16.0.0/umd/react.production.min.js`

`unpkg.com/react-dom @16.0.0/umd/react-dom.production.min.js`

也可使用语义化版本范围,或标签来代替固定版本号,亦可忽略版本和标签,直接使用最新的版本

`unpkg.com/react@^16/umd/react.production.min.js`

`unpkg.com/react/umd/react.production.min.js`

如果忽略了文件的路径(例如,使用裸网址"bare"URL),unpkg会提供`package.json`里指定的文件,或降级到main

`unpkg.com/d3`

`unpkg.com/jquery`

`unpkg.com/three`

> 注:这种方式会产生一次302到最新的文件URL.好处是自动使用最新版,坏处是多一次性跳转,降低了性能

在网址最后添加斜线,可以查看一个包内的所有文件列表.

`unpkg.com/react/`

`unpkg.com/lodash/`

### 查询参数

#### ?meta

以`JSON`格式返回包的元数据(metadata)(例如: /any/file?meta)

#### ?module

展开`javascript`模块里所有"bare"`import`为unpkg网址.此功能为初步实验性质的

> 具体的实现和更多介绍可参考此仓库:`babel-plugin-unpkg`

### UNPKG上的发布流程

如果你是npm包作者,只要发布到npm仓库,unpkg替你减轻了发布到CDN的麻烦.仅需npm包中包含UMD构建即可(并非在代码仓库里包含,两者不同!)

简单来讲,通过以下步骤:

- 添加umd(或dist)目录到.gitignore文件中
- 添加umd目录到package.json文件数组(files)中
- 发布的时候,使用脚本构建UMD打包文件到umd目录

就是这样了,当npm发布时,在unpkg上也会拥有一个有效的文件版本

一旦发布到npm后即可被访问到,如果按以上说明操作,将具有更好的效果.建议参考Vue的package.json帮助理解

---
title: mac使用
updated: 1554288179
date: 2019-03-18 19:59:43
tags:
 - mac
---

## 免密码登录(自动登录)

- 关闭文件保险箱
- 取消关闭自动登录

## 允许各种来源的软件

```bash
sudo spctl --master-disable
```

## [lrzsz](http://www.cnblogs.com/dingdada/p/4498766.html)

- 安装iterm2
- 安装lrzsz:`brew install lrzsz`
- ~~软连接~~
- 安装automatic zmoderm for iterm2

```bash
cd /usr/local/bin
sudo wget https://raw.github.com/mmastrac/iterm2-zmodem/master/iterm2-send-zmodem.sh
sudo wget https://raw.github.com/mmastrac/iterm2-zmodem/master/iterm2-recv-zmodem.sh
sudo chmod 777 /usr/local/bin/iterm2-*
```

- 修改iterm2设置:`Profiles`$\to$`Edit Profiles`$\to$`Profiles`$\to$`Advanced`$\to$`Edit Trigger`

| Regular expression | Action | parameters |
| :--: | :--: | :--: |
| `\*\*B0100` | Run Silent Coprocess | /usr/local/bin/iterm2-send-zmodem.sh | 
| `\*\*B00000000000000` | Run Silent Coprocess | /usr/local/bin/iterm2-recv-zmodem.sh | 

## [截图](https://zh.wikihow.com/%E5%9C%A8Mac-OS-X%E4%B8%8A%E6%88%AA%E5%8F%96%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE)

- 全屏截图,保存至桌面:`cmd`+`shift`+`3`
- 区域截图,保存至桌面:`cmd`+`shift`+`4`
- 窗口截图,保存至桌面:`cmd`+`shift`+`4`,`space`
- 上3种,保存至粘贴板:+`ctrl`
- grab

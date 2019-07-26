---
title: apahce2搭建php环境
updated: 1555840539
date: 2019-04-18 18:09:11
tags:
 - php
 - apahce2
---

### 安装

```bash
sudo apt install php7.2
sudo apt install apahce2
sudo apt install php7.2-mysql # php支持mysql
sudo apt install mysql-server mysql-client
```

### 常用命令

```bash
sudo service mysql start # 不知道干嘛的
sudo service apache2 restart # http
sudo /usr/sbin/apache2ctl start # http
php -S localhost:6060 -t . # http,不能够浏览目录
```

`apahce2`配置目录`/etc/apahce2`

### 修改`apahce2`默认目录

- 修改`/etc/apahce2/sites-available/000-default.conf`

```
DocumentRoot /{不要带/}
```

- 修改`/etc/apahce2/apahce2.conf`

```
<Directory /{你的目录,不要加/}>
```

- 要有默认主页文件`index.{后缀名任意}`

### 修改`apahce2`默认端口

- 修改`/etc/apahce2/sites-available/000-default/conf`

```
<VirtualHost *:{端口号}>
```

- 修改`/etc/apahce2/ports.conf`

```
Listen {端口}
```

> 注意`https`和`http`的区别

### 多端口

- `ports.conf`增加`Listen`
- `apahce2.conf`增加`<VirtualHost *:{端口}></VirtualHost>`

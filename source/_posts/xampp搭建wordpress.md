---
title: xampp搭建wordpress
updated: 1556548282
date: 2019-03-27 23:36:00
tags:
 - php
 - wordpress
 - xampp
---

# windows

## 安装和配置

- 启动报错

```
[Apache] Error: Apache shutdown unexpectedly.
[Apache] This may be due to a blocked port, missing dependencies,
[Apache] improper privileges, a crash, or a shutdown by another method.
[Apache] Press the Logs button to view error logs and check
[Apache] the Windows Event Viewer for more clues
[Apache] If you need more help, copy and post this
[Apache] entire log window on the forums
```

需要修改端口号:

 - `界面`->`Config`->`Service and Port Settings`->`SSL Port`
 - `xampp/apache/conf/extra/httpd-ssl.conf`
 ```
 Listen {端口号}
 ```
 > 两次端口要一致

 ---

# Linux

## [xampp安装](https://jingyan.baidu.com/article/066074d66e1141c3c21cb0ce.html)

- `.run`文件

```bash
sudo chmod a+x *.run
sudo ./*.run
```

出现

```
XAMPP: Starting Apache...fail.
XAMPP:  Another web server is already running.
```

使用(待定)

```bash
sudo /usr/sbin/apache2ctl stop
```

- 命令

```bash
sudo /opt/lampp/lampp start # https
```

## [wordpress安装](https://www.crifan.com/during_install_wordpress_access_wp_admin_install_php_error_database_connection_error_your_database_name_and_password_may_not_correct_provided_in_wp_config_php/)

- [建立数据库](https://www.crifan.com/use_phpmyadmin_to_create_new_mysql_database_for_wordpress/)

若出现数据库已经存在的报错(重装时),删除原数据库.先手动删除数据库(位置`/opt/lampp/var/mysql/wordpress`),然后再用phpmyadmin(`localhost/phpmyadmin`)删除

- `wp-config.php`

```php
define('DB_NAME', 'wordpress');
define('DB_USER', 'root');
define('DB_PASSWORD', '');
```

好像最开始是不能有密码的

## 报错解决

- `无法创建目录`

```
sudo chmod a+w -R /opt/lampp/htdocs
```

- (localhost)`连接服务器时出错,请检查设置`(更新的时候)

在`htdocs/wp-config.php`添加

```
define('FS_METHOD', "direct");
```

但还是一堆`Warning`

## bug解决

- 本地`css`样式加载不正常

用`127.0.0.1`替代`localhost`

## 其他配置

- [免ftp密码](https://www.oschina.net/question/1467780_147338)

- 修改站点信息

`仪表盘`->`设置`->`常规`

## 插件

- `WP Editor.md`:markdown编辑器
- `WordPress Database Backup`:备份工具

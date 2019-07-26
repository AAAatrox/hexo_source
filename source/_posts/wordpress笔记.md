---
title: wordpress笔记
updated: 1557402085
date: 2019-04-29 14:24:21
tags:
 - wordpress
 - mysql
 - php
 - apache
---

## mysql

```bash
mysqladmin --version

sudo mysqladmin -u root password "111111"
mysql -h localhost -u root -p
```

```bash
ps -ef | grep mysqld

cd /usr/bin
sudo ./mysqld_safe
```

```bash
sudo mysql

mysql> SHOW DATABASES;
mysql> exit;
mysql> drop database wordpress;
```

## phpmyadmin

```bash
sudo apt install phpmyadmin
```

位置:`/usr/share/phpmyadmin`

## [wordpress安装](https://www.crifan.com/during_install_wordpress_access_wp_admin_install_php_error_database_connection_error_your_database_name_and_password_may_not_correct_provided_in_wp_config_php/)

- [建立数据库](https://www.crifan.com/use_phpmyadmin_to_create_new_mysql_database_for_wordpress/)

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

- (localhost)`连接服务器时出错,请检查设置`

在`htdocs/wp-config.php`添加

```
define('FS_METHOD', "direct");
```

但还是一堆`Warning`

## 其他配置

- [免ftp密码](https://www.oschina.net/question/1467780_147338)

## 插件

- `WP Editor.md`:markdown编辑器
- `WordPress Database Backup`:备份工具


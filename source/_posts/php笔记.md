---
title: php笔记
updated: 1555841472
date: 2019-04-21 16:47:01
tags:
 - php
---

> 乱七八糟的东西

```bash
sudo apt install php7.2-cgi
```

[phpstorm注册网站](idea.lanyus.com)

# html加载php

## 注意:

- 分号
- 文件加载先后

## 输出到`console`

```php
<?
function console_log($src)
{
  if (is_array($src) || is_object($src))
  {
    echo("console.log(" . json_encode($src) . ");");
  }
  else
  {
    echo("console.log(" . $src . ");");
  }
}
console_log("fuck");
```

## js调用php变量

```php
<?php
function tranlate_js($src, $dest)
{
  if (is_array($dest) || is_object($dest))
  {
    console_log("...");
    return;
  }
  if (is_array($src) || is_object($src))
  {
    echo("var " . $dest . "=" . json_encode($src) . ";");
  }
  else
  {
    echo("var " . $dest . "=" . $src . ";");
  }
}
$arr = array("you", 2, 3);
tranlate_js($arr, "shit"); // var shit = $array
```

```javascript
console.log(shit);
```

## php调用js方法

```javascript
function my_log(a)
{
  console.log(a);
}
```

```php
$str = "'you'";
echo "my_log(" . $str . ");";
```


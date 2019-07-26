---
title: live2d壁纸
updated: 1554630358
date: 2019-04-07 17:18:32
tags:
 - live2d
---

## 打包

```
root/-+-${name1}/-+-motions/
      |           |
      |           +-textures/
      |           |
      |           +-model.moc
      |           |
      |           +${name1}.model.json
      |           |
      |           `-...
      |
      +-${name2}/---...
      | # 以下为手动打包时需要的文件
      +-config.mlve
      |
      `-last.mlve # 这个不知道干嘛的,长得和上面那个一模一样
```

- 手动

人物压缩包后缀名`lpk`,背景`bpk`

 - config.mlve

 ```json
  {
    "type":"Live2D Model List",
    "name":"${pkg_name}",
    "id":"${id_name}",
    "version":"1.0",
    "encrypt":"false",
    "list":
      [
      {
        "character":"${name1}",
        "costume":
        [
        {"name":"${costume_name}", "path":"${path}/${name1}.model.json"}
        ]
      }
    ]
  }
 ```

- `Live2D Config Generator`

选择`root/`,`生成配置文件`$\to$`生成mlve文件`$\to$`创建LPK文件`

## Android

- 安装`Live2DViewerEX`2.0.4+版本

## Windows

- 安装`Live2d Wallpaper`

语言气泡还未开始研究

- `Live2DViewerEX`+`Wallpaper Engine`

(未开坑),见[bilibili](http://www.bilibili.com/video/av7904265?p=2&share_medium=android&share_source=qq&bbid=XY69FCA600698489D9FFA223DD6F27B4C9601&ts=1554626603503)

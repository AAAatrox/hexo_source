---
title: 七牛云使用笔记
updated: 1551704610
date: 2019-03-04 17:52:19
tags:
 - bucket
 - cdn
 - html
---

- 外链

 - live2d_api:pnu3nz53b.bkt.clouddn.com
 - live2d_mini:pnu7uf4io.bkt.clouddn.com
 - live2d_lazy:pnu9p6tp8.bkt.clouddn.com

## [listbucket](https://github.com/qiniu/qshell/blob/master/docs/listbucket.md)

列举七牛空间的文件列表

```bash
qshell listbucket live2d_api
```

## [qupload](https://github.com/qiniu/qshell/blob/master/docs/qupload.md)

上传

```bash
qshell qupload .qshell.json
```

`.qshell.json`配置

```json
{
  "src": "/home/lynx/live2d_api",
  "bucket": "live2d_api"
}
```

## [batchdelete](https://github.com/qiniu/qshell/blob/master/docs/batchdelete.md)

删除文件名列表中的文件

```bash
qshell batchdelete live2d_mini -i delete_list
```

## 还没开始看的参考网址

- [加速图片等静态文件](https://devework.com/wordpress-qiniu.html)
- [上传文件夹的python实现](https://blog.csdn.net/YZCSzhiYZTY/article/details/78224706)
- [https://blog.csdn.net/u010646653/article/details/9371011](https://blog.csdn.net/u010646653/article/details/9371011)

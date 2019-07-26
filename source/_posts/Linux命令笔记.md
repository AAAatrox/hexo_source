---
title: Linux命令笔记
updated: 1558190303
date: 2019-01-20 10:52:59
tags:
 - Linux
---

- 当前目录,只保留file

 - `xargs`
 ```bash
 find /当前目录 -type f ! -name "file"|xargs rm -f
 ```

 - `find`自带命令
 ```bash
 find /当前目录 -type f ! -name "file" -exec rm -f {} \
 ```

- 递归删除:

 除`.java`
 
```bash
find ./ -name "*.java" | xargs rm -rfv
```

- 批量修改文件名:

```bash
rename 's/原内容/改后内容/' *
```

- 打包:

```bash
tar czvf FileName.tar DirName
```

- 计算目录大小

```bash
du -h --max-depth=1 .
```

- 合并文件夹

```bash
cp -frp new/* old/
```
 
`-f`强制覆盖,`-r`递归,`-p`保持新文件的属性不变

## dpkg

- 查找已装软件?

```bash
dpkg -l|grep filename
```

- 卸载软件

```bash
dpkg -r filename
```

或?
 
```bash
dpkg -P filename
```

- 目录分析(du)

示例

```bash
du -d1 -b -a .
du -d0 -m .
```

- 彻底删除标识为`rc`的配置信息

> `rc`:软件已卸载,配置文件还在

```bash
dpkg -l | grep ^rc | cut -d' ' -f3 | sudo xargs dpkg --purge
```

## cat

- 输出固定行数

```bash
cat $file | head -n +6
``` 

[详细](https://blog.csdn.net/NFR413/article/details/78966085)

## curl

- 下载`$file`

```bash
curl -O $pathtofile
```

- 命令行中输出表达式的值

```bash
echo $[1 == 2]
```

[Linux的算术运算](https://www.cnblogs.com/newcaoguo/p/5980913.html)

## 进程

- 切换到后台

```bash
<ctrl+z>
```

- 查看后台进程

```bash
jobs
```

- 使第`N`个进程在前台/后台运行

```bash
fg %N
bg %N
```

不加`N`默认对最后一个进程操作

## ctags

- vim设定源

固定

```vim
set tags=$path
```

先当前目录,后向上找

```vim
set tags=tags;
set autochdir
```

## `ln`链接

- 文件夹软链接

```bash
ln -s $exists $new
```

## `wc`统计行数

```bash
find -maxdepth 10 -type f | xargs wc -l
wc -l `find -name '*.*'`
```

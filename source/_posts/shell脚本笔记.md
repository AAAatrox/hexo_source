---
title: shell脚本笔记
updated: 1553434111
date: 2019-02-16 19:46:43
tags:
 - Linux
 - shell
---

## 传参

```bash
zsh ./fuck.sh $1 $2 $3 ...
```

## 赋值

 - 不要加空格

## if

示例:

```bash
if [ "${message}"x = x ]
then
  echo "equal"
elif [ "${message}"x = "shitx" ] || [ "${message}"x = "SHIT" ]
then
  echo "shit"
else
  echo "fuck"
fi
```

- 注意`[``]`的空格和关系运算符的空格
- 注意字符串比较时为空的情况
- [更多](https://www.jb51.net/article/56553.htm)

## for

```bash

```

## while

一个修改缩进的脚本

```bash
line_num=$(wc -l $1)
echo ${line_num}
i=0
while [ ${line_num:${i}:1} != " " ]
do
  ((i++))# 寻找空格
done
line_num=${line_num:0:${i}}
echo ${line_num}
version=$(uname)
if [ "${version}" = "Linux" ]
then
  sed -i 's/\t/  /g' $1
  sed -i 's/  / /g' $1
elif [ "${version}" = "Darwin" ]
then
  sed -i '' 's/<C-v><tab>/  /g' $1 #这个地方指按下ctrl+v,然后再按一下tab,输出tab字符
  sed -i '' 's/  / /g' $1
fi
```

- [变量自增的方法](http://www.cnblogs.com/iloveyoucc/archive/2012/07/11/2585559.html)

## 字符串处理

[cnblogs](http://www.cnblogs.com/chengmo/archive/2010/10/02/1841355.html)

## sed

### mac(FreeBSD)

示例

```bash
sed -i '' -e '4a\
'${message} ${filename}
```

或

```bash
sed -i '' -e '4a\
shit' ${filename}
```

### linux

```bash
sed -i '4a\shit' ${filename}
```

或

```bash
sed -i '4a\'${message} ${filename}
```

[参数](https://www.cnblogs.com/ggjucheng/archive/2013/01/13/2856901.html)

## 计算字符长度

```bash
${#string}
```

## sleep

## read

## 数组

```bash
sh=()
sh+=(1)
sh+=(2)
for i in $sh
do
  echo $i
done
```

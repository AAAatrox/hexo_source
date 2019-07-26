---
title: hexo自定义排序
updated: 1552622263
date: 2019-02-24 20:24:51
tags:
 - hexo
 - shell
---

## 位置

`blog/_config.yml`:

```
index_generator:
  order_by:
    updated: -1 # -1表示降序
```

## updated脚本

```bash
for filename in *.md
do
  changed=$(git diff ${filename})
  changed_num=${#changed}
  if [ ${changed_num} -ge 10 ]
    # 计算修改程度
  then
    echo ${filename}
    echo ${changed_num}
    old=$(sed -n "3p" ${filename})
    new="${old#updated}"
    updated="updated: "$(date "+%s")
    if [ "${new}" != "${old}" ]
    then
      echo "${filename}" "has updated tab"
        # 有updated这一栏
      sed -i '' -e '3c \
      '${updated} ${filename}
    else
      echo "${filename}" "no updated tab"
        # 没有updated这一栏
      sed -i '' -e '3i \
      '${updated} ${filename}
    fi
  fi
done
```

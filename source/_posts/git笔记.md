---
title: git笔记
updated: 1563878950
date: 2019-01-20 10:49:06
tags:
 - git
---

- 不同版本文件对比

 - 同一文件

 ```bash
 git diff branch1 branch2 file
 ```

 - 不同文件

 ```bash
 git diff branch1:(绝对路径) branch2:(绝对路径)
 ```

- 查看远程仓库

```bash
git remote -v
```

- 增加仓库

```bash
git remote add 名字 地址
```

- 删除仓库

```bash
git remote rm 名字
```

### 从版本中删除(?)

```bash
git rm 文件 --cached
```

[博客园](http://www.cnblogs.com/flying_bat/p/4172435.html)
[stackoverflow](https://stackoverflow.com/a/30274113/10336529)

```bash
git filter-branch --tree-filter 'rm -f {file}' HEAD
```

- 删除本地分支

```bash
git branch -d branchname
```

- 重命名本地分支

```bash
git branch -m branchname1 branchname2
```

- 更新单个文件

```bash
git checkout origin/master path_to_file
```

- 恢复单个文件到历史版本

```bash
git checkout -- $filepath
git reset $commit_id $pathtofile
```

- 强制覆盖本地

```bash
git fetch
git reset --hard origin/master
git pull
```

- 修改remote

```bash
git remote set-url origin [url]
```

- 删除远程分支

```bash
git push origin --delete branchname
```

删除master需要在github上修改默认分支后才能删除

- 回复到上一版本

```bash
git reset --hard HEAD
git reset --hard HEAD^
git reset --hard HEAD^^
git reset --hard HEAD~100
```

- 回复到新版本

[廖雪峰](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/0013744142037508cf42e51debf49668810645e02887691000)

- 标签管理

略

- [显示新增文件](https://stackoverflow.com/questions/9000163/git-list-new-files-only)

 - 不需要`git add`

```bash
git ls-files --others --exclude-standard
git status --porcelain
```

 - 在`git add` 之后

```
git diff --name-only --diff-filter=A --cached # All new files in the index  
git diff --name-only --diff-filter=A          # All files that are not staged  
git diff --name-only --diff-filter=A HEAD     # All new files not yet committed
```

- 删除commits

- reset

```bash
git reset --soft HEAD~10
```

- 添加`.gitignore`后重新跟踪

```bash
git rm -r --cached .
git add .
```

- 子模块

---
title: git免验证
updated: 1557279782
date: 2019-02-17 10:16:38
tags:
 - git
 - ssh
---

## 法一

[详细](https://williamlfang.github.io/post/2018-09-05-github%E4%BD%BF%E7%94%A8ssh%E5%85%8D%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95/)

1. 设置全局

2. 生成ssh key

```bash
ssh-keygen -t rsa -C "1197225628@qq.com"
```

3. github.com$\to$`Settings`$\to$`SSH and GPG keys`$\to$`New SSH key`,将`./.ssh/id_rsa.pub`中的文本复制过去

4. 检查

```bash
ssh -T git@github.com
```

5. 不知道怎么办了(修改remote为ssh?)

## 法二

```bash
git config --global credential.helper store
```

取消自动保存(方便多个账号)

```bash
git config --global credential.helper ""
```

---
title: python之sklearn
updated: 1551018203
date: 2019-02-12 10:48:59
tags:
 - python
 - NumPy
 - sklearn
 - matplotlib
---

## NumPy

### ndarray

 - 切片

[菜鸟教程](http://www.runoob.com/numpy/numpy-ndexing-and-slicing.html)

 - 平均值
```python
a.mean()
```

## 模块导入

 - 训练测试分离

```python
from sklearn.model_selection import train_test_split
```

 - 可视化学习过程
```python
from sklearn.model_selection import learning_curve
```

## 函数调用

 - 均方误差评估

```python
cross_val_score(knn, X, y, cv = 10, scoring = 'neg_mean_squared_error')
```

前4个参数视具体情况而定

## 图像化工具`matplotlib`

 - 安装
```bash
python3 -m pip install matplotlib 
```

## 亂七八糟的問題

 - ubuntu

    1. `... return error code 1 ...`

    ```bash
    sudo apt-get intall python3-matplotlib
    ```

    2. `Consider using the '--user' option or check the permissions.`

    ```bash
    python -m pip install matplotlib --user
    ```

    3.  `No module named functools_lru_cache`

    取消注释原软件源

    ```bash
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install python-tk
    ```

 - mac

    1. `Cannot uninstall 'numpy'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall.`

    ```bash
    python -m pip install sklearn --ignore-installed --user
    ```

> 有些平台安装部分模块不能通过pip安装?

---
title: powerline配置
updated: 1553599520
date: 2019-03-26 18:51:14
tags:
 - Linux
 - powerline
---

本文中的powerline指的是

```bash
sudo apt-get install python3-pip
```

- [颜色表参考](https://blog.csdn.net/cp3alai/article/details/45509459)

- 颜色声明:`.config/powerline/color.json`

```json
{
  "colors": 
  {
    "0": 0,
    "1": 1,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9
  }
}
```

- `vim`显示信息:`.config/powerline/themes/vim/default.json`

```json
{
  "segments": {
    "left": [
      {
        "function": "powerline.segments.vim.plugin.capslock.capslock_indicator",
        "include_modes": ["i", "R", "Rv"],
        "priority": 10
      },
      {
        "function": "branch",
        "exclude_modes": ["nc"],
        "priority": 30
      },
      {
        "function": "readonly_indicator",
        "draw_soft_divider": false,
        "after": " "
      },
      {
        "function": "file_scheme",
        "priority": 20
      },
      {
        "function": "powerline.segments.shell.cwd",
        "priority": 60
      }
    ]
  }
}
```

- `vim`颜色设定:`.config/powerline/colorshemes/vim/default.json`
 - `ic`,`ix`:补全模式

- 符号设定:`.config/powerline/themes/powerline.json`

---
title: live2d搭建API
updated: 1557570937
date: 2019-04-27 18:11:03
tags:
 - php
 - javascript
 - live2d
---

# 原生js静态加载

## 使用cdn

### 遇到的问题(未解决)

- 图片跨源请求

```
Uncaught DOMException: Failed to execute 'texImage2D' on 'WebGLRenderingContext': The image element contains cross-origin data, and may not be loaded.
```

- 浏览器的CORS协议

```
Access to XMLHttpRequest at 'file:///home/lynx/webGL/assets/Epsilon/Epsilon.model.json' from origin 'null' has been blocked by CORS policy: Cross origin requests are only supported for protocol schemes: http, data, chrome, chrome-extension, https.
```

- 浏览器`json`加载失败

```
main.js:7588 Failed to load (0) : new/assets/Epsilon/Epsilon.model.json
```

## 不使用cdn

# php动态加载

> [参考fghrsh的API实现](https://www.fghrsh.net/post/123.html)

## 原代码分析

### 结构

- 后端(API)

```
live2d_api/-+-add/---index.php
            |
            +-get/---index.php
            |
            +-model/---{模型}/
            |
            +-rand/---index.php
            |
            +-rand_textures/---index.php
            |
            +-switch/---index.php
            |
            +-switch_textures/---index.php
            |
            +-tools/-+-jsonCompatible.php
            |        |
            |        +-modelList.php
            |        |
            |        +-modelTextures.php
            |        |
            |        `name-to-lower.php
            |
            `-model_list.json
```

- 前端(有改动)

```
live2d_fore/-+-lib/-+-jquery-ui.min.js
             |      |
             |      `-jquery.min.js
             |
             +-css/-+-font-awesome.min.css
             |      |
             |      +-flat-ui-icons-regular.eot
             |      |
             |      +-flat-ui-icons-regular.svg
             |      |
             |      +-flat-ui-icons-regular.ttf
             |      |
             |      +-flat-ui-icons-regular.woff
             |      |
             |      `-tips.css
             |
             +-live2d.min.js
             |
             +-autoload.js
             |
             +-tips.js
             |
             +-tips.json
             |
             `-fuck.json
```

### 文件功能

#### 前端

> `lib/`里面的是必备的jquery

> 由于作者使用了font-awesome图标,所以`font-awesome`和`flat-ui-icons-regular`都必备

- `autoload.js`: 主调度文件

- `tips.css`: 提示框的样式

- `live2d.min.js`: 看不懂,应该是整合了官方SDK的所有函数,和原版不兼容

- `tips.js`: 管理tips的显示

- `tips.json`: 鼠标事件相应的tips

- `fuck.json`: 自己写的本地嘴臭API

##### live2d.min.js

作者将`Live2DFramework`,`live2d.min.js`,`LAppDefine`,`LAppLive2DManager`,`LAppModel`,`PlatformManager`,`MatrixStack`,`ModelSettingJson`全部合并到了`live2d.min.js`(舍去`SampleApp`)

```javascript
! function(t) // 这个参数貌似也没有用
{
  ...; // 里面的东西貌似没用,直接删了
}([function(){}, function(){}, ..., function(){}]);
```

```javascript
function(t, e, i) // Live2DFramework
{
 ...,
 t.exports = {
    l2dtargetpoint: p,
    Live2DFramework: c,
    L2DViewMatrix: f,
    L2DPose: $,
    L2DPartsParam: u,
    L2DPhysics: l,
    L2DMotionManager: h,
    L2DModelMatrix: a,
    L2DMatrix44: _,
    EYE_STATE: g,
    L2DEyeBlink: s,
    L2DExpressionParam: n,
    L2DExpressionMotion: o,
    L2DBaseModel: r
  } 
}, // 约668
```

```javascript
function(t, e, i) // LAppDefine
{
  "use strict";
  t.exports = {
    ...
  }
}, // 约699
```

```javascript
function(t, e, i) // 不清楚哪一部分,和网页问候语有关
{
  ;
}, // 约714
```

```javascript
function(t, e, i) // MatrixStack
{
  ..., t.exports = r;
}, // 约747
```

```javascript
function(t, e, i) // 不知道干嘛的,删掉感觉没影响
{
  t.exports = i(5);
}
```

#### 后端

##### add

##### get

##### rand

##### rand_textures

##### switch

##### switch_textures

##### tools

## 重构(官方SDK + API)

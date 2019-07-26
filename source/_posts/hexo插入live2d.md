---
title: hexo插入live2d
updated: 1554647826
date: 2019-02-24 21:12:08
tags:
 - hexo
 - live2d
 - html
---

## 位置说明

> 注意不要重复使用一个API

### 文件位置

#### 保证能用

- fghrsh:`//live2d-cdn.fghrsh.net/assets/1.4.2/$file`
- zhangshuqiao:`https://cdn.jsdelivr.net/gh/stevenjoezhang/live2d-widget/$file`
- jsdelivr加载github:`https://cdn.jsdelivr.net/gh/NiaBie/live2d_lazy@version/$file`
- jquery和font-awesome什么的自己找

#### 基本不能用

- hexo加载(默认是在`source/`里面):`https://niabie.github.io/$dir/$file`
- github原码:`https://raw.githubusercontent.com/NiaBie/live2d_lazy/master/$file`

### hexo的样式文件

`blog/themes/next/layout/_layout.swig`:

- `<head>`最后一行:

```swig
{% include '_third-party/live2d_head' %}
```

- `<body>`最后一行:

```swig
{% include '_third-party/live2d_body' %}
```

添加文件请直接修改这两个文件,注意html注释(不要嵌套`<!-- -->`)!

 ---

## 使用xiazeyu的hexo-live2d-widget.js

### 安装

按照EYHN的手册用npm安装插件和模型

### 添加模型

手动下载zip,解压到`~/node_modules/`:

```
~/node_modules/${foldername}/--+--package.json
                               |
                               `--assets/-+-${name}.moc
                                          |
                                          +-${name}.model.json
                                          |
                                          +-textures/---${你的材质图}.png
                                          |
                                          +-modtions/---${动作}.mtn
                                          | # 以下可选
                                          +-expressions/---${没研究过}.json
                                          |
                                          +-sounds/--${你懂的}.mp3
                                          |
                                          +-${name}.physics # 不知道干嘛的
                                          |
                                          `-${name}.pose.json # 不知道干嘛的
```

- `${foldername}`随意,在`blog/_config.yml`中调用的模型名字为`${foldername}`
- `package.json`可以只留一对大括号
- `assert/`文件夹必须要有
- 注意模型的`json`文件后缀名为`model.json`,前缀名字随意
- 其余部分的命名都随意
- `package-lock.json`可不要

## zhangshuqiao的live2d-widget

### 启用

`<head>`:

- `<script src="$path/jquery.min.js"></script>`
- `<link rel="stylesheet" href="$path/font-awesome.min.css"/>`

`<body>`:

- `<script src="$path/autoload.js"></script>`

记得修改`autoload.js`中的github版本(安全的版本:`1.0.7`),其会调用:

- `live2d.min.js`
- `waifu-tips.js`
- `waifu-tips.json`

由于作者没有提供修改大小的api,所以只能直接在js里面调,建议设置:

```html
<div id="waifu">
    <div id="waifu-tips" style="opacity: 0; position: absolute; bottom: 210px; left: 10px;"></div>
    <canvas id="live2d" width="300" height="300" style="width:200px; height:200px; left:60px;"></canvas>
    <div id="waifu-tool" style="position:absolute; left:250px; top:-30px;"></div>
</div>
```

## fghrsh的live2d-demo和live2d-api

> 直接使用示例网站的api

### 用`autoload.js`加载

`<head>`:

- `<script src="$pathto/jquery.min.js"></script>`

`<body>`:
 
- `<script src="$pathto/autoload.js"></script>`

记得修改`autoload.js`中的github版本(安全的版本:`3.0.2`),其会调用:

- `waifu.min.css`
- `waifu-tips.json`
- `live2d.min.js`

直接向`autoload`中的`function()`增加参数,不需要使用`waifu-tips.js`

拖动效果需要另外的js,放在`<head>`或`<body>`(推荐)都可:

- `<script src="$pathto/jquery-ui.min.js"></script>`

注意需要:

- `flat-ui-icons-regular.eot` 
- `flat-ui-icons-regular.svg`
- `flat-ui-icons-regular.ttf`
- `flat-ui-icons-regular.woff`

#### 修改不同模型的位置

1. 修改`waifu-tips.js`

```javascript
loadlive2d('live2d', live2d_settings.modelAPI + 'get/?id=' + modelId + '-' + modelTexturesId, (live2d_settings.showF12Status ? console.log('[Status]', 'live2d', '模型', modelId + '-' + modelTexturesId, '加载完成') : null));
+++ var temp_body  = document.getElementsByTagName('body')[0];
+++ var temp_style = document.getElementById('live2d_lazy_data');
+++ if (temp_style == null)
+++ {
+++   var temp_style = document.createElement('style');
+++   temp_style.id = "live2d_lazy_data";
+++   temp_body.append(temp_style);
+++ }
+++ temp_style.modelId = modelId;
+++ temp_style.modelTexturesId = modelTexturesId;
```

通过在每次加载模型后,在`<body>`尾部创建/搜索一个没用的模型,将live2d的数据赋值给这个`<style>`

2. 增加`third_party/my_js/live2d.swig`

```html
<script>
function live2d_lazy_start(para) {
  setTimeout("live2d_lazy_execute()", para);
  setTimeout("live2d_lazy_execute()", para + 100);
  setTimeout("live2d_lazy_execute()", para + 1000);
}

function live2d_lazy_execute() {
  var temp_style = document.getElementById('live2d_lazy_data');
  // var live2d_lazy_sheet = document.getElementById('live2d').sheet;
  var live2d_lazy_model = document.getElementById('live2d');
  var live2d_lazy_tips = document.getElementsByClassName('waifu-tips')[0];
  var live2d_lazy_tool = document.getElementsByClassName('waifu-tool')[0];
  var modelTexturesId = temp_style.modelTexturesId;
  var modelId = temp_style.modelId;
  console.log('id: ' + modelId + ',texture: ' + modelTexturesId);
  switch (Number(modelId)) {
    case 1:
      var live2d_lazy_offset = 150;
      break;
    case 2:
      var live2d_lazy_offset = 135;
      break;
    case 3:
      var live2d_lazy_offset = 120;
      break;
    case 4:
      var live2d_lazy_offset = 120;
      break;
    case 5:
      var live2d_lazy_offset = 120;
      break;
    case 6:
    {
      switch (Number(modelTexturesId)){
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
          var live2d_lazy_offset = 85;
          console.log(live2d_lazy_offset);
          break;
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
        case 16:
        case 17:
        case 18:
          var live2d_lazy_offset = 50;
          console.log(live2d_lazy_offset);
          break;
        case 19:
        case 20:
          var live2d_lazy_offset = 0;
          console.log(live2d_lazy_offset);
          break;
      }
      break;
    }
    case 7:
      var live2d_lazy_offset = 150;
      break;
  }
  console.log(live2d_lazy_offset);
  live2d_lazy_model.style = "bottom: -" + live2d_lazy_offset + "px;";
  live2d_lazy_tips.style = "width: 170px; height: 70px; top: " + (live2d_lazy_offset + 150) + "px; font-size: 12px; opacity: 0;";
  live2d_lazy_tool.style = "font-size: 14px; top:" + (live2d_lazy_offset + 200) + "px;";
}
</script>
```

start函数是便于其他地方调用以及延迟效果使用(因为有可能页面加载后live2d还没加载好,所以需要重复执行,且这个时间很难估计)

3. `third_party/my_js/main.swig`

```html
<script>
setTimeout("my_init()", 0);
setTimeout("my_init()", 1000);
setTimeout("my_init()", 3000);
function my_init()
{
  var main_body = document.getElementsByTagName('body')[0];
  main_body.setAttribute('onresize', 'my_resize()');
  main_body.setAttribute('onload', 'my_resize()');
  main_body.setAttribute('onclick', 'live2d_lazy_start(50)');
  main_body.setAttribute('onmousemove', 'bar_hide()');
  bar_init();
  // window.onload = my_resize();
  // window.onresize = my_resize();
}
function my_resize()
{
  live2d_lazy_start(0);
  layout_resize();
  dfs_li_entry();
  table_resize();
}
</script>
```

这部分包含了hexo其他部分的js,会随时间而过时

### 内嵌`autoload.js`和`waifu-tips.js`

还没调好,不能用

`<head>`加`waifu.min.css`/`waifu.css`,css文件好像一定得静态存放

`<body>`加`jquery.min.js`,`jquery-ui.min.js`,`waifu-tips.min.js`,`live2d.min.js`

```html
<div class="waifu-tips"></div>
  <!--参数不要写上面,写源文件-->
  <canvas id="live2d"></canvas>
  <div class="waifu-tool">
    <span class="fui-home"></span>
    <span class="fui-chat"></span>
    <span class="fui-eye"></span>
    <span class="fui-user"></span>
    <span class="fui-photo"></span>
    <span class="fui-info-circle"></span>
    <span class="fui-cross"></span>
  </div>
</div>

/* 可直接修改部分参数 */
// 后端接口
live2d_settings['modelAPI'] = '//live2d.fghrsh.net/api/'; // 自建 API 修改这里
live2d_settings['tipsMessage'] = 'waifu-tips.json'; // 同目录下可省略路径
live2d_settings['hitokotoAPI'] = 'lwl12.com'; // 一言 API，可选 'lwl12.com', 'hitokoto.cn', 'jinrishici.com'(古诗词)

// 默认模型
live2d_settings['modelId'] = 1; // 默认模型 ID，可在 F12 控制台找到
live2d_settings['modelTexturesId'] = 53; // 默认材质 ID，可在 F12 控制台找到

// 工具栏设置
live2d_settings['showToolMenu'] = true; // 显示 工具栏          ，可选 true(真), false(假)
live2d_settings['canCloseLive2d'] = true; // 显示 关闭看板娘  按钮，可选 true(真), false(假)
live2d_settings['canSwitchModel'] = true; // 显示 模型切换    按钮，可选 true(真), false(假)
live2d_settings['canSwitchTextures'] = true; // 显示 材质切换    按钮，可选 true(真), false(假)
live2d_settings['canSwitchHitokoto'] = false; // 显示 一言切换    按钮，可选 true(真), false(假)
live2d_settings['canTakeScreenshot'] = false; // 显示 看板娘截图  按钮，可选 true(真), false(假)
live2d_settings['canTurnToHomePage'] = false; // 显示 返回首页    按钮，可选 true(真), false(假)
live2d_settings['canTurnToAboutPage'] = false; // 显示 跳转关于页  按钮，可选 true(真), false(假)

// 模型切换模式
live2d_settings['modelStorage'] = true; // 记录 ID (刷新后恢复)，可选 true(真), false(假)
live2d_settings['modelRandMode'] = 'switch'; // 模型切换，可选 'rand'(随机), 'switch'(顺序)
live2d_settings['modelTexturesRandMode'] = 'switch'; // 材质切换，可选 'rand'(随机), 'switch'(顺序)

// 提示消息选项
live2d_settings['showHitokoto'] = true; // 显示一言
live2d_settings['showF12Status'] = true; // 显示加载状态
live2d_settings['showF12Message'] = false; // 显示看板娘消息
live2d_settings['showF12OpenMsg'] = true; // 显示控制台打开提示
live2d_settings['showCopyMessage'] = true; // 显示 复制内容 提示
live2d_settings['showWelcomeMessage'] = true; // 显示进入面页欢迎词

//看板娘样式设置
live2d_settings['waifuSize'] = '200x250'; // 看板娘大小，例如 '280x250', '600x535'
live2d_settings['waifuTipsSize'] = '170x70'; // 提示框大小，例如 '250x70', '570x150'
live2d_settings['waifuFontSize'] = '12px'; // 提示框字体，例如 '12px', '30px'
live2d_settings['waifuToolFont'] = '14px'; // 工具栏字体，例如 '14px', '36px'
live2d_settings['waifuToolLine'] = '20px'; // 工具栏行高，例如 '20px', '36px'
live2d_settings['waifuToolTop'] = '0px' // 工具栏顶部边距，例如 '0px', '-60px'
live2d_settings['waifuMinWidth'] = '400px'; // 面页小于 指定宽度 隐藏看板娘，例如 'disable'(禁用), '768px'
live2d_settings['waifuEdgeSide'] = 'left:60'; // 看板娘贴边方向，例如 'left:0'(靠左 0px), 'right:30'(靠右 30px)
live2d_settings['waifuDraggable'] = 'unlimited'; // 拖拽样式，例如 'disable'(禁用), 'axis-x'(只能水平拖拽), 'unlimited'(自由拖拽)
live2d_settings['waifuDraggableRevert'] = false; // 松开鼠标还原拖拽位置，可选 true(真), false(假)

// 其他杂项设置
live2d_settings['l2dVersion'] = '1.4.2'; // 当前版本
live2d_settings['l2dVerDate'] = '2018.11.12'; // 版本更新日期
live2d_settings['homePageUrl'] = 'auto'; // 主页地址，可选 'auto'(自动), '{URL 网址}'
live2d_settings['aboutPageUrl'] = 'https://www.fghrsh.net/post/123.html'; // 关于页地址, '{URL 网址}'
live2d_settings['screenshotCaptureName'] = 'live2d.png'; // 看板娘截图文件名，例如 'live2d.png'
/* 在 initModel 前添加 */
initModel("https://raw.githubusercontent.com/NiaBie/live2d_lazy/master/waifu-tips.json")
</script>
```

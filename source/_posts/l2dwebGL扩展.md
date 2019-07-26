---
title: live2d SDK WebGL 功能扩展
updated: 1555689406
date: 2019-04-15 22:04:10
tags:
 - live2d
 - html
 - javascript
---

> 本文使用的SDK是`Live2D SDK WebGl 2.1`的`SampleApp1`

## 1 添加模型

- 在`LAppDefine.js`中增加路径

```javascript
MODEL_${NAME} : "assets/live2d/${name}/${name}.model.json"
```

- 在`LAppLive2DManager.js`中修改`changeModel`

```javascript
switch (no)
{
  ...;
  case num:
    this.releaseModel(1, gl); // 释放之前的模型
    this.releaseModel(0, gl); // 释放之前的模型
    // 如果之前加载的模型不止一个,注意要从后往前释放,否则下一个模型会卡死
    // 释放数量没有规定
    this.createModel(); // 创建模型
    this.models[0].load(gl, LAppDefine.${MODEL_NAME_1}, function()
    { // 加载多个模型
      thisRef.createModel();
      thisRef.models[1].load(gl, LAppDefine.${MODEL_NAME_2});// 也可以继续嵌套
      // (貌似嵌套的成功率要高些)
      thisRef.createModel();
      thisRef.models[2].load(gl, LAppDefine.${MODEL_NAME_2});
    } // 注意要按顺序create,否则会在当前模型卡死
    );
    /* this.models[0].load(gl, LAppDefine.${MODEL_NAME}); // 加载单个模型 */
}
```

- 为防止重合,可以创建多个`${name}.model.json`:

```json
{
  "layout":
  {
    "center_x": 0.5,
    "y": 1,
    "width": 1.9
  }
}
```

- 一般显示

```
script error
line 0
```

是`json`文件有语法错误

### (重构)自动切换模型

`LAppLive2DManager.js`

```javascript
LAppLive2DManager.prototype.changeModel = function(gl)
{
  console.log("--> LAppLive2DManager.update(gl)// (changeModel)");
  var tempNum = this.num;

  if (this.reloadFlg)
  {

    this.reloadFlg = false;
    var last_no = parseInt((this.count + LAppDefine[tempNum].MODELS.length - 1) % LAppDefine[tempNum].MODELS.length);
    var cur_no = parseInt(this.count % LAppDefine[tempNum].MODELS.length);

    if (Array.isArray(LAppDefine[tempNum].MODELS[last_no]))
    {
      for (var i = LAppDefine[tempNum].MODELS[last_no].length - 1; i >= 0; i --)
      {
        this.releaseModel(i, gl);
      }
    }
    else
    {
      this.releaseModel(0, gl);
    }
    if (Array.isArray(LAppDefine[tempNum].MODELS[cur_no]))
    {
      thisRef = this;
      this.createModel();
      this.models[0].load(gl, LAppDefine[tempNum].MODELS[cur_no][0], function () {
          for (var i = 1; i < LAppDefine[tempNum].MODELS[cur_no].length; i ++)
          {
          thisRef.createModel();
          thisRef.models[i].load(gl, LAppDefine[tempNum].MODELS[cur_no][i]);
          }
          })
    }
    else
    {
      this.createModel();
      this.models[0].load(gl, LAppDefine[tempNum].MODELS[cur_no]);
    }
  }
}
```

`LAppDefine.js`(其余见下文`多重canvas`),[参考:类的声明](http://www.ruanyifeng.com/blog/2012/07/three_ways_to_define_a_javascript_class.html)

```javascript
var myDefine = 
{
  ...
    width: 200,
  height: 300,

  VIEW_MAX_SCALE: 1.1, // 不想用这个功能
  VIEW_MIN_SCALE: 0.5,
  ...

  MODELS : null,

  MOTION_GROUP_IDLE : "idle", // 无操作
  MOTION_GROUP_TAP_BODY : "tap_body", // 点击身体
  MOTION_GROUP_FLICK_HEAD : "flick_head", 
  MOTION_GROUP_PINCH_IN : "pinch_in", // 放大至1.5
  MOTION_GROUP_PINCH_OUT : "pinch_out",  // 缩小至0.5
  MOTION_GROUP_SHAKE : "shake", 
  ...
};

var LAppDefine = new Array();

(function (){
  for (var i = minNum; i <= maxNum; i ++)
  {
  LAppDefine[i] = Object.create(myDefine);
  }
 
  LAppDefine[1].MODELS = [
  "assets/haru/haru_01.model.json",
  "assets/haru/haru_02.model.json",
  ];
 
  LAppDefine[0].MODELS = [ // 注意数组声明方式
  "assets/Epsilon/Epsilon.model.json",
  "assets/Epsilon2.1/Epsilon2.1.model.json",
  ];
 
  LAppDefine[2].MODELS = [
  "assets/haru/haru.model.json",
  ];
}());
```

- TODO
 - 2个模型是极限了,加载更多的会有bug

## 2 模型点击事件的实现

官方SDK只提供了2种点击事件:触摸`head`(`hit_areas: name`)触发表情随机,触摸`body`触发`tap_body`.若要额外增加事件(触摸特定部位触发`motion`,`sound`等),在`{name}.model.json`中添加

```
"hit_areas":
[
  {"name":"shit", "id":"D_REF.BODY"}
],
"motions":
{
  "tap_shit":
  [
    {"file":"motions/${}.mtn","fade_in":2000, "fade_out":2000}
  ]
}
```

- 其中`hit_areas: name`名字随意,但是之后需要在`LAppDefine.js`中定义一个变量与之对应
- `hit_areas: id`必须要和`cmox`/`moc`中部位的`id`对应.获取`id`的方法
 - 如果有源模型`cmox`:直接在`cubism`中的`Parts`窗口里面,打开某个元素的`Drawable Object`,显示例如`D_REF.BODY`之类的`id`
 - 只有`moc`:在`Viewer`中打开`{name}.model.json`,在下拉菜单中选择`Model Info`,打开某个元素的文件夹,打开`draw`文件夹,显示如`D_REF.BODY`的`id`

修改了`{name}.model.json`后在`LAppDefine`中增加

```javascript
MOTION_GROUP_TAP_SHIT : "tap_shit", // 对应json文件中"motions"的事件名
...
HIT_AREA_SHIT : "shit", // 对应json文件中"hit_areas"的区域"name"
```

- 每次鼠标点击时,`LAppLive2DManager.prototype.tapEvent`会调用`hitTest`

- `LAppModel.prototype.hitTest`会逐一判断点击位置(对比`name`,然后获得`id`),得到`id`后,调用`hitTestSimple`

> `LAppDefine`中`MOTION_GROUP_{EVENT}`对应`json`的`motions`下子事件(如`idle`,`tap_body`等),没有在`LAppDefine`声明的情况下不能够直接用`""`(这里和`Viewer`不一样),如果没有任何`motions`,`console`会提示`motions`加载错误

最后在`LAppLive2DManager.prototype.tapEvent`中增加

```javascript
...
else if (this.models[i].hitTest(LAppDefine.HIT_AREA_SHIT, x, y)) // 这里是你声明的区域名的名称
{
  this.models[i].startRandomMotion(LAppDefine.MOTION_GROUP_TAP_SHIT, // 这里是你声明的动作子事件的名称
                                     LAppDefine.PRIORITY_NORMAL); // 应该是覆盖掉PRIORITY较小的(如idle)motion
}
```

## 3 模型大小及放缩

放缩极限见`LAppDefine.js`

模型的放缩`SampleApp1.js`

```javascript
...
if (e.type == "mousewheel") // 鼠标滚轮事件
{
  /* 暂时感觉这几句完全是多余的,影响使用
  --- if (e.clientX < 0 || thisRef.canvas.clientWidth < e.clientX ||
  ---     e.clientY < 0 || thisRef.canvas.clientHeight < e.clientY)
  --- {
  ---   return;
  --- }
  */
  +++ if (e.clientX < 0 || e.clientY < 0)
  +++ {
  +++   return;
  +++ }
  
  if (e.wheelDelta > 0) modelScaling(1.1);// 放大
  else modelScaling(0.9);// 缩小
} else {...
```

> 未完待续

## 4 鼠标拖动

> 把`#glcanvas`和`#btnChange`的`position`和`z-index`先作调整

[菜鸟教程](http://www.runoob.com/jqueryui/example-draggable.html)

将按钮和画布绑定到父元素`div`,并且限定移动范围

```css
#drag1 
{
  position: fixed; // 相对屏幕不动
  width: 300px;
  height: 500px;
}

#glcanvas 
{
  background-size: 150%;
  background-position: 50% 50%;
  z-index: 0;
  bottom: 0px;
  right: 0px;
  position: relative; // 相对父元素定位
}

#btnChange 
{
  z-index: 2;
  left: 30px;
  bottom: 0px;
  position: relative;
}
```

```html
<script src="//apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
/* 必须要jquery支持 */
<script src="//apps.bdimg.com/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
/* 支持拖动 */
<script>
$(function() 
{
  $( "#drag1" ).draggable({ containment: document.body});// 限制在<body>内拖拽
});
</script>
```

live2d的canvas的`id`是`glcanvas`

## 5

没什么用处,删了

## 6 全局鼠标跟随

`SampleApp1.js`

```javascript
function followPointer(event)
{    
  // var rect = event.target.getBoundingClientRect(); // 没用了
  var the_div = document.getElementById("drag1"); // 获得父元素(可拖拽的div)
  // 这里不要直接用btn或canvas来计算偏移,因为他们还有一个父元素div
  var cx = event.clientX; 
  var cy = event.clientY;
  var rleft = the_div.offsetLeft; // 直接计算偏移,相对原代码会有<0.5%的误差
  var rtop = the_div.offsetTop;
  var sx = transformScreenX(cx - rleft);
  var sy = transformScreenY(cy - rtop);
  var vx = transformViewX(cx - rleft);
  var vy = transformViewY(cy - rtop);
  
  if (LAppDefine.DEBUG_MOUSE_LOG)
    l2dLog("onMouseMove device( x:" + cx + " y:" + cy + " ) view( x:" + vx + " y:" + vy + ")");

  // if (thisRef.drag) 不要通过鼠标点击来转头
  thisRef.lastMouseX = sx;
  thisRef.lastMouseY = sy;

  thisRef.dragMgr.setPoint(vx, vy); 
}
```

`tansform...`什么的函数都是调用`Live2DFramework.js`中的函数,这里不深入研究

- TODO:在canvas外的跟随鼠标,在模型缩小后延迟增加.同时在多重canvas中还会互相影响响应时间

 ---

> 对框架进行了重构,注意转换文件名

## 7 多重canvas

过程比较复杂,简单的说下思路,代码见[github](https://github.com/NiaBie/live2d_SDK_for_web)

- 将`sampleApp`这个函数作为对象声明,你要多少个canvas,数组就多大

`JSManager.js`

```javascript
document.write("<script src=\"new/live2d.js\"></script>");
document.write("<script src=\"new/LAppDefine.js\"></script>");
document.write("<script src=\"new/Live2DFramework.js\"></script>");
document.write("<script src=\"new/MatrixStack.js\"></script>");
document.write("<script src=\"new/ModelSettingJson.js\"></script>");
document.write("<script src=\"new/PlatformManager.js\"></script>");
document.write("<script src=\"new/LAppModel.js\"></script>");
document.write("<script src=\"new/LAppLive2DManager.js\"></script>");
document.write("<script src=\"new/SampleApp.js\"></script>");

var minTips = 2;// 严格对应编号
var maxTips = 4;
var thisMy = new Array();
var loadInterval = 300;

function sampleManager()
{
  var i = 0;
  for (i = minTips; i <= maxTips; i++)
  {
    var tempDrag = document.createElement("div");
    tempDrag.id = "drag_" + i;
    tempDrag.className = "drag";
    var tempTip = document.createElement("div");
    tempTip.id = "tip_" + i;
    tempTip.className = "tips";
    tempTip.setAttribute("style",
        "width: " + (LAppDefine[i].width + 50) + "px;" + 
        "left: " + (-25) + "px;" + 
        "margin: 0px 0px " + (-LAppDefine[i].height / 10) + "px 0px;"
        );
    tempDrag.appendChild(tempTip);
    var tempCanvas = document.createElement("canvas");
    tempCanvas.id = "glcanvas_" + i;
    tempCanvas.className = "glcanvas";
    tempCanvas.width = LAppDefine[i].width;
    tempCanvas.height = LAppDefine[i].height;
    tempDrag.appendChild(tempCanvas);
    var tempButton = document.createElement("button");
    tempButton.id = "btnChange_" + i;
    tempButton.className = "active btnChange";
    tempDrag.appendChild(tempButton);
    document.body.appendChild(tempDrag);
    setTimeout("new sampleApp(" + i + ")", (i - minTips) * loadInterval);
  }
  setTimeout("myDrag()", (maxTips - minTips + 1) * loadInterval);
}

function myDrag()
{
  $(".drag").draggable(
      {
containment: document.body
});
}
```

- 每个`sampleApp`要有一个`this.num`,对应`canvas`的编号
 - 在调用`sampleApp`的成员函数时,除了一些关于`id`的操作,基本上不要用到`this.num`
 - 在创建`LAppLive2DManager`,`L2DTargetPoint`,`L2DViewMatrix`时需要用`this.num`进行区分
 - 在除`sampleApp`模块外,其他的部分除了在新建对象时,基本上不需要依靠`this.num`进行区分

- 原来的`Live2D``window`全局变量和`LAppDefine`使用数组进行初始化

- (待定)`Live2DFramework`中只需要对`getPlatformManager`和`setPlatformManager`进行区分,但是现在关于`getPlatformManager`的作用不是特别清楚


## 8 多重tips功能

[参考:jad](https://imjad.cn/archives/lab/add-dynamic-poster-girl-with-live2d-to-your-blog-02)

> 需要`font-awesome`和`jquery`

- 每一个`canvas`改为

```html
<div id="drag_2" class="drag">
  <div class="tips" id="tip_2"></div>
  <canvas id="glcanvas_2" class="glcanvas" width=200 height=300 style="border:dashed 1px #CCC" draggable="true">
  </canvas>
  <button id="btnChange_2" class="active btnChange">Change Model</button>
</div>
```

> 注意`tip_`的下标是从2开始,可以使用多个`tip_{num}.json`,也可以只用一个

- `<head>`加载css和js

```html
<link rel="stylesheet" type="text/css" href="src/tips/tips.css">
<script async src="src/tips/tips.js"></script>
```

> 注意要加`async`

- 修改`tips.css`

```css
/* 其他的都没用了,删掉 */

.tips {
  position: relative;
  opacity: 0;
  width: 250px;
  height: 70px;
  margin: -20px -25px;
  padding: 5px 10px;
  border-radius: 12px;
  box-shadow: 0 3px 15px 2px rgba(191, 158, 118, 0.2);
  font-size: 14px;
  text-align: center;
  text-overflow: ellipsis;
  overflow: hidden;

  animation-delay: 5s;
  animation-duration: 50s;
  animation-iteration-count: infinite;
  animation-name: shake;
  animation-timing-function: ease-in-out;
}

#tip_2 {
  border: 1px solid rgba(172, 133, 253, 0.5);
  background-color: rgb(172, 133, 253, 0.62);
}

/* 自己对多重canvas添加样式 */

@keyframes shake {
}
```

- 把`tips.js`修改为支持多重canvas

```javascript
// 原来的带ajax的匿名函数删掉
// 对鼠标事件分别执行
(function () {
  $.getJSON("tips/tips.json", function (result) {
    $.each(result.mouseover, function (index, tips) {
      $(document).on("mouseover", tips.selector, function () {
        var temp_num = Number(tips.selector[tips.selector.length - 1]);
        var text = tips.text;
        if (Array.isArray(tips.text)) text = tips.text[Math.floor(Math.random() * tips.text.length + 1) - 1];
        text = text.render({
          text: $(this).text()
        });
        showMessage(text, 3000, temp_num);
      });
    });
    $.each(result.click, function (index, tips) {
      $(document).on("click", tips.selector, function () {
        var temp_num = Number(tips.selector[tips.selector.length - 1]);
        var text = tips.text;
        if (Array.isArray(tips.text)) text = tips.text[Math.floor(Math.random() * tips.text.length + 1) - 1];
        text = text.render({
          text: $(this).text()
        });
        showMessage(text, 3000, temp_num);
      });
    });
  });
})();

// 把一言api改成嘴臭api
function showHitokoto() {
  $.getJSON("tips/fuck.json" // 注意json格式不要写错了
  , function (result) {
    var randf = Math.random() * 1000;
    var randi = Math.floor(randf * 1000);
    var shit_len = result.fuck[0].shit.length;
    showMessage(result.fuck[0].shit[randi % shit_len], 5000, randi % maxTips + minTips);
  });
}

// 调用部分就不详细写了
function showMessage(text, timeout, num) {
  if (Array.isArray(text)) text = text[Math.floor(Math.random() * text.length + 1) - 1];
  if (num == -1) {
    for (num = minTips; num <= maxTips; num++) {
      $("#tip_" + num).stop();
      $("#tip_" + num).html(text).fadeTo(200, 1);
      if (timeout === null) timeout = 5000;
      hideMessage(timeout, num);
    }
  } else {
    $("#tip_" + num).stop();
    $("#tip_" + num).html(text).fadeTo(200, 1);
    if (timeout === null) timeout = 5000;
    hideMessage(timeout, num);
  }
}

function hideMessage(timeout, num) {
  $("#tip_" + num).stop().css('opacity', 1);
  if (timeout === null) timeout = 5000;
  $("#tip_" + num).delay(timeout).fadeTo(200, 0);
}
```

- 参考`tips.json`

```json
{
  "mouseover": [{
      "selector": "#drag_2",
      "text": ["干嘛呢你，快把手拿开", "鼠…鼠标放错地方了！"]
    }, {
      "selector": "#drag_3",
      "text": ["干嘛呢你，快把手拿开", "鼠…鼠标放错地方了！"]
    }  ],
  "click": [{
    "selector": "#drag_2",
    "text": ["是…是不小心碰到了吧", "萝莉控是什么呀", "你看到我的小熊了吗", "再摸的话我可要报警了！⌇●﹏●⌇", "110吗，这里有个变态一直在摸我(ó﹏ò｡)"]
  }, {
    "selector": "#drag_3",
    "text": ["是…是不小心碰到了吧", "萝莉控是什么呀", "你看到我的小熊了吗", "再摸的话我可要报警了！⌇●﹏●⌇", "110吗，这里有个变态一直在摸我(ó﹏ò｡)"]
  }]
}
```

- TODO
 - 仍有停不下来的bug

## 9 放缩canvas大小

这居然是个坑,由于官方的原因,在对`canvas`进行放缩的时候,根据`moc`文件(具体是建模过程中哪个步骤引起的不详)的不同,有的模型会实时进行比例放缩,有的不会,所以此功能暂时放弃

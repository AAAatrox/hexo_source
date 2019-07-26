---
title: html笔记
updated: 1555689219
date: 2019-02-27 21:24:22
tags:
 - html
 - css
 - javascript
---

## `<canvas>`放缩及调整位置

```html
<canvas id = "canvas" width = "300" height = "300" style = "width:200px; height:200px; left:60px"></canvas>
```

## 表格固定宽度

```html
<style>
  table
    th:first-of-type {width: 200px;}
    th:nth-of-type(2) {width: 200px;}
</style>
```

## 表格自适应宽度

```html
<script>
window.onresize = my_resize;
window.onload = my_resize;
function my_resize(){
  var x = window.innerWidth;
  sheet = document.getElementById('my_table').sheet;
  if (window.innerWidth < 950){
    sheet.addRule('table th:first-of-type, table th:nth-of-type(2)',
    'width: ' + x/7 + 'px;');
  }else{
    sheet.addRule('table th:first-of-type, table th:nth-of-type(2)',
    'width: ' + x/15 + 'px;');
  }
}
</script>
```

## js修改css

```html
document.styleSheets[0].addRule('.box', 'height: 100px');
document.styleSheets[0].insertRule('.box {height: 100px}', 0);
```
 
[参考](https://www.cnblogs.com/LiuWeiLong/p/6058059.html)
[w3plus](https://www.w3cplus.com/javascript/style-and-class.html)

元素里面的文字也算子节点

[js提取元素](https://www.jb51.net/article/61737.htm)

## `div`大小放缩示例

```javascript
<head>
  <script type="text/javascript">
    function mouse() {
      var direct = 0;
      e = window.event;
      if (e.wheelDelta) { //判断浏览器IE，谷歌滑轮事件             
        if (e.wheelDelta > 0) { //当滑轮向上滚动时
          change(1);
        }
        if (e.wheelDelta < 0) { //当滑轮向下滚动时
          change(-1);
        }
      } else if (e.detail) { //Firefox滑轮事件
        if (e.detail > 0) { //当滑轮向上滚动时
          change(1);
        }
        if (e.detail < 0) { //当滑轮向下滚动时
          change(-1);
        }
      }
    }

function change(num) {
  var b1 = document.getElementById('b1');
  var bit = b1.width/b1.height;
  if (num == 1) {
    b1.src = "/i/eg_mouse.jpg";
    b1.width += 2*bit;
    b1.height += 2;
    if (b1.style.left == "") {
      b1.style.left = "-" + bit + "px";
      b1.style.top = "-1px";
    } else {
      var temp = (Number(b1.style.left.replace(/px/, "")) - 1*bit).toString() + "px";
      // 注意toString加括号
      b1.style.left = temp;
      var temp = (Number(b1.style.top.replace(/px/, "")) - 1).toString() + "px";
      b1.style.top = temp;
    }
  } else {
    b1.src = "/i/eg_mouse2.jpg"
    b1.width -= 2*bit;
    b1.height -= 2;
    if (b1.style.left == "") {
      b1.style.left = bit + "px";
      b1.style.top = "1px";
    } else {
      var temp = (Number(b1.style.left.replace(/px/, "")) + 1*bit).toString() + "px";
      b1.style.left = temp;
      var temp = (Number(b1.style.top.replace(/px/, "")) + 1).toString() + "px";
      b1.style.top = temp;
    }
  }
}
  </script>
</head>

<body>
  <a href="http://www.w3school.com.cn" onmousewheel="mouse()">
    <img alt="Visit W3School!" src="/i/eg_mouse2.jpg" id="b1" style="position: fixed; top: 100px; left: 100px;" width="200px" height="100px" />
    <!-- 不要把width写进style -->
  </a>
</body>
```
```

---
title: hexo自定义配置
updated: 1553085822
date: 2019-03-01 17:38:34
tags:
 - hexo
 - javascript
 - html
 - css
---

## 链接和表格

`<head>`:`blog/themes/next/layout/_third-party`

前后加
```html
<style type="text/css"></style>
```

- 文章内链接

```css
.post-body p a{
  transition-duration: 0.4s;
  font-family: DejaVu Sans Mono;
  border: #ffffff 5px solid;
  color: #fc6423;
  font-weight: 700;
}

.post-body p a:hover{
  transition-property: background;
  transition-property: color;
  transition-duration: 0.1s, border-color;
  transition-duration: 1s;
  border-color: #999999;
  color: #ffffff;
  background: #999999;
}
```

- 表格

```css
.post-body td a{
  font-family: DejaVu Sans Mono;
  border: none;
  font-weight: 500;
  color: #fc6423;
}

.post-body td a:hover{
  transition-property: color;
  transition-duration: 0.1s;
  font-weight: 700;
  color: #ffffff;
}

.post-body th{
  font-size: 16px;
  font-family: DejaVu Sans Mono;
  font-weight: 800;
}

.post-body td:hover, .post-body th:hover{
  transition-property: background, color;
  transition-duration: 0.4s;
  color: #ffffff;
  background: #999999;
}

table{
  border: 5px #999999 solid;
  box-shadow: 8px 8px 5px #999999;
  border-radius: 15px;
}
```

 - 注意不要用`.post-block`,否则会将post链接也修改.
 - 因为不同页面大小,`.post-body p a`的`transition-duration`属性还有大小渐变效果.
 - 内嵌脚本好像不能用`&:`
 - `visited`不知道为什么用不了
 - 表格不会修边

[参考](https://blog.csdn.net/qw8880000/article/details/80235648)
[选择器排序问题](http://www.w3school.com.cn/css/css_link.asp)
[参考2](http://shenzekun.cn/hexo%E7%9A%84next%E4%B8%BB%E9%A2%98%E4%B8%AA%E6%80%A7%E5%8C%96%E9%85%8D%E7%BD%AE%E6%95%99%E7%A8%8B.html)

- 主体自适应宽度(不要加在`<head>`)

原变量名(在`blog/themes/next/source/css/_variables/`中的几个文件里)`$main-desktop`,`.container .main-inner`,`.footer-inner`和`.header`都用到该变量

```javascript
window.onresize = layout_resize;
window.onload = layout_resize;
sheet = document.getElementById('layout_style').sheet;
function layout_resize(){
  var x = window.innerWidth;
  if (x < 1200){
    sheet.addRule('.container .main-inner, .footer-inner, .header', 'width:95%'); 
  }else if (x < 1400){
    sheet.addRule('.container .main-inner, .footer-inner, .header', 'width:90%'); 
  }else{
    sheet.addRule('.container .main-inner, .footer-inner, .header', 'width:80%'); 
  }
}
```

- 修改list(`<li>`)样式
  
 - 增加list图标(font awesome) 

 ```javascript
 var my_body = document.getElementsByTagName('body')[0];
 window.onresize = dfs(my_body);
 window.onload = dfs(my_body);
 function myFunction(){
   var my = document.getElementsByTagName('li')[0];
   alert(my.tagName);
   alert(my.tagName == "LI");
 }
 function dfs(my_node){
   //alert(my_node.innerHTML);
   if (my_node.tagName == 'UL' && my_node.className == '')
   {
     my_node.className = "fa-ul";
   }
   if (my_node.tagName == 'LI' && my_node.className == '')
   {
     var my_tag = document.createElement('i');
     //my_tag.className = "fa-li fa fa-spinner fa-spin";
     my_tag.className = "fa-li fa fa-arrow-right";
     my_tag.style = "font-size:16px;";
     my_node.appendChild(my_tag);
     //my_node.insertBefore(my_tag, my_node.childNodes[0]);
   }
   var my_child = my_node.childNodes.length;
   for (var i = 0; i < my_child; i ++)
   {
     dfs(my_node.childNodes[i]);
   }
 }
 ```

 - 清除原有list

位置:`blog/themes/next/source/css/_common/components/post/post-expand.swig`,去掉
  
 ```css
 ul li { list-style: none; }
 ```

- 模块阴影

`blog/themes/next/source/css/_variables/Gemini.styl`

```styl
$box-shadow-inner
$box-shadow
```

 --- 

## 重要更新

之前写在md文件和`layout.swig`文件的`<script>`模块不知道为什么用不了了,使用`layout.swig`加载也没有用

现在直接在swig里面写javascript,位置:`third_party/my_js`,全部加载到`my_body.swig`里面,然后其中的`main.swig`全局上给元素增加监听属性(重点是增加监听属性,js位置不重要)

```html
<script>
  var main_body = document.getElementsByTagName('body')[0];
  main_body.setAttribute('onresize', 'layout_resize(), table_resize()');
  main_body.setAttribute('onload', 'layout_resize(), table_resize()');
</script>
```

针对不同文章,可以在md里面声明不同id的`<style>`,然后js中根据id来进行渲染,避免混乱,注意`<style>`要写在文章中间

现在使用的一些id

- `layout_style`:在`my_head.swig`,控制所有文章
- `live2d_table`:单个文章

 ---

##  重要更新

`third_party/my_js/main.swig`改成用`my_all`统一执行,注意函数执行的顺序

```html
<script>
  setTimeout("my_init()", 0);
  setTimeout("my_init()", 1000);
  setTimeout("my_init()", 3000);
  function my_init()
  {
    var main_body = document.getElementsByTagName('body')[0];
    main_body.setAttribute('onresize', 'my_all()');
    main_body.setAttribute('onload', 'my_all()');
    main_body.setAttribute('onclick', 'live2d_lazy_start(50)');
    // window.onload = my_all();
    // window.onresize = my_all();
  }
  function my_all()
  {
    live2d_lazy_start(0);
    layout_resize();
    dfs_li_entry();
    table_resize();
  }
</script>
```

 ---

## 自定义滚动条

### chrome

[demo及源码](http://www.xuanfengge.com/demo/201311/scroll/css3-scroll.html)

- 位置`theme/next/source/css/_custom/scrollbar.styl`
- 样例:

```css
::-webkit-scrollbar-track
{
  -webkit-box-shadow: inset 0 0 3px rgba(0,0,0,0.3);
  background-color: #eeeeee;
}

::-webkit-scrollbar
{
  width: 13px;
  background-color: #f5f5f5;
}

::-webkit-scrollbar-thumb
{
  background-color: #F90;
  background-image: -webkit-linear-gradient(90deg,
  rgba(255, 255, 255, .2) 25%,
  transparent 25%,
  transparent 50%,
  rgba(255, 255, 255, .2) 50%,
  rgba(255, 255, 255, .2) 75%,
  transparent 75%,
  transparent)
}

```

- 引入(`css/_custom/custom.styl`)

```css
@import "./scrollbar";
```

- 自动隐藏/显示(不太好的实现)

```html
<script>
function bar_init()
{
  document.styleSheets[2].addRule("::-webkit-scrollbar", "width: 3px;");
}
function bar_hide()
{
  var x_offset = window.innerWidth - event.x;
  var sheet = document.getElementById('layout_style');
  if (x_offset >= 30)
  {
    document.styleSheets[2].addRule("::-webkit-scrollbar", "width: 3px;");
  }
  else
  {
    document.styleSheets[2].addRule("::-webkit-scrollbar", "width: 10px;");
  }
}
</script>
```

缺点:会往css里面写一堆东西.文章主体宽度会突变

## 背景颜色

`css/_variables/Gemini.styl`

```css
$body-bg-color = #eee
```

## 插入pdf

[Adobe参数](https://www.adobe.com/content/dam/acom/en/devnet/acrobat/pdfs/pdf_open_parameters.pdf)

```html
<embed src="$file#toolbar=0&navpanes=0&scrollbar=0&zoom=120">
<object width="400" height="500" type="application/pdf" data="$file?#zoom=80&scrollbar=1&toolbar=1&navpanes=1">
```

- 对于`page`:`$pagename/$filename`
- 对于`_posts`:`$filename`


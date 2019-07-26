---
title: hexo主题制作
updated: 1563879966
date: 2019-05-02 17:24:56
tags:
 - hexo
 - javascript
 - html
 - css
 - swig
 - ejs
---

> 本文不对之后的主体优化再做记录

# ejs

- 代码参考[hexo-theme-material-x](https://github.com/xaoxuu/hexo-theme-material-x)
- [教程参考](https://segmentfault.com/a/1190000008040387)
- [辅助函数](https://www.jianshu.com/p/81ea81d291fd)

## 框架

```
{theme_name}/-+-script/ (现在还不知道是用来干嘛的,存放字体?)
              |
              +-source/-+-css/ 存放网页css,styl
              |         |
              |         `-js/ 存放网页js
              |
              `-layout/ 模板
```

## 模板

[官方说明](https://hexo.io/zh-cn/docs/templates.html)

主页默认继承`index.ejs`,其余所有页面,没有特别声明`layout`,都默认继承`post.ejs`

此外,如果存在`layout.ejs`,所有的模板都会将自身的`layout`填入`layout.ejs`的`<%- body %>`来重写`layout.ejs`

## 主体块自动调整宽度(节选)

```javascript
// 摘要块宽度,考虑两行并列
var b_padding = $(".mid_block").css("padding-left"); // padding转数字
var b_margin = $(".mid_block").css("margin-left"); // margin转数字
var rate = mid_block_rate(w_width);
if (b_padding)
{
  b_padding = (Number(b_padding.replace("px", "")));
  b_margin = (Number(b_margin.replace("px", "")));
  var b_offset = b_padding + b_margin;

  if (w_width < 1200)
  { // 半页,1列
    var b_width = w_width * rate;
    var b_left = (w_width - b_width) / 2 - b_offset; // 减去多余的padding
    $(".mid_block").css("width", b_width + "px");
    $(".mid_block").css("left", b_left + "px");
  }
  else
  { // 全页,2列
    b_offset *= 2;
    var b_width = w_width * rate;
    var b_left = (w_width - 2 * b_width) / 2 - b_offset; // 因为并排,所以要减去两个padding
    $(".mid_block").css("width", b_width + "px");
    $(".mid_block").css("left", b_left + "px");
  }
}
```

其中`mid_block_rate`是一个分段函数

### js笔记:ejs向javascript传参

```html
<script>
  var cur_page = '<%= page.current%> / <%= page.total%>';
</script>
<%- js('js/paginator') %>
```

## 页面页脚

为了防止`float`属性导致排版问题,页脚的`class`应和摘要块有交集

```html
<div class="shadow_block bottom_block">
  <p id="bottom_block_inner">
  <% if (page && page.posts) { %>
    <%= page.current %> / <%= page.total %>
  <% } else { %>
    1 / 1
  <% } %>
  </p>
</div>
```

同时宽度要足够大

```css
.bottom_block {
  /* 放在底部用于凑长度的块 */
  text-align: center;
  padding-top: 30px;
  padding-bottom: 30px; /* 凑高度 */
  padding-left: 0px;
  padding-right: 0px;
  margin-left: 0px;
  margin-right: 0px; /* 居中 */
  width: 100%;

  border-width: 0px;
  box-shadow: 0px 0px 0px;
}
```


## 归档页制作

hexo自带的npm模块:`blog/node_modules/hexo-generator-index/`

页面文章数量配置:`blog/_config.yml`

### ejs笔记:遍历

- [iterator遍历](https://www.jb51.net/article/70106.htm)

```html
<% page.posts.each(function(post){ %>
  <% if (is_home() || is_tag() || is_category()) { %>
    <!-- post带摘要 -->
    <style>
      embed {
        display: none; /* 防止找不到pdf报错 */
      }
    </style>
      <div class="mid_block shadow_block block_300">
        <%- partial('post.ejs', {
          post: post,
          page: page,
          post_num: post_num
        }) %>
      </div>
  <% } else if (is_archive()) { %>
      <!-- post只有标题 -->
      <div class="mid_block shadow_block block_100">
        <%- partial('post.ejs', {
          post: post,
          page: page,
          post_num: post_num
        }) %>
      </div>
  <% } %>
```

## 翻页

- post翻页:
 - `if (page.prev)`
 - `url_for(page.next.path)`/`urll_for(page.prev.path)`

- archive翻页:
 - `if (page.prev)`
 - `url_for(page.next_link)`/`url_for(page.prev_link)`

### js笔记:点击事件

```javascript
$(".right_tool_2").click(function () {
  location = '<%= url_for(page.next_link) %>';
  });
```

## 回到顶部/底部

### 顶部

jquery自带回到顶部的功能

```javascript
$(".right_tool_4").click(function () {
  $("html, body").animate({
    scrollTop: 0
  }, 300);
});
```

返回过程中无法中断

### 底部

由于浏览器对`scroll-behavior`的支持性不好,所以选择`scrollIntoView`来实现(同样有少部分浏览器不支持`smooth`效果)

```javascript
$(document).ready(function () {
  document.querySelectorAll(".right_tool_1")[0].onclick = function () {
    document.querySelectorAll(".bottom_block")[0].scrollIntoView({
      block: "end",
      behavior: "smooth"
    });
  };
});
```

#### js笔记

- 全页长度: `document.body.scrollHeight`

## 本地搜索功能

搜索功能需要RSS,现在使用现成的npm包来生成xml

可使用的包:`hexo-generator-search`,`hexo-generator-searchdb`(代码和前面那个一模一样,归属`next`主题的子项目)

然后在`source`里面自行编写`search.js`,`load.js`和`search.css`

向`layout.ejs`中插入

```html
<div class="shadow_block block_hide_top top_block">
  <!-- 隐藏在顶部 -->
  <span class="local-search-plugin">
      <input type="search" placeholder="Search" id="local-search-input" class="local-search-input-cls">
      <!-- placeholder:提示信息 -->
      <div id="local-search-result" class="local-search-result-cls"></div>
  </span>
</div>
```

### 文章链接解码(成中文)

```javascript
str += "<li><a href='" + unescape(decodeURI(data_url)) + "' class='search-result-title'>" + data_title + "</a>";
```

## latex公式渲染

见[hexo插入latex公式](https://niabie.github.io/2019/01/22/hexo%E6%8F%92%E5%85%A5latex%E5%85%AC%E5%BC%8F/)

> 国内一些垃圾浏览器渲染不正确很正常

## 代码块美化

> 注意取消hexo自带的highlight行号

### 高亮

hexo的`highlight.js`已经做了一部分语法分析,只需要进一步`dfs`区分关键字来美化,再重写css即可

关于换行和滚动条

```css
.code_pre {
  /* 强制换行必须要修改pre */
  word-break: break-all;
  white-space:pre-wrap; /* css3.0 */
  white-space:-moz-pre-wrap; /* Firefox */
  white-space:-pre-wrap; /* Opera 4-6 */
  white-space:-o-pre-wrap; /* Opera 7 */
  word-wrap: break-word;
}

.code_figure::-webkit-scrollbar-thumb {
  background-color: var(--molokai_grey);
  border-radius: 3px;
}

.code_figure::-webkit-scrollbar {
  background-color: rgb(56, 57, 52);
  height: 8px;
}

```

强制换行只有在`pre`中设置css样式才有效

### 显示语言类型(兼容性不是很好)

先一遍遍历

```javascript
function show_language() {
  document.querySelectorAll(".highlight").forEach(function(my_node) {
    var temp_class = my_node.className.replace(/highlight/, "");
    temp_class = temp_class.replace(/code_figure/, "");
    console.log(temp_class);
    my_node.setAttribute("language_type", temp_class);
  });
}
```

> styl格式文件

```css
.code_figure {
  /* 代码框 */
  border: 1px solid var(--shadow_grey);
  border-radius: 3px;
  background-color: var(--molokai_black);
  padding-left: 20px;
  padding-right: 20px;
  padding-top: 35px;

  font-size: 15px;
  position: relative;
  overflow-x: hidden;
  /* 防止溢出 */
  overflow-y: hidden;

  /* 显示语言类型 */
  &::before {
    background: #21252b;

    color: white;
    content: attr(language_type);
    text-indent: 15px;
    line-height: 38px;
    font-size: 16px;

    position: absolute;
    top: 0;
    left: 0;
    height: 38px;
    width: 100%;
    /* 会溢出 */

    font-family: 'DejaVu Sans Mono for Powerline';
    font-weight: bold;
    padding: 0px 80px;
  }

  &::after {
    content: "";
    position: absolute;
    margin-top: 13px;
    z-index: 3;

    width: 12px;
    height: 12px;
    top: 0;
    left: 20px;

    border-radius: 50%;
    background: #fc625d;
    box-shadow: 20px 0px #fdbc40, 40px 0px #35cd4b;
    /* 后两个圆是第一个的影子 */
  }
}
```

## 附加导航

由于bootstrap真的是个垃圾,所以此功能自己手动实现

首先借用`highlight`功能的dfs,对文章所有标题进行标记,其中需要记录`序号`(第几个)和`级数`(h1,h2,h2).然后按`序号`绑定跳转,跳转功能还是需要`scrollIntoView`来实现

```javascript
// 创建对象
function create_guide() {

  var left_block = document.getElementsByClassName("left_block")[0];

  var guide_title = document.createElement("a");// 跳转至标题
  guide_title.innerText = document.getElementById("post_name").innerText;
  guide_title.innerHTML = "<div id='guide_title'>" + guide_title.innerHTML + "</div>";

  dfs_h(document.body);// 搜索所有的1,2,3级标题

  var left_guide = document.createElement("div");
  left_guide.setAttribute("class", "left_guide");
  for (var i = 0; i < document.h_index; i ++)
  {// 设置序号和级数
    var temp_a = document.createElement("div");
    temp_a.id = "guide_" + i;
    temp_a.className = "guide_" + my_guide[i].rank;
    temp_a.innerHTML = "<a>" + my_guide[i].name.replace(/</g, "<&shy;") + "</a>";
    left_guide.appendChild(temp_a);
  }

  left_block.appendChild(guide_title);
  document.querySelector("#guide_title").onclick = function () {
    document.querySelector("#post_name").scrollIntoView({
      block: "start",
      behavior: "smooth"
    });
  };
  left_block.appendChild(left_guide);
  for (var i = 0; i < document.h_index; i ++)
  {
    document.querySelector("#guide_" + i).setAttribute("onclick", "add_scroll(" + i + ")");
  }
}
```

在dfs之后,监听滚动事件(和自动宽度调整一起执行)

```javascript
// 附加导航功能
function change_guide(direct)
{
  var w_top = $(window).scrollTop();
  var guide_1 = null; // 待修改的索引
  var guide_2 = null;
  var guide_3 = null;
  var guide_4 = null;
  var guide_5 = null;

  for (var i = 0; i < document.h_index; i ++)// h_index是section/guide的总数
  {
    var this_guide = document.getElementById("guide_" + i);
    if ((this_guide.className != "guide_1")
    &&(this_guide.className != "guide_2")
    &&(this_guide.className != "guide_3")
    &&(this_guide.className != "guide_4")
    &&(this_guide.className != "guide_5"))
    {
      $(this_guide).toggleClass("guide_active");// 关闭active属性
    }
  }

  for (var i = 0; i < document.h_index; i ++)// 从上往下遍历
  {
    var this_section = document.getElementById("section_" + i);
    var temp_offset = $("#section_" + i).offset().top - w_top;
    // console.log(i, temp_offset);
    if (temp_offset > 5) break;// 未到达的section
    if (this_section.className.match("section_1") != null) { // 有可能会有其他class名,比如使用了mathjax
      guide_1 = document.getElementById("guide_" + i);// 注意id寻找
      guide_2 = null;
      guide_3 = null;
      guide_4 = null;
      guide_5 = null;
    } else if (this_section.className.match("section_2") != null) {
      guide_2 = document.getElementById("guide_" + i);
      guide_3 = null;
      guide_4 = null;
      guide_5 = null;
    } else if (this_section.className.match("section_3") != null) {
      guide_3 = document.getElementById("guide_" + i);
      guide_4 = null;
      guide_5 = null;
    } else if (this_section.className.match("section_4") != null) {
      guide_4 = document.getElementById("guide_" + i);
      guide_5 = null;
    } else if (this_section.className.match("section_5") != null) {
      guide_5 = document.getElementById("guide_" + i);
    }
  }

  if (guide_1) {
    $(guide_1).toggleClass("guide_active");
  }
  if (guide_2) {
    $(guide_2).toggleClass("guide_active");
  }
  if (guide_3) {
    $(guide_3).toggleClass("guide_active");
  }
  if (guide_4) {
    $(guide_4).toggleClass("guide_active");
  }
  if (guide_5) {
    $(guide_5).toggleClass("guide_active");
  }
}
```

> 注意遍历的顺序

## 插入live2d

直接把所有文件合并然后和其他脚本扔上去就可以了

## 修改list样式

### 无序列表

#### 方案一:使用border

```css
.main_block ul li {
  list-style: none;
  margin-left: -5px;
  margin-top: 5px;
  padding-bottom: 5px;
  // 解决latex公式过挤的问题
  &::before {
    content: "";
    border: 5px solid var(--hover_blue);
    border-radius: 100%;
    
    margin-right: 10px;
    margin-top: 7px;
    float: left;
  }
  li {
    margin-left: -20px;
    &::before {
      border: 5px solid #ddd;
    }
    li {
      &::before {
        border: 5px solid #eee;
      }
    }
  }
}
```

缺点:可能会受字体,行距,latex渲染的影响,显示不正确

#### 方案二:使用字符编码

```css
.main_block ul li {
  list-style: none;
  margin-left: -5px;
  margin-top: 5px;
  padding-bottom: 5px;
  // 解决latex公式过挤的问题
  &::before {
    content: "\2022";
    font-size: 24px;
    left: -5px;
    bottom: 7px;
    color: var(--hover_blue);
    position: relative;
    float: left;

    text-shadow: 0px 0px 3px var(--link_blue);
  }
  li {
    margin-left: -20px;
    &::before {
      color: #999
      text-shadow: 0px 0px 3px #bbb;
    }
    li {
      &::before {
        color: #ccc
        text-shadow: 0px 0px 3px #eee;
      }
    }
  }
}
```

缺点:字体不能过大(当前24px是极限),否则会显示错误

### 有序列表

[参考,codeitdown](https://codeitdown.com/ordered-list-css-styles/)

#### 方案一 

```css
ol {
  list-style: none;
  counter-reset: li-counter;
}
ol > li{
  margin-top: 5px;
  padding-bottom: 5px;
  position: relative;
}
ol > li:before {
  position: absolute;
  top: 3px;
  left: -20px;
  width: 12px;
  height: 12px;
    
  text-align: center;
  font-size: 10px;
  color: white;
  overflow: hidden;
  // 防止超过10显示不正常

  border: 3px solid #c5c5c5;
  border-radius: 50%;
  background-color: #464646;
  content: counter(li-counter);
  counter-increment: li-counter;
}
```

#### 方案二

```css
ol {
  list-style: none;
  counter-reset: li-counter;
}
ol > li{
  margin-top: 5px;
  padding-bottom: 5px;
  position: relative;
}
ol > li:before {
  position: absolute;
  padding-right: 3px;
  left: -24px;
  height: 22px;
    
  color: #464646;
  font-weight: 1000;
  line-height: 1.2;
  border-right: 3px solid #c5c5c5;

  content: counter(li-counter) ".";
  counter-increment: li-counter;
}
```

## 文件说明

```
ejs/-+-layout/-+-partial/-+-head.ejs
     |         |          |
     |         |          +-header.ejs
     |         |          |
     |         |          +-archive.ejs
     |         |          |
     |         |          +-post.ejs
     |         |          |
     |         |          +-paginator.ejs
     |         |          |
     |         |          +-search.ejs
     |         |          |
     |         |          `-latex.ejs
     |         |
     |         +-index.ejs
     |         |
     |         +-layout.ejs
     |         |
     |         +-archive.ejs
     |         |
     |         +-tag.ejs
     |         |
     |         +-category.ejs
     |         |
     |         `-post.ejs
     |
     +-source/-+-css/-+-style.styl
     |         |      |
     |         |      +-block.css
     |         |      |
     |         |      +-tool.css
     |         |      |
     |         |      +-font.css
     |         |      |
     |         |      +-table.css
     |         |      |
     |         |      +-search.styl
     |         |      |
     |         |      +-code_normal.css
     |         |      |
     |         |      `-code_molokai.css
     |         |
     |         `-js/-+-change.js
     |               |
     |               +-guide.js
     |               |
     |               +-highlight.js
     |               |
     |               +-load.js
     |               |
     |               `-search.js
     |
     `-_config.yml
```

# swig

---
title: hexo修改代码块
updated: 1558057719
date: 2019-02-28 19:27:39
tags:
 - hexo
 - javascript
 - html
 - css
---

# 此文作废,相关内容请查看[hexo主题制作](https://niabie.github.io/2019/05/02/hexo%E4%B8%BB%E9%A2%98%E5%88%B6%E4%BD%9C/)

 ---

> 记得`hexo cl`

## 修改高亮+自动换行

1. 禁用hexo高亮

2. `<body>`插入

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/NiaBie/code_prettify@0.0.0/$pathtofile.css" type="text/css">
<script src="https://cdn.jsdelivr.net/gh/NiaBie/code_prettify@0.0.0/loader/prettify.js" type="text/javascript"></script>
<script type="text/javascript">
  $(document).ready(function() {
      $('pre').addClass('prettyprint linenums').attr('style', 'overflow:auto;');
      prettyPrint();
  });
</script>
```

3. css(`blog/themes/next/source/css/main.styl`)插入(添加到`_custom/custom.styl`)

```css
pre{
  word-break: break-all;
  white-space:pre-wrap; /* css3.0 */
  white-space:-moz-pre-wrap; /* Firefox */
  white-space:-pre-wrap; /* Opera 4-6 */
  white-space:-o-pre-wrap; /* Opera 7 */
  word-wrap:break-word; /* Internet Explorer 5.5+ */
}

code{
  font-style: bold;
  font-weight: 800;
}

table{
  line-height: 1.3;
}

td{
  ...
}

a{
  font-size: 15px;
  font-family: "DejaVu Sans Mono";
  font-style: italic;
  ...
}

p{
  ...
}
```

注意css样式的覆盖顺序

 - 参考地址

     - [溢出变成滚动条](http://masikkk.com/article/hexo-12-google-code-prettify/#%E8%87%AA%E5%8A%A8%E6%8D%A2%E8%A1%8C)
     - [代码参考](https://www.drunkdream.com/2017/06/03/hexo-set-code-highlight/)
     - [cnblog](http://www.cnblogs.com/zhangpengshou/archive/2012/08/08/2628737.html):css样式覆盖顺序

## 代码块显示语言类型

1. 启用hexo代码高亮,关闭其他高亮

2. 添加`blog/themes/next/script/codeblock.js`

```javascript
var attributes = [
  'autocomplete="off"',
  'autocorrect="off"',
  'autocapitalize="off"',
  'spellcheck="false"',
  'contenteditable="true"'
]

var attributesStr = attributes.join(' ')

hexo.extend.filter.register('after_post_render', function(data) {
  while (/<figure class="highlight ([a-zA-Z]+)">.*?<\/figure>/.test(data.content)) {
    data.content = data.content.replace(/<figure class="highlight ([a-zA-Z]+)">.*?<\/figure>/, function() {
      var language = RegExp.$1 || 'plain'
      var lastMatch = RegExp.lastMatch
      lastMatch = lastMatch.replace(/<figure class="highlight /, '<figure class="iseeu highlight /')
      return '<div class="highlight-wrap"' + attributesStr + 'data-rel="' + language.toUpperCase() + '">' + lastMatch + '</div>'
    })
  }
  return data
})
```

3. 修改`blog/themes/next/source/css/_common/components/highlight/highlight.js`

    - 调整滚动条,上下位置调整,右端显示问题
    
```css
$code-block{
  overflow: auto;
  margin: 34px -10px 0px 0px;
  padding: 0px 10px 0px 0px;
}
```

 - 添加代码

```css
highlight-wrap[data-rel] {
  position: relative;
  overflow: hidden;
  border-radius: 5px;
  box-shadow: 0 10px 30px 0px rgba(0,0,0,0.4);
  margin: 35px 0;
  ::-webkit-scrollbar {
    height: 10px;
  }

  ::-webkit-scrollbar-track {
      -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
      border-radius: 10px;
  }

  ::-webkit-scrollbar-thumb {
      border-radius: 10px;
      -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
  }
  &::before {
    color: white;
    content: attr(data-rel);
    height: 38px;
    line-height: 38px;
    background: #21252b;
    color: #fff;
    font-size: 16px;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    font-family: 'Source Sans Pro', sans-serif;
    font-weight: bold;
    padding: 0px 80px;
    text-indent: 15px;
    float: left;
  }
  &::after {
    content: " ";
    position: absolute;
    -webkit-border-radius: 50%;
    border-radius: 50%;
    background: #fc625d;
    width: 12px;
    height: 12px;
    top: 0;
    left: 20px;
    margin-top: 13px;
    -webkit-box-shadow: 20px 0px #fdbc40, 40px 0px #35cd4b;
    box-shadow: 20px 0px #fdbc40, 40px 0px #35cd4b;
    z-index: 3;
  }
}
```

padding右边的数值调大一些可以避免换行的一些bug

4. 隐藏底部的滚动条

在`codeblock.js`中作如下修改:

```javascript
...
lastMatch = lastMatch.replace(...)
+++ lastMatch = lastMatch.replace(/<\/span/, '<br><\/span')
```
使所有代码下面多出一行,然后修改`blog/themes/next/source/css/_common/components/highlight/highlight.styl`的`margin`或`padding`属性来屏蔽滚动条

5. 修改高亮风格

`blog/themes/next/_config.yml`使用`highlight_theme`:`my`,在`blog/themes/next/source/css/_common/components/highlight/theme.style`最后加上:

```sytl
if $highlight_theme == "my"
  $highlight-background   = #000510// 000000
  $highlight-current-line = #ff0000// 2a2a2a
  $highlight-selection    = #ff0000// 424242
  $highlight-foreground   = #ffffff// eaeaea normal-code
  $highlight-comment      = #969896// 969896 comment grey
  $highlight-red          = #50e7ff// d54e53 lightblue
  $highlight-orange       = #ffff44// e78c45 printf
  $highlight-yellow       = #ff0000// e7c547
  $highlight-green        = #647fff// b9ca4a string
  $highlight-aqua         = #00d7ff// 70c0b1 function main
  $highlight-blue         = #ff87ff// 7aa6da parathese yellow
  $highlight-purple       = #00ff73// c397d8 darkblue macro
  $highlight-gutter       = {
    color: lighten($highlight-background, 40%),
    bg-color: lighten($highlight-background, 16%)
  }
```

[参考](https://aoenian.github.io/2018/08/09/next-theme-customized-2/)
[空格符的处理](http://www.w3school.com.cn/css/css_text.asp)

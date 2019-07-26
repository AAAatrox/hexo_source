---
title: hexo插入latex公式
updated: 1557470921
date: 2019-01-22 11:43:05
tags:
 - latex
 - mathjax
 - katex
 - hexo
---

## mathjax

[参考](http://catx.me/2014/03/09/hexo-mathjax-plugin)

### 使用官方cdn(完整版功能,但是写latex公式可能不会都用到)

标准使用,`layout`中插入

```html
<!DOCTYPE html>
<script type="text/javascript" src="https://cdn.bootcss.com/mathjax/2.7.1/latest.js?config=TeX-AMS-MML_HTMLorMML"></script>

<script type="text/x-mathjax-config">
  $(document).ready(function()
  {
    MathJax.Hub.Config(
    {
      tex2jax:
      {
        inlineMath: [
          ['$', '$']
        ],
        processEscapes: true,
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code']
      }
    })

    MathJax.Hub.Queue(function()// 重新渲染
    {// 函数体内部不清楚作用
      var all = MathJax.Hub.getAllJax(),
      i;
      for (i = 0; i < all.length; i += 1)
      {
        all[i].SourceElement().parentNode.className += ' has-jax';
      }
    })
  });
</script>
```

### 使用自建的tex2jax(删减版,目前只测试过latex公式)

[官方参考(tex2jax)](https://docs.mathjax.org/en/latest/options/preprocessors/tex2jax.html)

```html
<!DOCTYPE html>
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    tex2jax: {inlineMath: [
      ["$","$"]
    ]}
  });
  MathJax.Hub.Queue(["Typeset", MathJax.Hub]);// 重新渲染
</script>
<script type="text/javascript" src="../MathJax.js?config=TeX-AMS_HTML-full"></script>
```

## katex

### 修改文章换行

因为垃圾katex不能处理换行的公式,所以需要一遍dfs来修改换行

```javascript
// 删除<p>内部换行,使katex正确渲染
$(document).ready(setTimeout(function()
{
  document.querySelectorAll("div div div p").forEach(function(temp_p){
    var my_child = temp_p.childNodes.length;

    for (var i = 0; i < my_child; i ++)
    {
      if (temp_p.childNodes[i].tagName == "BR")
      {
        temp_p.removeChild(temp_p.childNodes[i]);
        my_child --;
        i --;
      }
    }

    temp_p.innerText = temp_p.innerText.replace(/\n/g, "");
    temp_p.innerText = temp_p.innerText.replace(/\$\$\$\$/g, "$$$$\n$$$$");
    temp_p.innerText = temp_p.innerText.replace(/\$\$\$/g, "$\n$$$$");
  });
  /**/
  renderMathInElement(document.body,
  {
    // ...options...
    delimiters: [
      { left: "$$", right: "$$", display: true },
      { left: "$", right: "$", display: false }
      // { left: "\\[", right: "\\]", display: true }
    ]
  });
}, 500));// 删除元素不能进行得太早,不然会和highlight的dfs冲突
```

以上js只不能够解决如

```
$$
formula
$$
$formula$
```

的情况

然后在`layout`中加入

```html
<link rel="stylesheet" href="<%- theme.latex.katex %>/dist/katex.min.css" integrity="sha384-dbVIfZGuN1Yq7/1Ocstc1lUEm+AT+/rCkibIcC/OmWo5f0EA48Vf8CytHzGrSwbQ" crossorigin="anonymous">
<!-- The loading of KaTeX is deferred to speed up page rendering -->
<script defer src="<%- theme.latex.katex %>/dist/katex.min.js" integrity="sha384-2BKqo+exmr9su6dir+qCw08N2ZKRucY4PrGQPPWU1A7FtlCGjmEGFqXCv5nyM5Ij" crossorigin="anonymous"></script>
<!-- To automatically render math in text elements, include the auto-render extension: -->
<script defer src="<%- theme.latex.katex %>/dist/contrib/auto-render.min.js" integrity="sha384-kWPLUVMOks5AQFrykwIup5lo0m3iMkkHrD0uJ4H5cjeGihAutqP0yW0J6dpFiVkI" crossorigin="anonymous"></script>

<script>
  $(document).ready(setTimeout(function()
  {
    renderMathInElement(document.body,
    {
      // ...options...
      delimiters: [
        { left: "$$", right: "$$", display: true },
        { left: "$", right: "$", display: false }
        // { left: "\\[", right: "\\]", display: true }
      ]
    });
  }, 500));// 这500毫秒是为了给dfs时间
</script>
```

## hexo的markdown解析注意点

- 注意换行是`\\\\`
- `<`,`>`两边记得加空格(如果`<`之后直接接字母会被解析成html元素)
- 公式内部`_`转义:`\_`

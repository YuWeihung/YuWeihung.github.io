---
title: "Hugo 博客插入图片的方法"
date: 2021-09-04T18:10:47+08:00
draft: false
slug: "hugo-blog-picture"
categories: ["互联网"]
tags: ["Hugo"]
---

本文主要介绍了如何在 Hugo 静态博客中优雅地插入图片。

<!--more-->

## 如何显示图片

由于 Hugo 生成的是静态博客，因此插入图片是一件相对比较麻烦的事情。当然，一个简单的方法就是采用图床，不过大部分图床都需要收费，免费的也不能保证稳定性，而我们的博客所用的图片数量也并不算多，所以我们可以采取随 markdown 源文件一起存储的方法。

Hugo 普遍的新建博文的方式是 `hugo new posts/new-post.md`，这样我们可以将图片都存放在 `Blog/static/` 目录下，这样经过编译之后图片会存放到网站的根目录。不过如果这样，那么在编写博客的时候编辑器就没办法显示图片，只能凭感觉了。而放到其他目录时，编译后的网站又不能识别。

一个较为优雅的方式就是

```
hugo new posts/new-post/index.md
```

将新的博文创建成一个文件夹，将 markdown 源文件命名为 `index.md`，再在文件夹内创建 `pics` 文件夹，将图片放入该文件夹，在编写博文插入图片时使用相对路径，即 `pics/1.png`，这样在编辑器中就可以看到图片了。

而当网站编译完成之后，文件夹的格式就会如下所示

- first-post
  - pics
    - 1.png
  - index.html

`index.html` 文件与 `pics` 文件夹同级，网站同样也可以识别 html 文件中的图片路径。

## 改变图片大小和布局

解决了图片的存储位置之后，另一个问题就是如何改变图片的大小。

当我们采用 markdown 默认的图片插入方式，即 `![pic](pic.png)` 时，图片的宽度默认为编辑器的宽度，而且不能调节，这样当我们插入一些比较小的图片时也会占据很大的空间，非常影响文章的阅读体验。

这时我想到的一个方法就是采用 HTML 标签的方法来插入图片，即

```html
<img src="pic.png" width="50%" align="center" />
```

这样在编辑器中倒是可以正常显示，不过编译完之后图片全部变成左对齐了，这说明 `align` 没有发挥作用。

最终的解决方案是

```html
<center><img src="pic.png" width="50%" /></center>
```

这样就可以实现图片居中显示了。

## 显示图注

当文章的图片比较多的时候我们经常需要使用图注，当然我们可以直接这样

```html
<center><img src="pic.png" width="50%" /></center>
<center>图1</center>
```

不过显示效果较差，不太优雅。那么有没有什么比较好的办法呢？

答案是肯定的。Hugo 官方提供了一些 shortcodes 短代码，其中就包含插入图片的短代码 `figure`。上例可以用 `figure` 来较为优雅地解决。（去掉代码中的反斜杠）

```html
<center>\{\{< figure src="pic.png" width="50%" title="图1" >}}</center>
```

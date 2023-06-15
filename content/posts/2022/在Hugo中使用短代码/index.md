---
title: "在 Hugo 中使用短代码"
date: 2022-02-18T22:17:07+08:00
draft: false
slug: "hugo-shortcodes"
categories: ["互联网"]
tags: ["Hugo"]
---

本文主要介绍了 Hugo 中的短代码 Shortcodes。

<!--more-->

## 什么是短代码

我们采用 Markdown 来写博客是因为它的内容格式简单，但有时 Markdown 也不尽如人意。这时候，内容作者就被迫添加原始 HTML 代码到 Markdown 内容中去。这是与 Markdown 语法的优美简洁相矛盾的，因此 Hugo 创建了短代码来规避这些限制。短代码是内容文件中的一个简单片段，Hugo 将使用预定义的模板来呈现它。

## Hugo 的内置短代码

Hugo 附带了一组预定义的短代码，它们代表了非常常见的用法。提供这些短代码是为了方便作者并保持您的 Markdown 内容干净，比如 figure, gist, highlight, instagram 等。下面以 figure 为例来介绍。

`figure` 是 Markdown 中图像语法的扩展，可用的参数有：src, link, target, rel, alt, title, caption, class, height, width, attr 以及 attrlink。示例 figure 输入如下

```html
\{\{< figure src="/media/spf13.jpg" title="Steve Francia" >\}\}
```

它将被转化为如下的 html 代码

```html
<figure>
  <img src="/media/spf13.jpg" />
  <figcaption>
    <h4>Steve Francia</h4>
  </figcaption>
</figure>
```

## 自定义短代码

除了使用 Hugo 自带的短代码外，我们还可以自定义短代码。

要自定义短代码，我们需要在 `/layouts/shortcodes/` 目录下创建短代码文件，文件名为 “shortcode.html”。在 shortcode 中，可以通过 `.Get` 方法来访问参数。

要按名称访问参数，请使用 `.Get` 方法，后跟命名参数作为带引号的字符串：

```html
{{ .Get "class" }}
```

要按位置访问参数，请使用 `.Get` 后跟数字位置，记住位置参数是零索引的：

```html
{{ .Get 0 }} {{ .Get 1 }}
```

当输出取决于设置的参数时可以使用 `with`:

```html
{{ with .Get "class" }} class="{{ . }}"{{ end }}
```

当条件取决于任一值或两者时，`.Get` 也可用于检查是否提供了参数：

```html
{{ if or (.Get "title") (.Get "alt") }} alt="{{ with .Get "alt" }}{{ . }}{{ else
}}{{ .Get "title" }}{{ end }}"{{ end }}
```

下面以插入图片的短代码 `img.html` 为例来介绍。

```html
<!-- image -->
<figure class="align-center">
  <img
    src="assets/{{ .Get `src` }}#center"
    width="{{- if .Get `width` -}} {{ .Get `width` }}{{ else }} 60% {{- end -}}"
  />
  <figcaption>{{ with (.Get "title") -}} {{ . }} {{- end -}}</figcaption>
</figure>
```

上述代码实现了图片居中，自定义图片宽度（默认为 60%）及显示图注。

之后，我们就可以在 Markdown 文件中来使用该短代码

```markdown
\{\{< img src="/media/spf13.jpg" width="80%" title="Steve Francia" >}}
```

---

参考链接：

1. [Shortcodes](https://gohugo.io/content-management/shortcodes/)
2. [Create Your Own Shortcodes](https://gohugo.io/templates/shortcode-templates/)

---
title: "Hugo 显示 LaTeX 公式"
date: 2023-08-16T23:00:33+08:00
draft: false
slug: "hugo-latex"
categories: ["互联网"]
tags: ["Hugo", "LaTeX"]
---

本文介绍如何在 Hugo 中显示 \\(\LaTeX\\) 数学公式。

<!--more-->

### 1. 修改配置文件

在网站的配置文件中添加

```yaml
markup:
  goldmark:
    extensions:
      passthrough:
        delimiters:
          block:
            - - \[
              - \]
            - - $$
              - $$
          inline:
            - - \(
              - \)
        enable: true
params:
  math: true
```

### 2. 修改主题

添加 `layouts/partials/math.html` 文件

```html
<script
  id="MathJax-script"
  async
  src="https://cdn.jsdelivr.net.cn/npm/mathjax@3/es5/tex-chtml.js"
></script>
<script>
  MathJax = {
    tex: {
      displayMath: [
        ["\\[", "\\]"],
        ["$$", "$$"],
      ], // block
      inlineMath: [["\\(", "\\)"]], // inline
    },
  }
</script>
```

修改 `layouts/_default/baseof.html` 文件

```html
<head>
  ... {{ if .Param "math" }} {{ partialCached "math.html" . }} {{ end }} ...
</head>
```

### 3. 书写公式

然后就可以在 markdown 文件中写 \(\LaTeX\) 公式了。

```markdown
\\[
y = e^{x_1} + e^{x_2} + e^{x_3}
\\]

\\[
y^{'}_{x_1} = e^{x_1}
\\]
```

效果如下：
\\[
y = e^{x_1} + e^{x_2} + e^{x_3}
\\]

\\[
y^{'}_{x_1} = e^{x_1}
\\]

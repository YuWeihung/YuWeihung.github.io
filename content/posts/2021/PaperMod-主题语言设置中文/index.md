---
title: "PaperMod 主题语言设置中文"
date: 2021-12-03T22:18:55+08:00
draft: false
slug: "papermod-lang-zh"
categories: ["互联网"]
tags: ["Hugo"]
---

本文主要介绍了如何让 Hugo 的 PaperMod 主题的语言设置为中文。

<!--more-->

## 配置文件修改语言

首先肯定是修改 `config.yml` 文件

```yaml
languageCode: zh
defaultContentLanguage: zh

menu:
  main:
    - name: 归档
      url: archives
      weight: 10
    - name: 分类
      url: categories/
      weight: 20
    - name: 标签
      url: tags/
      weight: 30
    - name: 搜索
      url: search/
      weight: 40
```

这样大部分内容就显示成中文了，不过一些页面还是英文，这就需要我们进一步的修改。

## 归档和搜索页面

实现归档和搜索页面是我们在 `content` 目录下添加的 markdown 文件，要改为中文只需将其的 title 设为中文即可。

`archives.md`

```markdown
---
title: "归档"
layout: "archives"
url: "/archives"
summary: "archives"
---
```

`search.md`

```markdown
---
title: "搜索"
layout: "search"
summary: "search"
---
```

## 标签分类和文章页面

要将标签和分类等页面改为中文需要在对应文件夹下添加 `_index.md` 文件。

`content\categories\_index.md`

```markdown
---
title: "分类"
---
```

`content\tags\_index.md`

```markdown
---
title: "标签"
---
```

`content\posts\_index.md`

```markdown
---
title: "文章"
---
```

这样修改语言的工作就完成了。

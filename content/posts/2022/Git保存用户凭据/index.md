---
title: "Git 保存用户凭据"
date: 2022-04-22T21:21:40+08:00
draft: false
slug: "git-save-credential"
categories: ["Linux"]
tags: ["Git"]
---

本文介绍了如何在 Linux 下保存 Git 的用户凭据。

<!--more-->

在 Linux 的命令行中使用 Git 来推送提交的时候，默认并不会记住我们的用户凭据。我们每次推送的时候都需要手动输入账号和密码，这样就非常的麻烦。

如果想要让 Git 记住我们的用户凭据也很简单，只需要设置

```
git config --global credential.helper store
```

这样当我们下次输入密码时，用户凭据就会被保存在 `~/.git-credentials` 中，以后就不需要再手动输入了。

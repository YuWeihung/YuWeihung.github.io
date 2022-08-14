---
title: "Git commit 信息规范"
date: 2022-03-15T19:04:19+08:00
draft: false
slug: "git-commit-specification"
categories: ["Linux"]
tags: ["Git"]
---

本文主要介绍了 Git commit 信息的一些规范。

<!--more-->

## commit 信息格式

每次提交，Commit message 都包括三个部分：Header，Body 和 Footer。

```
<type>(<scope>): <subject>
// 空一行
<body>
// 空一行
<footer>
```

其中，Header 是必需的，Body 和 Footer 可以省略。

不管是哪一个部分，任何一行都不得超过 72 个字符（或 100 个字符）。这是为了避免自动换行影响美观。

## Header

Header 部分只有一行，包括三个字段：type（必需）、scope（可选）和 subject（必需）。

### type

用于说明 git commit 的类别，只允许使用下面的标识。

- feat：新功能（feature）。
- fix/to：修复 bug，可以是 QA 发现的 BUG，也可以是研发自己发现的 BUG。
  - fix：产生 diff 并自动修复此问题。适合于一次提交直接修复问题。
  - to：只产生 diff 不自动修复此问题。适合于多次提交。最终修复问题提交时使用 fix。
- docs：文档（documentation）。
- style：格式（不影响代码运行的变动）。
- refactor：重构（即不是新增功能，也不是修改 bug 的代码变动）。
- perf：优化相关，比如提升性能、体验。
- test：增加测试。
- chore：构建过程或辅助工具的变动。
- revert：回滚到上一个版本。
- merge：代码合并。
- sync：同步主线或分支的 Bug。

### scope

scope 用于说明 commit 影响的范围，比如数据层、控制层、视图层等等，视项目不同而不同。

### subject

subject 是 commit 目的的简短描述，不超过 50 个字符。

- 以动词开头，使用第一人称现在时，比如 change，而不是 changed 或 changes
- 第一个字母小写
- 结尾不加句号或其他标点符号

### 样例

```
fix(DAO): 用户查询缺少username属性
feat(Controller): 用户查询接口开发
```

## Body

Body 部分是对本次 commit 的详细描述，可以分成多行。下面是一个范例。

```
More detailed explanatory text, if necessary.  Wrap it to
about 72 characters or so.

Further paragraphs come after blank lines.

- Bullet points are okay, too
- Use a hanging indent
```

- 使用第一人称现在时，比如使用 change 而不是 changed 或 changes。
- 应该说明代码变动的动机，以及与以前行为的对比。

## Footer

Footer 部分只用于两种情况。

### 不兼容变动

如果当前代码与上一个版本不兼容，则 Footer 部分以 `BREAKING CHANGE` 开头，后面是对变动的描述、以及变动理由和迁移方法。

```
BREAKING CHANGE: isolate scope bindings definition has changed.

    To migrate the code follow the example below:

    Before:

    scope: {
      myAttr: 'attribute',
    }

    After:

    scope: {
      myAttr: '@',
    }

    The removed `inject` wasn't generaly useful for directives so there should be no code using it.
```

### 关闭 Issue

如果当前 commit 针对某个 issue，那么可以在 Footer 部分关闭这个 issue 。

```
Closes #234
```

也可以一次关闭多个 issue 。

```
Closes #123, #245, #992
```

---

参考链接：

1. [Commit message 和 Change log 编写指南 - 阮一峰的网络日志](https://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)

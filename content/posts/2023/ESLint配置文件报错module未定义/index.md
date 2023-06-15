---
title: "ESLint 配置文件报错 Module 未定义"
date: 2023-05-16T17:12:05+08:00
draft: false
slug: "eslint-module-not-define"
categories: ["前端"]
tags: ["eslint"]
---

使用 vite 新建了一个 react 的项目，通过 vscode 打开，发现 `.eslintrc.cjs` 文件报错："'module' is not defined"。经过查阅资料，发现原来是 vscode 的问题。ESLint 本来应该忽略以 `.` 开头的文件，但在 vscode 中没有生效。解决方案就是在 `.eslintrc.cjs` 文件中添加 node 环境。就像这样：

<!--more-->

```js
module.exports = {
  env: { browser: true, es2020: true, node: true },
  extends: [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:react-hooks/recommended",
  ],
  parser: "@typescript-eslint/parser",
  parserOptions: { ecmaVersion: "latest", sourceType: "module" },
  plugins: ["react-refresh"],
  rules: {
    "react-refresh/only-export-components": "warn",
  },
};
```

---

参考链接

1. [.eslintrc.js 'module' is not defined](https://stackoverflow.com/questions/70058316/eslintrc-js-module-is-not-defined)

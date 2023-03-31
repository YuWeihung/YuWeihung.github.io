---
title: "C++ Clang Format 设置"
date: 2023-03-28T23:05:59+08:00
draft: false
slug: "clang-format"
categories: ["编程语言"]
tags: ["C++", "Clang"]
---

本文介绍了如何使用 Clang Format 来格式化 C++ 代码。

<!--more-->

由于我平时使用 Java 较多，所以比较偏爱类似于 Java 的格式化风格。即大括号不换行，使用 4 个空格缩进等。

我的配置文件如下：

```
// 基于 LLVM 配置修改
BasedOnStyle: LLVM
// 语言 Cpp
Language: Cpp
// 使用空格而不是 Tab
UseTab: Never
// 缩进 4 字符
IndentWidth: 4
TabWidth: 4
// 访问修饰符（public）等靠左对齐
AccessModifierOffset: -4
// 最大列宽度
ColumnLimit: 90
// 是否允许短的函数，语句块等单独一行
AllowShortIfStatementsOnASingleLine: Never
AllowShortBlocksOnASingleLine: Empty
AllowShortFunctionsOnASingleLine: Empty
// 函数初始化元素右对齐
AlignArrayOfStructures: Right
// 函数返回值类型不换行
AlwaysBreakAfterReturnType: None
// 函数定义如果换行函数名需要缩进
IndentWrappedFunctionNames: true
// 函数的参数要么在同一行，要么各占一行
BinPackParameters: false
AllowAllParametersOfDeclarationOnNextLine: false
```

效果如下：

```cpp
#include <vector>
using namespace std;

class Solution {
public:
    void backTrack(vector<vector<int>> &ret,
                   vector<int> &cur,
                   const vector<int> &candidates,
                   int index,
                   int sum,
                   int target) {
        if (sum == target) {
            ret.emplace_back(cur);
            return;
        }
        else if (sum > target) {
            return;
        } else if (index == candidates.size()) {
            return;
        } else {
            cur.emplace_back(candidates[index]);
            sum += candidates[index];
            backTrack(ret, cur, candidates, index, sum, target);
            sum -= candidates[index];
            cur.pop_back();
            backTrack(ret, cur, candidates, index + 1, sum, target);
        }
    }

    vector<vector<int>> combinationSum(vector<int> &candidates, int target) {
        vector<vector<int>> ret;
        vector<int> cur;
        int sum = 0;
        int index = 0;
        backTrack(ret, cur, candidates, index, sum, target);
        return ret;
    }
};
```

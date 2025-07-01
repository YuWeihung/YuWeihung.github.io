---
title: "044：括号生成"
date: 2025-07-01T17:17:26+08:00
draft: false
slug: "lc-0022"
categories: ["高频面试题"]
tags: ["回溯", "组合型回溯"]
---

LeetCode 22

https://leetcode.cn/problems/generate-parentheses/description/

难度：中等

选或不选。选就是左括号，不选就是右括号。左右括号的数量需要有约束，open 是左括号的数量。open < n 限制左括号至多填 n 个，i - open < open 限制右括号至多填 open 个。

时间复杂度：分析回溯问题的时间复杂度，有一个通用公式：路径长度 × 搜索树的叶子数。对于本题，它等于 O(n⋅C(2n,n))。但由于左右括号的约束，实际上没有这么多叶子，根据 Catalan 数，实际的时间复杂度为 O(C(2n,n))。

空间复杂度：O(n)。返回值的空间不计入。

<!--more-->

```cpp
class Solution {
public:
    vector<string> generateParenthesis(int n) {
        int m = n * 2; // 括号长度
        vector<string> ans;
        string path(m, 0); // 所有括号长度都是一样的 m

        // 目前填了 i 个括号
        // 这 i 个括号中有 open 个左括号，i-open 个右括号
        auto dfs = [&](this auto&& dfs, int i, int open) {
            if (i == m) { // 括号构造完毕
                ans.emplace_back(path); // 加入答案
                return;
            }
            if (open < n) { // 可以填左括号
                path[i] = '('; // 直接覆盖
                dfs(i + 1, open + 1); // 多了一个左括号
            }
            if (i - open < open) { // 可以填右括号
                path[i] = ')'; // 直接覆盖
                dfs(i + 1, open);
            }
        };

        dfs(0, 0);
        return ans;
    }
};
```

---
title: "051：最长有效括号"
date: 2025-07-02T12:55:58+08:00
draft: false
slug: "lc-0032"
categories: ["高频面试题"]
tags: ["动态规划", "线性DP"]
---

LeetCode 32

https://leetcode.cn/problems/longest-valid-parentheses/description/

难度：困难

本题是一道一维 DP 的题目。f[i] 表示以 i 结尾的最长有效括号的长度。由于有效括号只会以 ')' 结尾，所以只在当前字符为 ')' 时的状态转移。

当前一个字符为 '(' 时，转移到 f[i] = f[i - 2] + 2。

当第 i - f[i - 1] - 1 个字符为 '(' 时，将原本不连续的两段长度合并，即转移到 f[i] = f[i - 1] + f[i - f[i - 1] - 2] + 2。

时间复杂度： O(n)，其中 n 为字符串的长度。我们只需遍历整个字符串一次，即可将 dp 数组求出来。

空间复杂度： O(n)。我们需要一个大小为 n 的 dp 数组。

<!--more-->

```cpp
class Solution {
public:
    int longestValidParentheses(string s) {
        int n = s.size();
        if (n == 0) {
            return 0;
        }
        vector<int> f(n, 0);
        for (int i = 1; i < n; i++) {
            if (s[i] == ')') {
                if (s[i - 1] == '(') {
                    if (i - 2 >= 0) {
                        f[i] = f[i - 2] + 2;
                    } else {
                        f[i] = 2;
                    }
                } else if (i - f[i - 1] - 1 >= 0 &&
                           s[i - f[i - 1] - 1] == '(') {
                    if (i - f[i - 1] - 2 >= 0) {
                        f[i] = f[i - 1] + f[i - f[i - 1] - 2] + 2;
                    } else {
                        f[i] = f[i - 1] + 2;
                    }
                }
            }
        }
        return *max_element(f.begin(), f.end());
    }
};
```

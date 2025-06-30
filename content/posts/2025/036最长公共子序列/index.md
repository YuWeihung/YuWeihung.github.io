---
title: "036：最长公共子序列"
date: 2025-06-30T21:50:35+08:00
draft: false
slug: "lc-1143"
categories: ["高频面试题"]
tags: ["动态规划", "线性DP"]
---

LeetCode 1143

https://leetcode.cn/problems/longest-common-subsequence/description/

难度：中等

LCS 线性 DP 问题，状态转移方程如下：

```cpp
if (s[i] == t[j]) {
    f[i + 1][j + 1] = f[i][j] + 1;
} else {
    f[i + 1][j + 1] = max(f[i + 1][j], f[i][j + 1]);
}
```

时间复杂度：O(nm)。

空间复杂度：O(nm)。

<!--more-->

```cpp
class Solution {
public:
    int longestCommonSubsequence(string s, string t) {
        int m = s.size(), n = t.size();
        vector f(m + 1, vector<int>(n + 1, 0));
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (s[i] == t[j]) {
                    f[i + 1][j + 1] = f[i][j] + 1;
                } else {
                    f[i + 1][j + 1] = max(f[i + 1][j], f[i][j + 1]);
                }
            }
        }
        return f[m][n];
    }
};
```

---
title: "085：不同路径"
date: 2025-07-05T23:02:09+08:00
draft: false
slug: "lc-0062"
categories: ["高频面试题"]
tags: ["动态规划", "网格图DP"]
---

LeetCode 62

https://leetcode.cn/problems/unique-paths/description/

难度：中等

基础的网格图 DP。

时间复杂度：O(mn)。

空间复杂度：O(mn)。

<!--more-->

```cpp
class Solution {
public:
    int uniquePaths(int m, int n) {
        vector f(m + 1, vector<int>(n + 1, 0));
        f[0][1] = 1;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                f[i + 1][j + 1] = f[i + 1][j] + f[i][j + 1];
            }
        }
        return f[m][n];
    }
};
```

---
title: "071：最小路径和"
date: 2025-07-04T19:21:45+08:00
draft: false
slug: "lc-0064"
categories: ["高频面试题"]
tags: ["动态规划", "网格图DP"]
---

LeetCode 64

https://leetcode.cn/problems/minimum-path-sum/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

网格图 DP 题目。f 数组初始化为 INF，f[0][1] = 0。

```
f[i + 1][j + 1] = min(f[i + 1][j], f[i][j + 1]) + grid[i][j];
```

时间复杂度：O(mn)，其中 m 和 n 分别为 grid 的行数和列数。

空间复杂度：O(mn)。

<!--more-->

```cpp
class Solution {
public:
    int minPathSum(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector f(m + 1, vector<int>(n + 1, INT_MAX));
        f[0][1] = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                f[i + 1][j + 1] = min(f[i + 1][j], f[i][j + 1]) + grid[i][j];
            }
        }
        return f[m][n];
    }
};
```

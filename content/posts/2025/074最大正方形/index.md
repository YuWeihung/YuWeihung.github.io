---
title: "074：最大正方形"
date: 2025-07-04T19:22:20+08:00
draft: false
slug: "lc-0221"
categories: ["高频面试题"]
tags: ["动态规划", "子矩阵DP"]
---

LeetCode 221

https://leetcode.cn/problems/maximal-square/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

二维 DP，状态转移方程如下，并在计算 f 数组的时候维护正方形边长的最大值。

```cpp
f[i + 1][j + 1] = min({f[i + 1][j], f[i][j + 1], f[i][j]}) + 1;
```

时间复杂度：O(mn)，其中 m 和 n 是矩阵的行数和列数。需要遍历原始矩阵中的每个元素计算 dp 的值。

空间复杂度：O(mn)，其中 m 和 n 是矩阵的行数和列数。创建了一个和原始矩阵大小相同的矩阵 dp。由于状态转移方程中的 dp(i,j) 由其上方、左方和左上方的三个相邻位置的 dp 值决定，因此可以使用两个一维数组进行状态转移，空间复杂度优化至 O(n)。

<!--more-->

```cpp
class Solution {
public:
    int maximalSquare(vector<vector<char>>& matrix) {
        int m = matrix.size(), n = matrix[0].size();
        vector f(m + 1, vector<int>(n + 1, 0));
        int mx = 0;
        f[0][1] = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (matrix[i][j] == '1') {
                    f[i + 1][j + 1] =
                        min({f[i + 1][j], f[i][j + 1], f[i][j]}) + 1;
                    mx = max(mx, f[i + 1][j + 1]);
                }
            }
        }
        return mx * mx;
    }
};
```

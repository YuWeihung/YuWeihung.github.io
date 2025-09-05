---
title: "170：三角形最小路径和"
date: 2025-07-15T19:02:55+08:00
draft: false
slug: "lc-0120"
categories: ["高频面试题"]
tags: ["动态规划", "网格图DP"]
---

LeetCode 120

https://leetcode.cn/problems/triangle/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

f[i][j] = min(f[i+1][j],f[i+1][j+1]) + triangle[i][j]

时间复杂度：O(n^2)，其中 n 为 triangle 的长度。

空间复杂度：O(n^2)。

<!--more-->

```cpp
class Solution {
public:
    int minimumTotal(vector<vector<int>>& triangle) {
        int n = triangle.size();
        vector f(n, vector<int>(n));
        f[n - 1] = triangle[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            for (int j = 0; j <= i; j++) {
                f[i][j] = min(f[i + 1][j], f[i + 1][j + 1]) + triangle[i][j];
            }
        }
        return f[0][0];
    }
};
```

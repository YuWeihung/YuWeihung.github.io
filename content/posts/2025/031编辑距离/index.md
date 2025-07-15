---
title: "031：编辑距离"
date: 2025-06-29T23:07:49+08:00
draft: false
slug: "lc-0072"
categories: ["高频面试题"]
tags: ["动态规划", "线性DP"]
---

LeetCode 72

https://leetcode.cn/problems/edit-distance/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这是线性 DP 的经典题目，类似 LeetCode 1143 最长公共子序列。

状态转移方程为：

```cpp
//word1[i] == word2[j]
f[i + 1][j + 1] = f[i][j];
//word1[i] != word2[j]
f[i + 1][j + 1] = min({f[i + 1][j], f[i][j + 1], f[i][j]}) + 1;
```

在不相等时，三种情况分别对应插入，删除，替换的情况。

此外，还要注意数组的初始化操作。

```cpp
f[i + 1][0] = i + 1;
f[0][j + 1] = j + 1;
```

时间复杂度：O(nm)，其中 n 为 word1 的长度，m 为 word2 的长度。

空间复杂度：O(nm)。

<!--more-->

```cpp
class Solution {
public:
    int minDistance(string word1, string word2) {
        int m = word1.size(), n = word2.size();
        vector f(m + 1, vector<int>(n + 1, 0));
        for (int j = 0; j < n; j++) {
            f[0][j + 1] = j + 1;
        }
        for (int i = 0; i < m; i++) {
            f[i + 1][0] = i + 1;
            for (int j = 0; j < n; j++) {
                if (word1[i] == word2[j]) {
                    f[i + 1][j + 1] = f[i][j];
                } else {
                    f[i + 1][j + 1] = min({f[i][j + 1], f[i + 1][j], f[i][j]}) + 1;
                }
            }
        }
        return f[m][n];
    }
};
```

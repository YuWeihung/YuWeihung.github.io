---
title: "072:旋转图像"
date: 2025-07-04T19:22:03+08:00
draft: false
slug: "lc-0048"
categories: ["高频面试题"]
tags: ["思维题"]
---

LeetCode 48

https://leetcode.cn/problems/rotate-image/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

怎样 O(1)旋转矩阵？

答案是先将矩阵转置，再将矩阵的每行翻转。

时间复杂度：\(O(n^2)\)，其中 n 是 matrix 的行数和列数。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    void rotate(vector<vector<int>>& matrix) {
        int n = matrix.size();

        // 第一步：转置
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                swap(matrix[i][j], matrix[j][i]);
            }
        }

        // 第二步：行翻转
        for (auto &row: matrix) {
            reverse(row.begin(), row.end());
        }
    }
};
```

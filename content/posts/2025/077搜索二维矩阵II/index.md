---
title: "077：搜索二维矩阵II"
date: 2025-07-04T19:22:57+08:00
draft: false
slug: "lc-0240"
categories: ["高频面试题"]
tags: ["双指针"]
---

LeetCode 240

https://leetcode.cn/problems/search-a-2d-matrix-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

排除法。比较剩余矩阵右上角的元素 matrix[i][j] 和 target。如果更小，说明这一行所有元素都小于 target，i++。如果更大，说明这一列所有元素都大于 target，j--。直到找到 target 或矩阵为空。

时间复杂度：O(m+n)，其中 m 和 n 分别为 matrix 的行数和列数。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    bool searchMatrix(vector<vector<int>>& matrix, int target) {
        int m = matrix.size(), n = matrix[0].size();
        int i = 0, j = n - 1; // 从右上角开始
        while (i < m && j >= 0) { // 还有剩余元素
            if (matrix[i][j] == target) {
                return true; // 找到 target
            }
            if (matrix[i][j] < target) {
                i++; // 这一行剩余元素全部小于 target，排除
            } else {
                j--; // 这一列剩余元素全部大于 target，排除
            }
        }
        return false;
    }
};
```

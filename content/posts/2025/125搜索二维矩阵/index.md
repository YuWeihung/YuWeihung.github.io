---
title: "125：搜索二维矩阵"
date: 2025-07-15T19:01:42+08:00
draft: false
slug: "lc-0074"
categories: ["高频面试题"]
tags: ["二分查找", "矩阵"]
---

LeetCode 74

https://leetcode.cn/problems/search-a-2d-matrix/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

二分查找，二分开区间为 [-1, mn]，对于 mid，对应元素为 matrix[mid / n][mid % n]。

时间复杂度：O(log(mn))，其中 m 和 n 分别为 matrix 的行数和列数。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    bool searchMatrix(vector<vector<int>>& matrix, int target) {
        int m = matrix.size(), n = matrix[0].size();
        int left = -1, right = m * n;
        while (left + 1 < right) {
            int mid = left + (right - left) / 2;
            int x = matrix[mid / n][mid % n];
            if (x == target) {
                return true;
            }
            (x < target ? left : right) = mid;
        }
        return false;
    }
};
```

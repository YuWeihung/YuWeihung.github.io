---
title: "152：二维数组中的查找"
date: 2025-07-15T19:02:22+08:00
draft: false
slug: "lcr-0121"
categories: ["高频面试题"]
tags: ["双指针", "矩阵"]
---

LCR 121

https://leetcode.cn/problems/er-wei-shu-zu-zhong-de-cha-zhao-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

时间复杂度：O(m + n)

空间复杂度：O(1)

<!--more-->

```cpp
class Solution {
public:
    bool findTargetIn2DPlants(vector<vector<int>>& plants, int target) {

        int m = plants.size();
        if (m == 0) {
            return false;
        }
        int n = plants[0].size();
        if (n == 0) {
            return false;
        }
        int i = 0, j = n - 1;
        while (i < m && j >= 0) {
            if (plants[i][j] == target) {
                return true;
            }
            if (plants[i][j] > target) {
                j--;
            } else {
                i++;
            }
        }
        return false;
    }
};
```

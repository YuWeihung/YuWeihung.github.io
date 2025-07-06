---
title: "086：乘积最大子数组"
date: 2025-07-05T23:02:16+08:00
draft: false
slug: "lc-0152"
categories: ["高频面试题"]
tags: ["动态规划", "线性DP"]
---

LeetCode 152

https://leetcode.cn/problems/maximum-product-subarray/description/

难度：中等

动态规划，类似 LeetCode 53 最大子数组和。由于负负得正，需要维护以 i 结尾的连续子数组乘积的最大值和最小值。

```cpp
f_max[i] = max({f_max[i - 1] * x, f_min[i - 1] * x, x});
f_min[i] = min({f_max[i - 1] * x, f_min[i - 1] * x, x});
```

时间复杂度：O(n)，其中 n 是 nums 的长度。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
public:
    int maxProduct(vector<int>& nums) {
        int n = nums.size();
        vector<int> f_max(n), f_min(n);
        f_max[0] = f_min[0] = nums[0];
        for (int i = 1; i < n; i++) {
            int x = nums[i];
            // 把 x 加到右端点为 i-1 的（乘积最大/最小）子数组后面，
            // 或者单独组成一个子数组，只有 x 一个元素
            f_max[i] = max({f_max[i - 1] * x, f_min[i - 1] * x, x});
            f_min[i] = min({f_max[i - 1] * x, f_min[i - 1] * x, x});
        }
        return *max_element(f_max.begin(), f_max.end());
    }
};
```

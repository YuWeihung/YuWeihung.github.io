---
title: "007：最大子数组和"
date: 2025-06-27T13:25:44+08:00
draft: false
slug: "lc-0053"
categories: ["高频面试题"]
tags: ["前缀和", "动态规划"]
---

LeetCode 53

https://leetcode.cn/problems/maximum-subarray/description/

难度：中等

本题有两种做法，分别是前缀和以及动态规划。

前缀和的做法为维护最小前缀和，答案为当前前缀和减去最小前缀和。

动态规划的转移方程为 \(f[i] = max(f[i-1],0) + nums[i]\)。

时间复杂度：O(n)，其中 n 为 nums 的长度。

空间复杂度：O(1)。仅用到若干额外变量。

<!--more-->

前缀和：

```cpp
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        int ans = INT_MIN;
        int min_pre_sum = 0;
        int pre_sum = 0;
        for (int x: nums) {
            pre_sum += x;
            ans = max(ans, pre_sum - min_pre_sum);
            min_pre_sum = min(min_pre_sum, pre_sum);
        }
        return ans;
    }
};
```

动态规划：

```cpp
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        int ans = INT_MIN; // 注意答案可以是负数，不能初始化成 0
        int f = 0;
        for (int x : nums) {
            f = max(f, 0) + x;
            ans = max(ans, f);
        }
        return ans;
    }
};
```

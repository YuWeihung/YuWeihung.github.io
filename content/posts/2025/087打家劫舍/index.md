---
title: "087：打家劫舍"
date: 2025-07-05T23:02:23+08:00
draft: false
slug: "lc-0198"
categories: ["高频面试题"]
tags: ["动态规划", "线性DP"]
---

LeetCode 198

https://leetcode.cn/problems/house-robber/description/

难度：中等

状态转移：

```cpp
f[i + 2] = max(f[i + 1], f[i] + nums[i]);
```

时间复杂度：O(n)。其中 n 为 nums 的长度。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
public:
    int rob(vector<int>& nums) {
        int n = nums.size();
        vector<int> f(n + 2);
        for (int i = 0; i < n; i++) {
            f[i + 2] = max(f[i + 1], f[i] + nums[i]);
        }
        return f[n + 1];
    }
};
```

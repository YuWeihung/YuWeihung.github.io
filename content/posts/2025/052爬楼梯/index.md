---
title: "052：爬楼梯"
date: 2025-07-02T22:26:00+08:00
draft: false
slug: "lc-0070"
categories: ["高频面试题"]
tags: ["动态规划", "线性DP"]
---

LeetCode 70

https://leetcode.cn/problems/climbing-stairs/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

斐波那契数列。f[i] = f[i - 1] + f[i - 2]。

时间复杂度：O(n)。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
public:
    int climbStairs(int n) {
        vector<int> f(n + 1, 0);
        f[0] = 1;
        f[1] = 1;
        for (int i = 2; i <= n; i++) {
            f[i] = f[i - 1] + f[i - 2];
        }
        return f[n];
    }
};
```

---
title: "142：连续子数组的最大和"
date: 2025-07-15T19:02:07+08:00
draft: false
slug: "lcr-0161"
categories: ["高频面试题"]
tags: ["动态规划", "前缀和"]
---

LCR 161

https://leetcode.cn/problems/lian-xu-zi-shu-zu-de-zui-da-he-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题与 LeetCode 53 相同。

这里使用动态规划方法。 f[i + 1] = max(f[i], 0) + sales[i]。

时间复杂度：O(n)，其中 n 为 sales 数组的长度。我们只需要遍历一遍数组即可求得答案。

空间复杂度：O(n)。我们只需要常数空间存放若干变量。

<!--more-->

```cpp
class Solution {
public:
    int maxSales(vector<int>& sales) {
        int n = sales.size();
        vector<int> f(n + 1, 0);
        for (int i = 0; i < n; i++) {
            f[i + 1] = max(f[i], 0) + sales[i];
        }
        return *max_element(f.begin(), f.end());
    }
};
```

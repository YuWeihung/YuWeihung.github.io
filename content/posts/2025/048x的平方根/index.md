---
title: "048：x 的平方根"
date: 2025-07-01T20:32:58+08:00
draft: false
slug: "lc-0069"
categories: ["高频面试题"]
tags: ["二分答案"]
---

LeetCode 69

http://leetcode.cn/problems/sqrtx/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题是找满足 i \* i <= x 的最大 i。i 越小越满足要求，i 越大越不满足要求，答案具有单调性，可以二分答案。

本题是“求最大”类型的题目，与“求最小”类型不同。左边是满足要求的，染成蓝色，右边是不满足要求的，染成红色。满足条件时更新 left = mid，最后也返回 left。

时间复杂度：O(logx)。
空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int mySqrt(int x) {
        long long left = 0, right = (long long)x + 1;
        while (left + 1 < right) {
            long long mid = left + (right - left) / 2;
            if (mid * mid <= x) {
                left = mid;
            } else {
                right = mid;
            }
        }
        return (int)left;
    }
};
```

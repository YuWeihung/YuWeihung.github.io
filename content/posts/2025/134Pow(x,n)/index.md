---
title: "134：Pow(x,n)"
date: 2025-07-15T19:01:54+08:00
draft: false
slug: "lc-0050"
categories: ["高频面试题"]
tags: ["快速幂"]
---

LeetCode 50

https://leetcode.cn/problems/powx-n/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

快速幂。

时间复杂度：O(log∣n∣)。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    double myPow(double x, int N) {
        double ans = 1;
        long long n = N;
        if (n < 0) { // x^-n = (1/x)^n
            n = -n;
            x = 1 / x;
        }
        while (n) { // 从低到高枚举 n 的每个比特位
            if (n & 1) { // 这个比特位是 1
                ans *= x; // 把 x 乘到 ans 中
            }
            x *= x; // x 自身平方
            n >>= 1; // 继续枚举下一个比特位
        }
        return ans;
    }
};
```

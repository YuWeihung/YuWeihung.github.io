---
title: "153：斐波那契数列"
date: 2025-07-15T19:02:24+08:00
draft: false
slug: "lcr-0126"
categories: ["高频面试题"]
tags: ["动态规划"]
---

LCR 126

https://leetcode.cn/problems/fei-bo-na-qi-shu-lie-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

<!--more-->

```cpp
class Solution {
public:
    int fib(int n) {
        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return 1;
        }
        int MOD = 1e9 + 7;
        int f0 = 0, f1 = 1;
        int f2;
        for (int i = 2; i <= n; i++) {
            f2 = (f0 + f1) % MOD;
            f0 = f1;
            f1 = f2;
        }
        return f2;
    }
};
```

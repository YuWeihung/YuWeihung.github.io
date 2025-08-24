---
title: "148：青蛙跳台阶问题"
date: 2025-07-15T19:02:16+08:00
draft: false
slug: "lcr-0127"
categories: ["高频面试题"]
tags: ["动态规划"]
---

LCR 127

https://leetcode.cn/problems/qing-wa-tiao-tai-jie-wen-ti-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

跳台阶。

时间复杂度 O(n) ： 计算 f(n) 需循环 n 次，每轮循环内计算操作使用 O(1) 。

空间复杂度 O(1) ： 几个标志变量使用常数大小的额外空间。

<!--more-->

```cpp
class Solution {
public:
    int trainWays(int num) {
        const int MOD = 1e9 + 7;
        if (num < 2) {
            return 1;
        }
        int x = 1, y = 1;
        int s;
        for (int i = 2; i <= num; i++) {
            s = (x + y) % MOD;
            x = y;
            y = s;
        }
        return s;
    }
};
```

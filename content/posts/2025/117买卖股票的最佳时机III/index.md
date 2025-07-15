---
title: "117：买卖股票的最佳时机III"
date: 2025-07-15T19:01:33+08:00
draft: false
slug: "lc-0123"
categories: ["高频面试题"]
tags: ["动态规划", "状态机DP"]
---

LeetCode 123

https://leetcode.cn/problems/best-time-to-buy-and-sell-stock-iii/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题是至少可以完成 k 次交易的股票买卖问题。

数组需要增加一维 k， f[n + 1][k + 2][2]。在买入（或卖出）时将剩余交易次数减一。

初始化 f[0][j][0] = 0，其他元素为 -INF。

时间复杂度：O(n)，其中 n 为 prices 的长度。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int n = prices.size();
        const int k = 2;
        vector f(n + 1, vector<array<int, 2>>(k + 2, {INT_MIN / 2, INT_MIN / 2}));
        for (int j = 1; j <= k + 1; j++) {
            f[0][j][0] = 0;
        }
        for (int i = 0; i < n; i++) {
            for (int j = 1; j <= k + 1; j++) {
                f[i + 1][j][0] = max(f[i][j][0], f[i][j][1] + prices[i]);
                f[i + 1][j][1] = max(f[i][j][1], f[i][j - 1][0] - prices[i]);
            }
        }
        return f[n][k + 1][0];
    }
};
```

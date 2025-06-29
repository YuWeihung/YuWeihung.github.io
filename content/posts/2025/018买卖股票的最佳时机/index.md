---
title: "018：买卖股票的最佳时机"
date: 2025-06-29T11:56:37+08:00
draft: false
slug: "lc-0121"
categories: ["高频面试题"]
tags: ["贪心"]
---

LeetCode 121

https://leetcode.cn/problems/best-time-to-buy-and-sell-stock/description/

难度：简单

贪心题目，枚举第 i 天之前价格的最小值，作为买入价格。

时间复杂度：O(n)，其中 n 为 prices 的长度。

空间复杂度：O(1)。仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int ans = 0;
        int min_price = prices[0];
        for (int p : prices) {
            ans = max(ans, p - min_price);
            min_price = min(min_price, p);
        }
        return ans;
    }
};
```

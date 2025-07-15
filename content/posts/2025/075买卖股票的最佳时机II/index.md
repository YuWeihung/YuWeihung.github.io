---
title: "075：买卖股票的最佳时机 II"
date: 2025-07-04T19:22:32+08:00
draft: false
slug: "lc-0122"
categories: ["高频面试题"]
tags: ["动态规划", "状态机DP"]
---

LeetCode 122

https://leetcode.cn/problems/best-time-to-buy-and-sell-stock-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

买卖股票类题目一般都是状态机 DP。f[i][0] 不持有股票，f[i][1] 持有股票。答案是 f[n][0]。初始化 f[0][0] = 0，f[0][1] = INT_MIN。

注意二维的 DP 数组，vector<int[2]> f(n + 1) 会比 vector<vector<int>> 更快，如果数组长度固定，尽量使用 array 而不是 vector。

时间复杂度：O(n)，其中 n 为 prices 的长度。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
public:
    int maxProfit(vector<int>& prices) {
        int n = prices.size();
        // f[i][0] 不持有股票，f[i][1] 持有股票
        vector<int[2]> f(n + 1);
        f[0][1] = INT_MIN;
        for (int i = 0; i < n; i++) {
            f[i + 1][0] = max(f[i][0], f[i][1] + prices[i]);
            f[i + 1][1] = max(f[i][1], f[i][0] - prices[i]);
        }
        return f[n][0];
    }
};
```

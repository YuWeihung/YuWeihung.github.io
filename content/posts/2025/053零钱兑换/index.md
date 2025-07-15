---
title: "053：零钱兑换"
date: 2025-07-02T22:29:31+08:00
draft: false
slug: "lc-0322"
categories: ["高频面试题"]
tags: ["动态规划", "完全背包"]
---

LeetCode 322

https://leetcode.cn/problems/coin-change/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

完全背包题目。与 0-1 背包的不同是转移方程中右边的 i 变成 i + 1，说明可以重复取同一个元素。

```cpp
f[i + 1][c] = min(f[i][c], f[i + 1][c - w[i]] + v[i])
```

时间复杂度：O(n⋅amount)，其中 n 为 coins 的长度。

空间复杂度：O(n⋅amount)。

<!--more-->

```cpp
class Solution {
public:
    int coinChange(vector<int>& coins, int amount) {
        int n = coins.size();
        vector f(n + 1, vector<int>(amount + 1, INT_MAX / 2)); // 除 2 防止下面 + 1 溢出
        f[0][0] = 0;
        for (int i = 0; i < n; i++) {
            for (int c = 0; c <= amount; c++) {
                if (c < coins[i]) {
                    f[i + 1][c] = f[i][c];
                } else {
                    f[i + 1][c] = min(f[i][c], f[i + 1][c - coins[i]] + 1);
                }
            }
        }
        int ans = f[n][amount];
        return ans < INT_MAX / 2 ? ans : -1;
    }
};
```

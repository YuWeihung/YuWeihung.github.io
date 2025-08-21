---
title: "132：零钱兑换II"
date: 2025-07-15T19:01:51+08:00
draft: false
slug: "lc-0518"
categories: ["高频面试题"]
tags: ["动态规划", "完全背包"]
---

LeetCode 518

https://leetcode.cn/problems/coin-change-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

完全背包题目。

dfs(i, c) = dfs(i − 1, c) + dfs(i, c − coins[i])

时间复杂度：O(n⋅amount)，其中 n 为 coins 的长度。

空间复杂度：O(n⋅amount)。

<!--more-->

```cpp
class Solution {
public:
    int change(int amount, vector<int>& coins) {
        int n = coins.size();
        // 和答案无关的转移可能会溢出，从而报错
        // 为了避免报错，使用 unsigned
        vector f(n + 1, vector<unsigned>(amount + 1));
        f[0][0] = 1;
        for (int i = 0; i < n; i++) {
            for (int c = 0; c <= amount; c++) {
                if (c < coins[i]) {
                    f[i + 1][c] = f[i][c];
                } else {
                    f[i + 1][c] = f[i][c] + f[i + 1][c - coins[i]];
                }
            }
        }
        return f[n][amount];
    }
};
```

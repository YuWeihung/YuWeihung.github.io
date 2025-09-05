---
title: "171：鸡蛋掉落"
date: 2025-07-15T19:02:57+08:00
draft: false
slug: "lc-0887"
categories: ["高频面试题"]
tags: ["动态规划"]
---

LeetCode 887

https://leetcode.cn/problems/super-egg-drop/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

定义状态为 dfs(i,j)，表示在有 i 次操作机会和 j 枚鸡蛋的情况下，可以让我们能确定 f 值的最大建筑层数。

在 dfs(i−1,j−1)+1 楼扔第一枚鸡蛋：

- 如果鸡蛋碎了，接下来只需要在 [1,dfs(i−1,j−1)] 中扔鸡蛋，就可以确定 f 的值。
- 如果鸡蛋没碎，问题变成在有 i−1 次操作机会和 j 枚鸡蛋的情况下，可以让我们能确定 f 值的最大建筑层数。这个子问题的答案 dfs(i−1,j)，加上 dfs(i−1,j−1) + 1，就是原问题的答案 dfs(i,j)。

所以有

dfs(i,j) = dfs(i−1,j) + dfs(i−1,j−1) + 1

时间复杂度：O(nk)。瓶颈主要在创建数组上。

空间复杂度：O(nk)。

<!--more-->

```cpp
class Solution {
public:
    int superEggDrop(int k, int n) {
        vector<vector<int>> f(n + 1, vector<int>(k + 1));
        for (int i = 1; ; i++) {
            for (int j = 1; j <= k; j++) {
                f[i][j] = f[i - 1][j] + f[i - 1][j - 1] + 1;
            }
            if (f[i][k] >= n) {
                return i;
            }
        }
    }
};
```

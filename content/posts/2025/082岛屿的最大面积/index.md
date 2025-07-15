---
title: "082：岛屿的最大面积"
date: 2025-07-05T23:01:49+08:00
draft: false
slug: "lc-0695"
categories: ["高频面试题"]
tags: ["图论", "DFS"]
---

LeetCode:695

https://leetcode.cn/problems/max-area-of-island/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

网格图 DFS，类似 LeetCode 200 岛屿数量，增加一个当前岛屿面积的计算。

时间复杂度：O(mn)，其中 m 和 n 分别为 grid 的行数和列数。

空间复杂度：O(mn)。最坏情况下，递归需要 O(mn) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    int maxAreaOfIsland(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        int mx = 0;
        auto dfs = [&](auto &&dfs, int i, int j) -> int {
            if (i < 0 || i >= m || j < 0 || j >= n || grid[i][j] != 1) {
                return 0;
            }
            grid[i][j] = -1;
            int ans = 1;
            ans += dfs(dfs, i, j - 1);
            ans += dfs(dfs, i, j + 1);
            ans += dfs(dfs, i - 1, j);
            ans += dfs(dfs, i + 1, j);
            return ans;
        };
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    mx = max(mx, dfs(dfs, i, j));
                }
            }
        }
        return mx;
    }
};
```

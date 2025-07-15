---
title: "014：岛屿数量"
date: 2025-06-28T23:54:44+08:00
draft: false
slug: "lc-0200"
categories: ["高频面试题"]
tags: ["图论", "DFS"]
---

LeetCode 200

https://leetcode.cn/problems/number-of-islands/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题是一道图论 DFS 的题目。初始图中的陆地为 1，水为 0。当我们遍历陆地的时候，将遍历过的陆地改为 2，以防止重复访问。

遍历整张图，如果发现 grid[i][j] == 1，说明这是一块没被访问过的岛屿，dfs(i, j)，岛屿数量加一。

时间复杂度：O(mn)，其中 m 和 n 分别为 grid 的行数和列数。

空间复杂度：O(mn)。最坏情况下，递归需要 O(mn) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    int numIslands(vector<vector<char>>& grid) {
        int m = grid.size(), n = grid[0].size();
        int ans = 0;
        auto dfs = [&](auto&& dfs, int i, int j) {
            if (i < 0 || i >= m || j < 0 || j >= n || grid[i][j] != '1') {
                return;
            }
            grid[i][j] = '2';
            dfs(dfs, i, j - 1);
            dfs(dfs, i, j + 1);
            dfs(dfs, i - 1, j);
            dfs(dfs, i + 1, j);
        };

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == '1') {
                    dfs(dfs, i, j);
                    ans++;
                }
            }
        }
        return ans;
    }
};
```

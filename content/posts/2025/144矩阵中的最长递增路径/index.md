---
title: "144：矩阵中的最长递增路径"
date: 2025-07-15T19:02:10+08:00
draft: false
slug: "lc-0329"
categories: ["高频面试题"]
tags: ["DFS", "记忆化搜索"]
---

LeetCode 329

https://leetcode.cn/problems/longest-increasing-path-in-a-matrix/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题为记忆化 DFS。使用 memo[i][j] 维护以 matrix[i][j] 为起点的最长递增路径的长度。

时间复杂度：O(mn)，其中 m 和 n 分别是矩阵的行数和列数。深度优先搜索的时间复杂度是 O(V+E)，其中 V 是节点数，E 是边数。在矩阵中，O(V)=O(mn)，O(E)≈O(4mn)=O(mn)。

空间复杂度：O(mn)，其中 m 和 n 分别是矩阵的行数和列数。空间复杂度主要取决于缓存和递归调用深度，缓存的空间复杂度是 O(mn)，递归调用深度不会超过 mn。

<!--more-->

```cpp
class Solution {
    static constexpr int DIRS[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

public:
    int longestIncreasingPath(vector<vector<int>>& matrix) {
        int m = matrix.size(), n = matrix[0].size();
        if (m == 0 || n == 0) {
            return 0;
        }
        vector memo(m, vector<int>(n, -1));
        int ans = 0;
        auto dfs = [&](this auto&& dfs, int i, int j) -> int {
            if (memo[i][j] != -1) {
                return memo[i][j];
            }
            int& res = memo[i][j];
            res = 1;
            for (auto& d : DIRS) {
                int x = i + d[0], y = j + d[1];
                if (x >= 0 && x < m && y >= 0 && y < n &&
                    matrix[x][y] > matrix[i][j]) {
                    res = max(res, dfs(x, y) + 1);
                }
            }
            return res;
        };
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                ans = max(ans, dfs(i, j));
            }
        }
        return ans;
    }
};
```

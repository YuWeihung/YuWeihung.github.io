---
title: "194：N皇后"
date: 2025-07-15T19:04:01+08:00
draft: false
slug: "lc-051"
categories: ["高频面试题"]
tags: ["回溯", "排列型回溯"]
---

LeetCode 51

https://leetcode.cn/problems/n-queens/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

放置皇后有四个要求，本行(row)，本列(col)，与主对角线平行的斜线(row - col)和与副对角线平行的斜线(row + col)。为了避免 row - col 出现负数，使用 row - col + n - 1。

时间复杂度：O(n^2 n!)。

空间复杂度：O(n)。返回值的空间不计入。

<!--more-->

```cpp
class Solution {
public:
    vector<vector<string>> solveNQueens(int n) {
        vector<vector<string>> ans;
        vector board(n, string(n, '.')); // 一开始棋盘是空的，没有皇后
        vector<uint8_t> col(n), diag1(n * 2 - 1), diag2(n * 2 - 1); // vector<uint8_t> 效率比 vector<bool> 高
        auto dfs = [&](this auto&& dfs, int r) {
            if (r == n) {
                ans.push_back(board); // 复制整个棋盘
                return;
            }
            // 在 (r,c) 放皇后
            for (int c = 0; c < n; c++) {
                int rc = r - c + n - 1;
                if (!col[c] && !diag1[r + c] && !diag2[rc]) { // 判断能否放皇后
                    board[r][c] = 'Q'; // 放皇后
                    col[c] = diag1[r + c] = diag2[rc] = true; // 皇后占用了 c 列和两条斜线
                    dfs(r + 1);
                    col[c] = diag1[r + c] = diag2[rc] = false; // 恢复现场
                    board[r][c] = '.';
                }
            }
        };
        dfs(0);
        return ans;
    }
};
```

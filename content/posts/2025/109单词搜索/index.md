---
title: "109：单词搜索"
date: 2025-07-13T12:37:15+08:00
draft: false
slug: "lc-0079"
categories: ["高频面试题"]
tags: ["回溯", "网格图"]
---

LeetCode 79

https://leetcode.cn/problems/word-search/description/

难度：中等

网格图回溯。为了知道当前匹配到了第几个字母，需要三个参数 dfs(i, j, k)。

定义 dfs(i,j,k) 表示当前在 board[i][j] 这个格子，要匹配 word[k]，返回在这个状态下最终能否匹配成功（搜索成功）。

- 如果 board[i][j] != word[k]，匹配失败，返回 false。
- 否则，如果 k == len(word) − 1，匹配成功，返回 true。
- 否则，枚举 (i, j) 周围的四个相邻格子 (x, y)，如果 (x, y) 没有出界，则递归 dfs(x, y, k + 1)，如果其返回 true，则 dfs(i, j, k) 也返回 true。
  如果递归周围的四个相邻格子都没有返回 true，则最后返回 false，表示没有搜到。

递归过程中，为了避免重复访问同一个格子，可以直接修改 board[i][j]，将其置为空（或者 0），返回 false 前再恢复成原来的值（恢复现场）。注意返回 true 的时候就不用恢复现场了，因为已经成功搜到 word 了。

时间复杂度：\(O(mn3^k)\)，其中 m 和 n 分别为 grid 的行数和列数，k 是 word 的长度。除了递归入口，其余递归至多有 3 个分支（因为至少有一个方向是之前走过的），所以每次递归（回溯）的时间复杂度为 \(O(3^k)\)，一共回溯 O(mn) 次，所以时间复杂度为 \(O(mn3^k)\)。

空间复杂度：O(∣Σ∣+k)。其中 ∣Σ∣=52 是字符集合的大小。递归需要 O(k) 的栈空间。部分语言用的数组代替哈希表，可以视作 ∣Σ∣=128。

<!--more-->

```cpp
class Solution {
    static constexpr int DIRS[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
public:
    bool exist(vector<vector<char>>& board, string word){
        int m = board.size(), n = board[0].size();
        auto dfs = [&](auto &&dfs, int i, int j, int k) -> bool {
            if (board[i][j] != word[k]) {
                return false;
            }
            if (k + 1 == word.size()) {
                return true;
            }
            char ch = board[i][j];
            board[i][j] = 0;
            for (auto &d: DIRS) {
                int x = i + d[0];
                int y = j + d[1];
                if (0 <= x && x < m && 0 <= y && y < n && dfs(dfs, x, y, k + 1)) {
                    return true;
                }
            }
            board[i][j] = ch;
            return false;
        };
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (dfs(dfs, i, j, 0)) {
                    return true;
                }
            }
        }
        return false;
    }
};
```

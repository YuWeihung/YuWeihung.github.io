---
title: "131：螺旋矩阵II"
date: 2025-07-15T19:01:50+08:00
draft: false
slug: "lc-0059"
categories: ["高频面试题"]
tags: ["模拟", "矩阵"]
---

LeetCode 59

https://leetcode.cn/problems/spiral-matrix-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

1. 初始化一个 n×n 的矩阵，一开始所有元素均为 0。
2. 用一个长为 4 的方向数组 DIRS=[(0,1),(1,0),(0,−1),(−1,0)] 分别表示右下左上 4 个方向。同时用一个下标 di 表示当前方向，初始值为 0，表示一开始向右。
3. 每次移动，相当于把行号增加 DIRS[di][0]，把列号增加 DIRS[di][1]。
4. 向右转 90°，相当于把 di 增加 1，但在 di=3 时要回到 di=0。两种情况合二为一，把 di 更新为 (di+1)mod4。

时间复杂度：\(O(n^2)\)。

空间复杂度：O(1)。返回值不计入。

<!--more-->

```cpp
class Solution {
    static constexpr int DIRS[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}; // 右下左上
public:
    vector<vector<int>> generateMatrix(int n) {
        vector ans(n, vector<int>(n));
        int i = 0, j = 0, di = 0;
        for (int val = 1; val <= n * n; val++) { // 要填入的数
            ans[i][j] = val;
            int x = i + DIRS[di][0];
            int y = j + DIRS[di][1]; // 下一步的位置
            // 如果 (x, y) 出界或者已经填入数字
            if (x < 0 || x >= n || y < 0 || y >= n || ans[x][y]) {
                di = (di + 1) % 4; // 右转 90°
            }
            i += DIRS[di][0];
            j += DIRS[di][1]; // 走一步
        }
        return ans;
    }
};
```

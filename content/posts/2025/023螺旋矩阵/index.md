---
title: "023：螺旋矩阵"
date: 2025-06-29T19:19:14+08:00
draft: false
slug: "lc-0054"
categories: ["高频面试题"]
tags: ["模拟"]
---

LeetCode 54

https://leetcode.cn/problems/spiral-matrix/description/

难度：中等

对于已经访问过的数据，更改值为 INF，对其进行标记。定义方向数组，当访问到不合法的节点时，右转 90°，即 di = (di + 1) % 4。

时间复杂度：O(mn)，其中 m 和 n 分别为 matrix 的行数和列数。

空间复杂度：O(1)。返回值不计入。

<!--more-->

```cpp
class Solution {
    static constexpr int DIRS[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}; // 右下左上
public:
    vector<int> spiralOrder(vector<vector<int>>& matrix) {
        int m = matrix.size(), n = matrix[0].size();
        vector<int> ans(m * n);
        int i = 0, j = 0, di = 0;
        for (int k = 0; k < m * n; k++) { // 一共走 mn 步
            ans[k] = matrix[i][j];
            matrix[i][j] = INT_MAX; // 标记，表示已经访问过（已经加入答案）
            int x = i + DIRS[di][0];
            int y = j + DIRS[di][1]; // 下一步的位置
            // 如果 (x, y) 出界或者已经访问过
            if (x < 0 || x >= m || y < 0 || y >= n || matrix[x][y] == INT_MAX) {
                di = (di + 1) % 4; // 右转 90°
            }
            i += DIRS[di][0];
            j += DIRS[di][1]; // 走一步
        }
        return ans;
    }
};
```

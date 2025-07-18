---
title: "118：对角线遍历"
date: 2025-07-15T19:01:34+08:00
draft: false
slug: "lc-0498"
categories: ["高频面试题"]
tags: ["矩阵", "模拟"]
---

LeetCode 498

https://leetcode.cn/problems/diagonal-traverse/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

模拟对角线遍历，当到达边界的时候需要改变方向。需要注意的是在判断边界时有顺序要求，例如向上移动时，需要先处理右边界，再处理上边界。这是因为如果当同时到达右边界和上边界时，如果处理上边界，col 就越界了。

时间复杂度：O(m×n)，其中 m 为矩阵行的数量，n 为矩阵列的数量。需要遍历一遍矩阵中的所有元素，需要的时间复杂度为 O(m×n)。

空间复杂度：O(1)。除返回值外不需要额外的空间。

<!--more-->

```cpp
class Solution {
public:
    vector<int> findDiagonalOrder(vector<vector<int>>& mat) {
        int m = mat.size(), n = mat[0].size();
        vector<int> ans;
        int row = 0, col = 0;
        bool up = true; // 方向标志：true表示向上移动，false表示向下移动

        while (ans.size() < m * n) {
            ans.push_back(mat[row][col]);

            if (up) { // 向上移动（右上方向）
                if (col == n - 1) { // 到达右边界
                    row++;
                    up = false; // 改为向下
                } else if (row == 0) { // 到达上边界
                    col++;
                    up = false; // 改为向下
                } else { // 正常向上移动
                    row--;
                    col++;
                }
            } else { // 向下移动（左下方向）
                if (row == m - 1) { // 到达下边界
                    col++;
                    up = true; // 改为向上
                } else if (col == 0) { // 到达左边界
                    row++;
                    up = true; // 改为向上
                } else { // 正常向下移动
                    row++;
                    col--;
                }
            }
        }

        return ans;
    }
};
```

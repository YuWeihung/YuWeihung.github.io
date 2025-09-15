---
title: "182：顺时针打印矩阵"
date: 2025-07-15T19:03:24+08:00
draft: false
slug: "lcr-0146"
categories: ["高频面试题"]
tags: ["矩阵", "模拟"]
---

LCR 146

https://leetcode.cn/problems/shun-shi-zhen-da-yin-ju-zhen-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

时间复杂度：O(mn)，其中 m 和 n 分别为 array 的行数和列数。

空间复杂度：O(1)。返回值不计入。

<!--more-->

```cpp
class Solution {
    static constexpr int DIRS[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}; // 右下左上
public:
    vector<int> spiralArray(vector<vector<int>>& array) {
        if (array.empty()) {
            return {};
        }
        int m = array.size(), n = array[0].size();
        vector<int> ans(m * n);
        int i = 0, j = 0, di = 0;
        for (int k = 0; k < m * n; k++) { // 一共走 mn 步
            ans[k] = array[i][j];
            array[i][j] = INT_MAX; // 标记，表示已经访问过（已经加入答案）
            int x = i + DIRS[di][0];
            int y = j + DIRS[di][1]; // 下一步的位置
            // 如果 (x, y) 出界或者已经访问过
            if (x < 0 || x >= m || y < 0 || y >= n || array[x][y] == INT_MAX) {
                di = (di + 1) % 4; // 右转 90°
            }
            i += DIRS[di][0];
            j += DIRS[di][1]; // 走一步
        }
        return ans;
    }
};
```

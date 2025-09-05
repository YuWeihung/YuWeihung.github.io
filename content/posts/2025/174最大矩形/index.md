---
title: "174：最大矩形"
date: 2025-07-15T19:03:04+08:00
draft: false
slug: "lc-0"
categories: ["高频面试题"]
tags: ["单调栈"]
---

LeetCode 85

https://leetcode.cn/problems/maximal-rectangle/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题是 LeetCoce 84 柱状图中最大的矩形的升级版，枚举矩形的底边，做 m 次 largestRectangleArea。如果 matrix[i][j]=0，那么没有柱子，高度等于 0。否则，在上一行柱子的基础上，把柱子高度增加 1。

时间复杂度：O(mn)，其中 m 和 n 分别为 matrix 的行数和列数。做 m 次 84 题，每次 O(n)。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
    int largestRectangleArea(vector<int>& heights) {
        int n = heights.size();
        vector<int> left(n, -1);
        vector<int> right(n, n);
        stack<int> st;
        int ans = 0;
        for (int i = 0; i < n; i++) {
            int h = heights[i];
            while (st.size() > 0 && heights[st.top()] >= h) {
                right[st.top()] = i;
                st.pop();
            }
            if (st.size() > 0) {
                left[i] = st.top();
            }
            st.push(i);
        }
        for (int i = 0; i < n; i++) {
            ans = max(ans, heights[i] * (right[i] - left[i] - 1));
        }
        return ans;
    }
public:
    int maximalRectangle(vector<vector<char>>& matrix) {
        int m = matrix.size(), n = matrix[0].size();
        vector<int> nums(n, 0);
        int ans = 0;
        for (int i = 0; i < m; i++) {
            for (int j=  0; j < n; j++) {
                if (matrix[i][j] == '1') {
                    nums[j]++;
                } else {
                    nums[j] = 0;
                }
            }
            ans = max(ans, largestRectangleArea(nums));
        }
        return ans;
    }
};
```

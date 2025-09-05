---
title: "186：柱状图中最大的矩形"
date: 2025-07-15T19:03:35+08:00
draft: false
slug: "lc-0084"
categories: ["高频面试题"]
tags: ["单调栈"]
---

LeetCode 84

https://leetcode.cn/problems/largest-rectangle-in-histogram/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

单调栈。h = height[i]，left[i] 表示在 i 左侧小于 h 的最近元素下标，right[i] 表示在 i 右侧小于等于 h 的最近元素下标。以 h 为高度的矩形的最大面积为 height[i] \* (right[i] - left[i] - 1)。

两次遍历，在计算 left 的过程中，如果栈顶元素 ≥ heights[i]，那么 i 就是栈顶元素的 right。

时间复杂度：O(n)，其中 n 为 heights 的长度。每个元素入栈出栈各至多一次，所以二重循环是 O(n) 的。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
public:
    int largestRectangleArea(vector<int> &heights) {
        int n = heights.size();
        vector<int> left(n, -1);
        vector<int> right(n, n);
        stack<int> st;
        for (int i = 0; i < n; i++) {
            int h = heights[i];
            while (!st.empty() && heights[st.top()] >= h) {
                right[st.top()] = i;
                st.pop();
            }
            if (!st.empty()) {
                left[i] = st.top();
            }
            st.push(i);
        }

        int ans = 0;
        for (int i = 0; i < n; i++) {
            ans = max(ans, heights[i] * (right[i] - left[i] - 1));
        }
        return ans;
    }
};
```

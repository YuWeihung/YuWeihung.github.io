---
title: "030：接雨水"
date: 2025-06-29T21:40:53+08:00
draft: false
slug: "lc-0042"
categories: ["高频面试题"]
tags: ["单调栈"]
---

LeetCode 42

https://leetcode.cn/problems/trapping-rain-water/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题为常考的 Hard 题目，有多种做法，分别是前后缀分解，相向双指针和单调栈。本文使用单调栈方法。单调栈的做法相当于「横着」计算面积。

这个方法可以总结成 16 个字：找上一个更大元素，在找的过程中填坑。

如果当前元素大于栈顶元素，栈顶元素作为底边，当前元素作为右边，再找栈中第二小的元素作为左边。这段区域可以接的水为 min(height[left], height[i]) - bottom_h \* (i - left - 1)。如果找不到第二小的元素，说明这一段不能接水。最后将 i 入栈。

时间复杂度：O(n)，其中 n 为 height 的长度。虽然我们写了个二重循环，但站在每个元素的视角看，这个元素在二重循环中最多入栈出栈各一次，因此循环次数之和是 O(n)，所以时间复杂度是 O(n)。

空间复杂度：O(min(n,U))，其中 U=max(height)−min(height)+1。注意栈中没有重复元素，在 height 值域很小的情况下，空间复杂度主要取决于 height 的值域范围。

<!--more-->

```cpp
class Solution {
public:
    int trap(vector<int>& height) {
        int ans = 0;
        stack<int> st;
        for (int i = 0; i < height.size(); i++) {
            while (!st.empty() && height[i] >= height[st.top()]) {
                int bottom_h = height[st.top()];
                st.pop();
                if (st.empty()) {
                    break;
                }
                int left = st.top();
                int dh = min(height[left], height[i]) - bottom_h; // 面积的高
                ans += dh * (i - left - 1);
            }
            st.push(i);
        }
        return ans;
    }
};
```

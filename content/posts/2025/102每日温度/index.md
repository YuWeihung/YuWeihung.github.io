---
title: "102：每日温度"
date: 2025-07-13T12:37:14+08:00
draft: false
slug: "lc-0739"
categories: ["高频面试题"]
tags: ["单调栈"]
---

LeetCode 739

https://leetcode.cn/problems/daily-temperatures/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

单调栈经典题目。从左往右遍历，栈中记录还没算出下一个更大元素的那些数的下标。相当于栈是一个 todolist，在循环的过程中，现在还不知道答案是多少，在后面的循环中会算出答案。

时间复杂度：O(n)，其中 n 为 temperatures 的长度。虽然我们写了个二重循环，但站在每个元素的视角看，这个元素在二重循环中最多入栈出栈各一次，因此循环次数之和是 O(n)，所以时间复杂度是 O(n)。

空间复杂度：O(n)。注意这种写法栈中可以有重复元素。

<!--more-->

```cpp
class Solution {
public:
    vector<int> dailyTemperatures(vector<int>& temperatures) {
        int n = temperatures.size();
        vector<int> ans(n);
        stack<int> st; // todolist
        for (int i = 0; i < n; i++) {
            int t = temperatures[i];
            while (!st.empty() && t > temperatures[st.top()]) {
                int j = st.top();
                st.pop();
                ans[j] = i - j;
            }
            st.push(i);
        }
        return ans;
    }
};
```

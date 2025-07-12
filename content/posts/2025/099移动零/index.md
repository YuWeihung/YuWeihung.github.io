---
title: "099：移动零"
date: 2025-07-06T13:21:52+08:00
draft: false
slug: "lc-0283"
categories: ["高频面试题"]
tags: ["栈"]
---

LeetCode 283

https://leetcode.cn/problems/move-zeroes/description/

难度：简单

题目要求在不复制数组的情况下原地对数组进行操作。

直接把 nums 当作栈，用一个变量 stackSize 表示栈的大小，初始值为 0。

入栈就是把 nums[stackSize] 置为 nums[i]，同时把 stackSize 加一。

最后把 nums 中的下标从 stackSize 到 n−1 的数都置为 0。

时间复杂度：O(n)，其中 n 是 nums 的长度。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    void moveZeroes(vector<int>& nums) {
        int stack_size = 0;
        for (int x : nums) {
            if (x) {
                nums[stack_size++] = x; // 把 x 入栈
            }
        }
        for (int i = stack_size; i < nums.size(); i++) {
            nums[i] = 0;
        }
    }
};
```

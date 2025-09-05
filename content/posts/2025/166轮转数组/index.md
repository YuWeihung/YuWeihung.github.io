---
title: "166：轮转数组"
date: 2025-07-15T19:02:48+08:00
draft: false
slug: "lc-0198"
categories: ["高频面试题"]
tags: ["双指针"]
---

LeetCode 189

https://leetcode.cn/problems/rotate-array/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

轮转数组只需要三步，反转整个数组，反转前 k 个元素，反转后 n - k 个。

时间复杂度：O(n)，其中 n 是 nums 的长度。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    void rotate(vector<int>& nums, int k) {
        int n = nums.size();
        k %= n;
        reverse(nums.begin(), nums.end());
        reverse(nums.begin(), nums.begin() + k);
        reverse(nums.begin() + k, nums.end());
    }
};
```

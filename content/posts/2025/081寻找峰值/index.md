---
title: "081：寻找峰值"
date: 2025-07-05T23:01:42+08:00
draft: false
slug: "lc-0162"
categories: ["高频面试题"]
tags: ["二分查找", ""]
---

LeetCode 162

https://leetcode.cn/problems/find-peak-element/description/

难度：中等

如果 nums[mid] > nums[mid + 1]，说明 mid 要么就是峰值，要么在峰值的右侧，染成蓝色，否则 mid 在峰值的左侧，染成红色。

二分开区间为 (-1, n - 1)。因为 n - 1 一定满足条件，是蓝色。

时间复杂度：O(logn)，其中 n 为 nums 的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    int findPeakElement(vector<int>& nums) {
        int left = -1, right = nums.size() - 1; // 开区间 (-1, n-1)
        while (left + 1 < right) { // 开区间不为空
            int mid = left + (right - left) / 2;
            if (nums[mid] > nums[mid + 1]) {
                right = mid;
            } else {
                left = mid;
            }
        }
        return right;
    }
};
```

---
title: "042：二分查找"
date: 2025-07-01T16:55:21+08:00
draft: false
slug: "lc-0704"
categories: ["高频面试题"]
tags: ["二分查找"]
---

LeetCode 704

https://leetcode.cn/problems/binary-search/description/

难度：简单

红蓝染色法，开区间二分。满足条件 nums[mid] >= target 更新 right = mid。更新什么什么就是答案，本题 right 就是答案。

时间复杂度：O(logn)，其中 n 为 nums 的长度。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int search(vector<int>& nums, int target) {
        int n = nums.size();
        int left = -1, right = n;
        while (left + 1 < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] >= target) {
                right = mid;
            } else {
                left = mid;
            }
        }
        if (right == n || nums[right] != target) {
            return -1;
        }
        return right;
    }
};
```

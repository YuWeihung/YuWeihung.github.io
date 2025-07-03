---
title: "064：在排序数组中查找元素的第一个和最后一个位置"
date: 2025-07-03T22:08:30+08:00
draft: false
slug: "lc-0034"
categories: ["高频面试题"]
tags: ["二分查找"]
---

LeetCode 34

https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/description/

难度：中等

二分查找。

```
// >= x
lower_bound(x)
// > x
lower_bound(x + 1)
// < x
lower_bound(x) - 1
// <= x
lower_bound(x + 1) - 1
```

时间复杂度：O(logn)，其中 n 为 nums 的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
    // lower_bound 返回最小的满足 nums[i] >= target 的下标 i
    // 如果数组为空，或者所有数都 < target，则返回 nums.size()
    // 要求 nums 是非递减的，即 nums[i] <= nums[i + 1]
    int lower_bound(vector<int>& nums, int target) {
        int left = -1, right = nums.size(); // 开区间 (left, right)
        while (left + 1 < right) { // 区间不为空
            // 循环不变量：
            // nums[left] < target
            // nums[right] >= target
            int mid = left + (right - left) / 2;
            if (nums[mid] >= target) {
                right = mid; // 范围缩小到 (left, mid)
            } else {
                left = mid; // 范围缩小到 (mid, right)
            }
        }
        // 循环结束后 left+1 = right
        // 此时 nums[left] < target 而 nums[right] >= target
        // 所以 right 就是第一个 >= target 的元素下标
        return right;
    }

public:
    vector<int> searchRange(vector<int>& nums, int target) {
        int start = lower_bound(nums, target);
        if (start == nums.size() || nums[start] != target) {
            return {-1, -1}; // nums 中没有 target
        }
        // 如果 start 存在，那么 end 必定存在
        int end = lower_bound(nums, target + 1) - 1;
        return {start, end};
    }
};
```

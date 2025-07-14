---
title: "106：寻找旋转排序数组中的最小值"
date: 2025-07-13T12:37:15+08:00
draft: false
slug: "lc-0153"
categories: ["高频面试题"]
tags: ["二分查找"]
---

LeetCode 153

https://leetcode.cn/problems/find-minimum-in-rotated-sorted-array/description/

难度：中等

二分查找，与最后一个数比大小。如果 mid 比 nums[n - 1] 小，一定是蓝色（是最小值或最小值右边），反之是红色（最小值左边）， 最后 right 就是答案。

时间复杂度：O(logn)，其中 n 为 nums 的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    int findMin(vector<int>& nums) {
        int n = nums.size();
        int left = -1, right = n - 1;
        while (left + 1 < right) {
            int mid = left + (right - left) / 2;
            if (nums[mid] < nums.back()) {
                right = mid;
            } else {
                left = mid;
            }
        }
        return nums[right];
    }
};
```

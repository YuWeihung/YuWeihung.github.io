---
title: "013：搜索旋转排序数组"
date: 2025-06-28T23:24:08+08:00
draft: false
slug: "lc-0033"
categories: ["高频面试题"]
tags: ["二分查找"]
---

LeetCode 33

https://leetcode.cn/problems/search-in-rotated-sorted-array/description/

难度：中等

本题是二分查找的应用，使用红蓝染色法。如果 mid 就是 target 或者在 target 右侧，染为蓝色，如果在 target 左侧，染为红色。

如果数组被旋转了，那么分为左右两段，左边一段的元素大于最后一个元素。

对于节点 i 被染为蓝色分为以下情况：

- 如果 nums[i] > end，也就是 i 在左边这段。那么需要 target 也在左边这段，并且在他左边。
- 如果 nums[i] <= end，也就是 i 在右边这段。那么需要 target 要么在左边这段，要么在右边这段但是在他左边。

由于最后一个元素一定在 target 右边，初始就为蓝色，因此二分区间为 [0, n - 2]。

时间复杂度：O(logn)，其中 n 为 nums 的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    int search(vector<int>& nums, int target) {
        int end = nums.back();
        auto check = [&](int i) -> bool {
            int x = nums[i];
            if (x > end) {
                return target > end && x >= target;
            }
            return target > end || x >= target;
        };

        int left = -1, right = nums.size() - 1; // 开区间 (-1, n-1)
        while (left + 1 < right) { // 开区间不为空
            int mid = left + (right - left) / 2;
            (check(mid) ? right : left) = mid; // 更简洁的写法
        }
        return nums[right] == target ? right : -1;
    }
};
```

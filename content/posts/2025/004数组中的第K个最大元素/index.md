---
title: "004：数组中的第K个最大元素"
date: 2025-06-25T17:43:43+08:00
draft: false
slug: "lc-0215"
categories: ["高频面试题"]
tags: ["快速排序"]
---

LeetCode 215

https://leetcode.cn/problems/kth-largest-element-in-an-array/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

快速选择算法，类似快速排序。

时间复杂度：O(n)

空间复杂度：O(logn)

<!--more-->

```cpp
class Solution {
public:
    int quickselect(vector<int> &nums, int l, int r, int k) {
        if (l == r)
            return nums[k];
        int partition = nums[l], i = l - 1, j = r + 1;
        while (i < j) {
            do i++; while (nums[i] < partition);
            do j--; while (nums[j] > partition);
            if (i < j)
                swap(nums[i], nums[j]);
        }
        if (k <= j)return quickselect(nums, l, j, k);
        else return quickselect(nums, j + 1, r, k);
    }

    int findKthLargest(vector<int> &nums, int k) {
        int n = nums.size();
        return quickselect(nums, 0, n - 1, n - k);
    }
};
```

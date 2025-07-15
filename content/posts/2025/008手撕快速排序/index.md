---
title: "008：手撕快速排序"
date: 2025-06-27T13:34:30+08:00
draft: false
slug: "lc-0912"
categories: ["高频面试题"]
tags: ["快速排序"]
---

本题为手撕快速排序，力扣上类似的题为 LeetCode 912 排序数组。

https://leetcode.cn/problems/sort-an-array/description/

难度：中等。

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

需要注意的是，初始化 i = l - 1，j = r + 1，方便在循环开始时直接进行 i++ 和 j--，递归时边界分别是 [l, j] 和 [j + 1, r]。

时间复杂度：O(nlogn)

空间复杂度：O(logn)

<!--more-->

```cpp
class Solution {
public:
    void sort(vector<int>& nums, int l, int r) {
        if (l == r) {
            return;
        }
        int i = l - 1, j = r + 1, mid = l + (r - l)/ 2;
        int x = nums[mid];
        while (i < j) {
            do {
                i++;
            } while (nums[i] < x);
            do {
                j--;
            } while (nums[j] > x);
            if (i < j) {
                swap(nums[i], nums[j]);
            }
        }
        sort(nums, l, j);
        sort(nums, j + 1, r);
    }
    vector<int> sortArray(vector<int>& nums) {
        sort(nums, 0, nums.size() - 1);
        return nums;
    }
};
```

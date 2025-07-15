---
title: "114：手撕归并排序"
date: 2025-07-15T19:01:29+08:00
draft: false
slug: "lc-0912-3"
categories: ["高频面试题"]
tags: ["排序", "归并排序"]
---

LeetCode 912

https://leetcode.cn/problems/sort-an-array/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

归并排序。将整个数组分成前后两个部分，递归调用归并排序，使得两部分分别有序，之后使用一个临时数组，将两个有序数组合并，最后将结果复制回原数组。

时间复杂度：O(nlogn)。由于归并排序每次都将当前待排序的序列折半成两个子序列递归调用，然后再合并两个有序的子序列，而每次合并两个有序的子序列需要 O(n) 的时间复杂度，根据主定理我们可以得出归并排序的时间复杂度为 O(nlogn)。

空间复杂度：O(n)。我们需要额外 O(n) 空间的 tmp 数组，且归并排序递归调用的层数最深为 logn，所以我们还需要额外的 O(logn) 的栈空间，所需的空间复杂度即为 O(n+logn) = O(n)。

<!--more-->

```cpp
class Solution {
    vector<int> tmp;
public:
    void merge_sort(vector<int>& nums, int l, int r) {
        if (l == r) {
            return;
        }
        int mid = l + (r - l) / 2;
        merge_sort(nums, l, mid);
        merge_sort(nums, mid + 1, r);
        int i = l, j = mid + 1;
        for (int k = l; k <= r; k++) {
            if (i == mid + 1) {
                tmp[k] = nums[j];
                j++;
            } else if (j == r + 1) {
                tmp[k] = nums[i];
                i++;
            } else if (nums[i] < nums[j]) {
                tmp[k] = nums[i];
                i++;
            } else {
                tmp[k] = nums[j];
                j++;
            }
        }
        for (int k = l; k <= r; k++) {
            nums[k] = tmp[k];
        }
    }
    vector<int> sortArray(vector<int>& nums) {
        int n = nums.size();
        tmp.resize(n);
        merge_sort(nums, 0, n - 1);
        return nums;
    }
};
```

---
title: "016:合并两个有序数组"
date: 2025-06-29T11:38:15+08:00
draft: false
slug: "lc-0088"
categories: ["高频面试题"]
tags: ["双指针"]
---

LeetCode 88

https://leetcode.cn/problems/merge-sorted-array/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题最简单的思路是使用额外的空间存储，最后复制回 nums1。那么有没有什么方案可以避免额外空间？答案是使用逆向双指针算法。从最后一个元素开始，将结果赋值到 nums1。这样可以避免 nums1 中元素被覆盖的问题。

时间复杂度：O(m+n)。

空间复杂度：O(1)。仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
        int p1 = m - 1, p2 = n - 1, p = m + n - 1;
        while (p2 >= 0) { // nums2 还有要合并的元素
            // 如果 p1 < 0，那么走 else 分支，把 nums2 合并到 nums1 中
            if (p1 >= 0 && nums1[p1] > nums2[p2]) {
                nums1[p--] = nums1[p1--]; // 填入 nums1[p1]
            } else {
                nums1[p--] = nums2[p2--]; // 填入 nums2[p1]
            }
        }
    }
};
```

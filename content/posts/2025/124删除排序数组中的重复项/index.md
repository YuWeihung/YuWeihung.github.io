---
title: "124：删除排序数组中的重复项"
date: 2025-07-15T19:01:41+08:00
draft: false
slug: "lc-0026"
categories: ["高频面试题"]
tags: ["双指针"]
---

LeetCode 26

https://leetcode.cn/problems/remove-duplicates-from-sorted-array/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

双指针，维护保留元素的个数。

时间复杂度：O(n)，其中 n 是 nums 的长度。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        int k = 1;
        for (int i = 1; i < nums.size(); i++) {
            if (nums[i] != nums[i - 1]) { // nums[i] 不是重复项
                nums[k++] = nums[i]; // 保留 nums[i]
            }
        }
        return k;
    }
};
```

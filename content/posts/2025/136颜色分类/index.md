---
title: "136：颜色分类"
date: 2025-07-15T19:01:57+08:00
draft: false
slug: "lc-0075"
categories: ["高频面试题"]
tags: ["双指针", "排序"]
---

LeetCode 75

https://leetcode.cn/problems/sort-colors/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

O(1) 插入元素
不是插入元素，而是修改元素！

维护 a 中 0 的个数，即改为 0 的位置，记作 p0。维护 a 中 0 和 1 的个数，即改为 1 的位置，记作 p1。

首先将 x 改为 2，如果 x <= 1，nums[p1++] = 1，如果 x == 0，nums[p0++] = 0。

时间复杂度：O(n)，其中 n 是 nums 的长度。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    void sortColors(vector<int>& nums) {
        int p0 = 0, p1 = 0;
        for (int i = 0; i < nums.size(); i++) {
            int x = nums[i];
            nums[i] = 2;
            if (x <= 1) {
                nums[p1++] = 1;
            }
            if (x == 0) {
                nums[p0++] = 0;
            }
        }
    }
};
```

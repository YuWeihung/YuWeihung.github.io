---
title: "168：调整数组顺序使奇数位于偶数前面"
date: 2025-07-15T19:02:52+08:00
draft: false
slug: "lcr-0139"
categories: ["高频面试题"]
tags: ["双指针"]
---

LCR 139

https://leetcode.cn/problems/diao-zheng-shu-zu-shun-xu-shi-qi-shu-wei-yu-ou-shu-qian-mian-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

双指针。

时间复杂度 O(N) ： N 为数组 actions 长度，双指针 i, j 共同遍历整个数组。

空间复杂度 O(1) ： 双指针 i, j 使用常数大小的额外空间。

<!--more-->

```cpp
class Solution {
public:
    vector<int> trainingPlan(vector<int>& actions) {
        int i = 0, n = actions.size(), j = n - 1;
        while (i < j) {
            while (i < j && actions[i] % 2 == 1) {
                i++;
            }
            while (i < j && actions[j] % 2 == 0) {
                j--;
            }
            if (i < j) {
                swap(actions[i], actions[j]);
            }
        }
        return actions;
    }
};
```

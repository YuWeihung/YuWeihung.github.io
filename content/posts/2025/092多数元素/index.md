---
title: "092：多数元素"
date: 2025-07-06T13:20:14+08:00
draft: false
slug: "lc-0169"
categories: ["高频面试题"]
tags: ["摩尔投票法", "思维题"]
---

LeetCode 169

https://leetcode.cn/problems/majority-element/description/

难度：简单

Boyer-Moore 投票算法

- 我们维护一个候选众数 candidate 和它出现的次数 count。初始时 candidate 可以为任意值，count 为 0；

- 我们遍历数组 nums 中的所有元素，对于每个元素 x，在判断 x 之前，如果 count 的值为 0，我们先将 x 的值赋予 candidate，随后我们判断 x：

  如果 x 与 candidate 相等，那么计数器 count 的值增加 1；

  如果 x 与 candidate 不等，那么计数器 count 的值减少 1。

- 在遍历完成后，candidate 即为整个数组的众数。

时间复杂度：O(n)。Boyer-Moore 算法只对数组进行了一次遍历。

空间复杂度：O(1)。Boyer-Moore 算法只需要常数级别的额外空间。

<!--more-->

```cpp
class Solution {
public:
    int majorityElement(vector<int>& nums) {
        int candidate = -1;
        int count = 0;
        for (int num : nums) {
            if (num == candidate)
                ++count;
            else if (--count < 0) {
                candidate = num;
                count = 1;
            }
        }
        return candidate;
    }
};
```

---
title: "112：只出现一次的数字"
date: 2025-07-15T19:01:27+08:00
draft: false
slug: "lc-0136"
categories: ["高频面试题"]
tags: ["位运算"]
---

LeetCode 136

https://leetcode.cn/problems/single-number/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

利用异或运算 a ⊕ a = 0 的性质，我们可以用异或来「消除」所有出现了两次的元素，最后剩下的一定是只出现一次的元素。

初始化 ans = 0 是因为 0 ⊕ a = a，相当于我们从第一个数开始，和其它数异或。

<!--more-->

```cpp
class Solution {
public:
    int singleNumber(vector<int>& nums) {
        int ans = 0;
        for (int x : nums) {
            ans ^= x;
        }
        return ans;
    }
};
```

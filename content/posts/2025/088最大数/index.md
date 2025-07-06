---
title: "088：最大数"
date: 2025-07-05T23:02:28+08:00
draft: false
slug: "lc-0179"
categories: ["高频面试题"]
tags: ["贪心", "思维题"]
---

LeetCode 179

https://leetcode.cn/problems/largest-number/description/

难度：中等

要得到最大数，在开头数值不同时，需要把数值大的数排在前面，那么对于有相同数字开头时，应该怎么排序呢？

只需要把两个数字转成字符串并拼接起来，看哪个前后顺序更大。

```cpp
auto cmp = [](const int &a, const int &b) {
    return to_string(a) + to_string(b) > to_string(b) + to_string(a);
};
```

时间复杂度：O(nlognlogm)，其中 n 是给定序列的长度，m 是 32 位整数的最大值，每个数转化为字符串后的长度是 O(logm) 的数量级。排序比较函数的时间复杂度为 O(logm)，共需要进行 O(nlogn) 次比较。同时我们需要对字符串序列进行拼接，时间复杂度为 O(nlogm)，在渐进意义上小于 O(nlognlogm)。

空间复杂度：O(logn)，排序需要 O(logn) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    string largestNumber(vector<int>& nums) {
        int n = nums.size();
        auto cmp = [](const int &a, const int &b) {
            return to_string(a) + to_string(b) > to_string(b) + to_string(a);
        };
        sort(nums.begin(), nums.end(), cmp);
        if (nums[0] == 0) {
            return "0";
        }
        string ans;
        for (int x: nums) {
            ans += to_string(x);
        }
        return ans;
    }
};
```

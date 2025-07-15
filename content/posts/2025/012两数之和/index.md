---
title: "012：两数之和"
date: 2025-06-28T23:20:34+08:00
draft: false
slug: "lc-0001"
categories: ["高频面试题"]
tags: ["哈希表"]
---

LeetCode 1

https://leetcode.cn/problems/two-sum/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

LeetCode 第一题，哈希表的应用。

时间复杂度：O(n)，其中 n 为 nums 的长度。

空间复杂度：O(n)。哈希表需要 O(n) 的空间。

<!--more-->

```cpp
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int, int> mp;
        int n = nums.size();
        for (int i = 0; i < n; i++) {
            int x = nums[i];
            if (mp.count(target - x) > 0) {
                return {mp[target - x], i};
            }
            mp[x] = i;
        }
        return {};
    }
};
```

---
title: "193：两个数组的交集"
date: 2025-07-15T19:03:58+08:00
draft: false
slug: "lc-0349"
categories: ["高频面试题"]
tags: ["哈希表"]
---

LeetCode 349

https://leetcode.cn/problems/intersection-of-two-arrays/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

把 nums1​ 中的元素都加到哈希集合 st 中，这样可以 O(1) 判断 nums2[i] 在不在 nums1 中。

为了保证答案列表中没有重复元素，在 nums2[i] 加入答案列表的同时，把 nums2[i] 从哈希集合 st 中去掉，这样后面遍历到相同的元素时，由于其不在 st 中，所以不会加入答案列表。

时间复杂度：O(n+m)，其中 n 是 nums1 的长度，m 是 nums2 的长度。

空间复杂度：O(n)。注：可以把长度小的数组转成哈希集合，这样可以做到 O(min(n,m)) 的空间复杂度。

<!--more-->

```cpp
class Solution {
public:
    vector<int> intersection(vector<int>& nums1, vector<int>& nums2) {
        unordered_set<int> st1(nums1.begin(), nums1.end());
        vector<int> ans;
        for (int x: nums2) {
            if (st1.count(x) == 1) {
                st1.erase(x);
                ans.push_back(x);
            }
        }
        return ans;
    }
};
```

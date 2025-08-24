---
title: "143：数组中重复的数据"
date: 2025-07-15T19:02:08+08:00
draft: false
slug: "lc-0442"
categories: ["高频面试题"]
tags: ["原地哈希"]
---

LeetCode 442

https://leetcode.cn/problems/find-all-duplicates-in-an-array/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

对于数组大小和数据范围基本相同的题目，考虑原地哈希。

交换元素到其应到的位置，最后不在正确位置的元素说明重复。

时间复杂度：O(n)。每一次交换操作会使得至少一个元素被交换到对应的正确位置，因此交换的次数为 O(n)，总时间复杂度为 O(n)。

空间复杂度：O(1)。返回值不计入空间复杂度。

<!--more-->

```cpp
class Solution {
public:
    vector<int> findDuplicates(vector<int>& nums) {
        vector<int> ans;
        int n = nums.size();
        for (int i = 0; i < n; i++) {
            while (nums[i] != nums[nums[i] - 1]) {
                swap(nums[i], nums[nums[i] - 1]);
            }
        }
        for (int i = 0; i < n; i++) {
            if (i != nums[i] - 1) {
                ans.push_back(nums[i]);
            }
        }
        return ans;
    }
};
```

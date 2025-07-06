---
title: "090：和为K的子数组"
date: 2025-07-05T23:02:42+08:00
draft: false
slug: "lc-0560"
categories: ["高频面试题"]
tags: ["前缀和", "哈希表"]
---

LeetCode 560

https://leetcode.cn/problems/subarray-sum-equals-k/description/

难度：中等

本题是前缀和题目。需要注意只有满足单调性的时候才能使用滑动窗口。

s 为前缀和，如果 i 到 j 的和为 k，那么 s[j] - s[i] == k。

枚举右，维护左，通过哈希表统计有多少 s[i] == s[j] - k。

时间复杂度：O(n)，其中 n 为 nums 的长度。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
public:
    int subarraySum(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> s(n + 1);
        for (int i = 0; i < n; i++) {
            s[i + 1] = s[i] + nums[i];
        }

        int ans = 0;
        unordered_map<int, int> cnt;
        for (int sj : s) {
            // 注意不要直接 += cnt[sj-k]，如果 sj-k 不存在，会插入 sj-k
            ans += cnt.contains(sj - k) ? cnt[sj - k] : 0;
            cnt[sj]++;
        }
        return ans;
    }
};
```

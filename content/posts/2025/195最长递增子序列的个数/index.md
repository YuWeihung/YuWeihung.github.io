---
title: "195：最长递增子序列的个数"
date: 2025-07-15T19:04:06+08:00
draft: false
slug: "lc-0673"
categories: ["高频面试题"]
tags: ["动态规划", "线性DP"]
---

LeetCode 673

https://leetcode.cn/problems/number-of-longest-increasing-subsequence/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题是 LC 300 最长递增子序列的升级版。

定义 dp[i] 表示以 nums[i] 结尾的最长上升子序列的长度，cnt[i] 表示以 nums[i] 结尾的最长上升子序列的个数。设 nums 的最长上升子序列的长度为 maxLen，那么答案为所有满足 dp[i]=maxLen 的 i 所对应的 cnt[i] 之和。

对于 cnt[i]，其等于所有满足 dp[j]+1=dp[i] 的 cnt[j] 之和。在代码实现时，我们可以在计算 dp[i] 的同时统计 cnt[i] 的值。

时间复杂度：O(n^2)，其中 n 是数组 nums 的长度。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
public:
    int findNumberOfLIS(vector<int> &nums) {
        int n = nums.size(), maxLen = 0, ans = 0;
        vector<int> dp(n), cnt(n);
        for (int i = 0; i < n; ++i) {
            dp[i] = 1;
            cnt[i] = 1;
            for (int j = 0; j < i; ++j) {
                if (nums[i] > nums[j]) {
                    if (dp[j] + 1 > dp[i]) {
                        dp[i] = dp[j] + 1;
                        cnt[i] = cnt[j]; // 重置计数
                    } else if (dp[j] + 1 == dp[i]) {
                        cnt[i] += cnt[j];
                    }
                }
            }
            if (dp[i] > maxLen) {
                maxLen = dp[i];
                ans = cnt[i]; // 重置计数
            } else if (dp[i] == maxLen) {
                ans += cnt[i];
            }
        }
        return ans;
    }
};
```

---
title: "199：分割等和子集"
date: 2025-07-15T19:04:25+08:00
draft: false
slug: "lc-0416"
categories: ["高频面试题"]
tags: ["动态规划", "0-1背包"]
---

LeetCode 416

https://leetcode.cn/problems/partition-equal-subset-sum/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题相当于能否从 nums 中选出一个子序列，其元素和恰好等于 s/2。这是 0-1 背包的恰好装满型问题。

dfs(i, j)=dfs(i−1, j−nums[i]) || dfs(i−1, j)
​
时间复杂度：O(ns)，其中 n 是 nums 的长度，s 是 nums 的元素和（的一半）。由于每个状态只会计算一次，动态规划的时间复杂度 = 状态个数 × 单个状态的计算时间。本题状态个数等于 O(ns)，单个状态的计算时间为 O(1)，所以动态规划的时间复杂度为 O(ns)。

空间复杂度：O(ns)。保存多少状态，就需要多少空间。


<!--more-->

```cpp
class Solution {
public:
    bool canPartition(vector<int>& nums) {
        int s = reduce(nums.begin(), nums.end());
        if (s % 2) {
            return false;
        }

        int n = nums.size();
        vector memo(n, vector<int>(s / 2 + 1, -1)); // -1 表示没有计算过

        // lambda 递归函数
        auto dfs = [&](this auto&& dfs, int i, int j) -> bool {
            if (i < 0) {
                return j == 0;
            }
            int& res = memo[i][j]; // 注意这里是引用
            if (res != -1) { // 之前计算过
                return res;
            }
            if (j < nums[i]) {
                return res = dfs(i - 1, j); // 只能不选
            }
            return res = dfs(i - 1, j - nums[i]) || dfs(i - 1, j); // 选或不选
        };

        return dfs(n - 1, s / 2);
    }
};
```

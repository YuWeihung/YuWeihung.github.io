---
title: "060：子集"
date: 2025-07-03T13:02:49+08:00
draft: false
slug: "lc-0078"
categories: ["高频面试题"]
tags: ["回溯", "子集型回溯"]
---

LeetCode 78

https://leetcode.cn/problems/subsets/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

子集型回溯，选或不选。

时间复杂度：\(O(n2^n)\)，其中 n 为 nums 的长度。每次都是选或不选，递归次数为一个满二叉树的节点个数，那么一共会递归 \(O(2^n)\) 次（等比数列和），再算上加入答案时复制 path 需要 O(n) 的时间，所以时间复杂度为 \(O(n2^n)\)。

空间复杂度：O(n)。返回值的空间不计。

<!--more-->

```cpp
class Solution {
public:
    vector<vector<int>> subsets(vector<int>& nums) {
        vector<vector<int>> ans;
        vector<int> path;
        int n = nums.size();
        auto dfs = [&](auto &&dfs, int i) {
            if (i == n) {
                ans.emplace_back(path);
                return;
            }
            dfs(dfs, i + 1);
            path.push_back(nums[i]);
            dfs(dfs, i + 1);
            path.pop_back();
        };
        dfs(dfs, 0);
        return ans;
    }
};
```

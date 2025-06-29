---
title: "015：全排列"
date: 2025-06-29T11:31:55+08:00
draft: false
slug: "lc-0046"
categories: ["高频面试题"]
tags: ["回溯"]
---

LeetCode 46

https://leetcode.cn/problems/permutations/description/

难度：中等

这是一道回溯法的题目，本题适用于“枚举选哪个”方法。

时间复杂度：O(n⋅n!)，其中 n 为 nums 的长度。灵神的视频中提到，搜索树中的节点个数低于 3⋅n!。实际上，精确值为 ⌊e⋅n!⌋，其中 e=2.718⋯ 为自然常数。有 O(n!) 个叶节点，每个叶节点花费 O(n) 的时间复制 path 数组，因此时间复杂度为 O(n⋅n!)。

空间复杂度：O(n)。返回值的空间不计入。

<!--more-->

```cpp
class Solution {
public:
    vector<vector<int>> permute(vector<int> &nums) {
        int n = nums.size();
        vector<vector<int>> ans;
        vector<int> path(n), on_path(n); // 所有排列的长度都是一样的 n
        auto dfs = [&](this auto&& dfs, int i) {
            if (i == n) {
                ans.emplace_back(path);
                return;
            }
            for (int j = 0; j < n; j++) {
                if (!on_path[j]) {
                    path[i] = nums[j]; // 从没有选的数字中选一个
                    on_path[j] = true; // 已选上
                    dfs(i + 1);
                    on_path[j] = false; // 恢复现场
                    // 注意 path 无需恢复现场，因为排列长度固定，直接覆盖就行
                }
            }
        };
        dfs(0);
        return ans;
    }
};
```

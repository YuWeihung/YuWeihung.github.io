---
title: "122：组合总和II"
date: 2025-07-15T19:01:39+08:00
draft: false
slug: "lc-0040"
categories: ["高频面试题"]
tags: ["回溯", "有重复元素的回溯"]
---

LeetCode 40

https://leetcode.cn/problems/combination-sum-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

为了避免得到重复的答案，首先对数组排序。如果选，递归到 i + 1，如果不选，跳过所有等于当前数的数，递归到 i + k。也就是对于相同的元素，只能按照顺序选，不能跳过一个选后面的。

时间复杂度：\(O(n\*2^2)\)

空间复杂度：O(n)

<!--more-->

```cpp
class Solution {
public:
    vector<vector<int>> combinationSum2(vector<int>& candidates, int target) {
        ranges::sort(candidates);
        int n = candidates.size();
        vector<vector<int>> ans;
        vector<int> path;
        auto dfs = [&](this auto&& dfs, int i, int left) -> void {
            // 所选元素之和恰好等于 target
            if (left == 0) {
                ans.push_back(path);
                return;
            }

            // 没有可以选的数字
            if (i == n) {
                return;
            }

            // 所选元素之和无法恰好等于 target
            int x = candidates[i];
            if (left < x) {
                return;
            }

            // 选 x
            path.push_back(x);
            dfs(i + 1, left - x);
            path.pop_back(); // 恢复现场

            // 不选 x，那么后面所有等于 x 的数都不选
            // 如果不跳过这些数，会导致「选 x 不选 x'」和「不选 x 选 x'」这两种情况都会加到 ans 中，这就重复了
            i++;
            while (i < n && candidates[i] == x) {
                i++;
            }
            dfs(i, left);
        };
        dfs(0, target);
        return ans;
    }
};
```

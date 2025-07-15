---
title: "066：组合总和"
date: 2025-07-03T22:20:44+08:00
draft: false
slug: "lc-0039"
categories: ["高频面试题"]
tags: ["回溯", "子集型回溯"]
---

LeetCode 39

https://leetcode.cn/problems/combination-sum/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

子集型回溯，选或不选。

类似完全背包，选的话递归到 dfs(i, left - candidates[i])，不选递归到 dfs(i + 1, left)。

时间复杂度：O(S)，其中 S 为所有可行解的长度之和。从分析给出的搜索树我们可以看出时间复杂度取决于搜索树所有叶子节点的深度之和，即所有可行解的长度之和。在这题中，我们很难给出一个比较紧的上界，我们知道 \(O(n2^n)\) 是一个比较松的上界，即在这份代码中，n 个位置每次考虑选或者不选，如果符合条件，就加入答案的时间代价。但是实际运行的时候，因为不可能所有的解都满足条件，递归的时候我们还会用 target−candidates[idx]≥0 进行剪枝，所以实际运行情况是远远小于这个上界的。

空间复杂度：O(target)。除答案数组外，空间复杂度取决于递归的栈深度，在最差情况下需要递归 O(target) 层。

<!--more-->

```cpp
class Solution {
public:
    vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
        vector<vector<int>> ans;
        vector<int> path;
        int n = candidates.size();
        auto dfs = [&](auto&& dfs, int i, int left) {
            if (left == 0) {
                ans.push_back(path);
                return;
            }
            if (i == n || left < 0) {
                return;
            }
            // 选
            path.push_back(candidates[i]);
            dfs(dfs, i, left - candidates[i]);
            path.pop_back();

            // 不选
            dfs(dfs, i + 1, left);
        };
        dfs(dfs, 0, target);
        return ans;
    }
};
```

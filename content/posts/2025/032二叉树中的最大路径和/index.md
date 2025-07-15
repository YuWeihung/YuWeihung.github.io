---
title: "032：二叉树中的最大路径和"
date: 2025-06-30T13:20:49+08:00
draft: false
slug: "lc-0124"
categories: ["高频面试题"]
tags: ["动态规划", "树形DP"]
---

LeetCode 124

https://leetcode.cn/problems/binary-tree-maximum-path-sum/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这道题是树形 DP 中的直径 DP。枚举直径拐弯的位置，在每一个拐弯的位置更新答案，将以当前节点为根的链的最大路径和返回给父节点，如果路径和为负数返回 0。

边界条件是空节点的路径和为 0。

需要注意的是，更新答案的是直接的路径和，而返回的是链的路径和。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。

空间复杂度：O(n)。最坏情况下，二叉树退化成一条链，递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    int maxPathSum(TreeNode* root) {
        int ans = INT_MIN;
        auto dfs = [&](auto &&dfs, TreeNode* node) {
            if (node == nullptr) {
                return 0;
            }
            int l_val = dfs(dfs, node->left);
            int r_val = dfs(dfs, node->right);
            ans = max(ans, l_val + r_val + node->val);
            return max(0, max(l_val, r_val) + node->val);
        };
        dfs(dfs, root);
        return ans;
    }
};
```

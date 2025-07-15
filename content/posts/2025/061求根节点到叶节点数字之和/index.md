---
title: "061：求根节点到叶节点数字之和"
date: 2025-07-03T16:59:20+08:00
draft: false
slug: "lc-0129"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 129

https://leetcode.cn/problems/sum-root-to-leaf-numbers/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

使用参数记录路径之和，当当前节点为叶子节点时更新答案，并处理节点为空的情况。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。

空间复杂度：O(n)。最坏情况下，二叉树退化成一条链，递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    int sumNumbers(TreeNode* root) {
        int ans = 0;
        auto dfs = [&](auto &&dfs, TreeNode* node, int path) {
            if (node == nullptr) {
                return;
            }
            path = path * 10 + node->val;
            if (node->left == node->right) {
                ans += path;
                return;
            }
            dfs(dfs, node->left, path);
            dfs(dfs, node->right, path);
        };
        dfs(dfs, root, 0);
        return ans;
    }
};
```

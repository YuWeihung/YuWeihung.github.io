---
title: "040：二叉树的中序遍历"
date: 2025-06-30T22:29:06+08:00
draft: false
slug: "lc-0094"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 94

https://leetcode.cn/problems/binary-tree-inorder-traversal/description/

难度：简单

二叉树中序遍历的递归实现。

时间复杂度：O(n)，其中 n 为二叉树节点的个数。二叉树的遍历中每个节点会被访问一次且只会被访问一次。

空间复杂度：O(n)。空间复杂度取决于递归的栈深度，而栈深度在二叉树为一条链的情况下会达到 O(n) 的级别。

<!--more-->

```cpp
class Solution {
public:
    vector<int> inorderTraversal(TreeNode* root) {
        vector<int> ans;
        auto dfs = [&](auto &&dfs, TreeNode* node) {
            if (node == nullptr) {
                return;
            }
            dfs(dfs, node->left);
            ans.push_back(node->val);
            dfs(dfs, node->right);
        };
        dfs(dfs, root);
        return ans;
    }
};
```

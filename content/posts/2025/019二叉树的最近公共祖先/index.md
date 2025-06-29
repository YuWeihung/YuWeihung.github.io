---
title: "019：二叉树的最近公共祖先"
date: 2025-06-29T12:00:53+08:00
draft: false
slug: "lc-0236"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 236

https://leetcode.cn/problems/lowest-common-ancestor-of-a-binary-tree/description/

难度：中等

二叉树题目。如果当前节点为空，或者为 p，或者为 q，直接返回当前节点。

如果左右子树都找到 p 或 q，返回当前节点。

如果左子树找到 p 和 q，返回左子树的结果。

如果右子树找到 p 和 q，返回右子树的结果。

如果左右子树都没找到，返回空节点。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。

空间复杂度：O(n)。最坏情况下，二叉树是一条链，因此递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        if (root == nullptr || root == p || root == q) {
            return root;
        }
        TreeNode* left = lowestCommonAncestor(root->left, p, q);
        TreeNode* right = lowestCommonAncestor(root->right, p, q);
        if (left && right) { // 左右都找到
            return root; // 当前节点是最近公共祖先
        }
        return left ? left : right;
    }
};
```

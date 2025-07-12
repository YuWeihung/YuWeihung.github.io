---
title: "097：翻转二叉树"
date: 2025-07-06T13:20:20+08:00
draft: false
slug: "lc-0226"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 226

https://leetcode.cn/problems/invert-binary-tree/description/

难度：简单

递归调用 invertTree(root.left)，获取到左子树翻转后的结果 left。

递归调用 invertTree(root.right)，获取到右子树翻转后的结果 right。

交换左右儿子，即更新 root.left 为 right，更新 root.right 为 left。

返回 root。

递归边界：如果 root 是空节点，返回空。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。

空间复杂度：O(n)。最坏情况下，二叉树退化成一条链，递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    TreeNode* invertTree(TreeNode* root) {
        if (root == nullptr) {
            return nullptr;
        }
        auto left = invertTree(root->left); // 翻转左子树
        auto right = invertTree(root->right); // 翻转右子树
        root->left = right; // 交换左右儿子
        root->right = left;
        return root;
    }
};
```

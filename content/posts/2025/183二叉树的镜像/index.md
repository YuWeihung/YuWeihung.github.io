---
title: "183：二叉树的镜像"
date: 2025-07-15T19:03:27+08:00
draft: false
slug: "lcr-0144"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LCR 144

https://leetcode.cn/problems/er-cha-shu-de-jing-xiang-lcof/description/

难度：简单

递归镜像二叉树。

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

时间复杂度 O(N) ： 其中 N 为二叉树的节点数量，建立二叉树镜像需要遍历树的所有节点，占用 O(N) 时间。

空间复杂度 O(N) ： 最差情况下（当二叉树退化为链表），递归时系统需使用 O(N) 大小的栈空间。

<!--more-->

```cpp
class Solution {
public:
    TreeNode* flipTree(TreeNode* root) {
        if (root == nullptr) {
            return nullptr;
        }
        TreeNode* left = flipTree(root->left);
        TreeNode* right = flipTree(root->right);
        root->left = right;
        root->right = left;
        return root;
    }
};
```

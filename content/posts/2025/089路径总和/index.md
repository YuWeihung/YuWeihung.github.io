---
title: "089：路径总和"
date: 2025-07-05T23:02:35+08:00
draft: false
slug: "lc-0112"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 112

https://leetcode.cn/problems/path-sum/description/

难度：简单

直接递归调用 hasPathSum，当前节点为叶子节点时判断是否存在路径。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。

空间复杂度：O(n)。最坏情况下，二叉树退化成一条链，递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    bool hasPathSum(TreeNode* root, int targetSum) {
        if (root == nullptr) {
            return false;
        }
        targetSum -= root->val;
        if (root->left == nullptr && root->right == nullptr) { // root 是叶子
            return targetSum == 0;
        }
        return hasPathSum(root->left, targetSum) || hasPathSum(root->right, targetSum);
    }
};
```

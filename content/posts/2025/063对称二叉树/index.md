---
title: "063对称二叉树"
date: 2025-07-03T22:01:06+08:00
draft: false
slug: "lc-0101"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 101

https://leetcode.cn/problems/symmetric-tree/description/

难度：简单

与 LeetCode 100 相同的树 类似，这个比较 p 的左子树和 q 和右子树。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。

空间复杂度：O(n)。最坏情况下，二叉树退化成一条链，递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
    // 在【100. 相同的树】的基础上稍加改动
    bool isSameTree(TreeNode* p, TreeNode* q) {
        if (p == nullptr || q == nullptr) {
            return p == q;
        }
        return p->val == q->val && isSameTree(p->left, q->right) && isSameTree(p->right, q->left);
    }

public:
    bool isSymmetric(TreeNode* root) {
        return isSameTree(root->left, root->right);
    }
};
```

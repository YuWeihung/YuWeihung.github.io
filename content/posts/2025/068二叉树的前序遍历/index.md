---
title: "068：二叉树的前序遍历"
date: 2025-07-03T23:09:26+08:00
draft: false
slug: "lc-0144"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 144

https://leetcode.cn/problems/binary-tree-preorder-traversal/description/

难度：简单

递归求二叉树的前序遍历。

时间复杂度：O(n)，其中 n 是二叉树的节点数。每一个节点恰好被遍历一次。

空间复杂度：O(n)，为递归过程中栈的开销，平均情况下为 O(logn)，最坏情况下树呈现链状，为 O(n)。

<!--more-->

```cpp
class Solution {
public:
    vector<int> preorderTraversal(TreeNode* root) {
        vector<int> ans;
        auto dfs = [&](auto &&dfs, TreeNode* node) {
            if (node == nullptr) {
                return;
            }
            ans.push_back(node->val);
            dfs(dfs, node->left);
            dfs(dfs, node->right);
        };
        dfs(dfs, root);
        return ans;
    }
};
```

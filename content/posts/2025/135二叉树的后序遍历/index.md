---
title: "135：二叉树的后序遍历"
date: 2025-07-15T19:01:55+08:00
draft: false
slug: "lc-0145"
categories: ["高频面试题"]
tags: ["二叉树"]
---

LeetCode 145

https://leetcode.cn/problems/binary-tree-postorder-traversal/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

二叉树后序遍历。

时间复杂度：O(n)，其中 n 是二叉搜索树的节点数。每一个节点恰好被遍历一次。

空间复杂度：O(n)，为递归过程中栈的开销，平均情况下为 O(logn)，最坏情况下树呈现链状，为 O(n)。

<!--more-->

```cpp
class Solution {
public:
    vector<int> postorderTraversal(TreeNode* root) {
        vector<int> ans;
        auto dfs = [&](this auto &&dfs, TreeNode* node) {
            if (node == nullptr) {
                return;
            }
            dfs(node->left);
            dfs(node->right);
            ans.push_back(node->val);
        };
        dfs(root);
        return ans;
    }
};
```

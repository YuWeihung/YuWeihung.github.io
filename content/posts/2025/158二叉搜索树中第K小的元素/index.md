---
title: "158：二叉搜索树中第K小的元素"
date: 2025-07-15T19:02:32+08:00
draft: false
slug: "lc-0230"
categories: ["高频面试题"]
tags: ["二叉树", "二叉搜索树"]
---

LeetCode 230

https://leetcode.cn/problems/kth-smallest-element-in-a-bst/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

中序遍历二叉树。

时间复杂度：O(n)，其中 n 是二叉树的大小（节点个数）。

空间复杂度：O(h)，其中 h 是树高，递归需要 O(h) 的栈空间。最坏情况下树是一条链，h=n，空间复杂度为 O(n)。

<!--more-->

```cpp
class Solution {
public:
    int kthSmallest(TreeNode* root, int k) {
        int ans;
        auto dfs = [&](this auto&& dfs, TreeNode* node) -> void {
            if (node == nullptr || k == 0) {
                return;
            }
            dfs(node->left); // 左
            if (--k == 0) {
                ans = node->val; // 根
            }
            dfs(node->right); // 右
        };
        dfs(root);
        return ans;
    }
};
```

---
title: "057：从前序与中序遍历序列构造二叉树"
date: 2025-07-03T10:49:58+08:00
draft: false
slug: "lc-0105"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 105

https://leetcode.cn/problems/construct-binary-tree-from-preorder-and-inorder-traversal/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题使用递归从二叉树的前序和中序遍历构造二叉树。首先找到中序遍历中根节点的位置，它左边就是左子树的长度。然后构造左右子树的前序和中序遍历，递归调用，构造二叉树。

时间复杂度：\(O(n^2)\)，其中 n 为 preorder 的长度。最坏情况下二叉树是一条链，我们需要递归 O(n) 次，每次都需要 O(n) 的时间查找 preorder[0] 和复制数组。

空间复杂度：\(O(n^2)\)。

<!--more-->

```cpp
class Solution {
public:
    TreeNode* buildTree(vector<int>& preorder, vector<int>& inorder) {
        if (preorder.empty()) {
            return nullptr;
        }
        int left_size = find(inorder.begin(), inorder.end(), preorder[0]) - inorder.begin();
        vector<int> pre1(preorder.begin() + 1, preorder.begin() + 1 + left_size);
        vector<int> pre2(preorder.begin() + 1 + left_size, preorder.end());
        vector<int> in1(inorder.begin(), inorder.begin() + left_size);
        vector<int> in2(inorder.begin() + 1 + left_size, inorder.end());
        TreeNode *left = buildTree(pre1, in1);
        TreeNode *right = buildTree(pre2, in2);
        return new TreeNode(preorder[0], left, right);
    }
};
```

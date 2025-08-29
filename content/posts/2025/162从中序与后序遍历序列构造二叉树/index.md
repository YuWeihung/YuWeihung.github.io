---
title: "162：从中序与后序遍历序列构造二叉树"
date: 2025-07-15T19:02:39+08:00
draft: false
slug: "lc-0106"
categories: ["高频面试题"]
tags: ["二叉树"]
---

LeetCode 106

https://leetcode.cn/problems/construct-binary-tree-from-inorder-and-postorder-traversal/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

时间复杂度：\(O(n^2)\)，其中 n 为 postorder 的长度。最坏情况下二叉树是一条链，我们需要递归 O(n) 次，每次都需要 O(n) 的时间查找 postorder[n−1] 和复制数组。

空间复杂度：\(O(n^2)\)。

<!--more-->

```cpp
class Solution {
public:
    TreeNode* buildTree(vector<int>& inorder, vector<int>& postorder) {
        if (postorder.empty()) { // 空节点
            return nullptr;
        }
        int left_size = ranges::find(inorder, postorder.back()) - inorder.begin(); // 左子树的大小
        vector<int> in1(inorder.begin(), inorder.begin() + left_size);
        vector<int> in2(inorder.begin() + left_size + 1, inorder.end());
        vector<int> post1(postorder.begin(), postorder.begin() + left_size);
        vector<int> post2(postorder.begin() + left_size, postorder.end() - 1);
        TreeNode* left = buildTree(in1, post1);
        TreeNode* right = buildTree(in2, post2);
        return new TreeNode(postorder.back(), left, right);
    }
};
```

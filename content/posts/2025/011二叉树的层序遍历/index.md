---
title: "011：二叉树的层序遍历"
date: 2025-06-28T23:13:33+08:00
draft: false
slug: "lc-0102"
categories: ["高频面试题"]
tags: ["二叉树", "BFS"]
---

LeetCode 102

https://leetcode.cn/problems/binary-tree-level-order-traversal/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这道题是 BFS 的经典题目。本题使用两个数组 cur 和 nxt 来实现 BFS。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。

空间复杂度：O(n)。满二叉树（每一层都填满）最后一层有大约 n/2 个节点，因此数组中最多有 O(n) 个元素，所以空间复杂度是 O(n) 的。

<!--more-->

```cpp
class Solution {
public:
    vector<vector<int>> levelOrder(TreeNode* root) {
        if (root == nullptr) {
            return {};
        }
        vector<TreeNode*> cur;
        cur.push_back(root);
        vector<vector<int>> ans;
        while (cur.size() > 0) {
            vector<TreeNode*> nxt;
            vector<int> level;
            for (TreeNode* node: cur) {
                level.push_back(node->val);
                if (node->left) {
                    nxt.push_back(node->left);
                }
                if (node->right) {
                    nxt.push_back(node->right);
                }
            }
            ans.push_back(level);
            cur = move(nxt);
        }
        return ans;
    }
};
```

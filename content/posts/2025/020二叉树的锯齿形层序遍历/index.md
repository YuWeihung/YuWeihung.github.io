---
title: "020：二叉树的锯齿形层序遍历"
date: 2025-06-29T18:57:16+08:00
draft: false
slug: "lc-0103"
categories: ["高频面试题"]
tags: ["二叉树", "BFS"]
---

LeetCode 103

https://leetcode.cn/problems/binary-tree-zigzag-level-order-traversal/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这道题类似 LeetCode 102，只是需要判断当前层的奇偶性，如果是偶数，需要把当前层的结果翻转后再加入答案。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。
空间复杂度：O(n)。满二叉树（每一层都填满）最后一层有大约 n/2 个节点，因此数组中最多有 O(n) 个元素，所以空间复杂度是 O(n) 的。

<!--more-->

```cpp
class Solution {
public:
    vector<vector<int>> zigzagLevelOrder(TreeNode *root) {
        if (root == nullptr) return {};
        vector<vector<int>> ans;
        vector<TreeNode *> cur = {root};
        while (!cur.empty()) {
            vector<TreeNode *> nxt;
            vector<int> vals;
            for (auto node : cur) {
                vals.push_back(node->val);
                if (node->left)  nxt.push_back(node->left);
                if (node->right) nxt.push_back(node->right);
            }
            cur = move(nxt);
            if (ans.size() % 2) ranges::reverse(vals);
            ans.emplace_back(vals);
        }
        return ans;
    }
};
```

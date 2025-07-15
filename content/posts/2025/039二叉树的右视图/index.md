---
title: "039：二叉树的右视图"
date: 2025-06-30T22:22:49+08:00
draft: false
slug: "lc-0199"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 199

https://leetcode.cn/problems/binary-tree-right-side-view/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

先递归右子树，再递归左子树，当某个深度首次到达时，对应的节点就在右视图中。

时间复杂度：O(n)，其中 n 是二叉树的节点个数。

空间复杂度：O(h)，其中 h 是二叉树的高度。递归需要 O(h) 的栈空间。最坏情况下，二叉树退化成一条链，递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    vector<int> rightSideView(TreeNode* root) {
        vector<int> ans;
        auto dfs = [&](this auto&& dfs, TreeNode* node, int depth) -> void {
            if (node == nullptr) {
                return;
            }
            if (depth == ans.size()) { // 这个深度首次遇到
                ans.push_back(node->val);
            }
            dfs(node->right, depth + 1); // 先递归右子树，保证首次遇到的一定是最右边的节点
            dfs(node->left, depth + 1);
        };
        dfs(root, 0);
        return ans;
    }
};
```

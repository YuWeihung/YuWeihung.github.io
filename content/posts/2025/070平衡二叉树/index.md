---
title: "070：平衡二叉树"
date: 2025-07-03T23:26:14+08:00
draft: false
slug: "lc-0110"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 110

https://leetcode.cn/problems/balanced-binary-tree/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这道题对 LeetCode 104 二叉树的最大深度 稍加改造，当求出左右子树的深度时，如果深度差超过 1，则返回 -1，父节点如果接收到 -1，也直接返回 -1，否则返回当前子树的深度。最后判断根节点得到的深度是否为 -1。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。

空间复杂度：O(n)。最坏情况下，二叉树退化成一条链，递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    bool isBalanced(TreeNode* root) {
        auto dfs = [&](auto &&dfs, TreeNode* node) -> int {
            if (node == nullptr) {
                return 0;
            }
            int left = dfs(dfs, node->left);
            int right = dfs(dfs, node->right);
            if (left == -1 || right == -1 || abs(left - right) > 1) {
                return -1;
            }
            return max(left, right) + 1;
        };

        return dfs(dfs, root) != -1;
    }
};
```

---
title: "137：另一个树的子树"
date: 2025-07-15T19:01:59+08:00
draft: false
slug: "lc-0572"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 572

https://leetcode.cn/problems/subtree-of-another-tree/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

如果暴力匹配，时间复杂度是 O(n⋅min(n,m))，如何改进呢？

定义节点 node 的高度为 node 到其最深叶子的路径上的节点个数。特别地，叶子的高度为 1。设 subRoot 的高度为 hs。

设 node 为 root 中的节点。我们可以在匹配之前，先判断 node 的高度是否等于 hs，只有在相等时才做匹配。

这样做的时间复杂度是多少呢？

首先，对于 root 中的两个高度相同的节点 p 和 q（p

=q），不可能出现 p 是 q 的祖先，或者 q 是 p 的祖先。因为如果 p 是 q 的祖先，那么 p 的高度必然大于 q 的高度，反之亦然。

其次，对于 root 中的两个高度相同的节点 p 和 q（p != q），子树 p 和子树 q 没有任何交集。假如有交集，说明从 p 出发可以到达某个点 node，从 q 出发也可以到达 node，但这只有在 p 是 q 的祖先，或者 q 是 p 的祖先时才成立，与两个节点高度相同矛盾。

所以，root 中的所有与 hs 高度相同的节点，对应的子树两两不相交，这些子树的节点个数之和不超过 n，所以总的匹配次数也不会超过 n，下面代码中的 dfs 的时间复杂度为 O(n)。

时间复杂度：O(n+m)，其中 n 是二叉树 root 的节点个数，m 是二叉树 subRoot 的节点个数。注意当 subRoot 的节点个数比 n 还要多时，dfs 并不会遍历 subRoot 中的所有节点。其中 O(m) 是计算 subRoot 树高的时间，如果限制 getHeight 递归访问的节点个数至多为 n，则可以做到 O(n) 的时间复杂度。

空间复杂度：O(n+m)。如果限制 getHeight 递归访问的节点个数至多为 n，则可以做到 O(n) 的（栈）空间复杂度。

<!--more-->

```cpp
class Solution {
    // 代码逻辑同 104. 二叉树的最大深度
    int getHeight(TreeNode* root) {
        if (root == nullptr) {
            return 0;
        }
        int left_h = getHeight(root->left);
        int right_h = getHeight(root->right);
        return max(left_h, right_h) + 1;
    }

    // 100. 相同的树
    bool isSameTree(TreeNode* p, TreeNode* q) {
        if (p == nullptr || q == nullptr) {
            return p == q; // 必须都是 nullptr
        }
        return p->val == q->val &&
               isSameTree(p->left, q->left) &&
               isSameTree(p->right, q->right);
    }

public:
    bool isSubtree(TreeNode* root, TreeNode* subRoot) {
        int hs = getHeight(subRoot);

        // 返回 node 的高度，以及是否找到了 subRoot
        auto dfs = [&](this auto&& dfs, TreeNode* node) -> pair<int, bool> {
            if (node == nullptr) {
                return {0, false};
            }
            auto [left_h, left_found] = dfs(node->left);
            auto [right_h, right_found] = dfs(node->right);
            if (left_found || right_found) {
                return {0, true};
            }
            int node_h = max(left_h, right_h) + 1;
            return {node_h, node_h == hs && isSameTree(node, subRoot)};
        };
        return dfs(root).second;
    }
};
```

---
title: "073：二叉树的直径"
date: 2025-07-04T19:22:11+08:00
draft: false
slug: "lc-0543"
categories: ["高频面试题"]
tags: ["动态规划", "树形DP"]
---

LeetCode 543

https://leetcode.cn/problems/diameter-of-binary-tree/description/

难度：简单

树形 DP 中的直径 DP。

链：从子树中的叶子节点到当前节点的路径。把最长链的长度，作为 dfs 的返回值。根据这一定义，空节点的链长是 −1，叶子节点的链长是 0。

直径：等价于由两条（或者一条）链拼成的路径。我们枚举每个 node，假设直径在这里「拐弯」，也就是计算由左右两条从下面的叶子节点到 node 的链的节点值之和，去更新答案的最大值。

直径可能在下面的某个节点拐弯，不一定经过树根 root。

dfs 返回的是链的长度，不是直径的长度。如果返回直径，那么上面与其他的链继续拼接，得到的就不是直径了。

dfs 返回的是当前子树的最大链长（也可以理解为子树的高度），不包含当前节点和其父节点的这条边。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。

空间复杂度：O(n)。最坏情况下，二叉树退化成一条链，递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    int diameterOfBinaryTree(TreeNode* root) {
        int ans = 0;
        auto dfs = [&](this auto&& dfs, TreeNode* node) -> int {
            if (node == nullptr) {
                return -1; // 对于叶子来说，链长就是 -1+1=0
            }
            int l_len = dfs(node->left) + 1; // 左子树最大链长+1
            int r_len = dfs(node->right) + 1; // 右子树最大链长+1
            ans = max(ans, l_len + r_len); // 两条链拼成路径
            return max(l_len, r_len); // 当前子树最大链长
        };
        dfs(root);
        return ans;
    }
};
```

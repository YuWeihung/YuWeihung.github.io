---
title: "140：二叉搜索树的第k大节点"
date: 2025-07-15T19:02:04+08:00
draft: false
slug: "lcr-0174"
categories: ["高频面试题"]
tags: ["二叉树", "二叉搜索树"]
---

LCR 174

https://leetcode.cn/problems/er-cha-sou-suo-shu-de-di-kda-jie-dian-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

二叉搜索树前序遍历为递增序列，而把前序遍历反过来可以得到递减序列。

如何把前序遍历反过来呢？为 “右、根、左” 顺序。

当访问到第 cnt 个节点，即可返回。

时间复杂度：O(n)

空间复杂度：O(n)

<!--more-->

```cpp
class Solution {
public:
    int findTargetNode(TreeNode* root, int cnt) {
        int ans = INT_MIN;
        auto dfs = [&](this auto&&dfs, TreeNode* node) {
            if (node == nullptr || cnt == 0) {
                return;
            }
            dfs(node->right);
            cnt--;
            if (cnt == 0) {
                ans = node->val;
            }
            dfs(node->left);
        };
        dfs(root);
        return ans;
    }
};
```

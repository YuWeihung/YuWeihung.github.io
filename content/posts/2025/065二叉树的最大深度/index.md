---
title: "065：二叉树的最大深度"
date: 2025-07-03T22:18:06+08:00
draft: false
slug: "lc-0104"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 104

https://leetcode.cn/problems/maximum-depth-of-binary-tree/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

递归求最大深度。

时间复杂度：O(n)，其中 n 为二叉树的节点个数。

空间复杂度：O(n)。最坏情况下，二叉树退化成一条链，递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    int maxDepth(TreeNode* root) {
        if (root == nullptr) {
            return 0;
        }
        int left =maxDepth(root->left);
        int right = maxDepth(root->right);
        return max(left, right) + 1;
    }
};
```

---
title: "078：验证二叉搜索树"
date: 2025-07-04T19:23:09+08:00
draft: false
slug: "lc-0098"
categories: ["高频面试题"]
tags: ["二叉树", "递归"]
---

LeetCode 98

https://leetcode.cn/problems/validate-binary-search-tree/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

使用中序遍历验证二叉搜索树，比较当前节点与上一个节点的值的大小。需要注意的是，为了处理节点值为 INT_MIN 的情况，pre 需要初始化为 LLONG_MIN。

时间复杂度：O(n)，其中 n 为二叉搜索树的节点个数。

空间复杂度：O(n)。最坏情况下，二叉搜索树退化成一条链（注意题目没有保证它是平衡树），因此递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
    long long pre = LLONG_MIN;
public:
    bool isValidBST(TreeNode* root) {
        if (root == nullptr) {
            return true;
        }
        if (!isValidBST(root->left)) { // 左
            return false;
        }
        if (root->val <= pre) { // 中
            return false;
        }
        pre = root->val;
        return isValidBST(root->right); // 右
    }
};
```

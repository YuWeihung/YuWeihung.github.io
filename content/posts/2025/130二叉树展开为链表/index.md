---
title: "130：二叉树展开为链表"
date: 2025-07-15T19:01:48+08:00
draft: false
slug: "lc-0114"
categories: ["高频面试题"]
tags: ["二叉树", "链表"]
---

LeetCode 114

https://leetcode.cn/problems/flatten-binary-tree-to-linked-list/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

采用头插法构建链表，按照右子树 - 左子树 - 根的顺序 DFS 这棵树。DFS 的同时，记录当前链表的头节点为 head。一开始 head 是空节点。

具体来说：

- 如果当前节点为空，返回。
- 递归右子树。
- 递归左子树。
- 把 root.left 置为空。
- 头插法，把 root 插在 head 的前面，也就是 root.right=head。
- 现在 root 是链表的头节点，把 head 更新为 root。

时间复杂度：O(n)，其中 n 是二叉树的节点个数。

空间复杂度：O(n)。递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
    TreeNode* head;
public:
    void flatten(TreeNode* root) {
        if (root == nullptr) {
            return;
        }
        flatten(root->right);
        flatten(root->left);
        root->left = nullptr;
        root->right = head; // 头插法，相当于链表的 root->next = head
        head = root; // 现在链表头节点是 root
    }
};
```

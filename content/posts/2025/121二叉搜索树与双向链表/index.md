---
title: "121：二叉搜索树与双向链表"
date: 2025-07-15T19:01:37+08:00
draft: false
slug: "lcr-0155"
categories: ["高频面试题"]
tags: ["二叉树", "中序遍历"]
---

LCR 155

https://leetcode.cn/problems/er-cha-sou-suo-shu-yu-shuang-xiang-lian-biao-lcof/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

使用中序遍历遍历二叉树搜索树，定义变量 head，pre，当前节点 cur，cur->left = pre，pre->right = cur。最后 pre 指向最后一个节点，更新 head->left = pre，pre->right = head。

时间复杂度：O(n)

空间复杂度：O(n)

<!--more-->

```cpp
class Solution {
public:
    Node* treeToDoublyList(Node* root) {
        if (root == nullptr) {
            return nullptr;
        }
        Node* pre = nullptr, *head = nullptr;
        auto dfs = [&](auto &&dfs, Node* cur) {
            if (cur == nullptr) {
                return;
            }
            dfs(dfs, cur->left);
            if (pre != nullptr) {
                pre->right = cur;
            } else {
                head = cur;
            }
            cur->left = pre;
            pre = cur;
            dfs(dfs, cur->right);
        };
        dfs(dfs, root);
        head->left = pre;
        pre->right = head;
        return head;
    }
};
```

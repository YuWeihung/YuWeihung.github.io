---
title: "119：二叉树的完全性检验"
date: 2025-07-15T19:01:35+08:00
draft: false
slug: "lc-0958"
categories: ["高频面试题"]
tags: ["二叉树", "BFS"]
---

LeetCode 958

https://leetcode.cn/problems/check-completeness-of-a-binary-tree/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

层序遍历二叉树。如果遍历到了一个非空节点之前遍历过空节点，就不是完全二叉树。

时间复杂度：O(N)，其中 N 是树节点个数。

空间复杂度：O(N)。

<!--more-->

```cpp
class Solution {
public:
    bool isCompleteTree(TreeNode* root) {
        vector<TreeNode*> cur;
        cur.push_back(root);
        bool flag = false;
        while (cur.size() > 0) {
            vector<TreeNode*> nxt;
            for (TreeNode* node: cur) {
                if (node == nullptr) {
                    flag = true;
                    continue;
                }
                if (flag) {
                    return false;
                }
                nxt.push_back(node->left);
                nxt.push_back(node->right);
            }
            cur = move(nxt);
        }
        return true;
    }
};
```

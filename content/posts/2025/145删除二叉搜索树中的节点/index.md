---
title: "145：删除二叉搜索树中的节点"
date: 2025-07-15T19:02:11+08:00
draft: false
slug: "lc-0450"
categories: ["高频面试题"]
tags: ["二叉树", "二叉搜索树"]
---

LeetCode 450

https://leetcode.cn/problems/delete-node-in-a-bst/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

1. root 为空，代表未搜索到值为 key 的节点，返回空。
2. root.val>key，表示值为 key 的节点可能存在于 root 的左子树中，需要递归地在 root.left 调用 deleteNode，并返回 root。
3. root.val<key，表示值为 key 的节点可能存在于 root 的右子树中，需要递归地在 root.right 调用 deleteNode，并返回 root。
4. root.val=key，root 即为要删除的节点。此时要做的是删除 root，并将它的子树合并成一棵子树，保持有序性，并返回根节点。根据 root 的子树情况分成以下情况讨论：

- root 为叶子节点，没有子树。此时可以直接将它删除，即返回空。
- root 只有左子树，没有右子树。此时可以将它的左子树作为新的子树，返回它的左子节点。
- root 只有右子树，没有左子树。此时可以将它的右子树作为新的子树，返回它的右子节点。
- root 有左右子树，这时可以将 root 的后继节点（比 root 大的最小节点，即它的右子树中的最小节点，记为 successor）作为新的根节点替代 root，并将 successor 从 root 的右子树中删除，使得在保持有序性的情况下合并左右子树。
  简单证明，successor 位于 root 的右子树中，因此大于 root 的所有左子节点；successor 是 root 的右子树中的最小节点，因此小于 root 的右子树中的其他节点。以上两点保持了新子树的有序性。
  在代码实现上，我们可以先寻找 successor，再删除它。successor 是 root 的右子树中的最小节点，可以先找到 root 的右子节点，再不停地往左子节点寻找，直到找到一个不存在左子节点的节点，这个节点即为 successor。然后递归地在 root.right 调用 deleteNode 来删除 successor。因为 successor 没有左子节点，因此这一步递归调用不会再次步入这一种情况。然后将 successor 更新为新的 root 并返回。

时间复杂度：O(n)，其中 n 为 root 的节点个数。最差情况下，寻找和删除 successor 各需要遍历一次树。

空间复杂度：O(n)，其中 n 为 root 的节点个数。递归的深度最深为 O(n)。

<!--more-->

```cpp
class Solution {
public:
    TreeNode* deleteNode(TreeNode* root, int key) {
        if (root == nullptr) {
            return nullptr;
        }
        if (root->val > key) {
            root->left = deleteNode(root->left, key);
            return root;
        }
        if (root->val < key) {
            root->right = deleteNode(root->right, key);
            return root;
        }
        if (root->val == key) {
            if (!root->left && !root->right) {
                return nullptr;
            }
            if (!root->right) {
                return root->left;
            }
            if (!root->left) {
                return root->right;
            }
            TreeNode *successor = root->right;
            while (successor->left) {
                successor = successor->left;
            }
            root->right = deleteNode(root->right, successor->val);
            successor->right = root->right;
            successor->left = root->left;
            return successor;
        }
        return root;
    }
};
```

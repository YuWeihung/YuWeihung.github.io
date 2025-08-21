---
title: "133：树的子结构"
date: 2025-07-15T19:01:52+08:00
draft: false
slug: "lcr-0143"
categories: ["高频面试题"]
tags: ["二叉树"]
---

LCR 143

https://leetcode.cn/problems/shu-de-zi-jie-gou-lcof/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

具有相同子结构的条件是：

- A、B 非空
- dfs(A, B) 或 dfs(A->left, B) 或 dfs(A->right, B)

时间复杂度 O(MN)： 其中 M,N 分别为树 A 和 树 B 的节点数量；先序遍历树 A 占用 O(M)，每次调用 dfs(A, B) 判断占用 O(N)。

空间复杂度 O(M)： 当树 A 和树 B 都退化为链表时，递归调用深度最大。当 M ≤ N 时，遍历树 A 与递归判断的总递归深度为 M；当 M > N 时，最差情况为遍历至树 A 的叶节点，此时总递归深度为 M。

<!--more-->

```cpp
class Solution {
public:
    bool isSubStructure(TreeNode* A, TreeNode* B) {
        auto dfs = [&](this auto &&dfs, TreeNode* A, TreeNode* B) -> bool {
            if (B == nullptr) {
                return true;
            }
            if (A == nullptr || A->val != B->val) {
                return false;
            }
            return dfs(A->left, B->left) && dfs(A->right, B->right);
        };
        return (A != nullptr && B != nullptr) && (dfs(A, B) || isSubStructure(A->left, B) || isSubStructure(A->right, B));
    }
};
```

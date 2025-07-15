---
title: "083：路径总和 II"
date: 2025-07-05T23:01:57+08:00
draft: false
slug: "lc-0113"
categories: ["高频面试题"]
tags: ["二叉树", "回溯"]
---

LeetCode 113

https://leetcode.cn/problems/path-sum-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

子集型回溯。

时间复杂度：\(O(n^2)\)，其中 n 是二叉树的节点个数。对于「一条链 + 完全二叉树」这样的「扫帚型」二叉树，我们会在 O(n) 个叶子节点处，都去复制长为 O(n) 的 path，所以总的时间复杂度为 \(O(n^2)\)。

空间复杂度：O(n)。返回值不计入。

<!--more-->

```cpp
class Solution {
public:
    vector<vector<int>> pathSum(TreeNode* root, int targetSum) {
        vector<vector<int>> ans;
        vector<int> path;
        auto dfs = [&](auto&& dfs, TreeNode* node, int left) {
            if (node == nullptr) {
                return;
            }
            left -= node->val;
            path.push_back(node->val);
            if (node->left == node->right) {
                if (left == 0) {
                    ans.push_back(path);
                }
            } else {
                dfs(dfs, node->left, left);
                dfs(dfs, node->right, left);
            }
            path.pop_back();
        };
        dfs(dfs, root, targetSum);
        return ans;
    }
};
```

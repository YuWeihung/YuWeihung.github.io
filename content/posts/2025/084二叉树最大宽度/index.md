---
title: "084：二叉树最大宽度"
date: 2025-07-05T23:02:03+08:00
draft: false
slug: "lc-0662"
categories: ["高频面试题"]
tags: ["二叉树", "BFS"]
---

LeetCode 662

https://leetcode.cn/problems/maximum-width-of-binary-tree/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这道题类似二叉树层序遍历，但是除了要保留节点本身，还需要保留节点在本层的编号。对节点 i，左儿子为 2 \* i，右儿子为 2 \* i + 1。

另外，由于最大 3000 个节点，如果是一条只有右儿子的链，那么编号会达到 \(2^3000\)，任何数据类型都会溢出，所以我们需要使用 unsigned long long 类型，当溢出后会重新回到 0，而不会报错。

时间复杂度：O(n)，其中 n 是二叉树的节点个数。需要遍历所有节点。

空间复杂度：O(n)。广度优先搜索的空间复杂度最多为 O(n)。

<!--more-->

```cpp
class Solution {
public:
    int widthOfBinaryTree(TreeNode* root) {
        vector<pair<TreeNode*, unsigned long long>> cur;
        cur.emplace_back(root, 0);
        unsigned long long ans = 0;
        while (cur.size() > 0) {
            vector<pair<TreeNode*, unsigned long long>> nxt;
            for (auto &[node, idx]: cur) {
                if (node->left) {
                    nxt.emplace_back(node->left, idx * 2);
                }
                if (node->right) {
                    nxt.emplace_back(node->right, idx * 2 + 1);
                }
            }
            ans = max(ans, cur.back().second - cur[0].second + 1);
            cur = move(nxt);
        }
        return ans;
    }
};
```

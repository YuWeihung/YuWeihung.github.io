---
title: "103：二叉树的序列化与反序列化"
date: 2025-07-13T12:37:14+08:00
draft: false
slug: "lc-0297"
categories: ["高频面试题"]
tags: ["二叉树", "BFS"]
---

LeetCode 297

https://leetcode.cn/problems/serialize-and-deserialize-binary-tree/description/

难度：困难

本题可以使用前序遍历或者层序遍历，这里使用层序遍历。

在序列化时需要注意空节点也需要保存。在反序列化时，为了分割字符串，使用了 stringstream。

```cpp
getline(ss, token, ',')
```

序列化和反序列化的时空复杂度相同。

时间复杂度：O(n)。

空间复杂度：O(n)。

<!--more-->

```cpp
class Codec {
public:
    // 序列化：将二叉树转换为字符串
    string serialize(TreeNode* root) {
        if (!root)
            return "[]";
        queue<TreeNode*> q;
        q.push(root);
        string res = "[";
        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            if (node) {
                res += to_string(node->val) + ",";
                q.push(node->left);
                q.push(node->right);
            } else {
                res += "null,";
            }
        }
        // 删除最后一个多余的逗号
        res.pop_back();
        res += "]";
        return res;
    }

    // 反序列化：将字符串转换为二叉树
    TreeNode* deserialize(string data) {
        if (data == "[]")
            return nullptr;
        // 分割字符串为标记数组
        vector<string> tokens;
        string str = data.substr(1, data.size() - 2)
        stringstream ss(str);
        string token;
        while (getline(ss, token, ',')) {
            tokens.push_back(token);
        }

        queue<TreeNode*> q;
        // 创建根节点
        TreeNode* root = new TreeNode(stoi(tokens[0]));
        q.push(root);
        int i = 1;
        while (!q.empty()) {
            TreeNode* node = q.front();
            q.pop();
            // 处理左子节点
            if (tokens[i] != "null") {
                TreeNode* left = new TreeNode(stoi(tokens[i]));
                node->left = left;
                q.push(left);
            }
            i++;
            // 处理右子节点
            if (tokens[i] != "null") {
                TreeNode* right = new TreeNode(stoi(tokens[i]));
                node->right = right;
                q.push(right);
            }
            i++;
        }
        return root;
    }
};
```

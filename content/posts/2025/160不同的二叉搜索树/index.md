---
title: "160：不同的二叉搜索树"
date: 2025-07-15T19:02:36+08:00
draft: false
slug: "lc-0096"
categories: ["高频面试题"]
tags: ["数学", "动态规划"]
---

LeetCode 96

https://leetcode.cn/problems/unique-binary-search-trees/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

二叉搜索树的个数为卡特兰数。

\\[
C_0 =1
\\]

\\[
C_{n + 1} = \frac{2(2n + 1)}{n + 2}C_n
\\]

<!--more-->

动态规划：

时间复杂度 : \(O(n^2)\)，其中 n 表示二叉搜索树的节点个数。G(n) 函数一共有 n 个值需要求解，每次求解需要 O(n) 的时间复杂度，因此总时间复杂度为 \(O(n^2)\)。

空间复杂度 : O(n)。我们需要 O(n) 的空间存储 G 数组。

```cpp
class Solution {
public:
    int numTrees(int n) {
        vector<int> G(n + 1, 0);
        G[0] = 1;
        G[1] = 1;

        for (int i = 2; i <= n; ++i) {
            for (int j = 1; j <= i; ++j) {
                G[i] += G[j - 1] * G[i - j];
            }
        }
        return G[n];
    }
};
```

数学：

时间复杂度 : O(n)，其中 n 表示二叉搜索树的节点个数。我们只需要循环遍历一次即可。

空间复杂度 : O(1)。我们只需要常数空间存放若干变量。

```cpp
class Solution {
public:
    int numTrees(int n) {
        long long C = 1;
        for (int i = 0; i < n; ++i) {
            C = C * 2 * (2 * i + 1) / (i + 2);
        }
        return (int)C;
    }
};
```

---
title: "080：最长公共前缀"
date: 2025-07-04T19:23:29+08:00
draft: false
slug: "lc-0014"
categories: ["高频面试题"]
tags: ["字符串"]
---

LeetCode 14

https://leetcode.cn/problems/longest-common-prefix/description/

难度：简单

1. 从左到右遍历 strs 的每一列。
2. 设当前遍历到第 j 列，从上到下遍历这一列的字母。
3. 设当前遍历到第 i 行，即 strs[i][j]。如果 j 等于 strs[i] 的长度，或者 strs[i][j] != strs[0][j]，说明这一列的字母缺失或者不全一样，那么最长公共前缀的长度等于 j，返回 strs[0] 的长为 j 的前缀。
4. 如果没有中途返回，说明所有字符串都有一个等于 strs[0] 的前缀，那么最长公共前缀就是 strs[0]。

时间复杂度：O(nm)，其中 n 为 strs 的长度，m 为 strs 中最短字符串的长度。

空间复杂度：O(1)。返回值不计入。

<!--more-->

```cpp
class Solution {
public:
    string longestCommonPrefix(vector<string>& strs) {
        string& s0 = strs[0];
        for (int j = 0; j < s0.size(); j++) {
            for (string& s : strs) {
                if (j == s.size() || s[j] != s0[j]) {
                    return s0.substr(0, j);
                }
            }
        }
        return s0;
    }
};
```

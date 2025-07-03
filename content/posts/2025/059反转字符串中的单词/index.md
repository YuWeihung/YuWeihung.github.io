---
title: "059：反转字符串中的单词"
date: 2025-07-03T12:48:34+08:00
draft: false
slug: "lc-0151"
categories: ["高频面试题"]
tags: ["字符串"]
---

LeetCode 151

https://leetcode.cn/problems/reverse-words-in-a-string/description/

难度：中等

先翻转整个字符串，再分别翻转每一个单词。

时间复杂度：O(n)，其中 n 为输入字符串的长度。

空间复杂度：O(n)，用来存储字符串分割之后的结果。

<!--more-->

```cpp
class Solution {
public:
    string reverseWords(string s) {
        string str;
        reverse(s.begin(), s.end());
        string path;
        for (char c: s) {
            if (c == ' ' && path.size() > 0) {
                reverse(path.begin(), path.end());
                if (str.size() > 0) {
                    str += " ";
                }
                str += path;
                path = "";
            }
            if (c != ' ') {
                path.push_back(c);
            }
        }
        if (path.size() > 0) {
            reverse(path.begin(), path.end());
            if (str.size() > 0) {
                str += " ";
            }
            str += path;
        }
        return str;
    }
};
```

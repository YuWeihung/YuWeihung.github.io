---
title: "017：有效的括号"
date: 2025-06-29T11:48:17+08:00
draft: false
slug: "lc-0020"
categories: ["高频面试题"]
tags: ["栈"]
---

LeetCode 20
https://leetcode.cn/problems/valid-parentheses/description/

难度：中等

本题是栈的应用。如果是左括号就入栈，如果是右括号，如果栈顶元素与其匹配，则出栈，否则返回 false。最后返回栈是否为空。

时间复杂度：O(n)，其中 n 是 s 的长度。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
    unordered_map<char, char> mp = {{')', '('}, {']', '['}, {'}', '{'}};
public:
    bool isValid(string s) {
        if (s.length() % 2) { // s 长度必须是偶数
            return false;
        }
        stack<char> st;
        for (char c : s) {
            // mp.contains(c) 用来判断 c 是不是 mp 的一个 key
            if (!mp.contains(c)) { // c 是左括号
                st.push(c); // 入栈
            } else { // c 是右括号
                if (st.empty() || st.top() != mp[c]) {
                    return false; // 没有左括号，或者左括号类型不对
                }
                st.pop(); // 出栈
            }
        }
        return st.empty(); // 所有左括号必须匹配完毕
    }
};
```

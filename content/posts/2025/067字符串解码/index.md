---
title: "067：字符串解码"
date: 2025-07-03T22:54:28+08:00
draft: false
slug: "lc-0394"
categories: ["高频面试题"]
tags: ["字符串", "栈"]
---

LeetCode 394

https://leetcode.cn/problems/decode-string/description/

难度：中等

使用双栈法。一个栈存储数字，一个栈存储字符串。当遇到数字时，更新数字，注意数字可能有多位；遇到字母时，加到当前字符串中；遇到 '[' 时，将将当前字符串和数字入栈；遇到 ']' 时，解码，将数字和字符串出栈，将当前字符串重复 k 次加到栈顶字符串后面，将栈顶字符串更新为当前字符串。

时间复杂度：O(S)。

空间复杂度：O(S)。

<!--more-->

```cpp
class Solution {
public:
    string decodeString(string s) {
        stack<int> st_cnt;
        stack<string> st_str;
        string cur = "";
        int k = 0;
        for (char c: s) {
            if (isdigit(c)) {
                // 处理多位数
                k = k * 10 + c - '0';
            } else if (c == '[') {
                // 遇到 '['，将字符串和数字入栈
                st_cnt.push(k);
                st_str.push(cur);
                cur = "";
                k = 0;
            } else if (c == ']') {
                // 遇到 '['，解码
                int cnt = st_cnt.top();
                st_cnt.pop();
                string str = st_str.top();
                st_str.pop();

                // 重复当前字符串
                for (int i = 0; i < cnt; i++) {
                    str += cur;
                }
                // 更新当前字符串
                cur = str;
            } else {
                // 如果是字母，直接加到当前字符串
                cur.push_back(c);
            }
        }
        return cur;
    }
};
```

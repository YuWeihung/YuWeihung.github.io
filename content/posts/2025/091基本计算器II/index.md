---
title: "091：基本计算器 II"
date: 2025-07-06T13:20:07+08:00
draft: false
slug: "lc-0227"
categories: ["高频面试题"]
tags: ["栈"]
---

LeetCode 227

https://leetcode.cn/problems/basic-calculator-ii/description/

难度：中等

本题是包含加减乘除，但没有括号的表达式求值。可以使用一个栈来解决。

使用 op 记录上一个运算符是什么。遍历字符串，如果当前字符是数字，就更新数字，如果是运算符或者已经到了最后一个字符，那么根据上一个运算符来操作。如果是加减，那么直接将当前数字加入栈中。如果是乘除，直接操作栈顶元素。然后将 op 更新为当前字符。

最后只需要将栈中所有元素加起来即可。为了方便遍历，栈使用 vector 实现。

时间复杂度：O(n)，其中 n 为字符串 s 的长度。需要遍历字符串 s 一次，计算表达式的值。

空间复杂度：O(n)，其中 n 为字符串 s 的长度。空间复杂度主要取决于栈的空间，栈的元素个数不超过 n。

<!--more-->

```cpp
class Solution {
public:
    int calculate(string s) {
        vector<int> stk;
        char op = '+';
        int num = 0;
        int n = s.size();
        for (int i = 0; i < n; i++) {
            if (isdigit(s[i])) {
                num = num * 10 + int(s[i] - '0');
            }
            if (!isdigit(s[i]) && s[i] != ' ' || i == n - 1) {
                if (op == '+') {
                    stk.push_back(num);
                } else if (op == '-') {
                    stk.push_back(-num);
                } else if (op == '*') {
                    stk.back() *= num;
                } else {
                    stk.back() /= num;
                }
                op = s[i];
                num = 0;
            }
        }
        int ans = 0;
        for (int x : stk) {
            ans += x;
        }
        return ans;
    }
};
```

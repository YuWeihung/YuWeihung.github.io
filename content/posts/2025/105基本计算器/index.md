---
title: "105：基本计算器"
date: 2025-07-13T12:37:15+08:00
draft: false
slug: "lc-0224"
categories: ["高频面试题"]
tags: ["栈"]
---

LeetCode 224

https://leetcode.cn/problems/basic-calculator/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

由于字符串除了数字与括号外，只有加号和减号两种运算符。因此，如果展开表达式中所有的括号，则得到的新表达式中，数字本身不会发生变化，只是每个数字前面的符号会发生变化。

因此，我们考虑使用一个取值为 {−1,+1} 的整数 sign 代表「当前」的符号。根据括号表达式的性质，它的取值：

- 与字符串中当前位置的运算符有关；
- 如果当前位置处于一系列括号之内，则也与这些括号前面的运算符有关：每当遇到一个以 − 号开头的括号，则意味着此后的符号都要被「翻转」。

考虑到第二点，我们需要维护一个栈 ops，其中栈顶元素记录了当前位置所处的每个括号所「共同形成」的符号。例如，对于字符串 1+2+(3-(4+5))：

- 扫描到 1+2 时，由于当前位置没有被任何括号所包含，则栈顶元素为初始值 +1；
- 扫描到 1+2+(3 时，当前位置被一个括号所包含，该括号前面的符号为 + 号，因此栈顶元素依然 +1；
- 扫描到 1+2+(3-(4 时，当前位置被两个括号所包含，分别对应着 + 号和 − 号，由于 + 号和 − 号合并的结果为 − 号，因此栈顶元素变为 −1。

在得到栈 ops 之后， sign 的取值就能够确定了：如果当前遇到了 + 号，则更新 sign = ops.top()；如果遇到了遇到了 − 号，则更新 sign = −ops.top()。

然后，每当遇到 ( 时，都要将当前的 sign 取值压入栈中；每当遇到 ) 时，都从栈中弹出一个元素。这样，我们能够在扫描字符串的时候，即时地更新 ops 中的元素。

时间复杂度：O(n)，其中 n 为字符串 s 的长度。需要遍历字符串 s 一次，计算表达式的值。

空间复杂度：O(n)，其中 n 为字符串 s 的长度。空间复杂度主要取决于栈的空间，栈中的元素数量不超过 n。

<!--more-->

```cpp
class Solution {
public:
    int calculate(string s) {
        stack<int> ops;
        ops.push(1);
        int sign = 1;

        int ret = 0;
        int n = s.length();
        int i = 0;
        while (i < n) {
            if (s[i] == ' ') {
                i++;
            } else if (s[i] == '+') {
                sign = ops.top();
                i++;
            } else if (s[i] == '-') {
                sign = -ops.top();
                i++;
            } else if (s[i] == '(') {
                ops.push(sign);
                i++;
            } else if (s[i] == ')') {
                ops.pop();
                i++;
            } else {
                int num = 0;
                while (i < n && s[i] >= '0' && s[i] <= '9') {
                    num = num * 10 + (s[i] - '0');
                    i++;
                }
                ret += sign * num;
            }
        }
        return ret;
    }
};
```

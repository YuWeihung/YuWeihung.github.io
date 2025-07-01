---
title: "043用栈实现队列"
date: 2025-07-01T17:06:56+08:00
draft: false
slug: "lc-0232"
categories: ["高频面试题"]
tags: ["栈", "队列"]
---

LeetCode 232

https://leetcode.cn/problems/implement-queue-using-stacks/description/

难度：简单

用两个栈，输入栈和输出栈来模拟队列。push 时将输入压进输入栈。pop 时，如果输出栈为空，将输出栈的元素全部压入输出栈，这时输出栈的顺序就是输入的顺序。返回输出栈栈顶元素。

时间复杂度：push 和 empty 为 O(1)，pop 和 peek 为均摊 O(1)。对于每个元素，至多入栈和出栈各两次，故均摊复杂度为 O(1)。

空间复杂度：O(n)。其中 n 是操作总数。对于有 n 次 push 操作的情况，队列中会有 n 个元素，故空间复杂度为 O(n)。

<!--more-->

```cpp
class MyQueue {
    stack<int> input;
    stack<int> output;

public:
    MyQueue() {}

    void push(int x) { input.push(x); }

    int pop() {
        if (output.empty()) {
            while (!input.empty()) {
                int x = input.top();
                input.pop();
                output.push(x);
            }
        }
        int x = output.top();
        output.pop();
        return x;
    }

    int peek() {
        if (output.empty()) {
            while (!input.empty()) {
                int x = input.top();
                input.pop();
                output.push(x);
            }
        }
        int x = output.top();
        return x;
    }

    bool empty() { return input.empty() && output.empty(); }
};
```

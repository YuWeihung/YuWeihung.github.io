---
title: "161：用队列实现栈"
date: 2025-07-15T19:02:37+08:00
draft: false
slug: "lc-0225"
categories: ["高频面试题"]
tags: ["队列", "栈"]
---

LeetCode 225

https://leetcode.cn/problems/implement-stack-using-queues/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

使用一个队列时，为了满足栈的特性，即最后入栈的元素最先出栈，同样需要满足队列前端的元素是最后入栈的元素。

入栈操作时，首先获得入栈前的元素个数 n，然后将元素入队到队列，再将队列中的前 n 个元素（即除了新入栈的元素之外的全部元素）依次出队并入队到队列，此时队列的前端的元素即为新入栈的元素，且队列的前端和后端分别对应栈顶和栈底。

由于每次入栈操作都确保队列的前端元素为栈顶元素，因此出栈操作和获得栈顶元素操作都可以简单实现。出栈操作只需要移除队列的前端元素并返回即可，获得栈顶元素操作只需要获得队列的前端元素并返回即可（不移除元素）。

由于队列用于存储栈内的元素，判断栈是否为空时，只需要判断队列是否为空即可。

时间复杂度：入栈操作 O(n)，其余操作都是 O(1)，其中 n 是栈内的元素个数。

空间复杂度：O(n)，其中 n 是栈内的元素个数。需要使用一个队列存储栈内的元素。

<!--more-->

```cpp
class MyStack {
public:
    queue<int> q;

    /** Initialize your data structure here. */
    MyStack() {

    }

    /** Push element x onto stack. */
    void push(int x) {
        int n = q.size();
        q.push(x);
        for (int i = 0; i < n; i++) {
            q.push(q.front());
            q.pop();
        }
    }

    /** Removes the element on top of the stack and returns that element. */
    int pop() {
        int r = q.front();
        q.pop();
        return r;
    }

    /** Get the top element. */
    int top() {
        int r = q.front();
        return r;
    }

    /** Returns whether the stack is empty. */
    bool empty() {
        return q.empty();
    }
};
```

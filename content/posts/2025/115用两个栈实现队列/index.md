---
title: "115：用两个栈实现队列"
date: 2025-07-15T19:01:30+08:00
draft: false
slug: "lcr-0125"
categories: ["高频面试题"]
tags: ["栈", "队列"]
---

LCR 125

https://leetcode.cn/problems/yong-liang-ge-zhan-shi-xian-dui-lie-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

将一个栈当作输入栈，用于压入 appendTail 传入的数据；另一个栈当作输出栈，用于 deleteHead 操作。

每次 deleteHead 时，若输出栈为空则将输入栈的全部数据依次弹出并压入输出栈，这样输出栈从栈顶往栈底的顺序就是队列从队首往队尾的顺序。

时间复杂度：appendTail 为 O(1)，deleteHead 为均摊 O(1)。对于每个元素，至多入栈和出栈各两次，故均摊复杂度为 O(1)。

空间复杂度：O(n)。其中 n 是操作总数。对于有 n 次 appendTail 操作的情况，队列中会有 n 个元素，故空间复杂度为 O(n)。

<!--more-->

```cpp
class CQueue {
private:
    stack<int> inStack, outStack;

    void in2out() {
        while (!inStack.empty()) {
            outStack.push(inStack.top());
            inStack.pop();
        }
    }

public:
    CQueue() {}

    void appendTail(int value) {
        inStack.push(value);
    }

    int deleteHead() {
        if (outStack.empty()) {
            if (inStack.empty()) {
                return -1;
            }
            in2out();
        }
        int value = outStack.top();
        outStack.pop();
        return value;
    }
};
```

---
title: "062：最小栈"
date: 2025-07-03T21:48:57+08:00
draft: false
slug: "lc-0155"
categories: ["高频面试题"]
tags: ["栈"]
---

LeetCode 155

https://leetcode.cn/problems/min-stack/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

栈存储一个 pair，当前值和前缀最小值，初始化存储一个哨兵节点。

```cpp
stack<pair<int, int>> st;
```

时间复杂度：所有操作均为 O(1)。

空间复杂度：O(q)。其中 q 是 push 调用的次数。最坏情况下，只有 push 操作，需要 O(q) 的空间保存元素。

<!--more-->

```cpp
class MinStack {
    stack<pair<int, int>> st;
public:
    MinStack() {
        st.emplace(0, INT_MAX);
    }

    void push(int val) {
        st.emplace(val, min(getMin(), val));
    }

    void pop() {
        st.pop();
    }

    int top() {
        return st.top().first;
    }

    int getMin() {
        return st.top().second;
    }
};
```

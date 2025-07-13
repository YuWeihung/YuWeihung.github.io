---
title: "堆排序"
date: 2024-06-13T11:33:45+08:00
draft: false
slug: "heap-sort"
categories: ["算法题"]
tags: ["排序", "堆排序"]
---

本文介绍堆排序的实现方法，题目选择洛谷的 P1177。

本题使用小根堆，先把所有的元素都 push 进去，然后每次取出堆顶输出并弹掉堆顶，直到堆空为止。

堆的实现需要两个修复操作。当把结点插入堆时，首先将结点放到尾部，这时可能不满足小根堆的性质，因此需要自底向上修复堆。修复的边界条件是 x 已经是根结点或者 x 大于他的父结点。

当删除堆顶元素时，将堆顶元素和尾部元素交换，删除尾部元素，这时也可能不满足小根堆的性质，因此需要自顶向下修复堆。修复的边界条件是 x 已经是叶子结点或者 x 小于他的儿子中的最小值。

堆排序整体的时间复杂度为 O(nlogn)，空间复杂度为 O(n)。

<!--more-->

```cpp
#include <algorithm>
#include <iostream>
#include <vector>

using namespace std;

vector<int> w;
int tot = 0; // 目前堆中有多少个结点

// 返回最小值
int top() {
    return w[0];
}

// 插入时，修复 x 号结点
void modify(int x) {
    // x 为根，或已符合小根堆的性质
    if (x == 0 || w[x] > w[(x - 1) / 2]) {
        return;
    }
    swap(w[x], w[(x - 1) / 2]);
    modify((x - 1) / 2);
}

// 加入元素
void push(int x) {
    tot++;
    w[tot - 1] = x;
    // 自底向上修复
    modify(tot - 1);
}

// 删除时，修复 x 号结点
void repair(int x) {
    // x 已经是叶子结点
    if (x * 2 + 1 >= tot) {
        return;
    }
    int tar = x * 2 + 1;
    if (x * 2 + 2 < tot) {
        tar = w[x * 2 + 1] < w[x * 2 + 2] ? x * 2 + 1 : x * 2 + 2;
    }
    // tar 是 x 子结点中 key 最小的，违反小根堆的性质
    if (w[x] > w[tar]) {
        swap(w[x], w[tar]);
        repair(tar);
    }
}

// 删除堆顶
void pop() {
    // 与尾部结点交换，然后删掉尾部
    swap(w[0], w[tot - 1]);
    tot--;
    // 自顶向下修复
    repair(0);
}

int main() {
    ios::sync_with_stdio(false);
    int n;
    cin >> n;
    w.resize(n);
    for (int i = 0; i < n; i++) {
        int x;
        cin >> x;
        push(x);
    }
    for (int i = 0; i < n; i++) {
        int x = top();
        cout << x << " ";
        pop();
    }
    cout << '\n';
}
```

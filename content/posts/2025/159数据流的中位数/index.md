---
title: "159：数据流的中位数"
date: 2025-07-15T19:02:34+08:00
draft: false
slug: "lc-0295"
categories: ["高频面试题"]
tags: ["堆"]
---

LeetCode 295

https://leetcode.cn/problems/find-median-from-data-stream/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

需要两个堆。left 是最大堆，right 是最小堆。

保证 left 的大小和 right 的大小尽量相等。规定：在有奇数个数时，left 比 right 多 1 个数。

保证 left 的所有元素都小于等于 right 的所有元素。

如果当前有奇数个元素，中位数是 left 的堆顶。

如果当前有偶数个元素，中位数是 left 的堆顶和 right 的堆顶的平均值。

如果当前 left 的大小和 right 的大小相等：

- 如果添加的数字 num 比较大，比如添加 7，那么把 7 加到 right 中。现在 left 比 right 少 1 个数，不符合前文的规定，所以必须把 right 的最小值从 right 中去掉，添加到 left 中。如此操作后，可以保证 left 的所有元素都小于等于 right 的所有元素。
- 如果添加的数字 num 比较小，比如添加 0，那么把 0 加到 left 中。
- 这两种情况可以合并：无论 num 是大是小，都可以先把 num 加到 right 中，然后把 right 的最小值从 right 中去掉，并添加到 left 中。

如果当前 left 比 right 多 1 个数：

- 如果添加的数字 num 比较大，比如添加 7，那么把 7 加到 right 中。
- 如果添加的数字 num 比较小，比如添加 0，那么把 0 加到 left 中。现在 left 比 right 多 2 个数，不符合前文的规定，所以必须把 left 的最大值从 left 中去掉，添加到 right 中。如此操作后，可以保证 left 的所有元素都小于等于 right 的所有元素。
- 这两种情况可以合并：无论 num 是大是小，都可以先把 num 加到 left 中，然后把 left 的最大值从 left 中去掉，并添加到 right 中。

时间复杂度：初始化和 findMedian 都是 O(1)，addNum 是 O(logq)，其中 q 是 addNum 的调用次数。每次操作堆需要 O(logq) 的时间。

空间复杂度：O(q)。

<!--more-->

```cpp
class MedianFinder {
    priority_queue<int> left; // 最大堆
    priority_queue<int, vector<int>, greater<>> right; // 最小堆

public:
    void addNum(int num) {
        if (left.size() == right.size()) {
            right.push(num);
            left.push(right.top());
            right.pop();
        } else {
            left.push(num);
            right.push(left.top());
            left.pop();
        }
    }

    double findMedian() {
        if (left.size() > right.size()) {
            return left.top();
        }
        return (left.top() + right.top()) / 2.0;
    }
};
```

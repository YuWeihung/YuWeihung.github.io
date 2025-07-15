---
title: "029：相交链表"
date: 2025-06-29T21:30:00+08:00
draft: false
slug: "lc-0160"
categories: ["高频面试题"]
tags: ["链表", "双指针"]
---

LeetCode 160

https://leetcode.cn/problems/intersection-of-two-linked-lists/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

最简单的方法是使用哈希集合来记录访问过的节点。除此之外还有双指针的做法。

> 我来到你的城市，走过你来时的路。

- 初始化两个指针 p = headA, q = headB。
- 不断循环，直到 p == q。
- 每次循环，p 和 q 各向后走一步。具体来说，如果 p 不是空节点，那么更新 p 为 p->next，否则更新 p 为 headB；如果 q 不是空节点，那么更新 q 为 q->next，否则更新 q 为 headA。
- 循环结束时，如果两条链表相交，那么此时 p 和 q 都在相交的起始节点处，返回 p；如果两条链表不相交，那么 p 和 q 都走到空节点，所以也可以返回 p，即空节点。

时间复杂度：O(m+n)，其中 m 是第一条链表的长度，n 是第二条链表的长度。除了交点，每个节点会被指针 p 访问至多一次，每个节点会被指针 q 访问至多一次。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    ListNode* getIntersectionNode(ListNode* headA, ListNode* headB) {
        ListNode* p = headA;
        ListNode* q = headB;
        while (p != q) {
            p = p ? p->next : headB;
            q = q ? q->next : headA;
        }
        return p;
    }
};
```

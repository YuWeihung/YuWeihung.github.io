---
title: "035：删除链表的倒数第 N 个结点"
date: 2025-06-30T21:44:08+08:00
draft: false
slug: "lc-0019"
categories: ["高频面试题"]
tags: ["链表"]
---

LeetCode 19

https://leetcode.cn/problems/remove-nth-node-from-end-of-list/description/

难度：中等

前后指针，右节点先走 n 步，然后左右节点同时走。当右节点走到最后一个节点的时候，左节点就在删除节点的前一个节点。为了处理删除第一个节点的情况，设置 dummy 节点。

时间复杂度：O(m)，其中 m 为链表的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    ListNode* removeNthFromEnd(ListNode* head, int n) {
        ListNode* dummy = new ListNode();
        dummy->next = head;
        ListNode* p0 = dummy;
        ListNode* p1 = dummy;
        for (int i = 0; i < n; i++) {
            p1 = p1->next;
        }
        while (p1->next) {
            p0 = p0->next;
            p1 = p1->next;
        }
        ListNode* p2 = p0->next;
        p0->next = p0->next->next;
        delete(p2);
        return dummy->next;
    }
};
```

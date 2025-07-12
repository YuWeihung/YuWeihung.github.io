---
title: "098：两两交换链表中的节点"
date: 2025-07-06T13:21:45+08:00
draft: false
slug: "lc-0024"
categories: ["高频面试题"]
tags: ["链表"]
---

LeetCode 24

https://leetcode.cn/problems/swap-nodes-in-pairs/description/

难度：中等

K 个一组反转链表的简单版本。

时间复杂度：O(n)，其中 n 为链表长度。

空间复杂度：O(1)。仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    ListNode* swapPairs(ListNode* head) {
        ListNode* dummy = new ListNode(0, head);
        ListNode* p0 = dummy;
        ListNode* pre = nullptr;
        ListNode* cur = p0->next;
        while (cur && cur->next) {
            for (int i = 0; i < 2; i++) {
                ListNode* nxt = cur->next;
                cur->next = pre;
                pre = cur;
                cur = nxt;
            }
            ListNode* nxt = p0->next;
            p0->next->next = cur;
            p0->next = pre;
            p0 = nxt;
        }
        return dummy->next;
    }
};
```

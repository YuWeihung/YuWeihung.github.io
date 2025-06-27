---
title: "003：反转链表"
date: 2025-06-25T17:28:54+08:00
draft: false
slug: "lc-0206"
categories: ["高频面试题"]
tags: ["链表", "递归"]
---

LeetCode 206

https://leetcode.cn/problems/reverse-linked-list/description/

难度：Easy

本题有迭代和递归两种解法，迭代法更易理解，且空间复杂度更优。

<!--more-->

迭代：

时间复杂度：O(n)

空间复杂度：O(1)

```cpp
class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        ListNode* pre = nullptr;
        ListNode* cur = head;
        while (cur) {
            ListNode* nxt = cur->next;
            cur->next = pre;
            pre = cur;
            cur = nxt;
        }
        return pre;
    }
};
```

递归：

从倒数第二个节点开始向前，每次将下一个节点的 next 指向自己，自己的 next 指向空。

时间复杂度：O(n)

空间复杂度：O(n)

```cpp
class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        if (!head || !head->next) {
            return head;
        }
        ListNode* newHead = reverseList(head->next);
        head->next->next = head;
        head->next = nullptr;
        return newHead;
    }
};
```

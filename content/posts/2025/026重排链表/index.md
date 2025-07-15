---
title: "026：重排链表"
date: 2025-06-29T20:51:41+08:00
draft: false
slug: "lc-0143"
categories: ["高频面试题"]
tags: ["链表"]
---

LeetCode 143

https://leetcode.cn/problems/reorder-list/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这道题目需要先找到链表的中间节点 LeetCode 876，然后反转后半部分的链表 LeetCode 206。

head 指向前半部分头节点，head2 指向后半部分的头节点。每次更新 head->next = head2, head2->next = nxt。

时间复杂度：O(n)，其中 n 为链表的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    ListNode* middleNode(ListNode* head) {
        ListNode* slow = head, *fast = head;
        while (fast && fast->next) {
            slow = slow->next;
            fast = fast->next->next;
        }
        return slow;
    }

    ListNode* reverseList(ListNode* head) {
        ListNode* pre = nullptr, *cur = head;
        while (cur) {
            ListNode* nxt = cur->next;
            cur->next = pre;
            pre = cur;
            cur = nxt;
        }
        return pre;
    }

    void reorderList(ListNode* head) {
        ListNode* mid = middleNode(head);
        ListNode* head2 = reverseList(mid);
        while(head2->next) {
            ListNode* nxt = head->next;
            ListNode* nxt2 = head2->next;
            head->next = head2;
            head2->next = nxt;
            head = nxt;
            head2= nxt2;
        }
    }
};
```

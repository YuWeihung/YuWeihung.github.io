---
title: "079：回文链表"
date: 2025-07-04T19:23:17+08:00
draft: false
slug: "lc-0234"
categories: ["高频面试题"]
tags: ["链表"]
---

LeetCode 234

https://leetcode.cn/problems/palindrome-linked-list/description/

难度：简单

本题需要用到两个知识点，寻找链表的中间节点和反转链表。

首先找到链表的中间节点，然后反转链表的后半段。最后，同时遍历这两段链表，判断值是否相等。

时间复杂度：O(n)，其中 n 是链表的长度（节点个数）。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
    // 876. 链表的中间结点
    ListNode* middleNode(ListNode* head) {
        ListNode* slow = head, *fast = head;
        while (fast && fast->next) {
            slow = slow->next;
            fast = fast->next->next;
        }
        return slow;
    }

    // 206. 反转链表
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

public:
    bool isPalindrome(ListNode* head) {
        ListNode* mid = middleNode(head);
        ListNode* head2 = reverseList(mid);
        while (head2) {
            if (head->val != head2->val) { // 不是回文链表
                return false;
            }
            head = head->next;
            head2 = head2->next;
        }
        return true;
    }
};
```

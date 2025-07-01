---
title: "045：排序链表"
date: 2025-07-01T19:56:25+08:00
draft: false
slug: "lc-0148"
categories: ["高频面试题"]
tags: ["链表", "归并排序"]
---

LeetCode 148

https://leetcode.cn/problems/sort-list/description/

难度：中等

本题使用归并排序。

1. 找到链表的中间结点 head 2 的前一个节点，并断开 head2 与其前一个节点的连接。这样我们就把原链表均分成了两段更短的链表。
2. 分治，递归调用 sortList，分别排序 head（只有前一半）和 head2。
3. 排序后，我们得到了两个有序链表，那么合并两个有序链表，得到排序后的链表，返回链表头节点。

时间复杂度：O(nlogn)，其中 n 是链表长度。递归式 T(n)=2T(n/2)+O(n)，由主定理可得时间复杂度为 O(nlogn)。

空间复杂度：O(logn)。递归需要 O(logn) 的栈开销。

<!--more-->

```cpp
class Solution {
public:
    ListNode* middleNode(ListNode* head) {
        ListNode *slow = head, *fast = head;
        ListNode* pre = head;
        while (fast && fast->next) {
            pre = slow;
            fast = fast->next->next;
            slow = slow->next;
        }
        pre->next = nullptr;
        return slow;
    }

    ListNode* mergetTwoLists(ListNode* list1, ListNode* list2) {
        ListNode* dummy = new ListNode();
        ListNode* cur = dummy;
        while (list1 && list2) {
            if (list1->val < list2->val) {
                cur->next = list1;
                list1 = list1->next;
            } else {
                cur->next = list2;
                list2 = list2->next;
            }
            cur = cur->next;
        }
        cur->next = list1 ? list1 : list2;
        return dummy->next;
    }

    ListNode* sortList(ListNode* head) {
        if (head == nullptr || head->next == nullptr) {
            return head;
        }
        ListNode* head2 = middleNode(head);
        head = sortList(head);
        head2 = sortList(head2);
        return mergetTwoLists(head, head2);
    }
};
```

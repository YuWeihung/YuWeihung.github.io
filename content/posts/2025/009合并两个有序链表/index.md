---
title: "009：合并两个有序链表"
date: 2025-06-27T13:45:04+08:00
draft: false
slug: "lc-0021"
categories: ["高频面试题"]
tags: ["链表"]
---

LeetCode 21

https://leetcode.cn/problems/merge-two-sorted-lists/description/

难度：简单

每次将 list1 和 list2 中较小值作为下一个节点，最后将剩余节点接在后面。

时间复杂度：O(n+m)，其中 n 为 list 1 的长度，m 为 list 2 的长度。

空间复杂度：O(1)。仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {
        ListNode dummy{}; // 用哨兵节点简化代码逻辑
        auto cur = &dummy; // cur 指向新链表的末尾
        while (list1 && list2) {
            if (list1->val < list2->val) {
                cur->next = list1; // 把 list1 加到新链表中
                list1 = list1->next;
            } else { // 注：相等的情况加哪个节点都是可以的
                cur->next = list2; // 把 list2 加到新链表中
                list2 = list2->next;
            }
            cur = cur->next;
        }
        cur->next = list1 ? list1 : list2; // 拼接剩余链表
        return dummy.next;
    }
};
```

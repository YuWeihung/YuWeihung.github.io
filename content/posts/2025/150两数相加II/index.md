---
title: "150：两数相加II"
date: 2025-07-15T19:02:19+08:00
draft: false
slug: "lc-0445"
categories: ["高频面试题"]
tags: ["链表"]
---

LeetCode 445

https://leetcode.cn/problems/add-two-numbers-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

反转链表+两数相加。

时间复杂度：O(n)，其中 n 为 l1 长度和 l2 长度的最大值。

空间复杂度：O(1)。返回值不计入。

<!--more-->

```cpp
class Solution {
    // 视频讲解 https://www.bilibili.com/video/BV1sd4y1x7KN/
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

    ListNode* addTwo(ListNode* l1, ListNode* l2) {
        ListNode dummy; // 哨兵节点
        auto cur = &dummy;
        int carry = 0; // 进位
        while (l1 || l2 || carry) { // 有一个不是空节点，或者还有进位，就继续迭代
            if (l1) carry += l1->val; // 节点值和进位加在一起
            if (l2) carry += l2->val; // 节点值和进位加在一起
            cur = cur->next = new ListNode(carry % 10); // 每个节点保存一个数位
            carry /= 10; // 新的进位
            if (l1) l1 = l1->next; // 下一个节点
            if (l2) l2 = l2->next; // 下一个节点
        }
        return dummy.next; // 哨兵节点的下一个节点就是头节点
    }

public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        l1 = reverseList(l1);
        l2 = reverseList(l2);
        auto l3 = addTwo(l1, l2);
        return reverseList(l3);
    }
};
```

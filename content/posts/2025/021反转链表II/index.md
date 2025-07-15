---
title: "021：反转链表 II"
date: 2025-06-29T19:04:32+08:00
draft: false
slug: "lc-0092"
categories: ["高频面试题"]
tags: ["链表"]
---

LeetCode 92

https://leetcode.cn/problems/reverse-linked-list-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这道题需要翻转中间一段链表。我们定义这段链表的前一个节点为 p0。翻转结束之后，需要修改 p0->next->next = cur, p0->next = pre。

时间复杂度：O(right)。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    ListNode* reverseBetween(ListNode* head, int left, int right) {
        ListNode* dummy = new ListNode();
        dummy->next = head;
        ListNode* p0 = dummy;
        for (int i = 0; i < left - 1; i++) {
            p0 = p0->next;
        }
        ListNode* cur = p0->next;
        ListNode* pre = nullptr;
        for (int i = 0; i < right - left + 1; i++) {
            ListNode* nxt = cur->next;
            cur->next = pre;
            pre = cur;
            cur = nxt;
        }
        p0->next->next = cur;
        p0->next = pre;
        return dummy->next;
    }
};
```

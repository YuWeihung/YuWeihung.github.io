---
title: "196：链表求和"
date: 2025-07-15T19:04:10+08:00
draft: false
slug: "lc-面试题0205"
categories: ["高频面试题"]
tags: ["链表", "模拟"]
---

LeetCode 面试题 02.05

https://leetcode.cn/problems/sum-lists-lcci/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

两数之和。

时间复杂度：O(max(m,n))，其中 m 和 n 分别为两个链表的长度。我们需要遍历两个链表的全部位置，而处理每个位置只需要 O(1) 的时间。

空间复杂度：O(1)。注意返回值不计入空间复杂度。

<!--more-->

```cpp
class Solution {
public:
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        ListNode* dummy = new ListNode();
        ListNode* pre = dummy;
        int carry = 0;
        while (l1 || l2 || carry) {
            int v1 = l1 ? l1->val : 0;
            int v2 = l2 ? l2->val : 0;
            int t = v1 + v2 + carry;
            ListNode* cur = new ListNode(t % 10);
            carry = t / 10;
            pre->next = cur;
            pre = cur;
            if (l1) {
                l1 = l1->next;
            }
            if (l2) {
                l2 = l2->next;
            }
        }
        return dummy->next;
    }
};
```

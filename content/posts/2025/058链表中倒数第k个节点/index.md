---
title: "058：链表中倒数第k个节点"
date: 2025-07-03T12:44:11+08:00
draft: false
slug: "lcr-0140"
categories: ["高频面试题"]
tags: ["链表", "双指针"]
---

LCR 140

https://leetcode.cn/problems/lian-biao-zhong-dao-shu-di-kge-jie-dian-lcof/description/

难度：简单

前后指针找链表倒数第 k 个节点。

时间复杂度：O(n)，其中 n 为链表的长度。我们使用快慢指针，只需要一次遍历即可，复杂度为 O(n)。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    ListNode* trainingPlan(ListNode* head, int cnt) {
        ListNode* slow = head, *fast = head;
        for (int i = 0; i < cnt; i++) {
            fast = fast->next;
        }
        while (fast) {
            fast = fast->next;
            slow = slow->next;
        }
        return slow;
    }
};
```

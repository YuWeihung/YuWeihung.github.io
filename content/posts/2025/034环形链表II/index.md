---
title: "034：环形链表 II"
date: 2025-06-30T21:37:13+08:00
draft: false
slug: "lc-0142"
categories: ["高频面试题"]
tags: ["链表", "双指针"]
---

LeetCode 142

https://leetcode.cn/problems/linked-list-cycle-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

环形链表 II，比环形链表 I 多了需要找到入环节点。

设头节点到入环口需要走 a 步，环长为 c。快慢指针相遇时，慢指针走了 b 步，快指针走了 2b 步。设快指针比慢指针多走了 k 圈，即 2b - b = kc，得 b = kc。

慢指针在入环口开始，在环中走了 b - a = kc - a 步到达相遇点。这说明从相遇点开始，再走 a 步，就恰好到达相遇点。

如果让头节点和慢指针同时走，恰好 a 步后二者必定相遇，且相遇点就在入环口。

时间复杂度：O(n)，其中 n 为链表的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    ListNode* detectCycle(ListNode* head) {
        ListNode* slow = head;
        ListNode* fast = head;
        while (fast && fast->next) {
            slow = slow->next;
            fast = fast->next->next;
            if (fast == slow) { // 相遇
                while (slow != head) { // 再走 a 步
                    slow = slow->next;
                    head = head->next;
                }
                return slow;
            }
        }
        return nullptr;
    }
};
```

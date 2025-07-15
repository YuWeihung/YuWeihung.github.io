---
title: "022：环形链表"
date: 2025-06-29T19:14:12+08:00
draft: false
slug: "lc-0141"
categories: ["高频面试题"]
tags: ["链表", "双指针"]
---

LeetCode 141

https://leetcode.cn/problems/linked-list-cycle/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这道题目的做法是快慢指针。快指针每次走两步，慢指针每次走一步，如果快慢指针相等，说明链表有环。

时间复杂度：O(n)，其中 n 为链表的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    bool hasCycle(ListNode *head) {
        ListNode* dummy = new ListNode();
        dummy->next = head;
        ListNode* slow = dummy, *fast = dummy;
        while (fast && fast->next) {
            slow = slow->next;
            fast = fast->next->next;
            if (slow == fast) {
                return true;
            }
        }
        return false;
    }
};
```

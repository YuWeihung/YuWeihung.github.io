---
title: "116：旋转链表"
date: 2025-07-15T19:01:32+08:00
draft: false
slug: "lc-0061"
categories: ["高频面试题"]
tags: ["链表"]
---

LeetCode 61

https://leetcode.cn/problems/rotate-list/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题是旋转链表，可以直接将链表闭合成环，再在指定位置断开。

时间复杂度：O(n)，最坏情况下，我们需要遍历该链表两次。

空间复杂度：O(1)，我们只需要常数的空间存储若干变量。

<!--more-->

```cpp
class Solution {
public:
    ListNode* rotateRight(ListNode* head, int k) {
        if (k == 0 || head == nullptr || head->next == nullptr) {
            return head;
        }
        int n = 1;
        ListNode* cur = head;
        while (cur->next) {
            cur = cur->next;
            n++;
        }
        int add = n - k % n;
        if (add == n) {
            return head;
        }
        // 闭合成环
        cur->next = head;
        while (add) {
            add--;
            cur = cur->next;
        }
        ListNode* head2 = cur->next;
        cur->next = nullptr;
        return head2;
    }
};
```

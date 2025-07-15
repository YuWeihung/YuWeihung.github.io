---
title: "049：两数相加"
date: 2025-07-01T20:42:55+08:00
draft: false
slug: "lc-0002"
categories: ["高频面试题"]
tags: ["链表", "递归"]
---

LeetCode 2

https://leetcode.cn/problems/add-two-numbers/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

递归处理两个链表相加。

时间复杂度：O(n)，其中 n 为 l1 长度和 l2 长度的最大值。

空间复杂度：O(n)。递归需要 O(n) 的栈空间。

<!--more-->

```cpp
class Solution {
public:
    // l1 和 l2 为当前遍历的节点，carry 为进位
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2, int carry = 0) {
        if (l1 == nullptr && l2 == nullptr && carry == 0) { // 递归边界
            return nullptr;
        }

        int s = carry;
        if (l1) {
            s += l1->val; // 累加进位与节点值
            l1 = l1->next;
        }
        if (l2) {
            s += l2->val;
            l2 = l2->next;
        }

        // s 除以 10 的余数为当前节点值，商为进位
        return new ListNode(s % 10, addTwoNumbers(l1, l2, s / 10));
    }
};
```

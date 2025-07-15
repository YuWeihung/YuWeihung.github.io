---
title: "037：删除排序链表中的重复元素 II"
date: 2025-06-30T21:55:32+08:00
draft: false
slug: "lc-0082"
categories: ["高频面试题"]
tags: ["链表"]
---

LeetCode 82

https://leetcode.cn/problems/remove-duplicates-from-sorted-list-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题需要删除链表中所有重复数字的节点，只留下不同的数字。为了删除节点，cur 需要在要被删除的节点前面，因此比较 cur->next 和 cur->next->next 的节点值是否相同，如果相同，通过循环将所有等于这个值的节点都删除。否则，更新 cur 到下一个节点。

时间复杂度：O(n)，其中 n 为链表的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    ListNode* deleteDuplicates(ListNode* head) {
        ListNode* dummy = new ListNode(0, head);
        ListNode* cur = dummy;
        while (cur->next && cur->next->next) {
            int val = cur->next->val;
            if (cur->next->next->val == val) {
                while (cur->next && cur->next->val == val) {
                    cur->next = cur->next->next;
                }
            } else {
                cur = cur->next;
            }
        }
        return dummy->next;
    }
};
```

---
title: "025：合并K个升序链表"
date: 2025-06-29T20:11:17+08:00
draft: false
slug: "lc-0023"
categories: ["高频面试题"]
tags: ["堆"]
---

LeetCode 23

https://leetcode.cn/problems/merge-k-sorted-lists/description/

难度：困难

本题是最小堆的题目。首先将 k 个链表的头节点加入堆，每次在链表中插入堆顶元素，再把堆顶元素的下一个元素入堆。

需要注意的是最小堆的声明方式。a > b（greater）是最小堆，a < b（less） 是最大堆。STL 的优先队列默认是最大堆。

```cpp
auto cmp = [](const ListNode* a, const ListNode* b) {
    return a->val > b->val;
};
priority_queue<ListNode*, vector<ListNode*>, decltype(cmp)> pq;
```

时间复杂度：O(Llogm)，其中 m 为 lists 的长度，L 为所有链表的长度之和。

空间复杂度：O(m)。堆中至多有 m 个元素。

<!--more-->

```cpp
class Solution {
public:
    ListNode* mergeKLists(vector<ListNode*>& lists) {
        int n = lists.size();
        ListNode* dummy = new ListNode();
        ListNode* cur = dummy;

        auto cmp = [](const ListNode* p, const ListNode* q) {
            return p->val > q->val;
        };
        priority_queue<ListNode*, vector<ListNode*>, decltype(cmp)> pq;

        for (auto head : lists) {
            if (head) {
                pq.push(head);
            }
        }

        while (pq.size() > 0) {
            ListNode* node = pq.top();
            pq.pop();
            cur->next = node;
            cur = cur->next;
            if (node->next) {
                pq.push(node->next);
            }
        }
        return dummy->next;
    }
};
```

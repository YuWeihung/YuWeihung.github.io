---
title: "096：删除排序链表中的重复元素"
date: 2025-07-06T13:21:35+08:00
draft: false
slug: "lc-0083"
categories: ["高频面试题"]
tags: ["链表"]
---

LeetCode 83

https://leetcode.cn/problems/remove-duplicates-from-sorted-list/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

判断下个节点，与当前节点相同就删除。

时间复杂度：O(n)，其中 n 为链表的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    ListNode* deleteDuplicates(ListNode* head) {
        if (head == nullptr) {
            return nullptr;
        }
        ListNode* cur = head;
        while (cur->next) { // 看看下个节点……
            if (cur->next->val == cur->val) { // 和我一样，删！
                cur->next = cur->next->next;
            } else { // 和我不一样，移动到下个节点
                cur = cur->next;
            }
        }
        return head;
    }
};
```

---
title: "005：K个一组翻转链表"
date: 2025-06-25T18:20:36+08:00
draft: false
slug: "lc-0025"
categories: ["高频面试题"]
tags: ["链表", ""]
---

LeetCode 25

https://leetcode.cn/problems/reverse-nodes-in-k-group/description/

难度：困难

反转一组节点的代码与 LeetCode 206 类似，每次修改一个节点的 next。

```cpp
ListNode* nxt = cur->next;
cur->next = pre;
pre = cur;
cur = nxt;
```

需要注意的是，每次需要保存一组节点的上一个节点 p0，反转结束后，更新 p0 和 p0->next。

```cpp
ListNode* nxt = p0->next;
p0->next->next = cur;
p0->next = pre;
p0 = nxt;
```

时间复杂度：O(n)，其中 n 为链表节点个数。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

完整代码如下：

```cpp
class Solution {
public:
    ListNode* reverseKGroup(ListNode* head, int k) {
        // 统计节点个数
        int n = 0;
        for (ListNode* cur = head; cur; cur = cur->next) {
            n++;
        }

        ListNode dummy(0, head);
        ListNode* p0 = &dummy;
        ListNode* pre = nullptr;
        ListNode* cur = head;

        // k 个一组处理
        for (; n >= k; n -= k) {
            for (int i = 0; i < k; i++) { // 同 92 题
                ListNode* nxt = cur->next;
                cur->next = pre; // 每次循环只修改一个 next，方便大家理解
                pre = cur;
                cur = nxt;
            }

            // 见视频
            ListNode* nxt = p0->next;
            p0->next->next = cur;
            p0->next = pre;
            p0 = nxt;
        }
        return dummy.next;
    }
};
```

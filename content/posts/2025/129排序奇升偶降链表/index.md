---
title: "129：排序奇升偶降链表"
date: 2025-07-15T19:01:47+08:00
draft: false
slug: "addtion-01"
categories: ["高频面试题"]
tags: ["链表", "排序"]
---

补充题 1

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

给定一个奇数位升序，偶数位降序的链表，将其重新排序。

1.  将链表拆分成两个链表：奇数节点链表和偶数节点链表。

奇数节点链表：位置 1,3,5,...的节点，原链表奇数位置升序，所以奇数节点链表是升序的。

偶数节点链表：位置 2,4,6,...的节点，原链表偶数位置降序，所以偶数节点链表是降序的。

2.  将偶数节点链表反转，因为降序反转后变成升序。

3.  合并两个升序链表（奇数链表和反转后的偶数链表），合并成新的升序链表。

时间复杂度：O(n)。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    ListNode *reorderList(ListNode *head) {
        if (!head || !head->next)
            return head;

        // 步骤1：拆分链表为奇数链和偶数链
        ListNode oddDummy(-1);
        ListNode evenDummy(-1);
        ListNode *oddCurr = &oddDummy;
        ListNode *evenCurr = &evenDummy;
        ListNode *curr = head;

        while (curr) {
            // 奇数节点
            oddCurr->next = curr;
            oddCurr = oddCurr->next;
            curr = curr->next;

            // 偶数节点
            if (curr) {
                evenCurr->next = curr;
                evenCurr = evenCurr->next;
                curr = curr->next;
            }
        }

        // 断尾处理
        oddCurr->next = nullptr;
        evenCurr->next = nullptr;

        // 步骤2：反转偶数链表（降序变升序）
        ListNode *evenHead = reverse(evenDummy.next);

        // 步骤3：合并两个升序链表（奇数链和反转后的偶数链）
        ListNode mergeDummy(-1);
        ListNode *m = &mergeDummy;
        ListNode *p1 = oddDummy.next;
        ListNode *p2 = evenHead;

        while (p1 && p2) {
            if (p1->val <= p2->val) {
                m->next = p1;
                p1 = p1->next;
            } else {
                m->next = p2;
                p2 = p2->next;
            }
            m = m->next;
        }

        // 处理剩余节点
        m->next = p1 ? p1 : p2;

        return mergeDummy.next;
    }

private:
    ListNode *reverse(ListNode *head) {
        ListNode *prev = nullptr;
        ListNode *curr = head;
        while (curr) {
            ListNode *next = curr->next;
            curr->next = prev;
            prev = curr;
            curr = next;
        }
        return prev;
    }
};
```

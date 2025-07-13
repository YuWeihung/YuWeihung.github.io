---
title: "104：复制带随机指针的链表"
date: 2025-07-13T12:37:15+08:00
draft: false
slug: "lc-0138"
categories: ["高频面试题"]
tags: ["链表", "哈希表"]
---

LeetCode 138

https://leetcode.cn/problems/copy-list-with-random-pointer/description/

难度：中等

简单的做法是直接用一个哈希表把两个链表中节点的对应关系存起来，在二次遍历的时候设置新链表的 next 和 random。

此外，我们可以把新链表和旧链表混在一起。依次复制每个节点（创建新节点并复制 val 和 next），把新节点直接插到原节点的后面，形成一个交错链表。如此一来，原链表节点的下一个节点，就是其对应的新链表节点了！

然后遍历这个交错链表，假如节点 1 的 random 指向节点 3，那么就把节点 1′ 的 random 指向节点 3 的下一个节点 3′，这样就完成了对 random 指针的复制。

最后，从交错链表链表中分离出深拷贝后的链表。

时间复杂度：O(n)，其中 n 是链表的长度。

空间复杂度：O(1)。返回值不计入。

<!--more-->

哈希表：

时间复杂度：O(n)。

空间复杂度：O(n)。

```cpp
class Solution {
public:
    Node* copyRandomList(Node* head) {
        unordered_map<Node*, Node*> mp;
        Node* cur = head;
        while (cur) {
            Node* p = new Node(cur->val);
            mp[cur] = p;
            cur = cur->next;
        }
        cur = head;
        while (cur) {
            mp[cur]->next = mp[cur->next];
            mp[cur]->random = mp[cur->random];
            cur = cur->next;
        }
        return mp[head];
    }
};
```

交错链表：

```cpp
class Solution {
public:
    Node* copyRandomList(Node* head) {
        if (head == nullptr) {
            return nullptr;
        }

        // 复制每个节点，把新节点直接插到原节点的后面
        for (Node* cur = head; cur; cur = cur->next->next) {
            cur->next = new Node(cur->val, cur->next, nullptr);
        }

        // 遍历交错链表中的原链表节点
        for (Node* cur = head; cur; cur = cur->next->next) {
            if (cur->random) {
                // 要复制的 random 是 cur->random 的下一个节点
                cur->next->random = cur->random->next;
            }
        }

        // 把交错链表分离成两个链表
        Node* new_head = head->next;
        Node* cur = head;
        for (; cur->next->next; cur = cur->next) {
            Node* copy = cur->next;
            cur->next = copy->next; // 恢复原节点的 next
            copy->next = copy->next->next; // 设置新节点的 next
        }
        cur->next = nullptr; // 恢复原节点的 next
        return new_head;
    }
};
```

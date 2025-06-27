---
title: "002：LRU缓存"
date: 2025-06-25T16:57:08+08:00
draft: false
slug: "lc-0146"
categories: ["高频面试题"]
tags: ["链表", "哈希表"]
---

LeetCode 146

https://leetcode.cn/problems/lru-cache/description/

难度：Mid

本题是双向链表和哈希表的经典题目。每个节点有 key，value，还有两个指针 prev 和 next 分别指向前一个和下一个节点。

此外，链表中还包含一个 dummy 节点，让每个节点的 prev 和 next 都不为空。

时间复杂度：所有操作均为 O(1)。

空间复杂度：O(min(p,capacity))，其中 p 为 put 的调用次数。

<!--more-->

```cpp
class Node {
public:
    int key;
    int value;
    Node* prev;
    Node* next;

    Node(int k = 0, int v = 0) : key(k), value(v) {}
};

class LRUCache {
private:
    int capacity;
    Node* dummy; // 哨兵节点
    unordered_map<int, Node*> key_to_node;

    // 删除一个节点（抽出一本书）
    void remove(Node* x) {
        x->prev->next = x->next;
        x->next->prev = x->prev;
    }

    // 在链表头添加一个节点（把一本书放在最上面）
    void push_front(Node* x) {
        x->prev = dummy;
        x->next = dummy->next;
        x->prev->next = x;
        x->next->prev = x;
    }

    // 获取 key 对应的节点，同时把该节点移到链表头部
    Node* get_node(int key) {
        auto it = key_to_node.find(key);
        if (it == key_to_node.end()) { // 没有这本书
            return nullptr;
        }
        Node* node = it->second; // 有这本书
        remove(node); // 把这本书抽出来
        push_front(node); // 放在最上面
        return node;
    }

public:
    LRUCache(int capacity) : capacity(capacity), dummy(new Node()) {
        dummy->prev = dummy;
        dummy->next = dummy;
    }

    int get(int key) {
        Node* node = get_node(key); // get_node 会把对应节点移到链表头部
        return node ? node->value : -1;
    }

    void put(int key, int value) {
        Node* node = get_node(key); // get_node 会把对应节点移到链表头部
        if (node) { // 有这本书
            node->value = value; // 更新 value
            return;
        }
        key_to_node[key] = node = new Node(key, value); // 新书
        push_front(node); // 放在最上面
        if (key_to_node.size() > capacity) { // 书太多了
            Node* back_node = dummy->prev;
            key_to_node.erase(back_node->key);
            remove(back_node); // 去掉最后一本书
            delete back_node; // 释放内存
        }
    }
};
```

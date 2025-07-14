---
title: "108：LFU缓存"
date: 2025-07-13T12:37:15+08:00
draft: false
slug: "lc-0460"
categories: ["高频面试题"]
tags: ["链表", "哈希表"]
---

LeetCode 460

https://leetcode.cn/problems/lfu-cache/description/

难度：困难

本题是 LRU 缓存的升级版。本题对于每个使用频率，都需要维护一个双向链表，并通过哈希表把频率和链表关联起来。为了找到最少的使用频率，需要维护一个 min_freq 变量。

在插入时需要插入到链表的头部，而当容量满，需要删除时需要删除的是最少使用频率的书中的尾部结点 dummy->prev。

时间复杂度：所有操作均为 O(1)。

空间复杂度：O(min(p,capacity))，其中 p 为 put 的调用次数。

<!--more-->

```cpp
class Node {
public:
    int key;
    int value;
    int freq = 1; // 新书只读了一次
    Node* prev;
    Node* next;

    Node(int k = 0, int v = 0) : key(k), value(v) {}
};

class LFUCache {
private:
    int min_freq;
    int capacity;
    unordered_map<int, Node*> key_to_node;
    unordered_map<int, Node*> freq_to_dummy;

    Node* get_node(int key) {
        auto it = key_to_node.find(key);
        if (it == key_to_node.end()) { // 没有这本书
            return nullptr;
        }
        Node* node = it->second; // 有这本书
        remove(node); // 把这本书抽出来
        Node* dummy = freq_to_dummy[node->freq];
        if (dummy->prev == dummy) { // 抽出来后，这摞书是空的
            freq_to_dummy.erase(node->freq); // 移除空链表
            delete dummy; // 释放内存
            if (min_freq == node->freq) { // 这摞书是最左边的
                min_freq++;
            }
        }
        push_front(++node->freq, node); // 放在右边这摞书的最上面
        return node;
    }

    // 创建一个新的双向链表
    Node* new_list() {
        Node* dummy = new Node(); // 哨兵节点
        dummy->prev = dummy;
        dummy->next = dummy;
        return dummy;
    }

    // 在链表头添加一个节点（把一本书放在最上面）
    void push_front(int freq, Node* x) {
        auto it = freq_to_dummy.find(freq);
        if (it == freq_to_dummy.end()) { // 这摞书是空的
            it = freq_to_dummy.emplace(freq, new_list()).first;
        }
        Node* dummy = it->second;
        x->prev = dummy;
        x->next = dummy->next;
        x->prev->next = x;
        x->next->prev = x;
    }

    // 删除一个节点（抽出一本书）
    void remove(Node* x) {
        x->prev->next = x->next;
        x->next->prev = x->prev;
    }

public:
    LFUCache(int capacity) : capacity(capacity) {}

    int get(int key) {
        Node* node = get_node(key);
        return node ? node->value : -1;
    }

    void put(int key, int value) {
        Node* node = get_node(key);
        if (node) { // 有这本书
            node->value = value; // 更新 value
            return;
        }
        if (key_to_node.size() == capacity) { // 书太多了
            Node* dummy = freq_to_dummy[min_freq];
            Node* back_node = dummy->prev; // 最左边那摞书的最下面的书
            key_to_node.erase(back_node->key);
            remove(back_node); // 移除
            delete back_node; // 释放内存
            if (dummy->prev == dummy) { // 这摞书是空的
                freq_to_dummy.erase(min_freq); // 移除空链表
                delete dummy; // 释放内存
            }
        }
        key_to_node[key] = node = new Node(key, value); // 新书
        push_front(1, node); // 放在「看过 1 次」的最上面
        min_freq = 1;
    }
};
```

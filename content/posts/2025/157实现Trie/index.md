---
title: "157：实现 Trie"
date: 2025-07-15T19:02:30+08:00
draft: false
slug: "lc-0208"
categories: ["高频面试题"]
tags: ["前缀树"]
---

LeetCode 208

https://leetcode.cn/problems/implement-trie-prefix-tree/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

前缀树其实就是一棵 26 叉树，对于 26 叉树的每个节点，可以用哈希表，或者长为 26 的数组来存储子节点。

初始化：

创建一棵 26 叉树，一开始只有一个根节点 root。26 叉树的每个节点包含一个长为 26 的儿子节点列表 son，以及一个布尔值 end，表示是否为终止节点。

insert：

- 遍历字符串 word，同时用一个变量 cur 表示当前在 26 叉树的哪个节点，初始值为 root。
- 如果 word[i] 不是 cur 的儿子，那么创建一个新的节点 node 作为 cur 的儿子。如果 word[i]=a，那么把 node 记录到 cur 的 son[0] 中。如果 word[i]=b，那么把 node 记录到 cur 的 son[1] 中。依此类推。
- 更新 cur 为儿子列表中的相应节点。
- 遍历结束，把 cur 的 end 标记为 true。

search 和 startsWith 可以复用同一个函数 find：

- 遍历字符串 word，同时用一个变量 cur 表示当前在 26 叉树的哪个节点，初始值为 root。
- 如果 word[i] 不是 cur 的儿子，返回 0。search 和 startsWith 收到 0 之后返回 false。
- 更新 cur 为儿子列表中的相应节点。
- 遍历结束，如果 cur 的 end 是 false，返回 1，否则返回 2。search 如果收到的是 2，返回 true，否则返回 false。startsWith 如果收到的是非 0 数字，返回 true，否则返回 false。

时间复杂度：初始化为 O(1)，insert 为 O(n∣Σ∣)，其余为 O(n)，其中 n 是 word 的长度，∣Σ∣=26 是字符集合的大小。注意创建一个节点需要 O(∣Σ∣) 的时间（如果用的是数组）。

空间复杂度：O(qn∣Σ∣)。其中 q 是 insert 的调用次数。

<!--more-->

```cpp
struct Node {
    Node* son[26]{};
    bool end = false;
};

class Trie {
    Node* root = new Node();

    int find(string word) {
        Node* cur = root;
        for (char c : word) {
            c -= 'a';
            if (cur->son[c] == nullptr) { // 道不同，不相为谋
                return 0;
            }
            cur = cur->son[c];
        }
        // 走过同样的路（2=完全匹配，1=前缀匹配）
        return cur->end ? 2 : 1;
    }

    void destroy(Node* node) {
        if (node == nullptr) {
            return;
        }
        for (Node* son : node->son) {
            destroy(son);
        }
        delete node;
    }

public:
    ~Trie() {
        destroy(root);
    }

    void insert(string word) {
        Node* cur = root;
        for (char c : word) {
            c -= 'a';
            if (cur->son[c] == nullptr) { // 无路可走？
                cur->son[c] = new Node(); // new 出来！
            }
            cur = cur->son[c];
        }
        cur->end = true;
    }

    bool search(string word) {
        return find(word) == 2;
    }

    bool startsWith(string prefix) {
        return find(prefix) != 0;
    }
};
```

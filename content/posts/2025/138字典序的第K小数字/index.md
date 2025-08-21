---
title: "138：字典序的第K小数字"
date: 2025-07-15T19:02:00+08:00
draft: false
slug: "lc-0440"
categories: ["高频面试题"]
tags: ["字典树"]
---

LeetCode 440

https://leetcode.cn/problems/k-th-smallest-in-lexicographical-order/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

题解参考灵神（https://leetcode.cn/problems/k-th-smallest-in-lexicographical-order/solutions/3696254/zai-shi-cha-shu-shang-zhao-di-k-xiao-olo-vzkl/）。

本题可以看成一颗十叉树。

先序遍历这棵树，等价于从左到右遍历字典序列表。所以先序遍历访问到的第 k 个节点就是答案。

每访问一个节点，就把 k 减一。当 k=0 时，当前节点就是答案。

从根节点的第一个儿子 1 开始。由于该节点被我们访问了，先把 k 减一。

设子树 1 的大小（节点个数）为 size。分类讨论：

如果 size≤k，那么答案不在子树 1 中。然后考虑下一个儿子 2，依此类推。访问到下一个儿子时，要把 k 减去 (size−1)+1=size，这里 size−1 是因为节点 1 已经访问过了。

否则，答案在子树 1 中。首先访问 1 的儿子 10，把 k 减一。依次考虑 1 的儿子 10,11,12,…,19，计算子树大小，比较子树大小与 k 的大小关系，依此类推。
问：为什么判断条件是 size≤k 而不是 size<k？

答：因为当我们访问到子树根节点时，就把 k 减一了。这时再算子树大小，就把根节点重复统计了，所以是 size−1<k，即 size≤k。

如何计算子树大小
子树每层的节点个数是有规律的，可以逐层统计。

比如 n = 1234，计算子树 1 的大小：

第一层，只有 1 一个节点。
第二层，最小是 10，最大是 19，有 10 个节点。
第三层，最小是 100，最大是 199，有 100 个节点。
第四层，最小是 1000，最大是 n=1234，有 n−1000+1=235 个节点。
所以一共有 1+10+100+235=346 个节点。

上述过程如何用代码实现？

每一层的最小值是好算的：1→10→100→1000。

最大值呢？看上去不太好算。

不妨改为 2→20→200→min(2000,n+1)，这个过程中的每个数减一，就是每一层的最大值。

时间复杂度：\(O(Dlog^2n)\)，其中 D=10。整棵树有 O(logn) 层，每层会遍历至多 D 个节点，每个节点需要 O(logn) 的时间计算子树大小。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int findKthNumber(int n, int k) {
        // 逐层统计 node 子树大小
        auto count_subtree_size = [&](int node) -> int {
            // 子树大小不会超过 n，所以 size 用 int 类型
            // 但计算过程中的 left 和 right 会超过 int，所以用 long long 类型
            int size = 0;
            long long left = node, right = node + 1;
            while (left <= n) {
                // 这一层的最小值是 left，最大值是 min(right, n + 1) - 1
                size += min(right, n + 1LL) - left;
                left *= 10; // 继续，计算下一层
                right *= 10;
            }
            return size;
        };

        int node = 1;
        k--; // 访问节点 node
        while (k > 0) {
            int size = count_subtree_size(node);
            if (size <= k) { // 向右，跳过 node 子树
                node++; // 访问 node 右侧兄弟节点
                k -= size; // 访问子树中的每个节点，以及新的 node 节点
            } else { // 向下，深入 node 子树
                node *= 10; // 访问 node 的第一个儿子
                k--; // 访问新的 node 节点
            }
        }
        return node;
    }
};
```

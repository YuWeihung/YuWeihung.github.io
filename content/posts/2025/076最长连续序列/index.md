---
title: "076：最长连续序列"
date: 2025-07-04T19:22:45+08:00
draft: false
slug: "lc-0128"
categories: ["高频面试题"]
tags: ["哈希表"]
---

LeetCode 128

https://leetcode.cn/problems/longest-consecutive-sequence/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

对于 nums 中的元素 x，以 x 为起点，不断查找下一个数 x+1,x+2,⋯ 是否在 nums 中，并统计序列的长度。

为了做到 O(n) 的时间复杂度，需要两个关键优化：

把 nums 中的数都放入一个哈希集合中，这样可以 O(1) 判断数字是否在 nums 中。

如果 x−1 在哈希集合中，则不以 x 为起点。为什么？因为以 x−1 为起点计算出的序列长度，一定比以 x 为起点计算出的序列长度要长！这样可以避免大量重复计算。比如 nums=[3,2,4,5]，从 3 开始，我们可以找到 3,4,5 这个连续序列；而从 2 开始，我们可以找到 2,3,4,5 这个连续序列，一定比从 3 开始的序列更长。
⚠ 注意：遍历元素的时候，要遍历哈希集合，而不是 nums！如果 nums=[1,1,1,…,1,2,3,4,5,…]（前一半都是 1），遍历 nums 的做法会导致每个 1 都跑一个 O(n) 的循环，总的循环次数是 \(O(n^2)\)，会超时。

时间复杂度：O(n)，其中 n 是 nums 的长度。在二重循环中，每个元素至多遍历两次：在外层循环中遍历一次，在内层循环中遍历一次。所以二重循环的时间复杂度是 O(n) 的。比如 nums=[1,2,3,4]，其中 2,3,4 不会进入内层循环，只有 1 会进入内层循环。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
public:
    int longestConsecutive(vector<int>& nums) {
        int ans = 0;
        unordered_set<int> st(nums.begin(), nums.end()); // 把 nums 转成哈希集合
        for (int x : st) { // 遍历哈希集合
            if (st.contains(x - 1)) {
                continue;
            }
            // x 是序列的起点
            int y = x + 1;
            while (st.contains(y)) { // 不断查找下一个数是否在哈希集合中
                y++;
            }
            // 循环结束后，y-1 是最后一个在哈希集合中的数
            ans = max(ans, y - x); // 从 x 到 y-1 一共 y-x 个数
        }
        return ans;
    }
};
```

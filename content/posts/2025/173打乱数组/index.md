---
title: "173：打乱数组"
date: 2025-07-15T19:03:02+08:00
draft: false
slug: "lc-0384"
categories: ["高频面试题"]
tags: ["洗牌算法"]
---

LeetCode 384

https://leetcode.cn/problems/shuffle-an-array/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

Knuth 洗牌算法，i 从 n - 1 遍历到 0，j 为 [0, i] 中的随机数，交换 i，j。

取随机数的方法为 rand() % (i + 1)。rand() 函数定义在 cstdlib 头文件中。

时间复杂度：

初始化：O(n)，其中 n 为数组中的元素数量。我们需要 O(n) 来初始化 original。

reset：O(n)。我们需要 O(n) 将 original 复制到 nums。

shuffle：O(n)。我们只需要遍历 n 个元素即可打乱数组。

空间复杂度：O(n)。记录初始状态需要存储 n 个元素。

<!--more-->

```cpp
class Solution {
    vector<int> v, s;

public:
    Solution(vector<int>& nums) : v(nums), s(nums) {}

    vector<int> reset() {
        s = v;
        return s;
    }

    vector<int> shuffle() {
        int n = s.size();
        for (int i = n - 1; i >= 0; i--) {
            swap(s[i], s[rand() % (i + 1)]);
        }
        return s;
    }
};
```

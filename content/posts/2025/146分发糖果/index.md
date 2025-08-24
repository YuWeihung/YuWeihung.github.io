---
title: "146：分发糖果"
date: 2025-07-15T19:02:13+08:00
draft: false
slug: "lc-0135"
categories: ["高频面试题"]
tags: ["贪心"]
---

LeetCode 135

https://leetcode.cn/problems/candy/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

两次遍历，先从左往右，再从右往左。

时间复杂度：O(n)，其中 n 是孩子的数量。我们需要遍历两次数组以分别计算满足左规则或右规则的最少糖果数量。

空间复杂度：O(n)，其中 n 是孩子的数量。我们需要保存所有的左规则对应的糖果数量。

<!--more-->

```cpp
class Solution {
public:
    int candy(vector<int>& ratings) {
        int n = ratings.size();
        vector<int> f(n, 1);
        for (int i = 1; i < n; i++) {
            if (ratings[i] > ratings[i - 1]) {
                f[i] = f[i - 1] + 1;
            }
        }
        int sum = f[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            if (ratings[i] > ratings[i + 1]) {
                f[i] = max(f[i], f[i + 1] + 1);
            }
            sum += f[i];
        }
        return sum;
    }
};
```

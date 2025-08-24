---
title: "141：解码方法"
date: 2025-07-15T19:02:05+08:00
draft: false
slug: "lc-0091"
categories: ["高频面试题"]
tags: ["动态规划", "划分型DP"]
---

LeetCode 91

https://leetcode.cn/problems/decode-ways/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这是划分型 DP 中的最优划分问题。

计算最少（最多）可以划分出多少段、最优划分得分等。

一般定义 f[i] 表示长为 i 的前缀 a[:i] 在题目约束下，分割出的最少（最多）子数组个数（或者定义成分割方案数）。

枚举最后一个子数组的左端点 L，从 f[L] 转移到 f[i]，并考虑 a[L:i] 对最优解的影响。

本题类似爬楼梯，只是 f[i - 2] 需要判定。

时间复杂度：O(n)，其中 n 是字符串 s 的长度。

空间复杂度：O(n) 或 O(1)。如果使用数组进行状态转移，空间复杂度为 O(n)；如果仅使用三个变量，空间复杂度为 O(1)。

<!--more-->

```cpp
class Solution {
public:
    int numDecodings(string s) {
        int n = s.size();
        vector<int> f(n + 1, 0);
        f[0] = 1;
        for (int i = 1; i <= n; i++) {
            if (s[i - 1] != '0') {
                f[i] += f[i - 1];
            }
            if (i > 1 && s[i - 2] != '0' && ((s[i - 2] - '0') * 10 + (s[i - 1] - '0') <= 26)) {
                f[i] += f[i - 2];
            }
        }
        return f[n];
    }
};
```

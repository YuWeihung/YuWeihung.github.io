---
title: "179：第N个数字"
date: 2025-07-15T19:03:16+08:00
draft: false
slug: "lc-0400"
categories: ["高频面试题"]
tags: ["数学"]
---

LeetCode 400

https://leetcode.cn/problems/nth-digit/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

已知 x 位数共有 9×10^x−1 个，所有 x 位数的位数之和是 x × 9×10^x−1。使用 d 和 count 分别表示当前遍历到的位数和当前位数下的所有整数的位数之和，初始时 d=1，count=9。每次将 n 减去 d×count，然后将 d 加 1，将 count 乘以 10，直到 n≤d×count，此时的 d 是目标数字所在整数的位数，n 是所有 d 位数中从第一位到目标数字的位数。

为了方便计算目标数字，使用目标数字在所有 d 位数中的下标进行计算，下标从 0 开始计数。令 index=n−1，则 index 即为目标数字在所有 d 位数中的下标，index 的最小可能取值是 0。

时间复杂度：O(log10 n)。用 d 表示第 n 位数字所在整数的位数，循环需要遍历 d 次，由于 d=O(log10 n)，因此时间复杂度是 O(log10 n)。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int findNthDigit(int n) {
        int d = 1, count = 9;
        while (n > (long) d * count) {
            n -= d * count;
            d++;
            count *= 10;
        }
        int index = n - 1;
        int start = (int) pow(10, d - 1);
        int num = start + index / d;
        int digitIndex = index % d;
        int digit = (num / (int) (pow(10, d - digitIndex - 1))) % 10;
        return digit;
    }
};
```

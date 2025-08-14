---
title: "127：整数反转"
date: 2025-07-15T19:01:44+08:00
draft: false
slug: "lc-0007"
categories: ["高频面试题"]
tags: ["模拟"]
---

LeetCode 7

https://leetcode.cn/problems/reverse-integer/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

模拟即可。需要判断答案是否会溢出，如果会溢出直接返回 0。

时间复杂度：O(log∣x∣)。翻转的次数即 x 十进制的位数。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int reverse(int x) {
        int ans = 0;
        while (x != 0) {
            if (ans < INT_MIN / 10 || ans > INT_MAX / 10) {
                return 0;
            }
            ans = ans * 10 + x % 10;
            x /= 10;
        }
        return ans;
    }
};
```

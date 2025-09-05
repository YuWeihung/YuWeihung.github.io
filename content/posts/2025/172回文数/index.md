---
title: "172：回文数"
date: 2025-07-15T19:03:00+08:00
draft: false
slug: "lc-0009"
categories: ["高频面试题"]
tags: ["数学"]
---

LeetCode 9

https://leetcode.cn/problems/palindrome-number/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

反转前一半数字。特判 x<0 的情况，此时 x 一定不是回文数。特判 x > 0 且 x 个位数是 0 的情况，由于 x 的最高位一定不是 0，所以 x 一定不是回文数。

时间复杂度：如果 x≤0 则时间复杂度为 O(1)，否则时间复杂度为 O(logx)。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    bool isPalindrome(int x) {
        if (x < 0 || x > 0 && x % 10 == 0) {
            return false;
        }
        intev = 0;
        while (rev < x / 10) {
            rev = rev * 10 + x % 10;
            x /= 10;
        }
        return rev == x || rev == x / 10;
    }
};
```

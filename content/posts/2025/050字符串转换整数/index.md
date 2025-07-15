---
title: "050：字符串转换整数"
date: 2025-07-01T21:03:43+08:00
draft: false
slug: "lc-0008"
categories: ["高频面试题"]
tags: ["字符串", "模拟"]
---

LeetCode 8

https://leetcode.cn/problems/string-to-integer-atoi/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题是一道比较麻烦的模拟。

1. 跳过前导空格。
2. 检查符号。
3. 读入数字。需要注意检查溢出。32 位 int 的范围是 [-2147483648, 2147483647]。无论是正数还是负数，只要绝对值大于 2147483647，我们就返回 INT_MAX/INT_MIN。对于正数是已经溢出，对于负数则正好是 INT_MIN。判断方式是 ans > INT_MAX / 10 || (ans == INT_MAX / 10 && s[i] > '7')。

时间复杂度：O(n)。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int myAtoi(string s) {
        if (s.empty()) {
            return 0;
        }
        int ans = 0;
        int sign = 1;
        int i = 0, n = s.size();
        while (i < n && s[i] == ' ') {
            i++;
        }
        if (i < n && s[i] == '+' || s[i] == '-') {
            if (s[i] == '-') {
                sign = -1;
            }
            i++;
        }
        while (i < n && isdigit(s[i])) {
            if (ans > INT_MAX / 10 || (ans == INT_MAX / 10 && s[i] > '7')) {
                return sign == 1 ? INT_MAX : INT_MIN;
            }
            ans = ans * 10 + (s[i] - '0');
            i++;
        }
        return ans * sign;
    }
};
```

---
title: "027：字符串相加"
date: 2025-06-29T21:06:34+08:00
draft: false
slug: "lc-0415"
categories: ["高频面试题"]
tags: ["模拟", "高精度计算"]
---

LeetCode 415

https://leetcode.cn/problems/add-strings/description/

难度：简单

本题为高精度加法。使用两个指针倒序遍历 num1 和 num2，最后处理有进位的情况。将 ans 反转后就是答案。

时间复杂度：O(max(m, n))。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    string addStrings(string num1, string num2) {
        int m = num1.size(), n = num2.size();
        int i = m - 1, j = n - 1;
        int carry = 0;
        string ans;
        while (i >= 0 && j >= 0) {
            int d = num1[i] - '0' + num2[j] - '0' + carry;
            carry = d / 10;
            d %= 10;
            ans.push_back(d + '0');
            i--;
            j--;
        }
        while (i >= 0) {
            int d = num1[i] - '0' + carry;
            carry = d / 10;
            d %= 10;
            ans.push_back(d + '0');
            i--;
        }
        while (j >= 0) {
            int d = num2[j] - '0' + carry;
            carry = d / 10;
            d %= 10;
            ans.push_back(d + '0');
            j--;
        }
        if (carry) {
            ans.push_back('1');
        }
        reverse(ans.begin(), ans.end());
        return ans;
    }
};
```

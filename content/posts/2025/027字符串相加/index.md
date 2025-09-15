---
title: "027：字符串相加"
date: 2025-06-29T21:06:34+08:00
draft: false
slug: "lc-0415"
categories: ["高频面试题"]
tags: ["模拟", "字符串"]
---

LeetCode 415

https://leetcode.cn/problems/add-strings/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题为高精度加法。使用两个指针倒序遍历 num1 和 num2，最后处理有进位的情况。将 ans 反转后就是答案。

时间复杂度：O(max(m, n))。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    string addStrings(string num1, string num2) {
        int i = num1.length() - 1, j = num2.length() - 1, add = 0;
        string ans = "";
        while (i >= 0 || j >= 0 || add != 0) {
            int x = i >= 0 ? num1[i] - '0' : 0;
            int y = j >= 0 ? num2[j] - '0' : 0;
            int result = x + y + add;
            ans.push_back('0' + result % 10);
            add = result / 10;
            i -= 1;
            j -= 1;
        }
        // 计算完以后的答案需要翻转过来
        reverse(ans.begin(), ans.end());
        return ans;
    }
};
```

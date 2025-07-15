---
title: "054：字符串相乘"
date: 2025-07-02T22:46:25+08:00
draft: false
slug: "lc-0043"
categories: ["高频面试题"]
tags: ["模拟", "高精度计算"]
---

LeetCode 43

https://leetcode.cn/problems/multiply-strings/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

高精度乘法，模拟竖式计算。

为了方便处理进位，先用一个倒序的 int 类型数组来存储计算结果，最后再将结果转回字符串。

数组的长度初始化为 m + n，如果最高位为 0，则将长度减一。

时间复杂度：O(mn)。

空间复杂度：O(m+n)。

<!--more-->

```cpp
class Solution {
public:
    string multiply(string num1, string num2) {
        int m = num1.size(), n = num2.size();
        if (num1 == "0" || num2 == "0") {
            return "0";
        }
        vector<int> ans(m + n, 0);
        for (int i = m - 1; i >= 0; i--) {
            int x = num1[i] - '0';
            for (int j =n - 1; j >= 0; j--) {
                int y = num2[j] - '0';
                int pos = m + n - i - j - 2;
                ans[pos] += x * y;
                ans[pos + 1] += ans[pos] / 10;
                ans[pos] %= 10;
            }
        }
        int idx = m + n - 1;
        if (ans[idx] == 0) {
            idx--;
        }
        string str;
        for (int i = idx; i >= 0; i--) {
            str.push_back(ans[i] + '0');
        }
        return str;
    }
};
```

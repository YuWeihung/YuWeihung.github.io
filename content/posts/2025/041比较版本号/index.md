---
title: "041：比较版本号"
date: 2025-07-01T16:42:49+08:00
draft: false
slug: "lc-0165"
categories: ["高频面试题"]
tags: ["字符串", "双指针"]
---

LeetCode 165

https://leetcode.cn/problems/compare-version-numbers/description/

难度：中等

使用两个指针，遍历两个字符串，直到找到'.'，将每一段的版本号转换为整数，比较两个整数是否相等。整数初始化为 0，以处理这一段版本号缺失的情况。

时间复杂度：O(n+m)，其中 m 是字符串 version1 的长度，n 是字符串 version2 的长度。

空间复杂度：O(1)，我们只需要常数的空间保存若干变量。

<!--more-->

```cpp
class Solution {
public:
    int compareVersion(string version1, string version2) {
        int m = version1.size(), n = version2.size();
        int i = 0, j = 0;
        while (i < m || j < n) {
            long long x = 0;
            for (; i < m && version1[i] != '.'; i++) {
                x = x * 10 + version1[i] - '0';
            }
            i++;
            long long y = 0;
            for (; j < n && version2[j] != '.'; j++) {
                y = y * 10 + version2[j] - '0';
            }
            j++;
            if (x != y) {
                return x > y ? 1 : -1;
            }
        }
        return 0;
    }
};
```

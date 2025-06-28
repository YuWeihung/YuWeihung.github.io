---
title: "010：最长回文子串"
date: 2025-06-28T23:00:27+08:00
draft: false
slug: "lc-0005"
categories: ["高频面试题"]
tags: ["字符串"]
---

LeetCode 5

https://leetcode.cn/problems/longest-palindromic-substring/description/

难度：中等

本题是字符串的经典题目，有 3 种做法，分别是动态规划，中心扩展法和马拉车算法。其中前两种做法的时间复杂度为\(O(n^2)\)，马拉车算法的时间复杂度为\(O(n)\)。不过由于马拉车算法较为复杂，在这里使用的是实现较为简单的中心扩展算法。

中心扩展算法就是对于每一个元素，分别讨论子串长度为奇数和偶数的情况，如果子串两端的字符相同，就继续向外扩展。

时间复杂度：\(O(n^2)\)，其中 n 是字符串的长度。长度为 1 和 2 的回文中心分别有 n 和 n−1 个，每个回文中心最多会向外扩展 O(n) 次。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    string longestPalindrome(string s) {
        int start = -1, len = 0;
        int n = s.size();
        for (int i = 0; i < n; i++) {
            int r = 0;
            while (i - r >= 0 && i + r < n && s[i - r] == s[i + r]) {
                r++;
            }
            r--;
            if (2 * r + 1 > len) {
                len = 2 * r + 1;
                start = i - r;
            }
            if (i < n - 1) {
                r = 0;
                while (i - r >= 0 && i + 1 + r < n && s[i - r] == s[i + 1 + r]) {
                    r++;
                }
                r--;
                if (2 * r + 2 > len) {
                    len = 2 * r + 2;
                    start = i - r;
                }
            }
        }
        return s.substr(start, len);
    }
};
```

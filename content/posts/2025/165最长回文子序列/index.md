---
title: "165：最长回文子序列"
date: 2025-07-15T19:02:44+08:00
draft: false
slug: "lc-0516"
categories: ["高频面试题"]
tags: ["动态规划", "区间DP"]
---

LeetCode 516

https://leetcode.cn/problems/longest-palindromic-subsequence/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

区间 DP，从大区间转移到小区间。f[i][j] 为 s[i] 到 s[j] 的最长回文子序列。

```
if (s[i] == s[j]) {
    f[i][j] = 2 + f[i + 1][j - 1];
} else {
    f[i][j] = max(f[i + 1][j], f[i][j - 1];)
}
```

时间复杂度：O(n^2)，其中 n 为 s 的长度。动态规划的时间复杂度 = 状态个数 × 单个状态的转移个数。本题中状态个数等于 O(n^2)，而单个状态的转移个数为 O(1)，因此时间复杂度为 O(n^2)。

空间复杂度：O(n^2)。

<!--more-->

```cpp
class Solution {
public:
    int longestPalindromeSubseq(string s) {
        int n = s.length();
        vector f(n, vector<int>(n));
        for (int i = n - 1; i >= 0; i--) {
            f[i][i] = 1;
            for (int j = i + 1; j < n; j++) {
                f[i][j] = s[i] == s[j] ? f[i + 1][j - 1] + 2 :
                          max(f[i + 1][j], f[i][j - 1]);
            }
        }
        return f[0][n - 1];
    }
};
```

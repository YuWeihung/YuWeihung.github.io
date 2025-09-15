---
title: "175：通配符匹配"
date: 2025-07-15T19:03:06+08:00
draft: false
slug: "lc-0044"
categories: ["高频面试题"]
tags: ["动态规划", "字符串"]
---

LeetCode 44

https://leetcode.cn/problems/wildcard-matching/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

动态规划，我们用 dp[i][j] 表示字符串 s 的前 i 个字符和模式 p 的前 j 个字符是否能匹配。状态转移方程为

```cpp
if (p[j - 1] == '*') {
    dp[i][j] = dp[i][j - 1] | dp[i - 1][j];
}
else if (p[j - 1] == '?' || s[i - 1] == p[j - 1]) {
    dp[i][j] = dp[i - 1][j - 1];
}
```

时间复杂度：O(mn)，其中 m 和 n 分别是字符串 s 和模式 p 的长度。

空间复杂度：O(mn)，即为存储所有 (m+1)(n+1) 个状态需要的空间。此外，在状态转移方程中，由于 dp[i][j] 只会从 dp[i][..] 以及 dp[i−1][..] 转移而来，因此我们可以使用滚动数组对空间进行优化，即用两个长度为 n+1 的一维数组代替整个二维数组进行状态转移，空间复杂度为 O(n)。

<!--more-->

```cpp
class Solution {
public:
    bool isMatch(string s, string p) {
        int m = s.size();
        int n = p.size();
        vector<vector<int>> dp(m + 1, vector<int>(n + 1));
        dp[0][0] = true;
        for (int i = 1; i <= n; ++i) {
            if (p[i - 1] == '*') {
                dp[0][i] = true;
            }
            else {
                break;
            }
        }
        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (p[j - 1] == '*') {
                    dp[i][j] = dp[i][j - 1] | dp[i - 1][j];
                }
                else if (p[j - 1] == '?' || s[i - 1] == p[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1];
                }
            }
        }
        return dp[m][n];
    }
};
```

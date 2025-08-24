---
title: "149：正则表达式匹配"
date: 2025-07-15T19:02:17+08:00
draft: false
slug: "lc-0010"
categories: ["高频面试题"]
tags: ["动态规划"]
---

LeetCode 10

https://leetcode.cn/problems/regular-expression-matching/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

动态规划。dp[i][j]表示 s[..i]与 p[..j]是否能够匹配。

1. s[i]==p[j] 或者 p[j]=='.'

此时 dp[i][j] = dp[i-1][j-1]

2. s[i]与 p[j]不匹配，并且 p[j] != '\*'

如果 2.1 不成立，并且 p[j]也不是通配符'\*'，那没辙了，直接返回匹配失败。

3. s[i]与 p[j]虽然不匹配，但是 p[j] == '\*'

这就要分两种情况了，要看 p[j-1]和 s[i]是否匹配。

如果 p[j-1]和 s[i]不匹配，那'\_'只能把前元素 p[j-1]匹配成 0 个

如果 p[j-1]和 s[i]可以匹配，那'\_'就可以把前元素 p[j-1]匹配成 0 个，1 个，多个。

时间复杂度：O(mn)，其中 m 和 n 分别是字符串 s 和 p 的长度。我们需要计算出所有的状态，并且每个状态在进行转移时的时间复杂度为 O(1)。

空间复杂度：O(mn)，即为存储所有状态使用的空间。

<!--more-->

```cpp
class Solution {
public:
    bool isMatch(string s, string p) {
        int m = s.size();
        int n = p.size();

        auto matches = [&](int i, int j) {
            if (i == 0) {
                return false;
            }
            if (p[j - 1] == '.') {
                return true;
            }
            return s[i - 1] == p[j - 1];
        };

        vector<vector<int>> f(m + 1, vector<int>(n + 1));
        f[0][0] = true;
        for (int i = 0; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (p[j - 1] == '*') {
                    f[i][j] |= f[i][j - 2];
                    if (matches(i, j - 1)) {
                        f[i][j] |= f[i - 1][j];
                    }
                }
                else {
                    if (matches(i, j)) {
                        f[i][j] |= f[i - 1][j - 1];
                    }
                }
            }
        }
        return f[m][n];
    }
};
```

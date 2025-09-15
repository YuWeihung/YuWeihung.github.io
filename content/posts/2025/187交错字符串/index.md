---
title: "187：交错字符串"
date: 2025-07-15T19:03:39+08:00
draft: false
slug: "lc-0097"
categories: ["高频面试题"]
tags: ["动态规划"]
---

LeetCode 97

https://leetcode.cn/problems/interleaving-string/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

f[i + 1][j + 1] 表示 s3 的前 i + j + 2 个元素能否由 s1 的前 i + 1 个元素和 s2 的前 j + 1 个元素组成。

状态转移条件是 s3 的前 i + j + 1 个元素能否由 s1 的前 i 个元素和 s2 的前 j + 1 个元素组成，或由 s1 的前 i + 1 个元素和 s2 的前 j 个元素组成。

初始值 f[0][0] = 0，并且单独计算 f[i][0] 和 f[0][j]。

时间复杂度：O(nm)。

空间复杂度：O(nm)。

<!--more-->

```cpp
class Solution {
public:
    bool isInterleave(string s1, string s2, string s3) {
        int n = s1.size(), m = s2.size();
        if (n + m != s3.size()) {
            return false;
        }

        vector f(n + 1, vector<int>(m + 1));
        f[0][0] = true;
        for (int j = 0; j < m; j++) {
            f[0][j + 1] = s2[j] == s3[j] && f[0][j];
        }
        for (int i = 0; i < n; i++) {
            f[i + 1][0] = s1[i] == s3[i] && f[i][0];
            for (int j = 0; j < m; j++) {
                f[i + 1][j + 1] = s1[i] == s3[i + j + 1] && f[i][j + 1] ||
                                  s2[j] == s3[i + j + 1] && f[i + 1][j];
            }
        }
        return f[n][m];
    }
};
```

---
title: "095：单词拆分"
date: 2025-07-06T13:21:14+08:00
draft: false
slug: "lc-0139"
categories: ["高频面试题"]
tags: ["动态规划", "划分型DP"]
---

LeetCode 139

https://leetcode.cn/problems/word-break/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

划分型 DP 一般定义 f[i] 表示长为 i 的前缀 a[:i] 能否划分。

枚举最后一个子数组的左端点 L，从 f[L] 转移到 f[i]，并考虑 a[L:i] 是否满足要求。

这道题首先为了方便判断是否在单词表中，先把 wordDict 转成 unordered_set。另外，本题 wordDict 至多有 1000 个字符串，但最多只有 20 种不同的长度，所以应该枚举长度，而不是枚举 wordDict 中的字符串。

时间复杂度：\(O(mL+nL^2)\)，其中 m 是 wordDict 的长度，L 是 wordDict 中字符串的最长长度，n 是 s 的长度。创建哈希集合需要 O(mL) 的时间。由于每个状态只会计算一次，动态规划的时间复杂度 = 状态个数 × 单个状态的计算时间。本题状态个数等于 O(n)，单个状态的计算时间为 \(O(L^2)\)（注意判断子串是否在哈希集合中需要 O(L) 的时间），所以记忆化搜索的时间复杂度为 \(O(nL^2)\)。

空间复杂度：O(mL+n)。哈希集合需要 O(mL) 的空间。记忆化搜索需要 O(n) 的空间。

<!--more-->

```cpp
class Solution {
public:
    bool wordBreak(string s, vector<string>& wordDict) {
        int m = s.size(), n = wordDict.size();
        int max_len = 0;
        for (int i = 0; i < n; i++) {
            max_len = max(max_len, (int)wordDict[i].size());
        }
        unordered_set<string> words(wordDict.begin(), wordDict.end());

        vector<int> f(m + 1);
        f[0] = true;

        for (int i = 1; i <= m; i++) {
            for (int j = i - 1; j >= max(i - max_len, 0); j--) {
                if (f[j] && words.count(s.substr(j, i - j))) {
                    f[i] = true;
                    break;
                }
            }
        }

        return f[m];
    }
};
```

---
title: "001：无重复字符的最长子串"
date: 2025-06-25T16:43:49+08:00
draft: false
slug: "lc-0003"
categories: ["高频面试题"]
tags: ["哈希表", "滑动窗口"]
---

LeetCode 0003
https://leetcode.cn/problems/longest-substring-without-repeating-characters/description/

难度：Mid

本题为经典的哈希表加滑动窗口的题目，哈希表统计窗口内字符出现次数，如果窗口右端点字符出现次数大于 1，右移左端点，直到无重复字符，最后更新答案。窗口的长度为 right - left + 1。

<!--more-->

```cpp
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        int n = s.size();
        int left = 0;
        int ans = 0;
        unordered_map<char, int> cnt;
        for (int right = 0; right < n; right++) {
            cnt[s[right]]++;
            while (cnt[s[right]] > 1) {
                cnt[s[left]]--;
                left++;
            }
            ans = max(ans, right - left + 1);
        }
        return ans;
    }
};
```

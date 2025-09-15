---
title: "185：至少有K个重复字符的最长子串"
date: 2025-07-15T19:03:32+08:00
draft: false
slug: "lc-0395"
categories: ["高频面试题"]
tags: ["滑动窗口", "字符串"]
---

LeetCode 395

https://leetcode.cn/problems/longest-substring-with-at-least-k-repeating-characters/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题直接使用滑动窗口，当不满足条件时，无法确定应该如何移动窗口，因此需要添加一个参数，count 记录窗口内不同字母的数量。在滑动窗口的过程中，固定右端点，unique 表示窗口内不同字母的数量，valid 表示至少出现了 k 次的字母的数量。当 unique > count 时，需要右移窗口左端点。当 valid == count 时，窗口合法，更新答案。最后遍历 count 的可能值 1 - 26，得到最终的答案。

时间复杂度: O(26∗n)

空间复杂度: O(n)

<!--more-->

```cpp
class Solution {
public:
    int longestSubstring(string s, int k) {
        int n = s.size();
        auto helper = [&](int count) -> int {
            int res = 0;
            int left = 0;
            int cnt[26] = {0};
            int unique = 0;
            int valid = 0;
            for (int right = 0; right < n; right++) {
                int c = s[right] - 'a';
                if (cnt[c] == 0) {
                    unique++;
                }
                cnt[c]++;
                if (cnt[c] == k) {
                    valid++;
                }
                while (unique > count) {
                    int d = s[left] - 'a';
                    left++;
                    if (cnt[d] == k) {
                        valid--;
                    }
                    cnt[d]--;
                    if (cnt[d] == 0) {
                        unique--;
                    }
                }
                if (valid == count) {
                    res = max(res, right - left + 1);
                }
            }
            return res;
        };
        int ans = 0;
        for (int i = 1; i <= 26; i++) {
            ans = max(ans, helper(i));
        }
        return ans;
    }
};
```

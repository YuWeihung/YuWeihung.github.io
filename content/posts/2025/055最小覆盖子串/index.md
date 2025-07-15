---
title: "055：最小覆盖子串"
date: 2025-07-02T23:52:57+08:00
draft: false
slug: "lc-0076"
categories: ["高频面试题"]
tags: ["滑动窗口", "哈希表"]
---

LeetCode 76

https://leetcode.cn/problems/minimum-window-substring/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

这是滑动窗口的题目。s 覆盖 t 的意思就是对 t 中的每个字母，s 里的出现次数都不小于 t 里的出现次数。出现次数使用哈希表来计数，在本题可以使用数组来进行优化。

时间复杂度：O(∣Σ∣m+n)，其中 m 为 s 的长度，n 为 t 的长度，∣Σ∣ 为字符集合的大小，本题字符均为英文字母，所以 ∣Σ∣=52。注意 left 只会增加不会减少，left 每增加一次，我们就花费 O(∣Σ∣) 的时间。因为 left 至多增加 m 次，所以二重循环的时间复杂度为 O(∣Σ∣m)，再算上统计 t 字母出现次数的时间 O(n)，总的时间复杂度为 O(∣Σ∣m+n)。

空间复杂度：O(∣Σ∣)。如果创建了大小为 128 的数组，则 ∣Σ∣=128。

<!--more-->

```cpp
class Solution {
public:
    string minWindow(string s, string t) {
        int cnt_s[128]{}; // s 子串字母的出现次数
        int cnt_t[128]{}; // t 中字母的出现次数
        int m = s.size(), n = t.size();
        for (char c : t) {
            cnt_t[c]++;
        }
        auto check = [&]() -> bool {
            for (char c = 'a'; c <= 'z'; c++) {
                if (cnt_s[c] < cnt_t[c]) {
                    return false;
                }
            }
            for (char c = 'A'; c <= 'Z'; c++) {
                if (cnt_s[c] < cnt_t[c]) {
                    return false;
                }
            }
            return true;
        };
        int left = 0;
        int start = -1, len = INT_MAX;
        for (int right = 0; right < m; right++) {
            cnt_s[s[right]]++;
            while (check()) {
                int l = right - left + 1;
                if (l < len) {
                    len = l;
                    start = left;
                }
                cnt_s[s[left]]--;
                left++;
            }
        }
        if (len == INT_MAX) {
            return "";
        } else {
            return s.substr(start, len);
        }
    }
};
```

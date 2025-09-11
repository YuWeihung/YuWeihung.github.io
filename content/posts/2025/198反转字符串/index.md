---
title: "198：反转字符串"
date: 2025-07-15T19:04:22+08:00
draft: false
slug: "lc-0344"
categories: ["高频面试题"]
tags: ["双指针", "字符串"]
---

LeetCode 344

https://leetcode.cn/problems/reverse-string/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

由于 left+right=n−1 恒成立，所以只需要用一个变量 i 表示 left，n−1−i 就是 right。

根据上面的讨论，循环直到 i=⌊n / 2⌋ 时停止。

时间复杂度：O(n)，其中 n 为 s 的长度。

空间复杂度：O(1)。仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    void reverseString(vector<char>& s) {
        int n = s.size();
        for (int i = 0; i < n / 2; i++) {
            swap(s[i], s[n - 1 - i]);
        }
    }
};
```

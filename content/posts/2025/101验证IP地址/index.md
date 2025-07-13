---
title: "101：验证IP地址"
date: 2025-07-13T12:37:14+08:00
draft: false
slug: "lc-0468"
categories: ["高频面试题"]
tags: ["字符串", "模拟"]
---

LeetCode 468

https://leetcode.cn/problems/validate-ip-address/description/

难度：中等

模拟题。

我们首先查找给定的字符串 queryIP 中是否包含符号 ‘.’。如果包含，那么我们需要判断其是否为 IPv4 地址；如果不包含，我们则判断其是否为 IPv6 地址。

对于 IPv4 地址而言，它包含 4 个部分，用 ‘.’ 隔开。因此我们可以存储相邻两个 ‘.’ 出现的位置 last 和 cur（当考虑首个部分时，last=−1；当考虑最后一个部分时，cur=n，其中 n 是字符串的长度），那么子串 queryIP[last+1..cur−1] 就对应着一个部分。我们需要判断：

它的长度是否在 [1,3] 之间（虽然这一步没有显式要求，但提前判断可以防止后续计算值时 32 位整数无法表示的情况）；

它是否只包含数字；

它的值是否在 [0,255] 之间；

它是否不包含前导零。具体地，如果它的值为 0，那么该部分只能包含一个 0，即 (cur−1)−(last+1)+1=1；如果它的值不为 0，那么该部分的第一个数字不能为 0，即 queryIP[last+1] 不为 0。

对于 IPv6 地址而言，它包含 8 个部分，用 ‘:’ 隔开。同样地，我们可以存储相邻两个 ‘:’ 出现的位置 last 和 cur，那么子串 queryIP[last+1..cur−1] 就对应着一个部分。我们需要判断：

它的长度是否在 [1,4] 之间；

它是否只包含数字，或者 a-f，或者 A-F；

除了上述情况以外，如果我们无法找到对应数量的部分，那么给定的字符串也不是一个有效的 IP 地址。

时间复杂度：O(n)，其中 n 是字符串 queryIP 的长度。我们只需要遍历字符串常数次。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    string validIPAddress(string queryIP) {
        if (queryIP.find('.') != string::npos) {
            // IPv4
            int last = -1;
            for (int i = 0; i < 4; ++i) {
                int cur = (i == 3 ? queryIP.size() : queryIP.find('.', last + 1));
                if (cur == string::npos) {
                    return "Neither";
                }
                if (cur - last - 1 < 1 || cur - last - 1 > 3) {
                    return "Neither";
                }
                int addr = 0;
                for (int j = last + 1; j < cur; ++j) {
                    if (!isdigit(queryIP[j])) {
                        return "Neither";
                    }
                    addr = addr * 10 + (queryIP[j] - '0');
                }
                if (addr > 255) {
                    return "Neither";
                }
                if (addr > 0 && queryIP[last + 1] == '0') {
                    return "Neither";
                }
                if (addr == 0 && cur - last - 1 > 1) {
                    return "Neither";
                }
                last = cur;
            }
            return "IPv4";
        }
        else {
            // IPv6
            int last = -1;
            for (int i = 0; i < 8; ++i) {
                int cur = (i == 7 ? queryIP.size() : queryIP.find(':', last + 1));
                if (cur == string::npos) {
                    return "Neither";
                }
                if (cur - last - 1 < 1 || cur - last - 1 > 4) {
                    return "Neither";
                }
                for (int j = last + 1; j < cur; ++j) {
                    if (!isdigit(queryIP[j]) && !('a' <= tolower(queryIP[j]) && tolower(queryIP[j]) <= 'f')) {
                        return "Neither";
                    }
                }
                last = cur;
            }
            return "IPv6";
        }
    }
};
```

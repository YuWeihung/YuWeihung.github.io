---
title: "181：36进制加法"
date: 2025-07-15T19:03:21+08:00
draft: false
slug: "nc-0330"
categories: ["高频面试题"]
tags: ["字符串", "模拟"]
---

NowCoder 330

https://www.nowcoder.com/practice/c5db069fd9d64e6e9cf5fd68860abcdd

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题类似 LeetCode 415 字符串相加，不过改成了 36 进制。代码类似，只需要将 10 改为 36，以及 36 进制字符与数字的转换。

时间复杂度：O(max(m, n))。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
    int to_int(char ch) {
        int x;
        if ('0' <= ch && ch <= '9') {
            x = ch - '0';
        } else {
            x = ch - 'a' + 10;
        }
        return x;
    }

    char to_char(int x) {
        char ch;
        if (0 <= x && x <= 9) {
            ch = x + '0';
        } else {
            ch = x - 10 + 'a';
        }
        return ch;
    }
public:
    string thirtysixAdd(string A, string B) {
        int m = A.size(), n = B.size();
        int i = m - 1, j = n - 1;
        int carry = 0;
        int x, y;
        string ans;
        while (i >= 0 || j >= 0 || carry > 0) {
            if (i >= 0) {
                x = to_int(A[i]);
            } else {
                x = 0;
            }
            if (j >= 0) {
                y = to_int(B[j]);
            } else {
                y = 0;
            }
            int tmp = x + y + carry;
            ans.push_back(to_char(tmp % 36));
            carry = tmp / 36;
            i--;
            j--;
        }
        reverse(ans.begin(), ans.end());
        return ans;
    }
};
```

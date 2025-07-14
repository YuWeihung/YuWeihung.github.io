---
title: "110：移掉 K 位数字"
date: 2025-07-13T12:37:15+08:00
draft: false
slug: "lc-0402"
categories: ["高频面试题"]
tags: ["单调栈", "贪心"]
---

LeetCode 402

https://leetcode.cn/problems/remove-k-digits/description/

难度：中等

本题需要尽量保证前面的数字最小，这可以使用单调栈来实现。

我们定义一个单调栈，遍历整个数字，当 k > 0 时，对于当前数字，判断是否小于栈顶，否则弹出栈顶元素。这样最后从栈底到栈顶单调不减。

如果最后 k 还是 > 0，那么直接删除最后的 k - m 个元素，因为他们是最大的。

为了生成答案，需要从栈底到栈顶遍历，因此栈使用 vector 来实现。

时间复杂度：O(n)，其中 n 为字符串的长度。

空间复杂度：O(n)。栈存储数字需要线性的空间。

<!--more-->

```cpp
class Solution {
public:
    string removeKdigits(string num, int k) {
        vector<char> stk;
        for (char digit: num) {
            while (k > 0 && !stk.empty() && digit < stk.back()) {
                stk.pop_back();
                k--;
            }
            stk.push_back(digit);
        }

        while (k > 0) {
            stk.pop_back();
            k--;
        }

        string ans = "";
        bool is_leading_zero = true;
        for (auto digit : stk) {
            if (is_leading_zero && digit == '0') {
                continue;
            }
            is_leading_zero = false;
            ans += digit;
        }
        return ans == "" ? "0" : ans;
    }
};
```

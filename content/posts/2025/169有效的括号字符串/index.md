---
title: "169：有效的括号字符串"
date: 2025-07-15T19:02:54+08:00
draft: false
slug: "lc-0678"
categories: ["高频面试题"]
tags: ["栈"]
---

LeetCode 678

https://leetcode.cn/problems/valid-parenthesis-string/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

括号匹配的问题可以用栈求解。

如果字符串中没有星号，则只需要一个栈存储左括号，在从左到右遍历字符串的过程中检查括号是否匹配。

在有星号的情况下，需要两个栈分别存储左括号和星号。从左到右遍历字符串，进行如下操作。

- 如果遇到左括号，则将当前下标存入左括号栈。

- 如果遇到星号，则将当前下标存入星号栈。

- 如果遇到右括号，则需要有一个左括号或星号和右括号匹配，由于星号也可以看成右括号或者空字符串，因此当前的右括号应优先和左括号匹配，没有左括号时和星号匹配：

  - 如果左括号栈不为空，则从左括号栈弹出栈顶元素；

  - 如果左括号栈为空且星号栈不为空，则从星号栈弹出栈顶元素；

  - 如果左括号栈和星号栈都为空，则没有字符可以和当前的右括号匹配，返回 false。

遍历结束之后，左括号栈和星号栈可能还有元素。为了将每个左括号匹配，需要将星号看成右括号，且每个左括号必须出现在其匹配的星号之前。当两个栈都不为空时，每次从左括号栈和星号栈分别弹出栈顶元素，对应左括号下标和星号下标，判断是否可以匹配，匹配的条件是左括号下标小于星号下标，如果左括号下标大于星号下标则返回 false。

最终判断左括号栈是否为空。如果左括号栈为空，则左括号全部匹配完毕，剩下的星号都可以看成空字符串，此时 s 是有效的括号字符串，返回 true。如果左括号栈不为空，则还有左括号无法匹配，此时 s 不是有效的括号字符串，返回 false。

时间复杂度：O(n)，其中 n 是字符串 s 的长度。需要遍历字符串一次，遍历过程中每个字符的操作时间都是 O(1)，遍历结束之后对左括号栈和星号栈弹出元素的操作次数不会超过 n。

空间复杂度：O(n)，其中 n 是字符串 s 的长度。空间复杂度主要取决于左括号栈和星号栈，两个栈的元素总数不会超过 n。

<!--more-->

```cpp
class Solution {
public:
    bool checkValidString(string s) {
        stack<int> leftStack;
        stack<int> asteriskStack;
        int n = s.size();

        for (int i = 0; i < n; i++) {
            char c = s[i];
            if (c == '(') {
                leftStack.push(i);
            } else if (c == '*') {
                asteriskStack.push(i);
            } else {
                if (!leftStack.empty()) {
                    leftStack.pop();
                } else if (!asteriskStack.empty()) {
                    asteriskStack.pop();
                } else {
                    return false;
                }
            }
        }

        while (!leftStack.empty() && !asteriskStack.empty()) {
            int leftIndex = leftStack.top();
            leftStack.pop();
            int asteriskIndex = asteriskStack.top();
            asteriskStack.pop();
            if (leftIndex > asteriskIndex) {
                return false;
            }
        }

        return leftStack.empty();
    }
};
```

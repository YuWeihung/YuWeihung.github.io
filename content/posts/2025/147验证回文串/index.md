---
title: "147：验证回文串"
date: 2025-07-15T19:02:14+08:00
draft: false
slug: "lc-0125"
categories: ["高频面试题"]
tags: ["字符串"]
---

LeetCode 125

https://leetcode.cn/problems/valid-palindrome/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

初始化一左一右两个指针 i=0，j=n−1。其中 n 是 s 的长度。

C++ 判断字符的常用函数如下：

```
1. 判断字符是否为数字：isdigit(c)

2. 判断字符是否为字母或数字：isalnum(c)

3. 判断字符是否为字母：isalpha(c)

4. 判断字符是否为大写字母：isupper(c)

5. 判断字符是否为小写字母：islower(c)

6. 将大写字母转换为小写：tolower(c)

7. 将小写字母转换为大写：toupper(c)
```

分类讨论：

如果 s[i] 既不是字母也不是数字，右移左指针，也就是把 i 加一。
如果 s[j] 既不是字母也不是数字，左移右指针，也就是把 j 减一。
否则，如果 s[i] 和 s[j] 转成小写后相等，那么把 i 加一，把 j 减一，继续判断。
否则，s 不是回文串，返回 false。
循环直到 i≥j 为止。最后返回 true。

时间复杂度：O(n)，其中 n 是 s 的长度。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    bool isPalindrome(string s) {
        int i = 0, j = s.size() - 1;
        while (i < j) {
            if (!isalnum(s[i])) {
                i++;
            } else if (!isalnum(s[j])) {
                j--;
            } else if (tolower(s[i]) == tolower(s[j])) {
                i++;
                j--;
            } else {
                return false;
            }
        }
        return true;
    }
};
```

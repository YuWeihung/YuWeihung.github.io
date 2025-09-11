---
title: "200：压缩字符串"
date: 2025-07-15T19:04:28+08:00
draft: false
slug: "lc-0443"
categories: ["高频面试题"]
tags: ["字符串", "双指针"]
---

LeetCode 443

https://leetcode.cn/problems/string-compression/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

为了实现原地压缩，我们可以使用双指针分别标志我们在字符串中读和写的位置。每次当读指针 read 移动到某一段连续相同子串的最右侧，我们就在写指针 write 处依次写入该子串对应的字符和子串长度即可。

在实际代码中，当读指针 read 位于字符串的末尾，或读指针 read 指向的字符不同于下一个字符时，我们就认为读指针 read 位于某一段连续相同子串的最右侧。该子串对应的字符即为读指针 read 指向的字符串。我们使用变量 left 记录该子串的最左侧的位置，这样子串长度即为 read−left+1。

特别地，为了达到 O(1) 空间复杂度，我们需要自行实现将数字转化为字符串写入到原字符串的功能。这里我们采用短除法将子串长度倒序写入原字符串中，然后再将其反转即可。

时间复杂度：O(n)，其中 n 为字符串长度，我们只需要遍历该字符串一次。

空间复杂度：O(1)。我们只需要常数的空间保存若干变量。

<!--more-->

```cpp
class Solution {
public:
    int compress(vector<char>& chars) {
        int n = chars.size();
        int write = 0, left = 0;
        for (int read = 0; read < n; read++) {
            if (read == n - 1 || chars[read] != chars[read + 1]) {
                chars[write++] = chars[read];
                int num = read - left + 1;
                if (num > 1) {
                    int anchor = write;
                    while (num > 0) {
                        chars[write++] = num % 10 + '0';
                        num /= 10;
                    }
                    reverse(&chars[anchor], &chars[write]);
                }
                left = read + 1;
            }
        }
        return write;
    }
};
```

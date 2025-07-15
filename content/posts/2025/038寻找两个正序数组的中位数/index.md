---
title: "038：寻找两个正序数组的中位数"
date: 2025-06-30T22:16:43+08:00
draft: false
slug: "lc-0004"
categories: ["高频面试题"]
tags: ["二分查找", "复习"]
---

LeetCode 4

https://leetcode.cn/problems/median-of-two-sorted-arrays/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题难度较大。

灵神题解：https://leetcode.cn/problems/median-of-two-sorted-arrays/solutions/2950686/tu-jie-xun-xu-jian-jin-cong-shuang-zhi-z-p2gd/

时间复杂度：O(logmin(m,n))，其中 m 是 a 的长度，n 是 b 的长度。注：这个复杂度比题目所要求的 O(log(m+n)) 更优。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    double findMedianSortedArrays(vector<int>& a, vector<int>& b) {
        if (a.size() > b.size()) {
            swap(a, b);
        }

        int m = a.size(), n = b.size();
        // 循环不变量：a[left] <= b[j+1]
        // 循环不变量：a[right] > b[j+1]
        int left = -1, right = m;
        while (left + 1 < right) { // 开区间 (left, right) 不为空
            int i = (left + right) / 2;
            int j = (m + n + 1) / 2 - i - 2;
            if (a[i] <= b[j + 1]) {
                left = i; // 缩小二分区间为 (i, right)
            } else {
                right = i; // 缩小二分区间为 (left, i)
            }
        }

        // 此时 left 等于 right-1
        // a[left] <= b[j+1] 且 a[right] > b[j'+1] = b[j]，所以答案是 i=left
        int i = left;
        int j = (m + n + 1) / 2 - i - 2;
        int ai = i >= 0 ? a[i] : INT_MIN;
        int bj = j >= 0 ? b[j] : INT_MIN;
        int ai1 = i + 1 < m ? a[i + 1] : INT_MAX;
        int bj1 = j + 1 < n ? b[j + 1] : INT_MAX;
        int max1 = max(ai, bj);
        int min2 = min(ai1, bj1);
        return (m + n) % 2 ? max1 : (max1 + min2) / 2.0;
    }
};
```

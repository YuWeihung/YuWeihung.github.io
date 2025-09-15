---
title: "184：丑数II"
date: 2025-07-15T19:03:29+08:00
draft: false
slug: "lc-0264"
categories: ["高频面试题"]
tags: ["动态规划"]
---

LeetCode 264

https://leetcode.cn/problems/ugly-number-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

定义数组 dp，其中 dp[i] 表示第 i 个丑数，第 n 个丑数即为 dp[n]。

由于最小的丑数是 1，因此 dp[1]=1。

如何得到其余的丑数呢？定义三个指针 p2,p3,p5，表示下一个丑数是当前指针指向的丑数乘以对应的质因数。初始时，三个指针的值都是 1。

当 2≤i≤n 时，令 dp[i]=min(dp[p2]×2,dp[p3]×3,dp[p5]×5)，然后分别比较 dp[i] 和 dp[p2]×2,dp[p3]×3,dp[p5]×5 是否相等，如果相等则将对应的指针加 1。

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

<!--more-->

```cpp
class Solution {
public:
    int nthUglyNumber(int n) {
        vector<int> f(n + 1);
        f[1] = 1;
        int p2 = 1, p3 = 1, p5 = 1;
        for (int i = 2; i <= n; i++) {
            int num2 = f[p2] * 2, num3 = f[p3] * 3, num5 = f[p5] * 5;
            f[i] = min({num2, num3, num5});
            if (f[i] == num2) {
                p2++;
            }
            if (f[i] == num3) {
                p3++;
            }
            if (f[i] == num5) {
                p5++;
            }
        }
        return f[n];
    }
};
```

---
title: "163：圆圈中最后剩下的数字"
date: 2025-07-15T19:02:41+08:00
draft: false
slug: "lcr-0187"
categories: ["高频面试题"]
tags: ["动态规划"]
---

LCR 187

https://leetcode.cn/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

动态规划。状态转移方程 f[i] = (f[i - 1] + target) % i。

时间复杂度 O(n) ： 状态转移循环 n − 1 次使用 O(n) 时间，状态转移方程计算使用 O(1) 时间；

空间复杂度 O(1) ： 使用常数大小的额外空间；

<!--more-->

```cpp
class Solution {
public:
    int iceBreakingGame(int num, int target) {
        int f = 0;
        for (int i = 2; i <= num; i++) {
            f = (f + target) % i;
        }
        return f;
    }
};
```

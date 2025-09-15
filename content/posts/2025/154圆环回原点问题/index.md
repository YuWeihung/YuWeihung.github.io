---
title: "154：圆环回原点问题"
date: 2025-07-15T19:02:25+08:00
draft: false
slug: "nc-0311"
categories: ["高频面试题"]
tags: ["动态规划"]
---

NowCoder 311

https://www.nowcoder.com/practice/16409dd00ab24a408ddd0c46e49ddcf8

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

1. ​ 问题分析 ​：圆环有 10 个点（0 到 9），从点 0 出发，每次移动可以到相邻的点（顺时针或逆时针）。要求恰好 n 步后回到点 0 的方法数。
2. 动态规划设置 ​：使用一个数组 curr 来保存当前步数下到达每个点的方案数。初始时，curr[0] = 1，表示 0 步时在原点。
3. ​ 状态转移 ​：对于每一步，计算下一步到达每个点的方案数。每个点可以从其相邻的两个点转移过来，即 next[j] = curr[left] + curr[right]，其中 left 和 right 是 j 的相邻点。
4. 模数处理 ​：由于结果可能非常大，每次加法后对 MOD 取模。
5. 结果提取 ​：经过 n 步后，curr[0]即为回到原点的方法数。

<!--more-->

```cpp
class Solution {
public:
    int circle(int n) {
        const int MOD = 1e9 + 7;
        vector f(n + 1, vector<int>(10, 0));
        f[0][0] = 1;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < 10; j++) {
                f[i + 1][j] = (f[i][(j - 1 + 10) % 10] + f[i][(j + 1) % 10]) % MOD;
            }
        }
        return f[n][0];
    }
};
```

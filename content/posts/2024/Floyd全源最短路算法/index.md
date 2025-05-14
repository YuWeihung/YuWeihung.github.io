---
title: "Floyd全源最短路算法"
date: 2024-04-14T20:11:47+08:00
draft: false
slug: "floyd"
categories: ["算法题"]
tags: ["图论", "最短路"]
---

之前介绍了 Dijkstra 单源最短路算法，本文介绍 Floyd 全源最短路算法。例题： LeetCode 1334 阈值距离内邻居最少的城市。

<!--more-->

```cpp
class Solution {
public:
    int findTheCity(int n, vector<vector<int>>& edges, int distanceThreshold) {
        vector f(n, vector<int>(n, INT_MAX / 2));
        for (auto &e: edges) {
            int x = e[0], y = e[1], wt = e[2];
            f[x][y] = f[y][x] = wt;
        }

        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    f[i][j] = min(f[i][j], f[i][k] + f[k][j]);
                }
            }
        }

        int ans = 0;
        int min_cnt = n;
        for (int i = 0; i < n; i++) {
            int cnt = 0;
            for (int j= 0; j < n; j++) {
                if (j != i && f[i][j] <= distanceThreshold) {
                    cnt++;
                }
            }
            if (cnt <= min_cnt) {
                min_cnt = cnt;
                ans = i;
            }
        }
        return ans;
    }
};
```

Floyd 算法的核心代码非常简单，就是上文的三重循环。因此时间复杂度为 \(O(n^3)\)。需要注意的是，必须在最外层循环枚举 k。

之前介绍的朴素 Dijkstra 算法的时间复杂度为 \(O(n^2)\)，执行 n 次也不过 \(O(n^3)\)，那么 Floyd 算法的优势是什么呢？

第一，当然是 Floyd 的代码更加简单；第二，也是最为重要的一点，Dijsktra 无法处理具有负权边的情况，而 FLoyd 可以处理负权边，但不能处理负环。

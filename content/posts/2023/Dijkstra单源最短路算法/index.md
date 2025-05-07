---
title: "Dijkstra 单源最短路算法"
date: 2023-10-07T11:54:32+08:00
draft: false
slug: "dijkstra"
categories: ["算法题"]
tags: ["图论", "最短路"]
---

本文介绍一种最常用的求单源最短路的算法 Dijkstra。例题：洛谷 P4779 【模板】单源最短路径（标准版）。

<!--more-->

### 1. 邻接矩阵 + 朴素 Dijkstra

点的个数为 n，边的个数为 m。该算法的时间复杂度为 \(O(n^2)\)，对于这道题会超时。空间复杂度为 \(O(n^2)\)。

```cpp
#include <climits>
#include <iostream>
#include <vector>

using namespace std;

int main() {
    int n, m, s;
    cin >> n >> m >> s;

    // 初始化邻接矩阵
    vector g(n, vector<int>(n, INT_MAX / 2));

    // 读入边并保留最小边权
    for (int i = 0; i < m; i++) {
        int u, v, w;
        cin >> u >> v >> w;
        g[u - 1][v - 1] = min(g[u - 1][v - 1], w);
    }

    // Dijkstra算法
    vector<int> dis(n, INT_MAX / 2);
    vector<int> vis(n);
    dis[s - 1] = 0;

    while (true) {
        int x = -1;
        for (int i = 0; i < n; i++) {
            if (vis[i] == 0 && (x < 0 || dis[i] < dis[x])) {
                x = i;
            }
        }
        if (x < 0 || dis[x] == INT_MAX / 2) {
            break;
        }
        vis[x] = 1;
        for (int y = 0; y < n; y++) {
            dis[y] = min(dis[y], dis[x] + g[x][y]);
        }
    }

    // 输出结果
    for (int i = 0; i < n; i++) {
        cout << (dis[i] < INT_MAX / 2 ? dis[i] : INT_MAX) << " ";
    }
    cout << "\n";

    return 0;
}
```

### 2. 邻接表 + 堆优化的 Dijkstra

时间复杂度为 \(O(m\log m)\)，空间复杂度为 \(O(m)\)。

```cpp
#include <climits>
#include <iostream>
#include <queue>
#include <vector>

using namespace std;

const int INF = 0x7fffffff;

int main() {
    int n, m, s;
    cin >> n >> m >> s;

    // 初始化邻接表
    vector<vector<pair<int, int>>> g(n);

    // 读入边并保留最小边权
    for (int i = 0; i < m; ++i) {
        int u, v, w;
        cin >> u >> v >> w;
        g[u - 1].emplace_back(v - 1, w);
    }

    // Dijkstra算法
    vector<int> dis(n, INF);
    dis[s - 1] = 0;
    priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>>
        pq;
    pq.emplace(0, s - 1);
    while (!pq.empty()) {
        auto [dx, x] = pq.top();
        pq.pop();
        if (dx > dis[x]) {
            continue;
        }
        for (auto &[y, d] : g[x]) {
            int new_dis = dx + d;
            if (new_dis < dis[y]) {
                dis[y] = new_dis;
                pq.emplace(new_dis, y);
            }
        }
    }

    // 输出结果
    for (int i = 0; i < n; ++i) {
        cout << dis[i] << " ";
    }
    cout << "\n";

    return 0;
}
```

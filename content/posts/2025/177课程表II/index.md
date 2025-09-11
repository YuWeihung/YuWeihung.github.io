---
title: "177：课程表II"
date: 2025-07-15T19:03:12+08:00
draft: false
slug: "lc-0210"
categories: ["高频面试题"]
tags: ["图论", "拓扑排序"]
---

LeetCode 210

https://leetcode.cn/problems/course-schedule-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

拓扑排序，每次将入度为 0 的节点加入队列。

时间复杂度: O(n+m)，其中 n 为课程数，m 为先修课程的要求数。

空间复杂度: O(n+m)。

<!--more-->

```cpp
class Solution {
public:
    vector<int> findOrder(int n, vector<vector<int>>& prerequisites) {
        vector<vector<int>> g(n);
        vector<int> in_deg(n);
        for (auto& e : prerequisites) {
            int x = e[0], y = e[1];
            g[y].push_back(x);
            in_deg[x]++; // 统计 x 的先修课数量
        }

        queue<int> q;
        for (int i = 0; i < n; i++) {
            if (in_deg[i] == 0) { // 没有先修课，可以直接上
                q.push(i);        // 加入学习队列
            }
        }

        vector<int> topo_order;
        while (!q.empty()) {
            int x = q.front();
            q.pop();
            topo_order.push_back(x);
            for (int y : g[x]) {
                in_deg[y]--;          // 修完 x 后，y 的先修课数量减一
                if (in_deg[y] == 0) { // y 的先修课全部上完
                    q.push(y);        // 加入学习队列
                }
            }
        }

        if (topo_order.size() < n) { // 图中有环
            return {};
        }
        return topo_order;
    }
};
```

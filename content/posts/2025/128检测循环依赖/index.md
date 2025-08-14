---
title: "128：检测循环依赖"
date: 2025-07-15T19:01:46+08:00
draft: false
slug: "addtion-23"
categories: ["高频面试题"]
tags: ["图论", "拓扑排序"]
---

补充题 23

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

三色染色法，拓扑排序，检测是否有环。

时间复杂度：O(n+m)，其中 n 是 numCourses，m 是 prerequisites 的长度。每个节点至多递归访问一次，每条边至多遍历一次。

空间复杂度：O(n+m)。存储 g 需要 O(n+m) 的空间。

<!--more-->

```cpp
class Solution {
public:
    vector<int> findOrder(int numCourses, vector<vector<int>>& prerequisites) {
        vector<vector<int>> g(numCourses);
        for (auto &p: prerequisites) {
            g[p[1]].push_back(p[0]);
        }

        vector<int> colors(numCourses);
        vector<int> ans;

        auto dfs = [&](auto &&dfs, int x) -> bool {
            colors[x] = 1;
            for (int y: g[x]) {
                if (colors[y] == 1 || (colors[y] == 0 && dfs(dfs, y))) {
                    return true;
                }
            }
            colors[x] = 2;
            ans.push_back(x);
            return false;
        };

        for (int i = 0; i < numCourses; i++) {
            if (colors[i] == 0 && dfs(dfs, i)) {
                return {};
            }
        }
        reverse(ans.begin(), ans.end());
        return ans;
    }
};
```

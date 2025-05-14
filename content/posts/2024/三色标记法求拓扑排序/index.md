---
title: "三色标记法求拓扑排序"
date: 2024-05-14T21:11:10+08:00
draft: false
slug: "tyopological-order"
categories: ["算法题"]
tags: ["图论", "拓扑排序"]
---

本文介绍用三色标记法求拓扑排序。例题：LeetCode 210 课程表 II。

<!--more-->

对于每个节点 x，都定义三种颜色值：

- 0：x 尚未被访问到。
- 1：x 正在被访问，dfs(x) 尚未结束。
- 2：x 已访问完毕，dfs(x) 已返回。

算法流程：

1. 所有元素颜色值初始化为 0。
2. 遍历 colors，如果 colors[i] = 0，调用 dfs(i)。
3. 执行 dfs(x)：
   - 首先标记 color[x] = 1，表示 x 正在访问中。
   - 然后遍历 x 的邻居 y。如果 color[y] = 1，则找到环，返回 true。如果 color[y] = 0 且 dfs(y) 返回 true，那么 dfs(x) 也返回 true。
   - 如果没有找到环，先标记 color[x] = 2，表示 x 已访问完毕，然后将 x 压入栈中，最后返回 false。
4. 从栈顶到栈底就是一个拓扑顺序，将数组反转就得到答案。

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

        // dfs 返回值为是否有环
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

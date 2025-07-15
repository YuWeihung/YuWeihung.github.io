---
title: "107：课程表"
date: 2025-07-13T12:37:15+08:00
draft: false
slug: "lc-0207"
categories: ["高频面试题"]
tags: ["DFS", "图论"]
---

LeetCode 207

https://leetcode.cn/problems/course-schedule/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

三色标记法找环。

对于每个节点 x，都定义三种颜色值：

- 0：x 尚未被访问到。
- 1：x 正在被访问，dfs(x) 尚未结束。
- 2：x 已访问完毕，dfs(x) 已返回。

如果在递归过程中，发现下一个节点在递归栈中（正在访问中），则找到了环。

时间复杂度：O(n+m)，其中 n 是 numCourses，m 是 prerequisites 的长度。每个节点至多递归访问一次，每条边至多遍历一次。

空间复杂度：O(n+m)。存储 g 需要 O(n+m) 的空间。

<!--more-->

```cpp
class Solution {
public:
    bool canFinish(int numCourses, vector<vector<int>>& prerequisites) {
        vector<vector<int>> g(numCourses);
        for (auto& p : prerequisites) {
            g[p[1]].push_back(p[0]);
        }

        vector<int> colors(numCourses);
        // 返回 true 表示找到了环
        auto dfs = [&](this auto&& dfs, int x) -> bool {
            colors[x] = 1; // x 正在访问中
            for (int y : g[x]) {
                if (colors[y] == 1 || colors[y] == 0 && dfs(y)) {
                    return true; // 找到了环
                }
            }
            colors[x] = 2; // x 完全访问完毕
            return false; // 没有找到环
        };

        for (int i = 0; i < numCourses; i++) {
            if (colors[i] == 0 && dfs(i)) {
                return false; // 有环
            }
        }
        return true; // 没有环
    }
};
```

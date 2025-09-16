---
title: "180：加油站"
date: 2025-07-15T19:03:18+08:00
draft: false
slug: "lc-0134"
categories: ["高频面试题"]
tags: ["贪心"]
---

LeetCode 134

https://leetcode.cn/problems/gas-station/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

如果 gas 之和小于 cost 之和，那么答案不存在。从示例 1 的计算过程可以发现，我们可以先计算从 0 号加油站出发的油量变化，然后从中找到油量最低时所处的加油站（3 号加油站），即为答案。

时间复杂度：O(n)，其中 n 是 gas 的长度。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int canCompleteCircuit(vector<int>& gas, vector<int>& cost) {
        int ans = 0, min_s = 0, s = 0; // s 表示油量，min_s 表示最小油量
        for (int i = 0; i < gas.size(); i++) {
            s += gas[i] - cost[i]; // 在 i 处加油，然后从 i 到 i+1
            if (s < min_s) {
                min_s = s; // 更新最小油量
                ans = i + 1; // 注意 s 减去 cost[i] 之后，汽车在 i+1 而不是 i
            }
        }
        // 循环结束后，s 即为 gas 之和减去 cost 之和
        return s < 0 ? -1 : ans;
    }
};
```

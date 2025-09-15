---
title: "188：会议室II"
date: 2025-07-15T19:03:41+08:00
draft: false
slug: "lc-0253"
categories: ["高频面试题"]
tags: ["差分"]
---

LeetCode 253

https://www.lintcode.com/problem/919/description

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

给定一系列的会议时间间隔 intervals，包括起始和结束时间[[s1,e1],[s2,e2],...] (si < ei)，找到所需的最小的会议室数量。

样例：

```
输入: intervals = [(0,30),(5,10),(15,20)]
输出: 2
解释:
需要两个会议室
会议室1:(0,30)
会议室2:(5,10),(15,20)
```

本题考查差分。定义差分数组 diff，对于每个会议，diff[start]++，diff[end]--，然后对 diff 做前缀和，s 的值就是当前需要会议室的数量，s 的最大值就是答案。

时间复杂度：O(n)

空间复杂度：O(n)

<!--more-->

```cpp
class Solution {
public:
    int minMeetingRooms(vector<Interval> &intervals) {
        int n = intervals.size();
        int mx = 0;
        for (auto p: intervals) {
            mx = max(mx, p.end);
        }
        vector<int> diff(mx + 1, 0);
        for (auto &p: intervals) {
            int s = p.start, e = p.end;
            diff[s]++;
            diff[e]--;
        }
        int s = 0;
        int ans = 0;
        for (int x: diff) {
            s += x;
            ans = max(ans, s);
        }
        return ans;
    }
};
```

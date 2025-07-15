---
title: "028：合并区间"
date: 2025-06-29T21:19:52+08:00
draft: false
slug: "lc-0056"
categories: ["高频面试题"]
tags: ["排序"]
---

LeetCode 56

https://leetcode.cn/problems/merge-intervals/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

首先将数组按照左端点进行排序，然后如果当前区间左端点 <= 答案中最后一个合并区间的右端点，更新答案区间右端点为两者较大值；反之将当前区间加入答案。

时间复杂度：O(nlogn)，其中 n 是 intervals 的长度。瓶颈在排序上。

空间复杂度：O(1)。排序的栈开销和返回值不计入。

<!--more-->

```cpp
class Solution {
public:
    vector<vector<int>> merge(vector<vector<int>>& intervals) {
        sort(intervals.begin(), intervals.end());
        vector<vector<int>> ans;
        for (auto &p: intervals) {
            if (!ans.empty() && p[0] <= ans.back()[1]) {
                ans.back()[1] = max(ans.back()[1], p[1]);
            } else {
                ans.emplace_back(p);
            }
        }
        return ans;
    }
};
```

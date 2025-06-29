---
title: "024：最长上升子序列"
date: 2025-06-29T19:33:25+08:00
draft: false
slug: "lc-0300"
categories: ["高频面试题"]
tags: ["动态规划", "贪心", "二分查找"]
---

LeetCode 300

https://leetcode.cn/problems/longest-increasing-subsequence/description/

难度：中等

本题求最长上升子序列（LIS）有两种做法，分别是动态规划和贪心。

<!--more-->

动态规划：

f[i] 表示以 i 结尾的 LIS。

f[i] = max(f[j]) + 1, j < i && nums[j] < nums[i]

时间复杂度：\(O(n^2)\)，其中 n 为 nums 的长度。

空间复杂度：O(n)。

```cpp
class Solution {
public:
    int lengthOfLIS(vector<int>& nums) {
        int n = nums.size();
        vector<int> f(n, 0);
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[j] < nums[i]) {
                    f[i] = max(f[i], f[j]);
                }
            }
            f[i]++;
        }
        return *max_element(f.begin(), f.end());
    }
};
```

贪心：

g[i] 长为 i + 1 的上升子序列的末尾元素最小值。对于 nums 中的每一个元素 x，如果在 g 中可以找到比他大的元素，那么将这个元素更新为 x。如果 x 比所有元素都大，那么把 x 加到 g 的末尾，子序列长度加一。这个查找的过程可以用二分查找来实现。

时间复杂度：O(nlogn)，其中 n 为 nums 的长度。

空间复杂度：O(n)。

```cpp
class Solution {
public:
    int lengthOfLIS(vector<int>& nums) {
        vector<int> g;

        auto lower_bound = [&](int x) {
            int left = -1, right = g.size();
            while (left + 1 < right) {
                int mid = left + (right - left) / 2;
                if (g[mid] >= x) {
                    right = mid;
                } else {
                    left = mid;
                }
            }
            return right;
        };

        for (int x: nums) {
            int idx = lower_bound(x);
            if (idx == g.size()) {
                g.push_back(x);
            } else {
                g[idx] = x;
            }
        }
        return g.size();
    }
};
```

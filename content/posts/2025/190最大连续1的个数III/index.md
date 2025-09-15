---
title: "190：最大连续1的个数III"
date: 2025-07-15T19:03:46+08:00
draft: false
slug: "lc-1004"
categories: ["高频面试题"]
tags: ["滑动窗口"]
---

LeetCode 1004

https://leetcode.cn/problems/max-consecutive-ones-iii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

统计窗口内 0 的个数 cnt0，则问题转化成在 cnt0 ≤k 的前提下，窗口大小的最大值。

时间复杂度：O(n)，其中 n 为 nums 的长度。证明方式见视频讲解。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int longestOnes(vector<int>& nums, int k) {
        int ans = 0, left = 0, cnt0 = 0;
        for (int right = 0; right < nums.size(); right++) {
            cnt0 += 1 - nums[right]; // 0 变成 1，用来统计 cnt0
            while (cnt0 > k) {
                cnt0 -= 1 - nums[left];
                left++;
            }
            ans = max(ans, right - left + 1);
        }
        return ans;
    }
};
```

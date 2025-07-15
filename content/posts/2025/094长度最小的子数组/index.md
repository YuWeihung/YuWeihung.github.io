---
title: "094：长度最小的子数组"
date: 2025-07-06T13:21:08+08:00
draft: false
slug: "lc-0209"
categories: ["高频面试题"]
tags: ["滑动窗口"]
---

LeetCode 209

https://leetcode.cn/problems/minimum-size-subarray-sum/description/

难度：209

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

满足单调性，可以使用滑动窗口。

时间复杂度：O(n)，其中 n 为 nums 的长度。虽然写了个二重循环，但是内层循环中对 left 加一的总执行次数不会超过 n 次，所以总的时间复杂度为 O(n)。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    int minSubArrayLen(int target, vector<int>& nums) {
        int n = nums.size(), ans = n + 1, sum = 0, left = 0;
        for (int right = 0; right < n; right++) { // 枚举子数组右端点
            sum += nums[right];
            while (sum - nums[left] >= target) { // 尽量缩小子数组长度
                sum -= nums[left];
                left++; // 左端点右移
            }
            if (sum >= target) {
                ans = min(ans, right - left + 1);
            }
        }
        return ans <= n ? ans : 0;
    }
};
```

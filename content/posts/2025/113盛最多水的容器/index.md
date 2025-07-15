---
title: "113：盛最多水的容器"
date: 2025-07-15T19:01:28+08:00
draft: false
slug: "lc-0011"
categories: ["高频面试题"]
tags: ["双指针", "相向双指针"]
---

LeetCode 11

https://leetcode.cn/problems/container-with-most-water/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

相向双指针。容器的容积是由左右两端较低的一方决定的。如果保留较低的一端，另一端相向移动。假设新的另一端比他要高，那么最低的还是他，宽度变小了，容积也变小了。假设另一端比他还低，那么宽度变小了，高度也变小了，容积还是变小。因此如果要得到更大的容积，就不能保留较低的一端，需要移动他。

时间复杂度：O(n)，其中 n 为 height 的长度。

空间复杂度：O(1)，仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    int maxArea(vector<int>& height) {
        int ans = 0, left = 0, right = height.size() - 1;
        while (left < right) {
            int area = (right - left) * min(height[left], height[right]);
            ans = max(ans, area);
            height[left] < height[right] ? left++ : right--;
        }
        return ans;
    }
};
```

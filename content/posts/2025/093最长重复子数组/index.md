---
title: "093：最长重复子数组"
date: 2025-07-06T13:20:26+08:00
draft: false
slug: "lc-0718"
categories: ["高频面试题"]
tags: ["动态规划", "线性DP"]
---

LeetCode 718

https://leetcode.cn/problems/maximum-length-of-repeated-subarray/description/

难度：中等

类似最长公共子序列，这题是求连续子数组。定义 f[i+1][j+1] 表示以 nums1[i] 结尾的子数组和以 nums2[j] 结尾的子数组的最长公共子数组的长度。

如果 nums1[i] != nums2[j]，那么 f[i+1][j+1]=0。

如果 nums1[i] == nums2[j]，那么问题变成以 nums1[i−1] 结尾的子数组和以 nums2[j−1] 结尾的子数组的最长公共子数组的长度，即 f[i+1][j+1]=f[i][j]+1。相当于在以 nums1[i−1] 结尾的子数组后面添加 nums1[i]，在以 nums2[j−1] 结尾的子数组后面添加 nums2[j]。

初始值：f[0][j]=f[i][0]=0，空子数组没有公共部分。

答案：所有 f[i][j] 的最大值。

时间复杂度：O(nm)，其中 n 是 nums1 的长度，m 是 nums2 的长度。
空间复杂度：O(nm)。

<!--more-->

```cpp
class Solution {
public:
    int findLength(vector<int>& nums1, vector<int>& nums2) {
        int n = nums1.size(), m = nums2.size(), ans = 0;
        vector f(n + 1, vector<int>(m + 1));
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (nums1[i] == nums2[j]) {
                    f[i + 1][j + 1] = f[i][j] + 1; // 递推关系
                    ans = max(ans, f[i + 1][j + 1]);
                }
            }
        }
        return ans;
    }
};
```

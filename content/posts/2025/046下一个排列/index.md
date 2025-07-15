---
title: "046：下一个排列"
date: 2025-07-01T20:09:01+08:00
draft: false
slug: "lc-0031"
categories: ["高频面试题"]
tags: ["思维题"]
---

LeetCode 31

https://leetcode.cn/problems/next-permutation/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

1. 从右向左，找第一个小于右侧相邻数字的数 x
2. 找 x 右边最小的大于 x 的数 y，交换 x 和 y
3. 反转 y 右边的数，把右边的数变成最小的排列

时间复杂度：O(n)，其中 n 是 nums 的长度。最坏情况下需要遍历整个 nums 数组。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    void nextPermutation(vector<int>& nums) {
        int n = nums.size();

        // 第一步：从右向左找到第一个小于右侧相邻数字的数 nums[i]
        int i = n - 2;
        while (i >= 0 && nums[i] >= nums[i + 1]) {
            i--;
        }

        // 如果找到了，进入第二步；否则跳过第二步，反转整个数组
        if (i >= 0) {
            // 第二步：从右向左找到 nums[i] 右边最小的大于 nums[i] 的数 nums[j]
            int j = n - 1;
            while (nums[j] <= nums[i]) {
                j--;
            }
            // 交换 nums[i] 和 nums[j]
            swap(nums[i], nums[j]);
        }

        // 第三步：反转 nums[i+1:]（如果上面跳过第二步，此时 i = -1）
        reverse(nums.begin() + i + 1, nums.end());
    }
};
```

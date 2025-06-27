---
title: "006：三数之和"
date: 2025-06-27T12:50:03+08:00
draft: false
slug: "lc-0015"
categories: ["高频面试题"]
tags: ["相向双指针"]
---

LeetCode 15

https://leetcode.cn/problems/3sum/description/

难度：中等

首先，由于输出的顺序不重要，可以先将数组进行排序。然后，枚举第一个数，转化为两数之和 II（LeetCode 142）。为了排除重复答案，如果 i，j，k 与上一个元素相同，需要去重。

时间复杂度：O(\(n^ 2\))，其中 n 为 nums 的长度。排序 O(nlogn)。外层循环枚举第一个数，就变成 167. 两数之和 II - 输入有序数组 了，做法是 O(n) 双指针。所以总的时间复杂度为 O(\(n^ 2\))。

空间复杂度：O(1)。返回值不计入。忽略排序的栈开销。

<!--more-->

```cpp
class Solution {
public:
    vector<vector<int>> threeSum(vector<int>& nums) {
        ranges::sort(nums);
        vector<vector<int>> ans;
        int n = nums.size();
        for (int i = 0; i < n - 2; i++) {
            int x = nums[i];
            if (i && x == nums[i - 1]) continue; // 跳过重复数字
            if (x + nums[i + 1] + nums[i + 2] > 0) break; // 优化一
            if (x + nums[n - 2] + nums[n - 1] < 0) continue; // 优化二
            int j = i + 1, k = n - 1;
            while (j < k) {
                int s = x + nums[j] + nums[k];
                if (s > 0) {
                    k--;
                } else if (s < 0) {
                    j++;
                } else { // 三数之和为 0
                    ans.push_back({x, nums[j], nums[k]});
                    for (j++; j < k && nums[j] == nums[j - 1]; j++); // 跳过重复数字
                    for (k--; k > j && nums[k] == nums[k + 1]; k--); // 跳过重复数字
                }
            }
        }
        return ans;
    }
};
```

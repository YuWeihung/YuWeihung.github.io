---
title: "123：最接近的三数之和"
date: 2025-07-15T19:01:40+08:00
draft: false
slug: "lc-0016"
categories: ["高频面试题"]
tags: ["双指针"]
---

LeetCode 16

https://leetcode.cn/problems/3sum-closest/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题比三数之和增加了一个 min_diff 变量维护 |s - target| 最小值。

时间复杂度：\(O(n^2)\)，其中 n 为 nums 的长度。排序 O(nlogn)。外层循环枚举第一个数，然后 O(n) 双指针。所以总的时间复杂度为 \(O(n^2)\)。

空间复杂度：O(1)。返回值不计入，忽略排序的栈开销。

<!--more-->

```cpp
class Solution {
public:
    int threeSumClosest(vector<int>& nums, int target) {
        ranges::sort(nums);
        int ans, n = nums.size();
        int min_diff = INT_MAX;
        for (int i = 0; i < n - 2; i++) {
            int x = nums[i];
            if (i > 0 && x == nums[i - 1]) {
                continue; // 优化三
            }

            // 优化一
            int s = x + nums[i + 1] + nums[i + 2];
            if (s > target) { // 后面无论怎么选，选出的三个数的和不会比 s 还小
                if (s - target < min_diff) {
                    ans = s; // 由于下面直接 break，这里无需更新 min_diff
                }
                break;
            }

            // 优化二
            s = x + nums[n - 2] + nums[n - 1];
            if (s < target) { // x 加上后面任意两个数都不超过 s，所以下面的双指针就不需要跑了
                if (target - s < min_diff) {
                    min_diff = target - s;
                    ans = s;
                }
                continue;
            }

            // 双指针
            int j = i + 1, k = n - 1;
            while (j < k) {
                s = x + nums[j] + nums[k];
                if (s == target) {
                    return target;
                }
                if (s > target) {
                    if (s - target < min_diff) { // s 与 target 更近
                        min_diff = s - target;
                        ans = s;
                    }
                    k--;
                } else { // s < target
                    if (target - s < min_diff) { // s 与 target 更近
                        min_diff = target - s;
                        ans = s;
                    }
                    j++;
                }
            }
        }
        return ans;
    }
};
```

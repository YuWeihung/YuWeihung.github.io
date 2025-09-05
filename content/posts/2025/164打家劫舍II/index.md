---
title: "164：打家劫舍II"
date: 2025-07-15T19:02:43+08:00
draft: false
slug: "lc-0213"
categories: ["高频面试题"]
tags: ["动态规划", "线性DP"]
---

LeetCode 213

https://leetcode.cn/problems/house-robber-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

分类讨论，考虑是否偷 nums[0]：

- 如果偷 nums[0]，那么 nums[1] 和 nums[n−1] 不能偷，问题变成从 nums[2] 到 nums[n−2] 的非环形版本，调用 198 题的代码解决；
- 如果不偷 nums[0]，那么问题变成从 nums[1] 到 nums[n−1] 的非环形版本，同样调用 198 题的代码解决。

这两种方案覆盖了所有情况（毕竟 nums[0] 只有偷与不偷，没有第三种选择），所以取两种方案的最大值，即为答案。

时间复杂度：O(n)。其中 n 为 nums 的长度。

空间复杂度：O(1)。仅用到若干额外变量。为了写起来方便，Python 和 JS 使用了切片（忽略带来的空间），不使用切片的写法请参考其它语言。

<!--more-->

```cpp
class Solution {
    // 198. 打家劫舍
    int rob1(vector<int> &nums, int start, int end) { // [start,end) 左闭右开
        int f0 = 0, f1 = 0;
        for (int i = start; i < end; i++) {
            int new_f = max(f1, f0 + nums[i]);
            f0 = f1;
            f1 = new_f;
        }
        return f1;
    }

public:
    int rob(vector<int> &nums) {
        int n = nums.size();
        return max(nums[0] + rob1(nums, 2, n - 1), rob1(nums, 1, n));
    }
};
```

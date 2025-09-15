---
title: "176：有效三角形的个数"
date: 2025-07-15T19:03:09+08:00
draft: false
slug: "lc-0611"
categories: ["高频面试题"]
tags: ["双指针"]
---

LeetCode 611

https://leetcode.cn/problems/valid-triangle-number/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

为了能够使用相向双指针，先对数组从小到大排序，然后枚举最长边。因为如果枚举最短边，当 a + b < c 时，增大 b 或 减少 c 都可以满足条件，无法知道移动哪一个指针。

外层循环枚举最长边 c=nums[k]，内层循环用相向双指针枚举 a=nums[i] 和 b=nums[j]，具体如下：

1. 初始化左右指针 i=0, j=k−1。
2. 如果 nums[i]+nums[j]>c，由于数组是有序的，nums[j] 与下标 i′ 在 [i,j−1] 中的任何 nums[i′] 相加，都是 >c 的，因此直接找到了 j−i 个合法方案，加到答案中，然后将 j 减一。
3. 如果 nums[i]+nums[j]≤c，由于数组是有序的，nums[i] 与下标 j′ 在 [i+1,j] 中的任何 nums[j′] 相加，都是 ≤c 的，因此后面无需考虑 nums[i]，将 i 加一。
4. 重复上述过程直到 i≥j 为止。

时间复杂度：O(n^2)，其中 n 为 nums 的长度。

空间复杂度：O(1)。忽略排序的栈开销。

<!--more-->

```cpp
class Solution {
public:
    int triangleNumber(vector<int>& nums) {
        ranges::sort(nums);
        int ans = 0;
        for (int k = 2; k < nums.size(); k++) {
            int c = nums[k];
            int i = 0; // a=nums[i]
            int j = k - 1; // b=nums[j]
            while (i < j) {
                if (nums[i] + nums[j] > c) {
                    // 由于 nums 已经从小到大排序
                    // nums[i]+nums[j] > c 同时意味着：
                    // nums[i+1]+nums[j] > c
                    // nums[i+2]+nums[j] > c
                    // ...
                    // nums[j-1]+nums[j] > c
                    // 从 i 到 j-1 一共 j-i 个
                    ans += j - i;
                    j--;
                } else {
                    // 由于 nums 已经从小到大排序
                    // nums[i]+nums[j] <= c 同时意味着
                    // nums[i]+nums[j-1] <= c
                    // ...
                    // nums[i]+nums[i+1] <= c
                    // 所以在后续的内层循环中，nums[i] 不可能作为三角形的边长，没有用了
                    i++;
                }
            }
        }
        return ans;
    }
};
```

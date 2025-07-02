---
title: "056：缺失的第一个正数"
date: 2025-07-02T23:56:07+08:00
draft: false
slug: "lc-0041"
categories: ["高频面试题"]
tags: ["思维题"]
---

LeetCode 41

https://leetcode.cn/problems/first-missing-positive/description/

难度：困难

灵神题解：https://leetcode.cn/problems/first-missing-positive/solutions/3655377/huan-zuo-wei-tong-guo-li-zi-li-jie-suan-qa94e/

一般地，为了兼容「当前学生是真身，坐在正确的座位上」和「当前学生是影分身，且其真身坐在正确的座位上」两种情况，我们可以把 i=nums[i] 套一层 nums，用 nums[i]=nums[nums[i]] 判断。

无论「当前学生是真身，坐在正确的座位上」还是「当前学生是影分身，且其真身坐在正确的座位上」，上式都是成立的。

如果「当前学生是真身，不坐在正确的座位上」，那么上式左边是当前学生的学号，右边是要交换的学生的学号。

如果「当前学生是影分身，且其真身不坐在正确的座位上」，那么上式左边是当前学生的学号，右边是要交换的学生的学号。虽然是用影分身交换的，但交换后，可以认为真身已经坐在了正确的座位上。

代码实现时，由于 nums 的下标是从 0 开始的，通过学号访问下标，要把学号减一。

时间复杂度：O(n)，其中 n 是 nums 的长度。虽然我们写了个二重循环，但每次交换都会把一个学生换到正确的座位上，所以总交换次数至多为 n，所以内层循环的总循环次数是 O(n) 的，所以时间复杂度是 O(n)。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int firstMissingPositive(vector<int>& nums) {
        int n = nums.size();
        for (int i = 0; i < n; i++) {
            // 如果当前学生的学号在 [1,n] 中，但（真身）没有坐在正确的座位上
            while (1 <= nums[i] && nums[i] <= n && nums[i] != nums[nums[i] - 1]) {
                // 那么就交换 nums[i] 和 nums[j]，其中 j 是 i 的学号
                int j = nums[i] - 1; // 减一是因为数组下标从 0 开始
                swap(nums[i], nums[j]);
            }
        }

        // 找第一个学号与座位编号不匹配的学生
        for (int i = 0; i < n; i++) {
            if (nums[i] != i + 1) {
                return i + 1;
            }
        }

        // 所有学生都坐在正确的座位上
        return n + 1;
    }
};
```

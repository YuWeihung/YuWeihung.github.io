---
title: "100：手撕堆排序"
date: 2025-07-06T13:22:02+08:00
draft: false
slug: "lc-0912-2"
categories: ["高频面试题"]
tags: ["排序", "堆排序"]
---

LeetCode 912

https://leetcode.cn/problems/sort-an-array/description/

难度：中等

本题是手撕堆排序，使用最大堆。在本题中因为不会有新的元素插入，只需要实现自顶向下修复堆的操作即可。建堆时从最后一个非叶子结点开始，依次调用 repair 函数。然后每次将堆顶元素与堆的最后一个元素交换，堆的大小减一，修复堆。最后数组即为升序排列。反之，如果降序排列使用最小堆。

时间复杂度：O(nlogn)。初始化建堆的时间复杂度为 O(n)，建完堆以后需要进行 n−1 次调整，一次调整的时间复杂度为 O(logn)，那么 n−1 次调整即需要 O(nlogn) 的时间复杂度。因此，总时间复杂度为 O(n+nlogn)=O(nlogn)。

空间复杂度：O(1)。只需要常数的空间存放若干变量。

<!--more-->

```cpp
class Solution {
private:
    int tot = 0;
    // 自顶向下修复堆
    void repair(vector<int>& nums, int x) {
        if (x * 2 + 1 >= tot) {
            return;
        }
        int tar = x * 2 + 1;
        if (x * 2 + 2 < tot) {
            tar = nums[x * 2 + 1] > nums[x * 2 + 2] ? x * 2 + 1 : x * 2 + 2;
        }
        if (nums[x] < nums[tar]) {
            swap(nums[x], nums[tar]);
            repair(nums, tar);
        }
    }

    // 堆排序函数
    void heapSort(vector<int>& nums) {
        int n = nums.size();
        tot = n;

        // 构建最大堆：从最后一个非叶子节点开始
        for (int i = n / 2 - 1; i >= 0; i--) {
            repair(nums, i);
        }

        // 依次提取最大值并放到数组末尾
        for (int i = n - 1; i > 0; i--) {
            swap(nums[0], nums[i]); // 将最大值移到数组末尾
            tot--;
            repair(nums, 0); // 调整剩余堆（大小为i）
        }
    }

public:
    vector<int> sortArray(vector<int>& nums) {
        heapSort(nums);
        return nums;
    }
};
```

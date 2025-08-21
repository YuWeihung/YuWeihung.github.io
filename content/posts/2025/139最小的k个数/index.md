---
title: "139：最小的k个数"
date: 2025-07-15T19:02:02+08:00
draft: false
slug: "lcr-0159"
categories: ["高频面试题"]
tags: ["快速选择", "排序"]
---

LCR 159

https://leetcode.cn/problems/zui-xiao-de-kge-shu-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

快速选择算法，可以使数组 [0, k] 有序。

时间复杂度：O(n)

空间复杂度：O(logn)

<!--more-->

```cpp
class Solution {
public:
    int quickselect(vector<int> &nums, int l, int r, int k) {
        if (l == r)
            return nums[k];
        int partition = nums[l], i = l - 1, j = r + 1;
        while (i < j) {
            do i++; while (nums[i] < partition);
            do j--; while (nums[j] > partition);
            if (i < j)
                swap(nums[i], nums[j]);
        }
        if (k <= j)return quickselect(nums, l, j, k);
        else return quickselect(nums, j + 1, r, k);
    }

    vector<int> inventoryManagement(vector<int>& stock, int cnt) {
        int n = stock.size();
        quickselect(stock, 0, n - 1, cnt);
        vector<int> ans(stock.begin(), stock.begin() + cnt);
        return ans;
    }
};
```

---
title: "快速排序和第 K 小的数"
date: 2024-01-06T21:18:44+08:00
draft: false
slug: "kth-smallest-element"
categories: ["算法题"]
tags: ["排序", "递归"]
---

本文介绍快速排序算法以及基于快速排序的选择方法的实现。

<!--more-->

### 1. 快速排序

快速排序是最常用的排序算法。

```cpp
void quick_sort(vector<int> &nums, int l, int r) {
    if (l == r) {
        return;
    }
    int mid = l + (r - l) / 2;
    int x = nums[mid];
    int i = l - 1, j = r + 1;
    while (i < j) {
        do {
            i++;
        } while (nums[i] < x);
        do {
            j--;
        } while (nums[j] > x);
        if (i < j) {
            swap(nums[i], nums[j]);
        }
    }
    quick_sort(nums, l, j);
    quick_sort(nums, j + 1, r);
}
```

时间复杂度：O(nlogn)

STL 提供了库函数 sort 来实现该功能。

```cpp
sort(nums.begin(), nums.end());
```

### 2. 快速选择

快速排序可以将一个数组按从小到大的顺序排序，但如果我们只需要得到第 k 小的数（最小的数为第 0 小），有没有什么方法来进行优化呢？答案是快速选择算法。

```cpp
int quick_select(vector<int> &nums, int l, int r, int k) {
    if (l == r) {
        return nums[k];
    }
    int mid = l + (r - l) / 2;
    int x = nums[mid];
    int i = l - 1, j = r + 1;
    while (i < j) {
        do {
            i++;
        } while (nums[i] < x);
        do {
            j--;
        } while (nums[j] > x);
        if (i < j) {
            swap(nums[i], nums[j]);
        }
    }
    if (k <= j) {
        return quick_select(nums, l, j, k);
    } else {
        return quick_select(nums, j + 1, r, k);
    }
}
```

快速选择算法和快速排序算法是类似的，关键在于递归的时候只需要递归第 k 个元素所在的半边。

时间复杂度: O(n)

STL 提供了库函数 nth_element 来实现该功能。

```cpp
nth_element(nums.begin(), nums.begin() + k, nums.end());
return nums[k];
```

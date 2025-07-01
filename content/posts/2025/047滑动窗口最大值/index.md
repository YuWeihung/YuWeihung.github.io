---
title: "047：滑动窗口最大值"
date: 2025-07-01T20:16:27+08:00
draft: false
slug: "lc-0239"
categories: ["高频面试题"]
tags: ["单调队列"]
---

LeetCode 239

https://leetcode.cn/problems/sliding-window-maximum/description/

难度：困难

这道题是单调队列。单调队列是一个双端队列，类似单调栈，但需要把超过窗口的元素移除。队首元素就是窗口内的最大值。

1. 右边入（元素进入队尾，同时维护队列单调性）
2. 左边出（元素离开队首）
3. 记录/维护答案（根据队首）

时间复杂度：O(n)，其中 n 为 nums 的长度。由于每个下标至多入队出队各一次，所以二重循环的循环次数是 O(n) 的。

空间复杂度：O(min(k,U))，其中 U 是 nums 中的不同元素个数（本题至多为 20001）。双端队列至多有 k 个元素，同时又没有重复元素，所以也至多有 U 个元素，所以空间复杂度为 O(min(k,U))。返回值的空间不计入。

<!--more-->

```cpp
class Solution {
public:
    vector<int> maxSlidingWindow(vector<int>& nums, int k) {
        vector<int> ans;
        deque<int> q; // 双端队列

        for (int i = 0; i < nums.size(); i++) {
            // 1. 右边入
            while (!q.empty() && nums[q.back()] <= nums[i]) {
                q.pop_back(); // 维护 q 的单调性
            }
            q.push_back(i);

            // 2. 左边出
            if (q.front() <= i - k) { // 队首已经离开窗口了
                q.pop_front();
            }

            // 3. 记录答案
            if (i >= k - 1) {
                // 由于队首到队尾单调递减，所以窗口最大值就在队首
                ans.push_back(nums[q.front()]);
            }
        }

        return ans;
    }
};
```

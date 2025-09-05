---
title: "167：寻找重复数"
date: 2025-07-15T19:02:50+08:00
draft: false
slug: "lc-0287"
categories: ["高频面试题"]
tags: ["双指针"]
---

LeetCode 287

https://leetcode.cn/problems/find-the-duplicate-number/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题不允许修改数组，因此不能使用原地哈希。使用快慢指针法，同环形链表题目。

时间复杂度：O(n)。「Floyd 判圈算法」时间复杂度为线性的时间复杂度。

空间复杂度：O(1)。我们只需要常数空间存放若干变量。

<!--more-->

```cpp
class Solution {
public:
    int findDuplicate(vector<int>& nums) {
        int slow = 0;
        int fast = 0;
        slow = nums[slow];
        fast = nums[nums[fast]];
        while (fast != slow) {
            slow = nums[slow];
            fast = nums[nums[fast]];
        }
        int head = 0;
        while (head != slow) {
            head = nums[head];
            slow = nums[slow];
        }
        return head;
    }
};
```

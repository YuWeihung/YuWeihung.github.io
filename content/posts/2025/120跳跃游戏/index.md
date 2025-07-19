---
title: "120：跳跃游戏"
date: 2025-07-15T19:01:36+08:00
draft: false
slug: "lc-0055"
categories: ["高频面试题"]
tags: ["贪心", "区间覆盖"]
---

LeetCode 55

https://leetcode.cn/problems/jump-game/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

维护最右可达位置。用 i + nums[i] 更新 mx 最大值。如果当前位置不可达返回 False。

时间复杂度：O(n)，其中 n 是 nums 的长度。

空间复杂度：O(1)。仅用到若干额外变量。

<!--more-->

```cpp
class Solution {
public:
    bool canJump(vector<int>& nums) {
        int mx = 0;
        for (int i = 0; i < nums.size(); i++) {
            if (i > mx) { // 无法到达 i
                return false;
            }
            mx = max(mx, i + nums[i]); // 从 i 最右可以跳到 i + nums[i]
        }
        return true;
    }
};
```

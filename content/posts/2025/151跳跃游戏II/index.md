---
title: "151：跳跃游戏II"
date: 2025-07-15T19:02:20+08:00
draft: false
slug: "lc-0045"
categories: ["高频面试题"]
tags: ["贪心", "区间贪心"]
---

LeetCode 45

https://leetcode.cn/problems/jump-game-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

不是在无路可走的那个位置造桥，而是当发现无路可走的时候，时光倒流到能跳到最远点的那个位置造桥。换句话说，在无路可走之前，我们只是在默默地收集信息，没有实际造桥。当发现无路可走的时候，才从收集到的信息中，选择最远点造桥。所建造的这座桥的左端点（起跳位置）在我们当前走的这座桥的中间，而不是桥的末尾。

时间复杂度：O(n)。其中 n 是 nums 的长度。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int jump(vector<int>& nums) {
        int ans = 0;
        int cur_right = 0; // 已建造的桥的右端点
        int next_right = 0; // 下一座桥的右端点的最大值
        for (int i = 0; i + 1 < nums.size(); i++) {
            // 遍历的过程中，记录下一座桥的最远点
            next_right = max(next_right, i + nums[i]);
            if (i == cur_right) { // 无路可走，必须建桥
                cur_right = next_right; // 建桥后，最远可以到达 next_right
                ans++;
            }
        }
        return ans;
    }
};
```

---
title: "111：全排列 II"
date: 2025-07-13T12:37:15+08:00
draft: false
slug: "lc-0047"
categories: ["高频面试题"]
tags: ["回溯", "有重复元素的回溯"]
---

LeetCode 47

https://leetcode.cn/problems/permutations-ii/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题是有重复元素的全排列。如何避免得到重复的结果呢？可以把相同的元素排一个顺序，只能从左往右按顺序排。

为方便判断，先把 nums 排序（从小到大或者从大到小都可以）。

- 如果 nums[i] != nums[i−1]，那么 nums[i] 就是所有等于 nums[i] 的数中的第一个数。我们规定：这种情况可以随意填。
- 如果 nums[i] == nums[i−1]，继续讨论：
  - 如果 nums[i−1] 没有填入排列，为了避免生成重复的排列，绝对不能填 nums[i]，直接 continue。这会导致后续所有等于 nums[i] 的数全部 continue，因为对于后面的 nums[i] 来说，nums[i] 和前面的数 nums[i−1] 相等，并且 nums[i−1] 没有填入排列。
  - 如果 nums[i−1] 已经填入排列，那么 nums[i] 是剩余元素（子问题）中的第一个等于 nums[i] 的数，可以随意填。

时间复杂度：O(n⋅n!)，其中 n 为 nums 的长度。分析方法同 46 题的题解。

空间复杂度：O(n)。返回值的空间不计入。

<!--more-->

```cpp
class Solution {
public:
    vector<vector<int>> permuteUnique(vector<int>& nums) {
        ranges::sort(nums);
        int n = nums.size();
        vector<vector<int>> ans;
        vector<int> path(n); // 所有排列的长度都是 n
        vector<int> on_path(n); // on_path[j] 表示 nums[j] 是否已经填入排列
        // i 表示当前要填排列的第几个数
        auto dfs = [&](this auto&& dfs, int i) -> void {
            if (i == n) { // 填完了
                ans.push_back(path);
                return;
            }
            // 枚举 nums[j] 填入 path[i]
            for (int j = 0; j < n; j++) {
                // 如果 nums[j] 已填入排列，continue
                // 如果 nums[j] 和前一个数 nums[j-1] 相等，且 nums[j-1] 没填入排列，continue
                if (on_path[j] || j > 0 && nums[j] == nums[j - 1] && !on_path[j - 1]) {
                    continue;
                }
                path[i] = nums[j]; // 填入排列
                on_path[j] = true; // nums[j] 已填入排列（注意标记的是下标，不是值）
                dfs(i + 1); // 填排列的下一个数
                on_path[j] = false; // 恢复现场
                // 注意 path 无需恢复现场，因为排列长度固定，直接覆盖就行
            }
        };
        dfs(0);
        return ans;
    }
};
```

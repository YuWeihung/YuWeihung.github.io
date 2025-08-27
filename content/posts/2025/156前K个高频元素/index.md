---
title: "156：前 K 个高频元素"
date: 2025-07-15T19:02:29+08:00
draft: false
slug: "lc-0347"
categories: ["高频面试题"]
tags: ["排序", "桶排序"]
---

LeetCode 347

https://leetcode.cn/problems/top-k-frequent-elements/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

桶排序。

第一步

答案与元素的出现次数有关，我们首先用一个哈希表 cnt 统计每个元素的出现次数。哈希表的 key 是元素值，value 是 key 在数组中的出现次数。

第二步

设出现次数最大值为 maxCnt，由于 maxCnt≤n，我们可以用桶排序，把出现次数相同的元素，放到同一个桶中。

创建一个大小为 maxCnt+1 的列表 buckets，其中 buckets[c] 存储出现次数为 c 的元素。（每个 buckets[c] 都是一个列表）

遍历 cnt，把出现次数为 c 的元素 x 添加到 buckets[c] 中。

第三步

倒序遍历 buckets，把 buckets[c] 中的元素加到答案中。

一旦答案的长度等于 k，就立刻返回答案。

时间复杂度：O(n)，其中 n 是 nums 的长度。

空间复杂度：O(n)。

<!--more-->

```cpp
class Solution {
public:
    vector<int> topKFrequent(vector<int>& nums, int k) {
        // 第一步：统计每个元素的出现次数
        unordered_map<int, int> cnt;
        int max_cnt = 0;
        for (int x : nums) {
            cnt[x]++;
            max_cnt = max(max_cnt, cnt[x]);
        }

        // 第二步：把出现次数相同的元素，放到同一个桶中
        vector<vector<int>> buckets(max_cnt + 1);
        for (auto& [x, c] : cnt) {
            buckets[c].push_back(x);
        }

        // 第三步：倒序遍历 buckets，把出现次数前 k 大的元素加入答案
        vector<int> ans;
        // 注意题目保证答案唯一，一定会出现某次 insert 后 ans.size() 恰好等于 k 的情况
        for (int i = max_cnt; i >= 0 && ans.size() < k; i--) {
            ans.insert(ans.end(), buckets[i].begin(), buckets[i].end());
        }
        return ans;
    }
};
```

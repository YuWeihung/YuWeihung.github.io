---
title: "189：数组中出现次数超过一半的数字"
date: 2025-07-15T19:03:44+08:00
draft: false
slug: "lcr-0158"
categories: ["高频面试题"]
tags: ["摩尔投票法"]
---

LCR 158

https://leetcode.cn/problems/shu-zu-zhong-chu-xian-ci-shu-chao-guo-yi-ban-de-shu-zi-lcof/description/

难度：简单

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

摩尔投票法。

时间复杂度 O(N) ： N 为数组 stock 长度。

空间复杂度 O(1) ： votes 变量使用常数大小的额外空间。

<!--more-->

```cpp
class Solution {
public:
    int inventoryManagement(vector<int>& stock) {
        int x = 0, votes = 0;
        for(int num : stock){
            if(votes == 0) x = num;
            votes += num == x ? 1 : -1;
        }
        return x;
    }
};
```

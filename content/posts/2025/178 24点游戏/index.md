---
title: "178：24点游戏"
date: 2025-07-15T19:03:14+08:00
draft: false
slug: "lc-0679"
categories: ["高频面试题"]
tags: ["回溯"]
---

LeetCode 679

https://leetcode.cn/problems/24-game/description/

难度：困难

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

无论表达式是什么样的，我们总是可以从中选两个数最先计算。计算后，变成包含三个数字的表达式。同样地，这个表达式也可以从中选两个数最先计算，依此类推。

每次从剩余牌中取两张牌，执行计算，合并成一张新牌。所以每次计算后会减少一张牌，得到一个新的数组 newCards。用 newCards 递归调用 judgePoint24，直到只剩一张牌。判断这张牌的数字是否等于 24。

一共有六种运算方式：加减乘除，其中减和除有两种不同的顺序。注意除法需要保证分母不为 0。有两种方法实现除法：浮点数、分数类。如果用浮点数的话，会有舍入误差。但本题只有 4 张牌，舍入误差不会很大，取 ϵ=1e−9 足矣。如果两数绝对差小于 ϵ，则认为两数相等。

时间复杂度：O(n!⋅6^n)，其中 n 是 cards 的长度。

空间复杂度：O(n^2)。递归 O(n) 层，每层消耗 O(n) 空间。

<!--more-->

```cpp
class Solution {
    const double EPS = 1e-9;

    bool dfs(vector<double>& cards) {
        int n = cards.size();
        if (n == 1) {
            return abs(cards[0] - 24) < EPS;
        }

        // 选两张牌 x=cards[i] 和 y=cards[j]
        for (int i = 0; i < n; i++) {
            double x = cards[i];
            for (int j = i + 1; j < n; j++) {
                double y = cards[j];

                // 六种情况：加减乘除，其中减和除都有两种不同的顺序
                vector<double> candidates = {x + y, x - y, y - x, x * y};
                if (abs(y) > EPS) { // 保证分母不为 0
                    candidates.push_back(x / y);
                }
                if (abs(x) > EPS) { // 保证分母不为 0
                    candidates.push_back(y / x);
                }

                auto new_cards = cards;
                new_cards.erase(new_cards.begin() + j); // 删除 j
                for (double res : candidates) {
                    new_cards[i] = res; // 覆盖 i
                    if (dfs(new_cards)) {
                        return true;
                    }
                }
            }
        }
        return false;
    }

public:
    bool judgePoint24(vector<int>& cards) {
        vector<double> a(cards.begin(), cards.end());
        return dfs(a);
    }
};
```

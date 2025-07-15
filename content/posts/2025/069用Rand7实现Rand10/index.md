---
title: "069：用 Rand7() 实现 Rand10()"
date: 2025-07-03T23:12:57+08:00
draft: false
slug: "lc-0470"
categories: ["高频面试题"]
tags: ["概率论", "拒绝采样"]
---

LeetCode 470

https://leetcode.cn/problems/implement-rand10-using-rand7/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

参考题解：

https://leetcode.cn/problems/implement-rand10-using-rand7/solutions/167850/cong-zui-ji-chu-de-jiang-qi-ru-he-zuo-dao-jun-yun-/

假设已知 rand2()可以均匀的生成[1,2]的随机数，现在想均匀的生成[1,4]的随机数，该如何实现？

答案是 (rand2()-1) × 2 + rand2()

已知 rand_N() 可以等概率的生成[1, N]范围的随机数

那么：(rand_X() - 1) × Y + rand_Y() ==> 可以等概率的生成[1, X * Y]范围的随机数

即实现了 rand_XY()

那么如何通过 rand4()来实现 rand2()呢？这个就很简单了，已知 rand4()会均匀产生[1,4]的随机数，通过取余，再加 1 就可以了。

事实上，只要 rand_N()中 N 是 2 的倍数，就都可以用来实现 rand2()，反之，若 N 不是 2 的倍数，则产生的结果不是等概率的。

在本题中，要实现 rand10()，就需要先实现 rand_N()，并且保证 N 大于 10 且是 10 的倍数。这样再通过 rand_N() % 10 + 1 就可以得到[1,10]范围的随机数了。

(rand7()-1) × 7 + rand7() ==> rand49()

拒绝采样：如果某个采样结果不在要求的范围内，则丢弃它。

这样，我们可以得到 [1, 40] 的随机数。对他取余再 +1 得到 rand10()。

时间复杂度：期望时间复杂度为 O(1)，但最坏情况下会达到 O(∞)（一直被拒绝）。

空间复杂度：O(1)。

<!--more-->

```cpp
class Solution {
public:
    int rand10() {
        while (true) {
            // 等概率生成[1, 49]范围内的随机数
            int num = (rand7() - 1) * 7 + rand7();
            // 拒绝采样，并返回[1, 10]范围内的随机数
            if (num <= 40) {
                return num % 10 + 1;
            }
        }
    }
};
```

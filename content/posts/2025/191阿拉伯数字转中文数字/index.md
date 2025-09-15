---
title: "191：阿拉伯数字转中文数字"
date: 2025-07-15T19:03:50+08:00
draft: false
slug: "nc-0340"
categories: ["高频面试题"]
tags: ["字符串", "模拟"]
---

Nowcoder 340

https://www.nowcoder.com/practice/6eec992558164276a51d86d71678b300

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

本题数据范围为小于 10 亿，需要先把数字拆分为亿，万，个三级。对于每个部分，转换一个四位数为中文读法。

时间复杂度：O(1)

空间复杂度：O(1)

<!--more-->

```cpp
class Solution {
    string digits[10] = {"零", "一", "二", "三", "四", "五", "六", "七", "八", "九"};
    string units[4] = {"千", "百", "十", ""};

    // 转换一个四位数（0-9999）为中文读法
    string convertFourDigits(int num) {
        if (num == 0) return "";
        int d0 = num / 1000;
        int d1 = (num % 1000) / 100;
        int d2 = (num % 100) / 10;
        int d3 = num % 10;
        int arr[4] = {d0, d1, d2, d3};

        string res;
        bool hasZero = false; // 标记是否有待添加的零

        for (int i = 0; i < 4; i++) {
            if (arr[i] != 0) {
                // 只有在有未处理的零且结果不为空时才添加零
                if (hasZero && !res.empty()) {
                    res += "零";
                    hasZero = false;
                }

                // 处理十位上的1特殊情况
                if (i == 2 && arr[i] == 1 && res.empty()) {
                    res += "十";
                } else {
                    res += digits[arr[i]] + units[i];
                }

                // 重置零标记，因为已经处理了非零数字
                hasZero = false;
            } else {
                // 标记有零需要处理
                hasZero = true;
            }
        }
        return res;
    }

  public:
    string num2cn(int n) {
        if (n == 0) return "零";

        string sign = "";
        if (n < 0) {
            sign = "负";
            n = -n;
        }

        int billion = n / 100000000;       // 亿级部分
        int million = (n % 100000000) / 10000; // 万级部分
        int thousand = n % 10000;          // 个级部分

        string res;

        // 处理亿级
        if (billion > 0) {
            res += convertFourDigits(billion) + "亿";
            if (million == 0 && thousand > 0) {
                res += "零";
            }
        }

        // 处理万级
        if (million > 0) {
            res += convertFourDigits(million) + "万";
            if (thousand > 0 && thousand < 1000) {
                res += "零";
            }
        }

        // 处理个级
        if (thousand > 0) {
            res += convertFourDigits(thousand);
        }

        return sign + res;
    }
};
```

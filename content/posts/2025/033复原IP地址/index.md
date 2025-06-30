---
title: "033：复原IP地址"
date: 2025-06-30T13:33:09+08:00
draft: false
slug: "lc-0093"
categories: ["高频面试题"]
tags: ["回溯", "子集型回溯"]
---

LeetCode 93

https://leetcode.cn/problems/restore-ip-addresses/description/

难度：中等

子集型回溯题目，本题使用“枚举选哪个”方法。

dfs(i, start) i 表示第几段，start 表示这一段从第几个数字开始。当选够 4 段且所有数字都被使用时添加答案。

如果 s[start] 为 0，这一段只能是 0，dfs(i + 1, start + 1)。

如果不是 0，这一段的数据范围需要在 [1, 255]之间，如果超过 255 就 break。

时间复杂度：\(O(3^N \times m)\)，m 为 s 的长度。

空间复杂度：O(N)

<!--more-->

```cpp
class Solution {
public:
    static constexpr int N = 4;

    vector<string> restoreIpAddresses(string s) {
        vector<string> ans;
        vector<int> path(N);

        auto dfs = [&](auto&& dfs, int i, int start) {
            if (i == N) {
                if (start == s.size()) {
                    string ip = "";
                    for (int i = 0; i < N; i++) {
                        ip += to_string(path[i]);
                        if (i != N - 1) {
                            ip += ".";
                        }
                    }
                    ans.emplace_back(ip);
                }
                return;
            }
            if (start == s.size()) {
                return;
            }

            if (s[start] == '0') {
                path[i] = 0;
                dfs(dfs, i + 1, start + 1);
            } else {
                int addr = 0;
                for (int j = start; j < s.size(); j++) {
                    addr = addr * 10 + (s[j] - '0');
                    if (addr > 0 && addr <= 255) {
                        path[i] = addr;
                        dfs(dfs, i + 1, j + 1);
                    } else {
                        break;
                    }
                }
            }

        };
        dfs(dfs, 0, 0);
        return ans;
    }
};
```

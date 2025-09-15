---
title: "197简化路径"
date: 2025-07-15T19:04:14+08:00
draft: false
slug: "lc-0"
categories: ["高频面试题"]
tags: ["栈", "字符串"]
---

LeetCode 71

https://leetcode.cn/problems/simplify-path/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

使用一个栈存储目录，如果当前字符不是 '/'，那么更新 dir，直到遇到 '/'。如果 dir 是 ".."，把栈顶目录弹出。如果 dir 不是"."、".."和空串，添加到栈中。最后使用 '/' 连接目录作为答案。为方便处理，首先在 path 最后添加 '/'。

时间复杂度：O(n)，其中 n 是字符串 path 的长度。

空间复杂度：O(n)。我们需要 O(n) 的空间存储 names 中的所有字符串。

<!--more-->

```cpp
class Solution {
public:
    string simplifyPath(string path) {
        string ans;
        int index = 0;
        string dir = "";
        vector<string> st;
        path += '/';
        while (index < path.size()) {
            char ch = path[index];
            if (ch != '/') {
                dir += ch;
                index++;
                continue;
            } else if (dir == ".." && !st.empty()) {
                st.pop_back();
            } else if (dir != ".." && dir != "." && dir != "") {
                st.push_back(dir);
            }
            dir = "";
            index++;
        }
        for (auto &dir: st) {
            ans += '/';
            ans += dir;
        }
        return ans == "" ? "/" : ans;
    }
};
```

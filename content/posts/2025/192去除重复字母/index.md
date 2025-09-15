---
title: "192：去除重复字母"
date: 2025-07-15T19:03:53+08:00
draft: false
slug: "lc-0316"
categories: ["高频面试题"]
tags: ["单调栈"]
---

LeetCode 316

https://leetcode.cn/problems/remove-duplicate-letters/description/

难度：中等

高频面试题汇总：https://www.yuweihung.com/posts/2025/lc-hot/

单调栈。

1. 统计每个字母的出现次数，记到一个哈希表或者数组 left 中。
2. 遍历 s，先把 left[s[i]] 减一。
3. 如果 s[i] 在 ans 中，直接 continue。为了快速判断 s[i] 是否在 ans 中，可以用一个哈希表或者布尔数组 inAns 辅助判断。
4. 如果 s[i] 不在 ans 中，那么判断 s[i] 是否小于 ans 的最后一个字母（记作 x），如果 s[i]<x 且 left[x]>0，那么可以把 x 从 ans 中去掉，同时标记 inAns[x]=false。
5. 反复执行第 4 步，直到 ans 为空，或者 s[i]>x，或者 left[x]=0。
6. 把 s[i] 添加到 ans 末尾，同时标记 inAns[s[i]]=true。然后继续遍历 s 的下一个字母。
7. 遍历完 s 后，返回 ans。

时间复杂度：O(n)，其中 n 为 s 的长度。我们写了一个二重循环，看上去是 O(n^2) 的，但是考虑到每个 s[i] 加到 ans 中至多一次，从 ans 中去掉也至多一次。所以整体上看，算法的时间复杂度是 O(n) 的。

空间复杂度：O(∣Σ∣)，其中 ∣Σ∣ 为字符集的大小，本题中字符均为小写字母，所以 ∣Σ∣=26。注意 ans 的长度不会超过 ∣Σ∣。

<!--more-->

```cpp
class Solution {
public:
    string removeDuplicateLetters(string s) {
        int left[26]{};
        for (char c : s) {
            left[c - 'a']++; // 统计每个字母的出现次数
        }

        string ans; // 当作栈
        bool in_ans[26]{};
        for (char c : s) {
            left[c - 'a']--;
            if (in_ans[c - 'a']) { // ans 中不能有重复字母
                continue;
            }
            while (!ans.empty() && c < ans.back() && left[ans.back() - 'a']) {
                // (设 x=ans.back()) 如果 c < x，且右边还有 x，那么可以把 x 去掉，
                // 因为后面可以重新把 x 加到 ans 中
                in_ans[ans.back() - 'a'] = false; // 标记栈顶不在 ans 中
                ans.pop_back();
            }
            ans += c; // 把 c 加到 ans 的末尾
            in_ans[c - 'a'] = true; // 标记 c 在 ans 中
        }
        return ans;
    }
};
```

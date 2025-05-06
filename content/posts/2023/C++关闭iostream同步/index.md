---
title: "C++ 关闭 iostream 同步"
date: 2023-09-06T23:13:51+08:00
draft: false
slug: "disable-sync-with-stdio"
categories: ["算法题"]
tags: ["输入输出"]
---

在 C++ 中，iostream 默认会与标准输入输出（stdio）进行同步，以保证 I/O 顺序的一致性。然而，这会导致 iostream 的性能变得非常差，当题目的数据量大时很容易造成超时。因此我们需要关闭 iostream 的同步。

<!--more-->

关闭方法也很简单，只需要在 main 函数的开头添加以下代码即可。

```cpp
ios::sync_with_stdio(false);
```

下面测试关闭同步与否的性能差距。测试环境: Windows 11 x64，gcc 14.2.0。

| 实验              | 速度    |
| ----------------- | ------- |
| iostream 关闭同步 | 2790ms  |
| iostream 开启同步 | 20033ms |
| stdio             | 11040ms |

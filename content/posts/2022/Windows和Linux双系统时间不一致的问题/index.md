---
title: "Windows 和 Linux 双系统时间不一致的问题"
date: 2022-01-12T16:39:50+08:00
draft: false
slug: "dual-system-time-difference"
categories: ["Linux"]
tags: ["Windows", "Linux"]
---

本文主要介绍了如何解决 Windows 和 Linux 双系统时间不一致的问题。

<!--more-->

## 背景

当我们安装了 Windows 和 Linux 双系统后，经常会遇到两个系统时间不一致的问题，具体就是 Linux 系统的时间比 Windows 系统快了 8 个小时。这个问题是由于 Windows 和 Linux 系统处理系统硬件时间策略的不同带来的。

首先介绍一个概念:
协调世界时（英语：Coordinated Universal Time，简称 **UTC**）是最主要的世界时间标准，其以原子时秒长为基础，在时刻上尽量接近于格林威治标准时间，即 0 时区。

Windows 系统将计算机硬件时间当作本地时间(local time)，所以在 Windows 系统中显示的时间跟 BIOS 中显示的时间是一样的。

而 Linux/Mac 将计算机硬件时间当作 UTC， 所以在 Linux/Mac 系统启动后在该时间的基础上，加上电脑设置的时区数（ 比如我们在中国，它就加上“8” ），因此，Linux/Mac 系统中显示的时间总是比 Windows 系统中显示的时间快 8 个小时。

## 解决方案

由上可知，解决这个问题有两个方案，下面分别介绍。

### 1. 让 Linux 使用本地时间

现代 Linux 一般都采用 systemd 来管理系统，这时可以通过 timedatectl 命令来更改

```
timedatectl set-local-rtc 1 --adjust-system-clock
```

执行后重启系统就可以了。

### 2. 让 Windows 使用 UTC 时间

使用管理员权限打开命令行程序，输入以下命令来修改注册表。

```
Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1
```

---

参考链接：

1. [怎样解决 Windows10 时间快和 Ubuntu 时间差问题？ - 滑稽的回答- 知乎](https://www.zhihu.com/question/46525639/answer/157272414)

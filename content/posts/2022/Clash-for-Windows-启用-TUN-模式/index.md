---
title: "Clash for Windows 启用 TUN 模式"
date: 2022-02-23T21:10:49+08:00
draft: false
slug: "cfw-tun-system"
categories: ["互联网"]
tags: ["代理", "Clash"]
---

Clash for Windows（下简称 CFW）是一个常用的跨平台的代理软件。其 TUN 模式就类似于 VPN，通过创建一个虚拟网卡的方式来对流量实现更为彻底的代理。对于不遵循系统代理的软件，TUN 模式可以接管其流量并交由 CFW 处理。

<!--more-->

## Windows 系统中启用 TUN 模式

启动 TUN 模式需要进行如下操作：

1. 点击 `General` 中 `Service Mode` 右边 `Manage`，在打开窗口中安装服务模式，安装完成应用会自动重启，`Service Mode` 右边地球图标变为绿色即安装成功。
2. 点击 `General` 中 `TUN Mode` 右边开关启动 `TUN` 模式。

## 使用 system 作为 TUN stack

TUN 模式默认的 stack 为 gVisor，除此之外还有一个 system stack。system 使用内核的 TCP/IP 协议栈，在理论上行为与系统的 TCP/IP 最接近，兼容性最强。

但是需要将 clash core 从防火墙中放行才能正常工作。

设置 - 更新和安全 - Windows 安全中心 - 防火墙和网络保护 - 允许应用通过防火墙 - clash-win64.exe - 专用/公用 都放行。

## Allow LAN

安装 Service Mode 后 Allow LAN 功能可能会失效，如需要局域网连接功能谨慎开启。

---

参考链接：

1. [TUN 防火墙](https://github.com/Fndroid/clash_for_windows_pkg/issues/1936)
2. [Allow LAN](https://github.com/Fndroid/clash_for_windows_pkg/issues/831)

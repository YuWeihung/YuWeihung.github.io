---
title: "VMware 虚拟机大小核调度问题"
date: 2023-06-20T23:04:28+08:00
draft: false
slug: "vmware-p-core"
categories: ["Windows"]
tags: ["Windows", "VMware", "虚拟机", "Intel"]
---

众所周知，Intel 自 12 代处理器就开始使用大小核架构，把核心分为 P-Core 和 E-Core，即我们所说的大核和小核。Microsoft 声称在 Windows 11 系统上对大小核架构进行了优化。不过，在有些场景下大小核的调度仍不尽如人意，比如本文所探讨的 VMware 虚拟机场景。

<!--more-->

### 实验环境

本机使用 i9-13900h 处理器，6P + 8E 核，20 线程，操作系统 Windows 11 22H2。创建一台 Ubuntu 22.04 虚拟机，分配 12 个 CPU 核心，编译 [boost](https://www.boost.org/) 项目来测试 CPU 性能。

下载源码压缩包 `boost_1_82_0.tar.gz`，然后解压

```
tar zxvf boost_1_82_0.tar.gz
```

进入目录，运行 `bootstrap.sh` 脚本并设置相关参数

```
cd boost_1_82_0/
./bootstrap.sh --with-libraries=all --with-toolset=gcc
```

之后编译 boost

```
./b2 toolset=gcc
```

此时，打开宿主机的任务管理器我们可以发现，虚拟机的编译进程竟然全部跑在小核心上，6 个大核纹丝不动，可谓“一核有难，八核围观”。当然，这样编译的性能肯定也上不去了。那么，有什么办法可以解决这一问题呢？

### 修改虚拟机 vmx 配置文件

其中的一个办法是修改虚拟机的 vmx 配置文件，打开虚拟机目录下的 `.vmx` 文件（或全局配置文件：`C:\ProgramData\VMware\VMware Workstation\config.ini`），添加如下内容

```
processor0.use = "TRUE"
processor1.use = "TRUE"
processor2.use = "TRUE"
processor3.use = "TRUE"
processor4.use = "TRUE"
processor5.use = "TRUE"
processor6.use = "TRUE"
processor7.use = "TRUE"
processor8.use = "TRUE"
processor9.use = "TRUE"
processor10.use = "TRUE"
processor11.use = "TRUE"
processor12.use = "FALSE"
processor13.use = "FALSE"
processor14.use = "FALSE"
processor15.use = "FALSE"
processor16.use = "FALSE"
processor17.use = "FALSE"
processor18.use = "FALSE"
processor19.use = "FALSE"
```

注意，处理器的序号需要根据实际情况来调整，如本机 6P + 8E，前 12 个线程设为 TRUE，后面 8 个设为 FALSE，这样就把线程都分配到了 6 个大核上。

经实际测试，这样确实可以把任务分配到大核心上运行，不过性能好像一般，并不能跑满大核，CPU 的频率一直上不去，只运行在 2.x GHz。

### 使用管理员权限运行 VMware

另一个办法是使用管理员权限来运行 VMware Workstation。

打开 VMware 的安装目录，选择 `vmware.exe`，右键 - 属性 - 兼容性 - 以管理员身份运行此程序，并重新运行虚拟机。

同样运行测试，发现可以正常使用大核，并且 CPU 的频率也能跑到 4.x GHz。此外，继续尝试将虚拟机的 CPU 数量设置为 20，运行测试，发现可以完全跑满宿主机 CPU，任务管理器 CPU 占用率达到 100%。

总结，想要让 VMware 虚拟机正常调度大小核，最简单的方案就是使用管理员身份来运行虚拟机程序。

---
title: "使用 archinstall 快捷安装 Arch Linux"
date: 2022-10-27T19:21:35+08:00
draft: false
slug: "install-archlinux-using-archinstall"
categories: ["Linux"]
tags: ["Arch Linux"]
---

Arch Linux 是一个著名的滚动更新（Rolling update）的 Linux 发行版。与常用的 Ubuntu 等发行版相比，Arch Linux 有着更新的软件包，并且由于滚动更新的缘故，Arch Linux 也避免了 Ubuntu 在大版本更新时（如 20.04 LTS 到 22.04 LTS）由于软件包版本差异过大而可能遇到的困难。不过，当很多新人打算尝试 Arch Linux 的时候，却直接被 Arch Linux 复杂的安装过程而劝退。不过，随着官方系统镜像集成了 archinstall，Arch Linux 的安装也成为了一件简单的事情。

<!--more-->

本文通过创建一个 VMware 的虚拟机的方式来介绍 Arch Linux 的安装流程，在真机上的安装流程也类似。首先是准备工作，下载 Arch Linux 的安装 ISO 镜像，如果是真机安装的话可以使用 rufus 软件制作启动盘。

然后启动机器，进入 LiveCD。然后输入命令进入 archinstall 的可视化安装界面。

```
root@archiso ~ # archinstall
```

然后就可以看到安装的指引界面。

{{< img src="pic1.png" width="100%">}}

接着我们从上到下依次进行设置。

1. 语言和键盘布局
   由于 archinstall 暂不支持中文，因此这两项可以跳过。
2. 镜像区域
   选择 China
3. locale 编码
   选择 zh_CN.UTF8
4. 磁盘
   选择磁盘然后设置分区。选择抹除选择的磁盘，然后选择文件系统，有 btrfs，ext4，f2fs 和 xfs。可以根据自己的需要选择，这里选择 xfs。然后选择是否划分单独的 /home 分区，这里选择否。下面的硬盘加密如无特殊需求可跳过。grub 引导和 swap 都默认设置好了，如无特殊需求也可跳过。
5. 设置主机名和 root 密码
   主机名根据个人喜好设置，root 密码如不需要可留空。
6. 添加用户
   选择添加用户，输入用户名和密码，并确认密码，选择该用户是否是超级用户即具有 sudo 权限，选择是。确认并退出。
7. 配置网络
   上面的内核设置等如无特殊需要可以跳过，下面配置网络。如果打算安装桌面环境，选择使用 NetworkManager，如果用作服务器，选择手动配置。这里选择手动配置，添加网卡，选择通过 DHCP 获取 IP 还是静态 IP。选择静态 IP，输入 IP 地址和子网掩码，即 CIDR 地址，如 192.168.0.5/24。接着输入网关地址和 DNS 地址。确认并退出。
8. 时区
   选择 Asia/Shanghai，可以使用 / 来搜索。NTP 默认开启可以跳过。

现在一切准备就绪，选择 Install 来安装。按 Enter 键确认。之后就等待安装完成。

安装完成后会询问是否 chroot 到新安装的系统，选择是。进入系统之后就可以先安装一些需要的软件，如 vim，openssh 等。

```bash
pacman -S vim git openssh neofetch
```

并开启 sshd 的自启动，以便之后通过 ssh 来进行操作。

```bash
systemctl enable sshd
```

然后，我们只需要输入 `exit` 退出，并输入 `reboot` 来重启系统就可以完成安装了。

重启后，通过 ssh 连接到刚刚创建的用户，就可以开始使用了。以新系统的 neofetch 信息作结。

{{< img src="pic2.png" width="100%">}}

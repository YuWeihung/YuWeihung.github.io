---
title: "Windows 11 系统启用 WSL 2 并安装 Docker"
date: 2021-11-09T18:04:36+08:00
draft: false
slug: "wsl2-docker-instruction"
categories: ["系统设置"]
tags: ["WSL", "Docker", "代理"]
---

本文主要介绍了在 Win11 系统上启用 WSL 2，完成基本配置并安装 Docker 的过程。

<!--more-->

## 背景

Windows 11 系统对 WSL 2 进行了一系列的优化，尤其是解决了内存回收问题，这样当 Linux 子系统释放内存时主机就会将内存收回，不会再像 win10 一样一直占用很大的内存了。Windows 不愧是最佳 Linux 发行版 :D。在此之前，我一直通过 VMware 创建 Ubuntu 的虚拟机的方式来使用 Docker，现在利用 WSL 2，Linux 与主机的关联更加密切，开发起来就更方便了。

## 安装 WSL

在 Win11 上安装 WSL 2 的方法非常简单，只需打开管理员权限的 powershell，输入以下命令

```
wsl --install
```

并重启计算机，就会启用所需的可选组件，下载最新的 Linux 内核，将 WSL 2 设置为默认值，并安装 Linux 发行版（默认为 Ubuntu）。

首次打开 WSL 时，需要我们设置用户名和密码。

## APT 换源

Ubuntu 默认使用的是 HTTP 源，如果直接换 HTTPS 源的话会报证书错误，我们需要先执行

```
 sudo apt-get update
 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

然后再更换为国内的 HTTPS 源（如 USTC 源）。

## 设置代理

WSL 2 设置代理一直是一个比较麻烦的问题。当我们使用 VMware 的虚拟机时，只需要开启 Windows 上 Clash for Windows（简称 CFW） 的允许局域网连接，并设置为 VMware 虚拟网卡的局域网中主机的 ip 地址和端口的代理就可以了。

而 WSL 2 的 ip 地址每次开机都会变动，这样如果每次开机都去修改代理的 ip 就太麻烦了。当然一种办法是通过环境变量来动态获得 ip 地址，如

```
export host_ip=$(cat /etc/resolv.conf |grep -oP '(?<=nameserver\ ).*')
export https_proxy="http://${host_ip}:7890"
export http_proxy="http://${host_ip}:7890"
export all_proxy="http://${host_ip}:7890"
```

不过在一些不能通过环境变量来设置代理的软件中还是不太方便。

一种比较好的方案是利用 CFW 的 TUN 模式。

启动 TUN 模式需要进行如下操作：

首先点击 General 中 Service Mode 右边 Manage，在打开窗口中安装服务模式，安装完成应用会自动重启，Service Mode 右边地球图标变为绿色即安装成功。

然后进入 Settings 页面，滚动至 Profile Mixin 栏，点击 YAML 右边 Edit 小字打开编辑界面，在修改编辑界面内容为：

```yaml
mixin: # object
  dns:
    enable: true
    enhanced-mode: fake-ip
    nameserver:
      - 223.5.5.5 # 真实请求DNS，可多设置几个
      - 119.29.29.29
      - 114.114.114.114
  # interface-name: WLAN # 出口网卡名称，或者使用下方的自动检测
  tun:
    enable: true
    stack: gvisor # 使用 system 需要 Clash Premium 2021.05.08 及更高版本
    dns-hijack:
      - 198.18.0.2:53 # 请勿更改
    auto-route: true
    auto-detect-interface: true # 自动检测出口网卡
```

打开 Mixin，重启 CFW，这样 CFW 就会自动将 TUN 的配置内容添加到当前所用的配置文件中，这时所有流量都会由 CFW 接管了。

## 安装 Docker

由于 WSL 2 没有 Systemd，所以如果我们在 WSL 里面安装 Docker 需要每次开机手动开启服务。所以推荐的方案是在 Windows 上安装 Docker Desktop 并启用 WSL 2 的后端。

下载并安装 Docker Desktop 后，我们就可以使用 Docker 了。以安装 MySQL 的 docker 为例。

```
docker pull mysql
docker run -d --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=1234 mysql
```

这样就开启了一个 mysql 的服务。

我们可以通过

```
docker exec -it mysql-test /bin/
```

来进入容器。

---

参考链接：

1. [Install WSL](https://docs.microsoft.com/en-us/windows/wsl/install)
2. [TUN 模式](https://docs.cfw.lbyczf.com/contents/tun.html)

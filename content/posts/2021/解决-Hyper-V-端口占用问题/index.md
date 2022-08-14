---
title: "解决 Hyper-V 端口占用问题"
date: 2021-11-13T11:54:33+08:00
draft: false
slug: "hyper-v-reserved-port"
categories: ["系统设置"]
tags: ["Hyper-V", "Windows", "WSL"]
---

本文介绍了如何解决 Windows 系统开启 Hyper-V 之后端口被莫名占用的问题。

<!--more-->

在 Windows 操作系统中，当我们启用了 Hyper-V 或是 WSL 2（实际上 WSL 2 就是创建了一个 Hyper-V 虚拟机）之后，常常会遇到一些端口被占用的情况，而当我们使用 netstat 命令查找时，却又找不到是被什么程序占用了。

```
netstat -aon|findstr "port"
```

实际上，这些端口并不是被占用，而是被 Hyper-V 保留了。使用以下命令就可以查看 TCP 端口的保留范围。

```
netsh interface ipv4 show excludedportrange protocol=tcp
```

我们可以看到，Hyper-V 保留了很多低位端口。那么解决方案也就很简单了，只需将保留端口设置为不常用的高位端口就可以了。

```
netsh int ipv4 set dynamicport tcp start=50000 num=1000
netsh int ipv4 set dynamicport udp start=50000 num=1000
netsh int ipv6 set dynamicport tcp start=50000 num=1000
netsh int ipv6 set dynamicport udp start=50000 num=1000
```

重启之后，我们可以使用以下命令查看保留端口范围

```
netsh int ipv4 show dynamicport tcp

协议 tcp 动态端口范围
---------------------------------
启动端口        : 50000
端口数          : 1000
```

这时，Hyper-V 占用的就都是 50000 以上的高位端口了。

---

参考链接：

1. [The default dynamic port range for TCP/IP has changed](https://docs.microsoft.com/en-us/troubleshoot/windows-server/networking/default-dynamic-port-range-tcpip-chang)

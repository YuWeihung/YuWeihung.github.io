---
title: "在 WSL2 中启用 Systemd"
date: 2023-01-12T19:50:21+08:00
draft: false
slug: "wsl2-systemd"
categories: ["Windows"]
tags: ["Windows", "WSL"]
---

适用于 Linux 的 Windows 子系统，即 WSL，为使用 Windows 系统的程序员提供了一个便利的 GNU/Linux 环境。不过之前由于 WSL2 并不支持 systemd，所以当我们需要在 WSL 中起一些服务时就很不方便。好在现在 WSL2 已经原生支持了 systemd，本文就对如何安装 WSL2 和启用 systemd 进行简要的介绍。

<!--more-->

## 安装 WSL2

现在，可以使用单个命令安装运行 WSL 所需的一切内容。 在管理员模式下打开 PowerShell 或 Windows 命令提示符，输入 wsl --install 命令，然后重启计算机。

```
wsl --install
```

这会启用“虚拟机平台”以及“适用于 Linux 的 Windows 子系统”功能，并安装 Ubuntu 为 WSL2 的默认发行版。

重启后系统会自动安装并启动 Ubuntu，我们需要设置用户名及密码。

安装完成后，我们可以在 powershell 里查看 WSL 中发行版的版本。

```
> wsl -l -v
  NAME      STATE           VERSION
* Ubuntu    Running         2
```

我们可以看到运行的 Ubuntu 已经是 WSL2 版本。

## 启用 systemd

在 WSL 中修改 `/etc/wsl.conf` 文件

```
[boot]
systemd=true
```

然后在 powershell 中重启 WSL。

```
wsl.exe --shutdown
```

重启后可以在 WSL 中进行验证

```
ps --no-headers -o comm 1
```

如果返回 `systemd` 说明启用成功。

我们现在就可以通过 systemd 来管理服务了。例如开机自启动 docker

```
sudo systemctl enable docker.service
```

添加用户组

```
sudo usermod -aG docker $USER
```

我们还可以通过输入命令来查看 systemd 管理的服务状态。

```
systemctl list-unit-files --type=service
```

## 限制 WSL2 资源占用

WSL2 默认会占用系统一半的内存，我们可以通过配置文件来限制 WSL2 占用的资源。

修改 Windows 用户目录下 `.wslconfig` 文件，例如

```
[wsl2]
processors=4
memory=2GB
swap=2GB
```

限制 WSL2 使用 4 核处理器，2GB 内存以及 2GB 的交换空间。

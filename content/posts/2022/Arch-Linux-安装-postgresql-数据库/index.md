---
title: "Arch Linux 安装 PostgreSQL 数据库"
date: 2022-06-22T15:47:18+08:00
draft: false
slug: "archlinux-install-postgresql"
categories: ["Linux"]
tags: ["Arch Linux", "PostgreSQL"]
---

PostgreSQL 是一个强大的、开源的对象关系型数据库系统，经过 30 多年的积极开发，它在可靠性、功能稳健性和性能方面赢得了良好的声誉。本文记录了如何在 Arch Linux 上安装并配置 PostgreSQL 数据库。

<!--more-->

## 安装 PostgreSQL

首先就是更新系统并安装 PG 包

```
sudo pacman -Syu
sudo pacman -S postgresql
```

然后设置 PG 开机自启

```
sudo systemctl enable postgresql.service
```

不过，这时如何我们尝试启动 PG 服务的话就会报错，提示我们还没有初始化数据库。所以我们就根据提示来初始化数据库

```
su - postgres -c "initdb --locale zh_CN.UTF-8 -D '/var/lib/postgres/data'"
```

这样就可以启动 PG 了。

```
sudo systemctl start postgresql.service
```

然后就可以连接数据库了。

```
psql -U postgres
```

# 为数据库设置密码

首先修改 `/var/lib/postgres/data/pg_hba.conf`，设置认证方式为 `scram-sha-256`

```bash
# TYPE  DATABASE        USER            ADDRESS                 METHOD
# "local" is for Unix domain socket connections only
local   all             user                                    scram-sha-256
```

然后修改 `/var/lib/postgres/data/postgresql.conf`

```
password_encryption = scram-sha-256
```

重启服务

```
sudo systemctl restart postgresql.service
```

最后修改用户密码

```
ALTER USER postgres WITH ENCRYPTED PASSWORD 'password';
```

## PostgreSQL 常用命令

```
# 列出所有数据库
\l

# 连接数据库
\c dbname
# 或直接指定数据库名
psql -U postgres dbname

# 列出所有表格
\dt

# 显示指定表格信息
\d tablename
```

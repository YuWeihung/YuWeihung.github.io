---
title: "Debian 13 安装 PostgreSQL 17"
date: 2025-11-18T16:54:47+08:00
draft: false
slug: "debian13-postgresql"
categories: ["Linux"]
tags: ["debian", "postgresql"]
---

本文记录了如何在 Debian 13 上安装 PostgreSQL 17 并开启远程登录。

<!--more-->

```bash
apt update
apt install postgresql
```

修改 postgres 用户密码

```bash
su postgres
psql
ALTER USER postgres WITH PASSWORD '1234';
```

修改配置文件允许远程密码登录

```
cd /etc/postgresql/17/main/

vim pg_hba.conf

# IPv4 local connections:
# host    all             all             127.0.0.1/32            scram-sha-256
host    all             all             0.0.0.0/0            scram-sha-256

vim postgresql.conf


# - Connection Settings -

#listen_addresses = 'localhost'         # what IP address(es) to listen on;
listen_addresses = '*'                  # what IP address(es) to listen on;
                                        # comma-separated list of addresses;
                                        # defaults to 'localhost'; use '*' for all
                                        # (change requires restart)

systemctl restart postgresql
```

这样即可使用 postgres 用户远程连接到数据库了。需要注意的是，连接数据库所使用的密码为 postgresql 中 postgres 用户的密码（使用 ALTER USER postgres WITH PASSWORD 修改），而非 Linux 中 postgres 用户的密码（使用 passwd postgres 修改）。

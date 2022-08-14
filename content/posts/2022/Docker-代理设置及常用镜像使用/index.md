---
title: "Docker 代理设置及基本教程"
date: 2022-07-11T18:52:37+08:00
draft: false
slug: "docker-proxy-configure"
categories: ["Linux"]
tags: ["Docker", "代理"]
---

本文主要介绍了如何在 Docker 中设置代理加速访问，以及一些基本操作和常用镜像的使用。

<!--more-->

## 设置代理

Docker 守护程序在其启动环境中使用 `HTTP_PROXY`、`HTTPS_PROXY` 和 `NO_PROXY` 环境变量来配置 HTTP 或 HTTPS 代理。我们需要在 Docker systemd 服务文件中添加这些配置。

创建配置文件

```
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo vim /etc/systemd/system/docker.service.d/http-proxy.conf
```

并修改其内容为

```
[Service]
Environment="HTTP_PROXY=http://172.17.0.1:7890"
Environment="HTTPS_PROXY=http://172.17.0.1:7890"
Environment="NO_PROXY=localhost,127.0.0.1"
```

注意，代理的 HOST 需要设置为 docker 虚拟网卡的网段而不是 `127.0.0.1`，并开启代理软件的局域网访问。

完成修改并重启 docker

```
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## Docker 基本操作

在介绍各种基本指令之前，首先介绍如何通过添加用户组的方式来避免每次命令都需要输入 `sudo`

```
sudo usermod -aG docker $USER
```

重启系统后，我们的用户就在 docker 用户组中了。

### 镜像

Docker 把应用程序及其依赖，打包在 image 文件里面。只有通过这个文件，才能生成 Docker 容器。image 文件可以看作是容器的模板。Docker 根据 image 文件生成容器的实例。同一个 image 文件，可以生成多个同时运行的容器实例。

1. 列出所有 image 文件

```
docker image ls
# 或者
docker images
```

2. 获取 image

```
docker pull redis
```

默认 tag 为 latest，也可以自定义

```
docker pull redis:7.0.4
```

3. 删除 image

```
docker image rm [image_id]
## 或者
docker rmi [image_id]
```

### 容器

1. 列出容器

列出所有运行的容器

```
docker container ls
## 或者
docker ps
```

列出所有容器，包括终止的容器

```
docker container ls --all
## 或者
docker ps --all
```

2. 容器的运行和停止

运行容器（-d 为后台运行）

```
docker run -d --name redis-test redis
```

停止容器

```
docker stop redis-test
```

启动停止的容器

```
docker start redis-test
```

3. 删除容器

```
docker rm [container_id]
```

## 常用镜像使用

### postgres

运行容器

```bash
docker run --name test-pg -d --restart=unless-stopped -e POSTGRES_PASSWORD=1234 -p 5432:5432 postgres
```

进入数据库

```bash
docker exec -it test-pg /bin/bash

psql -U postgres
```

### redis

```bash
docker run --name test-redis -d --restart=unless-stopped -p 6379:6379 redis
```

### nginx

```bash
docker run --name test-nginx -d --restart=unless-stopped -p 80:80 nginx
```

### mysql

```bash
docker run --name test-mysql -d --restart=unless-stopped -p 3306:3306 -e MYSQL_ROOT_PASSWORD=1234 mysql
```

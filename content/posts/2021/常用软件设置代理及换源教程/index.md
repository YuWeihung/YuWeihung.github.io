---
title: "常用软件设置代理及换源教程"
date: 2021-09-13T20:11:32+08:00
draft: false
slug: "software-set-proxy-mirror"
categories: ["系统设置"]
tags: ["代理", "镜像加速"]
---

本文主要介绍一些常用软件的设置网络代理或者更换软件镜像源的方式。本文包括以下软件的设置：shell, git, apt, conda, maven, gradle, npm, yarn 以及 docker。

<!--more-->

## 1. shell

为 shell（以 zsh 为例）设置代理需要编辑 `~/zshrc`（ 用户为 `~/.rc`）文件，添加如下内容

```
export http_proxy=http://127.0.0.1:7890/
export https_proxy=http://127.0.0.1:7890/
```

然后执行

```
source .zshrc
```

此时运行在当前终端的应用程序就会应用此代理。

## 2. git

为 git 设置代理需要执行

```
git config --global http.proxy http://127.0.0.1:7890/
git config --global https.proxy http://127.0.0.1:7890/
```

需要注意的是，只有通过 HTTPS 方式进行 clone 或 push 等操作时才会应用此代理，而通过 SSH 方式时仍然为直连。

## 3. apt

为 apt 设置代理需要编辑 `/etc/apt/apt.conf.d/proxy.conf` 文件

```
Acquire::http::Proxy "http://127.0.0.1:7890/";
Acquire::https::Proxy "http://127.0.0.1:7890/";
```

## 4. conda

为 conda 设置代理需要编辑 `~/.condarc` 文件

```yaml
proxy_servers:
  http: http://127.0.0.1:7890/
  https: http://127.0.0.1:7890/
```

## 5. maven

为 maven 设置代理需要编辑 `~/.m2/settings.xml` 文件，修改其中的 <proxies> 部分

```xml
<proxies>
    <proxy>
      <id>http_proxy</id>
      <active>true</active>
      <protocol>http</protocol>
      <host>127.0.0.1</host>
      <port>7890</port>
    </proxy>
  </proxies>
```

## 6. gradle

为 gralde 设置代理需要编辑 `~/.gradle/gradle.properties` 文件

```properties
systemProp.http.proxyHost=127.0.0.1
systemProp.http.proxyPort=7890
systemProp.https.proxyHost=127.0.0.1
systemProp.https.proxyPort=7890
```

## 7. npm & yarn

由于前端开发时 node_modules 需要下载的小文件太多，使用代理的效果不好，所以 npm 不使用代理，而是设置国内的腾讯云镜像源。

npm 换源需要执行

```
npm config set registry https://mirrors.cloud.tencent.com/npm/
```

而 yarn 换源需要执行

```
yarn config set registry https://mirrors.cloud.tencent.com/npm/
```

## 8. docker

docker 同样推荐使用国内的阿里云镜像加速器。修改 `/etc/docker/daemon.json` 文件

```json
{
  "registry-mirrors": ["your.mirror.address"]
}
```

然后执行

```
sudo systemctl daemon-reload
sudo systemctl restart docker
```

---
title: "Spring Boot 前后端分离项目部署"
date: 2022-08-20T20:53:22+08:00
draft: false
slug: "spring-boot-deployment"
categories: ["后端"]
tags: ["Spring Boot", "Nginx"]
---

本文介绍了如何部署后端 Spring Boot 前端 React 的前后端分离项目。

<!--more-->

## 前端构建

打开前端项目，输入 `pnpm build` 构建生成 `dist` 文件夹。然后将该文件夹上传到服务器上，移动到 Nginx 的网站根目录中，默认为 `/usr/share/nginx/html`。

## 后端构建

使用 IDEA 打开后端项目，打开 gradle 工具栏，选择 `Task` -> `build` -> `bootJar`，就会在 `/build/libs/` 目录生成 jar 包。

然后将 jar 上传到服务器，输入命令使其后台运行并生成日志。

```bash
nohup java -jar project.jar > msg.log 2>&1
```

2>&1 的意思是将标准错误 2 重定向到标准输出 &1 ，标准输出 &1 再被重定向输入到 msg.log 文件中。

可以通过 `jobs` 命令查看后台运行的进程。 输入 `kill -9 pid` 来终止进程。

## 反向代理

要解决前后端分离的跨域问题，就需要使用 Nginx 做反向代理。在 [前文](https://www.yuweihung.com/posts/2022/vite-spring-cross-origin/) 中我们使用 Vite 解决了开发时的跨域问题，现在使用 Nginx 解决部署时的跨域问题。

修改 `/etc/nginx/nginx.conf`

```
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    # 反向代理
    location /api/ {
        rewrite ^/api/(.*)$ /$1 break;
        proxy_pass http://localhost:8080;
    }
}
```

这样所有到 80 端口 /api 的请求都会被转发到后端的 8080 端口。在浏览器访问时就不再存在跨域的问题。

另注：Nginx 的网站目录最好不要设置在个人账户的家目录中，因为 Nginx 默认使用的 http 账户不能读取家目录的内容，会引起 `403-Forbidden` 权限错误。

现在，项目部署完成，就可以访问了。

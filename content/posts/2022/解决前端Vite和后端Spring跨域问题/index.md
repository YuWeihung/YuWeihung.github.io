---
title: "解决前端 Vite 和后端 Spring 跨域问题"
date: 2022-05-25T12:09:08+08:00
draft: false
slug: "vite-spring-cross-origin"
categories: ["前端"]
tags: ["React", "Vite", "Kotlin", "Spring Boot", "Spring Security"]
---

本文主要介绍了如何解决前后端分离项目（前端：React + Vite，后端 Kotlin + Spring Security）的跨域问题。

<!--more-->

## 问题分析

前端的 Vite 运行在 http://localhost:5173，而后端的 Spring Boot 运行在 http://localhost:8080，端口号不同就带来了跨域（Cross-Origin）的问题。在默认情况下服务器不接受跨域的请求，这样请求就失败了。要解决这个问题有两种方法，分别是修改后端使其接受跨域请求，以及修改前端通过反向代理的方式直接消除跨域。下面分别介绍。

## 修改后端

如果修改后端，那就是要使服务器接受跨域请求。如果没有使用 Spring Security 的话，直接在 Controller 上添加 `@CrossOrgin` 注解就可以了。但是 Spring Security 默认禁用了 CORS（Cross-origin resource sharing，跨域资源共享），那就还需要打开 CORS。

在 `SecurityConfig` 文件里添加

```Kotlin
@Bean
fun filterChain(http: HttpSecurity): SecurityFilterChain {
    http {
        /* *** */
        cors { }
    }
}
```

这样就启用了 CORS。但是，这样还需要我们在每一个 Controller 文件中添加 `@CrossOrigin` 注解，还是比较麻烦。更好的办法是直接全局修改响应头部。还是修改 `SecurityConfig` 文件

```Kotlin
@Bean
fun filterChain(http: HttpSecurity): SecurityFilterChain {
    http {
        /* *** */
        cors { }
    }
}

@Bean
fun corsConfigurationSource(): CorsConfigurationSource {
    val source = UrlBasedCorsConfigurationSource()
    val configuration = CorsConfiguration()
    configuration.addAllowedOrigin("http://127.0.0.1:5173")
    configuration.allowCredentials = true
    configuration.addAllowedMethod("*")
    configuration.addAllowedHeader("*")
    configuration.addExposedHeader("*")
    source.registerCorsConfiguration("/**", configuration)
    return source
}
```

注意，当 `allowCredentials` 设置为 true 时，`allowedOrigin` 不能设置为 \* ，需要设置为具体的地址。这样，就可以正常接收前端的请求了。

## 修改前端

当然，解决问题的最好办法就是直接消除跨域问题，而 Vite 正好提供了非常便利的解决方案。

修改 `vite.config.ts` 文件

```TypeScript
export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      "/api": {
        target: "http://localhost:8080",
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ""),
      },
    },
  },
});
```

Vite 服务器会架设代理，将 localhost:5173/api 的请求反向代理到 localhost:8080，这样 ip 和端口都一致，就不存在跨域的问题了。当然，这时请求的地址也要从 localhost:8080 修改到 /api 了。

---

参考链接：

1. [Vite 官方文档](https://cn.vitejs.dev/config/server-options.html)

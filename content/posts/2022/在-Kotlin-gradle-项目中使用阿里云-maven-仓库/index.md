---
title: "在 Kotlin Gradle 项目中使用阿里云 Maven 仓库"
date: 2022-06-03T19:20:44+08:00
draft: false
slug: "gradle-kts-aliyun-maven"
categories: ["后端"]
tags: ["Gradle", "Kotlin", "镜像加速"]
---

本文主要介绍了如何在 Kotlin 的 Gradle 项目中使用阿里云的 Maven 仓库加速。

<!--more-->

## 修改编译仓库地址

第一步是修改项目依赖的仓库地址。这也是网上的很多教程中所讲到的内容，在 Maven 中心仓库和本地仓库之前添加阿里云的镜像仓库。

修改 `build.gradle.kts` 文件

```
repositories {
	maven {
        url = uri("https://maven.aliyun.com/repository/public/")
    }
    mavenLocal()
    mavenCentral()
}
```

## 修改插件仓库地址

第二步就是本文的重头戏了。在修改了上文的仓库地址后，我们会发现大部分的请求还是没有走阿里云的镜像。通过查阅官方文档，我发现原来这些是属于 Gradle 的插件，仓库地址需要另行配置。`build.gradle.kts` 中的 `plugins {}` 段默认从 [Gradle Plugin Portal](https://plugins.gradle.org/) 中解析，我们要做的就是修改它的解析仓库地址。

修改 `settings.gradle.kts` 文件

```
pluginManagement {
    repositories {
        maven(url = "https://maven.aliyun.com/repository/gradle-plugin")
        gradlePluginPortal()
    }
}
```

这样，该项目的全部依赖就都会走阿里云的 Maven 镜像仓库了。

## 全局修改仓库地址

上面的内容只是修改了单个项目的仓库地址，这样如果每个项目都一个个修改的话就太麻烦了。那么有没有全局修改的办法呢？

答案当然是有的，那就是修改 `init.gradle.kts` 初始化脚本。初始化脚本的位置为 `USER_HOME/.gradle/init.gradle.kts'。添加如下内容

```kotlin
allprojects {
    repositories {
	    maven {
           url = uri("https://maven.aliyun.com/repository/public/")
       }
       mavenLocal()
       mavenCentral()
    }
}

settingsEvaluated {
    pluginManagement {
        repositories {
            maven(url = "https://maven.aliyun.com/repository/gradle-plugin")
            gradlePluginPortal()
        }
    }
}
```

这样全部项目就都会走阿里云的镜像仓库了。

## Groovy 修改方式

另附 Groovy DSL 的修改方式。修改 `init.gradle` 脚本

```groovy
allprojects {
    repositories {
	    maven {
           url "https://maven.aliyun.com/repository/public/"
       }
       mavenLocal()
       mavenCentral()
    }
}

settingsEvaluated { settings ->
    settings.pluginManagement {
        repositories {
            maven {
                url "https://maven.aliyun.com/repository/gradle-plugin"
            }
            gradlePluginPortal()
        }
    }
}
```

---

参考链接：

1. [Declaring repositories](https://docs.gradle.org/current/userguide/declaring_repositories.html)
2. [Using Gradle Plugins](https://docs.gradle.org/current/userguide/plugins.html)

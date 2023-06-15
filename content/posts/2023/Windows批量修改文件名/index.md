---
title: "Windows 批量修改文件名"
date: 2023-04-11T17:39:09+08:00
draft: false
slug: "windows-batch-rename"
categories: ["Windows"]
tags: ["Windows"]
---

本文介绍了两种在 Windows 系统中批量重命名文件的方法。

<!--more-->

1. Everything

使用 Everything 搜索文件路径，选中文件之后可以直接按 F2 键批量重命名，支持正则表达式。

例如，电视剧视频文件名很长，我们只想保留需要的部分：

- 原文件名：后宫·甄嬛传.Empresses.in.the.Palace.S01E01.2011.2160p.WEB-DL.H265.60FPS.AAC.mp4

- 原始文件名表达式：%1.%2.S01E%3.%4.mp4

- 新文件名表达式：%1.E%3.mp4

- 新文件名：后宫·甄嬛传.E01.mp4

2. Bat 脚本

以批量去除文件名中的某个字符串为例：

```bat
@echo off
set /p str1= 请输入要替换的文件 / 文件夹名字符串（空格亦适用）：
set /p str2= 请输入替换后的文件 / 文件夹名字符串（删除则直接回车）：
set /p str3= 请选择 仅处理文件（输入1）/ 仅处理文件夹（输入2）/ 均需要处理（输入3）：
echo=
echo 正在修改中，请稍候……（完成后会自动退出！）

::-----文件-----
if %str3% EQU 1 (set decision='dir /a:-d /b')
::-----文件夹-----
if %str3% EQU 2 (set decision='dir /a:d /b')
::-----文件+文件夹-----
if %str3% EQU 3 (set decision='dir /b')

for /f "tokens=* delims=" %%i in (%decision%) do (
if "%%~nxi" neq "%~nx0" (
set "file=%%i"
set "name=%%~ni"
set "extension=%%~xi"
call set "name=%%name:%str1%=%str2%%%"
setlocal enabledelayedexpansion
ren "!file!" "!name!!extension!" 2>nul
endlocal)
)
exit
```

注意，需要使用 GBK 编码保存，否则中文会乱码。放到需要重命名的目录下运行。

---

参考链接：

1. [如何批量去除文件名中的某些字符串？ - Outside 的回答 - 知乎](https://www.zhihu.com/question/29446913/answer/2120769515)

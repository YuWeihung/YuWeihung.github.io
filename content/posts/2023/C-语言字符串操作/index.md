---
title: "C 语言字符串操作"
date: 2023-02-14T23:24:15+08:00
draft: false
slug: "c-string"
categories: ["编程语言"]
tags: ["C", "字符串"]
---

在 C 语言中，字符串实际上是使用空字符 \0 结尾的一维字符数组。C 标准库提供了一系列对于字符串的操作，大多定义在头文件 <string.h> 中。本文对一些常用的字符串操作进行记录。

<!--more-->

### 1. 初始化字符串

我们可以直接使用数组初始化规则来初始化字符串。注意，C 编译器会在初始化时自动将 \0 放在字符串的末尾。

```c
char str1[12] = "hello";
```

### 2. 输入和输出

我们有两种方法来输入和输出字符串。一种是使用格式化输入输出的 scanf() 和 printf()，另一种是使用 gets() 和 puts()。scanf() 与 gets() 的一个重要区别是 scanf() 遇到空格就会终止，而 gets()会读入完整的一行。函数 puts() 从参数指定的地址开始输出，遇到第一个 \0 后终止，并自动追加一个换行符。

```c
char str1[12];
char str2[12];
scanf("%s", str1);
prinf("%s\n", str1);
gets(str2);
puts(str2);
```

### 3. 字符串赋值

```c
char *strcpy(char *dest, const char *src)
```

把 src 所指向的字符串复制到 dest，返回值为一个指向最终的目标字符串 dest 的指针。

```c
`char *strncpy(char *dest, const char *src, size_t n)
```

把 src 所指向的字符串复制到 dest，最多复制 n 个字符。当 src 的长度小于 n 时，dest 的剩余部分将用空字节填充，返回值为最终复制的字符串。需要注意的是，如果 src 的长度大于 n，strncpy() 并不会自动加上终止符 \0，需要手动添加。

```c
char str1[14] = "hello, world!";
char str2[14];
char str3[11];
strcpy(str2, str1);
strncpy(str3, str1, 10);
str3[10] = '\0';
printf("str2: %s\n", str2);
printf("str3: %s\n", str3);
```

最终结果为：

```
str2: hello, world!
str3: hello, wor
```

### 4. 字符串连接

```c
char *strcat(char *dest, const char *src)
char *strncat(char *dest, const char *src, size_t n)
```

strcat() 把 src 所指向的字符串追加到 dest 所指向的字符串的结尾。strncat() 会将 src 所指向的字符串不多于 n 个字符追加到 dest 所指向的字符串的结尾。其他函数名加 n 的函数与之类似，下面不再一一说明。

```c
char str1[20] = "Hello, ";
char str2[10] = "Tom";
strcat(str1, str2);
printf("%s\n", str1);
```

结果为

```
str1: Hello, Tom
```

### 5. 字符串长度

```c
size_t strlen(const char *str)
```

strlen() 计算字符串 str 的长度，直到空结束字符，但不包括空结束字符。

### 6. 字符串比较

```c
int strcmp(const char *str1, const char *str2)
int strncmp(const char *str1, const char *str2, size_t n)
```

strcmp() 把 str1 所指向的字符串和 str2 所指向的字符串进行比较。strcmp() 从左至右依次按 ASCII 码对比两个字符串的字符，直至遇到不同的字符或 \0。返回值为整数，等于 1 表示 str1 > str2， 等于 0 表示 str1 = str2，等于 -1 表示 str1 < str2。

### 7. 查找字符

```c
char *strchr(const char *str, int c)
char *strrchr(const char *str, int c)
```

strchr() 用于查找字符串中的一个字符，如果在字符串 str 中找到字符 c，则函数返回指向第一次出现的该字符的指针，如果未找到该字符则返回 NULL。strrchr() 则返回指向最后一次出现的该字符的指针。

```c
char str[] = "hello";
char ch = 'l';
char *ptr1 = strchr(str, ch);
char *ptr2 = strrchr(str, ch);
printf("*ptr1 = %s\n", ptr1);
printf("*ptr2 = %s\n", ptr2);
```

结果为

```
*ptr1 = llo
*ptr2 = lo
```

### 8. 查找子串

```c
char *strstr(const char *str1, const char *str2)
```

strstr() 返回字符串 str1 中第一次出现 str2 的位置，如果没找到返回 NULL。

```c
char str1[] = "hello";
char str2[] = "ll";
char *ptr = strstr(str1, str2);
printf("*ptr = %s\n", ptr);
```

结果为

```
*ptr = llo
```

### 9. 字符串转换为数值

字符串与数值转换的函数定义在头文件 <stdlib.h> 中。

```c
double atof(const char *str)
int atoi(const char *str)
long int atol(const char *str)
```

atof 将 str 转换为一个浮点数，atoi 将 str 转换为一个整数，atol 将 str 转换为一个长整数。

```c
char str[] = "123.4";
int a = atoi(str);
double b = atof(str);
printf("a = %d\n", a);
printf("b = %.1lf\n", b);
```

结果为

```
a = 123
b = 123.4
```

### 10. 字符检查

<ctype.h> 头文件定义了一系列的字符检查函数。

```c
// 该函数检查所传的字符是否是字母和数字。
int isalnum(int c)
// 该函数检查所传的字符是否是字母。
int isalpha(int c)
// 该函数检查所传的字符是否是控制字符。
int iscntrl(int c)
// 该函数检查所传的字符是否是十进制数字。
int isdigit(int c)
// 该函数检查所传的字符是否是十六进制数字。
int isxdigit(int c)
// 该函数检查所传的字符是否是小写字母。
int islower(int c)
// 该函数检查所传的字符是否是大写字母。
int isupper(int c)
// 该函数检查所传的字符是否是标点符号字符。
int ispunct(int c)
// 该函数检查所传的字符是否是空白字符。
int isspace(int c)
// 该函数检查所传的字符是否有图形表示法。
int isgraph(int c)
// 该函数检查所传的字符是否是可打印的。
int isprint(int c)
```

其中，字母数字字符包含数字、小写字母和大写字母；空白字符包含制表符、换行符、垂直制表符、换页符、回车符和空格符；图形字符包含字母数字字符和标点符号字符；可打印字符包含字母数字字符、标点符号字符和空白字符；控制字符包含 ASCII 编码的八进制代码从 000 到 037，以及 177（DEL）的字符。

另外，标准库还包含两个转换函数

```c
// 该函数把大写字母转换为小写字母。
int tolower(int c)
// 该函数把小写字母转换为大写字母。
int toupper(int c)
```

对于 tolower()，如果 c 有相对应的小写字母，则该函数返回 c 的小写字母，否则返回 c 的原值。toupper() 与之类似。

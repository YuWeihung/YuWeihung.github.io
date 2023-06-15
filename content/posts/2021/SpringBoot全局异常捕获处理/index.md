---
title: "Spring Boot 全局异常捕获处理"
date: 2021-12-27T17:24:33+08:00
draft: false
slug: "spring-exception-handle"
categories: ["后端"]
tags: ["Java", "Spring Boot", "异常处理"]
---

本文主要介绍了如何实现 Spring Boot 项目的全局异常捕获并处理。

<!--more-->

## 背景

异常处理是我们的 Web 项目中必不可少的一环。当发生了业务异常，如用户名不存在或是密码错误时，后端就需要将错误码和异常信息提供给前端，再要求用户实施进一步的操作。

一种基本的方法就是在 Controller 层的每个接口中进行 try-catch，当捕获到异常时就根据异常类别返回对应的信息。不过这样会使得代码非常冗长，也不利于代码的维护。那么有没有什么比较优雅的处理办法呢？答案是肯定的，那就是 Spring Boot 的 ControllerAdvice 机制，下面进行介绍（注意，为方便起见，本文的项目引入了 Lombok）。

## 异常定义

异常处理的第一步首先是要定义异常。

### 基础异常接口类

首先定义一个基础的异常接口 `BaseErrorInterface`。里面包含两个方法，分别是获得错误码和获得异常信息。

```java
public interface BaseErrorInterface {
    String getCode();

    String getMsg();
}
```

### 错误码枚举类

然后定义自己的错误码枚举类 `ErrorCode`。定义项目中可能存在的异常，并实现上述接口的方法。

```java
@AllArgsConstructor
public enum ErrorCode implements BaseErrorInterface {
    USER_NOT_FOUND("4001", "用户名不存在"),
    USER_ALREADY_EXIST("4002", "用户名已存在"),
    PASSWORD_WRONG("4003", "密码错误"),
    UNKNOWN_WRONG("9999", "发生了未知错误");

    private final String code;
    private final String msg;

    @Override
    public String getCode() {
        return code;
    }

    @Override
    public String getMsg() {
        return msg;
    }
}
```

### 自定义异常实现类

最后是创建一个类 `ErrorException`，完成异常定义并实现上述的基础异常接口。

```java
public class ErrorException extends RuntimeException implements BaseErrorInterface {
    private BaseErrorInterface errorCode;

    public ErrorException() {
        super();
    }

    public ErrorException(ErrorCode errorCode) {
        super(errorCode.getCode());
        this.errorCode = errorCode;
    }

    public ErrorException(ErrorCode errorCode, Throwable throwable) {
        super(errorCode.getCode(), throwable);
        this.errorCode = errorCode;
    }

    @Override
    public String getCode() {
        return errorCode.getCode();
    }

    @Override
    public String getMsg() {
        return errorCode.getMsg();
    }
}
```

这样异常定义的工作就完成了。

## 全局异常捕获处理

### HTTP 响应封装

定义类 `Response`，包含`code`，`msg`，`data`三个字段。code 为错误码，msg 为异常信息，而 data 为正常返回内容。

```java
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Response {
   private String code;
   private String msg;
   private Object data;

   public static Response success(Object data) {
      return Response.builder().data(data).build();
   }

   public static Response failure(BaseErrorInterface e) {
      return Response.builder().code(e.getCode()).msg(e.getMsg()).build();
   }
}
```

### ControllerAdvice

最后就是创建全局异常捕获类了。在 Controller 层创建 `ExceptionHandlerController`，这样当调用 API 发生异常时它就可以捕获并统一处理了。

```java
@ControllerAdvice
public class ExceptionHandlerController {
    @ExceptionHandler(value = ErrorException.class)
    public ResponseEntity<Response> handleErrorException(ErrorException e) {
        Response response = Response.failure(e);
        return ResponseEntity.ok(response);
    }

    @ExceptionHandler(value = Exception.class)
    public ResponseEntity<Response> handleOtherException() {
        BaseErrorInterface errorCode = ErrorCode.UNKNOWN_WRONG;
        Response response = Response.failure(errorCode);
        return ResponseEntity.ok(response);
    }
}
```

这样全局捕获异常的功能就实现了。

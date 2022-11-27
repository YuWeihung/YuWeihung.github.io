---
title: "JWT 登录简介"
date: 2022-12-13T21:58:17+08:00
draft: false
slug: "introduction-to-jwt"
categories: ["后端"]
tags: ["JWT", "Spring Security"]
---

JSON Web Token（简写为 JWT）是目前最流行的跨域认证解决方案。本文简要介绍了它的原理和用法。

<!--more-->

## JWT 的结构

JWT 由三个部分组成

- Header （头部）
- Payload （负载）
- Signature （签名）

其中 Header 和 Payload 部分需要通过 Base64URL 算法编码成字符串。

下面是一个 JWT 的样例

{{<img src="1.png" width="60%">}}

三部分分别用红色、紫色和蓝色来标明。

### Header

Header 表明了使用什么签名算法，如上例

```JSON
{
  "alg": "RS256"
}
```

表明该 JWT 使用 RS256 签名算法。

### Payload

Payload 用来存放需要传输的数据。JWT 官方规定了 7 个字段，可供选用。

- iss (issuer)：签发人
- exp (expiration time)：过期时间
- sub (subject)：主题
- aud (audience)：受众
- nbf (Not Before)：生效时间
- iat (Issued At)：签发时间
- jti (JWT ID)：编号

除此之外，我们还可以定义私有字段。如上例

```JSON
{
  "iss": "self",
  "sub": "Tom",
  "exp": 1669595177,
  "iat": 1669559177,
  "scope": "ROLE_USER"
}
```

subject 设置为用户名 Tom，签发时间和过期时间使用一个 UNIX 时间戳，并通过 scope 字段表明 Tom 的角色权限为 ROLE_USER。

### Signature

Signature 部分是对前两部分的签名，防止数据篡改。

如 RS256 签名算法为

```
RSASHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  publicKey,
  privateKey
)
```

算出签名以后，把 Header、Payload、Signature 三个部分拼成一个字符串，每个部分之间用 "." 分隔，返回给用户。

## JWT 的使用方式

当客户端收到服务器发送的 JWT 之后，就可以将其储存起来。此后，客户端每次与服务端通信，都需要携带这个 JWT 作为身份证明。一般的方法是放在 HTTP 请求的头部:

```
Authorization: Bearer <token>
```

当此 JWT 过期之后就需要申请新的 JWT。

## JWT 密钥生成

Spring Security 的 JWT 登录默认使用 RS256 签名算法，并要求公私钥为 PKCS#8 格式。我们可以通过 openssl 来生成密钥。

如果使用的是老版本的 openssl （如 1.1.1)，那么默认生成私钥的为 PKCS#1 格式，需要我们转换成 PKCS#8 格式。

```bash
openssl genrsa -out private.key

openssl rsa -in private.key -pubout app.pub

openssl pkcs8 -topk8 -in private.key -nocrypt -out app.key
```

而如果我们使用的是新版本的 openssl （如 3.0.x），那么默认生成的密钥就是 PKCS#8 格式。

```bash
openssl genrsa -out app.key

openssl rsa -in app.key -pubout app.pub
```

---
title: "Spring Data JPA 关系映射"
date: 2022-12-08T12:16:37+08:00
draft: true
slug: "spring-data-jpa-relationship"
categories: ["后端"]
tags: ["Kotlin", "JPA", "PostgreSQL"]
---

本文主要介绍了如何使用 Spring Data JPA 操作 PostgreSQL 数据库。

<!--more-->

## Spring Data JPA 介绍

## JPA 基本使用

## JPA 关系映射

### @OneToOne

### @OneToMany

### @ManyToMany

下面以“用户-权限”关系来说明多对多关系。

User 表

```kotlin
@Entity
@Table(name = "\"user\"")
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "user_role",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "role_id")]
    ) var roles: MutableSet<Role> = mutableSetOf(),
)
```

Role 表

```kotlin
@Entity
@Table(name = "role")
class Role(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @ManyToMany(mappedBy = "roles", fetch = FetchType.LAZY)
    var users: MutableSet<User> = mutableSetOf(),
)
```

这样就会创建一个名为 "user_role" 的中间表来存储 User 和 Role 的关系，表的内容为 User 和 Role 的主键。

### @ElementCollection

下面以“商品-订单”关系来介绍一种相对复杂的映射关系。

```kotlin
\\ 商品表
@Entity
@Table(name = "product")
class Product(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null
)

\\订单表
@Entity
@Table(name = "\"order\"")
class Order(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @ElementCollection
    @CollectionTable(
        name = "order_product",
        joinColumns = [JoinColumn(name = "product_id")]
    )
    @Column(name = "product_amount")
    @MapKeyJoinColumn(name = "order_id")
    var products: MutableMap<product, Int> = mutableMapOf()
)
```

这样也会创建一个名为 "order_product" 的中间表来存储订单中各类商品的数量关系，表的内容为

| order_id | product_id | product_amount |
| -------- | ---------- | -------------- |
| 1001     | 2050       | 3              |

## 开启审计

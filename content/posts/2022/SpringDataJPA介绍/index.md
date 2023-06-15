---
title: "Spring Data JPA 介绍"
date: 2022-11-27T12:16:37+08:00
draft: false
slug: "spring-data-jpa-relationship"
categories: ["后端"]
tags: ["Kotlin", "JPA", "PostgreSQL"]
---

本文主要介绍了 Kotlin 如何使用 Spring Data JPA 来操作 PostgreSQL 数据库。

<!--more-->

## Spring Data JPA 介绍

Spring Data JPA 是一个流行的 Java (Kotlin) ORM 库，也是 Spring 大家庭的一员。JPA 力图通过面向对象（Object Oriented）的思想来操作数据库，以减少实现数据访问层（DAO）的工作量。我们只需定义存储库接口，Spring 就会自动提供实现。

## JPA 基本使用

在使用 JPA 之前，首先要进行相关信息的配置。修改 `application.properties` 文件

```
# postgres
spring.datasource.url=jdbc:postgresql://localhost:5432/bookstore
spring.datasource.username=postgres
spring.datasource.password=1234
spring.datasource.driver-class-name=org.postgresql.Driver
# jpa
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
```

postgres 部分定义了数据库的地址，用户名和密码，以及数据库的驱动。而 JPA 部分则定义了 JPA 运行时的一些行为，比如在启动时如何更新表结构等。

我们首先定义实体类。创建文件 `User.kt`

```kt
@Entity
@Table(name = "\"user\"")
class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @Column(name = "username", nullable = false)
    var username: String

    @Column(name = "password", nullable = false)
    var password: String
}
```

`@Entity` 注解表明这是一个实体类，而 `@Table` 标注表名。注意表名 user 的前后加了转义后的双引号，是因为 user 是 PostgreSQL 里的保留字，这样才能成功建表。

表的字段首先是主键 id，用 `@Id` 注解表明。`@GeneratedValue` 表明了主键的生成策略，这里选择 `IDENTITY`，即由数据库生成自增主键。`@Colume` 注解表明字段名以及该字段是否可为 `null`。后面的两个字段 username 和 password 也类似，这样就定义了一个有三个字段的表。

| id  | username | password |
| --- | -------- | -------- |
| 1   | abc      | 123456   |

接下来我们定义数据访问接口。创建文件 `UserRepository.kt`

```kt
interface UserRepository : JpaRepository<User, Long> {
    // 根据用户名查询
    fun findByUsername(username: String): User?

    // 根据用户名计数
    fun countByUsername(username: String): Long
}
```

这样就定义好了两个查询方法，分别是根据用户名来查询用户和根据用户名来计数。除此之外，JPA 还默认生成了 findById() 方法，只不过它返回的结果并不是我们定义的 User 类，而是一个 Optional 对象，需要进一步的操作才能取出对象。

上面介绍了“增删改查”中的查，JPA 的 “增、改”操作都是由 save() 方法实现，“删”是由 delete() 方法实现。下面举个例子来说明如何使用 JPA 来操作数据库。

```kt
// 根据用户名查询
val user1 = userRepository.findByUsername("abc")
// 修改密码
user1.password = "654321"
userRepository.save(user1)
// 根据主键查询
val user2 = userRepository.findById("def").orElse(null)
// 删除用户
userRepository.delete(user2)
// 根据用户名计数
val count = userRepository.countByUsername("ghi")
```

## JPA 关系映射

上面介绍了 JPA 的基本用法，下面介绍如何用 JPA 实现数据表之间的映射关系，即一对一，一对多和多对多关系。

### @OneToOne

一对一是最简单的映射关系。例如一个人只有一张身份证，而一张身份证对应一个人。一对一关系可以由任何一方来维护。

```kt
// 公民表
@Entity
@Table(name = "Person")
class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @OneToOne
    var idCard: IdCard? = null
}

// 身份证表
@Entity
@Table(name = "IdCard")
class IdCard {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @OneToOne(mappedBy = "idCard")
    var person? = null
}
```

mappedBy 表明这个一对一关系由 Person 表维护。

### @OneToMany

一对多关系也很常见，例如书籍和出版社的关系。每本书籍只有一个出版社，而一个出版社对应很多本书籍。一对多关系通常由多的那一方来维护。

```kt
// 书籍表
@Entity
@Table(name = "Book")
class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @ManyToOne
    var press: Press? = null
}

// 出版社表
@Entity
@Table(name = "Press")
class Press {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @OneToMany(mappedBy = "press")
    var books: MutableSet<Book> = mutableSetOf()
}
```

这样 Press 的主键会作为一个字段插入到 Book 表中。Book 表就像这样

| id  | press_id |
| --- | -------- |
| 1   | 2        |

而如果我们指定让一的一方维护关系的话，就需要一个中间表来存储关系，增大了系统的复杂度。

### @ManyToMany

书籍和作者的关系是一种典型的多对多关系。每本书籍可以有多个作者，而每个作者也可以对应多本书籍。多对多关系可以由双方的任一方来维护。多对多关系需要一个中间表来存储。

```kotlin
// 书籍表
@Entity
@Table(name = "book")
class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTabler
        name = "book_author",
        joinColumns = [JoinColumn(name = "book_id")],
        inverseJoinColumns = [JoinColumn(name = "author_id")]
    ) var authors: MutableSet<Author> = mutableSetOf(),
}

// 作者表
@Entity
@Table(name = "author")
class Author {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @ManyToMany(mappedBy = "authors")
    var books: MutableSet<Book> = mutableSetOf(),
}
```

这样就会创建一个名为 "book_author" 的中间表来存储 Book 和 Author 的关系，表的内容为 Book 和 Author 的主键。

| book_id | author_id |
| ------- | --------- |
| 3       | 5         |

### @ElementCollection

下面以“商品-订单”关系来介绍一种相对复杂的映射关系。在订单中有多种商品，而每个商品又有着不同的数量，这时可以通过 `@ElementCollecion` 和 `MapKeyJoinColumn` 来实现。

```kotlin
// 商品表
@Entity
@Table(name = "product")
class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null
}

//订单表
@Entity
@Table(name = "\"order\"")
class Order {
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
}
```

这样也会创建一个名为 "order_product" 的中间表来存储订单中各类商品的数量关系，表的内容为

| order_id | product_id | product_amount |
| -------- | ---------- | -------------- |
| 1001     | 2050       | 3              |
| 1001     | 2077       | 2              |

## 添加索引

我们可以使用 `@Table` 注解来添加索引。如

```kt
@Entity
@Table(
    name = "book",
    indexes = [
        Index(name = "idx_name", columnList = "name", unique = false),
        Index(name = "uni_isbn", columnList = "isbn", unique = true),
    ]
)
class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @Column(name = "name", nullable = false)
    var name: String,

    @Column(name = "isbn", nullable = false)
    var isbn: String,
}
```

上面为 Book 表添加了两条索引，分别是对于书籍名字的普通索引和对于 ISBN 编号的唯一索引。通过索引可以大大提高数据的查询速度。

## 开启审计

JPA 的审计功能可以方便地记录数据项的创建时间和最后修改时间，只需要在实体类上添加 `@EntityListeners` 注解。

```kt
@Entity
@Table(name = "\"user\"")
@EntityListeners(AuditingEntityListener::class)
class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null

    @CreatedDate
    @Column(name = "created_time", nullable = false)
    var createdTime: LocalDateTime? = null

    @LastModifiedDate
    @Column(name = "modified_time", nullable = false)
    var modifiedTime: LocalDateTime? = null
}
```

## 实体类继承

如果我们想要所有的实体类都继承自一个基类的话，可以使用 `MappedSuperclass` 注解。

被该注解标注的类不会在数据库中创建单独的表，但该类所拥有的属性都将映射到其子类的数据库表的字段中。

例如

```kt
// 基类
@MappedSuperclass
class BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Long? = null
}

// 用户表
@Entity
@Table(name = "\"user\"")
class User: BaseEntity() {
    @Column(name = "username", nullable = false)
    var username: String

    @Column(name = "password", nullable = false)
    var password: String
}
```

这样 User 表就有三个字段，分别是 `id`，`username` 以及 `password`。

## Kotlin All-open 插件

由于 Spring AOP 的设计，所有 Spring 相关的类都需要是 open 的。我们可以使用 `all-open` 插件来方便地解决这一问题。

`all-open` 插件默认支持以下注解：

- `@Component`
- `@Async`
- `@Transactional`
- `@Cacheable`
- `@SpringBootTest`

由于 `@Component` 是 `@Configuration`、`@Controller`、`@RestController`、`@Service` 以及 `@Repository` 的元注解，所以以上注解也都默认为 open。

所以，我们只需要在插件中添加 JPA 相关注解就可以了。

修改 `build.gradle.kts` 文件

```kt
allOpen {
    annotation("jakarta.persistence.MappedSuperclass")
    annotation("jakarta.persistence.Entity")
}
```

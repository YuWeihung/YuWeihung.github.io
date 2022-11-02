---
title: "JavaScript 高阶函数"
date: 2022-09-14T18:50:02+08:00
draft: true
slug: "javascript-functional-programming"
categories: ["前端"]
tags: ["JavaScript", "函数式编程"]
---

高阶函数，就是以函数作为参数或是返回值的函数，是函数式编程的基本思想之一。本文介绍了 JavaScript 中对于数组的一系列高阶函数，包括 map, reduce, filter, sort 等。

<!--more-->

## map

map() 的效果是将一个函数作用于数组的每一个元素，并返回一个新的数组。

例如，f(x) = x^2，要把这个函数作用于数组[1, 2, 3, 4, 5]，就可以使用 map

```js
function pow(x) {
  return x * x
}

const a = [1, 2, 3, 4, 5]
const b = a.map(pow)
console.log(b)
```

当然，也可以使用箭头函数来简化代码

```js
const a = [1, 2, 3, 4, 5]
const b = a.map((x) => x * x)
console.log(b)
```

得到结果 [1, 4, 9, 16, 25]。

## reduce

reduce() 的效果是对数组的每一个元素按序执行 reduce 函数，每次执行 reduce 都会将先前元素的计算结果作为参数传入，最后将其结果返回为单个值。

例如对数组 [1, 2, 3, 4, 5] 求和

```js
const a = [1, 2, 3, 4, 5]
const b = a.reduce((sum, x) => sum + x, 0)
console.log(b)
```

得到结果 15。

reduce() 接收两个参数，第一个参数是一个 reduce 函数，第二个参数是初始值。如上文的 reduce 函数是将当前值依次累加到前面所有数的和上，而初始值被设为 0。

如果不传递初始值，那么 reduce 会将第一个元素作为初始值，而 reduce 函数将会从第二个元素开始执行。在本问题中，这两种写法得到的结果是一致的。

```js
const a = [1, 2, 3, 4, 5]
const b = a.reduce((sum, x) => sum + x)
console.log(b)
```

## filter

filter() 正如它的名字过滤器，输入一个函数，筛选出符合条件的元素，返回一个新的数组。

例如过滤出 [1, 2, 3, 4, 5] 中的奇数

```js
const a = [1, 2, 3, 4, 5]
const b = a.filter((x) => x % 2 === 1)
console.log(b)
```

得到结果 [1, 3, 5]。

## sort

sort() 接收一个比较函数，对数组进行原地排序。sort() 的默认行为是将元素转换为字符串，然后比较它们的 UTF-16 值。

例如，对 [10, 20, 1, 2] 进行排序

```js
const a = [10, 20, 1, 2]
a.sort()
console.log(a)
```

得到结果 [1, 10, 2, 20]，这就是按照字符串编码排序得到的。

而如果想要按数值的升序排序，可以传入一个比较函数。比较函数的规则是

| compare(a, b) 返回值 | 排序顺序               |
| -------------------- | ---------------------- |
| > 0                  | a 在 b 后              |
| < 0                  | a 在 b 前              |
| === 0                | 保持 a 和 b 的顺序不变 |

因此，可以通过 a - b 来方便地使数组按从小到大排列。

```js
const a = [10, 20, 1, 2]
a.sort((x, y) => x - y)
console.log(a)
```

这时得到结果 [1, 2, 10, 20]。

## every

every() 类似于 filter()，输入一个函数，检验数组的每一个元素是否都满足条件。

例如，检验数组元素是否都是偶数

```js
const arr1 = [1, 2, 3, 4]
const arr2 = [2, 4, 6, 8]
const b1 = arr1.every((x) => x % 2 === 0)
const b2 = arr2.every((x) => x % 2 === 0)
console.log(b1)
console.log(b2)
```

得到结果分别为 false, true。

## find

find() 返回符合条件的第一个元素，如果找到了，返回这个元素，如果没找到，返回 `undefined`。

```js
const a = [1, 2, 3, 4]
const b = a.find((x) => x > 2)
console.log(b)
```

返回 3。

## findIndex

findIndex() 类似于 find()，只不过返回的是符合条件的第一个元素的索引，如果没找到，返回 -1。

## forEach

forEach() 类似于 map()，也会对每一个元素执行一次给定的函数，不过它不会返回一个新的数组，一般情况下也不会改变原数组元素的值。因此 forEach() 常用于数组元素的遍历。

例如打印数组中的每个元素。

```js
const a = [1, 2, 3, 4, 5]
a.forEach((x) => {
  console.log(x)
})
```

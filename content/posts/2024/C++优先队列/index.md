---
title: "C++ 优先队列"
date: 2024-07-16T16:22:57+08:00
draft: false
slug: "cpp-priority-queue"
categories: ["编程语言"]
tags: ["C++", "STL", "优先队列"]
---

`std::priority_queue` 是 C++ 标准库中的一个容器适配器，用于实现优先队列（堆）。它默认是一个最大堆（即优先级最高的元素在顶部），但可以通过自定义比较器实现最小堆或其他优先级规则。以下是 `std::priority_queue` 的基本用法：

<!--more-->

### 1. 包含头文件

使用 `std::priority_queue` 需要包含头文件 `<queue>`：

```cpp
#include <queue>
```

### 2. 定义和初始化

可以定义一个 `std::priority_queue`，并指定元素类型和底层容器类型（默认为 `std::vector`）：

```cpp
std::priority_queue<int> maxHeap; // 默认最大堆
```

如果需要最小堆，可以传入自定义比较器：

```cpp
std::priority_queue<int, std::vector<int>, std::greater<int>> minHeap;
```

- `int`：元素类型。
- `std::vector<int>`：底层容器类型（默认）。
- `std::greater<int>`：比较器，用于实现最小堆。

优先队列的比较函数逻辑与 sort 相反，如果传入的是 less，得到的是最大堆，传入的是 greater，得到的是最小堆。而在 sort 中，传入 less，得到的是递增序列，传入 greater，得到的是递减序列。

### 3. 插入元素

使用 `push` 方法插入元素：

```cpp
maxHeap.push(10);
maxHeap.push(5);
maxHeap.push(20);
```

### 4. 访问顶部元素

使用 `top` 方法访问优先级最高的元素（堆顶元素）：

```cpp
std::cout << "Top element: " << maxHeap.top() << std::endl;
```

### 5. 删除顶部元素

使用 `pop` 方法删除优先级最高的元素：

```cpp
maxHeap.pop(); // 删除堆顶元素
```

### 6. 检查队列是否为空

使用 `empty` 方法检查队列是否为空：

```cpp
if (maxHeap.empty()) {
    std::cout << "Priority queue is empty" << std::endl;
}
```

### 7. 获取队列大小

使用 `size` 方法获取队列中元素的数量：

```cpp
std::cout << "Size: " << maxHeap.size() << std::endl;
```

### 8. 自定义比较器

可以通过自定义比较器实现复杂的优先级规则。例如，实现一个最小堆存储 tuple 类型：

```cpp
auto cmp = [](const tuple<int, int, int> &a,
              const tuple<int, int, int> &b) -> bool {
    return get<0>(a) > get<0>(b);
};

priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>,
                decltype(cmp)>
    pq(cmp);
pq.push({1, 2, 3});
pq.push({2, 3, 4});
pq.push({3, 5, 6});
auto [t0, t1, t2] = pq.top();
// {1 2 3}
```

在 C++ 17 版本中，在初始化 pq 时需要传入 cmp 比较函数，在 C++ 20 中则可以省略这个构造函数参数。tuple 的结构化绑定功能也是在 C++ 17 中引入的。

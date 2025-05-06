---
title: "Pytorch Tensor 基本操作"
date: 2023-07-15T17:44:51+08:00
draft: false
slug: "pytorch-tensor"
categories: ["人工智能"]
tags: ["PyTorch"]
---

本文介绍了 PyTorch 中 Tensor 的一些常用操作。

<!--more-->

### 1. 初始化

| 操作            | 效果               |
| --------------- | ------------------ |
| ones(3, 4)      | 全 1               |
| zeros(3, 4)     | 全 0               |
| eye(3)          | 对角阵             |
| arange(0, 5, 1) | 从 0 到 4 步长为 1 |
| rand(3, 4)      | 0 到 1 随机数      |
| randn(3, 4)     | 正态分布随机数     |

### 2. 基本属性

| 操作      | 效果       |
| --------- | ---------- |
| shape     | 形状       |
| numel()   | 元素个数   |
| max()     | 最大值     |
| device    | 所在的位置 |
| abs()     | 绝对值     |
| grad      | 梯度       |
| reshape() | 改变形状   |

在 reshape 时，我们可以通过 -1 来自动计算维度。如 x 为 size([12]) 的 tensor，x.reshape([3, -1])，可以得到 size([3, 4])。而在使用下标访问 tensor 元素时，-1 表示最后一个元素。如上文的 x[-1][-1] 就表示 x[2][3]。

另外，函数名后加下划线意为原地操作，如 abs\_() 为 abs() 的原地版本

### 3. 拼接（cat/stack）

cat 在现有维度上进行拼接，stack 在新的维度上进行拼接。

```python
a = torch.rand(3, 4)
b = torch.rand(3, 4)

c = torch.cat((a, b), dim=0)
d = torch.stack((a, b), dim=0)

print(c.shape)
# torch.Size([6, 4])
print(d.shape)
# torch.Size([2, 3, 4])
```

### 4. 广播机制

广播机制即对两个形状不同的矩阵来进行按元素操作，如 a 为 size([3, 1])，b 为 size([1, 2])，a + b 会将两个矩阵广播为一个 size([3, 2]) 的矩阵，即复制 a 的行，而复制 b 的列，来进行按元素运算。

```python
a = torch.arange(3).reshape((3, 1))
b = torch.arange(2).reshape((1, 2))
print(a + b)
# tensor([[0, 1], [1, 2], [2, 3]])
```

### 5. 基本计算

#### 求和

包括按所有轴求和，按指定轴求和，以及保持维度求和。

```python
A = torch.tensor([[1, 2], [3, 4]])
print(A.sum())
# tensor(10)
print(A.sum(axis=0))
# tensor([4, 6])
print(A.sum(axis=0, keepdim=True))
# tensor([[4, 6]])
```

#### 按元素运算

对任意相同形状的 tensor，我们都可以使用常见的运算符（+，-，\*，/和\*\*，其中 \*\* 为求幂运算）来进行按元素运算。
除此之外，按元素还可以使用 exp() 自然指数这样的一元运算符。

```python
x = torch.tensor([1.0, 2, 4, 8])
y = torch.tensor([2, 2, 2, 2])
x + y, x - y, x * y, x / y, x ** y, x.exp()
```

上述结果分别为

```
tensor([ 3.,  4.,  6., 10.]),
tensor([-1.,  0.,  2.,  6.]),
tensor([ 2.,  4.,  8., 16.]),
tensor([0.5000, 1.0000, 2.0000, 4.0000]),
tensor([ 1.,  4., 16., 64.])
tensor([2.7183e+00, 7.3891e+00, 5.4598e+01, 2.9810e+03])
```

#### 乘法

包括按元素乘法，向量的数量积，向量和矩阵的乘法以及矩阵和矩阵的乘法。

向量之间的乘法

```python
x = torch.tensor([1, 2])
y = torch.tensor([3, 4])
print(x * y)
# tensor([3, 8])
print(x.dot(y))
# tensor(11)
```

向量和矩阵的乘法，注意这里的按元素乘法使用了广播机制。

```python
A = torch.tensor([[1, 2], [3, 4]])
x = torch.tensor([1, 2])
print(A * x)
# tensor([[1, 4], [3, 8]])
print(A.mv(x))
# tensor([ 5, 11])
```

矩阵之间的乘法

```python
A = torch.tensor([[1, 2], [3, 4]])
B = torch.tensor([[1, -1], [1, -1]])
print(A * B)
# tensor([[ 1, -2], [ 3, -4]])
print(A.mm(B))
print(A @ B)
# 上面两句均表示矩阵乘法
# tensor([[ 3, -3], [ 7, -7]])
```

### 6. 自动求导

\\[
y = e^{x_1} + e^{x_2} + e^{x_3}
\\]

\\[
y^{'}_{x_1} = e^{x_1}
\\]

```python
x = torch.arange(4.0, requires_grad=True)
print(x)
# tensor([0., 1., 2., 3.], requires_grad=True)
y = x.exp()
print(y)
# tensor([ 1.0000,  2.7183,  7.3891, 20.0855], grad_fn=<ExpBackward0>)
y.sum().backward()
print(x.grad)
# tensor([ 1.0000,  2.7183,  7.3891, 20.0855])
```

\\[
y = x_1^2 + x_2^2 + x_3^3
\\]

\\[
y^{'}_{x_1} = 2x_1
\\]

```python
x = torch.arange(4.0, requires_grad=True)
print(x)
# tensor([0., 1., 2., 3.], requires_grad=True)
y = x * x
print(y)
# tensor([0., 1., 4., 9.], grad_fn=<MulBackward0>)
y.sum().backward()
print(x.grad)
# tensor([0., 2., 4., 6.])
```

注意，只有标量的输出才能求梯度，因此我们在对 y 反向传播求梯度之前要先求和。

---
title: "LaTeX 基本使用方法"
date: 2023-12-17T14:07:48+08:00
draft: false
slug: "latex-tutorial"
categories: ["编程语言"]
tags: ["LaTeX"]
---

本文介绍 \(\LaTeX\) 的基本使用方法。

<!--more-->

### 1. 上标和下标

```latex
a_{1}
x^{2}
a_{1}^{2}
```

\\[
a\_{1} \qquad
x^{2} \qquad
a\_{i}^{2}
\\]

### 2. 分数

```latex
\dfrac{x^{2}}{y + 1}
x^{1/2}
```

\\[
\dfrac{x^{2}}{y + 1} \qquad
x^{1/2}
\\]

### 3. 开方

```latex
\sqrt{x}
\sqrt[3]{y}
```

\\[
\sqrt{x} \qquad
\sqrt[3]{y}  
\\]

### 4. 导数

```latex
y'
\dfrac{\mathrm{d}y}{\mathrm{d}x}
\dfrac{\partial y}{\partial x}
```

\\[
y' \qquad
\dfrac{\mathrm{d} y}{\mathrm{d} x} \qquad
\dfrac{\partial y}{\partial x}
\\]

### 5. 积分

```latex
\int_{a}^{b} f(x) \mathrm{d}x
\int_{-\infty}^{+\infty} g(x) \mathrm{d}x
```

\\[
\int\_{a}^{b} f(x) \mathrm{d}x \qquad
\int\_{-\infty}^{+\infty} g(x) \mathrm{d}x
\\]

### 6. 对数

```latex
\log_{2}{x}
\ln{x}
```

\\[
\log\_{2}{x} \qquad
\ln{x}
\\]

### 7. 求和与求积

```latex
\sum_{i = 0}^{n} i^2
\prod_{i = 1}^{n} i + 1
```

\\[
\sum\_{i = 0}^{n} {i^2} \qquad
\prod\_{i = 0}^{n} (i + 1)
\\]

### 8. 极限

```latex
\lim_{x \to 0} \dfrac{\sin{x}}{x} = 1
```

\\[
\lim\_{x \to 0} \dfrac{\sin{x}}{x} = 1
\\]

### 9. 矩阵

```latex
\begin{bmatrix} 0 & -1 \\ 1 & 0 \end{bmatrix}
\begin{vmatrix} 0 & -1 \\ 1 & 0 \end{vmatrix}
```

\\[
\begin{bmatrix} 0 & -1 \\\ 1 & 0 \end{bmatrix} \qquad
\begin{vmatrix} 0 & -1 \\\ 1 & 0 \end{vmatrix}
\\]

### 10. 数学符号

```latex
\begin{array}{ccccccccc}
\lt & \le & \gt & \ge & \neq & \approx & \times & \div & \pm \\
\mp & \cdot & \cup & \cap & \subset & \subseteq & \in & \emptyset & \land \\
\lor & \lnot & \oplus & \forall & \exists & \rightarrow & \Rightarrow & \infty & \nabla &
\end{array}
```

\\[
\begin{array}{ccccccccc}
\lt & \le & \gt & \ge & \neq & \approx & \times & \div & \pm \\\
\mp & \cdot & \cup & \cap & \subset & \subseteq & \in & \emptyset & \land \\\
\lor & \lnot & \oplus & \forall & \exists & \rightarrow & \Rightarrow & \infty & \nabla &
\end{array}
\\]

### 11. 希腊字母

```latex
\begin{array}{cccccccc}
\alpha & \beta & \gamma & \delta & \epsilon & \zeta & \eta & \theta \\
\iota & \kappa & \lambda & \mu & \nu & \xi & \omicron & \pi \\
 \rho &\sigma & \tau & \upsilon & \phi & \chi & \psi & \omega &
\end{array}
```

\\[
\begin{array}{cccccccc}
\alpha & \beta & \gamma & \delta & \epsilon & \zeta & \eta & \theta \\\
\iota & \kappa & \lambda & \mu & \nu & \xi & \omicron & \pi \\\
 \rho &\sigma & \tau & \upsilon & \phi & \chi & \psi & \omega &
\end{array}
\\]

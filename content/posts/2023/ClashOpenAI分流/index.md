---
title: "Clash for Windows OpenAI 分流"
date: 2023-11-17T21:20:34+08:00
draft: false
slug: "clash-openai"
categories: ["互联网"]
tags: ["OpenAI", "Clash"]
---

总所周知，OpenAI 对于访问 IP 的要求较为严格，因此我们最好使用较为固定的美国 IP 进行访问。如果我们所使用的分流规则中没有相应的规则的话，我们每次访问 ChatGPT 时都需要手动切换节点，非常的麻烦。那么有没有什么简单的方法来添加 Clash 的分流规则呢？当然有，那就是 Clash for Windows 的 Parsers 功能。

<!--more-->

打开 CFW 的 Settings - Profiles，可以找到 Parsers 选项。我们需要添加一个 OpenAI 的分流代理组，再为相关域名添加规则。如下所示，将你的配置文件的 URL 填入 url 项，在 OpenAI 的 proxies 中填入美国节点。

```yaml
parsers: # array
  - url: YOUR_URL
    yaml:
      append-proxy-groups:
        - name: z OpenAI
          type: select
          proxies:
            - 美国-01
            - 美国-02
            - 美国-03
      prepend-rules:
        - DOMAIN-SUFFIX,openai.com,🚀 OpenAI
        - DOMAIN-SUFFIX,oaistatic.com,🚀 OpenAI
        - DOMAIN-SUFFIX,oaiusercontent.com,🚀 OpenAI
        - DOMAIN-SUFFIX,poe.com,🚀 OpenAI
```

当然，Parsers 也可以方便地添加其他代理规则，例如我们还可以添加一条规则，使它直连

```yaml
- DOMAIN-SUFFIX,msftconnecttest.com,🍂 Domestic
```

Parsers 的相关参数说明如下表
| 键 | 操作 |
|---|---|
| append-rules | 数组合并至原配置 rules 数组后 |
| prepend-rules| 数组合并至原配置 rules 数组前|
| append-proxies|数组合并至原配置 proxies 数组后 |
|prepend-proxies |数组合并至原配置 proxies 数组前 |
| append-proxy-groups| 数组合并至原配置 proxy-groups 数组后|
|prepend-proxy-groups | 数组合并至原配置 proxy-groups 数组前|
|mix-proxy-providers |对象合并至原配置 proxy-providers 中 |
|mix-rule-providers|对象合并至原配置 rule-providers 中|
|mix-object|对象合并至原配置最外层中|
|commands |在上面操作完成后执行简单命令操作配置文件|

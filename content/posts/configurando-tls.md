---
id: 10426
title: 'Configurando TLS - Erro de Conexão Subjacente'
date: 2022-03-17
author: carloscds
layout: post
categories:
  - DotNet Core
  - Asp.Net
  - C Sharp
---
Estamos passando por grandes mudanças na segurança da web, onde a maioria dos serviços tem atualizado o TLS (Transport Layer Security), que garante a proteção os dados nas comunicações HTTPS.

#### O Problema da Conexão Subjacente

Desta maneira, aplicações que se comunicam via web podem começar a apresentar um erro chamado "Conexão Subjacente fechada", o que não é muito intuitivo, mas isto significa que a sua aplicação pode estar usando uma versão mais antiga do TLS.

#### Resolvendo o problema

Para resolver este problema você precisa apenas configurar o TLS:

* Para aplicações em .NET Core

```csharp
System.Net.ServicePointManager.SecurityProtocol |= SecurityProtocolType.Tls12; 
```

* Para aplicações em .NET Framework

```csharp
ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;
```

Basta adicionar a linha acima do código que faz a chamada HTTPS ou no start da sua aplicação.

Abraços e até a próxima!

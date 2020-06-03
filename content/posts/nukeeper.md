---
id: 758
title: NuKeeper - mantenha seus pacotes atualizados
date: 2020-06-01
author: carloscds
layout: post
categories:
  - .NET
  - .NET Core
---
Todos nós usamos diversos pacotes em nossas aplicações, até mesmo partes essenciais dos projetos estão em pacotes hoje em dia! Ai vem o grande desafio, como manter isto tudo atualizado, e principalmente, como descobrir o que precisa ser atualizado ?

#### Conheça o NuKepper

O Nukeeper é um "atualizador" de pacotes, que como o [site do GitHub](https://github.com/NuKeeperDotNet/NuKeeper) diz: "Ele Automagicamente" atualiza seus pacotes.

MAs atualizar pacotes pode ser perigoso, não é? Então você pode usar o NuKeeper para mostrar quais pacotes estão desatualizados, e há quanto tempo!

#### Instalando

Para instalar é muito simples:

```shell
dotnet tool install nukeeper --global
```

Agora você acessa um diretorio que possui um projeto com pacotes Nuget e digita:

```shell
nukeeper inspect
```

Este comando valida todos os pacotes do projeto e monta uma lista, como esta:


```output
Found 31 package updates
Newtonsoft.Json to 12.0.3 from 6.0.8 - 10.0.2 in 2 places since 7 months ago.
EntityFramework to 6.4.4 from 6.0.2 - 6.2.0 in 2 places since 20 days ago.
Microsoft.Rest.ClientRuntime to 2.3.21 from 2.3.5 in 1 place since 7 months ago.
Microsoft.Rest.ClientRuntime.Azure to 3.3.19 from 3.3.5 in 1 place since 1 year and 5 months ago.
Microsoft.IdentityModel.Clients.ActiveDirectory to 5.2.7 from 2.28.3 in 1 place since 4 months ago.
Microsoft.Rest.ClientRuntime.Azure.Authentication to 2.4.0 from 2.2.10 in 1 place since 1 year and 1 month ago.
Microsoft.Azure.Management.ResourceManager.Fluent to 1.33.0 from 1.0.0-beta50 in 1 place since 2 months ago.
Microsoft.Azure.Management.Storage.Fluent to 1.33.0 from 1.0.0-beta50 in 1 place since 2 months ago.
Microsoft.Azure.Management.Batch.Fluent to 1.26.1 from 1.0.0-beta50 in 1 place since 9 months ago.
Microsoft.Azure.Management.Graph.RBAC.Fluent to 1.33.0 from 1.0.0-beta50 in 1 place since 2 months ago.
Microsoft.Azure.Management.KeyVault.Fluent to 1.33.0 from 1.0.0-beta50 in 1 place since 2 months ago.
Microsoft.Azure.Management.AppService.Fluent to 1.33.0 from 1.0.0-beta50 in 1 place since 2 months ago.
Microsoft.Azure.Management.Cdn.Fluent to 1.33.0 from 1.0.0-beta50 in 1 place since 2 months ago.
Microsoft.Azure.Management.Network.Fluent to 1.33.0 from 1.0.0-beta50 in 1 place since 2 months ago.
Microsoft.Azure.Management.Compute.Fluent to 1.33.0 from 1.0.0-beta50 in 1 place since 2 months ago.
Microsoft.Azure.Management.Dns.Fluent to 1.33.0 from 1.0.0-beta50 in 1 place since 2 months ago.
```

Agora você pode decidir sew atualiza ou analisa os pacotes!

Se decidir atualizar tudo, basta usar o comando

```shell
nukeeper update
```

E pronto, tudo atualizado!

#### Conclusão

Realmente uma ferramenta que pode poupar um monte de trabalho!

Enjoy!

[]s.

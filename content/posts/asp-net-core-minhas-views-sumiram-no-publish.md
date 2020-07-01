---
id: 10384
title: 'ASP.NET Core: Minhas Views sumiram no publish?'
date: 2019-09-15T19:49:16-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10384
permalink: /2019/09/asp-net-core-minhas-views-sumiram-no-publish/
image:  wp-content/uploads/2019/09/RazorPage-175x131.png
categories:
  - DotNet Core
  - Asp.Net
---
Você é do tipo que as vezes muda o conteúdo de uma view no ambiente de produção ? 

Isto pode ser algo "questionável", mas é também muito útil se você precisa fazer um pequeno ajuste na parte visual na aplicação.

Eu já precisei mudar códigos JavaScript nas páginas em uma aplicação onde não poderia executar uma nova publicação, e esta facilidade me poupou muito tempo!

Mas uma [mudança feita no ASP.NET Core 2.1](https://docs.microsoft.com/pt-br/aspnet/core/razor-pages/sdk?view=aspnetcore-2.2#using-the-razor-sdk), alterou o comportamento das páginas Razor na publicação, incluindo tudo no binário (DLL) produzido pela aplicação, ou seja, removendo as Views do local de publicação.

Para demonstrar este comportamento, vamos criar um projeto ASP.NET Core 2.2 no Visual Studio, usando o template MVC (pode ser também um projeto no Core 3), veja:

![]( wp-content/uploads/2019/09/image.png)

Agora vamos simplesmente publicar este projeto em um diretório, usando a opção Publish da Solution e escolhendo "Folder":

![]( wp-content/uploads/2019/09/image-2.png) 

Após clicar no botão "Create Profile" clique novamente em "Publish" 

Abrindo o diretório, temos os seguintes arquivos:

![]( wp-content/uploads/2019/09/image-4.png)

Veja que não temos uma pasta Views.

**Fazendo a mudança no arquivo de projeto:**

Mas fazendo uma pequena mudança no arquivo .CSPROJ, acrescentando a tag **RazorCompileOnPublish** e marcando com "false":

![]( wp-content/uploads/2019/09/image-5-1024x356.png)

Salvando o arquivo e publicando novamente, temos os seguintes arquivos, agora com a pasta Views:

![]( wp-content/uploads/2019/09/image-6.png)

E dentro da pasta Views, temos todas as nossas Views: 

![]( wp-content/uploads/2019/09/image-7.png)

Você pode acrescentar também a tag RazorCompileOnBuild, que inclui as Views durante a compilação:

![]( wp-content/uploads/2019/09/image-8-1024x362.png)

**Conclusão:**

Pequenas configurações podem poupar muito tempo! Espero que faça sentido para você também!
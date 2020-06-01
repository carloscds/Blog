---
id: 9643
title: Gerando um arquivo EXE com .NetCore
date: 2017-10-29T21:50:13-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=9643
permalink: /2017/10/gerando-um-arquivo-exe-com-netcore/
categories:
  - .Net Core
  - 'C#'
tags:
  - publish
---
Olá pessoal,

O post de hoje é bem simples e rápido, apesar de ser uma questão muito pesquisada e nem sempre muito clara!

A idéia é simples, você está desenvolvendo com .Net Core e precisa publicar sua aplicação, mas produzindo um executável ao invés de uma DLL, que é o padrão da plataforma.

Mas porque produzir um executável ? Simples, para chamar diretamente sem o comando ‘dotnet’, ou seja, um executável self-contained deployment.

Mas então porque isto já não é feito quando usamos o comando dotnet publish ? Simples, porque o .Net Core é multiplataforma e arquivos .EXE existem no Windows.

Então vamos a solução!

Neste exemplo eu criei um projeto simples em console usando o comando:

**dotnet new console**

E para produzir a publicação do projeto, ou deploy, você usualmente chama o comando:

**dotnet publish**

Isto gera estes arquivos na pasta bin\debug:

![]( wp-content/uploads/2017/10/image.png)

Obs: Para gerar o arquivo em release, acrescente o parâmetro **–c release** ao comando.

Mas o que queremos é um executável, então vamos acrescentar o runtime ao comando:

dotnet publish &#8211;runtime win10-x64

Agora temos o nosso executável:

![]( wp-content/uploads/2017/10/image-1.png)

O comando acima indica a produção de um executável compatível com Windows 10 e 64 bits.

E veja que agora temos o arquivo .EXE!

Temos também uma pasta chama publish. Ela possui o que chamamos de self-contained deployment, ou seja, todos os arquivos necessários para executarmos nossa aplicação, incluindo os arquivos do .Net Core.

Você pode também mudar o framework de destino ou a plataforma!

Veja [aqui](https://docs.microsoft.com/en-us/dotnet/standard/frameworks) a lista de Frameworks possíveis e [aqui](https://docs.microsoft.com/en-us/dotnet/core/rid-catalog) a lista das plataformas!

Abraços e até a próxima,  
Carlos dos Santos.
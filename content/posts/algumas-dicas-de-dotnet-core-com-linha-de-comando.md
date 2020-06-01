---
id: 8501
title: Algumas dicas de DotNet Core com linha de comando
date: 2017-03-29T09:19:34-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=8501
permalink: /2017/03/algumas-dicas-de-dotnet-core-com-linha-de-comando/
categories:
  - 'C#'
  - DotNetCore
---
Olá pessoal,

Muita gente já está trabalhando com .Net Core e eu espero que você seja uma delas! Mas se não for, aproveite e já [baixe o DotNetCore agora mesmo neste link](https://www.microsoft.com/net/core#windowsvs2017).

Só para relembrar, o DotNet Core é uma nova versão da plataforma .Net que roda multi plataforma, ou seja, você pode desenvolver agora para Windows, Linux e Mac, usando o mesmo código fonte :blush: 

Existem muitas maneiras de se trabalhar com .Net Core, por exemplo usando o [Visual Studio Code](https://code.visualstudio.com/), Visual Studio 2015 e recentemente com o [Visual Studio 2017](https://www.visualstudio.com/pt-br/vs/whatsnew/), mas o divertido mesmo é trabalhar com o VS Code e a linha de comandos, então vamos lá!

Depois de instalar o DotNet Code, vamos abrir um prompt de comandos e começar a criar algumas coisas!

Vamos criar uma nova Solution usando o comando **dotnet new sln**

![]( wp-content/uploads/2017/03/image.png)

Agora temos uma nova solution, veja:

![]( wp-content/uploads/2017/03/image-1.png)

Agora vamos criar um projeto de Class Library com o comando **dotnet new classlib –n classe –o classe**

![]( wp-content/uploads/2017/03/image-2.png)

-n diz qual será o nome do nosso projeto e o –o é o diretório onde ele será criado

Veja como está ficando (estou usando o Visual Studio Code):

![]( wp-content/uploads/2017/03/image-3.png)

Agora vamos criar um projeto de testes com o comando **dotnet new xunit –n testes –o testes**

![]( wp-content/uploads/2017/03/image-4.png)

Agora temos uma solution com um projeto do tipo ClassLibrary e um projeto de testes com xUnit.

Vamos agora adicionar o projeto de classes como referência para o projeto de testes. Para isto vamos abrir o diretório do projeto de testes e digitar o comando: **dotnet add reference add ..\classe.csproj**

O comando **add reference** tem como argumento o arquivo de projeto que queremos referenciar, neste caso o projeto de Class Library.

![]( wp-content/uploads/2017/03/image-5.png)

Veja agora como ficou o arquivo csproj do teste:

![]( wp-content/uploads/2017/03/image-6.png)

Por fim, vamos adicionar os projetos a nossa Solution:

**dotnet sln add classe\classe.csproj**

**dotnet sln add testes\testes.csproj**

E o resultado final na nossa solution:

![]( wp-content/uploads/2017/03/image-7.png)

Agora é só codificar! Lembrando que tudo isto pode ser feito visualmente dentro do Visual Studio!

Abraços e até a próxima!  
Carlos dos Santos.
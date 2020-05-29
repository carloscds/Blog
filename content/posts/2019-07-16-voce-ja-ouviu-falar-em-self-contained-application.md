---
id: 10369
title: Você já ouviu falar em Self Contained Application?
date: 2019-07-16T23:10:43-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10369
permalink: /2019/07/voce-ja-ouviu-falar-em-self-contained-application/
image: /wp-content/uploads/2019/07/domo-175x131.png
categories:
  - .Net Core
---
Se você desenvolve em .NET provavelmente já se perguntou se tudo o que é preciso para a sua aplicação funcionar está na pasta de publicação, certo ? Normalmente temos dezenas, as vezes centenas de DLLs que precisamos levar para o ambiente de produção, e esquecer uma delas pode ser um caos total!

Bom, se você já está desenvolvendo para .NET Core isto está sendo resolvido de uma forma muito interessante: Bem vindo ao Self Contained App. 

Imagine distribuir a sua aplicação, junto com Framework e todas as dependências, tudo em um único local, ou seja, não é preciso instalar o .NET Core no ambiente de produção, pois ele vai junto com a sua aplicação.

Isto é possível há algum tempo no .NET Core. Vamos a um exemplo bem simples. Vou criar uma aplicação console para trabalharmos o exemplo, as você pode criar outros tipos de aplicação também. (Nestes exemplos vou usar a linha de comandos, pois algumas funcionalidades ainda não estão disponíveis na IDE). 

Para criarmos a aplicaçao console:

**dotnet new console**<figure class="wp-block-image">

![](/wp-content/uploads/2019/07/image.png" alt="" class="wp-image-10370" srcset="http://carloscds.net/wp-content/uploads/2019/07/image.png 791w, http://carloscds.net/wp-content/uploads/2019/07/image-300x126.png 300w, http://carloscds.net/wp-content/uploads/2019/07/image-768x322.png 768w" sizes="(max-width: 791px) 100vw, 791px" /> <figcaption>  
</figcaption></figure> 

Agora temos uma aplicação console criada. Tradicionalmente executamos o comando "publish" para publicarmos a nossa aplicação. Vou fazer isto usando o diretório "pub" como exemplo:

**dotnet publish -o pub**<figure class="wp-block-image">

![](/wp-content/uploads/2019/07/image-1.png" alt="" class="wp-image-10371" srcset="http://carloscds.net/wp-content/uploads/2019/07/image-1.png 934w, http://carloscds.net/wp-content/uploads/2019/07/image-1-300x214.png 300w, http://carloscds.net/wp-content/uploads/2019/07/image-1-768x548.png 768w, http://carloscds.net/wp-content/uploads/2019/07/image-1-701x500.png 701w" sizes="(max-width: 934px) 100vw, 934px" /> </figure> 

Olhando o diretório "pub" temos os arquivos da aplicação. Até aqui nada de novo ok! Vou acrescentar um pacote ao projeto, o NewtonSoft.Json, só para exemplificar a publicação com um pacote:

**dotnet add package Newtonsoft.Json**<figure class="wp-block-image">

![](/wp-content/uploads/2019/07/image-2.png" alt="" class="wp-image-10372" srcset="http://carloscds.net/wp-content/uploads/2019/07/image-2.png 1008w, http://carloscds.net/wp-content/uploads/2019/07/image-2-300x143.png 300w, http://carloscds.net/wp-content/uploads/2019/07/image-2-768x366.png 768w" sizes="(max-width: 1008px) 100vw, 1008px" /> </figure> 

Vou publicar novamente e veremos o resultado:<figure class="wp-block-image">

![](/wp-content/uploads/2019/07/image-4.png" alt="" class="wp-image-10374" srcset="http://carloscds.net/wp-content/uploads/2019/07/image-4.png 436w, http://carloscds.net/wp-content/uploads/2019/07/image-4-300x125.png 300w" sizes="(max-width: 436px) 100vw, 436px" /> </figure> 

Ok, agora temos também a Newtonsoft.Json.dll. Agora você pode copiar tudo para a produção, instalar o .NET Core Runtime e tá pronto!

Mas vamos melhorar isto, fazendo uma publicação Sefl Contained, publicando com algumas informações a mais:

  * plataforma de destino
  * modo release
  * parâmetro do self contained 

Então o comando fica assim:

**dotnet publish -r win-x64 -c release &#8211;self-contained -o pubself** 

Explicando o comando:  
**-r win-x64** indica que a plataforma de destino será Windows 64 bits  
**-c release** indica que estamos publicando no modo release  
**&#8211;self-contained** indica que tudo estará na para de publicação, incluindo o .NET Core Runtime.

Veja que eu mudei o diretório para "pubself" e o conteúdo agora é a aplicação e o .NET Core runtime:<figure class="wp-block-image">

![](/wp-content/uploads/2019/07/image-5-1024x633.png" alt="" class="wp-image-10375" srcset="http://carloscds.net/wp-content/uploads/2019/07/image-5-1024x633.png 1024w, http://carloscds.net/wp-content/uploads/2019/07/image-5-300x185.png 300w, http://carloscds.net/wp-content/uploads/2019/07/image-5-768x475.png 768w, http://carloscds.net/wp-content/uploads/2019/07/image-5-809x500.png 809w, http://carloscds.net/wp-content/uploads/2019/07/image-5.png 1243w" sizes="(max-width: 1024px) 100vw, 1024px" /> </figure> 

Com o conteúdo deste diretório podemos rodar nossa aplicação em um computador com Windows x64, sem precisar instalar o .NET Core Runtime. (para uma lista das plataforma acesse [aqui](https://docs.microsoft.com/pt-br/dotnet/core/rid-catalog)), 

Isto já está bom, mas ainda são muitos arquivos para copiar! E se você pudesse colocar tudo isto em um único arquivo? 

Com o [.NET Core 3.0 Preview 6](https://dotnet.microsoft.com/download/dotnet-core/3.0) isto é possível com o parâmetro**SelfContainedFile=true** no comando publish, veja:

**dotnet publish -r win-x64 -c release -o pubself2 /p:PublishSingleFile=true**

Veja o resultado:<figure class="wp-block-image">

![](/wp-content/uploads/2019/07/image-6.png" alt="" class="wp-image-10376" srcset="http://carloscds.net/wp-content/uploads/2019/07/image-6.png 362w, http://carloscds.net/wp-content/uploads/2019/07/image-6-300x115.png 300w" sizes="(max-width: 362px) 100vw, 362px" /> </figure> 

Agora temos tudo em um único arquivo, otimizado! Mas ainda ficou um pouco grande, certo! Para isto temos mais um comando: **PublishTrimmed**, veja:

**dotnet publish -r win-x64 -c release -o pubself2 /p:PublishSingleFile=true /p:PublishTrimmed=true**

Este comando demora um pouco mais, pois ele irá otimizar o uso das DLLs e construir um arquivo bem menor, veja:<figure class="wp-block-image">

![](/wp-content/uploads/2019/07/image-7.png" alt="" class="wp-image-10377" srcset="http://carloscds.net/wp-content/uploads/2019/07/image-7.png 337w, http://carloscds.net/wp-content/uploads/2019/07/image-7-300x107.png 300w" sizes="(max-width: 337px) 100vw, 337px" /> </figure> 

Resumindo, agora com um único arquivo, você tem toda a aplicação e o RunTime do .NET Core para executar! 

Se você ainda não começou a usar o .NET Core, comece agora mesmo. A versão que estou usando neste artigo, neste momento, ainda é um preview, então não aconselho usar em produção, mas logo deve sair a versão final e você com certeza já estará preparado!

Abraços e até a próxima!
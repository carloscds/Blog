---
id: 9482
title: 'Publicando uma aplicação Asp.NET Core no IIS'
date: 2017-08-06T17:38:30-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=9482
permalink: /2017/08/publicando-uma-aplicao-asp-net-core-no-iis/
categories:
  - .Net Core
---
Olá pessoal, ja faz um tempo do meu post sobre [como publicar uma aplicação no IIS](http://carloscds.net/2010/10/publicando-uma-aplicao-web-no-iis-7/), e agora, como temos novas tecnologias, chegou a hora de mostrar como fazer a publicação de uma aplicação Asp.Net Core!

**Mas por quê desenvolver em .Net Core ?** 

Existem centenas de artigos explicando as vantagens, mas vou colocar aqui apenas dois pontos: Velocidade e facilidade no desenvolvimento!  
Velocidade porque o Asp.Net Core é muitas vezes mais rápido que o Asp.Net convencional. Veja [aqui alguns benchmarks](https://github.com/aspnet/benchmarks)  
Facilidade pois você tem maior controle sobre toda a aplicação e como ela irá funcionar!  
Não podemos esquecer também que uma aplicação Asp.Net Core é multi plataforma: Windows, Linux e Mac.

**Fazendo a publicação no IIS!**

Inicialmente vou criar uma aplicação bem simples usando a linha de comandos:

```shell
dotnet new mvc
```

![]( wp-content/uploads/2017/08/image.png)

Este comando irá criar uma aplicação padrão Asp.Net Core MVC. Você pode também criar a aplicação usando o Visual Studio 2017!

Agora vamos publicar esta aplicação em um diretório, que depois será adicionado ao IIS:

```cshell
dotnet publish –o c:\temp\core
```

![]( wp-content/uploads/2017/08/image-1.png)

Veja mais informações sobre o comando dotnet publish [aqui](https://github.com/dotnet/docs/blob/master/docs/core/tools/dotnet-publish.md).

Agora temos os arquivos da publicação no diretório c:\temp\core:

![]( wp-content/uploads/2017/08/image-2.png)

Vamos então publicar no IIS, mas antes disto, precisamos instalar o **Windows Server Hosting** do Asp.Net Core, que você encontra no site do [DotNet Core](https://www.microsoft.com/net/download/core#/runtime), vamos baixar e instalar:

![]( wp-content/uploads/2017/08/image-3.png)

O Windows Server Hosting é quem irá realizar a execução das aplicações.

Agora vamos para o IIS!

Primeiro vamos criar um Application Pool para nossos sites em Asp.Net Core, para isto abra o IIS, vá em Application Pools e clique em “Add Application Pool…”

![]( wp-content/uploads/2017/08/image-4.png)

No nosso exemplo estamos criando um Application Pool chamado “Asp.Net Core”, e o segredo aqui é colocar “No Managed Code”, isto porque o WebHost que instalamos irá fazer o gerenciamento da aplicação.

Agora é só criarmos nossa aplicação e colocarmos neste pool. Lembrando que para criar a aplicação basta clicar com o botão direito em Site e depois em Add Application:

![]( wp-content/uploads/2017/08/image-5.png)

Depois criamos a nossa aplicação:

![]( wp-content/uploads/2017/08/image-6.png)

Veja que colocamos o pool que acabamos de criar e apontamos o diretório de publicação da aplicação!

E pronto, você já pode acessar o endereço: <http://localhost/teste>

![]( wp-content/uploads/2017/08/image-7.png)

Abraços e até a próxima!  
Carlos dos Santos.
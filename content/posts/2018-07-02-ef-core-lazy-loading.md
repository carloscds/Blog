---
id: 10223
title: EF Core – Lazy Loading
date: 2018-07-02T13:27:40-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10223
permalink: /2018/07/ef-core-lazy-loading/
categories:
  - .Net Core
  - EntityFramework Core
tags:
  - EntityFramework Core
---
Olá pessoal,

Depois um longo tempo sem escrever sobre o EntityFramework, vou retomar com uma série de artigos sobre esta nova versão, o EntityFramework Core.

Para quem ainda não sabe, o EF Core faz parte do [.NET Core](https://www.microsoft.com/net/learn/get-started/windows), que é multi plataforma.

Primeiro, vamos precisamos entender que o EF Core é um ORM totalmente novo, criado literalmente do ZERO, e por isto, ainda tem muitas coisas para serem feitas! Lembrando ainda que o [EntityFramework 6](https://github.com/aspnet/EntityFramework6) continua existindo como parte do .NET Full Framework.

No EF Core, com o lançamento da versão 2.1, tivemos uma boa evolução da ferramenta, e também a implementação do Lazy Loading.

**Mas o que é o Lazy Loading ?**

Quando temos relacionamentos no nosso modelo de dados, por exemplo, um Cliente com Pedidos, o EF nos permite que, ao ler o cliente, os pedidos possam ser trazidos também.

Mas isto pode deixar tudo muito lento, pois podemos ter vários clientes, com vários pedidos, e os pedidos também tem outros relacionamentos, como produtos, vendedores, etc.

Para a carga dos dados ficar mais rápida, o Lazy Loading, ou carga atrasada, é empregado e os dados relacionados são trazidos somente se eles forem consultados, ou acionados.

Para demonstrar isto na prática, vamos criar um projeto novo no [Visual Studio Code](https://code.visualstudio.com/) do tipo console, e para tornar isto ainda mais divertido, vamos fazer tudo na linha de comandos:

<span style="font-size: medium;"><strong>dotnet new console<br /> dotnet add package Microsoft.EntityFrameworkCore<br /> dotnet add package Microsoft.EntityFrameworkCore.SqlServer</strong></span>

Estes comandos vão criar um projeto .NET Core console e adicionar o EF Core e o provider do SQL Server.

Vou utilizar para este exemplo o banco de dados NorthWind (vou colocar o script no Git)

Agora que temos o projeto, vamos criar duas classes: Customers e Orders (Se preferir, pode fazer engenharia reversa usando este outro [artigo](http://carloscds.net/2018/05/ef-core-powertools/)):

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/5231b7e3e0a0c761f532c14db673adfe">Gist</a>.
  </noscript>
</div>

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/0d29a804aaef7f42e44825d66ad5dcd7">Gist</a>.
  </noscript>
</div>

Neste exemplo não estou utilizando todos os campos das tabelas, pois isto não irá interferir.

E por fim a nossa classe de contexto:

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/5089b9da487dc6b3204b1ce2ea85e59f">Gist</a>.
  </noscript>
</div>

Bom, até agora nada de diferente, certo ? Vamos então listar os dados:

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/b1d42852493dd2f48e7fdaa8517247dd">Gist</a>.
  </noscript>
</div>

E o resultado da execução:

[<img class="alignnone wp-image-10226" src="http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-02-17-300x225.png" alt="" width="401" height="301" srcset="http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-02-17-300x225.png 300w, http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-02-17-175x131.png 175w, http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-02-17.png 410w" sizes="(max-width: 401px) 100vw, 401px" />](http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-02-17.png)

Veja que todos os clientes possuem ZERO Orders, isto porque o LazyLoading está desativado ainda!

Vamos então habilitar o LazyLoading adicionando um novo pacote ao nosso projeto:

**dotnet add package Microsoft.EntityFrameworkCore.Proxies**

Agora podemos habilitar no nosso contexto com o seguinte código na classe Contexto.cs:

<div>
  <div>
    <strong>using Microsoft.EntityFrameworkCore.Proxies;</strong>
  </div>
  
  <div>
  </div>
</div>

<div>
</div>

<div>
  e adicionando o comando:
</div>

<div>
  <div>
    <div>
    </div>
    
    <div>
      <strong>optionsBuilder.UseLazyLoadingProxies();</strong>
    </div>
    
    <div>
    </div>
  </div>
  
  <div>
  </div>
  
  <div>
    Nossa classe ficará assim:</p> 
    
    <div class="oembed-gist">
      <noscript>
        View the code on <a href="https://gist.github.com/carloscds/191a42fd6370b307798e5852e7f1db48">Gist</a>.
      </noscript>
    </div>
    
    <p>
      Pronto, agora vamos executar novamente e teremos as Ordens:
    </p>
  </div>
  
  <div>
  </div>
  
  <div>
    <a href="http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-14-39.png"><img class="alignnone wp-image-10227" src="http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-14-39-300x233.png" alt="" width="433" height="336" srcset="http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-14-39-300x233.png 300w, http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-14-39.png 460w" sizes="(max-width: 433px) 100vw, 433px" /></a>
  </div>
</div>

<div>
</div>

<div>
  Se compararmos com o EntityFramework 6, ficou um pouco diferente, pois temos opção somente para LazyLoading e Proxy, o que eu não acho particularmente muito interessante, já que o objeto resultante vem com o proxy, veja:
</div>

<div>
  <a href="http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-18-15.png"><img class="alignnone wp-image-10228" src="http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-18-15-300x130.png" alt="" width="598" height="259" srcset="http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-18-15-300x130.png 300w, http://carloscds.net/wp-content/uploads/2018/07/2018-07-02_13-18-15.png 678w" sizes="(max-width: 598px) 100vw, 598px" /></a>
</div>

<div>
</div>

<div>
  Isto acontece porque a Microsoft utilizou o Castle Proxy para implementar o LazyLoading, algo que será melhorado em versões posteriores.
</div>

<div>
</div>

<div>
</div>

<div>
  O código fonte deste projeto esta mo meu GitHub em: <a href="https://github.com/carloscds/EFCoreSamples">https://github.com/carloscds/EFCoreSamples</a>
</div>

<div>
</div>

<div>
</div>

<div>
  Abraços e até a próxima!<br /> Carlos dos Santos.
</div>

<div>
</div>

<div>
</div>

<div>
</div>
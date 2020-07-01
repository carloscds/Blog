---
id: 7781
title: Serializando JSon com JIL
date: 2016-07-30T17:34:11-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=7781
permalink: /2016/07/serializando-json-com-jil/
categories:
  - DotNet
  - C Sharp
  - Open Source
tags:
  - json
---
Fala pessoal, tudo bem!

Hoje vou falar sobre uma biblioteca muito legal para serializar e deserializar objetos Json, pois este tipo de dados está cada vez mais comum com o advento das APIs web.

Um exemplo de dado em Json é o próprio WebAPI que faz parte do Asp.Net MVC, pois ele retorna basicamente dados em Json. Então qual o problema a ser resolvido ? 

Você recebe um dado em Json, que é basicamente um texto, e precisa manipular seu conteúdo através de uma classe! E é aí que entra o JIL !!!

A biblioteca [JIL](https://github.com/kevin-montrose/Jil), criada pela equipe do site StackExchange desempenha este trabalho com muita rapidez e simplicidade! Esta biblioteca está disponível através do [NuGet](https://www.nuget.org/packages/Jil/).

Vamos codificar para ver!

Vou criar um projeto bem simples do tipo Console Application no Visual Studio 2015, mas você pode usar outras versões do Visual Studio também:

![]( wp-content/uploads/2016/07/image_thumb1.png)

E vamos instalar o JIL usando o NuGet Package Manager Console (Tools/NuGet Packager Manager/Packager Manager Console):

![]( wp-content/uploads/2016/07/image_thumb3.png)

Vamos agora criar um classe e trabalhar com a serialização e deserialização:

```csharp
public class Cliente
{
  public int ID { get; set; }
  public string Nome { get; set; }
  public string Cidade { get; set; }
}
```

Agora vamos trabalhar com o JIL, veja como é simples:

Vamos criar um objeto do tipo cliente e serializar:
```csharp
var cli = new Cliente() { ID = 1, Nome = "Carlos", Cidade = "CPP" };
  
var json = JSON.Serialize<Cliente>(cli);
  
Console.WriteLine(json);
```   

Criamos o objeto e passamos como parâmetro para a classe JSON.Serialize()

O retorno é este:

![]( wp-content/uploads/2016/07/image_thumb.png)

Agora vamos fazer o inverso, pegar uma string Json e converter para um objeto:

```csharp
var jsonData = "{\"ID\":1,\"Nome\":\"João\",\"Cidade\":\"SP\"}";
var cliente = JSON.Deserialize<Cliente>(jsonData);

Console.WriteLine("ID: {0}\nNome: {1}\nCidade: {2}\n", cliente.ID, cliente.Nome, cliente.Cidade);
```

Temos o dado jsonData, que poderia ter vindo de qualquer serviço na web, e depois chamamos o método JSON.Deserialize(). Pronto, temos nosso objeto cliente!

Veja o retorno:

![]( wp-content/uploads/2016/07/image_thumb-1.png)

Veja o código todo aqui:

```csharp
using Jil;
using System;
     
namespace ConsoleApplication2
{
    class Program
    {
        static void Main(string[] args)
        {
          var cli = new Cliente() { ID = 1, Nome = "Carlos", Cidade = "CPP" };
          var json = JSON.Serialize<Cliente>(cli);
          Console.WriteLine(json);

          var jsonData = "{\"ID\":1,\"Nome\":\"João\",\"Cidade\":\"SP\"}";
          var cliente = JSON.Deserialize<Cliente>(jsonData);

          Console.WriteLine("ID: {0}\nNome: {1}\nCidade: {2}\n", cliente.ID, cliente.Nome, cliente.Cidade);
      }
  }

  public class Cliente
  {
      public int ID { get; set; }
      public string Nome { get; set; }
      public string Cidade { get; set; }
   }
}
```

Abraços e até a próxima,

Carlos dos Santos.
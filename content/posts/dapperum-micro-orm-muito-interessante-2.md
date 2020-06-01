---
id: 5791
title: 'Dapper - Um Micro ORM muito interessante'
date: 2014-09-07T17:46:32-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=5791
permalink: /2014/09/dapperum-micro-orm-muito-interessante-2/
categories:
  - 'C#'
  - ORM
tags:
  - 'msdn;c#'
---
Olá pessoal,

Eu utilizo muito EntityFramework nos projetos da empresa, pois trabalhar com classes e objetos é muito mais simples do que utulizar acessio a dados tradicionais. Mas recentemente comecei a utilizar o Dapper, que pode ser chamado de um micro ORM, pois ele possui algumas funcionalidades bem pontuais para trabalharmos com acesso a dados.

Então vamos pensar em um cenário onde você precisa consultar um banco de dados qualquer, e colocar o resultado desta consulta em um objeto. Você logo pensaria em criar uma classe, fazer um mapeamento para um contexto, etc. Sim, este seria o caminho normal para um ORM, mas não para o Dapper.

O Dapper trabalha com extension methods para a sua conexão, ou seja, você irá inicialmente criar uma conexão para o seu banco de dados, como se fosse utilizar ADO.Net, por exemplo: SqlConnection, OracleConnection, MySqlConnection, etc. No caso do Dapper, você também é o responsável por abrir e fechar a sua conexão.

Como ele trabalha com métodos de extensão sobre a conexão, o que temos a fazer é instalar o Dapper via NuGet, criar a nossa conexão e começar a utilizar.

Para começaramos a utilizar, vamos criar um projeto console no Visual Studio:

![]( wp-content/uploads/2014/09/SNAGHTML115102b5.png)

Agora vamos instalar o Dapper utilizando NuGet (Tools/NuGet Packager Manager/Packager Manager Console:

**PM> install-package Dapper**

Agora vamos escrever um código simples para um Select no banco de dados. No nosso exemplo vou utilizar o banco de dados [NorthWind da Microsoft.](http://northwinddatabase.codeplex.com/) Vou então fazer um select simples na tabela Customer:

```csharp
using System; 
using System.Collections.Generic; 
using System.Data.SqlClient; 
using System.Linq; 
using System.Text; 
using Dapper;  

namespace ExemploDapper 
{     
     class Program
     {
         static void Main(string[] args)
         {
             SqlConnection conexao = new SqlConnection("data source=(local); initial catalog=northwind; integrated security=true;");
             conexao.Open();
             var dados = conexao.Query("select * from customers");
             foreach (dynamic linha in dados)
             {
                 Console.WriteLine("{0} - {1}", linha.CustomerID, linha.CompanyName);
             }
             conexao.Close();
         }
     }
 }
``` 

Veja que para utilizarmos o Dapper, depois de adicionado com o NuGet, basta colocar o “using Dapper” para que o método de extensão Query() apareça na nossa conexão. E para realizar a consulta, basta informarmos o comando SQL e depois pegarmos o resultado. No exemplo acima, não utilizei uma classe como retorno e neste caso o Dapper retorna uma lista que podemos acessar com dynamic.

Vamos agora adicionar uma classe Customer ao nosso projeto, de acordo com o código abaixo:

```csharp
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ExemploDapper
{
    class Customer
    {
        public string CustomerID { get; set; }
        public string CompanyName { get; set; }
        public string City { get; set; }
    }
}
```

Neste exemplo estou adicionando somente alguns campos da classe. Agora vamos modificar nossa consulta utilizando a classe Customer:

```csharp
var dados1 = conexao.Query<Customer>("select customerID, companyName, City from customers");
foreach (var linha in dados1)
{
     Console.WriteLine("{0} - {1}", linha.CompanyName, linha.City);
}
```

Vamos agora incrementar nossa consulta adicionando um filtro:

```csharp
var dados2 = conexao.Query<Customer>("select CustomerID, CompanyName, City from customers where City = @City", new { City = "London" });

foreach (var linha in dados2)
{
   Console.WriteLine("{0} - {1}", linha.CompanyName, linha.City);
}
```

Veja como é bem simples, basta você criar o comando Select com o parâmetro e depois passar um objeto anônimo com os valores.

Vamos agora fazer uma inclusão na tabela Categories do banco NorthWind, veja como é simples:

```csharp
conexao.Query("insert into Categories(CategoryName) values(@CategoryName)",new {CategoryName = "Teste"});
```

A idéia é a mesma da consulta com parâmetros, você insere os parâmetros e passa um objeto com os valores.

Ao final de tudo isto, talvez você esteja se perguntando qual a vantagem de utilizar o Dapper ? A resposta é simples: performance.

Veja a tabela abaixo, comparando a velocidade de consulta:

![]( wp-content/uploads/2014/09/image.png)

Ou seja, para consultas em massa, o Dapper é mais rápido!

Ops! Isto significa que devo abandonar meu ORM e utilizar somente o Dapper, claro que a resposta é NÃO! O que você pode fazer é complementar a sua aplicação utilizando o Dapper para inclusões de dados em massa por exemplo, onde ele é mais rápido.

Neste post eu procurei fornecer uma visão geral e também uma alternativa de ORM que você pode utilizar em sua aplicação. Se você quer se aprodundar um pouco mais no Dapper, recomendo visitar a [página oficial do projeto](https://github.com/StackExchange/dapper-dot-net) no Github.

Um grande abraço e até a próxima!

Carlos dos Santos.
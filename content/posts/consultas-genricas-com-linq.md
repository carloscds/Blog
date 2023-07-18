---
id: 199
title: Consultas Genéricas com Linq
date: 2010-07-19T23:22:31-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2010/07/consultas-genricas-com-linq/
permalink: /2010/07/consultas-genricas-com-linq/
categories:
  - C Sharp
  - EntityFramework
tags:
  
---
No conceito de orientação a objeto, sempre temos em mente criar códigos que possam ser reutilizados dentro da aplicação ou mesmo em aplicações diferentes, e neste contexto eu tenho sido questionado sobre como é possível usar Linq, que é totalmente orientado a objeto e fortemente tipado, e ainda sim criar códigos reusáveis.

Aproveitando esta situação, vou mostrar como é possível criar um método de consulta usando Linq, que serve para consultar praticamente qualquer entidade (tabela) do seu modelo, ou seja, iremos criar uma consulta totalmente genérica, e um dos possíveis lugares que você pode utilizar este tipo de método, é em uma rotina de consulta que você chama em todo o seu sistema, por exemplo.

Para o nosso exemplo, vamos criar um projeto console bem simples, lembrando que usaremos o Visual Studio 2010 com o Entity Framework 4:

![]( wp-content/uploads/2010/07/image.png)

Agora vamos adicionar o modelo do Entity Framework, para este exemplo usaremos o banco de dados Northwind, caso você não o tenha, baixe [aqui](http://www.microsoft.com/downloads/details.aspx?familyid=06616212-0356-46a0-8da2-eebc53a68034&displaylang=en). Para adicionar o modelo, clique com o botão direito do mouse sobre o seu projeto e vá em Add/New Item, ou CTRL + SHIFT + A e selecione Data e depois ADO.Net Entity Data Model. Escolha Generate from database e crie a conexão com o seu banco de dados Northwind. Selecione algumas tabelas, por exemplo: Categories, Products, Customers:</font>

![]( wp-content/uploads/2010/07/image1.png)

Criado o arquivo EDMX, vamos para o método de Consulta:

```csharp
static ObjectQuery<DbDataRecord> Consulta(string query, ObjectContext ctx)
{
    return new ObjectQuery<DbDataRecord>(query, ctx);
}
```
Observação: adicione os seguintes namespaces:

```csharp
using System.Data.Objects;

using System.Data.Common;
```

Parece que ficou complicado, mas é muito simples. Estamos retornando um objeto genérico do tipo DbDataRecord, e dentro do método, estamos retornando um novo ObjectQuery, que nos permite criar consultas dinamicamente. Vejamos um exemplo de chamada do método:

```csharp
static void Main(string[] args)
{
     NorthwindEntities ctx = new NorthwindEntities();
  
     var dados = Consulta("select c.ProductName,c.UnitPrice from Products as c" , ctx);

     foreach (DbDataRecord linha in dados)
     {
         Console.WriteLine(linha["ProductName"] + " - " + linha["UnitPrice"]);
     }
}
```

Primeiro criamos o contexto para o banco de dados Northwind, depois chamamos o método Consulta passando a nossa query e o contexto. Veja que a query se parece muito com uma consulta SQL, e neste caso estamos trazendo o ProductName e o UnitPrice da tabela Products.

Depois executamos um foreach() para mostrar os dados, usando o DbDataRecord para acessar os campos da consulta. Vejamos outro exemplo, agora trazendo dados também da tabela Categories:

```csharp
var dados = Consulta("select c.ProductName,c.UnitPrice,c.Categories.CategoryName from Products as c" , ctx);
  
foreach (DbDataRecord linha in dados)
{
     Console.WriteLine(linha["ProductName"] + " - " + linha["UnitPrice"]+" - "+linha["CategoryName"]);
}
```

E para finalizar um exemplo com consulta condicional:

```csharp
var dados = Consulta("select c.ProductName,c.UnitPrice,c.Categories.CategoryName from Products as c where c.UnitPrice < 10" , ctx);
  
foreach (DbDataRecord linha in dados)
{
     Console.WriteLine(linha["ProductName"] + " - " + linha["UnitPrice"]+" - "+linha["CategoryName"]);
}
```

Acredito que este simples exemplo possa ajudar no desenvolvimento de sua aplicação e mostre também a quantidade de funcionalidades existentes no Entity Framework 4.

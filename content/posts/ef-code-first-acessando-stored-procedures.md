---
id: 397
title: EF Code First-Acessando Stored Procedures
date: 2011-08-20T22:07:01-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2011/08/ef-code-first-acessando-stored-procedures/
permalink: /2011/08/ef-code-first-acessando-stored-procedures/
hl_twitter_has_auto_tweeted:
  - Novo post EF Code First-Acessando Stored Procedures http://carloscds.net/?p=397
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'c#; msdn; #ef'
---
Olá,

Vou iniciar este post informando que o Entity Framework Code First não tem suporte nativo para Stored Procedures, ainda!!!

Mas se não é suportado nativamente, então como é possível acessá-las ? Através do método **SqlQuery()** do contexto, mas existe um inconveniente: o acesso fica vinculado ao banco de dados, ou seja, para cada banco de dados o acesso é feito de uma maneira, mesmo porquê cada banco tem uma maneira específica de chamar e tratar os parâmetros das stored procedures.

Em nosso exemplo vamos demonstrar como acessar uma stored procedure do banco de dados [Northwind](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs). A procedure que vamos utilizar é a CustOrderHist, que recebe como parâmetro o código do cliente e retorna os produtos e quantidades compradas pelo cliente.

Vamos então criar nosso projeto console no Visual Studio 2010 e já adicionar as referências para o EF CodeFirst, caso você não tenha o EF CodeFirst instalado em seu computador, pode baixá-lo [aqui](http://www.microsoft.com/download/en/details.aspx?displaylang=en&id=26660).

![](/wp-content/uploads/2011/08/image.png)

Para pegar o retorno da stored procedure, vamos criar uma classe que conterá os campos retornados:

```csharp
public class ProdutosPorCliente
{
    public string ProductName { get; set; }
    public int Total { get; set; }
}
```   
Para obter o conteúdo da classe, você precisa verificar o que a stored procedure retorna e neste caso ela retorna os nomes dos produtos e a quantidade comprada.

Antes de criar nosso contexto, vamos criar o arquivo de configuração para a string de conexão, veja este post sobre strings de conexão.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <connectionStrings>
    <add name="Contexto" providerName="System.Data.SqlClient" connectionString="Data Source=(local);Initial Catalog=Northwind;Persist Security Info=True;User ID=teste;Password=teste;Pooling=False;MultipleActiveResultSets=true;" />
  </connectionStrings>
</configuration>
```

Agora vamos criar o nosso contexto e incluir a chamada para a stored procedure:

```csharp
class Contexto : DbContext
{
    public IEnumerable<ProdutosPorCliente> RetornaProdutosPorCliente(string codigoCliente)
    {
        SqlParameter parClienteID = new SqlParameter("@CustomerID", SqlDbType.Text);
        parClienteID.Value = codigoCliente;

        return Database.SqlQuery<ProdutosPorCliente>("exec CustOrderHist @CustomerID", parClienteID);
    }
}
```

Veja que nosso contexto não possui as classes de dados, mas elas foram omitidas somente por uma questão didática.

O inconveniente aqui, como falamos no início é que a chamada da stored procedure fica vinculada ao banco de dados. No exemplo usamos SqlParameter() para criar o parâmetro, pois nosso banco de dados é SQL Server. Caso o banco seja diferente a classe de parâmetro muda.

Vamos agora ao exemplo para realizar a chamada ao método:

```csharp
static void Main(string[] args)
{
    Contexto ctx = new Contexto();

    var retProc = ctx.RetornaProdutosPorCliente("VINET");

    foreach (var l in retProc)
    {
        Console.WriteLine("{0} - {1}", l.ProductName, l.Total);
    }
}
```         
Veja que é bem simples, pois o método retorna um IEnumerable que pode ser percorrido por um foreach().

Espero que o exemplo seja útil, mas gostaria de deixar claro que este é somente um meio alternativo para acessar stored procedures.

Até a próxima,

Carlos dos Santos.
---
id: 820
title: Entity Framework–CodeBase Configuration (Interception)
date: 2013-12-30T00:06:34-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2013/12/entity-frameworkcodebase-configuration-interception/
permalink: /2013/12/entity-frameworkcodebase-configuration-interception/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'msdn;c#;ef codefirst; ef'
---
Olá pessoal,

Uma das novidades do Entity Framework 6 é a possibilidade de fazermos as configurações do nosso modelo usando código ao invés dos tradicionais arquivos de configuração (app.config/web.config). Além disto, temos agora muitas outras configurações que podem ser modificadas através da classe **DbConfiguration**.

Dentre as várias opções de configuração que temos através do DbConfiguration, existe uma chamada Interception (veja mais [aqui](https://docs.microsoft.com/en-us/ef/ef6/fundamentals/logging-and-interception)), onde podemos interceptar várias operaçoes que são enviadas ao banco de dados pelo Entity Framework. Neste exemplo iremos interceptar o envio de comandos para o banco de dados e gerar um arquivo texto de log.

**<u>Criando o projeto de exemplo:</u>**

Para começar, vamos criar um projeto do tipo Console usando o Visual Studio 2013 e em seguida iremos adicionar o Entity Framework através do NuGet:

![]( wp-content/uploads/2013/12/image2.png)

**<u>Adicionando o Entity Framework Code First:</u>**

Após criado o projeto, vamos adicionar o Entity Framework através do NuGet. Para isto abra o menu Tools/Library Package Manager/Package Manager Console e depois digite o comando abaixo:

**PM> Install-Package EntityFramework**

Neste exemplo estou utilizando também o [Entity Framework PowerTools](http://visualstudiogallery.msdn.microsoft.com/72a60b14-1581-4b9b-89f2-846072eff19d),  pois vamos fazer uma engenharia reversa do banco de dados NorthWind, que é disponibilizado pela Microsoft [aqui](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs). O recurso de engenharia reversa permite que possamos pegar um banco de dados existente e gerar as classes para o Entity Framework a partir dele.

Para fazer a engenharia reversa, clique com o botão direito do mouse em cima do nome da sua solution e no menu de contexto escolha: Entity Framework/Reverse Engineer Code First, conforme a figura abaixo:

![]( wp-content/uploads/2013/12/image12.png)

Este comando irá abrir uma janela solicitando as informações do banco de dados. Complete com as suas informações, no meu caso a tela é a seguinte:

![]( wp-content/uploads/2013/12/SNAGHTML5372fbd2.png)

**<u>Iniciando a implementação do Interception</u>**

Agora que já temos o banco de dados mapeado, vamos implementar a classe de configuração. Adicione ao projeto uma nova classe chamada Configuracao.cs e vamos colocar o código abaixo:

```csharp
public class Configuracao : DbConfiguration
{
    public Configuracao()
    {

    }
}
```

Esta é a classe base para a configuração. Nenhum código é necessário para chamar esta classe, pois o Entity Framework irá identificá-la desde que esteja no mesmo Assembly da aplicação, ou seja, você não precisa chamar esta classe diretamente em nenhuma parte do seu código.

Como vamos interceptar os comandos enviados para o banco de dados e iremos gerar um log, vamos implementar a nossa classe que irá gerar os logs. Para isto vamos criar uma outra classe chamada InterceptaSQL, veja o código abaixo:

```csharp
public class InterceptaSQL: IDbCommandInterceptor
{
    private string arquivoLog;
    public InterceptaSQL()
    {
        string caminho = Path.GetDirectoryName(Assembly.GetExecutingAssembly().GetModules()[0].FullyQualifiedName);
          arquivoLog = Path.Combine(caminho, "Log.txt");
    }

    private void EscreveLog(string s)
    {
        StreamWriter log = File.AppendText(arquivoLog);
        log.WriteLine(string.Format("{0} - {1}n", DateTime.Now.ToString(), s));
        log.Close();
    }

    public void NonQueryExecuting(
        DbCommand command, DbCommandInterceptionContext<int> interceptionContext)
    {
        GravaLog("Executando SQL",command, interceptionContext);
    }

    public void NonQueryExecuted(
        DbCommand command, DbCommandInterceptionContext<int> interceptionContext)
    {
        GravaLog("SQL executado",command, interceptionContext);
    }

    public void ReaderExecuting(
        DbCommand command, DbCommandInterceptionContext<DbDataReader> interceptionContext)
    {
        GravaLog("Executando Reader",command, interceptionContext);
    }

    public void ReaderExecuted(
        DbCommand command, DbCommandInterceptionContext<DbDataReader> interceptionContext)
    {
        GravaLog("Reader executado",command, interceptionContext);
    }

    public void ScalarExecuting(
        DbCommand command, DbCommandInterceptionContext<object> interceptionContext)
    {
        GravaLog("SQL Scalar executando",command, interceptionContext);
    }

    public void ScalarExecuted(
        DbCommand command, DbCommandInterceptionContext<object> interceptionContext)
    {
        GravaLog("SQL Scalar executado",command, interceptionContext);
    }

    private void GravaLog<TResult>(string TipoComando,
        DbCommand command, DbCommandInterceptionContext<TResult> interceptionContext)
    {
        if (interceptionContext.Exception != null)
        {
            EscreveLog(string.Format("ERRO - Comando SQL: {0},  falhou com exceção: {1}",
                command.CommandText, interceptionContext.Exception));
        }
        else
        {
            EscreveLog(string.Format("{0}: {1}",TipoComando, command.CommandText));
        }
    }
}
```

Nesta classe estamos implementando todos os métodos da interface IDbCommandInterceptor, e também o nosso método para a geração do arquivo texto com o log (linhas 11 a 16). Neste exemplo eu escolhi gravar o arquivo de log no mesmo diretório da aplicação e para isto eu peguei o diretório dentro do assembly usando reflection (linha 7). A gravação do log é bem simples e armazenamos a data/hora, o tipo da operação e o comando executado. Você pode modificar o método GravaLog() e tratar qualquer outra informação que achar necessária.

**Ativando a Interceptação**

Agora que já implementamos a nossa classe para interceptar os comandos, precisamos informar ao Entity Framework da existência desta classe. Para isto vamos voltar a nossa classe Configuracao.cs e adicionar o código abaixo ao construtor:

```csharp
public class Configuracao : DbConfiguration
{
    public Configuracao()
    {
        this.AddInterceptor(new InterceptaSQL());
    }
}
```     
O método AddInterceptor() informa ao Entity Framework que iremos interceptar as operações descritadas na classe InterceptaSQL.

**Testando a implementação**

Para testamos a nossa classe, vamos executar algumas operações no Entity Framework. Veja abaixo o código que utilizamos em Program.cs:

```csharp
static void Main(string[] args)
{
    var db = new NorthwindContext();

    foreach(var p in db.Products)
    {
          Console.WriteLine(p.Category.CategoryName+", "+p.ProductName);
    }

    var altera = db.Products.Where(p => p.ProductID == 1).FirstOrDefault();
    if(altera != null)
    {
        altera.UnitPrice = 10;
          db.SaveChanges();
    }
}
```

Ao executarmos o programa o seguinte arquivo Log.txt é gerado (apenas uma parte do arquivo foi colada aqui):

```xml
29/12/2013 23:51:38 - Executando Reader: select serverproperty('EngineEdition')
29/12/2013 23:51:38 - Reader executado: select serverproperty('EngineEdition')
29/12/2013 23:51:39 - Executando Reader: SELECT
[Extent1].[ProductID] AS [ProductID],
[Extent1].[ProductName] AS [ProductName],
[Extent1].[SupplierID] AS [SupplierID],
[Extent1].[CategoryID] AS [CategoryID],
[Extent1].[QuantityPerUnit] AS [QuantityPerUnit],
[Extent1].[UnitPrice] AS [UnitPrice],
[Extent1].[UnitsInStock] AS [UnitsInStock],
[Extent1].[UnitsOnOrder] AS [UnitsOnOrder],
[Extent1].[ReorderLevel] AS [ReorderLevel],
[Extent1].[Discontinued] AS [Discontinued]
FROM [dbo].[Products] AS [Extent1]

29/12/2013 23:51:39 - Reader executado: SELECT
[Extent1].[ProductID] AS [ProductID],
[Extent1].[ProductName] AS [ProductName],
[Extent1].[SupplierID] AS [SupplierID],
[Extent1].[CategoryID] AS [CategoryID],
[Extent1].[QuantityPerUnit] AS [QuantityPerUnit],
[Extent1].[UnitPrice] AS [UnitPrice],
[Extent1].[UnitsInStock] AS [UnitsInStock],
[Extent1].[UnitsOnOrder] AS [UnitsOnOrder],
[Extent1].[ReorderLevel] AS [ReorderLevel],
[Extent1].[Discontinued] AS [Discontinued]
FROM [dbo].[Products] AS [Extent1]
```

**<u>Conclusão</u>**

O novo recurso de interceptação de comandos do Entity Framework pode ser bastante útil para você fazer depurações e análises dos comandos enviados ao banco de dados, inclusive testes de performance, já que gravamos a data/hora do início da execução e também do final.

Logicamente que este é um log bem mais aprofundado do que eu já mostrei neste [outro post](http://carloscds.net/2013/09/entity-framework-6gerando-log-dos-comandos-sql/), mas a idéia principal é você entender o novo mecanismo de configuração do Entity Framework, que abre muitas possibilidades, incluindo a que acabamos de explorar.

[Baixe o código fonte do exemplo.](https://github.com/carloscds/CSharpSamples/tree/master/EFInterception)

Um grande abraço e até a próxima,

Carlos dos Santos.
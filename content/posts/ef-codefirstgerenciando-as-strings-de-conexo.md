---
id: 394
title: EF CodeFirst–Gerenciando as Strings de Conexão
date: 2011-08-08T22:21:48-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2011/08/ef-codefirstgerenciando-as-strings-de-conexo/
permalink: /2011/08/ef-codefirstgerenciando-as-strings-de-conexo/
hl_twitter_has_auto_tweeted:
  - Novo post EF CodeFirst–Gerenciando as Strings de Conexão http://carloscds.net/?p=394
categories:
  - C Sharp
  - EntityFramework
tags:
  - 'ef codefirst'
---
Olá,

Hoje vamos falar um pouco sobre o gerenciamento de string de conexões no Entity Framework Code First, uma maneira muito simples e rápida de criar um mapeamento objeto relacional em C# com o Visual Studio 2010.

Se você ainda não conhece o EF CodeFirst, veja este [post](http://blogs.msdn.com/b/adonet/archive/2011/03/15/ef-4-1-code-first-walkthrough.aspx "post") e também o <a href="http://blogs.msdn.com/b/adonet/" target="_blank" rel="noopener noreferrer">Blog do time de ADO.Net</a>.

O que vou tratar neste post é como podemos armazenar as strings de conexão e os providers que permitem o acesso do EF ao nosso banco de dados. Por padrão, quando criamos um contexto para nosso EF, é necessário uma string de conexão e um Data Provider, que indica qual o banco de dados será utilizado, mas se criarmos um contexto simples, sem nenhuma string de conexão, como no exemplo abaixo, o que acontece ?

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;

namespace EFExemplo
{
    public class ContextoExemplo : DbContext
    {
        public DbSet<Cliente> Cliente { get; set; }
    }
}
```

Como não expecificamos nenhum construtor, o EF tentará usar o servidor .SQLExpress e tentará criar o banco de dados ContextoExemplo e caso você não tenha este servidor SQL disponível, receberá um erro.

Vamos imaginar que você queira especificar uma string de conexão, neste caso temos várias maneiras de fazer isto e vamos explorar cada uma delas:

#### Opção 1: Informar a string de conexão no construtor do contexto:

```csharp
public class ContextoExemplo : DbContext
{
    public DbSet<Cliente> Cliente { get; set; }

    public ContextoExemplo(string conexao) : base(conexao)
    {

    }
}
```

Neste caso podemos usar de duas maneiras: você pode informar somente a string de conexão e neste caso poderá usar somente o SQL Server, que é o provider default para o EF. Isto pode ser feito na instância do contexto:

```csharp
static void Main(string[] args)
{
    ContextoExemplo ctx = new ContextoExemplo("data source=(local); initial catalog=EFExemplo; user id=teste; password=teste;");
    ctx.Database.CreateIfNotExists();
}
```
Neste caso será criado o banco de dados EFExemplo no servidor SQL local.

Opção 2: Informar o noem de uma string armazenada em um arquivo de configuração:

A segunda maneira é você manter a string fora do executável, de maneira que você possa modificá-la a qualquer momento, neste caso usaremos o arquivo de configuração da aplicação (app.config ou web.config):

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <connectionStrings>
    <add name="EFExemplo" providerName="System.Data.SqlClient" connectionString="data source=(local); initial catalog=EFExemplo; user id=teste; password=teste;"/>
    <add name="EFExemplo-MySql" connectionString="Server=localhost;Database=efexemplo;Uid=teste;Pwd=teste;Port=3306;" providerName="MySql.Data.MySqlClient"/>
  </connectionStrings>
</configuration>
```

No arquivo de configuração podemos agora manter mais de uma string e também informar qual o banco de dados de cada conexão. Para usar a conexão, basta informá-la no construtor:

```csharp
ContextoExemplo ctx = new ContextoExemplo("EFExemplo");
```

ou

```csharp
ContextoExemplo ctx = new ContextoExemplo("EFExemplo-MySql");
```

#### Opção 2: Informar um DbConnection:

DBConnection é a classe que cria as conexões para o EF CodeFirst, neste caso você pode gerar a string de uma maneira mais dinâmica e ela não precisa estar armazenada em um arquivo app.config ou web.config, o que deixaria a string mais exposta. Este mecanismo é interessante quando você quer criptografar a string, veja:

```csharp
public class ContextoExemplo : DbContext
{
    public DbSet<Cliente> Cliente { get; set; }

    public ContextoExemplo(string conexao) : base(conexao)
    {
    }

    public ContextoExemplo(DbConnection conexao) : base(conexao,true)
    {
    }
}
```

Veja que agora temos uma sobrecarga do construtor, onde informamos o DbConnection e vamos fazer isto na instância do contexto:

```csharp
static void Main(string[] args)
{
    DbProviderFactory prov = DbProviderFactories.GetFactory("System.Data.SqlClient");
    DbConnection conexao = prov.CreateConnection();
    conexao.ConnectionString = "data source=(local); initial catalog=EFExemplo; user id=teste; password=teste;";

    ContextoExemplo ctx = new ContextoExemplo(conexao);
    ctx.Database.CreateIfNotExists();
}
``` 
Para criarmos a conexão, primeiro precisamos identificar o tipo do banco de dados, através do DbProviderFactory() e logo a seguir, informamos a string de conexão que é depois passada como parâmetro para o contrutor do contexto. Note que a string de conexão poderia vir de um arquivo criptografado ou mesmo de um serviço web, o que aumentaria a segurança da aplicação.

Bem pessoal, espero que este post possa lhes ser útil.

Até breve,

Carlos dos Santos.
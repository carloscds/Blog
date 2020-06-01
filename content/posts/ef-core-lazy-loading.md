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

**dotnet new console**

**dotnet add package Microsoft.EntityFrameworkCore**

**dotnet add package Microsoft.EntityFrameworkCore.SqlServer**


Estes comandos vão criar um projeto .NET Core console e adicionar o EF Core e o provider do SQL Server.

Vou utilizar para este exemplo o banco de dados NorthWind (vou colocar o script no Git)

Agora que temos o projeto, vamos criar duas classes: Customers e Orders (Se preferir, pode fazer engenharia reversa usando este outro [artigo](http://carloscds.net/2018/05/ef-core-powertools/)):

```csharp
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace LazyLoading
{
    public class Customers
    {

        [Key]
        public string CustomerID {get; set;}
        public string CompanyName {get; set;}
        public string ContactName {get; set;}
        public virtual ICollection<Orders> Orders {get; set;}

        public Customers()
        {
            Orders = new List<Orders>();

        }
    }
}
```

```csharp
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace LazyLoading
{
    public class Orders
    {
        [Key]
        public int OrderID {get; set;}
        public string CustomerID {get; set;}
        public virtual Customers Customers {get; set;}
        public DateTime OrderDate {get; set;}
    }
}
```

Neste exemplo não estou utilizando todos os campos das tabelas, pois isto não irá interferir.

E por fim a nossa classe de contexto:

```csharp
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.SqlServer;

namespace LazyLoading
{
    public class Contexto : DbContext
    {
        public DbSet<Customers> Customers {get; set;}
        public DbSet<Orders> Orders {get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var conexao = new SqlConnectionStringBuilder()
            {
                DataSource = "(local)",
                InitialCatalog = "NorthWind",
                IntegratedSecurity = true
            };
            optionsBuilder.UseSqlServer(conexao.ConnectionString);
        }
    }
}
```

Bom, até agora nada de diferente, certo ? Vamos então listar os dados:

```csharp
using System;

namespace LazyLoading
{
    class Program
    {
        static void Main(string[] args)
        {
            var db = new Contexto();

            var cliente = db.Customers;
            foreach(var c in cliente)
            {
                Console.WriteLine($"{c.CompanyName} - Orders: {c.Orders.Count}");
            }
        }
    }
}
```

E o resultado da execução:

![]( wp-content/uploads/2018/07/2018-07-02_13-02-17.png)

Veja que todos os clientes possuem ZERO Orders, isto porque o LazyLoading está desativado ainda!

Vamos então habilitar o LazyLoading adicionando um novo pacote ao nosso projeto:

**dotnet add package Microsoft.EntityFrameworkCore.Proxies**

Agora podemos habilitar no nosso contexto com o seguinte código na classe Contexto.cs:

```csharp
using Microsoft.EntityFrameworkCore.Proxies;
```

e adicionando o comando:
```csharp
optionsBuilder.UseLazyLoadingProxies();
```
Nossa classe ficará assim:

```csharp
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.SqlServer;
using Microsoft.EntityFrameworkCore.Proxies; 

namespace LazyLoading
{
    public class Contexto : DbContext
    {
        public DbSet<Customers> Customers {get; set;}
        public DbSet<Orders> Orders {get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var conexao = new SqlConnectionStringBuilder()
            {
                DataSource = "(local)",
                InitialCatalog = "NorthWind",
                IntegratedSecurity = true
            };
            optionsBuilder.UseSqlServer(conexao.ConnectionString);
            optionsBuilder.UseLazyLoadingProxies();
        }
    }
}
```

Pronto, agora vamos executar novamente e teremos as Ordens:

![]( wp-content/uploads/2018/07/2018-07-02_13-14-39.png)

Se compararmos com o EntityFramework 6, ficou um pouco diferente, pois temos opção somente para LazyLoading e Proxy, o que eu não acho particularmente muito interessante, já que o objeto resultante vem com o proxy, veja:

![]( wp-content/uploads/2018/07/2018-07-02_13-18-15.png)

Isto acontece porque a Microsoft utilizou o Castle Proxy para implementar o LazyLoading, algo que será melhorado em versões posteriores.

O código fonte deste projeto esta mo meu GitHub em: <https://github.com/carloscds/EFCoreSamples>

Abraços e até a próxima!

Carlos dos Santos.

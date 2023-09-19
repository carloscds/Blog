---
id: 10426
title: 'EntityFramework - Se você usa Migrations com Azure Database, preste muita atenção!'
date: 2023-09-18
author: carloscds
layout: post
categories:
  - C Sharp 
  - EntityFramework 
---
O EntityFramework possui o recurso de migrations que ajuda demais no desenvolvimento de aplicações, pois com a abordagem do CodeFirst você vai criando  as suas classes e ao rodar o migrations tudo é aplicado no banco de dados. Muito útil durante o desenvolvimento!

Até aí nada demais, inclusive eu já abordei o Migrations em diversos artigos aqui no blog, então onde está o problema ?

### Azure Database Default Config
Quando você cria um banco de dados no Azure, por exemplo com o comando:

```sql
create database meubanco
```

O Azure cria o banco na instância padrão, **que não é a mais barata**, hoje ele cria na Gen5, veja so:
![]( wp-content/uploads/2023/09/entityframeworkcore-databasetier/sqlprice_gen5.png)
Neste caso mais de 2 mil reais na data de hoje.

### Mas porque isto acontece?
Quando você executa o migrations e o banco não existe, ele automaticamente é criado, e no caso do Azure ele cria na configuração padrão, ou seja, um descuido e você te um custo bem alto!

### Dá para resolver?
Sim, e é bem simples na verdade, basta adicionar duas linhas no OnModelCreating do seu Contexto:

```csharp
public class Contexto : DbContext
{
    public Contexto(DbContextOptions<Contexto> options) : base(options) { }

    public DbSet<Cliente> Cliente { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

        // SQL Azure - Camada Basic
        modelBuilder.HasServiceTier("Basic");
        modelBuilder.HasPerformanceLevel("Basic");
    }
}
```
Veja que os dois comandos abaixo:

```csharp
modelBuilder.HasServiceTier("Basic");
modelBuilder.HasPerformanceLevel("Basic");
```
Eles informam ao migrations para modificar a camada do SQL para Basic que custa muito, muito menos, cerca de R$ 27,00 hoje!

No meu exemplo eu usei o Basic porque sempre começo un projeto no Azure com uma camada de banco bem pequena e barata, e a medida que o projeto cresce, vamos aumentando o tamanho do banco! Questão de economia!

Você pode conferir mais detalhes sobre os comandos aqui:

https://learn.microsoft.com/en-us/ef/core/providers/sql-server/azure-sql-database
https://learn.microsoft.com/en-us/dotnet/api/microsoft.entityframeworkcore.sqlservermodelbuilderextensions.hasperformancelevel?view=efcore-7.0

Esta opção está disponível desde o EF Core 3.1

O código fonte deste exemplo pode ser encontrado no meu GitHub: https://github.com/carloscds/EntityFramework/tree/main/EFCoreDatabaseTier

Abraços e até a próxima!

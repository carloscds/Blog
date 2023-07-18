---
id: 789
title: Entity Framework 6–Gerando Log dos comandos SQL
date: 2013-09-02T21:31:15-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2013/09/entity-framework-6gerando-log-dos-comandos-sql/
permalink: /2013/09/entity-framework-6gerando-log-dos-comandos-sql/
categories:
  - C Sharp
  - EntityFramework
tags:
  - 'ef codefirst'
---
Olá,

O Entity Framework 6 RC já foi lançado! Agora é a hora de começar a trabalhar na migraçãoda versão 5 para a 6 e ver as novas funcionalidades. As especificações sobre as novas funcionalidades podem ser encontradas [aqui](https://docs.microsoft.com/en-us/ef/ef6/what-is-new/past-releases).

Dentre as muitas novidades, que vamos explorar nos post seguintes, hoje vou destacar uma que acho bem interessante: o log dos comandos enviados ao banco de dados.

Um ORM (Object-Relational Mapping), ou simplesmente um Mapeamento Objeto-Relacional traduz comandos de uma linguagem de programação, no nosso caso C# e LINQ, para comandos de banco de dados. A eficiência do ORM está diretamente relacionada a como os comandos para o banco de dados são gerados, ou seja, pegar os comandos escritos em C# e convertê-los em comandos SQL.

Na versão 6 do Entity Framework foi introduzido um novo objeto que nos permite interceptar os comandos que estão sendo enviados para o banco de dados e assim podemos ver o que acontece “por baixo dos panos”. Isto também podem ser feito colocando uma ferramenta de profiler de banco de dados. No caso do Microsoft SQL Server esta ferramenta é o SQL Server Profiler, mas existem vários outros.

No caso do nosso exemplo, vamos executar um método para cada operação em LINQ que será executada no Entity Framework, e para iniciarmos o nosso exemplo, vamos criar um projeto do tipo Console Application usando o .Net 4.5 (o uso do .Net 4.5 é importante para suportar todas as funcionalidades do Entity Framework 6).

Criando um novo projeto do tipo Console Application:

![]( wp-content/uploads/2013/09/SNAGHTML476eb6022.png)

Criado o nosso projeto, vamos adicionar o Entity Framework através da janela do  Nuget, que está em Tools/Library Packager Manager/Packager Manger Console e dentro dele iremos executar o comando abaixo:

**PM> Install-Package EntityFramework –Pre**

Veja que a opção “-Pre” é quem irá instalar o Entity Framework 6 RC, visto que ele ainda não foi liberado oficialmente e ainda é um release candidate.

Agora vamos criar um contexto bem simples com uma classe Cliente. Para isto adicione uma nova classe e chame-a de Contexto, como no exemplo abaixo:

```csharp
public class Contexto : DbContext
{
    public DbSet<Cliente> Cliente {get; set;}

}
```
Agora vamos adicionar a classe Cliente:

```csharp
public class Cliente
{
    public int ID { get; set; }
    public string Nome { get; set; }
}
```

E por fim vamos modificar o arquivo App.Config para direcionarmos o local e o nome do banco de dados a ser criado: (isto é somente um exemplo e o seu arquivo poderá ficar diferente)

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
   <connectionStrings>
     <add name="Contexto" connectionString="data source=(local); initial catalog=EFLog; integrated security=true;" providerName="System.Data.SqlClient"/>
   </connectionStrings>
</configuration>
``` 
Agora vamos ao que interessa, ou seja, vamos adicionar o LOG do SQL. Para isto, no Program.cs vamos inserir os seguintes comandos:

```csharp
class Program
{
    static void Main(string[] args)
    {
        var db = new Contexto();
        db.Database.Log = GravaLog;

        var cli = new Cliente() { Nome = "Carlos" };
        db.Cliente.Add(cli);
        db.SaveChanges();

        var consulta = from c in db.Cliente
                      select c;
        foreach(var c in consulta)
        {
            Console.WriteLine(c.Nome);
        }
    }

    public static void GravaLog(string sql)
    {
        Console.WriteLine("Comando SQL: "+sql);
    }
}
```     
O método GravaLog() é atrbuído a propriedade Log do DataBase do Contexto, sendo assim, todos os comandos enviados para o banco de dados são também enviados para este método e dentro dele simplesmente chamamos o método Console.WriteLine() para mostrar os comandos na tela.

Ao executar o programa, você verá algo como a imagem abaixo:

![]( wp-content/uploads/2013/09/SNAGHTML47817c48_thumb2.png)

Esta é uma implementação bastante simples da implementação do Log de comandos disponível agora na versão 6, mas com certeza você poderá utilizar de uma maneira bem mais elaborada em seus projetos.

Abraços e até a próxima,
Carlos dos Santos.
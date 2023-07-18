---
id: 5341
title: 'Criando Índices no Entity Framework CodeFirst'
date: 2014-07-01T23:51:36-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=5341
permalink: /2014/07/criando-ndices-no-entity-framework-codefirst/
categories:
  - C Sharp
  - EntityFramework
---
Olá pessoal,

A partir da versão 6.1 do EntityFramework é possível criar índices no banco de dados, especificando isto diretamente nas classes no código fonte. Esta criação dos índices é feira através do atributo <strong>Index</strong> diretamente sobre o campo da classe. <u>Mas atenção</u>: isto só é possível utilizando o recurso Migrations do EntityFramework.

Para demonstrar este recurso, vamos criar um projeto do tipo Console no Visual Studio e vamos adicionar o EntityFramework CodeFirst usando o pacote NuGet.

Criando o Projeto Console:

![]( wp-content/uploads/2014/07/SNAGHTML4fb2cd3.png)

Adicionando o EntityFramework CodeFirst com o NuGet Package (Tools/Nuget Package Manager/Package Manager Console) e iremos adicionar o pacote com o comando abaixo:

**Install-Package EntityFramework**

Vamos agora adicionar a nossa classe de Contexto:

```csharp
public class Contexto : DbContext
{
    public DbSet<Cliente> Cliente { get; set; }
}
```
E na sequência a classe Cliente:

```csharp
public class Cliente
{
    public int ID { get; set; }
    public string Nome { get; set; }
    public string Cidade { get; set; }
    public string UF { get; set; }
}
```

#### Criando Índices

Vamos imaginar que você precise criar um índice para o campo Nome classe Cliente. Iremos usar então o atributo Index e também o MaxLength para determinarmos o tamanho máximo do campo. O atributo Index está no NameSpace: System.ComponentModel.DataAnnotations.Schema
  
```csharp
public class Cliente
{
    public int ID { get; set; }
    [Index]
    [MaxLength(100)]
    public string Nome { get; set; }
    public string Cidade { get; set; }
    public string UF { get; set; }
}
```
  
  Veja que é bem simples, basta adicionar o atributo Index em cima do campo que você quer o índice! Você pode também dar um nome para o índice e, caso seja um índice composto (mais de um campo) indicar qual a posição do campo no índice.

Para nomear o índice, basta informar, por exemplo: <strong>[Index(“MeuIndice”)]</strong> e se você quiser informar também a posição, basta adicionar logo após o nome. Você ainda pode indicar se o índice é Clustered ou Unique. O nome do índice não é obrigatório.

Lembrando o que falei no início do post, a criação do índice é feita usando o Migrations e agora vamos adicioná-lo ao nosso projeto utilizando a Package Manager Console novamente:

***Enable-Migrations***
  
Agora já podemos começar a enviar os comandos do migrations para criar ou atualizar nosso banco de dados. Começamos então adicionando um checkpoint para o migrations:

***Add-Migration CriacaoBanco***

Se você verificar o código gerado pelo Migrations, verá a criação do índice (neste exemplo eu dei o nome “MeuIndice” para o índice):

```csharp
public partial class CriacaoBanco : DbMigration
{
   public override void Up()
   {
       CreateTable(
           "dbo.Clientes",
                 c => new
                 {
                    ID = c.Int(nullable: false, identity: true),
                    Nome = c.String(maxLength: 100),
                    Cidade = c.String(),
                    UF = c.String(),
                  })
            .PrimaryKey(t => t.ID)
            .Index(t => t.Nome, name: "MeuIndice");
   }
  
  public override void Down()
  {
       DropIndex("dbo.Clientes", "MeuIndice");
       DropTable("dbo.Clientes");
  }
}
```

Veja o comando .Index(t => t.nome, name: “Meu_Indice”). Ele é quem irá criar o índice quando aplicarmos a alteração no banco de dados, mas antes de criarmos o banco de dados não podemos esquecer da string de conexão de deve estar no app.config ou web.config (no caso de aplicações web). Vamos adicionar a linha com a conexão:

```xml
<connectionStrings>
    <add name="Contexto" 
        connectionString="data source=(local); initial catalog=EFIndice; user id=teste; password=teste" 
        providerName="System.Data.SqlClient"/>
</connectionStrings>
```
  
Agora vamos criar o banco de dados com o índice executando o comando Update-Database:

***Update-DataBase***

Pronto, nosso banco foi criado com o índice que determinamos. Vejam a tela do Management Studio:

![]( wp-content/uploads/2014/07/image.png)
    
Ao invés de criar o banco diretamente, você também pode adicionar o parametro –Script ao Update-Database para assim, gerar o script do seu bando de dados.

Agora você já pode adicionar a criação de índices ao seus projetos do EntityFramework e assim, melhorar a performance de suas consultas.

Abraços e até a próxima,

Carlos dos Santos.

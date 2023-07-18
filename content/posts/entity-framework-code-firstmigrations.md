---
id: 753
title: Entity Framework Code First–Migrations
date: 2012-07-15T22:20:07-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2012/07/entity-framework-code-firstmigrations/
permalink: /2012/07/entity-framework-code-firstmigrations/
categories:
  - C Sharp
  - EntityFramework
tags:
  - 'entity framework'
---
Olá pessoal,

Uma das grandes funcionalidades do Entity Framework Code First é o processo de atualização automatica do banco de dados através do pacote chamado Migrations.

O Migrations permite que você, que já trabalha com o CodeFirst, gere atualizações gerenciáveis no seu banco de dados, ou se preferir, deixar que o próprio Migrations cuide de tudo de forma automatica, mantendo seu banco de dados sempre atualizado com suas classes.

Na prática temos duas maneiras de trabalhar com o Migrations:  
1. Usar pontos de migração no banco de dados, onde podemos avançar, aplicando as últimas modificações, ou voltar na linha do tempo, em qualquer momento do banco de dados;  
2. Usar o modo totalmente automático, onde você não precisa se preocupar em atualizar o banco, pois ao executar o seu programa, isto será feito de maneira automatica.

Mas qual dos dois modelos eu devo utilizar em minha aplicação ? E a resposta é: Depende!. Se você precisa de um controle rigoroso das modificações, se precisa gerar scripts que serão executados no seu ambiente de produção, o melhor é usar o modo mais manual. Mas se o que lhe interessa é manter o banco sempre atualizado, sem se preocupar em rodar scripts, então use o modo automatico.

Neste artigo iremos abordar os dois métodos de utilização do Migrations e após entender cada um você poderá optar pelo que melhor se adequa ao seu processo.

**<u>Criando o projeto de exemplo</u>**

Antes de começar, vamos criar nosso projeto de exemplo. Eu estou usando o [Visual Studo 2012](http://www.microsoft.com/visualstudio/11/en-us/downloads), mas você pode também usar o Visual Studio 2010.

Vamos iniciar criando um projeto do tipo console, com o .Net Framework 4:  
![]( wp-content/uploads/2012/07/image.png)

Logo após criar o projeto, vamos adicionar o Entity Framework CodeFirst usando o NuGet. Para isto abra o gerenciador do NuGet em Tools/Library Package Manager/Packager Manager Console e digite:  
![]( wp-content/uploads/2012/07/image13.png)

Após isto teremos o EF CodeFirst instalado em nosso projeto. Vamos agora criar um Contexto e uma classe para podermos trabalhar com o Migrations.

Esta será a nossa classe de Contexto:

```csharp
public class Contexto : DbContextsdf
{
    public DbSet<Cliente> Cliente { get; set; }
}
```

E esta será a nossa classe de Clientes:

```csharp
public class Cliente
{
   public int ID { get; set; }
   public string Nome { get; set; }
}
```

Vamos também adicionar um arquivo app.config para identificarmos nosso servidor SQL e o nome do banco de dados:

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <connectionStrings>
    <add name="Contexto" providerName="System.Data.SqlClient" connectionString="data source=(local); initial catalog=ExemploMigrations; integrated security=true;"/>       
  </connectionStrings>
</configuration>
```

Agora que já temos nossas classes e o arquivo de configuração, vamos adicionar o Migrations.

**<u>Migrations – Gerenciando cada atualização no banco de dados</u>**

Vamos inicialmente adicionar o Migrations ao nosso projeto. Independente do método: manual ou automático, precisamos adicioná-lo ao nosso projeto. Faremos isto usando novamente a janela do Nuget através do comando Enable-Migrations:  
![]( wp-content/uploads/2012/07/image22.png)

Após este comando, uma nova classe será adicionada ao nosso projeto, o nome dela é Configurations:  
![]( wp-content/uploads/2012/07/image32.png)

Como vamos trabalhar com o processo manual, vamos deixar esta classe como está e vamos iniciar com os comandos do Migrations, que devem ser executados na janela do NuGet:

Agora, para todas as alterações que fizermos nas classes executaremos basicamente dois comandos:  
**Add-Migrations  
Update-DataBase**

Add-Migrations “nome_migrations” – cria um alteração no banco de dados, onde o “nome\_migrations” é o nome que você irá dar para a atualização;  
Update-DataBase – aplica as alterações no banco de dados;  
Update-DataBase – script – gera um script com os comandos SQL para serem executados no banco de dados.

Para nosso exemplo, iremos executar:  
**Add-Migrations “CriacaoBanco”  
Update-DataBase  
**  
Veja que ao executar o Add-Migrations, um novo arquivo foi adicionado ao projeto, contendo os comandos Migrations para o banco de dados:  
![]( wp-content/uploads/2012/07/image42.png)

```csharp
public partial class CriacaoBanco : DbMigration
{
    public override void Up()
    {
        CreateTable(
            "Clientes",
            c => new
                {
                    ID = c.Int(nullable: false, identity: true),
                    Nome = c.String(),
                })
            .PrimaryKey(t => t.ID);
        
    }
    
    public override void Down()
    {
        DropTable("Clientes");
    }
}
```

Como nosso banco de dados ainda não existia, ele foi criado após o comando Update-DataBase:  
![]( wp-content/uploads/2012/07/image52.png)

Para que nossos exemplo fiquem mais interessantes, vou adicionar alguns registros no banco de dados usando o código abaixo, mas se você preferir, insira os dados diretamente no SQL:

```csharp
static void Main(string[] args)
{
    var db = new Contexto();
    db.Cliente.Add(new Cliente() { Nome = "Carlos dos Santos" });
    db.Cliente.Add(new Cliente() { Nome = "Jose da Silva" });
    db.Cliente.Add(new Cliente() { Nome = "Antonio das Couves" });
    db.SaveChanges();
}
```

Agora vamos começar a modificar a nossa classe e ver como realmente o migrations pode nos ajudar. Inicialmente vamos adicionar um campo chamado Ativo na classe Cliente, e logo após vamos criar um novo Migration para enviar isto ao banco de dados:

Classe Cliente com o novo campo:
```csharp
public class Cliente
{
    public int ID { get; set; }
    public string Nome { get; set; }
}
```

Agora ao executar o comando Add-Migrations “Cliente_Ativo” teremos mais um arquivo do Migrations:
```csharp
public partial class Cliente_Ativo : DbMigration
{
    public override void Up()
    {
        AddColumn("Clientes", "Ativo", c => c.Boolean(nullable: false));
    }
    
    public override void Down()
    {
        DropColumn("Clientes", "Ativo");
    }
}
```

Mas antes de enviar isto para o banco, vamos imaginar que você queira setar um valor para o campo Ativo, por exemplo, todos os campos Ativos deverão estar true. Você pode fazer isto através do comando Sql() dentro do arquivo do migrations, veja:

```csharp
public partial class Cliente_Ativo : DbMigration
{
    public override void Up()
    {
        AddColumn("Clientes", "Ativo", c => c.Boolean(nullable: false));
        Sql("update clientes set ativo = 1");
    }
    
    public override void Down()
    {
        DropColumn("Clientes", "Ativo");
    }
}
```
Obviamente você poderia ter definido isto como um valor default par o banco, mass o intuito aqui é lhe mostrar como é possível enviar comandos durante o processo do Migrations.

Agora vamos enviar o comando para o banco, mas de uma maneira um pouco diferente, vamos gerar um script SQL. Para isto execute o comando da seguinte maneira:

**Update-DataBase –script**

E o resultado será um arquivo de script SQL:

```sql
ALTER TABLE [Clientes] ADD [Ativo] [bit] NOT NULL DEFAULT 0
update clientes set ativo = <span class="kwrd">1</span>
INSERT INTO [__MigrationHistory] ([MigrationId], [CreatedOn], [Model], [ProductVersion]) VALUES (<span class="str">'201207160033131_Cliente_Ativo'</span>, <span class="str">'2012-07-16T00:38:19.710Z'</span>, 0x1F8B0800000000000400CD56C96EDB3010BD17E83F083CB587988E0B0449202748ECB8085A3B4194E64E4B6387281755A40CFBDB7AE827F5173AD46E79C97AE84D2267797C7C33C3BFBFFFF8E74B29BC0524866BD527879D2EF140853AE26ADE27A99D1D1C93F3B38F1FFCAB482EBD87D2AEE7ECD053993E79B4363EA5D4848F2099E9481E26DAE899ED845A521669DAEB768FE9619702862018CBF3FCBB54592E21FBC1DF815621C4366562AC2310A658C79D208BEA4D980413B310FAE46A0932167ACCE709B308C610EF427086400210B317A2EA9E3854A4CA8719AF10995DDDAF62C8B2F6C9407050169A4668F60D566B0BB8749BE81812BBBA8359E17A3D241E5DF7A36DC7CAADE1E3B2E397B25F7AC49BA442B0A9C08519130688171F9D065627F01514200710DD326B21C16BB98E20435FB0701A1F3D8F8813DAED392228534ADB8CD60DE02D98132DA1041AD804E542BC115F42F41DD4DC3E5660C76C59AEE027F17E288EEA42279BA4D03C5CFEBF3FE985E50B5D66BDD45A00535B086A06F1697DA19BD78CC2B38C238DE55DE33F2CAD6E5D766E1C806D49C2AB63E7F2EB543BDB3054D96A7DD35CE06521D01D95E08F591C23C78DCA2856BC202F8BC141F072EDCB3C060DCD9612A8D0569950746C0EAD5D475A04239E183B64964D99BB814124B798EDE7B64CB3A7EAD6CAB3B477DFB9CF466BE8EC8852D337C2134934C90E0715969DF933DF206482255BEA76A0452AD5AEDADFE79D9753D33F5F797E84A2369A218AA5CD183E6D1DBFCD32DDA0B9D5C5DAB7B64FED6D932A7BA5FA96BAFD42694F0F830DE9E526C44372163C72B20B56C682EC38834EF04BE4F75A1B8C99E23330F65EFF0437D8B0325E3F50AA3E6A4C24FED3A9C2DDE99F9C1F7B7BEAFE69A0162C091F59F249B2E5E73775F829B7EFDCDDDB8DEACD6D3ED75B9F4453873AC7596C9A570F814DF9FBB4F962F28760F8BC0EE1DE4F0A42D7F2EAA0A5CDB59AE992643C5A135169D2BA8331581621431789E533165ADC0EC1986CC43F3091BA4E2BA7105DAB9BD4C6A9BD3006E454AC9AE7F5E9FEFCD9A45BC7ECDFC459D37E8F23204C8E47801B7599721155B8475B24B42384134B5121880A9F38186EBEAA224DB47A66A082BE21C4A05C7DDDBB2185C1CC8D0AD80276637B9AC375C6FC216738F96493C17CA5401230CCDC4881099A1E753EF7E0A7EEC57FF60FBDB90F33230C0000
```

Basta executar este arquivo dentro do SQL que o campo será criado e atualizado, ou se preferir, execute novamente o Update-DataBase que isto será feito automaticamente.  
Este recurso do script pode ser util se você precisar atualizar também um ambiente e produção da sua aplicação.  
![]( wp-content/uploads/2012/07/image62.png)

**<u>Obs: </u>**A tabela __MigrationHistory é usada pelo Migrations para gerenciar o histórico das versões dentro do banco de dados.

**<u>Voltando o banco de dados em um determinado ponto:</u>**

Um recurso bem interessante do Migrations é que você pode voltar o seu banco de dados a qualquer ponto em que tenha executado um Add-Migrations. Imagine então que nós criamos o campo ativo no banco e agora você queira voltar ao ponto onde este campo ainda não existia, para isto vamos executar o seguinte comando do Migrations:

**Update-DataBase –target “CriacaoBanco”**

Isto volta nosso banco de dados a este ponto, que nosso caso foi a criação do banco, mas poderia ser qualquer outro ponto. Lembrando que este comando afeta apenas o banco de dados e não a nossa classe.

Agora vamos ver como é executar o Migrations de forma totalmente automatica.

**<u>Migrations – Executando as atualizações automaticamente</u>**

Agora que você já sabe como manter seu banco de dados atualizados, gerando versões das atualizações, vamos imaginar que você não precisa manter este histórico, mas simplesmente manter o banco atualizado.

Para este exemplo, vamos criar um projeto com os mesmos dados do exemplo anterior, ou seja: crie um projeto do tipo console:  
![]( wp-content/uploads/2012/07/image72.png)

Adicione o EF CodeFirst através do console do NuGet e depois adicione o contexto, a classe cliente e o arquivo app.config, mas neste arquivo iremos modificar o nome do bando de dados para ExemploMigrationsAutomatico:

```csharp
public class Contexto : DbContext
{
   public DbSet<Cliente> Cliente { get; set; }
}
```

```csharp
public class Cliente
{
    public int ID { get; set; }
}       
```

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <connectionStrings>
    <add name="Contexto" providerName="System.Data.SqlClient" connectionString="data source=(local); initial catalog=ExemploMigrationsAutomatico; integrated security=true;"/>
  </connectionStrings>
</configuration>
```

Feito isto vamos adicionar o migrations, da mesma forma que antes, mas agora modificando os parâmetros necessários para que tudo fique automático, então abra o console do NuGet e execute o comando Enable-Migrations:  
![]( wp-content/uploads/2012/07/image82.png)

Agora que começam as diferenças. No exemplo anterior não modificamos nada na classe configurations, mas neste caso iremos fazer alguns ajustes:  
![]( wp-content/uploads/2012/07/image92.png)

Primeiro vamos mudar a classe para “public class”, pois precisaremos refenciá-lá posteriormente. Depois vamos ativar a propriedade da migração automatica e por fim vamos marcar a opção que dados podem ser perdidos durante a migração. Esta última opção fica a seu critério, pois se você não habilitar a opção e o Migrations não conseguir atualizar o banco de dados. você receberá um erro.

E agora vamos modificar o construtor do contexto para ele chamar o DatabaseInitializer, que é quem faz todo o processo acontecer:

```csharp
public class Contexto : DbContext
{
    public DbSet<Cliente> Cliente { get; set; }

    public Contexto()
    {
        Database.SetInitializer(new MigrateDatabaseToLatestVersion<Contexto, Configuration>());
    }
}
```

O que fizemos foi adicionar a chamada do DatabaseSetInitializer() com a opção MigrateDatabaseToLastVersion, o que faz com que nosso banco de dados seja sempre atualizado de acordo com as nossas classes.

Agora é só executar o exemplo abaixo para criarmos o banco de dados:

```csharp
static void Main(string[] args)
{
    var db = new Contexto();
    db.Cliente.Add(new Cliente() { Nome = "Carlos dos Santos" });
    db.Cliente.Add(new Cliente() { Nome = "Jose da Silva" });
    db.Cliente.Add(new Cliente() { Nome = "Antonio das Couves" });
    db.SaveChanges();
}
```

Agora vamos modificar a classe cliente e simplesmente executar o programa novamente:

```csharp
public class Cliente
{
    public int ID { get; set; }
    public string Nome { get; set; }
    public string CPF { get; set; }
    public decimal Limite { get; set; }
}
```

Após executar o programa e fazer uma consulta no SQL:  
![]( wp-content/uploads/2012/07/image102.png)

**Conclusão:**

O recurso de Migrations sem dúvida é algo realmente fantástico no Entity Framework CodeFirst e certament ajuda na produtividade do nosso dia a dia. Escolha o que melhor lhe atender e começe a usar agora mesmo.

Abraços e até a próxima.  
Carlos dos Santos.
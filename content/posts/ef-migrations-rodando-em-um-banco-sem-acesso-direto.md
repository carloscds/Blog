---
title: 'EF Migrations - Como rodar os updates se eu não tenho acesso direto ao banco ?'
date: 2025-01-20
author: carloscds
layout: post
categories:
  - C Sharp
  - EntityFramework Core
  - EF Core
---
Se você já trabalhou em um projeto onde existe um DBA então o título deste post é muito familiar para você, pois o DBA jamais vai deixar você rodar qualquer tipo de 'coisa' no banco de produção. Em um ambiente bem controlado, mesmo sem a presença de um DBA, isto também é uma EXCELENTE prática, afinal deixar o DEV rodar qualquer tipo de coisa no banco de produção pode ser um tanto perigoso!

Então ok, mas eu desenvolvo com EntityFramework e uso Migrations, como assim eu não posso rodar o comando:

```cmd
dotnet ef database update
```

Mas você pode rodar este comando, mas no seu banco de desenvolvimento e provavelmente no de homologação, no de produção provavelmente não, pois você não terá acesso ao ambiente por uma simples questão de **segurança**.



## Antes de iniciarmos, vamos criar um projeto base para os nossos testes

Neste exemplo estou criando um projeto console em .NET 8 e adicionando o EntityFarmeworkCore também na versão 8, usando SQL Server, mas você pode usar outra versão do EF e também outro banco de dados.

O nosso projeto tem a seguinte configuração:

![]( wp-content/uploads/2025/01/EstruturaProjetoMigrations.png)

Na imagem acima vemos a estrutura de pastas que contem o EF, o Configuration e também a pasta Migrations, uma vez que eu ja rodei o migration inicial.

Agora vamos analisar o Contexto.cs

```csharp
public class Contexto : DbContext
{
    public Contexto(DbContextOptions<Contexto> options) : base(options) {}
    public DbSet<Produto> Produto { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(Contexto).Assembly);
    }
}
```

Agora a classe de domínio Produto.cs:

```csharp
public class Produto
{
    public int Id { get; set; }
    public Guid Key { get; set; } = Guid.NewGuid();
    public string Nome { get; set; }
}
```

E por fim o arquivo de configurações do Produto:

```csharp
public class ProdutoConfiguration : IEntityTypeConfiguration<Produto>
{
    public void Configure(EntityTypeBuilder<Produto> builder)
    {
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id)
               .UseIdentityColumn()
               .ValueGeneratedOnAdd();
        builder.Property(x => x.Nome)
               .HasMaxLength(200);
        builder.HasIndex(e => e.Key).IsUnique();
    }
}
```

Até aqui nada demais desde que você esteja familiarizado com o uso do EF! Caso não esteja, tenho diversos outros artigos aqui no blog falando sobre EF!

## Agora vamos entender como o Migrations funciona

Quando você cria suas classes que representam as tabelas do banco de dados, você as mapeia no Contexto usando DbSets, indicando ao EF o que tem no seu banco de dados. Eu também espero, sinceramente, que você tenha um arquivo Configurations para cada tabela/classe, e que tenha feito as devidas configurações de tipos, tamanhos e relacionamentos corretamente! (PS: Cuidado com varcharmax!!!)

Muito bem, quando você rodar o comando abaixo:

```cmd
dotnet ef migratons Add Inicial
```

Isto cria ou modifica, um arquivo chamado ContextoModelSnapshot.cs, onde *Contexto* é o nome do seu contexto. Este arquivo contem uma *imagem* do seu banco completo. Além deste arquivo você verá também um outro com o nome do seu migrations, por exemplo: 20250120234254_Initial.cs onde o incio é data e hora que você executou o migrations mais o nome que você deu.

Por fim, temos as duas classes do Migrations  até este momento, a primeira é o ContextoModelSnapshot:

```csharp
    [DbContext(typeof(Contexto))]
    partial class ContextoModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "8.0.12")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("EFMigrationsUpdate.Domain.Produto", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<Guid>("Key")
                        .HasColumnType("uniqueidentifier");

                    b.Property<string>("Nome")
                        .IsRequired()
                        .HasMaxLength(200)
                        .HasColumnType("nvarchar(200)");

                    b.HasKey("Id");

                    b.HasIndex("Key")
                        .IsUnique();

                    b.ToTable("Produto");
                });
#pragma warning restore 612, 618
        }
```

Neste nosso exemplo o ModelSnapshot é bem simples, pois temos apenas uma tabela no banco, mas em projetos mais complexos este arquivo contem toda a configuração do banco de dados, com tabelas, relacionamentos, índices, etc.

O outro arquivo que temos é o migrations chamado "Initial" que rodei inicialmente:

```csharp
public partial class Initial : Migration
{
    /// <inheritdoc />
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.CreateTable(
            name: "Produto",
            columns: table => new
            {
                Id = table.Column<int>(type: "int", nullable: false)
                    .Annotation("SqlServer:Identity", "1, 1"),
                Key = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                Nome = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false)
            },
            constraints: table =>
            {
                table.PrimaryKey("PK_Produto", x => x.Id);
            });

        migrationBuilder.CreateIndex(
            name: "IX_Produto_Key",
            table: "Produto",
            column: "Key",
            unique: true);
    }

    /// <inheritdoc />
    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.DropTable(
            name: "Produto");
    }
}
```

Agora se eu pedir para você atualizara o banco de dados, provavelmente você irá rodar o comando abaixo:

```cmd
dotnet ef database update
```

ou se for em um banco de dados específico:

```cmd
dotnet ef database update --connection "conexao_do_banco"
```

Mas o nosso problema é que não temos acesso ao banco de dados, se lembra ?

### Criando scripts para executar no banco 

A solução para isto ? Gerar scripts e executar no ambiente onde o banco de dados está! E isto o EF Migrations faz desde muito, muito tempo!!!

Então ao invés de simplesmente rodarmos o comando diretamente no banco, vamos criar scripts a cada vez que o banco precisar ser atualizado!

O comando abaixo gera o script inicial do banco:

```cmd
dotnet ef migrations script 0 Initial
```

O '0' neste caso representa o primeiro script, e como ainda não rodamos nada, ele se faz necessário, logo após indicamos **até qual migrations iremos gerar o script** e neste caso é até o *Initial*.

Este comando gera o script SQL e o mostra na tela, veja:

![]( wp-content/uploads/2025/01/ScriptNaTela.png)

Mas acrescentando o comando -o "arquivo.sql" conseguimos criar um arquivo:

```cmd
dotnet ef migrations script 0 Initial -o initial.sql
```

E o conteudo deste arquivo é este:

```sql
IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Produto] (
    [Id] int NOT NULL IDENTITY,
    [Key] uniqueidentifier NOT NULL,
    [Nome] nvarchar(200) NOT NULL,
    CONSTRAINT [PK_Produto] PRIMARY KEY ([Id])
);
GO

CREATE UNIQUE INDEX [IX_Produto_Key] ON [Produto] ([Key]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250120234254_Initial', N'8.0.12');
GO

COMMIT;
GO
```

Pois bem, agora é so executar este script no servidor de producão.

## Mas eu tenho muitos outros migrations para executar

Muito bem, teremos muitos outros migrations para executar, como iremos saber qual script rodar ?

O EF cria uma tabela no seu banco de dados chamada **EF_MigrationsHistory**, veja abaixo:

![]( wp-content/uploads/2025/01/MigrationsHistoryTable.png)

Esta tabela guarda o histórico de todos os migrations que você rodou no banco! Então **CUIDADO**, preferencialmente não altere esta tabela ok! Fazendo um select nela veremos todos os migrations executados, em ordem cronológica, assim é so pegar o último e rodar a partir dele!

Vamos fazer ver como funciona ?

### Criando outro migrations e rodando o script

Agora vamos adicionar um campo novo na nossa tabela produtos chamado Preco, do tipo decimal:

```csharp
public class Produto
{
    public int Id { get; set; }
    public Guid Key { get; set; } = Guid.NewGuid();
    public string Nome { get; set; }
    public decimal Preco { get; set; }
}
```

Vamos modificar também o arquivo de configurações para colocar a precisão do campo

```csharp
public class ProdutoConfiguration : IEntityTypeConfiguration<Produto>
{
    public void Configure(EntityTypeBuilder<Produto> builder)
    {
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id)
               .UseIdentityColumn()
               .ValueGeneratedOnAdd();
        builder.Property(x => x.Nome)
               .HasMaxLength(200);
        builder.Property(x => x.Preco)
               .HasPrecision(18, 2);
        builder.HasIndex(e => e.Key).IsUnique();
    }
}
```

Agora vamos rodar outro migrations chamado ProdutoAddPreco:

```cmd
dotnet ef migrations add ProdutoAddPreco
```

E finalmente iremos criar o script para este migrations:

```cmd
dotnet ef migrations script Initial ProdutoAddPreco -o ProdutoAddPreco.sql
```

Lembrando que o ***Initial*** foi o ultimo script que executamos e o ***ProdutoAddPreco*** é o atual

Isto produzira o seguinte script SQL:

```sql
BEGIN TRANSACTION;
GO

ALTER TABLE [Produto] ADD [Preco] decimal(18,2) NOT NULL DEFAULT 0.0;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250121002645_ProdutoAddPreco', N'8.0.12');
GO

COMMIT;
GO
```

Veja que além de adicionar o campo Preco natabela Produto, ele também adiciona uma nova linha na tabela __EFMigrationsHistory

Agora é so rodar no banco de dados!

Para finalizar vou adicionar mais um campo no produto chamado Custo:

```csharp
public class Produto
{
    public int Id { get; set; }
    public Guid Key { get; set; } = Guid.NewGuid();
    public string Nome { get; set; }
    public decimal Preco { get; set; }
    public decimal Custo { get; set; }
}
```

E também vou fazer a configuração:

```csharp
public class ProdutoConfiguration : IEntityTypeConfiguration<Produto>
{
    public void Configure(EntityTypeBuilder<Produto> builder)
    {
        builder.HasKey(x => x.Id);
        builder.Property(x => x.Id)
               .UseIdentityColumn()
               .ValueGeneratedOnAdd();
        builder.Property(x => x.Nome)
               .HasMaxLength(200);
        builder.Property(x => x.Preco)
               .HasPrecision(18, 2);
        builder.Property(x => x.Custo)
               .HasPrecision(18, 2);
        builder.HasIndex(e => e.Key).IsUnique();
    }
}
```

E agora vamos adicionar o migrations:

```cmd
dotnet ef migrations add ProdutoAddCusto
```

E finalmente iremos criar o script para este migrations:

```cmd
dotnet ef migrations script ProdutoAddPreco ProdutoAddCusto -o ProdutoAddCusto.sql
```

Lembrando que o ***ProdutoAddPreco*** foi o ultimo script que executamos e o ***ProdutoAddCusto*** é o atual

Isto produzira o seguinte script SQL:

```sql
BEGIN TRANSACTION;
GO

ALTER TABLE [Produto] ADD [Custo] decimal(18,2) NOT NULL DEFAULT 0.0;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250121003310_ProdutoAddCusto', N'8.0.12');
GO

COMMIT;
GO
```

Pronto, agora você pode atualizar um banco que você não tem acesso diretamente, usando scripts!

### Considerações
Atualização de bancos de dados em produção exige muito controle e cuidado! Se você tem acesso direto, faça com cautela, e caso você não tenha, espero que o artigo seja útil para você!

O código fonte do exemplo está no meu [GitHub](https://github.com/carloscds/CSharpSamples/tree/master/EFMigrationsUpdate/EFMigrationsUpdate).

Abraços e até a próxima!

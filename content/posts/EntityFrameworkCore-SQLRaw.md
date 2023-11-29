---
id: 10426
title: 'EntityFramework - SQL Raw Queries'
date: 2023-11-28
author: carloscds
layout: post
categories:
  - C Sharp 
  - EntityFramework 
---
Recentemente foi lancado o EF 8, juntamente com o .NET 8 e com ele muitas novidades! Mas dentre todas, uma que 'volta', sim, ela já existiu no passado, é o uso de queries diretas sem uso do contexto, também conhecidas como RAW Queries.

Podemos afirmar que o seu uso é muito parecido com o Dapper, mas em um contexto do EF.

## Como funciona ?

Imagine que você tem um banco de dados de Livros, como o script abaixo:

```sql
CREATE TABLE [dbo].[Editora](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](20) NOT NULL,
	[Endereco] [varchar](50) NOT NULL,
	[Numero] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Livro](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](30) NOT NULL,
	[preco] [decimal](6, 2) NULL,
	[Lancamento] [datetime] NULL,
	[Id_Editora] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Livro]  WITH CHECK ADD  CONSTRAINT [Fk_Editora] FOREIGN KEY([Id_Editora])
REFERENCES [dbo].[Editora] ([id])
GO

ALTER TABLE [dbo].[Livro] CHECK CONSTRAINT [Fk_Editora]
GO
```

Então temos um banco de dados com Editora e Livro, precisamos então de duas classes para mapear estas tabelas no contexto do EF:

```csharp
public class Editora
{
    public int ID { get; set; }
    public string? Nome { get; set; }
    public string? Endereco { get; set; }
    public string? Numero { get; set; }
}

public class Livro
{
    public int ID { get; set; }
    public string? Nome { get; set; }
    public decimal Preco { get; set; }
    public DateTime Lancamento { get; set; }
    public int Id_Editora {get; set;}
    public virtual Editora Editora { get; set; }
}
```

E também o contexto:
```csharp
public class Contexto : DbContext
{
    public Contexto(DbContextOptions<Contexto> options): base(options) { }

    public DbSet<Editora> Editora { get; set; }
    public DbSet<Livro> Livro { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
        base.OnModelCreating(modelBuilder);
    }
}
```
Então se quisermos fazer uma consulta usando o Entity, podemos fazer algo assim:

```csharp
var dbOptions = new DbContextOptionsBuilder<Contexto>()
            .UseSqlServer("data source=(local); initial catalog=AceleraDev; integrated security=true;trusted_connection=true;encrypt=false;multipleactiveresultsets=true;")
            .UseLazyLoadingProxies();

var db = new Contexto(dbOptions.Options);

var livros = db.Livro;
foreach(var l in  livros)
{
    Console.WriteLine(l.Nome);
}
```

Ok, então para uma consulta no EF eu preciso criar relacionamentos, mapear tudo e depois navegar usando Proxy! Isto era o que faziamos, pois agora dá para fazer algo bem interessante!

## Usando o SQL Raw

Agora vamos fazer uma consulta usando um comando SQL Direto, mas precisamos guardar o resultado em uma classe, então vamos criar uma classe Dto para isto:

```csharp
public class LivroEditoraDto
{
    public string? Livro { get; set; }
    public decimal Preco { get; set; }
    public string? Editora { get; set; }
}
```

E agora fazemos a consulta:
```csharp
var livroEditora = db.Database.SqlQuery<LivroEditoraDto>($"select l.Nome Livro,l.preco Preco,e.nome Editora from livro l, editora e where l.Id_Editora = e.id")
                        .ToList();
foreach (var l in livroEditora)
{
    Console.WriteLine($"{l.Livro} - Ed {l.Editora} - {l.Preco}");
}
```

Veja que a classe **LivroEditoraDto** nao está mapeada no contexto, ela foi usada apenas na consulta. Então o resultado da nossa consulta é "copiado" para a classe Dto e esta classe não precisa existir no Contexto.

Pense que você pode fazer queries como no Dapper e ainda utilizar todos os benefícios dos relacionamentos do EF!!!


### Considerações
Agora podemos escrever nossas queries manualmente e fazer uma consulta que retorna um dado serializado em uma classe! Muito bom!!! Mas cuidado! Você está usando a sintaxe do banco de dados e isto pode quebrar a compatibilidade com outros bancos. Mesmo assim é muito interessante!!!

O código fonte deste exemplo pode ser encontrado no meu GitHub: https://github.com/carloscds/EntityFramework/tree/main/EFCore8SQLRaw

Abraços e até a próxima!

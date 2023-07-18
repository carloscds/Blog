---
id: 10426
title: 'EntityFramework Core - Inicio (de novo)'
date: 2023-07-17
author: carloscds
layout: post
categories:
  - C#
  - EntityFramework 
---
Durante muito tempo eu publiquei muito conteúdo sobre EntityFramework (EF), muito antes da versão Core surgir, e durante muito tempo depois desta nova versão eu apenas acompanhei o desenvolvimento, até que na versão 3.1, o EF Core ficou realmente bom para uso em grandes projetos, com a produção de queries "muito limpas" para o banco de dados. Neste ponto voltei a colocar o EF nos meus projetos.

Mas antes de contonuar, precisamos fazer uma explicação para você que "ainda" acha que o EntityFramework é um ORM ruim. Então existem duas grandes versões muito distintas do EF:
* EntityFramework 6.3 - roda apenas no .NET Framework, para Windows
* EntityFramework Core 3.1 ate EF 8 (preview) - nova versão, escrita do ZERO, muito focada em performance e multiplataforma

Então acho que agora está claro que o EF foi "feito de novo" e que ficou realmente muito melhor! E apesar da Microsoft ter removido o termo "Core", vamos chamar de EF Core apenas por uma questão de separação das versões.

### Foco na performance
Como a ferramenta foi reescrita, o foco desde a versão EF Core 5 foi a performance, assim temos um ORM que produz queries muito limpas. Lembrando que não existe "magica", um banco mal projetado não pode ser resolvido apenas como ORM, você precisa construir bem os relacionamentos, provisionar corretamente índices, analisar queries no ambiente de produção, uso de CPU e disco, etc.

### Tem alguma outra coisa que podemos usar alem do EF ?
* **Dapper**: Durante muito tempo em que eu não usei o EF Core em meus projetos, optamos por usar o [Dapper](https://dapperlib.github.io/Dapper/), um Micro ORM muito eficiente, onde você executa queries no banco e ele serializa em objetos para você. ISto simplifica muito as operações do banco de dados e deixa o código bem mais limpo. O Dapper funciona como um método de extensão da clase Connection do banco, por exemplo do SqlConnection().

* **ADO.NET**: Ainda temos o bom e velho ADO.NET, mas sinceramente, depois que você começa com Dapper, fica difícil voltar ao ADO, criando comandos e passando parâmetros: SqlConnection, SqlCommand, SqlDataReader, etc.

* **EF**: Claro que temos o EF Core, atualmente na versão 7.0 (STS) e quase chegando na versão 8.0 (LTS), que será lançada em novembro de 2023. Nesta versão, temos mais melhorias de performance e muito mais funcionalidades, algumas que eu sentia falta desde a versão 6.3 do EntityFramework para Windows,como executar querys escritas e transformar em objetos, [Veja aqui um exemplo.](https://github.com/dotnet/EntityFramework.Docs/blob/main/samples/core/Miscellaneous/NewInEFCore8/RawSqlSample.cs)

### Mas o que eu uso então ? Dapper ou EF ?
Você pode até usar os DOIS, mas vou te dar um exemplo prático: na [CDS](https://www.cds-software.com.br), empresa em que trabalho, temos um ERP em Nuvem chamado [BeijaFlorERP](https://www.beijaflorerp.com.br), que foi escrito com EntityFramework 6.3 e precisávamos dar um upgrade no acesso ao banco de dados. Então começamos a migrar o código para Dapper, até que eu percebi que seria mais simples e rápido migrar tudo para EF Core, usando .NET Standard, que permite um código .NET Framework funcionar junto com um código .NET Core ([se voce nunca ouviu falar disto clique aqui](https://github.com/carloscds/DotNetConfSample)), ou seja, agora temos uma aplicação híbrida. Foi um dia intenso de trabalho, mas eu consegui migrar todo o acesso a dados para EF Core, e claro, mais alguns dias ajustando algumas partes do código.

o EF tem uma grande vantagem em relação ao Dapper que são os relacionamentos, por exemplo: você tem um Cliente e um Pedido, no EF eu posso criar um relacionamento entre estes dois objetos, e a medida que eu carrego os pedidos, posso, automaticamente carregar o cliente, sem precisar construir manualmente uma query, que seria necessária no caso do Dapper.

As vezes o desenvolvedor prefere o Dapper por causa da "complexidade" da configuração dos relacionamentos no EF, principalmente de um banco existente. Mas posso garantir a você que o trabalho compensa pelo resultado. Ah, existem tambem aquela histório que falei la no começo de que o EntityFramework é ruim!

Do ponto de vista de performance, se você construir corretamente o seu banco, observando o que eu ja falei acima, certamente terá bons resultados. 

Mas e se eu quiser escrever a minha query manualmente, é possível ? Sim, o EF 8.0 permite escrever queries manualmente,[veja aqui.](https://github.com/dotnet/EntityFramework.Docs/blob/main/samples/core/Miscellaneous/NewInEFCore8/RawSqlSample.cs)

E não podemos deixar de citar que o EF é multibanco, ou seja, mudando apenas o "provider", mudamos de banco. E eu ja tive que fazer isto no meio de um projeto, pois o cliente mudou do MySQL para o Postgres, e para mim foi mudar uma linha no código, trocando o provider.

### Um pequeno exemplo
Para não ficarmos somente na conversa, veja abaixo um exemplo bem simples de acesso a dados com EF:

Script para o banco de dados:
```sql
CREATE TABLE [dbo].[Cliente](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](100) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
```
Este script cria apenas uma tabela chama Cliente com uma chave primaria ID, do tipo identity e uma coluna Nome.


Agora vamos criar o acesso ao banco com EF. Para isto vamos começar com a classe que irá representar a tabela cliente:

```csharp
public class Cliente 
{
    public int ID {get; set; }
    public string Nome { get; set; }
}
```

Primeiramente o Contexto do EF, que é onde mapeamos os objetos para o banco de dados:

```csharp
public class Contexto : DbContext
{
    public Contexto(DbContextOptions options): base(options) {}

    public DbSet<Cliente> Cliente { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Cliente>()
            .HasKey(p => p.ID);
        modelBuilder.Entity<Cliente>()
            .Property(p => p.ID)
            .UseIdentityColumn()
            .ValueGeneratedOnAdd();

        base.OnModelCreating(modelBuilder);
    }
}
```
O Contexto acima configura algumas propriedades do Cliente, como a chave primária e o auto incremento da coluna.

Agora vamos iniciar a conexão com o banco:

```csharp
var opt = new DbContextOptionsBuilder<DbContext>()
                .UseSqlServer("data source=(local); initial catalog=ExemploEF;integrated security=true;trusted_connection=true; encrypt=false;");
var db = new Contexto(opt.Options);
```

Agora vamos adicionar um Cliente:

```csharp
var cli = new Cliente { Nome = "Carlos" };
db.Cliente.Add(cli);
db.SaveChanges();
```

E depois vamos ler os clientes com ID maior que ZERO:
```csharp
var dados = db.Cliente.Where(w => w.ID > 0);
```

Veja a consulta produzida no banco:
```sql
SELECT [c].[ID], [c].[Nome]
      FROM [Cliente] AS [c]
      WHERE [c].[ID] > 0
```

Este é um pequeno exemplo do uso do EF Core, no próximo post iremos montar uma estrutura com Master x Detail.

O código fonte deste exemplo pode ser encontrado no meu GitHub: https://github.com/carloscds/EntityFramework

Abraços e até a próxima!

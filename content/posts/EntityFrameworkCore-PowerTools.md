---
id: 10426
title: 'EntityFramework Core PowerTools - Engenharia Reversa do Banco de Dados'
date: 2023-07-25
author: carloscds
layout: post
categories:
  - C Sharp 
  - EntityFramework 
---
Este artigo é uma dica rápida, mas extremamente útil! Imagine que você já tem um banco de dados e quer usar o EF, o que você faz ? Cria tudo na mão ? Esera que tem um jeito muito mais interessante!

### Apresentando o EF Core PowerTools
Este é uma ferramenta que considero essencial para trabalhar com EF. Não é uma ferramenta nova, já escrevi sobre ela há muitos anos atrás, mas ainda considero bastante útil no cenário que mencionei acima, você já tem o banco e precisa criar as classes.
Para começar você então precisa baixar a extensão para o Visual Studio [neste link](https://marketplace.visualstudio.com/items?itemName=ErikEJ.EFCorePowerTools) ou se prefeir pode baixar diretamente nas extensões do Visual Studio

![]( wp-content/uploads/2023/07/VS-Extension-EFCorePowerTools.png)



### Testando o componente
Para este teste vou criar simplesmente um projeto Console em Core, depois clicando com o botão direito na Solution você ver um novo menu:

![]( wp-content/uploads/2023/07/SolutionMenu-EFCorePowerToolsMenu.png)

Agora vamos escolher **Reverse Engineer** e depois clicamos em **Add Database Connection**

Lembre-se de escolher a versão do EF Core que você está usando e depois adicione a conexão:

![]( wp-content/uploads/2023/07/EFPowerToolsAddConnection.png)

Preencha com os dados do seu servidor:

![]( wp-content/uploads/2023/07/EFCorePowerTools-SelectDatabase.png)

E depois selecione as tabelas do seu banco:

![]( wp-content/uploads/2023/07/EFPowerToolsTables.png)

Por último podemos ajustar algumas configurações da geração do código:

![]( wp-content/uploads/2023/07/EFCorePowerTools-ConfigClasses.png)

Se você quer dar uma "refinada" nas classes, por exemplo gerando arquivos de configuração, vá em **Advanced**:

![]( wp-content/uploads/2023/07/EFCorePowerTools-ConfigClassesAdvanced.png)

Agora sim, ja temos nossas classes, vejam o projeto:

![]( wp-content/uploads/2023/07/EFCorePowerTools-ProjectConfigured.png)

Agora vamos examinar algumas classes:

#### Contexto
```csharp
public partial class EF1Context : DbContext
{
    public EF1Context(DbContextOptions<EF1Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Cliente> Cliente { get; set; } = null!;
    public virtual DbSet<Pedido> Pedido { get; set; } = null!;
    public virtual DbSet<PedidoItem> PedidoItem { get; set; } = null!;
    public virtual DbSet<Produto> Produto { get; set; } = null!;

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfiguration(new Configurations.ClienteConfiguration());
        modelBuilder.ApplyConfiguration(new Configurations.PedidoConfiguration());
        modelBuilder.ApplyConfiguration(new Configurations.PedidoItemConfiguration());
        modelBuilder.ApplyConfiguration(new Configurations.ProdutoConfiguration());

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
```

#### Cliente
```csharp
 public partial class Cliente
{
    public Cliente()
    {
        Pedido = new HashSet<Pedido>();
    }

    public int Id { get; set; }
    public string Nome { get; set; } = null!;

    public virtual ICollection<Pedido> Pedido { get; set; }
}
```

#### Pedido
```csharp
public partial class Pedido
{
    public Pedido()
    {
        PedidoItem = new HashSet<PedidoItem>();
    }

    public int Id { get; set; }
    public DateTime Data { get; set; }
    public int ClienteId { get; set; }
    public decimal Total { get; set; }

    public virtual Cliente Cliente { get; set; } = null!;
    public virtual ICollection<PedidoItem> PedidoItem { get; set; }
}
```
Vejam que os relacionamentos foram feitos!

#### PedidoConfiguration
```csharp
public partial class PedidoConfiguration : IEntityTypeConfiguration<Pedido>
{
    public void Configure(EntityTypeBuilder<Pedido> entity)
    {
        entity.HasIndex(e => e.ClienteId, "IX_Pedido_ClienteId");

        entity.Property(e => e.Total).HasColumnType("decimal(18, 2)");

        entity.HasOne(d => d.Cliente)
            .WithMany(p => p.Pedido)
            .HasForeignKey(d => d.ClienteId)
            .OnDelete(DeleteBehavior.ClientSetNull);

        OnConfigurePartial(entity);
    }

    partial void OnConfigurePartial(EntityTypeBuilder<Pedido> entity);
}
```

Agora só instanciar o contexto e testar:

```csharp
static void Main(string[] args)
{
    var opt = new DbContextOptionsBuilder<EF1Context>()
        .UseSqlServer("data source=(local); initial catalog=EF1;integrated security=true;trusted_connection=true; encrypt=false;");
    var db = new EF1Context(opt.Options);

    foreach(var c in db.Cliente) 
    {
        Console.WriteLine($"{c.Nome}");
    }
}
```

O código fonte deste exemplo pode ser encontrado no meu GitHub: https://github.com/carloscds/EntityFramework

Abraços e até a próxima!

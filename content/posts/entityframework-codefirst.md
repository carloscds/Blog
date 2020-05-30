---
id: 568
title: EntityFramework CodeFirst
date: 2012-01-07T23:31:48-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2012/01/entityframework-codefirst/
permalink: /2012/01/entityframework-codefirst/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'msdn;c#;ef codefirst; ef'
---
No [post anterior](http://carloscds.net/2012/01/trabalhando-com-entity-framework-designer), eu falei em como trabalhar com Entity Framework usando o Designer, ou seja, um modelo de classes criado a partir de um arquivo EDMX. Este modelo funciona perfeitamente em diversos tipos de projetos, mas o grande incoveniente é ter um arquivo EDMX para cada tipo de banco de dados do seu projeto.

Então vamos agora usar uma abordagem diferente, mas nem tão diferente assim do artigo anterior. Nossa necessidade ainda é manter o isolamento do banco de dados e trabalhar somente com objetos. O CodeFirst, como o próprio nome sugere, nos leva a criar primeiramente as classes POCO e depois o banco de dados, mas é possível também pegar um banco de dados existente e gerar o CodeFirst.

O Entity Framework faz uma ponte entre as classes POCO e o banco de dados utilizando um container que chamamos de <u>Contexto</u>. O contexto é o responsável por mapear as nossas classes com o banco de dados e também por informar ao engine quem é o banco de dados, através da string de conexão, e isto é o que mais me agrada no Code First, você precisa trocar somente a string de conexão para mudar de banco. Nenhum tipo de alteração no código é necessária.

**<u>Instalando o Entity Framework Code First:</u>**

Antes de começarmos a escrever as classes, precisamos instalar o Entity Framework CodeFirst, que é basicamente composto pela EntityFramework.DLL. Faremos isto isando o NuGet, que é um instalador de pacotes para o Visual Studio. Se você ainda não o possui, vá até o Extension Manager do Visual Studio (Tools/Extension Manager) e instale:

![](/wp-content/uploads/2012/01/SNAGHTMLa23ac4a_thumb1_thumb8.png)

Depois de instalado o NuGet, vá em Tools/Library Package Manager/Package Manager Console. Isto vai abrir o gerenciador do NuGet:

![](http://carloscds.net/wp-content/uploads/2012/01/image_thumb1_thumb8.png)

Agora digite o comando: **Install-Package EntityFramework** dentro do console, isto irá instalara o EF CodeFirst e suas dependências:

**<u>Criando um projeto com o EntityFramework CodeFirst:</u>**

Vamos criar uma classe de contexto que chamaremos de Contexto.cs, esta classe irá herdar de DbContext e nela iremos mapear nossas tabelas:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;

namespace EFCodeFirst
{
    public class Contexto : DbContext
    {
        public DbSet<Grupo> Grupo { get; set; }
        public DbSet<Produto> Produto { get; set; }
    }
}
```

O segredo aqui é o DBSet<>, pois ele faz o mapeamento da nossa classe para o banco e vincula a um objeto, que utilizaremos para fazer as operações com o BD.

Veja o código da classe Grupo:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace EFCodeFirst
{
    [Table("Grupo")]
    public class Grupo
    {
        public int ID { get; set; }
        [Required(ErrorMessage="Nome não pode ser branco.")]
        public string Nome { get; set; }

        public virtual IQueryable<Produto> Produtos { get; set; }
    }
}
``` 
E da classe Produto:

```csharp {.line-numbers}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace EFCodeFirst
{
    [Table("Produto")]
    public class Produto
    {
        public int ID { get; set; }
        [Required(ErrorMessage="Nome não pode ser branco.")]
        public string Descricao { get; set; }
        public int GrupoID { get; set; }

        [ForeignKey("GrupoID")]
        public virtual Grupo Grupo { get; set; }
    }
}
``` 
No CodeFirst podemos controlar todos os aspectos do mapeamento das classes com o banco de dados, desde o nome da tabela no banco, obrigatoriedade dos campos, tamanho, etc.

Na classe Grupo, eu determinei o nome da tabela no banco de dados, ou seja, podemos ter um nome para a classes e outro para a tabela no banco de dados. Informei também que o nome não pode ser banco e vinculei uma mensagem, que pode ser usada em projetos MVC e WPF. Finalmente criei o relacionamento entre Grupo e Produto.

Na classe Produto, eu determinei também o nome da tabela no banco de dados, e o campo obrigatório. Fiz também o relacionamento com a tabela grupo através do campo GrupoID.

O EF identifica também automaticamente as chaves primárias das tabelas, desde que você as chame por ID ou nome_da_tabelaID, exemplo: GrupoID ou ProdutoID.

Um coisa muito legal que o EF CodeFirst faz para nós é criar o banco de dados, mas isto depende do provider do seu banco de dados, nem todos aceitam a criação do banco.

Vamos agora montar um exemplo para carregar dados no nosso banco:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EFCodeFirst
{
    class Program
    {
        static void Main(string[] args)
        {
            var db = new Contexto();

            db.Database.CreateIfNotExists();

            var g1 = new Grupo() { Nome = "Peças" };
            var g2 = new Grupo() { Nome = "Serviços" };

            db.Grupo.Add(g1);
            db.Grupo.Add(g2);

            var p1 = new Produto() { Descricao = "Pneu", Grupo = g1 };
            var p2 = new Produto() { Descricao = "Roda", Grupo = g1 };
            var p3 = new Produto() { Descricao = "Alinhamento", Grupo = g2 };
            var p4 = new Produto() { Descricao = "Balanceamento", Grupo = g2 };

            db.Produto.Add(p1);
            db.Produto.Add(p2);
            db.Produto.Add(p3);
            db.Produto.Add(p4);

            db.SaveChanges();

            var dados = from p in db.Produto
                        select p;

            foreach (var linha in dados)
            {
                Console.WriteLine("{0,-30} - {1}", linha.Grupo.Nome, linha.Descricao);
            }

        }
    }
}
```

O código acima cria o nosso banco de dados no SQL, caso ele não exista (linha 14). Após isto eu inseri os dados em Grupo e Produto, mas percebam que eu simplesmente vinculei os objetos, sem me preocupar com as chaves primárias ou estrangeiras, pois o EF resolve isto para nós desde que seu mapeamento esteja correto.

Assim ao final do código temos o banco de dados criado e os dados inseridos. Veja como ficou o banco de dados no Management Studio:

![](/wp-content/uploads/2012/01/image_thumb3_thumb1_thumb6.png)

Veja que o nome do banco de dados é o nome da aplicação mais o nome do Contexto, mas podemos resolver isto adicionando um arquivo App.Config e informando os dados do banco, então vamos adicionar um arquivo de configuração ao nosso exemplo e colocar a seguinte linha:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <connectionStrings>
    <add name ="Contexto" providerName="System.Data.SqlClient" connectionString="data source=(local); initial catalog=ExemploEF; user id=teste; password=teste;"/>
  </connectionStrings>
</configuration>
```

O nome da string de conexão é o mesmo nome da nossa classe de Contexto. O providerName indica que usamos SQL Server e a string de conexão é padrão de ADO.Net, informando Servidor/Banco de Dados/Usuário. Eu já fiz outro post falando só sobre Gerenciamento de Strings de Conexão.

Executando nosso código novamente o banco chamado EFExemplo será criado e preenchido com os dados.

Visualizando o modelo do CodeFirst:

Mas e se você quiser ver como está ficando seu modelo se você está usando somente código ? Para isto existe o Entity Framework PowerTools que permite visualizar o modelo a partir das classes e também gerar um script para o banco de dados. Vejamos como ver o modelo visual do nosso exempo.

Após instalar o PowerTools, clique com o botão direito do mouse sobre a classe Contexto.cs no seu projeto, irá aparecer um menu de contexto EntityFramework, com várias opções:

![](/wp-content/uploads/2012/01/image_thumb5_thumb1_thumb6.png)

A primeira opção é justamente a que mostra o modelo gráfico, vamos vê-lo então:

![](/wp-content/uploads/2012/01/image_thumb31_thumb6.png)

Já tenho um banco de dados e quero usar o CodeFirst:

Se você já tiver um banco de dados, o EF PowerTools permite que você faça engenharia reversa e gere o contexto e as classes, para isto clique com o botão direito do mouse em sua Solution no Visual Studio e escolhar Entity Framework no menu:

![](/wp-content/uploads/2012/01/image_thumb9_thumb1_thumb6.png)

Esta opção gera todas as classes e relacionamentos do seu modelo, basta informar qual o banco de dados e o servidor na janela abaixo:

![](/wp-content/uploads/2012/01/SNAGHTMLa560840_thumb1_thumb1_thumb6.png)

Não se esquece de adicionar o EntityFramework CodeFirst com o NuGet antes de fazer a engenharia reversa.

Quando usar Designer ou CodeFirst:

Esta é um pergunta bem complicada, eu diria que se você usa somente um banco de dados e precisa trabalhar com Stored Procedures é melhor usar o Designer, principalmenet porquê o CodeFirst ainda não suporta procedures nativamente.

Se você quer criar uma aplicação multibanco, de maneira mais rápida e simples através de classes POCO, então o CodeFirst é sua escolha.

Muito importante saber também que o Entity Framework Designer e o CodeFirst são independentes e podem não compartilhar alguns recursos.

Espero que o artigo seja útil para vocês e se assim desejarem façam seus comentários ou sugestões.

Até a próxima,

Carlos dos Santos.
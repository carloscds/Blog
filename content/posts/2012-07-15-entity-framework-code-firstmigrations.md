---
id: 753
title: Entity Framework Code First–Migrations
date: 2012-07-15T22:20:07-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2012/07/entity-framework-code-firstmigrations/
permalink: /2012/07/entity-framework-code-firstmigrations/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'c#; msdn; entity framework'
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
<a href="http://carloscds.net/wp-content/uploads/2012/07/image.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb13.png" alt="image" width="712" height="494" border="0" /></a>

Logo após criar o projeto, vamos adicionar o Entity Framework CodeFirst usando o NuGet. Para isto abra o gerenciador do NuGet em Tools/Library Package Manager/Packager Manager Console e digite:  
<a href="https://www.carloscds.net/wp-content/uploads/2012/07/image13.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb14.png" alt="image" width="712" height="107" border="0" /></a>

Após isto teremos o EF CodeFirst instalado em nosso projeto. Vamos agora criar um Contexto e uma classe para podermos trabalhar com o Migrations.

Esta será a nossa classe de Contexto:

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">class</span> Contexto : DbContext
    {
        <span class="kwrd">public</span> DbSet&lt;Cliente&gt; Cliente { get; set; }
    }</pre>

E esta será a nossa classe de Clientes:

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">class</span> Cliente
    {
        <span class="kwrd">public</span> <span class="kwrd">int</span> ID { get; set; }
        <span class="kwrd">public</span> <span class="kwrd">string</span> Nome { get; set; }
    }</pre>

Vamos também adicionar um arquivo app.config para identificarmos nosso servidor SQL e o nome do banco de dados:

<pre class="csharpcode">&lt;?xml version=<span class="str">"1.0"</span> encoding=<span class="str">"utf-8"</span>?&gt;
&lt;configuration&gt;
  &lt;connectionStrings&gt;
    &lt;add name=<span class="str">"Contexto"</span> providerName=<span class="str">"System.Data.SqlClient"</span> connectionString=<span class="str">"data source=(local); initial catalog=ExemploMigrations; integrated security=true;"</span>/&gt;       
  &lt;/connectionStrings&gt;
&lt;/configuration&gt;</pre>

Agora que já temos nossas classes e o arquivo de configuração, vamos adicionar o Migrations.

**<u>Migrations – Gerenciando cada atualização no banco de dados</u>**

Vamos inicialmente adicionar o Migrations ao nosso projeto. Independente do método: manual ou automático, precisamos adicioná-lo ao nosso projeto. Faremos isto usando novamente a janela do Nuget através do comando Enable-Migrations:  
<a href="https://www.carloscds.net/wp-content/uploads/2012/07/image22.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb22.png" alt="image" width="712" height="178" border="0" /></a>

Após este comando, uma nova classe será adicionada ao nosso projeto, o nome dela é Configurations:  
<a href="https://www.carloscds.net/wp-content/uploads/2012/07/image32.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb32.png" alt="image" width="712" height="240" border="0" /></a>

Como vamos trabalhar com o processo manual, vamos deixar esta classe como está e vamos iniciar com os comandos do Migrations, que devem ser executados na janela do NuGet:

Agora, para todas as alterações que fizermos nas classes executaremos basicamente dois comandos:  
**Add-Migrations  
Update-DataBase**

Add-Migrations “nome\_migrations” – cria um alteração no banco de dados, onde o “nome\_migrations” é o nome que você irá dar para a atualização;  
Update-DataBase – aplica as alterações no banco de dados;  
Update-DataBase – script – gera um script com os comandos SQL para serem executados no banco de dados.

Para nosso exemplo, iremos executar:  
**Add-Migrations “CriacaoBanco”  
Update-DataBase  
**  
Veja que ao executar o Add-Migrations, um novo arquivo foi adicionado ao projeto, contendo os comandos Migrations para o banco de dados:  
<a href="https://www.carloscds.net/wp-content/uploads/2012/07/image42.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb42.png" alt="image" width="417" height="350" border="0" /></a>

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">partial</span> <span class="kwrd">class</span> CriacaoBanco : DbMigration
    {
        <span class="kwrd">public</span> <span class="kwrd">override</span> <span class="kwrd">void</span> Up()
        {
            CreateTable(
                <span class="str">"Clientes"</span>,
                c =&gt; <span class="kwrd">new</span>
                    {
                        ID = c.Int(nullable: <span class="kwrd">false</span>, identity: <span class="kwrd">true</span>),
                        Nome = c.String(),
                    })
                .PrimaryKey(t =&gt; t.ID);
            
        }
        
        <span class="kwrd">public</span> <span class="kwrd">override</span> <span class="kwrd">void</span> Down()
        {
            DropTable(<span class="str">"Clientes"</span>);
        }
    }</pre>

Como nosso banco de dados ainda não existia, ele foi criado após o comando Update-DataBase:  
<a href="https://www.carloscds.net/wp-content/uploads/2012/07/image52.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb52.png" alt="image" width="712" height="237" border="0" /></a>

Para que nossos exemplo fiquem mais interessantes, vou adicionar alguns registros no banco de dados usando o código abaixo, mas se você preferir, insira os dados diretamente no SQL:

<pre class="csharpcode"><span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
        {
            var db = <span class="kwrd">new</span> Contexto();
            db.Cliente.Add(<span class="kwrd">new</span> Cliente() { Nome = <span class="str">"Carlos dos Santos"</span> });
            db.Cliente.Add(<span class="kwrd">new</span> Cliente() { Nome = <span class="str">"Jose da Silva"</span> });
            db.Cliente.Add(<span class="kwrd">new</span> Cliente() { Nome = <span class="str">"Antonio das Couves"</span> });
            db.SaveChanges();
        }</pre>

Agora vamos começar a modificar a nossa classe e ver como realmente o migrations pode nos ajudar. Inicialmente vamos adicionar um campo chamado Ativo na classe Cliente, e logo após vamos criar um novo Migration para enviar isto ao banco de dados:

Classe Cliente com o novo campo:

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">class</span> Cliente
    {
        <span class="kwrd">public</span> <span class="kwrd">int</span> ID { get; set; }
        <span class="kwrd">public</span> <span class="kwrd">string</span> Nome { get; set; }
        <span class="kwrd">public</span> <span class="kwrd">bool</span> Ativo { get; set; }
    }</pre>

Agora ao executar o comando Add-Migrations “Cliente_Ativo” teremos mais um arquivo do Migrations:

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">partial</span> <span class="kwrd">class</span> Cliente_Ativo : DbMigration
    {
        <span class="kwrd">public</span> <span class="kwrd">override</span> <span class="kwrd">void</span> Up()
        {
            AddColumn(<span class="str">"Clientes"</span>, <span class="str">"Ativo"</span>, c =&gt; c.Boolean(nullable: <span class="kwrd">false</span>));
        }
        
        <span class="kwrd">public</span> <span class="kwrd">override</span> <span class="kwrd">void</span> Down()
        {
            DropColumn(<span class="str">"Clientes"</span>, <span class="str">"Ativo"</span>);
        }
    }</pre>

Mas antes de enviar isto para o banco, vamos imaginar que você queira setar um valor para o campo Ativo, por exemplo, todos os campos Ativos deverão estar true. Você pode fazer isto através do comando Sql() dentro do arquivo do migrations, veja:

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">partial</span> <span class="kwrd">class</span> Cliente_Ativo : DbMigration
    {
        <span class="kwrd">public</span> <span class="kwrd">override</span> <span class="kwrd">void</span> Up()
        {
            AddColumn(<span class="str">"Clientes"</span>, <span class="str">"Ativo"</span>, c =&gt; c.Boolean(nullable: <span class="kwrd">false</span>));
            Sql(<span class="str">"update clientes set ativo = 1"</span>);
        }
        
        <span class="kwrd">public</span> <span class="kwrd">override</span> <span class="kwrd">void</span> Down()
        {
            DropColumn(<span class="str">"Clientes"</span>, <span class="str">"Ativo"</span>);
        }
    }</pre>

Obviamente você poderia ter definido isto como um valor default par o banco, mass o intuito aqui é lhe mostrar como é possível enviar comandos durante o processo do Migrations.

Agora vamos enviar o comando para o banco, mas de uma maneira um pouco diferente, vamos gerar um script SQL. Para isto execute o comando da seguinte maneira:

**Update-DataBase –script**

E o resultado será um arquivo de script SQL:

<pre class="csharpcode">ALTER TABLE [Clientes] ADD [Ativo] [bit] NOT NULL DEFAULT 0
update clientes set ativo = <span class="kwrd">1</span>
INSERT INTO [__MigrationHistory] ([MigrationId], [CreatedOn], [Model], [ProductVersion]) VALUES (<span class="str">'201207160033131_Cliente_Ativo'</span>, <span class="str">'2012-07-16T00:38:19.710Z'</span>, 0x1F8B0800000000000400CD56C96EDB3010BD17E83F083CB587988E0B0449202748ECB8085A3B4194E64E4B6387281755A40CFBDB7AE827F5173AD46E79C97AE84D2267797C7C33C3BFBFFFF8E74B29BC0524866BD527879D2EF140853AE26ADE27A99D1D1C93F3B38F1FFCAB482EBD87D2AEE7ECD053993E79B4363EA5D4848F2099E9481E26DAE899ED845A521669DAEB768FE9619702862018CBF3FCBB54592E21FBC1DF815621C4366562AC2310A658C79D208BEA4D980413B310FAE46A0932167ACCE709B308C610EF427086400210B317A2EA9E3854A4CA8719AF10995DDDAF62C8B2F6C9407050169A4668F60D566B0BB8749BE81812BBBA8359E17A3D241E5DF7A36DC7CAADE1E3B2E397B25F7AC49BA442B0A9C08519130688171F9D065627F01514200710DD326B21C16BB98E20435FB0701A1F3D8F8813DAED392228534ADB8CD60DE02D98132DA1041AD804E542BC115F42F41DD4DC3E5660C76C59AEE027F17E288EEA42279BA4D03C5CFEBF3FE985E50B5D66BDD45A00535B086A06F1697DA19BD78CC2B38C238DE55DE33F2CAD6E5D766E1C806D49C2AB63E7F2EB543BDB3054D96A7DD35CE06521D01D95E08F591C23C78DCA2856BC202F8BC141F072EDCB3C060DCD9612A8D0569950746C0EAD5D475A04239E183B64964D99BB814124B798EDE7B64CB3A7EAD6CAB3B477DFB9CF466BE8EC8852D337C2134934C90E0715969DF933DF206482255BEA76A0452AD5AEDADFE79D9753D33F5F797E84A2369A218AA5CD183E6D1DBFCD32DDA0B9D5C5DAB7B64FED6D932A7BA5FA96BAFD42694F0F830DE9E526C44372163C72B20B56C682EC38834EF04BE4F75A1B8C99E23330F65EFF0437D8B0325E3F50AA3E6A4C24FED3A9C2DDE99F9C1F7B7BEAFE69A0162C091F59F249B2E5E73775F829B7EFDCDDDB8DEACD6D3ED75B9F4453873AC7596C9A570F814DF9FBB4F962F28760F8BC0EE1DE4F0A42D7F2EAA0A5CDB59AE992643C5A135169D2BA8331581621431789E533165ADC0EC1986CC43F3091BA4E2BA7105DAB9BD4C6A9BD3006E454AC9AE7F5E9FEFCD9A45BC7ECDFC459D37E8F23204C8E47801B7599721155B8475B24B42384134B5121880A9F38186EBEAA224DB47A66A082BE21C4A05C7DDDBB2185C1CC8D0AD80276637B9AC375C6FC216738F96493C17CA5401230CCDC4881099A1E753EF7E0A7EEC57FF60FBDB90F33230C0000, <span class="str">'4.3.1'</span>)
</pre>

Basta executar este arquivo dentro do SQL que o campo será criado e atualizado, ou se preferir, execute novamente o Update-DataBase que isto será feito automaticamente.  
Este recurso do script pode ser util se você precisar atualizar também um ambiente e produção da sua aplicação.  
<a href="https://www.carloscds.net/wp-content/uploads/2012/07/image62.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb62.png" alt="image" width="425" height="264" border="0" /></a>

**<u>Obs: </u>**A tabela __MigrationHistory é usada pelo Migrations para gerenciar o histórico das versões dentro do banco de dados.

**<u>Voltando o banco de dados em um determinado ponto:</u>**

Um recurso bem interessante do Migrations é que você pode voltar o seu banco de dados a qualquer ponto em que tenha executado um Add-Migrations. Imagine então que nós criamos o campo ativo no banco e agora você queira voltar ao ponto onde este campo ainda não existia, para isto vamos executar o seguinte comando do Migrations:

**Update-DataBase –target “CriacaoBanco”**

Isto volta nosso banco de dados a este ponto, que nosso caso foi a criação do banco, mas poderia ser qualquer outro ponto. Lembrando que este comando afeta apenas o banco de dados e não a nossa classe.

Agora vamos ver como é executar o Migrations de forma totalmente automatica.

**<u>Migrations – Executando as atualizações automaticamente</u>**

Agora que você já sabe como manter seu banco de dados atualizados, gerando versões das atualizações, vamos imaginar que você não precisa manter este histórico, mas simplesmente manter o banco atualizado.

Para este exemplo, vamos criar um projeto com os mesmos dados do exemplo anterior, ou seja: crie um projeto do tipo console:  
<a href="https://www.carloscds.net/wp-content/uploads/2012/07/image72.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb72.png" alt="image" width="712" height="494" border="0" /></a>

Adicione o EF CodeFirst através do console do NuGet e depois adicione o contexto, a classe cliente e o arquivo app.config, mas neste arquivo iremos modificar o nome do bando de dados para ExemploMigrationsAutomatico:

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">class</span> Contexto : DbContext
    {
        <span class="kwrd">public</span> DbSet&lt;Cliente&gt; Cliente { get; set; }
    }</pre>

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">class</span> Cliente
    {
        <span class="kwrd">public</span> <span class="kwrd">int</span> ID { get; set; }
        <span class="kwrd">public</span> <span class="kwrd">string</span> Nome { get; set; }
    }</pre>

<pre class="csharpcode">&lt;?xml version=<span class="str">"1.0"</span> encoding=<span class="str">"utf-8"</span>?&gt;
&lt;configuration&gt;
  &lt;connectionStrings&gt;
    &lt;add name=<span class="str">"Contexto"</span> providerName=<span class="str">"System.Data.SqlClient"</span> connectionString=<span class="str">"data source=(local); initial catalog=ExemploMigrationsAutomatico; integrated security=true;"</span>/&gt;
  &lt;/connectionStrings&gt;
&lt;/configuration&gt;</pre>

Feito isto vamos adicionar o migrations, da mesma forma que antes, mas agora modificando os parâmetros necessários para que tudo fique automático, então abra o console do NuGet e execute o comando Enable-Migrations:  
<a href="https://www.carloscds.net/wp-content/uploads/2012/07/image82.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb82.png" alt="image" width="712" height="178" border="0" /></a>

Agora que começam as diferenças. No exemplo anterior não modificamos nada na classe configurations, mas neste caso iremos fazer alguns ajustes:  
<a href="https://www.carloscds.net/wp-content/uploads/2012/07/image92.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb92.png" alt="image" width="712" height="163" border="0" /></a>

Primeiro vamos mudar a classe para “public class”, pois precisaremos refenciá-lá posteriormente. Depois vamos ativar a propriedade da migração automatica e por fim vamos marcar a opção que dados podem ser perdidos durante a migração. Esta última opção fica a seu critério, pois se você não habilitar a opção e o Migrations não conseguir atualizar o banco de dados. você receberá um erro.

E agora vamos modificar o construtor do contexto para ele chamar o DatabaseInitializer, que é quem faz todo o processo acontecer:

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">class</span> Contexto : DbContext
    {
        <span class="kwrd">public</span> DbSet&lt;Cliente&gt; Cliente { get; set; }

        <span class="kwrd">public</span> Contexto()
        {
            Database.SetInitializer(<span class="kwrd">new</span> MigrateDatabaseToLatestVersion&lt;Contexto, Configuration&gt;());
        }
    }</pre>

O que fizemos foi adicionar a chamada do DatabaseSetInitializer() com a opção MigrateDatabaseToLastVersion, o que faz com que nosso banco de dados seja sempre atualizado de acordo com as nossas classes.

Agora é só executar o exemplo abaixo para criarmos o banco de dados:

<pre class="csharpcode"><span class="kwrd">static</span> <span class="kwrd">void</span> Main(<span class="kwrd">string</span>[] args)
        {
            var db = <span class="kwrd">new</span> Contexto();
            db.Cliente.Add(<span class="kwrd">new</span> Cliente() { Nome = <span class="str">"Carlos dos Santos"</span> });
            db.Cliente.Add(<span class="kwrd">new</span> Cliente() { Nome = <span class="str">"Jose da Silva"</span> });
            db.Cliente.Add(<span class="kwrd">new</span> Cliente() { Nome = <span class="str">"Antonio das Couves"</span> });
            db.SaveChanges();
        }</pre>

Agora vamos modificar a classe cliente e simplesmente executar o programa novamente:

<pre class="csharpcode"><span class="kwrd">public</span> <span class="kwrd">class</span> Cliente
    {
        <span class="kwrd">public</span> <span class="kwrd">int</span> ID { get; set; }
        <span class="kwrd">public</span> <span class="kwrd">string</span> Nome { get; set; }
        <span class="kwrd">public</span> <span class="kwrd">string</span> CPF { get; set; }
        <span class="kwrd">public</span> <span class="kwrd">decimal</span> Limite { get; set; }
    }
</pre>

Após executar o programa e fazer uma consulta no SQL:  
<a href="https://www.carloscds.net/wp-content/uploads/2012/07/image102.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" src="https://www.carloscds.net/wp-content/uploads/2012/07/image_thumb102.png" alt="image" width="519" height="337" border="0" /></a>

Conclusão:

O recurso de Migrations sem dúvida é algo realmente fantástico no Entity Framework CodeFirst e certament ajuda na produtividade do nosso dia a dia. Escolha o que melhor lhe atender e começe a usar agora mesmo.

Abraços e até a próxima.  
Carlos dos Santos.
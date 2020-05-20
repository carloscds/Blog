---
id: 789
title: Entity Framework 6–Gerando Log dos comandos SQL
date: 2013-09-02T21:31:15-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2013/09/entity-framework-6gerando-log-dos-comandos-sql/
permalink: /2013/09/entity-framework-6gerando-log-dos-comandos-sql/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'msdn;c#;ef codefirst'
---
Olá,

O Entity Framework 6 RC já foi lançado! Agora é a hora de começar a trabalhar na migraçãoda versão 5 para a 6 e ver as novas funcionalidades. As especificações sobre as novas funcionalidades podem ser encontradas [aqui](https://docs.microsoft.com/en-us/ef/ef6/what-is-new/past-releases).

Dentre as muitas novidades, que vamos explorar nos post seguintes, hoje vou destacar uma que acho bem interessante: o log dos comandos enviados ao banco de dados.

Um ORM (Object-Relational Mapping), ou simplesmente um Mapeamento Objeto-Relacional traduz comandos de uma linguagem de programação, no nosso caso C# e LINQ, para comandos de banco de dados. A eficiência do ORM está diretamente relacionada a como os comandos para o banco de dados são gerados, ou seja, pegar os comandos escritos em C# e convertê-los em comandos SQL.

Na versão 6 do Entity Framework foi introduzido um novo objeto que nos permite interceptar os comandos que estão sendo enviados para o banco de dados e assim podemos ver o que acontece “por baixo dos panos”. Isto também podem ser feito colocando uma ferramenta de profiler de banco de dados. No caso do Microsoft SQL Server esta ferramenta é o SQL Server Profiler, mas existem vários outros.

No caso do nosso exemplo, vamos executar um método para cada operação em LINQ que será executada no Entity Framework, e para iniciarmos o nosso exemplo, vamos criar um projeto do tipo Console Application usando o .Net 4.5 (o uso do .Net 4.5 é importante para suportar todas as funcionalidades do Entity Framework 6).

Criando um novo projeto do tipo Console Application:

<a href="https://www.carloscds.net/wp-content/uploads/2013/09/SNAGHTML476eb6022.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTML476eb602" src="https://www.carloscds.net/wp-content/uploads/2013/09/SNAGHTML476eb602_thumb2.png" alt="SNAGHTML476eb602" width="532" height="369" border="0" /></a>

Criado o nosso projeto, vamos adicionar o Entity Framework através da janela do  Nuget, que está em Tools/Library Packager Manager/Packager Manger Console e dentro dele iremos executar o comando abaixo:

PM> Install-Package EntityFramework –Pre

Veja que a opção “-Pre” é quem irá instalar o Entity Framework 6 RC, visto que ele ainda não foi liberado oficialmente e ainda é um release candidate.

Agora vamos criar um contexto bem simples com uma classe Cliente. Para isto adicione uma nova classe e chame-a de Contexto, como no exemplo abaixo:

<div id="codeSnippetWrapper" style="overflow: auto; cursor: text; font-size: 8pt; height: 96px; font-family: 'Courier New', courier, monospace; width: 84.19%; direction: ltr; text-align: left; margin: 20px 0px 10px; line-height: 12pt; max-height: 200px; background-color: #f4f4f4; border: silver 1px solid; padding: 4px;">
  <div id="codeSnippet" style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;">
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">class</span> Contexto : DbContext</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span> {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>     <span style="color: #0000ff;">public</span> DbSet&lt;Cliente&gt; Cliente {get; set;}</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span> }</pre>
    
    <p>
      <!--CRLF-->
    </p>
  </div>
</div>

Agora vamos adicionar a classe Cliente:

<div id="codeSnippetWrapper" style="overflow: auto; cursor: text; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 97.5%; direction: ltr; text-align: left; margin: 20px 0px 10px; line-height: 12pt; max-height: 200px; background-color: #f4f4f4; border: silver 1px solid; padding: 4px;">
  <div id="codeSnippet" style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;">
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">class</span> Cliente</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span>     {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">int</span> ID { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">string</span> Nome { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span>     }</pre>
    
    <p>
      <!--CRLF-->
    </p>
  </div>
</div>

E por fim vamos modificar o arquivo App.Config para direcionarmos o local e o nome do banco de dados a ser criado: (isto é somente um exemplo e o seu arquivo poderá ficar diferente)

<div id="codeSnippetWrapper" style="overflow: auto; cursor: text; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 97.5%; direction: ltr; text-align: left; margin: 20px 0px 10px; line-height: 12pt; max-height: 200px; background-color: #f4f4f4; border: silver 1px solid; padding: 4px;">
  <div id="codeSnippet" style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;">
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> &lt;?xml version=<span style="color: #006080;">"1.0"</span> encoding=<span style="color: #006080;">"utf-8"</span>?&gt;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span> &lt;configuration&gt;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>   &lt;connectionStrings&gt;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>     &lt;add name=<span style="color: #006080;">"Contexto"</span> connectionString=<span style="color: #006080;">"data source=(local); initial catalog=EFLog; integrated security=true;"</span> providerName=<span style="color: #006080;">"System.Data.SqlClient"</span>/&gt;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span>   &lt;/connectionStrings&gt;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum6" style="color: #606060;">   6:</span> &lt;/configuration&gt;</pre>
    
    <p>
      <!--CRLF-->
    </p>
  </div>
</div>

Agora vamos ao que interessa, ou seja, vamos adicionar o LOG do SQL. Para isto, no Program.cs vamos inserir os seguintes comandos:

<div id="codeSnippetWrapper" style="overflow: auto; cursor: text; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 97.5%; direction: ltr; text-align: left; margin: 20px 0px 10px; line-height: 12pt; max-height: 200px; background-color: #f4f4f4; border: silver 1px solid; padding: 4px;">
  <div id="codeSnippet" style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;">
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> <span style="color: #0000ff;">class</span> Program</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span>     {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>         <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">void</span> Main(<span style="color: #0000ff;">string</span>[] args)</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>         {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span>             var db = <span style="color: #0000ff;">new</span> Contexto();</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum6" style="color: #606060;">   6:</span>             db.Database.Log = GravaLog;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum7" style="color: #606060;">   7:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum8" style="color: #606060;">   8:</span>             var cli = <span style="color: #0000ff;">new</span> Cliente() { Nome = <span style="color: #006080;">"Carlos"</span> };</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum9" style="color: #606060;">   9:</span>             db.Cliente.Add(cli);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum10" style="color: #606060;">  10:</span>             db.SaveChanges();</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum11" style="color: #606060;">  11:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum12" style="color: #606060;">  12:</span>             var consulta = from c <span style="color: #0000ff;">in</span> db.Cliente</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum13" style="color: #606060;">  13:</span>                            select c;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum14" style="color: #606060;">  14:</span>             <span style="color: #0000ff;">foreach</span>(var c <span style="color: #0000ff;">in</span> consulta)</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum15" style="color: #606060;">  15:</span>             {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum16" style="color: #606060;">  16:</span>                 Console.WriteLine(c.Nome);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum17" style="color: #606060;">  17:</span>             }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum18" style="color: #606060;">  18:</span>         }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum19" style="color: #606060;">  19:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum20" style="color: #606060;">  20:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">void</span> GravaLog(<span style="color: #0000ff;">string</span> sql)</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum21" style="color: #606060;">  21:</span>         {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum22" style="color: #606060;">  22:</span>             Console.WriteLine(<span style="color: #006080;">"Comando SQL: "</span>+sql);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum23" style="color: #606060;">  23:</span>         }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum24" style="color: #606060;">  24:</span>     }</pre>
    
    <p>
      <!--CRLF-->
    </p>
  </div>
</div>

O método GravaLog() é atrbuído a propriedade Log do DataBase do Contexto, sendo assim, todos os comandos enviados para o banco de dados são também enviados para este método e dentro dele simplesmente chamamos o método Console.WriteLine() para mostrar os comandos na tela.

Ao executar o programa, você verá algo como a imagem abaixo:

<a href="https://www.carloscds.net/wp-content/uploads/2013/09/SNAGHTML47817c482.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTML47817c48" src="https://www.carloscds.net/wp-content/uploads/2013/09/SNAGHTML47817c48_thumb2.png" alt="SNAGHTML47817c48" width="676" height="443" border="0" /></a>

Esta é uma implementação bastante simples da implementação do Log de comandos disponível agora na versão 6, mas com certeza você poderá utilizar de uma maneira bem mais elaborada em seus projetos.

Abraços e até a próxima,  
Carlos dos Santos.
---
id: 473
title: Trabalhando com Entity Framework Designer
date: 2012-01-07T16:21:11-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2012/01/trabalhando-com-entity-framework-designer/
permalink: /2012/01/trabalhando-com-entity-framework-designer/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'c#; msdn; #ef'
---
Olá pessoal,

Hoje em um desenvolvimento de projeto é muito comum  o programador ter que saber vários comando de bancos de dados (Insert, Delete, Update, Select) para poder desenvolver, além de saber sobre a linguagem de progração. O EntityFramework vem para ajudar nesta tarefa, criando uma correspondência entre as tabelas do banco de dados, o que chamamos de ORM, ou mapeamento Objeto-Relacional.

Existem, basicamente, duas maneiras de se trabalhar com o Entity Framework, usando o Entity Designer ou o Entity Framework Code First. A diferença é simples, no Designer você precisa criar um diagrama do banco de dados visualmente, usando um arquivo EDMX, que deve ser específico para cada banco de dados da sua aplicação, ou seja, para cada banco de dados é necessário usar um arquivo EDMX. Neste artigo vamos vamos criar um modelo visual e analisar seus aspectos.

**<u>Mapeando o Banco de dados com o Entity Designer:</u>**

Abra o Visual Studio 2010 e crie um projeto no .Net Framework 4 do tipo Console Application, depois vá em adcionar novo item. Você verá a janela abaixo, escolha ADO.Net Entity Data Model:

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="SNAGHTML9dffcc9" src="http://carloscds.net/wp-content/uploads/2012/01/SNAGHTML9dffcc9_thumb.png" alt="SNAGHTML9dffcc9" width="646" height="395" border="0" />](http://carloscds.net/wp-content/uploads/2012/01/SNAGHTML9dffcc9.png)

Podemos ainda escolher se iremos nosso modelo a partir de um banco de dados pronto ou em branco:

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb.png" alt="image" width="383" height="192" border="0" />](http://carloscds.net/wp-content/uploads/2012/01/image.png)

Vamos gerar nosso exemplo a partir do banco de dados <a href="https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs" target="_blank" rel="noopener noreferrer">NorthWind</a>, escolhendo a opção “Generate from database”. Na tela seguinte crie a conexão para o banco de dados e depois escolha quais tabelas, views ou stored procedures você quer mapear:

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="SNAGHTML9e3d339" src="http://carloscds.net/wp-content/uploads/2012/01/SNAGHTML9e3d339_thumb.png" alt="SNAGHTML9e3d339" width="629" height="561" border="0" />](http://carloscds.net/wp-content/uploads/2012/01/SNAGHTML9e3d339.png)

No nosso exemplo ou escolher todas as tabelas, views e stored procedures. Feito isto teremos o modelo visual pronto:

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb1.png" alt="image" width="672" height="561" border="0" />](http://carloscds.net/wp-content/uploads/2012/01/image1.png)

Este processo gerou um modelo EDMX, que contém basicamente três partes:

1. **<u>Storage Model Content</u>**: que contém as informações do banco de dados, como tabelas, tipos dos dados, etc;  
2. **<u>Conceptual Model Content</u>**: contém a definição do modelo, o que você pode ver no diagrama, como as classes, tipos complexos, associações, etc.  
3. **<u>Mapping Content</u>**: faz a ligação entre o Storage e o modelo Conceitual.

O código fonte das classes também faz parte do modelo,dentro do arquivo de Designer:

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb2.png" alt="image" width="419" height="298" border="0" />](http://carloscds.net/wp-content/uploads/2012/01/image2.png)

Este arquivo contém o código fonte de todas as classes de nosso modelo. Mas então se eu criar um modelo novo as classes serão geradas novamente ? A resposta é SIM.

Opa, mas então temos um problema, teremos classes duplicadas e como vamos resolver isto ? Com classes POCO, que podem ser independentes do modelo. Para isto faremos algumas pequenas modificações no nosso modelo.

<u>Se você for utilizar somente um banco de dados não precisa trabalhar com classes POCO.</u>

**<u>Trabalhando com POCO no Entity Designer:</u>**

A primeira coisa que precisamos fazer é desativar a geração de código pelo designer. Isto é simples, basta desligarmos a propriedade Code Generation Strategy do modelo, colocando em none:

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb3.png" alt="image" width="414" height="687" border="0" />](http://carloscds.net/wp-content/uploads/2012/01/image3.png)

Agora precisamos adicionar novamente as classes e para isto iremos utilizar um gerador automático de código, que iremos adicionar ao nosso projeto:

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="SNAGHTML9f0e092" src="http://carloscds.net/wp-content/uploads/2012/01/SNAGHTML9f0e092_thumb.png" alt="SNAGHTML9f0e092" width="579" height="354" border="0" />](http://carloscds.net/wp-content/uploads/2012/01/SNAGHTML9f0e092.png)

Ao adicionarmos o ADO.Net POCO Entity Generator, dois novos arquivos irão aparecer em nosso projeto: Model1.Context.tt e Model1.tt. Para gerar as classes precisamos abrir cada um deles e colocar o nome do nosso arquivo EDMX, Veja o exemplo:

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb4.png" alt="image" width="622" height="406" border="0" />](http://carloscds.net/wp-content/uploads/2012/01/image4.png)

No nosso exemplo ficará assim: string inputFile = @”model1.edmx”. Faça o mesmo no arquivo Model1.tt. Depois de fazer isto salve o arquivo e o nosso projeto ficará assim:

[<img style="background-image: none; padding-left: 0px; padding-right: 0px; display: inline; padding-top: 0px; border: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb5.png" alt="image" width="388" height="697" border="0" />](http://carloscds.net/wp-content/uploads/2012/01/image5.png)

Agora temos classes POCO, que são independentes do designer. Se você modificar o designer, assim que salvá-lo as classes serão atualizadas automaticamente.

Agora você pode adicionar um novo EDMX apontando para um outro banco de dados, por exemplo: MySQL ou Oracle, desde que tenham a mesma estrutura logicamente, e você usará as mesmas classes.

**<u>Usando o modelo para recuperar os dados:</u>**

Vamos agora criar um pequeno código para listar os Products e Categories do nosso modelo, usando LINQ:

<div id="codeSnippetWrapper" style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 20px 0px 10px; width: 104.91%; font-family: 'Courier New', courier, monospace; direction: ltr; height: 208px; max-height: 200px; font-size: 8pt; overflow: auto; cursor: text; border: silver 1px solid; padding: 4px;">
  <div id="codeSnippet" style="text-align: left; line-height: 12pt; background-color: #f4f4f4; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;">
    <pre style="text-align: left; line-height: 12pt; background-color: white; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> var db = <span style="color: #0000ff;">new</span> NorthwindEntities();</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align: left; line-height: 12pt; background-color: white; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>             var dados = from p <span style="color: #0000ff;">in</span> db.Products</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>                         select p;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align: left; line-height: 12pt; background-color: white; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum6" style="color: #606060;">   6:</span>             <span style="color: #0000ff;">foreach</span> (var linha <span style="color: #0000ff;">in</span> dados)</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align: left; line-height: 12pt; background-color: white; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum7" style="color: #606060;">   7:</span>             {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align: left; line-height: 12pt; background-color: #f4f4f4; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum8" style="color: #606060;">   8:</span>                 Console.WriteLine(<span style="color: #006080;">"{0,-35} - {1}"</span>, linha.ProductName, linha.Categories.CategoryName);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="text-align: left; line-height: 12pt; background-color: white; margin: 0em; width: 100%; font-family: 'Courier New', courier, monospace; direction: ltr; color: black; font-size: 8pt; overflow: visible; border-style: none; padding: 0px;"><span id="lnum9" style="color: #606060;">   9:</span>             }</pre>
    
    <p>
      <!--CRLF-->
    </p>
  </div>
</div>

No próximo artigo iremos falar sobre o Entity Framework Code First.

Espero que tenham gostado.

Até a próxima.

Carlos dos Santos.
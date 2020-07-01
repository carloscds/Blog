---
id: 473
title: Trabalhando com Entity Framework Designer
date: 2012-01-07T16:21:11-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2012/01/trabalhando-com-entity-framework-designer/
permalink: /2012/01/trabalhando-com-entity-framework-designer/
categories:
  - C Sharp
  - Entity Framework
tags:
  
---
Olá pessoal,

Hoje em um desenvolvimento de projeto é muito comum  o programador ter que saber vários comando de bancos de dados (Insert, Delete, Update, Select) para poder desenvolver, além de saber sobre a linguagem de progração. O EntityFramework vem para ajudar nesta tarefa, criando uma correspondência entre as tabelas do banco de dados, o que chamamos de ORM, ou mapeamento Objeto-Relacional.

Existem, basicamente, duas maneiras de se trabalhar com o Entity Framework, usando o Entity Designer ou o Entity Framework Code First. A diferença é simples, no Designer você precisa criar um diagrama do banco de dados visualmente, usando um arquivo EDMX, que deve ser específico para cada banco de dados da sua aplicação, ou seja, para cada banco de dados é necessário usar um arquivo EDMX. Neste artigo vamos vamos criar um modelo visual e analisar seus aspectos.

**<u>Mapeando o Banco de dados com o Entity Designer:</u>**

Abra o Visual Studio 2010 e crie um projeto no .Net Framework 4 do tipo Console Application, depois vá em adcionar novo item. Você verá a janela abaixo, escolha ADO.Net Entity Data Model:

![]( wp-content/uploads/2012/01/SNAGHTML9dffcc9.png)

Podemos ainda escolher se iremos nosso modelo a partir de um banco de dados pronto ou em branco:

![]( wp-content/uploads/2012/01/image.png)

Vamos gerar nosso exemplo a partir do banco de dados [Northwind](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs), escolhendo a opção “Generate from database”. Na tela seguinte crie a conexão para o banco de dados e depois escolha quais tabelas, views ou stored procedures você quer mapear:

![]( wp-content/uploads/2012/01/SNAGHTML9e3d339.png)

No nosso exemplo ou escolher todas as tabelas, views e stored procedures. Feito isto teremos o modelo visual pronto:

![]( wp-content/uploads/2012/01/image1.png)

Este processo gerou um modelo EDMX, que contém basicamente três partes:

1. **<u>Storage Model Content</u>**: que contém as informações do banco de dados, como tabelas, tipos dos dados, etc;  
2. **<u>Conceptual Model Content</u>**: contém a definição do modelo, o que você pode ver no diagrama, como as classes, tipos complexos, associações, etc.  
3. **<u>Mapping Content</u>**: faz a ligação entre o Storage e o modelo Conceitual.

O código fonte das classes também faz parte do modelo,dentro do arquivo de Designer:

![]( wp-content/uploads/2012/01/image2.png)

Este arquivo contém o código fonte de todas as classes de nosso modelo. Mas então se eu criar um modelo novo as classes serão geradas novamente ? A resposta é SIM.

Opa, mas então temos um problema, teremos classes duplicadas e como vamos resolver isto ? Com classes POCO, que podem ser independentes do modelo. Para isto faremos algumas pequenas modificações no nosso modelo.

<u>Se você for utilizar somente um banco de dados não precisa trabalhar com classes POCO.</u>

**<u>Trabalhando com POCO no Entity Designer:</u>**

A primeira coisa que precisamos fazer é desativar a geração de código pelo designer. Isto é simples, basta desligarmos a propriedade Code Generation Strategy do modelo, colocando em none:

![]( wp-content/uploads/2012/01/image3.png)

Agora precisamos adicionar novamente as classes e para isto iremos utilizar um gerador automático de código, que iremos adicionar ao nosso projeto:

![]( wp-content/uploads/2012/01/SNAGHTML9f0e092.png)

Ao adicionarmos o ADO.Net POCO Entity Generator, dois novos arquivos irão aparecer em nosso projeto: Model1.Context.tt e Model1.tt. Para gerar as classes precisamos abrir cada um deles e colocar o nome do nosso arquivo EDMX, Veja o exemplo:

![]( wp-content/uploads/2012/01/image4.png)

No nosso exemplo ficará assim: string inputFile = @”model1.edmx”. Faça o mesmo no arquivo Model1.tt. Depois de fazer isto salve o arquivo e o nosso projeto ficará assim:

![]( wp-content/uploads/2012/01/image5.png)

Agora temos classes POCO, que são independentes do designer. Se você modificar o designer, assim que salvá-lo as classes serão atualizadas automaticamente.

Agora você pode adicionar um novo EDMX apontando para um outro banco de dados, por exemplo: MySQL ou Oracle, desde que tenham a mesma estrutura logicamente, e você usará as mesmas classes.

**<u>Usando o modelo para recuperar os dados:</u>**

Vamos agora criar um pequeno código para listar os Products e Categories do nosso modelo, usando LINQ:

```csharp
var db = new NorthwindEntities();

var dados = from p in db.Products
            select p;

foreach (var linha in dados)             {
{
      Console.WriteLine("{0,-35} - {1}", linha.ProductName, linha.Categories.CategoryName);
}
```

No próximo artigo iremos falar sobre o Entity Framework Code First.

Espero que tenham gostado.

Até a próxima.
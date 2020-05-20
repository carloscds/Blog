---
id: 5181
title: 'EntityFramework&ndash;Apoveitando seu Banco de Dados com PowerTools'
date: 2014-04-21T19:34:06-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=5181
permalink: /2014/04/entityframeworkapoveitando-seu-banco-de-dados-com-powertools/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'msdn;c#;ef codefirst; ef'
---
Olá pessoal,

Quando uma empresa resolve adotar uma ferramenta de ORM (Mapeamento Objeto Relacional &#8211; no nosso caso o EntityFramework),&#160; começa uma grande quebra de paradigma, pois você vai deixar de acessar o banco de dados diretamente (Select, Insert, Update, Delete, etc) e vai passar a trabalhar somente com classes e objetos. Isto torna o desenvolvimento muito mais fácil e produtivo, uma vez que você não precisa ficar se preocupando com os comandos que vão para o banco de dados, já que isto é trabalho do ORM. 

Mas e quando você já tem um banco de dados pronto ? Isto sempre gera outra discussão, afinal você pode construir um novo banco, aproveitar o processo e melhorar tudo ou reaproveitar a estrutura do banco existente e incluir somente o ORM ? Quer ouvir outra coisa muito comum: você está criando uma nova funcionalidade ou novo projeto, e resolve utilizar o EntityFramework, mas precisa ler e gravar dados do banco atual. Como fazer ? Escrever as classes POCO na mão ? Obviamente que não, pois para isto existem diversas ferramentas que podem fazer isto para você e uma delas que vamos apresentar hoje é o EntityFramework PowerTools.

Para iniciarmos você precisa baixar o PowerTools através do gerenciamento de extensões do Visual Studio (Tools/Extensions and Updates), e depois procurar pelo Entity Framework Power Tools, conforme a figura abaixo:

[<img title="SNAGHTML4333684" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="SNAGHTML4333684" src="http://carloscds.net/wp-content/uploads/2014/04/SNAGHTML4333684_thumb.png" width="718" height="412" />](http://carloscds.net/wp-content/uploads/2014/04/SNAGHTML4333684.png)

No meu caso já está instalado, mas caso o seu ainda não esteja, clique no botão “Install” e pronto! Agora vamos criar um projeto para explorar os recursos.

Vamos iniciar criando um projeto Console e adicionando o EntityFramework através do NuGet:

[<img title="SNAGHTML434d0ea" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="SNAGHTML434d0ea" src="http://carloscds.net/wp-content/uploads/2014/04/SNAGHTML434d0ea_thumb.png" width="716" height="410" />](http://carloscds.net/wp-content/uploads/2014/04/SNAGHTML434d0ea.png)

Agora vamos adicionar o EF:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb8.png" width="728" height="182" />](http://carloscds.net/wp-content/uploads/2014/04/image8.png)

Agora que já temos o EntityFramework, vamos verificar no menu da nossa Solution um novo item chamado Entity Framework (para ver este menu, clique com o botão direito sobre o nome do seu projeto):

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb9.png" width="744" height="143" />](http://carloscds.net/wp-content/uploads/2014/04/image9.png)

Veja que temos duas opções:

  * Reverse Engineer Code First: permite ler um banco de dados existente e gerar as classes e o contexto;
  * Customize Reverse Engineer Templates: permite mudar o formado de geração das classes através de um arquivo T4

Se você escolher customizar os templates, terá os seguintes arquivos adicionados ao projeto, que poderão ser modificados de acordo com sua necessidade:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb10.png" width="442" height="181" />](http://carloscds.net/wp-content/uploads/2014/04/image10.png)

Escolhendo gerar as classes com a opção “Reverse Engineer Code First” você terá uma tela para colocar os dados de acesso ao seu banco de dados, faça isto e depois clique em OK para iniciar a geração das classes:

[<img title="SNAGHTML43ed31c" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="SNAGHTML43ed31c" src="http://carloscds.net/wp-content/uploads/2014/04/SNAGHTML43ed31c_thumb.png" width="372" height="574" />](http://carloscds.net/wp-content/uploads/2014/04/SNAGHTML43ed31c.png)

Agora já temos todo o banco de dados mapeado, e na versão atual do Entity Framework, isto inclui as tabelas e as views. Veja uma parte destas classes na nossa solution:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb11.png" width="312" height="556" />](http://carloscds.net/wp-content/uploads/2014/04/image11.png)

A engenharia reversa faz todo o mapeamento de atributos utilizando FluentAPI e a pasta “Mapping” contém estes mapeamentos.

Agora vamos clicar com o botão direito do mouse em cima do nosso contexto: NorthwindContext.cs:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb12.png" width="633" height="125" />](http://carloscds.net/wp-content/uploads/2014/04/image12.png)

Veja que agora temos outras opções, que são relativas ao banco que foi mapeado. Como estamos trabalhando com CodeFirst, não temos um diagrama visual do nosso banco de dados, mas com a ajuda do PowerTools, clicando na primeira opção: “View Entity Data Model (Read-only), você pode visualizar graficamente como está seu banco de dados, veja abaixo:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb13.png" width="605" height="460" />](http://carloscds.net/wp-content/uploads/2014/04/image13.png)

Veja que todos os relacionamentos foram criados e estão gerados através do FluentAPI no arquivo de mapeamento. Repare que no menu está escrito “Read-only” e isto quer dizer que este diagrama serve apenas para leitura, então não adianta escrever nada nele que não será refletido nas entidades. 

É possível também gerarmos um arquivo XML, que se assemelha ao arquivo EDMX (Model First e DataBase First). Existe também uma opção para gerarmos um script DDL, que pode ser executado no servidor de banco de dados para a criação do mesmo. No caso do EntityFramework CodeFirst existe o Migrations que elimina este trabalho de criação e atualização do banco de dados. Veja este post [aqui](http://carloscds.net/2012/07/entity-framework-code-firstmigrations/).

Por fim temos uma opção bem interessante: “Generate Views” que gera consultas optimizadas para o banco de dados e ajuda a melhorar a performance da nossa aplicação. Lembrando que se você optar por utilizar as Views, deverá gerá-las sempre que modificar suas classes.

Espero ter esclarecido o uso da ferramenta Entity Framework PowerTools e que este artigo seja muito útil para você!

Um grande abraço e até a próxima.  
Carlos dos Santos.
---
id: 9893
title: SQL Operations Studio
date: 2017-11-19T21:00:06-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=9893
permalink: /2017/11/sql-operations-studio/
image: /wp-content/uploads/2017/11/SQLOperationsStudio2-175x131.png
categories:
  - SQL
  - Visual Studio Code
tags:
  - tools
---
Olá pessoal,

Esta foi uma semana de muitas novidades para a comunidade de desenvolvedores. Aconteceu nos Estados Unidos o evento Connect, e um dos destaques foi a nova ferramenta de gerenciamento do SQL Server, baseado no Visual Studio Code.

A Microsoft tem investido muito nesta ferramenta, principalmente por ser multi plataforma, e a comunidade também tem escrito muitos plugins para o VS Code, o que possibilita desenvolver praticamente qualquer tipo de aplicação nele hoje, de Web a Arduino, tudo é possível.

E não poderia faltar também um ambiente para gerenciamento do banco de dados, surge então o SQL Operations Studio, que inicialmente não está integrado ao VS Code, mas certamente em breve estará.

Vamos então dar uma olhada nele!

Primeiro você precisa baixar os arquivos [neste link](https://docs.microsoft.com/en-us/sql/sql-operations-studio/download). E depois simplesmente descompactar o conteúdo em uma pasta, por exemplo: C:\SQLOperationsStudio. Lembrando que a ferramenta é multi plataforma, então podemos instalar também no MAC e no Linux.













Depois de descompactado, basta clicar no arquivo sqlops.exe:

[<img width="578" height="210" title="image" style="display: inline; background-image: none;" alt="image" src="http://carloscds.net/wp-content/uploads/2017/11/image_thumb.png" border="0" />](http://carloscds.net/wp-content/uploads/2017/11/image.png)





Pronto, já temos a ferramenta e agora vamos explorar alguns recursos!

Vejam que mesmo não estando dentro do VS Code, é praticamente a mesma interface, incluindo a integração com o Git!

[<img width="613" height="463" title="image" style="display: inline; background-image: none;" alt="image" src="http://carloscds.net/wp-content/uploads/2017/11/image_thumb-1.png" border="0" />](http://carloscds.net/wp-content/uploads/2017/11/image-1.png)













Ah sim, você pode/deve, gerenciar as mudanças no seu banco de dados, como se fosse o código fonte da sua aplicação, mesmo porque, o script do BD não deixa de ser também um código da aplicação.

Eu achei a ferramenta muito ‘clean’, bem simples de usar, e após colocar a conexão com o seu BD, você já tem várias informações na tela:

[<img width="630" height="476" title="image" style="display: inline; background-image: none;" alt="image" src="http://carloscds.net/wp-content/uploads/2017/11/image_thumb-2.png" border="0" />](http://carloscds.net/wp-content/uploads/2017/11/image-2.png)

A partir daí é só trabalhar com o banco. Veja uma que uma simples query já traz algumas facilidades diretamente na IDE:

[<img width="619" height="548" title="image" style="display: inline; background-image: none;" alt="image" src="http://carloscds.net/wp-content/uploads/2017/11/image_thumb-3.png" border="0" />](http://carloscds.net/wp-content/uploads/2017/11/image-3.png)

Veja por exemplo o conjunto de botôes destacados na imagem, com eles você já pode exportar os dados da consulta para CSV, Json e Excel, ou até mesmo montar um gráfico.

Aqui eu exportei para Json:

[<img width="602" height="425" title="image" style="display: inline; background-image: none;" alt="image" src="http://carloscds.net/wp-content/uploads/2017/11/image_thumb-4.png" border="0" />](http://carloscds.net/wp-content/uploads/2017/11/image-4.png)

Além de poder salvar todas as consultar e scripts em um repositório Git:

[<img width="495" height="495" title="image" style="display: inline; background-image: none;" alt="image" src="http://carloscds.net/wp-content/uploads/2017/11/image_thumb-5.png" border="0" />](http://carloscds.net/wp-content/uploads/2017/11/image-5.png)

A conclusão é que teremos uma excelente ferramenta de gerenciamento do SQL.

Estou aguardando ansiosamente a evolução desta ferramenta, que podemos considerar em beta ainda!

Aproveite e baixe também! Faça seus comentários!

Abraços e até a próxima!

Carlos dos Santos.
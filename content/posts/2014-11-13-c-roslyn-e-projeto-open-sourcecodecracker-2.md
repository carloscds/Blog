---
id: 6101
title: 'C# Roslyn e Projeto Open Source&ndash;CodeCracker'
date: 2014-11-13T23:14:56-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=6101
permalink: /2014/11/c-roslyn-e-projeto-open-sourcecodecracker-2/
categories:
  - 'C#'
tags:
  - 'msdn;c#'
---
Esta semana a Microsoft anunciou o novo Visual Studio 2015 e junto com ele o C# 6 com seu novo compilador, anteriormente conhecido como Roslyn e agora oficialmente chamado de [.Net Compiler Platform](https://roslyn.codeplex.com/). 

Com o Roslyn possível termos acesso a estrutura do compilador, sua árvore sintática e também mudar o seu comportamento através de componentes chamados Analyzers.

Na semana passada, quando eu estava na sede da Microsoft em Redmond/USA, participei de um hackaton com o time do compilador Roslyn, onde eu e diversos outros MVPs tivemos a oportunidade de escrever alguns analyzers juntamente com o time do Roslyn e durante este mesmo evento surgiu a idéia de criarmos um projeto Open Source contendo diversos analyzers, totalmente aberto e free, disponível para toda a comunidade de desenvolvedores, nascia então o projeto [CodeCracker](https://github.com/code-cracker/code-cracker), naquele momento criamos o time inicial, composto por mim, [Giovanni Bassi](http://blog.lambda3.com.br/L3/giovannibassi/) e o [Elemar Junior](http://elemarjr.net/), todos MVPs de C#. Subimos então os primeiros analyzers e agora estamos trabalhando nest projeto.

Como o projeto é Open Source está no GitHub, todo desenvolvedor que tiver interessde em participar, codificar junto com a gente, basta entrar em contato que adicionamos ao projeto, afinal queremos criar muitos analyzers e fixes!!!

Falando um pouco do que são os analyzers, vou explicar mostrando como eles funcionam, sendo assim, imagine então que você pode condicionar o compilador a validar o código fonte e apontar possíveis melhorias, ja fazendo as correções necessárias, tudo isto no editor de código fonte.

Vamos então a um pequeno exemplo de código:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/11/image_thumb.png" width="279" height="247" />](http://carloscds.net/wp-content/uploads/2014/11/image.png)

Este é um típico código onde o desenvolvedor não fez o tratamento da exceção. Agora com um dos Analyzers, o compilador já sugere uma correção:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/11/image_thumb1.png" width="492" height="270" />](http://carloscds.net/wp-content/uploads/2014/11/image1.png)

E ao clicar na opção para corrigir, o código já é modificado:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/11/image_thumb2.png" width="296" height="251" />](http://carloscds.net/wp-content/uploads/2014/11/image2.png)

Esta é a idéia dos analyzers e fixers que estamos construindo no projeto. Se você achou útil, pode começar a utilizar agora mesmo a versão alfa através do Nuget abaixo:

Se você achou demais a idéia e quer escrever analyzers, fale com a gente e participe do projeto open source!

Abraços e até a próxima!  
Carlos dos Santos.
---
id: 7541
title: CodeCracker 1.0
date: 2016-04-04T08:32:14-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=7541
permalink: /2016/04/codecracker-1-0/
categories:
  - 'C#'
  - Roslyn
---
Depois de um longo tempo e muito trabalho, temos o oriulho de anunciar a versão 1.0 do CodeCracker, uma das mais populares ferramentas para análise estática de código do mercado, e totalmente free e open source.

Só relembrando, Análise Estática de Código, é o fato de conseguirmos analisar seu código direto no editor, sem a necessidade de compilar. Com o compilador Roslyn (.Net Compiler), que veio junto com o Visual Studio 2015, se tornou possível escrever códigos (analisadores e fixers) que atuam no fluxo da compilação, pois o Roslyn atua como “Compiler as a Service”, um serviço de compilação que podemos consumir.

Falando do CodeCracker, este projeto começou em novembro de 2014 com 3 MVPS: Carlos dos Santos (eu), Giovanni Bassi e Elemar Junior. Nós iniciamos este projeto com o intuito de aprender Roslyn, e ralamos muito pois nesta época quanse não existia documentação ou exemplos sobre Roslyn. Conforme fomos trabalhando, começamos a receber ajuda de outros desenvolvedores ao redor do mundo, criando tarefas, detectando bugs e implementando código.

Somo gratos a todos estes desenvolvedores e colaboradores, sem eles este projeto não teria se tornado realidade. Para nós é uma felicidade enorme ver que este projeto tomou proporções mundiais, sendo utilizado inclusive pela Microsoft em algumas demonstrações e eventos. Mais felizes ainda pelos feedbacks que recebemos quase diariamente no projeto, o que nos dá mais vontade de criar mais analisadores e fixers!

O projeto não acaba aqui não, esta é somente a versão 1.0, temos muitas tarefas para serem desenvolvidas e muitas novas funcionalidades a serem criadas, O CodeCracker é um projeto que a todo momento recebe solicitações de funcionalidades e melhorias! E se você ainda nào está colaborando, começe agora mesmo!

Para conhecer um pouco mais do projeto, veja este [vídeo](https://channel9.msdn.com/Events/MVP-RD-Americas/MVP-Tech-Talk/Code-Cracker-Project-A-must-have-extension-for-Visual-Studio-2015) que gravamos para o Channel 9.

Quer colaborar com o projeto, acesso o [GitHub](https://github.com/code-cracker/code-cracker) agora mesmo!

A a nossa versão 1.0 está descrita [aqui](https://github.com/code-cracker/code-cracker/releases/tag/v1.0.0)!

Abraços e até a próxima.  
Carlos dos Santos.
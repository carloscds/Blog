---
id: 285
title: Uma história interessante
date: 2010-10-15T18:34:44-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2010/10/uma-histria-interessante/
permalink: /2010/10/uma-histria-interessante/
aktt_tweeted:
  - "1"
aktt_notify_twitter:
  - 'yes'
categories:
  - Visual Studio
---
Pessoal,

Gostaria de compartilhar com vocês uma história muito interessante que ocorreu comigo ontem. Como MVP, temos acesso a diversas ferramentas, mesmo antes de serem lançadas para o público em geral, com o intuito de ajudarmos no processo de testes e refinamento das funcionalidades. Recentemente eu comecei a testar o novo Visual Studio Power Tools (versão ainda beta privado) e percebi que o Visual Studio ficou mais lento para carregar soluções.

Como temos acesso a listas de discussão com o time do produto, eu postei uma mensagem relatando o problema e rapidamente uma pessoa do time do Visual Studio entrou em contato comigo para pedir mais detallhes do problema. Após eu relatar o cenário onde estava ocorrendo a lentidão, esta pessoa me pediu para baixar e executar uma ferramenta de coleta de informações (dump) e enviar para eles analisarem.

Agora aconteceu algo muito interessante. Ao baixar a ferramenta, a mesma não estava funcionando corretamente, ficava em loop ao iniciar o trace. Novamente eu reportei o problema e uma outra pessoa, agora que é o responsável pela ferramenta de diagnóstico entrou em contato comigo, primeiro por email me passando algumas instruções, que também não deram certo. Por fim ele sugeriu fazermos uma conferência por LiveMeeting (mesma ferramenta usada para webcasts), mas o link que ele me enviou não funcionou. Como MVP, temos acesso ao livemeeting e eu passei para ele um acesso que eu já tinha criado.

Pois bem, ele se conectou e começamos a analisar a ferramenta, e depois de uns 20 minutos analisando o problema, descobrimos que havia um erro em uma linha de comando de um arquivo BAT da ferramenta, uma simples falta de espaço. Corrigimos e a ferramenta finamente funcionou.

O interessante disto tudo: acertamos um problema em um local totalmente diferente do problema inicial, que era com o Visual Studio. Agora eu executei a ferramenta e enviei o dump para eles analisarem e corrigirem o problema.

Isto só mostra o quando a Microsoft está preocupada com a qualidade dos seus produtos e quanto os MVPs são importantes neste processo!

Um abraço e até a próxima.

Carlos dos Santos.
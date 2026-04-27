---
title: 'Migrei um projeto de ASP.NET Core usando o GitHub Copilot'
date: 2026-04-27
author: carloscds
layout: post
categories:
  - C Sharp
  - ASPNET
  - Copilot
---
Pode parecer facil migrar um projeto não é ? Só trocar as referências no csproj e rodar uns updates no nuget, e pronto!

Façil falar, mais difícil e complexo fazer!

### Cenário

Temos um projeto na empresa que precisa gerar um QRCode para PIX, e para isto usamos um componente para "desenhar" o QRCode. Parece simples, até você tentar rodar isto em um container usando Linux Alpine.

Não é tão simples assim, primeiro que o Linux Alpine é extremamente enxuto e depois de algum tempo você chega a conclusão que instalar libgdiplus nele pode ser um pouco mais trabalhoso do que parece.

Então vamos migrar para o Ubuntu, imagem padrão! Ai começa outro problema, a versão do .NET e a compatibilidade com System.Drawing no Linux.

Conclusão: Usar a imagem no Ubuntu e migrar o projeto para .NET 8.

### Vamos migrar na mão ?

Ok, migrar um projeto de ASP.NET 6 para 8 nem é tao difícil assim, dá para fazer na mão, não é ? O problema é que o projeto em questão tinha 6 projetos dentro dele, autenticação JWT, Entity Framework, API, Site, etc...

Então por quê não usar a IA para fazer este trabalho tão "braçal" ?

### Usando o GitHub Copilot

Eu uso o Visual Studio 2026 (se você não usa, veja [este meu vídeo no youtube](https://www.youtube.com/watch?v=Nu7MWeKxXE4&t=188s)) e logicamente que eu também tenho uma assinatura do GitHub CoPilot +.

Aqui cabe um parênteses: A Microsoft mudou a precificação do Copilot e isto pode impactar diretamente o seu custo, leia aqui o [artigo](https://github.blog/news-insights/company-news/github-copilot-is-moving-to-usage-based-billing/).

Mas se você, assim como eu, já tem a sua assinatura aí funcionando, vamos lá!

Eu abri um chat no GitHub Copilot no Visual Studio e simplesmente digitei o seguinte: **"migre o projeto para .NET 8.0"**

E fiquei olhando para a tela vendo a mágica acontecer! E alguns minutos depois, o projeto estava migrado e funcionando!

Só fiz alguns ajustes no Docker por conta da libgdiplus!

Isto me economizou algumas horas de trabalho!

### Dica importante

Coloque o chat do GitHub Copilot no modo Agent, assim ele pode fazer as mudanças necessárias no seu código.

Veja onde configurar:

![]( wp-content/uploads/2026/04/GithubCopilotChat.png)



Outro ponto importante é você criar uma branch do seu código para realizar mudança, você pode incluir isto no seu prompt para a IA também colocando este prompt: **"migre o projeto para .NET 8.0, mas antes crie uma nova branch chamada migracao"**

Você também poderia ter feito este mesmo processo usando o GitHub Copilot CLI, ainda não conhece ? [Baixe aqui](https://github.com/features/copilot/cli). Esta ferramenta funciona nal linha comando, sem a IDE.

### Considerações

A Inteligência Artificial bem usada é uma excelente ferramenta no dia a dia de um desenvolvedor, eliminando trabalhos repetitivos e aumentando a sua produtividade!

Abraços e até a próxima!

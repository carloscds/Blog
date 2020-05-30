---
id: 32
title: Visual Studio 2010 – problema antigo resolvido
date: 2009-10-20T23:05:00-03:00
author: carloscds
layout: post
guid: /post/2009/10/20/Visual-Studio-2010-e28093-problema-antigo-resolvido.aspx
permalink: /2009/10/visual-studio-2010-problema-antigo-resolvido/
categories:
  - Visual Studio
---
Pessoal,

Quem nunca teve a infelicidade de pressionar a tecla F1 dentro do Visual Studio sem querer, e ele começa a compilar o help eternamente. Em alguns casos, eu mesmo, tive que derrubar o processo pelo gerenciador de tarefas.

Mas por quê isto acontececia ? Simples, o help era gerado no mesmo processo da IDE, ou seja, o DEVENV.EXE.

Agora, no Visual Studio 2010, o help é totalmente gerenciado via browser, ou seja, totalmente independente da IDE e muito, mas muito, mais rápido. Então é o fim do travamento pelo F1.

Olhem como ficou:

![](/wp-content/uploads/image_5.png)

Eu chamei esta janela de help, pressionando o F1 em cima do nome Form, da classe do formulário.

[]s,
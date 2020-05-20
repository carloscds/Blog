---
id: 757
title: Desenvolvimento para Windows 8
date: 2013-01-17T17:25:08-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2013/01/desenvolvimento-para-windows-8/
permalink: /2013/01/desenvolvimento-para-windows-8/
categories:
  - 'C#'
  - Windows 8
tags:
  - 'msdn;c#;windows 8'
---
Olá pessoal,

Neste primeiro post de 2013 vou falar um pouco somente a minha experiência no desenvolvimento de duas aplicações para Windows 8.

A primeira aplicação eu fiz no final do ano passado, apenas com o intuito de validar o processo de desenvolvimento e publicação na Store da Microsoft. É uma aplicação bem simples, para lista de compras, onde o usuário cria uma lista de compras e relaciona os produtos que vai comprar, podendo enviar esta lista por email através do Share do Windows.

O que achei bem interessante foi a facilidade do desenvolvimento. O Visual Studio ajuda muito e a linguagem C# também, o que torna o desenvolvimento bem rápido. Mas vale a pena ficar em dois apectos fundamentais no desenvolvimento usando C#: primeiro é um bom conhecimento de XAML, pois todo o designer da aplicação é baseado nele, e depois conhecer sobre programação assíncrona, já que é importante manter a resposta para o usuário rápida, afinal ninguem quer clicar em um botão e ficar esperando eternamente algo acontecer. 

A segunda aplicação que fiz, na semana passada, me surpreendeu mais ainda. Trata-se de um quadro de reuniões, que o usuário pode “rabiscar” a tela do micro ou do tablet, como se fosse um quadro branco e nesta aplicação eu apliquei recursos de globalização e estou disponibilizando a aplicação em Português e Inglês. Isto foi realmente muito simples de fazer, praticamente nenhuma linha de código, somente aquivos de recursos e tags em XAML. O processo de validação e publicação desta aplicação aconteceu em apenas 2 dias, ou seja, eu enviei para certificação e dois dias depois estava publicado na loja.

A plataforma Windows 8 deixou o desenvolvimento mais interessante e divertido, os recursos são fantásticos e para citar apenas alguns: Share e Search, que são contratos que podem ser implementados na aplicação. Estes recursos proporcionam uma nova visão sobre a interação da applicação com o sistema operacional e também com as outras aplicações.

Para conhecer mais sobre como programar para Wndows 8, você pode começar por aqui:  
[http://www.microsoft.com/brasil/apps/windows.html](http://www.microsoft.com/brasil/apps/windows.html "http://www.microsoft.com/brasil/apps/windows.html")

Para conhecer as minhas aplicações:  
Lista de Compras: <http://apps.microsoft.com/windows/pt-br/app/lista-de-compra/2cb1f61a-6d08-4697-8af0-a313f63cfea5>  
MeetingBoard:&nbsp; <http://apps.microsoft.com/windows/pt-BR/app/meetingboard/ad8d8944-5e3b-4c00-9211-93cc1c5ebcbf>

Começe a desenvolver agora mesmo!

Abraços e até a próxima!  
Carlos dos Santos.
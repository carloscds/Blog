---
id: 775
title: Analise sua Conta do Windows Azure
date: 2013-07-07T15:59:40-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2013/07/analise-sua-conta-do-windows-azure/
permalink: /2013/07/analise-sua-conta-do-windows-azure/
categories:
  - Azure
  - 'C#'
tags:
  - 'msdn;c#;azure'
---
Pessoal,

Quem já está usando o Windows Azure e tem necessidade de analisar como anda a conta, precisa baixar o arquivo CSV com os dados de movimentação da conta.

Este arquivo contém informações sobre todos os serviços que você está utilizando na sua conta, mas é um arquivo texto um pouco complicado de se entender.

Para resolver isto, eu criei uma ferramenta que permite transformar este arquivo texto em uma informação mais simples de se entender e também possível de ser exportada para um arquivo XML, que pode até ser aberto no Excel.

Para analisar a sua conta a primeira coisa a fazer é baixar o arquivo no site [account.windowsazure.com](http://account.windowsazure.com), na opção Conta/Baixar Detalhes do Uso. Depois disto abra o programa Windows Azure Usage a aponte para o seu arquivo. Veja a tela principal da ferramenta:

<a href="http://carloscds.azurewebsites.net/wp-content/uploads/2013/07/SNAGHTMLd76deed2.png" rel="lightbox"><img title="SNAGHTMLd76deed" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="SNAGHTMLd76deed" src="http://carloscds.azurewebsites.net/wp-content/uploads/2013/07/SNAGHTMLd76deed_thumb2.png" width="599" height="416" /></a>

Se você tiver alguma idéia ou sugestão, me envie, pois ainda vou acrescentar alguns recursos na ferramenta.

Para baixar o programa, clique [aqui](http://carloscds.net/download/azureusage.zip).

Abraços,  
Carlos dos Santos.
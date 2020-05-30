---
id: 235
title: Ferramentas para Relatórios
date: 2010-09-06T21:36:36-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2010/09/ferramentas-para-relatrios/
permalink: /2010/09/ferramentas-para-relatrios/
categories:
  - 'C#'
  - Visual Studio
tags:
  - 'msdn;c#'
---
Para quem está desenvolvendo aplicações comerciais em .Net, uma dúvida muito comum é como criar os relatórios da aplicação. Se você usa o Microsoft SQL Server, poderá usar o Reporting Services (), que é um excelente ferramenta para relatórios.

Mas se você usa outros bancos de dados, ou está criando uma aplicação multi-banco, talvez o Reporting Services não seja uma boa opção, mas não se preocupe pois existem várias alternativas e excelentes ferramentas para relatórios, vejamos algumas delas que considero muito boas:

1. **<u>PrintDocument:</u>** componente do Visual Studio onde você precisará desenhar o relatório manualmente, não é a maneira mais eficaz para um relatório, mas pode ser útil em alguns casos. Conheça mais em: 

2. **<u>SQL Reporting Services:</u>** faz parte do Microsoft SQL Server e é uma ferramenta gratuita, mesmo nas versões Express. É simples de utilizar e possui grande variedade de templates. Os relatórios ficam armazenados dentro do SQL Server. Conheça mais em: http://msdn.microsoft.com/pt-br/library/ms159106.aspx

3. **<u>DevExpress XTraReports:</u>** é uma ferramenta realmente excelente, apesar de ser paga, não é muito cara e depois de instalar o componente você terá um novo template para um item de projeto do tipo XTraReport, onde você cria relatórios realmente fantásticos. Você tem total controle sobre todas as partes do relatório e pode escrever o código em C# ou VB.Net dentro do Visual Studio. Os relatórios são compilados junto com a aplicação e você precisa somente distribuir as DLLs do componente. Um ponto que não gosto muito é que não tem um Designer muito amigável para o usuário final, caso você queira permitir que seus usuários modifiquem os relatórios. Ele também expota os relatórios para um dezena de formatos, como PDF, JPG, Word, Excel, HTML, etc. Conheça mais em: http://www.devexpress.com/products/net/reporting/
A DevExpress é muito conhecida também pela sua suite de componentes, que vale a pena você conhecer.

4. **<u>StimulReport:</u>** é uma ferramente excelente e muito simples de utilizar, trabalha por padrão com Ribons no Designer o que facilita muito a vida do desenvolvedor, permite controlar totalmente o relatório, assim como o XTraReports, mas ao contrário deste, o relatório não é compilado junto com a aplicação, ficando em um arquivo separado. Neste caso ou você mantém o arquivo separado ou cria um mecanismo para armazená-lo no banco de dados. A grande vantagem desta ferramenta é a facilidade de se modificar um relatório em tempo de execução, simplesmente clicando em um botão EDIT. Ele permite também que os formulários para os filtros do relatório, por exemplo, sejam feitos juntamente com o relatório, o que facilita muito a nossa vida. Você precisará também enviar junto com a aplicação as DLLs do componente. AO Stimul tem também uma interface toda em WPF, o que lhe confere um visual bem mais moderno. Ele também expota os relatórios para um dezena de formatos, como PDF, JPG, Word, Excel, HTML, etc. Conheça mais em: http://www.stimulsoft.com

É claro que existem vários outros componentes para relatórios, mas estes são os que eu considero muito produtivos. É isto aí, acho que deu para ter uma idéia de que caminho tomar no desenvolvimento de relatórios para aplicações.

[]s,  
Carlos dos Santos.
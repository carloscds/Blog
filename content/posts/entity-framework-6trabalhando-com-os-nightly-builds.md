---
id: 782
title: Entity Framework 6–Trabalhando com os Nightly Builds
date: 2013-08-18T18:13:06-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2013/08/entity-framework-6trabalhando-com-os-nightly-builds/
permalink: /2013/08/entity-framework-6trabalhando-com-os-nightly-builds/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'msdn;c#;ef codefirst'
---
Olá pessoal,

Voltando agora a escrever mais sobre o Entity Framework, estamos aguardando a nova versão 6 (ainda sem data definitiva para ser lançado) que trará melhorias muito significativas e vamos explorar algumas delas nos próximos artigos.

Antes de qualquer coisa é importante saber que o Entity Framework 6 ainda está em versão Alfa (isto mesmo ALFA), sendo assim não é recompendado utilizar em projetos que já estejam em produção, o que não nos impede de já ir testando algumas coisas bem legais.

A primeira coisa é como instalar o EF 6 em um projeto. Normalmente você usar o Nuget Package Console para adicionar o EF a um projeto seu, com o seguinte comando: (abra antes o Tools/Library Package Manager/Package Manager Console)

**<span style="color: #373737;">PM> InstallPackage EntityFramework</span>**

Mas irá instalar o EF 5 que é a última versão de produção, lançada juntamente com o Visual Studio 2012 e o .Net 4.5. Mas se você quer instalar o EF 6 em um projeto, terá que utilizar o seguinte comando:

**<span style="color: #373737;">PM> InstallPackage EntityFramework –Pre</span>**

Isto irá instalar a última versão publicada do EF 6, que atualmente é a Alfa 1. Legal, isto permite que você trabalhe com o EF 6 e explore algumas funcionalidades bem interessantes, mas não queremos isto, queremos as coisas legais ainda não publicadas.

**<u>Acessando os Builds Noturnos</u>**

O EF 6, como todos já devem saber, é Open Source e todo o seu código fonte, eu realmente disse todo o código fonte, pode ser baixado [aqui](https://github.com/dotnet/ef6). Eu recomendo que você baixe o código e dê uma olhada em como o projeto está estruturado, como são os testes unitários. O código fonte do EF é, sem dúvida alguma, uma excelente fonte de estudos.

Apesar do EF 6 ser totalmente open source, apenas a Microsoft libera as versões oficiais e também as chamadas Nightly Builds ou Build Noturnos, que nada mais são do que uma versão diária do que está sendo desenvolvido pela Microsoft e pela comunidade que está colaborando no projeto. Se você é, assim como eu, uma pessoa que gosta muito das novidades e fica ansioso por testá-las, estes builds noturnos nos dão isto.

Para ter acesso aos Nightly Builds você precisa configurar o Visual Studio para acessar o endereço onde eles são publicados diariamente. Vamos fazer isto acessando a configuração do NuGet em Tools/Library Package Manager/Package Manager Settings e depois em Package Source:

![](/wp-content/uploads/2013/08/SNAGHTMLc0f2ab22.png)

Clique no botão “+” e depois preencha os campos:

Name: Nightly Builds  
Source: [http://www.myget.org/F/aspnetwebstacknightly/](http://www.myget.org/F/aspnetwebstacknightly/ "http://www.myget.org/F/aspnetwebstacknightly/ ") 

Salve clicando no OK. Agora que já configuramos, vamos criar um projeto do tipo Console para poder adicionar a última versão nortuna publicada. Para isto crie o projeto do tipo Console, escolhendo o **.Net 4.5** pois alguns novos recursos só irão funcionar nesta versão do .Net.

Com o projeto criado, clique com o botão direito do mouse no nome da sua solução e depois escolha Manage Nuget Packages e você verá a imagem abaixo:

![](/wp-content/uploads/2013/08/SNAGHTMLc1440a32.png)

Veja que já temos os Nightly Builds na nossa janela, mas antes ainda precisamos indicar que queremos os “Pre Releases”, que são as versões ainda não oficiais. Você pode fazer isto clicando na opção “Stable Only” e mudando para “Include Prerelease”.

Feito isto vamos clicar em “Nightly Builds” e na janela de busca vamos digitar “Entity” e veja que você verá a última versão publicada, no meu caso do dia 18/08/2013:

![](/wp-content/uploads/2013/08/SNAGHTMLc1720992.png)

Agora é só clicar em “Install” para instalar a última versão.

Uma lista da novas funciondalidades pode ser obtidas no endereço:  
https://docs.microsoft.com/en-us/ef/ef6/what-is-new/past-releases

Nos próximos post iremos explorar mais detallhadamente algumas destas novas funcionalidades!

Abraços e até a próxima,  
Carlos dos Santos.
---
id: 282
title: Publicando uma aplicação web no IIS 7
date: 2010-10-03T16:39:28-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2010/10/publicando-uma-aplicao-web-no-iis-7/
permalink: /2010/10/publicando-uma-aplicao-web-no-iis-7/
aktt_notify_twitter:
  - 'yes'
aktt_tweeted:
  - "1"
categories:
  - Asp.Net
  - C Sharp
  - Visual Studio
tags:
  
---
Olá pessoal, neste artigo vou mostrar como é simples publicar uma aplicação web no IIS 7 (Internet Information Server), que está presente no Windows Vista, Windows 7 e Windows Server 2008 e 2008 R2. 

Publicar uma aplicação na sua rede local ou computador pessoal é um pouco diferente do que publicar em um webhost, que traz ferramentas específicas que ajudam e facilitam o trabalho, visto que dificilmente você terá acesso direto ao IIS do hosting.

Mas no ambiente da sua rede local, será necessário acessar o IIS para publicar sua aplicação web, seja ela Asp.Net, Webservices ou WCF, e é neste caso que este artigo pode lhe ajudar.

Não vou abordar a criação da aplicação propriamente dita, pois existe uma infinidade de artigos na web mostrando técnicas e frameworks que podem lhe ajudar neste processo, aqui vamos abordar simplesmente a publicação e atualização da aplicação.

Então vamos criar uma aplicação bem simples em Asp.Net só para demonstrar a publicação, para isto vá em New Project e escolha Asp.Net e dê o nome de WebTeste: 

![]( wp-content/uploads/2010/10/image.png)

Veja que estamos criando uma aplicação com o Framework 2.0. Estou fazendo isto para demonstrar logo abaixo como podemos publicar uma aplicação com o Framework 4.0, que apresenta algumas diferenças.

Criada a aplicação, vamos apenas escrever um texto qualquer, lembrando que o objetivo é mostrar a publicação apenas:

![]( wp-content/uploads/2010/10/image1.png)

Se você executar esta aplicação, pressionando F5, terá algo como a tela abaixo:

![]( wp-content/uploads/2010/10/image2.png)

O Visual Studio possui um micro servidor web, que serve para ajudar no desenvolvimento de aplicações web, ou seja, com este pequeno servidor, você consegue executar sua aplicação sem precisar instalar o IIS, e para cada aplicação que você executa, ele cria um endereço virtual, como o da imagem acima:

##### http://localhost:45566/Default.aspx

Isto é bem interessante, pois você pode usar este endereço inclusive dentro da sua rede, ou seja, de um outro computador, se você digitar o nome ou IP deste micro, é possível acessar esta aplicação web, mas lembre-se, somente para o desenvolvimento, pois o Visual Studio compila a aplicação e publica através deste servidor de desenvolvimento.

Mas agora vamos publicar a aplicação corretamente, usando o IIS. Para isto vá no menu Build/Publish do Visual Studio e você verá uma tela igual a este no Visual Studio 2010:

![]( wp-content/uploads/2010/10/image3.png)

![]( wp-content/uploads/2010/10/image4.png)

ou igual a esta no Visual Studio 2008:

![]( wp-content/uploads/2010/10/image5.png)

No Visual Studio 2010, nós temos mais opções na publicação, que você poderá explorar posteriomente. Eu vou escolher publicar em um diretório a nossa aplicação, mas você pode publicar direto no IIS ou por FTP, de acordo com a sua necessidade. Para publicar em um diretório, em Target Location coloque o nome do diretório e depois clique em Publish:

![]( wp-content/uploads/2010/10/image6.png)

Feito isto, o Visual Studio irá compilar e copiar os arquivos necessários para a aplicação web funcionar no diretório especificado, veja: 

![]( wp-content/uploads/2010/10/image7.png)

Agora precisamos publicar no IIS, e para isto vamos abrir o Gerenciador do IIS, lembrando que se você não tem o IIS precisará instalá-lo. Abra o gerenciador do IIS clicando Iniciar/Painel de Controle/Ferramentas Administrativas/Gerenciador do Internet Information Services (caso você não veja as Ferramentas Administrativas, use a busca do Painel de Controle) e após isto você vera a tela abaixo:

![]( wp-content/uploads/2010/10/image8.png)

Agora para publicar a aplicação, clique com o botão direito do mouse no site padrão (Default WebSite) e depois em Add Application:

![]( wp-content/uploads/2010/10/image9.png)

Você verá a tela abaixo:

![]( wp-content/uploads/2010/10/image10.png)

Neste tela o **Alias** é o nome do site, que será usado para acessá-lo pelo navegador e o **Physical Path** é o diretório onde publicamos a aplicação pelo Visual Studio ou o diretório do seu servidor onde está a aplicação publicada. Clicando em OK, você já poderá acessar a sua aplicação pelo browser:

![]( wp-content/uploads/2010/10/image11.png)

Está pronto, sua aplicação está publicada no IIS 7, mas lembre-se que no eu comentei no início do artigo que para publicar uma aplicação em .Net 4.0 era um pouco diferente e vou mostrar isto agora.

Quando desenvolvemos uma aplicação, ela está ligada a versão do Framework em que foi escrita, e isto acontece também com o Servidor Web (IIS). Nele as aplicações executam sob um Pool de Aplicações, onde você informa qual a versão do framework será executada. Isto possibilita que executemos em um mesmo servidor web aplicações escritas em várias versões do framework. Mas como gerenciar estes Pools&#160; de Aplicação ? Bom isto é bem simples, veja: clicando em Application Pools no gerenciador do IIS você tem esta tela:

![]( wp-content/uploads/2010/10/image12.png)

Ela mostra todos os pools que temos atualmente e você pode notar que temos .Net 2.0 e .Net 4.0, mas não temos o 3.5, pois ele faz parte do 2.0. Vamos então criar e publicar uma aplicação com .Net 4.0, para isto basta primeiramente criarmos a aplicação em&#160; .Net 4.0, então vamos em New Project/Web:

![]( wp-content/uploads/2010/10/image13.png)

Só um detalhe importante é que quando clicamos uma aplicação no Visual Studio 2010 para .Net 4.0, ela já tem um esqueleto pronto, então se você quiser, troque somente o texto da tela inicial, de maneira que fique como a tela abaixo:

![]( wp-content/uploads/2010/10/image14.png)

Depois publique da mesma maneira que foi demonstrado acima. Só para demonstrarmos um erro bem comum, publique a aplicação da mesma maneira que a anterior, e veja que ao executá-la obterá o seguinte erro: 

![]( wp-content/uploads/2010/10/image15.png)

Este erro acontece porquê o DefaultAppPool está apontando para o .Net 2.0 e sua aplicação agora é feita em 4.0, vamos então ver a maneira correta de criar a aplicação no IIS. Na verdade os passos são os mesmos com uma pequena diferença, temos que escolher um outro Pool para nossa aplicação, clicando no botão Select da tela de criação de aplicação:

![]( wp-content/uploads/2010/10/image16.png)

Clicando no botão Select, você verá a tela abaixo:

![]( wp-content/uploads/2010/10/image17.png)

Onde escolheremos ASP.NET v4.0, e está pronto, agora você pode acessar sua aplicação sem problemas:

![]( wp-content/uploads/2010/10/image18.png)

Se você já tiver criado a aplicação no IIS e quiser trocar o Pool, basta clicar em **Advanced Settings** e trocar o Pool. Você pode também criar seu próprio Pool no IIS, clicando com o botão direito em Application Pools/Add Application Pool.

Para finalizar, quando você atualizar a sua aplicação, basta publicar novamente que o IIS irá executar a nova versão.

Se você quer configurar a segurança da sua aplicação, veja estes outros posts:  
http://technet.microsoft.com/pt-br/library/cc731278(WS.10).aspx

http://technet.microsoft.com/pt-br/library/cc730708(WS.10).aspx

É isto aí pessoal, espero que seja útil para vocês!

Abraços,  
Carlos dos Santos.
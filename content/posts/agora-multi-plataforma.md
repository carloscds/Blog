---
id: 8301
title: 'Agora é multi plataforma!'
date: 2017-01-01T22:24:01-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=8301
permalink: /2017/01/agora-multi-plataforma/
categories:
  - DotNet
  - C Sharp
  - Open Source
---
Olá a todos,

Neste primeiro post de 2017 vou falar de algo que já está afetando a vida dos desenvolvedores: criar software multi plataforma! Há muito tempo se fala neste tipo de desenvolvimento e muito se prometeu com ferramentas e linguagens, algumas um tanto mirabolantes!

Me lembro de ter ido conhecer uma ferramenta Windows que havia sido portada para Linux e quando comecei a fazer perguntas sobre funcionalidades bem básicas a resposta foi: “Bem, isto ainda não fizemos…”, e nem preciso dizer que instalar a tal ferramenta era coisa para alguns dias de muitos comandos em um sistema Linux. E o pior: nenhuma compatibilidade com o que já existia! 

Muita coisa mudou deste então e muitas outras ferramentas e plataformas surgiram, algumas muito semelhantes a que descrevi e outras que nem existem mais!

Como desenvolvedores, e muitas vezes, empresários, é muito complicado ficar apostando em tecnologias que prometem muita coisa e que no final não entregam absolutamente nada!

Primeiro gostaria de falar com vocês sobre desenvolvimento mobile, então vamos imaginar um cenário em que você vai desenvolver uma app: primeiro você faz para Android, afinal é a plataforma líder, depois para iOS e talvez você pense no Windows Phone. Mas o grande problema sempre foi aproveitar o código, e isto nunca foi possível de verdade, porque cada plataforma tem uma linguagem e um jeito de fazer! 

Eis que então temos algumas alternativas: 

  * Apache Cordova, uma plataforma baseada em HTML+JS+CSS que promete entregar uma app em qualquer plataforma, e realmente ela consegue fazer isto de maneira muito satisfatória! O Visual Studio traz um conjunto de ferramentas para você trabalhar com Cordova que pode ser baixado neste [link](https://www.visualstudio.com/vs/cordova/). Mas o problema é a performance, pois você está rodando uma aplicação com um browser embutido nela, um [WebView](https://cordova.apache.org/docs/en/latest/guide/overview/), e isto pode te trazer alguns inconvenientes!&#160; 
  * Algumas outras ferramentas também surgiram com a promessa do desenvolvimento mobile multi plataforma, como: [PhoneGap](http://phonegap.com/getstarted/), [MonoDroid](http://www.monodevelop.com/archived/download/mono-for-android/) e finalmente o [Xamarin](https://www.xamarin.com/), que agora pertence a Microsoft.

Com Xamarin temos um desenvolvimento realmente muiti plataforma, com o mesmo código. Então podemos desenvolver em C# para Android, iOS e Windows Phone, usando uma única linguagem para todas as plataformas, desenvolvendo somente uma vez! 

Mas alguns podem dizer, eu não gosto de Windows, eu uso Linux, uso Mac! E aí que vem a beleza da ferramenta, pois existem versões para Windows, Linux e Mac, usando o [Xamarin Studio](https://www.xamarin.com/studio) e mais recentemente o [Visual Studio for Mac](https://www.visualstudio.com/vs/visual-studio-mac/). Se você estiver a fim de aprender mais sobre Xamarin, recomendo o [Monkey Nights](http://monkeyhub.com.br/), que é um hub de conteúdo sobre Xamarin!

Muito bem, mas o mundo não é so desenvolvimento Mobile, temos também Desktop e Web, como fica isto no mundo multi plataforma ?

Se você é um desenvolvedor Asp.Net e trabalha com C#, a boa notícia é que agora podemos desenvolver uma aplicação que roda no Windows (IIS) e no Linux (com diversos servidores web) e isto traz, uma quebra de paradigma para desenvolvedores acostumados com o mundo Windows: a famigerada LINHA DE COMANDO, isto mesmo, você terá que digitar muito comando e não pense que isto é ruim não! Veja, eu gosto muito da IDE do Visual Studio, acho realmente muito produtiva, talvez a mais produtiva do mercado, mas quando eu trabalho com projetos no Git, eu prefiro usar a linha de comando, sabe por quê, simples: eu tenho mais controle sobre o que está acontecendo e talvez a IDE ainda não tenha todos os comandos que eu preciso…

Entâo caro amigo desenvolvedor, se acostume a ver as telas abaixo:

![]( wp-content/uploads/2017/01/image.png)

![]( wp-content/uploads/2017/01/SNAGHTML37ff22fb.png)

Esta segunda tela é um terminal Linux para um servidor da empresa. E isto é bem interessante, já que até algum tempo atráz tudo era somente Windows, e agora temos um [SQL Server rodando no Linux](http://www.cds-software.com.br/noticias/sql-no-linux-erp-rodando/). Então tem dias que eu trabalho mais no Linux que no Windows!

Mas por quê eu estou usando Linux afinal de contas ? Simples, por quê eu estou desenvolvendo para web multi plataforma usando [Asp.Net Core](https://www.asp.net/core), estou usando C# e criando ferramentas que podem ser hopedadas em Windows ou Linux. 

Então vamos ao contexto: a Microsoft vem trabalhando em uma nova versão do Asp.Net, que foi totalmente reescrito, que roda muito mais rapido que o atual e principalmente, é totalmente multi plataforma: Windows, Linux e Mac.

Mas não precisa arrancar todos os cabelos por causa do terminal do Linux, pois o Visual Studio 2015 já trabalha com Asp.Net Core, basta instalar as ferramentas deste [link](https://www.microsoft.com/net/core#windowsvs2015). E se você gosta de coisas novas, assim como eu, também pode usar o [Visual Studio 2017 RC](https://www.visualstudio.com/vs/visual-studio-2017-rc/), lembrando que ainda está em beta.

Temos também uma ferramenta fantástica e multi plataforma, chamada [Visual Studio Code](https://code.visualstudio.com/), e esta ferramenta já é uma das mais utilizadas para desenvolvimento Javascript, pois é muito simples de trabalhar e conta com centenas de plugins que permitem a ela trabalhar com diversas linguagens! Eu já trabalhei com Arduino e Java no VS Code, veja alguns exemplos de linguagens:

![]( wp-content/uploads/2017/01/image-1.png)

Bom, eu falei tudo isto para enfatizar que existe uma nova Microsoft, que trabalha com Open Source ([veja meus slides aqui](http://pt.slideshare.net/carloscds/microsoft-opensource)) e que já é muiti plataforma, pois até Linux já existe dentro do seu Windows 10, se não acredita, veja este post [aqui](http://carloscds.net/2016/08/tem-um-linux-no-meu-windows-10/).

Então meu amigo desenvolvedor, é hora de quebrar paradigmas, de estudar Linux, de pensar diferente, pois o mundo é multi plataforma! Trabalhar com Windows, Linux, Mac, Visual Studio, VS Code, é o nosso dia a dia!!!

E viva a diversidade!

Abraços e até a próxima!  
Carlos dos Santos.
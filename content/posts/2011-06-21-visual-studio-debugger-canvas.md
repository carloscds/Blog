---
id: 393
title: Visual Studio Debugger Canvas
date: 2011-06-21T21:43:50-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2011/06/visual-studio-debugger-canvas/
permalink: /2011/06/visual-studio-debugger-canvas/
aktt_notify_twitter:
  - 'yes'
categories:
  - 'C#'
  - Visual Studio
tags:
  - 'c#; msdn'
---
Olá,

Acaba de ser lançado um recurso muito legal para o Visual Studio 2010 Ultimate, o Debugger Canvas, que é uma maneira mais visual de fazer debug de suas aplicações.

Normalmente, ao fazer debug de uma aplicação, você executa e vai percorrendo linha a linha, entrando e saindo de rotinas dentro do código e depois de algum tempo, você acaba com diversas janelas abertas no Visual Studio.

Agora imagine que ao fazer o debug, os diferentes códigos fontes vão se abrindo e se relacionando, formando um caminho percorrido pelo fluxo de execução, mais visual, não serial muito bom ? Pois é exatamente isto que o Debugger Canvas faz.

Para começar, vamos instalar o debugger canvas, que é um plugin para o Visual Studio Ultimate e pode ser baixado <a href="http://msdn.microsoft.com/en-us/devlabs/hh227299" target="_blank">aqui</a>.

Agora abra um projeto você está acostumado a fazer debug, no meu caso, vou abrir o projeto TailspinToys, que é um projeto exemplo da Microsoft. Vamos executá-lo (F5) e ver o que acontece com o debug.

Primeiro vamos abrir o CartController.cs e colocar um break point no método AddCart()

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2011/06/image_thumb.png" width="244" height="241" />](http://carloscds.net/wp-content/uploads/2011/06/image.png)[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2011/06/image_thumb1.png" width="523" height="233" />](http://carloscds.net/wp-content/uploads/2011/06/image1.png) 

Agora vamos executar o programa pressionando F5. Após a aplicação abrir no browser, clique em “Model Airplanes” e depois em&#160; em “View Plane”. Em seguida clique em “Add to Cart”.

Neste ponto o código irá parar no local onde fizemos o break point, mas com uma grande diferença no visual:

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2011/06/image_thumb2.png" width="493" height="289" />](http://carloscds.net/wp-content/uploads/2011/06/image2.png)

Veja que agora estamos no Debugger Canvas, no codigo do controller. Em cima na barra da janela está a árvore de execução, ou seja, por onde o código passou até chegar aqui e existe também um botão no canto direito da tela que mostrar as variáveis locais para o método:

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2011/06/image_thumb3.png" width="676" height="197" />](http://carloscds.net/wp-content/uploads/2011/06/image3.png)

Vamos executar o código pressionando F11 para entrar em algum outro método e logo em seguida temos esta outra janela:

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2011/06/image_thumb4.png" width="700" height="233" />](http://carloscds.net/wp-content/uploads/2011/06/image4.png)

Pressionando mais algumas vezes o F11 temos o seguinte:

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2011/06/image_thumb5.png" width="497" height="148" />](http://carloscds.net/wp-content/uploads/2011/06/image5.png)

Fazendo um pequeno ajuste visual temos o seguinte:

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2011/06/image_thumb6.png" width="861" height="279" />](http://carloscds.net/wp-content/uploads/2011/06/image6.png)

Aqui vemos a linha de execução do programa até onde paramos, ou seja, se continuarmos a execução teremos um mapa visual de todo o fluxo de execução da nossa aplicação, e o que ganhamos com isto ? Facilidade para entender como o código funciona.

Uma última coisa é que quando você instala o Debugger Canvas, ele fica como padrão para o seu debug e caso você queira ativar/desativar, basta abrir o menu Debug/Debugger Canvas/Options and Settings de desmarcar a propriedade abaixo:

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2011/06/image_thumb7.png" width="563" height="340" />](http://carloscds.net/wp-content/uploads/2011/06/image7.png)

Espero que vocês tenham gostado do potencial deste novo recurso para o Visual Studio e isto mostra mais uma vez que a ferramenta está evoluindo e tem muito mais a evoluir.

Abraços e até a próxima.

Carlos.
---
id: 808
title: Visual Studio 2013–Novidades
date: 2013-10-20T12:12:27-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2013/10/visual-studio-2013novidades/
permalink: /2013/10/visual-studio-2013novidades/
categories:
  - 'C#'
  - IDE
tags:
  - 'c#; msdn'
---
Olá pessoal,

O Visual Studio 2013 será lançado no próximo dia 13/11/2013 (para assinantes do MSDN já está disponível) e junto com esta nova versão temos melhorias muito interessantes na IDE, que tornam o nosso dia a dia ainda mais produtivo.

Neste post vou mostrar algumas destas novas funcionalidades que eu particularmente uso a todo momento e que ajudam muito no desenvolvimento. Enão vamos lá:

<u><strong>Peek Definition (ALT F12)</strong></u>

Imagine que você está escrevendo um método qualquer e precisa verificar um método que está em outra classe, normalmente você pressionar o F2 e olha a classe, e depois volta para o seu código. Isto é bem funcional, mas tira o foco do código que você está trabalhando. Agora no Visual Studio 2013, você tem o Peek Definition, que é acionado pela tecla ALT + F12, onde o código é mostrado para você na mesma janela, em cima do método.

Eu criei um projeto bem simples, com Entity Framework 6 acessando o banco de dados NorthWind e neste projeto tem um método RetornaClientes() que simplesmente volta uma lista de clientes (A idéia aqui não é focar na funcionalidade do projeto e sim na IDE). 

Veja o código abaixo:

<a href="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image8.png" rel="lightbox"><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image_thumb8.png" width="595" height="405" /></a>

Agora, com o mouse em cima do método RetornaClientes, pressione **ALT F12**:

<a href="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image12.png" rel="lightbox"><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image_thumb13.png" width="891" height="484" /></a>

É muito simples, agora você está vendo o código do método RetornaClientes() na mesma janela que estava trabalhando. E você pode pressionar o ALT F12 dentro desta janela também e ir navegando pelos códigos, sem precisar ficar alternando entre duas ou mais janelas.

<u><strong>Code Lens</strong></u>

Este é um recurso também muito útil, principalmente se você está trabalhando em um código de que você não conhece bem, mas como assim: quantas vezes você já precisou fazer uma busca no código para localizar a utilização de uma propriedade ou um método ? Quase sempre eu imagino! Isto toma muito tempo e abaca deixando um monte de janelas abertas na sua IDE.

O Code Lens pode te ajudar muito nisto. A idéia básica é que para cada classe, propriedade ou método, você tem uma referência logo acima do nome que indica quantas vezes ele está referenciado,ou seja, quem está utilizando esta classe, propriedade ou método.

Veja no mesmo exemplo, onde temos o Entity Framework referenciando o banco de dados NorthWind, ao abrirmos o código fonte da classe NortwindContext.cs, temos o Code Lens acima dos nomes, veja:

<a href="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image22.png" rel="lightbox"><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image_thumb22.png" width="803" height="583" /></a>

Isto quer dizer, por exemplo, que a classe NortwindContext está sendo referenciada 5 vezes. E ao clicar sobre o número:

<a href="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image32.png" rel="lightbox"><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image_thumb32.png" width="871" height="282" /></a>

E ao passar o mouse sobre as referências, você consegue ver em que parte do código fonte ele está sendo usado:

<a href="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image42.png" rel="lightbox"><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image_thumb42.png" width="916" height="198" /></a>

Sem dúvida um recurso muito útil e que vai deixar o seu dia ainda mais produtivo.

<u><strong>Nova Scroll Bar</strong></u>

Agora você pode configurar a barra de scroll do seu editor de código para deixá-la mais interessante do que apenas rolar o código. Podemos transformar a barra do scroll em um visualizador de códigos que pode facilitar a navegação pelas linhas do seu programa.

Para ativarmos este recurso, basta clicar com o botão direito do mouse sobre a barra latera e escolher Scroll Bar Options:

<a href="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image51.png" rel="lightbox"><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image_thumb52.png" width="309" height="318" /></a>

E depois é só configurar:

<a href="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image61.png" rel="lightbox"><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image_thumb61.png" width="504" height="194" /></a>

Ative a opção “Show Preview Tooltip” e depois escolha o tamanho da barra de scroll. Após a configuração você verá uma nova barra de scroll, como esta:

<a href="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image71.png" rel="lightbox"><img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; margin: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.azurewebsites.net/wp-content/uploads/2013/10/image_thumb71.png" width="244" height="176" /></a>

Sua barra agora contem um resumo de todo o código fonte do arquivo e ao mover o mouse sobre a barra, você verá uma prévia do código fonte.

É isto aí pessoal, espero que as dicas sejam úteis e que todos comecem a utilizar o novo Visual Studio 2013.

Abraços e até a próxima,  
Carlos dos Santos.
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

**Peek Definition (ALT F12)**

Imagine que você está escrevendo um método qualquer e precisa verificar um método que está em outra classe, normalmente você pressionar o F2 e olha a classe, e depois volta para o seu código. Isto é bem funcional, mas tira o foco do código que você está trabalhando. Agora no Visual Studio 2013, você tem o Peek Definition, que é acionado pela tecla ALT + F12, onde o código é mostrado para você na mesma janela, em cima do método.

Eu criei um projeto bem simples, com Entity Framework 6 acessando o banco de dados NorthWind e neste projeto tem um método RetornaClientes() que simplesmente volta uma lista de clientes (A idéia aqui não é focar na funcionalidade do projeto e sim na IDE). 

Veja o código abaixo:

![]( wp-content/uploads/2013/10/image8.png)

Agora, com o mouse em cima do método RetornaClientes, pressione **ALT F12**:

![]( wp-content/uploads/2013/10/image12.png)

É muito simples, agora você está vendo o código do método RetornaClientes() na mesma janela que estava trabalhando. E você pode pressionar o ALT F12 dentro desta janela também e ir navegando pelos códigos, sem precisar ficar alternando entre duas ou mais janelas.

**Code Lens**

Este é um recurso também muito útil, principalmente se você está trabalhando em um código de que você não conhece bem, mas como assim: quantas vezes você já precisou fazer uma busca no código para localizar a utilização de uma propriedade ou um método ? Quase sempre eu imagino! Isto toma muito tempo e abaca deixando um monte de janelas abertas na sua IDE.

O Code Lens pode te ajudar muito nisto. A idéia básica é que para cada classe, propriedade ou método, você tem uma referência logo acima do nome que indica quantas vezes ele está referenciado,ou seja, quem está utilizando esta classe, propriedade ou método.

Veja no mesmo exemplo, onde temos o Entity Framework referenciando o banco de dados NorthWind, ao abrirmos o código fonte da classe NortwindContext.cs, temos o Code Lens acima dos nomes, veja:

![]( wp-content/uploads/2013/10/image22.png)

Isto quer dizer, por exemplo, que a classe NortwindContext está sendo referenciada 5 vezes. E ao clicar sobre o número:

![]( wp-content/uploads/2013/10/image32.png)

E ao passar o mouse sobre as referências, você consegue ver em que parte do código fonte ele está sendo usado:

![]( wp-content/uploads/2013/10/image42.png)

Sem dúvida um recurso muito útil e que vai deixar o seu dia ainda mais produtivo.

**Nova Scroll Bar**

Agora você pode configurar a barra de scroll do seu editor de código para deixá-la mais interessante do que apenas rolar o código. Podemos transformar a barra do scroll em um visualizador de códigos que pode facilitar a navegação pelas linhas do seu programa.

Para ativarmos este recurso, basta clicar com o botão direito do mouse sobre a barra latera e escolher Scroll Bar Options:

![]( wp-content/uploads/2013/10/image51.png)

E depois é só configurar:

![]( wp-content/uploads/2013/10/image61.png)

Ative a opção “Show Preview Tooltip” e depois escolha o tamanho da barra de scroll. Após a configuração você verá uma nova barra de scroll, como esta:

![]( wp-content/uploads/2013/10/image71.png)

Sua barra agora contem um resumo de todo o código fonte do arquivo e ao mover o mouse sobre a barra, você verá uma prévia do código fonte.

É isto aí pessoal, espero que as dicas sejam úteis e que todos comecem a utilizar o novo Visual Studio 2013.

Abraços e até a próxima,  
Carlos dos Santos.
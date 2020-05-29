---
id: 10403
title: 'Injeção de Dependência em C# &#8211; Parte 1'
date: 2020-02-13T23:16:24-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10403
permalink: /2020/02/injecao-de-dependencia-em-c-parte-1/
image: /wp-content/uploads/2020/02/di-175x131.jpg
categories:
  - .Net
  - .Net Core
  - 'C#'
---
Olá,

Hoje em dia muito se tem se falado muito em injeção de dependência, principalmente se você desenvolve ou está começando a desenvolver com ASP.NET Core.

Mas que realmente significa "injetar" uma dependência e o que é a tal dependência?

<p style="font-size:23px">
  <strong>Conceito</strong>
</p>

Injeção de dependência é um padrão de projeto que permite baixo acoplamento do código!

Ai você se pergunta, mas o que é acoplamento do código? Sendo bem simplista, é um código que possui uma alta dependência de um outro código, onde o relacionamento entre os dois é muito forte!

Por exemplo, você tem uma classe de acesso a banco de dados como o código abaixo:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/86b89b388998ef0552233713bea23002">Gist</a>.
    </noscript>
  </div>
</div></figure> 

No exemplo acima este código só funciona com SqlConnection! Então se você precisar mudar de banco de dados, terá que reescrever o código.

Agora vamos a um exemplo com baixo acoplamento:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/d92f06727fbe5508893635f758a26d00">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Agora estamos implementando IDbConnection, que é a interface implementada pelo SqlConnection. Então temos um código desacoplado do banco, pois qualquer conexão que implemente IDbConnection poderá ser passada para nossa classe!

Este é o princípio da injeção de dependência!

<p style="font-size:23px">
  <strong>Um exemplo básico de injeção de dependência</strong>
</p>

Vamos escrever um código bem simples em C# para entendermos como este mecanismo da interface funciona!

Lembre-se que ao referenciar uma Interface você precisa implementar todos os seus métodos!

PS: Somente para tornar mais didático, vou colocar as classes e a interface em um único arquivo, mas em seu projeto coloque-os separadamente!<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/1d55134152920e9e1d3c7c3ac4436a88">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Muito bem, temos uma interface IServico que possui um método Executa()

Temos duas classes: ServicoCarro e ServicoMoto que implementam a interface IServico, cada uma resolvendo seu problema.

Agora vamos criar a classe executora, que receberá a interface:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/07117dd0eac59c14b6204ad9789648aa">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Veja que nossa classe recebe a interface e depois chama o método Executa(). Agora temos um desacoplamento, pois podemos passar para a classe qualquer objeto que implemente a interface, mudando o objeto a ser executado, sem modificar o nosso código!

Vejam a execução:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/44f9eab37a05fe52a856cbebbdee6aff">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Na execução estamos passando duas classes diferentes para o mesmo executor, chamando o mesmo método, pois ambas implementam a mesma interface!

<p style="font-size:23px">
  <strong>Mecanismos de injeção de dependência</strong>
</p>

Agora que você entendeu o princípio básico da injeção, deve estar pensando: O ASP.NET Core não faz isto e também no ASP.NET não era bem assim que se fazia! E você está certo! Este é o conceito!

O que se usa são os frameworks de injeção de dependência, que facilitam a vida para você, implementando este controle automaticamente.

Alguns dos frameworks mais conhecidos são:

  * NInject
  * SimpleInjector
  * Windsor

<p style="font-size:23px">
  <strong>Exemplo com NInject</strong>
</p>

Como o NInject é um dos mais conhecidos, vamos montar um exemplo com ele. A idéia é basicamente a mesma, teremos uma Interface e uma classe que implementa esta interface.

A grande diferença agora é que não precisamos mais instanciar a classe! Opa como assim!

Isto mesmo, o mecanisco de injeção de dependência, neste caso o NInject, fará isto para nós "magicamente"!

Vamos ao exemplo!

Eu criei um projeto console com .NET Core 3.1, mas você pode usar outra versão do .NET caso prefira!

Primeiro precisamos adicionar o pacote do NInject:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2020/02/image.png" alt="" class="wp-image-10408" srcset="http://carloscds.net/wp-content/uploads/2020/02/image.png 787w, http://carloscds.net/wp-content/uploads/2020/02/image-300x153.png 300w, http://carloscds.net/wp-content/uploads/2020/02/image-768x391.png 768w" sizes="(max-width: 787px) 100vw, 787px" /> </figure> 

Agora temos a Interface e a Classe:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/2a13608f0f9b00f061a39b3075ffe4f4">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Agora vamos implementar a classe executora:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/3f2a1f1fa2b1e2818d19341559628653">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Por fim, vamos implementar o NInject:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/952cba36cca6792052cfff182f5b077f">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Primeiro criamos o objeto "inject" que contém o mecanismo do NInject.

Depois informamos ao NInject quem será injetado, ou seja, toda vez que a interface IServico for utilizada a classe MeuServico será criada e passada!

No construtor da classe executora nós colocamos a interface:

 _public ExecutaDI(IServico servico)_ 

Por último criamos a instância da classe executora e chamamos o método:

_var obj = inject.Get<ExecutaDI>();  
obj.Executa();_

Neste caso quem instanciou o objeto foi o NInject quando chamamos o "Get".

Assim não precisamos nos preocupar com a criação dos objetos! 

Então o NInject "injeta" um objeto da classe MeuServico toda vez que encontra uma interface IServico.

<p style="font-size:23px">
  Conclusão
</p>

O injeção de dependência pode reduzir muito código da sua aplicação, deixando-a mais simples!

No próximo artigo vou mostrar o mecanismo de injeção de dependência do ASP.NET Core, que é simplesmente fantástico!

Os exemplos estão no meu Git: <https://github.com/carloscds/CSharpSamples> 

[Veja a segunda parte desta série!](http://carloscds.net/2020/02/injecao-de-dependencia-em-c-parte-2/)

Abraços e até a próxima!
---
id: 10414
title: 'Injeção de Dependência em C# – Parte 2'
date: 2020-02-25T01:10:29-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10414
permalink: /2020/02/injecao-de-dependencia-em-c-parte-2/
image: /wp-content/uploads/2020/02/Dependency-Injection-ASP.NET-Core-175x131.png
categories:
  - .Net Core
  - Asp.Net
  - 'C#'
---
Na [parte 1 desta série](http://carloscds.net/2020/02/injecao-de-dependencia-em-c-parte-1/) falamos sobre como funciona a injeção de dependência e até criamos um exemplo usando NInject. um famoso mecanismo de DI (depency injection).

Neste artigo vamos falar como o ASP.NET Core revolucionou a injeção de dependência, incorporando este mecanismo ao seu núcleo. Isto significa que agora já temos o mecanismo nativamente implementado, sem a necessidade de uma ferramenta de terceiros.

Uma outra coisa interessante sobre este mecanismo no ASP.NET Core é que ele ficou muito mais simples e dinâmico, tornando o código mais legível.

<p style="font-size:23px">
  <strong>Alguns conceitos importantes</strong>
</p>

Injetar dependências significa que podemos ter acesso a um objeto sem, necessariamente, instanciar diretamente este objeto, e também compartilhar a mesma instância deste objeto dentro de uma chamada (Request). Quem irá instanciar e gerenciar o objeto para nós é o mecanismo de injeção de dependência do ASP.NET Core. Confuso??? Pera, vamos melhorar um pouco!

Ter acesso a um objeto gerenciado pelo mecanismo de injeção significa que deixamos por conta dele a criação e destruição deste objeto e nos preocupamos apenas em consumi-lo.

E o que significa isto? É simples, iremos "indicar" o objeto e receberemos a instância deste objeto dentro da classe onde vamos utilizá-lo. 

E para esclarecer, uma chamada (request) é cada vez que você aciona algo dentro da sua aplicacão, ou seja, cada POST, GET, PUT, DELETE que é executado. 

Ok, então eu digo ao ASP.NET Core para criar e apagar meus objetos? Como ele faz isto?

<p style="font-size:23px">
  <strong>Tipos de injeção de Dependência do ASP.NET Core</strong>
</p>

Existem três maneiras diferentes do ASP.NET Core criar e manter objetos na injeç!ao de dependência:

  * Transient
  * Scoped
  * Singleton

**Transient**  
A cada chamada todos os objetos são criados novamente, ou seja, cada vez que chamamos a nossa aplicação, tudo é instanciado de novo, nenhum estado é mantido.

**Scoped**  
Os objetos são compartilhados dentro de uma mesma chamada, ou seja, todas as instâncias do objeto serão mantidas enquanto durar a chamada. Isto significa que se você usa um mesmo objeto em vários momentos do código, dentro de um mesmo fluxo de chamada, este objeto poderá manter a mesma instância.

**Singleton**  
Os objetos serão compartilhados por todas a aplicação, independente da chamada, ou seja, sempre iremos acessar o mesmo objeto, incusive independente do usuário. Então cuidado com isto!

<p style="font-size:23px">
  <strong>Vamos a um exemplo prático</strong>!
</p>

Iremos criar uma aplicação ASP.NET Core API usando o .NET Core 3.1 (o mesmo pode ser feito com uma asplicação MVC). 

Então para tornar o exemplo bem simples, vou criar uma interface chamada _IServico_ com um método _RetornaValor()_. Vou criar também uma classe chamada _Servico_, que irá implementar esta interface: <figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/a64690e534d97e363f6f62dcc37434b1">Gist</a>.
    </noscript>
  </div>
</div></figure> 

E agora a implementação da classe Servico.cs:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/0d13a30ba6d22fd25b14365bed8cfd2e">Gist</a>.
    </noscript>
  </div>
</div></figure> 

A idéia é mostrarmos o valor do "contador" de acordo com o tipo de dependência.

Agora imagine que esta classe _Servico_ esteja sendo utilizada em várias partes da aplicação, e que dentro de uma mesma chamada, você irá acessar dados desta classe mais de uma vez.

Para exemplificar isto, vou criar uma classe _ExecutaServico_, que também irá usar a classe _Servico_, mas receberá esta classe por injeção de dependência, veja:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/548cc74576a793c9c9dcb141943e8053">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Este classe recebe uma interface _IServico_ no seu construtor, que é atribuída a uma variável e depois chamada no método _RetornaServicoExecutado()_.

O mecanismo de injeção de dependência se encarregará de criar o objeto e passar para o construtor da classe.

Agora vamos colocar o código na nossa controller Home:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/88bd15785dbd5a670255701b876c825d">Gist</a>.
    </noscript>
  </div>
</div></figure> 

A nossa controller recebe dois objetos por injeção: _IServico_ e ExecutaServico, mas a classe _ExecutaServico_ também recebe um _IServico_. Isto quer dizer que temos dois locais na nossa aplicação exemplo que usam o objeto _Servico_.

Para você entender melhor, veja que o construtor da classe recebe as instâncias (variáveis _servico_ e _executaServico_) e estas são armazenadas em variáveis dentro da própria classe _(_servico_ e __executaServico_), no construtor. Quem instancia e passa estes parâmetros é o mecanismo de injeção de dependência.

<p style="font-size:23px">
  <strong>Agora vamos configurar a injeção de dependência</strong>
</p>

Um projeto ASP.NET Core possui uma classe chamada **Startup.cs**, e é nela que fazemos as configurações da nossa aplicação, incluindo a injeção de dependência. Nesta classe existe o método **ConfigureServices()**, onde fazemos estas configurações.

Vale lembrar também que existe um objeto Configuration na nossa aplicação ASP.NET Core, que traz os dados do arquivo "appsettings.json" por injeção de dependência, ou seja, em qualquer classe que você colocar o IConfiguration, terá acesso as estas configurações.

Seguindo com o exemplo, vamos primeiro colocar a injeção de dependência como "Transient":<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/8b5066d01c6b9a9133d51887f668319d">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Ao executar a nossa aplicação pela primeira vez temos o seguinte resultado:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2020/02/image-1.png" alt="" class="wp-image-10415" srcset="http://carloscds.net/wp-content/uploads/2020/02/image-1.png 406w, http://carloscds.net/wp-content/uploads/2020/02/image-1-300x116.png 300w" sizes="(max-width: 406px) 100vw, 406px" /> </figure> 

Veja que temos o mesmo resultado tanto para "Serviço", quanto para "ExecutaServico", isto porque o "Transient" diz para instanciar todos os objetos na chamada, então temos DUAS instâncias de Servico()

Agora vamos mudar para "Scoped":<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/2e172e64ed98c0678345d753c7a316fc">Gist</a>.
    </noscript>
  </div>
</div></figure> 

E novamente vamos executar a aplicação:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2020/02/image-2.png" alt="" class="wp-image-10416" srcset="http://carloscds.net/wp-content/uploads/2020/02/image-2.png 387w, http://carloscds.net/wp-content/uploads/2020/02/image-2-300x115.png 300w" sizes="(max-width: 387px) 100vw, 387px" /> </figure> 

Agora temos dois valores diferentes, porque se trata do mesmo objeto durante a chamada, ou seja, é a mesma classe Servico(), uma única instância! Assim no primeiro retorno o valor é 1 e no segundo é 2, pois o contador foi incrementado.

Por fim, vamos colocar o Singleton:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/3a23ae91925768ac5220441b14a163a2">Gist</a>.
    </noscript>
  </div>
</div></figure> 

E vamos executar novamente:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2020/02/image-3.png" alt="" class="wp-image-10417" srcset="http://carloscds.net/wp-content/uploads/2020/02/image-3.png 396w, http://carloscds.net/wp-content/uploads/2020/02/image-3-300x114.png 300w" sizes="(max-width: 396px) 100vw, 396px" /> </figure> 

A primeira execução é igual ao Scoped, mas veja a segunda:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2020/02/image-4.png" alt="" class="wp-image-10418" srcset="http://carloscds.net/wp-content/uploads/2020/02/image-4.png 390w, http://carloscds.net/wp-content/uploads/2020/02/image-4-300x118.png 300w" sizes="(max-width: 390px) 100vw, 390px" /> </figure> 

O valores continuam mudando, pois a instância agora é para TODAS as chamadas da aplicação, e isto independente do usuário ou browser. Veja uma chamada de outro browser:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2020/02/image-5.png" alt="" class="wp-image-10419" srcset="http://carloscds.net/wp-content/uploads/2020/02/image-5.png 371w, http://carloscds.net/wp-content/uploads/2020/02/image-5-300x120.png 300w" sizes="(max-width: 371px) 100vw, 371px" /> </figure> 

O valores vão mudando a cada chamada, pois o Singleton diz que "existirá" somente um objeto e ele será público para toda a aplicação.

<p style="font-size:23px">
  <strong>Conclusão</strong>
</p>

O tipo de injeção de dependência ue você irá usar depende do tempo de vida do seu objeto, por exemplo:

  * Se você nao precisa manter o estado do objeto, use TRANSIENT
  * Se precisa compatilhar dados dentro da mesma chamada, use SCOPED
  * E se precisar manter os "mesmos" dados durante toda a aplicação, use SINGLETON.

Espero ter ajudado a entender um pouco mais deste fantástico mecanismo!

Como sempre, o código do exemplo está no meu [Github](https://github.com/carloscds/CSharpSamples/tree/master/InjecaoDependenciaASPNETCore).

[Veja a teceira parte desta série!](http://carloscds.net/2020/02/injecao-de-depenencia-em-c-bonus/)

Abraços e até a próxima!
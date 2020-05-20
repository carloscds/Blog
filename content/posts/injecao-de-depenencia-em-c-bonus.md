---
id: 10426
title: 'Injeção de Dependência em C# - Bônus'
date: 2020-02-27
author: carloscds
layout: post
categories:
  - .Net Core
  - Asp.Net
  - 'C#'
  - EntityFramework Core
---
No último artigo desta série, vou mostrar duas coisas bem simples: primeiro como usar o EntityFramework Core em memória e como invocar uma dependência injetada sem usar o construtor da classe!

Mas porque você não iria injetar a dependência no construtor, como eu mostrei nos artigos anteriores? Bom, as vezes é necessário usarmos mecanismo alternativos para simplificar o desenvolvimento e termos acesso aos objetos!!!

<p style="font-size:23px">
  <strong>EntityFramework Core</strong>
</p>

Durante muitos anos eu escrevi sobre EF, mas como houve um atraso muito grande no desenvolvimento do EF Core, eu acabei utilizando outros ORMs em projetos. Mas agora o EF Core está bem interessante e voltei a utilizá-lo em um projeto bem grande!

Assim, resolvi complementar esta série mostrando um recurso extremamente útil do EF Core que é o banco de dados em memória.

Mas porque tão util? Bem imagino que você desenvolva usando um banco de dados de &#8220;desenvolvimento&#8221; ou até mesmo local na sua máquina, o que é perfeitamente normal, mas com o tempo este banco pode ficar &#8220;sujo&#8221; ou com dados &#8220;viciados&#8221;, aí temos que limpar e começar tudo de novo.

Pense então que você pode manter um banco inteiro em memória, realizando as mesmas operações que faria no banco normal, mas sem gravar nada em lugar algum, a não ser na memória.

Este recurso é muito valioso para testes unitários, e eu espero realmente que você esteja escrevendo testes hein!!!

_Para este exemplo vamos criar um projeto ASP.NET Core WebAPI._ 

<p style="font-size:23px">
  <strong>Criando o Contexto do EF Core</strong>
</p>

A primeira coisa que faremos será criar uma classe (tabela) e o contexto do Entity. Teremos uma classe simples de _Cliente_:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/d224f094c8470ce181b87a291b967a5d">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Agora vamos ao contexto:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/47565a0bd42ead503848fdf2ad8e81d4">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Nosso contexto não tem nada demais, a não ser um método SeedData() que estou usando para preencher a classe _Cliente_ em memória.

Lembre-se que estou usando um banco em memória, então para ter dados, preciso preencher este banco quando inicializo o contexto!

<p style="font-size:23px">
  <strong>Configurando o Startup.cs</strong>
</p>

Agora vamos configurar os serviços na classe Startup:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/583f0053d807d2597b2c81c3e352c8c5">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Veja que estamos adicionando um contexto com a opção &#8220;UseInMemoryDataBase()&#8221;

Para utilizar este método você vai precisar dos seguintes pacotes do Entity:

**Microsoft.EntityFrameworkCore  
Microsoft.EntityFrameworkCore.InMemory**

O pacote InMemory é o responsável por permitir o banco de dados em memória. Veja que você pode simplesmente trocar o &#8220;UseInMemoryDataBase()&#8221; por &#8220;UseSqlServer()&#8221; ou qualquer outro banco e tudo continua funcionando!

Quando eu escrevo testes unitários, crio um contexto InMemory() e na aplicação real uso um banco de dados! Isto facilita muito o meu trabalho!

Então estamos injetando um contexto de EntityFramework no nosso projeto através do _AddDbContext()_ , e também duas outras classes: _IHttpContextAccessor_ e _IEnvioEmail_, usando Singleton e Scoped, que mostrei no [artigo anterior](http://carloscds.net/2020/02/injecao-de-dependencia-em-c-parte-2/).

O IHttpContextAccessor nos permite acessar o contexto Http do ASP.NET Core em qualquer lugar onde ele for injetado e o _IEnvioEmail_ é uma classe exemplo que criei para simular o envio de email.

Veja aqui a interface _IEnvioEmail_ e a classe _EnvioEmail_:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/d5d758d937cf41c021a9abc81aa53ae2">Gist</a>.
    </noscript>
  </div>
</div></figure> <figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/046ded779d61c59c972898af046a7fc7">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Esta classe apenas &#8220;simula&#8221; o envio de um email, imagino que você irá implementar uma classe real para isto!

<p style="font-size:23px">
  <strong>Trabalhando a injecão na Controller</strong>
</p>

Agora que temos o nosso ambiente montado, vamos a criar uma controller para trabalhar estes dados. Iremos criar a _ClienteController.cs_ que terá duas actions: _Get()_ para trazer todos os clientes e _Email()_ para &#8220;simular o envio de email.

Vamos ao código:<figure class="wp-block-embed">

<div class="wp-block-embed__wrapper">
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/fe20c63aee0a89ba256a598fdacfbb6c">Gist</a>.
    </noscript>
  </div>
</div></figure> 

Muito bem, temos muitas coisas acontecendo aqui e vamos explicá-las:

No construtor da Controller estamos recebendo alguns objetos por injeção:

_ILogger logger_ &#8211; log do ASP.NET Core  
_AplicacaoContext db_ = nosso contexto do Entity Framework  
_IHttpContextAccessor_ httpContextAccessor = HttpContext da aplicação

Todos estão atribuídos a variáveis dentro da controller. Então vamos aos métodos que nos interessam.

O método _Get()_ simplesmente retorna todos os clientes do banco, que no nosso caso estão na memória apenas!

O outro método, _Email()_, é o que vamos mostrar a &#8220;invocação&#8221; de uma dependência sem o contrutor.

<p style="font-size:23px">
  <strong>Entendendo o cenário</strong>
</p>

Isto é mais comum do que você pensa! Neste nosso projeto, precisamos enviar um email e a classe email está na injeção de dependência (configuramos no Startup.cs), mas não colocamos no construtor da controller pois é um método pouco usado e não justifica neste caso, hipoteticamente! Ou ela simplesmente está &#8220;injetada dentro de uma outra classe, o que é mais comum ainda! De qualaquer maneira, não temos esta classe diretamente disponível.

Sendo assim, vamos &#8220;materializar&#8221; o objeto, buscando-o no injetor de dependências, veja como é simples:

_var email = _httpContextAccessor.HttpContext.RequestServices.GetService<IEnvioEmail>();_

Vamos entender:  
__httpContextAccessor_ é o contexto Http da aplicação, que tem o _HttpContext_ e o _Request_, que é a requisição para a página.

Usamos o _RequestServices.GetServices<IEnvioEmail>()_ que basicamente &#8220;pede&#8221; para o injetor de dependências nos &#8220;dar&#8221; o objeto correspondente a interface _IEnvioEmail_.

Isto é muito legal, pois você está &#8220;injetando&#8221; um objeto na mão, ou seja, está pegando um objeto que já está criado e trazendo para a variável &#8220;_email_&#8220;.

E agora é só usar o email!

Executando a aplicação teremos o seguinte resultado:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2020/02/image-6.png" alt="" class="wp-image-10427" srcset="http://carloscds.net/wp-content/uploads/2020/02/image-6.png 366w, http://carloscds.net/wp-content/uploads/2020/02/image-6-225x300.png 225w" sizes="(max-width: 366px) 100vw, 366px" /> </figure> 

Agora chamando o email:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2020/02/image-7.png" alt="" class="wp-image-10428" srcset="http://carloscds.net/wp-content/uploads/2020/02/image-7.png 438w, http://carloscds.net/wp-content/uploads/2020/02/image-7-300x147.png 300w" sizes="(max-width: 438px) 100vw, 438px" /> </figure> 

<p style="font-size:23px">
  <strong>Conclusão</strong>
</p>

O mecanismo de injeção de dependência nos permite simplificar muito o desenvolvimento! Mas use com cuidado, pois tudo em excesso é prejudicial!

Um agradecimento especial ao meu amigo [Rafael Almeida](http://ralms.net/), com quem &#8220;discuto&#8221; frequentemente sobre EntityFramework!!! Alias estas discussões ja geraram melhorias no EF Core, como por exemplo &#8220;WithNoLock()&#8221;.

Como sempre, o código do exemplo está no meu [Github](https://github.com/carloscds/CSharpSamples/tree/master/InjecaoDependenciaDiretaEF). 

Abraços e até a próxima!
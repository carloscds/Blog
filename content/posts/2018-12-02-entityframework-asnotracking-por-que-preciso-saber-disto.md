---
id: 10248
title: 'EntityFramework asNoTracking &#8211; Por que preciso saber disto ?'
date: 2018-12-02T19:05:49-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10248
permalink: /2018/12/entityframework-asnotracking-por-que-preciso-saber-disto/
image: /wp-content/uploads/2018/12/AsNoTracking-175x131.jpg
categories:
  - Entity Framework
---
Fala pessoal,

Esta semana me deparei com um problema em um cliente que é bem comum, e causa muito transtorno, pois envolve muito o conceito de como o EF trabalha.

Quando você cria um contexto para o EF e indica as classes do mapeamento, basicamente diz a ele que todos os objetos deverão ser rastreados, ou seja, o simples fato de você criar um objeto ou ler a partir do contexto, coloca este objeto sobre o controle do EF.

**Vamos considerar o seguinte contexto:**

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/21e3031092a6b09aa0421ec8beb88907">Gist</a>.
  </noscript>
</div>

Agora vamos simular uma injeção de dependência, onde temos uma classe Dados que recebe o contexto:

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/89f79b8892dcc291fe9155a1cd218ddb">Gist</a>.
  </noscript>
</div>

Vamos lembrar que o princípio básico da injeção de dependência é a propagação do objeto, neste caso temos apenas um Contexto, que é utilizado por todas classes através do mecanismo de injeção!

Vamos agora consultar o banco e trazer uma categoria:

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/f8307cf42a1067450c57ff9031bec3b2">Gist</a>.
  </noscript>
</div>

A partir deste momento o objeto "cat" faz parte do mapeamento do EF, ou seja, ele irá fazer o tracker deste objeto, ou seja, controlar o status deste objeto perante o EF (novo, modificado, deletado, etc). Bom, até aí tudo bem, pois é exatamente isto que esperamos que ele faça.

O problema começa quando instanciamos outros objetos, lembrando que estamos em uma ambiente de injeção de dependência. Vamos então realizar uma nova consulta e também vamos listar os objetos que estão no tracker do EF:

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/865d10eca6a9e7090cd9c6ed7a4c7f62">Gist</a>.
  </noscript>
</div>

Ao executar este código temos o seguinte resultado:

_Beverages_  
_System.Data.Entity.DynamicProxies.Categories_58C84246D9EE9DEB30950140620833728474B6132D2BC59BD4306359B33CE2A1, Modified_  
_System.Data.Entity.DynamicProxies.Categories_58C84246D9EE9DEB30950140620833728474B6132D2BC59BD4306359B33CE2A1, Unchanged_

Isto indica que o EF está mapeando os dois objetos, mesmo eles tendo sido consultados em diferentes instâncias da classe Dados, pois compartilham o mesmo contexto.

Sendo assim, se enviarmos um comando SaveChanges() e tivermos mudados os dois objetos, mesmo "sem querer", este serão enviados para o banco!

**E como resolvemos isto ???**

Exitem várias maneiras de resolvermos, e talvez a primeira que vem a sua cabeça é "vamos instanciar outro contexto", mas se eu fizer isto, qual o benefício da injeção de dependência neste caso ?

Para este tipo de situação temos o método "AsNoTracking()", que em termos bem simples diz ao contexto para não mapear o objeto!

Então vamos criar um outro método GetNoTracking() implementando esta chamada:

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/78401114238446cce2347c7a0b8da8d0">Gist</a>.
  </noscript>
</div>

Veja que somente adicionamos o AsNoTracking() após o objeto na consulta!

Agora vamos mudar a chamada do primeiro objecto, que neste exemplo é somente para leitura, ou seja, não iremos modificar nada nele:

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/5d0a62e9607d60d83e3b963b6a767ca1">Gist</a>.
  </noscript>
</div>

Executando novamente o código teremos um resultado diferente, ou seja, somente um objeto está mapeado pelo EF:

_Beverages_  
_System.Data.Entity.DynamicProxies.Categories_58C84246D9EE9DEB30950140620833728474B6132D2BC59BD4306359B33CE2A1, Modified_

**Resumindo:**

Se você está apenas consultando um objeto no EF, ou seja, não vai modificar e gravar, use AsNoTracking() sempre que possível.

Isto não quer dizer que você não possa instanciar outro contexto, mas evitar isto pode lhe dar um ganho de performance!

O código fonte esta no meu GitHub: <https://github.com/carloscds/CSharpSamples/tree/master/EFAsNoTracking>

E isto aí pessoal e até a próxima!  
Carlos dos Santos.
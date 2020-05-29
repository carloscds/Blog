---
id: 29
title: 'Programação Paralela com C# 4.0'
date: 2009-11-03T13:09:45-03:00
author: carloscds
layout: post
guid: /post/2009/11/03/Programacao-Paralela-com-C-40.aspx
permalink: /2009/11/programacao-paralela-com-c-4-0/
categories:
  - 'C#'
  - Visual Studio
tags:
  - 'msdn;c#'
---
Uma das novidades do .Net Framework 4.0 é a programação paralela, ou paralelelismo, que consiste em se utilizar os vários núcleos disponíveis nos computadores atuais, por exemplo, os famosos Core 2 Duo.

Mas como tirar proveito destes recursos em operações simples ? O que vou mostrar agora é como transformar dois comandos simples da linguagem C# com o uso da programação paralela.

Primeiramente vou montar um laço for tradicional:

<div style="font-family: consolas; background: white; color: black; font-size: 10pt;">
  <p style="margin: 0px;">
    <span style="color: #2b91af;">1</span> <span style="color: blue;">for</span> (<span style="color: blue;">int</span> i = <span style="color: red;"></span>; i < <span style="color: red;">100</span>; i++)
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">2</span>             {
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">3</span>                 <span style="color: #2b91af;">Console</span>.WriteLine(<span style="color: blue;">"Contador: {0}"</span>, i);
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">4</span>             }
  </p>
</div>

Agora o mesmo for com progamação paralela:

<div style="font-family: consolas; background: white; color: black; font-size: 10pt;">
  <p style="margin: 0px;">
    <span style="color: #2b91af;">1</span> <span style="color: #2b91af;">Parallel</span>.For(<span style="color: red;"></span>, <span style="color: red;">100</span>, <span style="color: blue;">delegate</span>(<span style="color: blue;">int</span> i)
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">2</span>             {
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">3</span>                 <span style="color: #2b91af;">Console</span>.WriteLine(<span style="color: blue;">"Contador: {0}"</span>, i);
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">4</span>             });
  </p>
</div>

Vejam como é simples, basta usar Parallel.For() no lugar de for().

Agora vamos fazer um exemplo com ForEach, primeiro no modo tradicional:

<div style="font-family: consolas; background: white; color: black; font-size: 10pt;">
  <p style="margin: 0px;">
    <span style="color: #2b91af;">1</span> <span style="color: #2b91af;">List</span><<span style="color: blue;">string</span>> lista = <span style="color: blue;">new</span> <span style="color: #2b91af;">List</span><<span style="color: blue;">string</span>>() { <span style="color: blue;">"Carlos"</span>, <span style="color: blue;">"Leandro"</span>, <span style="color: blue;">"João"</span>, <span style="color: blue;">"Maria"</span> };
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">2</span> 
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">3</span>             <span style="color: blue;">foreach</span> (<span style="color: blue;">string</span> nome <span style="color: blue;">in</span> lista)
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">4</span>             {
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">5</span>                 <span style="color: #2b91af;">Console</span>.WriteLine(<span style="color: blue;">"Nome: {0}"</span>, nome);
  </p>
  
  <p style="margin: 0px;">
    <span style="color: #2b91af;">6</span>             }
  </p>
  
  <p style="margin: 0px;">
     
  </p>
  
  <p style="margin: 0px;">
    Agora com programa paralela:
  </p>
  
  <p style="margin: 0px;">
     
  </p>
  
  <div style="font-family: consolas; background: white; color: black; font-size: 10pt;">
    <p style="margin: 0px;">
      <span style="color: #2b91af;">1</span>             <span style="color: #2b91af;">Parallel</span>.ForEach<<span style="color: blue;">string</span>>(lista, (nome) =>
    </p>
    
    <p style="margin: 0px;">
      <span style="color: #2b91af;">2</span>             {
    </p>
    
    <p style="margin: 0px;">
      <span style="color: #2b91af;">3</span>                 <span style="color: #2b91af;">Console</span>.WriteLine(<span style="color: blue;">"Nome: {0}"</span>, nome);
    </p>
    
    <p style="margin: 0px;">
      <span style="color: #2b91af;">4</span>             });
    </p>
    
    <p style="margin: 0px;">
      <span style="color: #2b91af;">5</span> 
    </p>
  </div>
</div>

Novamente, basta trocar o foreach() por Parallel.ForEach().

Veja que nos dois exemplo de programação paralela, foram usados delegates() para criar a iteração nos laços.

Bom, agora você está se perguntando: “Por quê vou trocar meu for/foreach por isto ?”, e a resposta é simples: **Performance**.

Imagine um laço com iterações bem pesadas, como diversos cálculos, você consegue executar várias operações simultaneamente, simplesmente trocando o tipo do laço.

Outro recurso interessantíssimo da programação paralela, são as janelas de Stacks e Tasks do Debug (Debug/Windows):

[<img style="display: inline; border: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/image_thumb_6.png" border="0" alt="image" width="231" height="244" />](http://carloscds.net/wp-content/uploads/image_6.png)

[<img style="display: inline; border: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/image_thumb_7.png" border="0" alt="image" width="636" height="75" />](http://carloscds.net/wp-content/uploads/image_7.png)

Com estas janelas você pode controlar toda a execução do código paralelo, como ver o que está em execução e o que está na fila para ser executado, entre outras coisas.

Resumindo, espero que estes simples exemplos tenham demonstrado o potencial e a simplicidade da programação paralela e além destes recursos que demonstrei aqui ainda existe vários outros da programação. Vale a pena conferir!

[]s,
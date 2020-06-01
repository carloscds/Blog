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

```csharp
for (int i = 0; i < 100; i++)
{
      Console.WriteLine(“Contador: {0}”, i);
}
```

Agora o mesmo for com progamação paralela:

```csharp
Parallel.For(0, 100, delegate(int i)
{
     Console.WriteLine(“Contador: {0}”, i);
});
```

Vejam como é simples, basta usar Parallel.For() no lugar de for().

Agora vamos fazer um exemplo com ForEach, primeiro no modo tradicional:

```csharp
List<string> lista = new List<string>() { “Carlos”, “Leandro”, “João”, “Maria” };

foreach (string nome in lista)
{
     Console.WriteLine(“Nome: {0}”, nome);
}
```
 
Agora com programa paralela:

```csharp 
Parallel.ForEach<string>(lista, (nome) =>
{
     Console.WriteLine(“Nome: {0}”, nome);
});
```

Novamente, basta trocar o foreach() por Parallel.ForEach().

Veja que nos dois exemplo de programação paralela, foram usados delegates() para criar a iteração nos laços.

Bom, agora você está se perguntando: “Por quê vou trocar meu for/foreach por isto ?”, e a resposta é simples: Performance.

Imagine um laço com iterações bem pesadas, como diversos cálculos, você consegue executar várias operações simultaneamente, simplesmente trocando o tipo do laço.

Outro recurso interessantíssimo da programação paralela, são as janelas de Stacks e Tasks do Debug (Debug/Windows):

![]( wp-content/uploads/image_thumb_6.png)

![]( wp-content/uploads/image_thumb_7.png)

Com estas janelas você pode controlar toda a execução do código paralelo, como ver o que está em execução e o que está na fila para ser executado, entre outras coisas.

Resumindo, espero que estes simples exemplos tenham demonstrado o potencial e a simplicidade da programação paralela e além destes recursos que demonstrei aqui ainda existe vários outros da programação. Vale a pena conferir!

[]s,
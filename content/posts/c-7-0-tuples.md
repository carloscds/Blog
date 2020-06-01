---
id: 8151
title: 'C# 7.0 - Tuples'
date: 2016-09-11T00:06:21-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=8151
permalink: /2016/09/c-7-0-tuples/
categories:
  - 'C#'
tags:
  - 'c#; tuple'
---
Olá pessoal,

Há algum tempo atrás eu publiquei um post falando sobre [Tuples em C#](http://carloscds.net/2011/02/usando-tuples-em-cretornando-vrios-parmetros-de-um-mtodo/), que é um recurso bem interessante para retorno de múltiplos valores, principalmente quando você não quer criar uma classe somente para isto.

Agora com o C# 7.0 (ainda em preview) as Tuplas ganharam novos recurso que facilitam ainda mais a sua utilização, agora podemos dar nomes aos elementos, faclitando ainda mais o nosso código. 

Para executarmos os exemplos você vai precisar baixar o [Visual Studio “15” Preview 4](https://www.visualstudio.com/en-us/news/releasenotes/vs15-relnotes). <u>Atenção</u>: se você ja tiver uma versão anterior deste Visual Studio, precisará removê-la antes de instalar o Preview 4.

O preview 4 é uma nova IDE, com novos recursos e um novo modelo de instalação, veja:

![]( wp-content/uploads/2016/09/image.png)

Você pode escolher o que achar interessante e depois clicar em “Install”. Esta instalação nos dá uma idéia do que esrá por vir, um modelo bem mais intuitivo de setup.

Depois de instalado o Visual Studio “15” Preview, vamos criar um projeto Console:

![]( wp-content/uploads/2016/09/image-1.png)

Inicialmente vou mostrar como estâo as tuplas hoje. Para isto vou criar um método que retorna vários parâmetros:

```csharp
class Program
{
  static void Main(string[] args)
  {
      var ret = BuscaNomeLimite(1);
      Console.WriteLine($"Nome: {ret.Item1} - Limite: {ret.Item2}");
  }

  static Tuple<string,decimal> BuscaNomeLimite(int ID)
  {
      return new Tuple<string, decimal>("Carlos",1000);
  }
}

```
Isto já facilita muito o desenvolvimento, principalmente quando você não quer criar uma classe para fazer isto, mas ao mesmo tempo gera um código um tanto confuso, pois os parâmetros sâo nomeados como Item1, Item2, etc.

Agora vamos ao C# 7 e ver como isto melhorou, e muito!!! Entâo vamos fazer um upgrade no nosso método usando a sintaxe nova, mas como ainda estamos em Preview, é necessário instalar o pacote <strong>System.ValueTuple</strong> usando o Nuget. Para isto clique com o botão direto no seu projeto e selecione “Manage Nuget Packages”, depois marque a opção “Include prerelease” e depois digite “tuple” na caixa de pesquisa:

![]( wp-content/uploads/2016/09/image-2.png)

Clique no botão Install e siga os passos! Pronto, agora vamos melhorar nosso código:

```csharp
static void Main(string[] args)
{
  var ret = BuscaNomeLimite(1);
  Console.WriteLine($"Nome: {ret.nome} - Limite: {ret.limite}");
}

static (string nome, decimal limite) BuscaNomeLimite(int ID)
{
  return ("Carlos", 1000);
}
```

Veja que com a nova sintaxe, você pode nomear os campos da Tupla, ou seja, pode usar nomes mais intuitivos e a sintaxe é bem simples. Basicamente você coloca os nomes e tipos entre parênteses, no mesmo local onde antes estava a Tuple<>:

![]( wp-content/uploads/2016/09/image-3.png)

E no retorno você coloca os valores, também entre parênteses, na mesma sequência da definição do médodo:

![]( wp-content/uploads/2016/09/image-4.png)

Você pode também nomear os parâmetros no retorno, para isto basta colocar o nome do parâmetro e dois pontos, seguido do valor de retorno:

![]( wp-content/uploads/2016/09/image-5.png)

Tuplas são um recurso muito legal do C#, e agora, com a nomeção dos campos, seu código vai ficar ainda mais simples de ser entendido!

Abraços e até a próxima!

Carlos dos Santos.
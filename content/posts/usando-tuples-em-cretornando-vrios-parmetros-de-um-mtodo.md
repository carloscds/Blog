---
id: 332
title: 'Usando Tuples em C#–retornando vários parâmetros de um método'
date: 2011-02-07T21:53:56-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2011/02/usando-tuples-em-cretornando-vrios-parmetros-de-um-mtodo/
permalink: /2011/02/usando-tuples-em-cretornando-vrios-parmetros-de-um-mtodo/
aktt_notify_twitter:
  - 'yes'
aktt_tweeted:
  - "1"
categories:
  - 'C#'
tags:
  - 'c#; msdn'
---
Olá pessoal,

Uma das coisas interessantes da linguagem C# é a quantidade de opções que temos para resolver o problemas do nosso dia a dia. Um caso interessante e bem comum é termos a necessidade de passar vários parâmetros para um método e às vezes também retornar vários parâmetros, e é bem provável que você se utilize de artifícios como parâmetros de saída (out) ou referência (ref).

Mas existe algo bem mais interessante, que são as tuplas (Tuples). Na prática uma tuple é um array de vários tipos de dados, que podem ser passados ou retornados por um método.

Vamos ao exemplo:

1. Crie um projeto Console no Visual Studio (no meu caso estou usando o 2010, mas você pode usar o 2008 também):

2. Vamos criar um método que retorne vários parâmetros e mostrar o use de Tuple:

```csharp
class Program
{
  static void Main(string[] args)
  {
      var retorno = RetornaVariosParametros();

      Console.WriteLine("Valor inteiro: {0}",retorno.Item1);
      Console.WriteLine("Valor String: {0}", retorno.Item2);
      Console.WriteLine("Valor Double: {0}", retorno.Item3);
  }

  public static Tuple<int,string,double> RetornaVariosParametros()
  {
      return Tuple.Create(10, "Tuple", 100.50);
  }
}
```

Veja como é simples: você usa uma Tuple<> identificando os tipos de dados que ela conterá e depois acessa cada valor através dos Items.

O exemplo é bem simples, mas demonstra a facilidade e a versatilidade das tuplas.

Mais referências sobre Tuple em http://msdn.microsoft.com/en-us/library/system.tuple.aspx

Um abraço e até a próxima.
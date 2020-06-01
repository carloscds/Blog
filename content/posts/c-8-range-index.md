---
id: 10283
title: 'C# 8 Range Index'
date: 2019-01-06T21:40:26-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10283
permalink: /2019/01/c-8-range-index/
image:  wp-content/uploads/2019/01/c8-175x119.png
categories:
  - 'C#'
tags:
  - 'c# 8'
---
No post anterior eu falei um pouco sobre o Visual Studio 2019 Preview, que alias, eu já estou utilizando para trabalhar em alguns projetos.

Juntamente com esta nova versão do Visual Studio, temos também o Preview do .NET Core 3 e do C# 8.

Neste post vamos criar um pequeno projeto Console e mostrar a funcionalidade chamada Range Index!

Antes de iniciarmos, vou criar o projeto exemplo no Visual Studio 2019 e configurar o C# para versão 8, veja abaixo:

![]( wp-content/uploads/2019/01/createproject.png)

![]( wp-content/uploads/2019/01/createproject1.png)

Depois de criamos o projeto, vamos configurar o .NET e a versão do C# para 8 beta. Entre em Project/Properties:

![]( wp-content/uploads/2019/01/consolec8.png)

![]( wp-content/uploads/2019/01/configc8-300x252.png) 

Agora que já temos nosso projeto Console, podemos iniciar os testes com o Range Index:

Com este novo recurso do C#, você pode navegar em um array qualquer, utilizando o indexador, mas isto já existe, certo ? Veja o exemplo abaixo:

```csharp
static void Main(string[] args)
{
   int[] num = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

   foreach(int i in num)
   {
      Console.WriteLine(i);
   }
}
```

A ideia agora é poder navegar dentro desta lista, mas utilizando qualquer ponto inicial ou final, veja o mesmo exemplo, agora com Range Index:

```csharp
static void Main(string[] args)
{
   int[] num = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

   foreach(int i in num[1..5])
   {
      Console.WriteLine(i);
   }
}
```

Veja que agora estamos navegando entre as posições 1 a 5, que se refere a sequência: 2,3,4,5.

Ok, mas vamos a um exemplo mais interessante, utilizando strings. Você provavelmente já se deparou com problemas do tipo ler uma parte de uma string, começando em uma posição e terminando em outra ? Isto é bem comum em leituras de arquivos TXT.

Lembrando que uma string é um array de char! Vejamos alguns exemplo com strings:

```csharp
string str = "Exemplo em C# 8";

string palavra = str[^4..^0];
Console.WriteLine(palavra);

string final = str[^4..];
Console.WriteLine(final);

string inicio = str[..7];
Console.WriteLine(inicio);
```

Vamos entender cada string:

No primeiro exemplo temos: **str[^4..^0]** &#8211; isto indica para iniciar o range 4 caracteres antes do final, até o final ^0, ou seja, retorne as 4 últimas letras da string.

No segundo exemplo temos: **str[^4..]** &#8211; que faz exatamente a mesma coisa do primeiro, pois suprimindo o final do index, indica que será tudo.

No terceiro exemplos temos:  **str[..7]** &#8211; que pega as 7 primeiras letras da string.

Executando o nosso exemplo, temos os seguintes resultados:

**C# 8**  
**C# 8**  
**Exemplo**

Você pode estar dizendo que isto faz o mesmo que o Substring(), e de fato faz, mas de uma maneira muito mais simples e poderosa!

É isto aí, espero que tenham gostado desta prévia do C# 8 que comecem a testar!!!

Este exemplo também está no meu Git: <https://github.com/carloscds/csharpsamples>

Abraços e até a próxima,  
Carlos dos Santos
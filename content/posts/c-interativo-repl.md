---
id: 7521
title: 'C# Interativo (REPL)'
date: 2016-04-02T20:34:24-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=7521
permalink: /2016/04/c-interativo-repl/
categories:
  - DotNet
  - C Sharp
  - Visual Studio
---
Alguma vez você já pensou em testar aquele trecho de código sem precisar compilar toda a solução ?

Acho que este é um sonho de vários desenvolvedores. Será que dá para executar só aquele “pedacinho” do código ? Normalmente você tem que executar o codigo todo e fazer um braek point e depois rodar o debug sem parar, ou mais ainda, quem de nós que nunca criou um programa console só para testar um trecho de código ?

Bom, para acabar com este sofrimento, o Visual Studio introduz uma funcionalidade de C# interativo ou REPL (read-eval-print-loop), como é também conhecido, e que nada mais é do que um shell de execução interativa para a linguagem.

Vamos a um exemplo prático, mas você precisa ter o Visual Studio [Update 1](https://www.visualstudio.com/pt-br/news/vs2015-update1-vs.aspx) ou [Update 2](https://www.visualstudio.com/en-us/news/vs2015-update2-vs.aspx), no meu caso estou com o Update 2.

Vou criar um programa Console em C# para trabalharmos com o exemplo, mas você pode executar em qualquer projeto C# ou VB:

![]( wp-content/uploads/2016/04/image6.png)

Após criar a solução, vamos abrir o console interativo:

![]( wp-content/uploads/2016/04/image7.png)

Feito isto, teremos o console na parte inferior da IDE do Visual Studio:

![]( wp-content/uploads/2016/04/image8.png)

Aqui podemos fazer várias coisas, como por exemplo escrever um código qualquer, que será executado imediatamente, por exemplo:

![]( wp-content/uploads/2016/04/image9.png)

Veja que eu criei uma lista e depois adicionei dois elementos. Ao final digitei “lista.Count” e o resultado está na tela! Simples assim!

Agora vamos imaginar que você já tenha um código e queira testá-lo no modo interativo. Mais simples ainda, basta selecionar o trecho do código e clicar com o botão direito do mouse, escolhendo a mesma opção “Execute in Interactive”:

![]( wp-content/uploads/2016/04/image10.png)

O resultado será a mesma janela do modo interativo, mas com o seu código carregado:

![]( wp-content/uploads/2016/04/image11.png)

Logicamente que códigos mais complexos também podem ser utilizados. Vamos então fazer um exemplo acessando um banco de dados de modo totalmente interativo:

***
> #r "System.Data.dll"  
> using System.Data.SqlClient;  
> var conexao = new SqlConnection("data source=(local); initial catalog=northwind; integrated security=true");  
> conexao.Open();  
> conexao.Database "northwind"  
> conexao.Close();  
>
*** 

Na primeira linha estamos carregando a DLL System.Data para o contexto do compilador interativo e após isto temos o código para se conectar no SQL e por fim estou apenas mostrando o nome do banco de dados.

Acredito que agora vocês estão imaginando as possibilidades!!!

PAra complementar, [neste link](https://github.com/dotnet/roslyn/wiki/Interactive-Window) tem um guia várias informações interessantes que podem complementar seu estudo!

Abraços e até a próxima,  
Carlos dos Santos.
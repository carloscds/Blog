---
id: 242
title: Verificar se um programa já está em execução
date: 2010-09-19T18:19:28-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2010/09/verificar-se-um-programa-j-est-em-execuo/
permalink: /2010/09/verificar-se-um-programa-j-est-em-execuo/
aktt_notify_twitter:
  - 'yes'
aktt_tweeted:
  - "1"
categories:
  - 'C#'
  - Visual Studio
tags:
  - 'msdn;c#'
---
Pessoal, neste post sobre C# básico, vou mostrar como identificar se um programa já está em execução. Vamos aproveitar também ver como listar todos os programas que estão em execução no computador.

Para começar, crie um projeto em C# do tipo Console Application e logo em seguida vamos modificar o program.cs conforme abaixo:

```csharp
static void Main(string[] args)
{
    string Processo = Process.GetCurrentProcess().ProcessName;
    if(Process.GetProcessesByName(Processo).Length > 1)
    {
        Console.WriteLine("Programa em execução");
        return;
    }
}
```

Veja que é bem simples, basicamente estamos verificando se o nosso processo (que é o programa), está na lista de processos em execução, e se estiver, mostramos uma mensagem e finalizamos o programa.

Podemos também transformar este código em uma função reutilizável, veja:

```csharp
static void Main(string[] args)
{
    if(VerificaProgramaEmExecucao())
    {
        Console.WriteLine("Programa em execução");
        return;
    }
    Console.WriteLine("Programa executando");
    Console.ReadKey();
}

public static bool VerificaProgramaEmExecucao()
{
    return Process.GetProcessesByName(Process.GetCurrentProcess().ProcessName).Length > 1;
}
```

Assim você simplesmente chama o método VerificaProgramaEmExecucao() e se ele retornar TRUE, o programa está ativo.

Para finalizar, vamos mostrar a lista de processos em execução:

```csharp
Console.WriteLine("Processos em execução");
Console.WriteLine("---------------------");
foreach(var proc in Process.GetProcesses())
{
   Console.WriteLine("{0} - {1}",proc.ProcessName,proc.Id);
}
```

No código acima, mostramos o nome do processo e o seu ID, mas se você observar a classe Proccess, verá que existem diversas propriedades e métodos que podem ser usados.

É isto aí pessoal, abraços e até a próxima.

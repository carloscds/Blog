---
id: 212
title: EFProfiler– Entity Framework Profiler
date: 2010-08-20T15:31:27-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2010/08/efprofiler-entity-framework-profiler/
permalink: /2010/08/efprofiler-entity-framework-profiler/
categories:
  - C Sharp
  - EntityFramework
tags:
  
---
Se você está trabalhando com EF4, provavelmente já se perguntou se os comandos SQL gerados estão realmente otimizados, ou talvez quando você tem algum problema de performance. Para responder a isto existem várias ferramentas de análise, ou profilers, e um destes é o EFProfiler.

A ferramenta é bastante simples, você baixa um executável do site [www.efprof.com](http://www.efprof.com) e segue as instruções contidas no arquivo “How to use.txt”.

Para o profiler funciona, você precisa adicionar a referência de um DLL do Profiler ao seu projeto: 

![]( wp-content/uploads/2010/08/image2.png)

Depois, no arquivo principal do projeto, você executa o inicializador do profiler:

```csharp
static void Main(string[] args)
{
    // Profiler
    HibernatingRhinos.Profiler.Appender.EntityFramework.EntityFrameworkProfiler.Initialize();

    TesteEntities dc = new TesteEntities();

    var dados = from c in dc.Cliente
                select c;
    foreach (var linha in dados)
    {
        Console.WriteLine(linha.Nome);
    }
}
```

No exemplo acima, temos uma simples consulta ao banco de dados.

Agora abra o profiler e execute sua aplicação, os resultados irão aparecer na tela:

![]( wp-content/uploads/2010/08/image_thumb4.png)

É isto aí pessoal, bom profiler para vocês!
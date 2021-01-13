---
id: 9643
title: Lendo uma Planilha Excel em C# - MAIS SIMPLES AINDA!
date: 2021-01-12T23:15:00-00:00
author: carloscds
layout: post
categories:
  - DotNet Core
  - C Sharp
tags:
  - publish
---
Olá pessoal,

Em 2009 eu escrevi um artigo que até hoje é muito acessado no meu blog, se trata de [como ler uma planilha Excel em C#](https://carloscds.net/2009/12/lendo-uma-planilha-do-excel-com-c). Claro que muita coisa mudou desde então, mas ainda hoje este código funciona e ajuda muita gente. 

Mas será que não dá para melhorar? Sempre dá...

# Vamos falar do ClosedXML

O componente ClosedXML pode ser encontrado no [Nuget](https://www.nuget.org/packages/ClosedXML/) e funciona tanto em aplicações .NET Framework, quanto .NET Core.

A idéia é a mesma do artigo anterior, você precisa ler uma planilha dentro do seu código em C#. Então vamos criar uma aplicação Console que irá ler todas as linhas e colunas de nossa planilha. 

Neste exemplo vou usar uma aplicação em .NET Core, mas você pode usar em outras versões do .NET conforme falei acima.

Este aplicação irá ler uma planilha Excel, conforme imagem abaixo:

![]( wp-content/uploads/2021/01/ExemploExcel.png)

# Criando a aplicação Exemplo:

Vamos fazer algo bem simples e funcional. Então primeiro criamos a aplicação Console:

```powershell
dotnet new console -o LerPlanilhaExcel
cd LerPlanilhaExcel
dotnet add package ClosedXML 
```
Os comandos acima criam o projeto e depois, dentro da pasta, adicionam o pacote do componente ClosedXML.

Se você está no Visual Studio, pode ir no Nuget Package Manager e procurar por **ClosedXML**.

# Lendo a Planilha em C#

```csharp
using System;
using System.Linq;
using ClosedXML.Excel;

namespace LerPlanilhaExcel
{
    class Program
    {
        static void Main(string[] args)
        {
           var xls = new XLWorkbook(@"C:\Temp\ExemploExcel.xlsx");
           var planilha = xls.Worksheets.First(w => w.Name == "Planilha1");
            var totalLinhas = planilha.Rows().Count();
            // primeira linha é o cabecalho
            for (int l = 2; l <= totalLinhas; l++)
            {
                var codigo = int.Parse(planilha.Cell($"A{l}").Value.ToString());
                var descricao  = planilha.Cell($"B{l}").Value.ToString();
                var preco = decimal.Parse(planilha.Cell($"C{l}").Value.ToString());
                Console.WriteLine($"{codigo} - {descricao} - {preco}");
            }
        }
    }
}
```

Veja como ficou mais simples manipular a planilha Excel. Primeiro você acessa o arquivo, identifica a planilha (Planilha1), depois percorre as linhas, acessando diretamente cada célula.

Veja que o campo código está nas células A1..A5, então nós simplesmente percorremos as linhas e pronto!

No meu exemplo eu percorri as linhas, mas você pode fazer algo do tipo:

```csharp

var codigoProduto1 = planilha.Cell("A2").Value.ToString();

```

Este componente permite também criar e modificar planilhas, então ele pode ser bastante útil em diversos tipos de projetos. Confira a documentação no [site do projeto](https://github.com/ClosedXML/ClosedXML).

# Concluindo

Vemos que agora existem componentes que facilitam ainda mais o nosso trabalho, como é o exemplo do ClosedXML. Então está na hora de dar aquela modernizada ou simplificada no seu código!

O fonte deste exemplo está no meu [GitHub](https://github.com/carloscds/CSharpSamples).

Abraços e até a próxima,  
Carlos dos Santos.

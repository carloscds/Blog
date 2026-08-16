---
title: 'Novidades do .NET 11 Preview 6 para quem já usa .NET 10 em produção'
date: 2026-08-16
author: carloscds
layout: post
categories:
  - C Sharp
  - ASPNET
---
Mais uma Preview do .NET saiu do forno! Se você lembra do post sobre o [ShortCircuit em Middlewares](/2026/07/shortcircuitaspnet/), aquele recurso já tinha chegado justamente nesta versão, a **Preview 6**. Agora vamos dar uma olhada geral no que mais veio junto, com foco no que interessa para quem trabalha com ASP.NET Core e Entity Framework Core no dia a dia.

### Runtime e Performance

O runtime ganhou melhorias no desempenho de código assíncrono, otimizações no JIT, um registro de erros mais detalhado melhorias significativas para quem publica com **NativeAOT**. 

### SDK e Ferramentas

O `dotnet test` ficou mais amigável, com saída melhorada e suporte a **xUnit v3** e **NUnit** de forma mais integrada. Outro detalhe interessante é a possibilidade de referenciar DLLs diretamente em aplicativos baseados em arquivo único:

```csharp
#:include ./libs/MinhaLib.dll
```

Além disso, o SDK já suporta NativeAOT via CLI de ponta a ponta, compilações multi-arquitetura usando **Podman** e integração com TypeScript via Static Web Assets.

### C#: Extension Indexers

A novidade que mais chamou minha atenção foi a introdução dos **extension indexers**. Até então, dava para criar métodos de extensão, propriedades de extensão, mas não um indexador. Agora sim:

```csharp
public static class ListaExtensions
{
    extension<T>(List<T> lista)
    {
        public T this[Index indice]
        {
            get => lista[indice.GetOffset(lista.Count)];
        }
    }
}
```

Repare que o indexador foi declarado dentro de um bloco `extension<T>(List<T> lista)`, e não como um método estático tradicional. Isso permite usá-lo exatamente como se fosse um indexador nativo do `List<T>`, inclusive aceitando `Index` (aquele `^1` que já usamos em arrays):

```csharp
var numeros = new List<int> { 10, 20, 30, 40, 50 };

Console.WriteLine(numeros[^1]); // 50 - último item usando Index
Console.WriteLine(numeros[2]);  // 30 - também funciona com int, pois Index tem conversão implícita
```

Sem o extension indexer, você precisaria escrever algo como `numeros.ElementAt(numeros.Count - 1)` ou criar uma classe derivada só para ganhar essa sintaxe. Agora dá para "estender" o comportamento de indexação direto em cima do `List<T>`, sem precisar tocar na classe original.

Isso abre espaço para deixar APIs de terceiros (que você não controla) muito mais fluentes, sem precisar criar um wrapper só para ganhar um `objeto[indice]`.

### ASP.NET Core

Aqui tem bastante coisa boa para quem usa **Minimal APIs**:

* **Validação assíncrona**: agora dá para validar o payload de forma assíncrona antes de chegar no handler, útil quando a validação depende de uma consulta ao banco ou a outro serviço;
* **Proteção automática contra CSRF**: menos boilerplate de configuração manual;
* **OpenAPI 3.2 por padrão**: os documentos gerados automaticamente já saem no formato mais novo da especificação;
* **Suporte a scroll no Blazor Virtualize**: melhora listas grandes renderizadas em componentes Blazor.

Um exemplo simples de validação assíncrona em Minimal API:

```csharp
app.MapPost("/pedidos", async (Pedido pedido, IValidator<Pedido> validator) =>
{
    var resultado = await validator.ValidateAsync(pedido);
    if (!resultado.IsValid)
        return Results.ValidationProblem(resultado.ToDictionary());

    return Results.Ok(pedido);
});
```

### Entity Framework Core

O EF Core seguiu evoluindo a tradução de LINQ, agora conseguindo percorrer propriedades de **tipos complexos** dentro de chaves e índices, e passou a suportar relacionamentos de chave estrangeira **sem restrição** (útil em cenários de integração com bancos legados, onde nem sempre dá para criar a FK "de verdade").

### .NET MAUI

Para quem trabalha com apps mobile: o **CollectionView2** chegou ao Windows, o Android ganhou uma arquitetura Shell baseada em handlers, o **HybridWebView** agora é seguro para uso com NativeAOT, e a geolocalização passou a suportar filtro de distância mínima entre atualizações.

### Containers

Quem publica em Docker/Kubernetes ganha imagens **Azure Linux 4.0** e imagens de SDK com NativeAOT ainda menores, o que ajuda bastante em tempo de cold start e tamanho final da imagem.

### Considerações

Como sempre em uma Preview, vale testar em ambiente de desenvolvimento antes de considerar qualquer coisa para produção. Mas olhando o conjunto — extension indexers, validação assíncrona em Minimal APIs e as melhorias no EF Core — dá para perceber que o time está deixando o dia a dia de quem já migrou para .NET 10 cada vez mais produtivo, preparando terreno para o próximo LTS.

Abraços e até a próxima!

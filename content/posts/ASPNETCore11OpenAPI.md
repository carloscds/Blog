---
title: 'OpenAPI no ASP.NET Core 11: APIs obsoletas e ambientes de geração'
date: 2026-10-20
author: carloscds
layout: post
categories:
  - C Sharp
  - ASPNET
---
Toda API que evolui acaba tendo endpoints antigos, mantidos apenas para não quebrar quem ainda os usa. Em C#, marcamos esse código com `[Obsolete]`, mas essa informação não chegava ao documento OpenAPI: quem consumia a API pelo Swagger ou por um cliente gerado não ficava sabendo. No .NET 11 RC 1 isso mudou. Além disso, a geração do documento durante o build ganhou uma opção para escolher o **ambiente** da aplicação.

Vamos ver as duas novidades em um projeto pequeno.

### Pré-requisitos

O exemplo foi validado no Windows com o SDK **11.0.100-rc.1.26425.128**, usando o mesmo `global.json` do [post sobre o RC 1](/2026/10/dotnet11rc1/). Crie o projeto:

```bash
dotnet new webapi -n CatalogoApi -f net11.0
cd CatalogoApi
```

O template já inclui o pacote `Microsoft.AspNetCore.OpenApi`.

### Marcando um endpoint como obsoleto

Substitua o `Program.cs` por:

```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddOpenApi(options =>
{
    options.AddDocumentTransformer((document, context, cancellationToken) =>
    {
        var ambiente = context.ApplicationServices
            .GetRequiredService<IHostEnvironment>().EnvironmentName;

        document.Info.Title = "Catálogo";
        document.Info.Description = $"Documento gerado no ambiente {ambiente}.";
        return Task.CompletedTask;
    });
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.MapPost("/dev/carga-inicial", () => Results.Ok("Dados de teste carregados"));
}

app.MapGet("/produtos/{id}", ObterProduto);

#pragma warning disable CS0618 // Mapeamos de propósito um endpoint obsoleto.
app.MapGet("/produtos/legado/{id}", ObterProdutoLegado);

app.Run();

static Produto ObterProduto(int id) =>
    new(id, $"Produto {id}", $"COD-{id:D4}");

[Obsolete("Use GET /produtos/{id}.")]
static ProdutoLegado ObterProdutoLegado(int id) =>
    new(id, $"Produto {id}", $"COD-{id:D4}");

public record Produto(int Id, string Nome, string Codigo);

[Obsolete("Use Produto.")]
public record ProdutoLegado(
    int Id,
    string Nome,
    [property: Obsolete("Use Codigo.")] string Sku);

#pragma warning restore CS0618
```

Temos dois endpoints para o mesmo produto: o novo, que retorna `Produto`, e o legado, que retorna `ProdutoLegado` com a propriedade antiga `Sku`. O `[Obsolete]` aparece em três lugares: no método do endpoint, no tipo de retorno e em uma propriedade.

O `#pragma` é necessário porque o próprio código usa os itens obsoletos. Sem ele, o compilador gera o warning **CS0618**. No meu teste, a primeira versão envolvia apenas o `MapGet` e o warning continuou aparecendo, desta vez na assinatura do método `ObterProdutoLegado`. Por isso o bloco vai até o final do arquivo.

O transformer de documento e o endpoint `/dev/carga-inicial` vão servir para a segunda parte do post. Por enquanto, repare que esse endpoint só existe no ambiente `Development`.

### Conferindo o documento

Execute a aplicação:

```bash
dotnet run --urls http://127.0.0.1:5120
```

O perfil do `launchSettings.json` define o ambiente como `Development`, então o documento fica disponível em `http://127.0.0.1:5120/openapi/v1.json`. Este é o trecho do endpoint legado no documento gerado no meu teste:

```json
"/produtos/legado/{id}": {
  "get": {
    "tags": [
      "Program"
    ],
    "parameters": [ ... ],
    "responses": {
      "200": {
        "description": "OK",
        "content": {
          "application/json": {
            "schema": {
              "$ref": "#/components/schemas/ProdutoLegado"
            }
          }
        }
      }
    },
    "deprecated": true
  }
}
```

E nos schemas:

```json
"ProdutoLegado": {
  "required": [
    "id",
    "nome",
    "sku"
  ],
  "type": "object",
  "properties": {
    "id": { ... },
    "nome": {
      "type": "string"
    },
    "sku": {
      "type": "string",
      "deprecated": true
    }
  },
  "deprecated": true
}
```

O `[Obsolete]` virou `deprecated: true` na operação, no schema e na propriedade, sem nenhum transformer personalizado. O endpoint `/produtos/{id}` e o schema `Produto` não receberam a marcação.

Vale lembrar que `deprecated` é só uma informação: o endpoint continua funcionando. No teste, `GET /produtos/legado/7` respondeu normalmente:

```json
{"id":7,"nome":"Produto 7","sku":"COD-0007"}
```

A diferença é que ferramentas como Swagger UI, Scalar e geradores de clientes agora conseguem destacar a operação como obsoleta, levando o aviso para quem consome a API, e não apenas para quem compila o código C#. Se você precisar de outro comportamento para um caso específico, um `IOpenApiOperationTransformer` ou `IOpenApiSchemaTransformer` pode sobrescrever o valor gerado.

Encerre a aplicação com `Ctrl+C`.

### Gerando o documento durante o build

Muitas equipes preferem gerar o arquivo OpenAPI no build, para versionar o documento, publicar em um portal ou gerar clientes no pipeline. Para isso, adicione o pacote:

```bash
dotnet add package Microsoft.Extensions.ApiDescription.Server --version 11.0.0-rc.1.26425.128
```

Para gerar o documento, o build carrega a aplicação. E aqui entra uma pergunta: **em qual ambiente?** Execute `dotnet build` sem mais nenhuma configuração. No meu teste, o arquivo foi gerado em `obj/CatalogoApi.json` com este conteúdo no `info`:

```json
"info": {
  "title": "Catálogo",
  "description": "Documento gerado no ambiente Production.",
  "version": "1.0.0"
}
```

O documento foi gerado como **Production**, e o endpoint `/dev/carga-inicial` ficou de fora. Isso não é um problema quando o documento serve para publicar a API, mas nem sempre é o que você precisa. Pode haver serviços, endpoints ou transformers que dependem do ambiente.

### Escolhendo o ambiente da geração

No RC 1, a propriedade `OpenApiGenerationEnvironment` resolve isso. Edite o `CatalogoApi.csproj`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>net11.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
    <OpenApiDocumentsDirectory>$(MSBuildProjectDirectory)/openapi</OpenApiDocumentsDirectory>
    <OpenApiGenerationEnvironment>Development</OpenApiGenerationEnvironment>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore.OpenApi" Version="11.0.0-rc.1.26425.128" />
    <PackageReference Include="Microsoft.Extensions.ApiDescription.Server" Version="11.0.0-rc.1.26425.128">
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
      <PrivateAssets>all</PrivateAssets>
    </PackageReference>
  </ItemGroup>

</Project>
```

O `OpenApiDocumentsDirectory` grava o arquivo na pasta `openapi` do projeto, que é mais fácil de versionar do que a pasta `obj`. O `OpenApiGenerationEnvironment` é repassado à aplicação no mesmo papel do `ASPNETCORE_ENVIRONMENT`.

Depois de um novo `dotnet build`, o arquivo `openapi/CatalogoApi.json` passou a mostrar `Documento gerado no ambiente Development.` e a incluir o endpoint `/dev/carga-inicial`:

```text
/dev/carga-inicial
/produtos/{id}
/produtos/legado/{id}
```

Também dá para escolher o ambiente na linha de comando, o que é útil no pipeline:

```bash
dotnet build --no-incremental -p:OpenApiGenerationEnvironment=Staging
```

Com `Staging`, a descrição mudou para `Documento gerado no ambiente Staging.` e o endpoint de desenvolvimento saiu do documento.

Repare no `--no-incremental`. No meu teste, rodar apenas `dotnet build -p:OpenApiGenerationEnvironment=Staging` logo depois do build em `Development` **não gerou o documento de novo**: o arquivo continuou indicando `Development`. Como o código não mudou, o build incremental considerou que não havia nada a fazer. Se você alternar ambientes na mesma pasta, force a recompilação ou limpe o projeto antes. Em um pipeline que começa de uma pasta limpa, esse problema não aparece.

### Considerações

As duas novidades são pequenas, mas ajudam quem mantém APIs públicas. Com o `deprecated` gerado a partir do `[Obsolete]`, o aviso de descontinuação chega aos clientes da API sem código extra. Com o `OpenApiGenerationEnvironment`, o documento gerado no build passa a refletir o ambiente que você escolheu, e não o padrão `Production`.

Minha sugestão é deixar no `.csproj` o ambiente usado para publicar a documentação e sobrescrever pela linha de comando apenas quando necessário.

Os detalhes estão nas [notas de versão do ASP.NET Core no RC 1](https://github.com/dotnet/core/blob/main/release-notes/11.0/preview/rc1/aspnetcore.md) e no [anúncio do .NET 11 RC 1](https://devblogs.microsoft.com/dotnet/dotnet-11-rc-1/).

Abraços e até a próxima!

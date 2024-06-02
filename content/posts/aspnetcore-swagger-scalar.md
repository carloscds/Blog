---
title: 'Swagger vai acabar e agora ? Vamos conhecer o Scalar'
date: 2024-06-02
author: carloscds
layout: post
categories:
  - C Sharp 
  - ASP.NET 
---
Criar uma boa doumentação para uma API é essencial para quem vai consumir os serviços, pois ajuda no uso, reduz chamados de suporte e mais que tudo,mostra que você é um desenvolver organizado!

É extremanemte desagradável, e digo isto pois trabalho com muitas APIs diariamente, trabalhar com documentações desatializadas e incorretas!

Se você e lembra, desde o .NET 5.0, o Swagger vem sendo utilizado amplamente em milhares de APIs, visto que seu uso é bastante simples e o resultado é muito bom, pois cria uma excelente documentação para nossas APIs.

O grande problema é que o Swagger tem alguns bugs (https://github.com/swagger-api/swagger-ui/issues) e a Microsoft resolveu colocar suporte nativo para OpenAPI, então o time do .NET resolveu usar uma outra ferramenta para documentar as APIs, chamada Scalar.

## Como funciona ?

O Scalar (https://github.com/scalar/scalar) é uma interface realmente muito completa e que um grande diferencial: gerar códigos exemplos para diversas linguagens. Isto elimina um grande trabalho de ficar criando exemplos de como usar a sua API.

Se você abrir o GitHub do link acima, verá uma imagem que explica exatamente o que estou falando para você. Simplesmente demais!!!

## Mas e os meus projetos com Swagger, vão deixar de funcionar ?

Claro que não, mas o pacote do Swagger não virá mais por padrão nas APIs em .NET, que agora adota o OpenAPI, mas seus códigos atuais continuam funcionando sem problemas.

Vou exemplificar o que vai acontecer!

Este é um código de uma API com .NET 8 (ou anterior):

```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();
app.Run();
```

E este foi criado com o .NET 9 Preview:

```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddOpenApi();

var app = builder.Build();
app.MapOpenApi();
app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();
app.Run();
```

Aqui temos o OpenAPI adicionado, seguindo o novo padrão, através dos métodos AddOpenApi() e MapOpenApi().

Viu a diferença ? Não tem mais o Swagger, somente o OpenAPI.

### Como eu uso o Scalar ?

A grande vantagem aqui é que você pode adicionar o Scalar em um projeto que já tem o Swagger, e os dois podem funcionar juntos. Eu recentemente fiz isto em uma API de um cliente e quando ele viu o que o Scalar pode fazer me falou: "Agora só vou usar este!".

Para adicionar o Scalar você precisa deste pacote:

```nuget
dotnet add package AspNetCore.Scalar --version 1.0.1
```

E adicionar estas linhas no Program.cs:

```csharp
if (app.Environment.IsDevelopment())
{
    app.MapScalarApiReference();
}
```

Executando a aplicação, você poderá entrar na url /scalar/v1 e ver a imagem abaixo:

![]( wp-content/uploads/2024/06/Scalar-UI.png)
 
Veja agora um exemplo de código em node.js chamando a API:

![]( wp-content/uploads/2024/06/Scalar-UI-NodeJS.png)

Este recurso é simplesmente fantástico! Lembrando que ele gera exemplos em diversas linguagens!

![]( wp-content/uploads/2024/06/Scalar-UI-Languages.gif)

### Mas eu ainda não estou experimentando o .NET 9 Preview, tem como usar ?

Muitos de nós ainda não estamos na versão preview, alias só os entusiastas (como eu, rsrs), mesmo assim ainda é possive usar o Scalar, adicionando as seguntes linhas no seu Program.cs

```csharp
app.UseScalar(options =>
{
    options.UseTheme(Theme.Default);
    options.RoutePrefix = "api-docs";
});
```

Neste exemplo você irá acessar o scalar através da url: /api-docs.

Veja que existe umao pequena diferença na configuração e na chamada em relação ao .NET 9, e acredito que ainda irá mudar mais, pois ainda estamos na versão preview.

### Considerações
O Scalar é sem dúvida uma poderosa ferramenta para documentação de API, mesmo para códigos existentes em .NET (Core), que podem se beneficiar agora mesmo, dando um belo upgrade na sua API.

Aproveite é já experimente!

Abraços e até a próxima!

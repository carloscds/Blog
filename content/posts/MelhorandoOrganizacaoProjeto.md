---
title: 'Melhorando a organização do seu projeto - Exemplo básico de arquitetura'
date: 2026-01-13
author: carloscds
layout: post
categories:
  - C Sharp
  - ASPNET
---
Como você tem organizado seus projetos, dependências e o código em geral ? Está separando tudo por projeto, isolando dependências e responsabilidades ?

Se não está, veja aqui um jeito simples e eficaz de organizar seu código e deixar os projetos mais claros!

Vamos considerar este projeto como exemplo:

![]( wp-content/uploads/2026/01/iocprojeto.png)

É exemplo bem interessante de uma arquitetura Clean, com alguns projetos:

* APIComIoC.API - API básica (CRUD)
* APIComIoC.Core  - Serviços Core (podemos considerar aqui a regra do negócio)
* APIComIoC.Domain - classes do domínio e DTOs
* APIComIoC.InfraEstrutura - acesso ao banco de dados (neste caso um banco EF em memória)

Até aí acho que não temos nenhuma novidade, pois é um típico projeto ASP.NET API com injeção de dependência e alguma organização, certo?

Vamos então olhar diretamente para a nossa API e para o **Program.cs**

```csharp
public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddControllers();
        builder.Services.AddOpenApi();

        builder.Services.AddDbContext<APIContext>(o =>
            o.UseInMemoryDatabase("BancoEmMemoria"));
        builder.Services.AddScoped<IUsuarioService, UsuarioService>();

        var app = builder.Build();
        app.MapOpenApi();
        app.UseSwaggerUI(options =>
        {
            options.RoutePrefix = "swagger";
            options.SwaggerEndpoint("/openapi/v1.json", "OpenAPI V1");
        });

        app.UseHttpsRedirection();
        app.UseAuthorization();
        app.MapControllers();
        app.MapGet("/", () => "API Com IoC funcionando!");
        app.Run();
    }
}
```
Nada mal, mas um pouco bagunçado! Tudo dentro do program, sem nenhuma separação ou organização, imagina em um projeto gigante esta estrutura!!!

Podemos melhorar isto usando uma classe de IoC (Inversion of Control), apesar disto não ter a ver somente om injeção de dependências ok! Também já ví muitos nomes para isto, então fique a vontade para usar o nome que mais lhe agrada, pois o importante aqui é manter as coisas organizadas!

Sendo assim, vamos agora criar uma nova classe na raiz do projeto da API chamada **IoC.cs**, nesta classe vamos separar os tipos de serviços e organizá-los:

```csharp
public static class IoC
{
    public static void AddCustomServices(this IServiceCollection app)
    {
        app.AddControllers();
        app.AddOpenApi();
    }

    public static void AddDatabase(this IServiceCollection app)
    {
        app.AddDbContext<APIContext>(o =>
            o.UseInMemoryDatabase("BancoEmMemoria"));
    }

    public static void AddServices(this IServiceCollection app)
    {
        app.AddScoped<IUsuarioService, UsuarioService>();
    }

    public static void UseOpenAPI(this WebApplication app)
    {
        app.MapOpenApi();
        app.UseSwaggerUI(options =>
        {
            options.RoutePrefix = "swagger";
            options.SwaggerEndpoint("/openapi/v1.json", "OpenAPI V1");
        });
    }

    public static void UseDefaultServices(this WebApplication app)
    {
        app.MapControllers();
        app.MapGet("/", () => "API Com IoC funcionando!");
    }

    public static void UseSecurity(this WebApplication app)
    {
        app.UseHttpsRedirection();
        app.UseAuthorization();
    }
}
```

Ficou melhor não ? 

Primeiro os serviços da API:

* AddCustomServices() - serviços bases da API
* AddDatabase() - onde vamos persistir os dados 
* AddServices() - serviços da nossa aplicacão

Agora os que vamos expor:

* UseOpenAPI() - serviço de documentação usando OpenAPI e Swagger
* UseDefaultServices() - serviços básicos da API
* UseSecurity() - serviços de segurança

E por fim, veja agora como fica o nosso **Program.cs**

```csharp
public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddCustomServices();
        builder.Services.AddDatabase();
        builder.Services.AddServices();

        var app = builder.Build();
        app.UseOpenAPI();
        app.UseSecurity();
        app.UseDefaultServices();
        app.Run();
    }
}
```

Veja que tudo é uma questão de organização, mais agrupado e mais simples de entender!

Este é um projeto exemplo com poucas injeções de dependêcia, mas já é possível deixá-lo muito mais organizado!

### Considerações
Existem diversas formas de arquitetura e organização de projetos com C#, eu gosto sempre do "menos é mais", o básico bem feito sempre funciona!

Espero que este exemplo te ajude e deixar o seu código mais organizado!

O código fonte do exemplo está no meu [GitHub](https://github.com/carloscds/CSharpSamples/tree/master/APIComIoC).

Abraços e até a próxima!

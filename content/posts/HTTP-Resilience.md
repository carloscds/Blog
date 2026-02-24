---
title: 'Tratando a resiliência em chamadas HTTP'
date: 2026-02-12
author: carloscds
layout: post
categories:
  - C Sharp
  - ASPNET
---
O que é ser resiliente ? E uma aplicação resiliente ?

Ser resiliente é saber lidar com adversidades, adaptar-se a mudancas e lidar com pressões. Mas e uma aplicação resiliente ? Basicamente é a mesma coisa, saber contornar problemas que não estão ao seu alcance, tratar erros e sobrecargas.

No cenário de aplicações web, vamos explorar um recurso que nem é tão novo assim, mas que ganhou uma nova "roupagem" nas últimas versões do .NET. Hoje vamos falar do tratamento de resiliência em chamadas HTTP, ou seja, como lidar com ambientes onde a chamada pode nao responder e precisamos pelo menos garantir tentativas antes de apresentar um erro para o usuário.

Ah, mas dá para resolver isto com um contador dentro de um for... Até dá, mas não seria uma solução estruturada e elegante!

Não vamos colocar contadores, vamos trabalhar com uma nova extensão do ASP.NET chamada **ResilienceHandler**, que é derivada do popular pacote [Polly](https://github.com/App-vNext/Polly). 

## Iniciando o projeto

Para este artigo iremos trabalhar com duas APIs em ASP.NET, uma principal que irá fazer chamadas para a outra. Estou também usando neste artigo o Visual Studio 2026 Preview e o .NET 11 Preview (sim tudo beta! rsrs)

Crie uma Solution em branco no Visual Studio e depois adicione dois projetos, um chamado: HttpResiliente e outro chamado TesteAPI, ambos ASP.NET Core WebAPI. Depois de feito isto teremos a seguinte estrutura:

![]( wp-content/uploads/2026/02/HttpResiliente_Solutions.png)

O projeto HttpResilience usa Controllers, e o TesteAPI é bem mais simples e usa MinimalAPI.

### Projeto HttpResilience

Para usarmos o conceito de Resiliencia temos que adicionar o pacote nuget:

```cmd
dotnet add package Microsoft.Extensions.Http.Resilience
```

#### Configurando tudo no Program.cs

*PS: neste exemplo nao usei o conceito de IoC para deixar mais simples!*

E depois no Program.cs adicionamos o Middleware - *AddResilienceHandler()*:

```csharp
public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddControllers();
        builder.Services.AddOpenApi();

        builder.Services.AddHttpClient("TesteAPI", s => s.BaseAddress = new Uri("https://localhost:6001/")))
            .AddResilienceHandler("TesteAPI-pipeline", builder => 
            {
                builder.AddRetry(new HttpRetryStrategyOptions
                {
                    MaxRetryAttempts = 3, // 3 tentativas
                    Delay = TimeSpan.FromSeconds(3), // aguarda 3 segundos inicialmente
                    BackoffType = DelayBackoffType.Exponential // vai dobrando: 3, 6, 12 e depois falha
                });
                builder.AddTimeout(TimeSpan.FromSeconds(3)); // tempo de timeout da chamada
            });

        var app = builder.Build();
        app.MapOpenApi("/openapi/v1.json");
        app.UseSwaggerUI(options =>
        {
            options.RoutePrefix = "swagger";
            options.SwaggerEndpoint("/openapi/v1.json", "OpenAPI V1");
        });
        app.MapControllers();
        app.MapGet("/" , () => "HTTP Resilience - 2026 Carlos dos Santos ");
        app.UseMiddleware<ResilienceMiddlewareException>();
        app.Run();
    }
```

O inicio do Program.cs não tem mistério, basicamente adicionamos os middlewares de Controller e da OpenApi. Mas logo após vamos incluir o **AddHttpClient()** com a extensão **AddResilienceHandler()**

Aqui temos alguns pontos muitos importantes:
1. Se você não usa HttpClient() e ClientFactory nas suas aplicações web, sugiro que começe! Isto evita muitos problemas de Socket no Sistema Operacional;
2. Ao adicionar o **HttpClient()**, colocamos o nome *"TesteAPI"* e o endereço base da API que vamos consumir. Este nome será usado para criarmos os HttpClients nas chamadas. Isto cria um conceito de pool de HTTP e também padroniza a nossa API.
3. Depois adicionamos o **AddResilienceHandler()**, colocamos um nome para ele: "TesteAPI-pipeline", e configuramos a nossa política de resiliência.

Explicando os parâmetros da política de resiliência:
* Quantas *tentativas* teremos antes de parar: cuidado para não colocar números muitos altos e travar a sua aplicação (no nosso exemplo 3 tentativas)
* Quanto *tempo vamos aguardar* entre cada tentativa ? (no nosso exemplo 3 segundos)
* Qual o *modelo de resiliência* que vamos adotar ? no caso deste exemplo escolhi Exponential, que vai dobrando os tempos (3, 6, e 12 segundos)
* E por fim, o *Timeout* das chamadas (no nosso exemplo 3 segundos)

Simples e eficiente!

Por fim, adicionei um Middleware para tratamento de erro. Eu ja abordei este tema [neste artigo](https://carloscds.net/2024/07/tratamento-erros-inner-exception/).

#### Configurando a Controller

A nossa controller exemplo se chama TesteController e tem a seguinte estrutura:

```charp
using Microsoft.AspNetCore.Mvc;

namespace HttpResilience.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TesteController : ControllerBase
    {
        private readonly HttpClient _client;
        public TesteController(IHttpClientFactory factory)
        {
            _client = factory.CreateClient("TesteAPI");
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var result = await _client.GetAsync("");
            var resultMsg = await result.Content.ReadAsStringAsync();
            if (result.IsSuccessStatusCode)
            {
                return Ok($"Chamada: {resultMsg}");
            }
            return BadRequest($"API Result: {resultMsg}");
        }
    }
}
```

Para poder usar o *ResilienceHandler* vamos criar o HttpClient usando a Factory do ASP.NET (se você nunca ouviu falar disto, recomendo ler este [artigo](https://learn.microsoft.com/pt-br/dotnet/architecture/microservices/implement-resilient-applications/use-httpclientfactory-to-implement-resilient-http-requests))

Quando criamos o HttpClient usando este código:

```csharp
public TesteController(IHttpClientFactory factory)
{
    _client = factory.CreateClient("TesteAPI");
}
```
Estamos pegando do DI (Dependency Injection), um HttpClient vinculado ao nome "TesteAPI", isto já cria o HttpClient com o BaseAddress e toda a configuração de Resiliência.

Agora é só fazer a chamada da mesma maneira que você já faz, mas observe que ao fazer a chamada, não temos nenhum código de tratamento de tentativa, pois isto veio já pronto quando pegamos a instância do HttpClient.

Nem mesmo o tratamento de erro está aqui, pois eu coloquei um Middleware de Exception. Você simplesmente chama a API e trata o resultado, o restante é por conta do ResilienceHandler().

Simples assim!!!

Agora vamos criar a API para chamarmos no teste.

### Projeto TesteAPI

Este projeto é muito simples. Basicamente um minimal API com um único endpoint. Veja o Program.cs

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();
app.MapGet("/", () => $"TesteAPI - {DateTime.Now}");
app.Run();
```

Pronto, agora alguns detalhes antes de executarmos a aplicação.

### Configurando o ambiente para execução

Vamos editar os arquivos **launchSettings.json** dos dois projetos.

No projeto HttpResilience, coloque o seguinte:

```json
{
  "$schema": "https://json.schemastore.org/launchsettings.json",
  "profiles": {
    "https": {
      "commandName": "Project",
      "dotnetRunMessages": true,
      "launchBrowser": false,
      "applicationUrl": "https://localhost:5001;http://localhost:5000",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }
  }
}
```

E no projeto TesteAPI, o seguinte:
```json
{
  "$schema": "https://json.schemastore.org/launchsettings.json",
  "profiles": {
    "https": {
      "commandName": "Project",
      "dotnetRunMessages": true,
      "launchBrowser": false,
      "applicationUrl": "https://localhost:6001;http://localhost:5006",
      "environmentVariables": {
        "ASPNETCORE_ENVIRONMENT": "Development"
      }
    }
  }
}
```

Basicamente informamos que o projeto HttpResilience vai rodar na porta HTTPS 5001 e o projeto TesteAPI na porta HTTPS 6001

Agora vamos rodar e ver o que acontece!

### Rodando os dois projetos

Você pode rodar pelo Visual Studio marcando a execução simultânea dos dois projetos, mas eu vou preferir rodar pela linha de comando para poder parar o projeto de Teste e depois rodar novamente! Faça ai como achar mais interessante!

#### Rodando na linha de comando

Entre no diretório do projeto HttpResilience e digite o comando:

```cmd
dotnet run --launch-profile https
```

Depois entre no diretório do projeto TesteAPI e faça o mesmo!

Agora temos as duas APIs em execução:
![]( wp-content/uploads/2026/02/HttpResiliente_Running.png)

Acesse o [Swagger da API HttpResilience](https://localhost:5001/swagger) e depois chame o endereço /Teste e faça o teste!

Ele vai rodar e retornar o valor: "Chamada: TesteAPI - 23/02/2026 22:47:15" *(aqui você verá a data da execução)*

#### Verificando a resiliência

Feche o programa do TesteAPI e execute novamente a chamada pelo Swagger...

Você verá um "Loading..." e depois de um tempo um erro 500, que é retornado pelo Middleware de Erros.

Agora faça o teste novamente: chamando a API pelo Swagger, depois derrube a API de testes, espere 3 segundos e execute novamente a linha de comando...

Você vai ver que a chamada foi executada sem erros! Isto significa que o chamador (HttpResilience) ficou tentando fazer a requisição e durante o tempo configurado na política a API voltou a funcionar e a chamada deu certo!

Pronto, agora temos Resiliência na nossa API!


### Considerações
É muito importante que você trate erros de chamada HTTP na sua aplicação, sempre levando em consideração que o serviço chamado pode sofrer alguma instabilidade e a sua aplicação precisa lidar com isto sem cair!

Como eu falei antes, existem diversas maneiras de tratar a Resiliência no ASP.NET, leia a [documentação](https://learn.microsoft.com/pt-br/dotnet/core/resilience/http-resilience?tabs=dotnet-cli) e adapte para a sua realidade!

O código fonte do exemplo está no meu [GitHub](https://github.com/carloscds/CSharpSamples/tree/master/HttpResilience).

Abraços e até a próxima!

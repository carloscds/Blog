---
title: 'ShortCircuit: Pulando o pipeline de Middlewares no ASP.NET Core'
date: 2026-07-21
author: carloscds
layout: post
categories:
  - C Sharp
  - ASPNET
---
Você já parou para pensar em quantos Middlewares são executados antes da sua Controller responder um simples "OK" ? Autenticação, CORS, Roteamento, Rate Limiting, Logging... e às vezes o seu endpoint nem precisa de nada disso!

Pensando nisso, o ASP.NET Core adicionou um novo atributo chamado **[ShortCircuit]**, que faz o endpoint ser executado logo após o Roteamento, "pulando" todo o restante do pipeline de Middlewares.

### Mas isto não é novidade ?

Na verdade não é 100% novo. Já existia o conceito de **ShortCircuit()** como uma *convenção de endpoint*, usada principalmente em Minimal APIs. A novidade aqui é que agora temos a versão em formato de **atributo**, podendo ser aplicado diretamente em Controllers e Actions do MVC, deixando o recurso muito mais simples de usar no dia a dia de quem ainda trabalha com Controllers.

### Por que usar o Short-Circuit ?

Pense em cenários como:
* Um endpoint de **health check**, que só precisa responder "estou vivo";
* Um **robots.txt**, que é um arquivo estático de texto;
* Qualquer endpoint que não dependa de autenticação, CORS ou outros Middlewares customizados da sua aplicação.

Nestes casos, todo o processamento dos Middlewares anteriores é um custo desnecessário. O **[ShortCircuit]** evita essa sobrecarga, pois o endpoint já responde assim que o Roteamento identifica qual Controller/Action deve ser chamada.

Importante: o endpoint **continua sendo executado normalmente** e produzindo a sua resposta, o que muda é que os Middlewares que estariam entre o Roteamento e a execução da Action não rodam.

### Usando no Controller inteiro

Você pode aplicar o atributo na classe, fazendo com que todas as Actions daquela Controller sejam short-circuited:

```csharp
[ApiController]
[Route("[controller]")]
[ShortCircuit]
public class HomeController : ControllerBase
{
    public IActionResult Get() => Ok("ShortCircuit");
}
```

### Usando apenas em um método

Se você quer aplicar o comportamento somente em uma Action específica, basta colocar o atributo no método, e não na classe:

```csharp
[ApiController]
[Route("[controller]")]
public class Home3Controller : ControllerBase
{
    [ShortCircuit]
    public IActionResult Get() => Ok("ShortCircuit no Methodo");
}
```

E para efeito de comparação, uma Controller "normal", sem o atributo, que vai passar por todo o pipeline de Middlewares normalmente:

```csharp
[ApiController]
[Route("[controller]")]
public class Home2Controller : ControllerBase
{
    public IActionResult Get() => Ok("Sem ShortCircuit");
}
```

### Exemplo real: robots.txt

Um dos casos mais clássicos de uso é justamente o **robots.txt**. Ele não precisa de autenticação, não precisa de CORS, é só um texto estático que os robôs de busca vão ler:

```csharp
[ApiController]
[Route("robots.txt")]
[ShortCircuit]
public class RobotsController : ControllerBase
{
    [HttpGet]
    public IActionResult Get() => Content("User-agent: *\nDisallow:", "text/plain");
}
```

Repare que o `[Route("robots.txt")]` já cuida do endereço, e o `[ShortCircuit]` garante que essa resposta seja a mais rápida possível, sem passar pelos demais Middlewares configurados no `Program.cs`.

### Definindo um status code diferente

Você também pode passar um status code opcional para o atributo, por exemplo se quiser retornar um 404 diretamente:

```csharp
[ShortCircuit(404)]
```

### Comprovando o Short-Circuit com um Middleware

Para deixar mais claro o efeito do **[ShortCircuit]**, adicionei ao projeto um Middleware chamado **ExceptionHandlingMiddleware**. Ele foi colocado ali apenas para fins didáticos, para mostrarmos quando o pipeline de Middlewares realmente é executado:

```csharp
using System.Net;
using System.Text.Json;

namespace CircuitoCurto.Middlewares;

internal sealed class ExceptionHandlingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<ExceptionHandlingMiddleware> _logger;

    public ExceptionHandlingMiddleware(RequestDelegate next, ILogger<ExceptionHandlingMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
            Console.WriteLine($"{DateTime.Now} - Request para {context.Request.Path}");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, $"Error {context.Request.Path}");
            await HandleExceptionAsync(context, ex);
        }
    }

    private static Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        var statusCode = exception switch
        {
            ArgumentException => HttpStatusCode.BadRequest,
            KeyNotFoundException => HttpStatusCode.NotFound,
            UnauthorizedAccessException => HttpStatusCode.Unauthorized,
            NotImplementedException => HttpStatusCode.NotImplemented,
            _ => HttpStatusCode.InternalServerError
        };

        var payload = new
        {
            status = (int)statusCode,
            error = statusCode.ToString(),
            message = exception.Message
        };

        context.Response.ContentType = "application/json";
        context.Response.StatusCode = (int)statusCode;
        return context.Response.WriteAsync(JsonSerializer.Serialize(payload));
    }
}
```

Repare no `Console.WriteLine($"{DateTime.Now} - Request para {context.Request.Path}");`. É essa linha que vai denunciar se o Middleware foi executado ou não.

Como este Middleware é registrado no `Program.cs` com `app.UseMiddleware<ExceptionHandlingMiddleware>()`, ele faz parte do pipeline "normal" da aplicação. Então, se chamarmos:

* **/Home2** (sem o `[ShortCircuit]`): o texto aparece no Console, pois a Request passou pelo Middleware normalmente;
* **/Home** ou **/Home3** (com o `[ShortCircuit]`): o texto **não aparece** no Console, comprovando que o Middleware foi mesmo pulado!

É uma forma simples e visual de comprovar que o atributo realmente está fazendo o que promete.

### Considerações

É um recurso simples, mas que ajuda bastante em performance quando você tem endpoints que realmente não precisam de todo aquele pipeline de Middlewares rodando por baixo dos panos. Health checks e arquivos estáticos como o robots.txt são os candidatos perfeitos para o **[ShortCircuit]**.

Vale lembrar: use com cuidado! Se o seu endpoint short-circuited passar a precisar de autenticação ou CORS no futuro, você vai precisar remover o atributo, senão aquele Middleware simplesmente não vai ser executado.

O código fonte do exemplo está no meu [GitHub](https://github.com/carloscds/CSharpSamples/tree/master/CircuitoCurto).

Abraços e até a próxima!

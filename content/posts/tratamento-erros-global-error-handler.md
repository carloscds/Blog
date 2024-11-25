---
title: 'Conheça o Global Error Handler - Novo Recurso do ASP.NET 8.0'
date: 2024-10-28
author: carloscds
layout: post
categories:
  - C Sharp 
  - ASP.NET 
---
No [último artigo](https://carloscds.net/2024/07/tratamento-erros-inner-exception) falamos de tratamento de exceções usando um Middeware, que é um recurso muito útil e versátil.

Agora no .NET 8 temos um recurso mais simples e poderoso chamado *Global Error Handler*, que faz basicamente o que o Middleware de Exception do nosso último artigo, só que de maneira um tanto mais simples e eficiente.

## Como usar o Global Error Handler

Existe muita maneiras de usar o recurso, mas basicamente você implementa uma classe que herda da interface *IExceptionHandler* :


```csharp
public class GlobalExceptionHandler(ILogger<GlobalExceptionHandler> logger) : IExceptionHandler
{
    public async ValueTask<bool> TryHandleAsync(HttpContext httpContext, Exception exception, CancellationToken cancellationToken)
    {
        // seu código aqui
        return true;
    }
}
```

Depois adiciona esta classe no **program.cs** usando o método *AddExceptionHandler()* e depois o *UseExceptionHandler()*. Estou adicionando também o ProblemDetails(), que usamos mais adiante.

```csharp
public static void Main(string[] args)
{
    var builder = WebApplication.CreateBuilder(args);

    builder.Services.AddControllers();
    builder.Services.AddSerilog(s => s.WriteTo.Console());
    builder.Services.AddExceptionHandler<GlobalExceptionHandler>(); // aqui
    builder.Services.AddProblemDetails();

    var app = builder.Build();
    app.UseAuthorization();
    app.MapControllers();
    app.UseExceptionHandler(); // e aqui
    app.Run();
}
```

## Adicionando o tratamento de Erros completo

Pegando a rotina de montagem de Erros do nosso último artigo, o código ficaria assim:

```csharp
using CapturaErros.DTO;
using Microsoft.AspNetCore.Diagnostics;
using System.Net;
using static System.Net.Mime.MediaTypeNames;

namespace CapturaErros.ExceptionHandler
{
    public class GlobalExceptionHandler(ILogger<GlobalExceptionHandler> logger) : IExceptionHandler
    {
        public async ValueTask<bool> TryHandleAsync(HttpContext httpContext, Exception exception, CancellationToken cancellationToken)
        {
            var _modelErros = new List<ModelErrors>();
            MontaMensagemErro(_modelErros, exception);
            var errorJson = System.Text.Json.JsonSerializer.Serialize(_modelErros);
            logger.LogError(errorJson);
            httpContext.Response.ContentType = Application.Json;
            httpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            await httpContext.Response.WriteAsJsonAsync(errorJson, cancellationToken).ConfigureAwait(false);
            return true;
        }

        private void MontaMensagemErro(List<ModelErrors> _modelErros, Exception ex)
        {
            _modelErros.Add(new ModelErrors { Mensagem = ex.Message, CodeTrace = ex.StackTrace });
            if (ex.InnerException != null)
            {
                MontaMensagemErro(_modelErros, ex.InnerException);
            }
        }
    }
}
```

Veja que agora não temos mais o *try..catch* do Middeware, pois o erro já vem para nós no método *TryHandleAsync* na propriedade Exception, e podemos fazer os devidos tratamentos, escrevendo ao final o retorno para o usuário.

## Adicionando o ProblemDetails

Agora vamos a uma pequena variação deste mesmo código adicionando um novo elemento chamado **ProblemDetails**. Esta nova classe serve para devolvermos os erros para o usuário de uma maneira mais padronizada. Para isto no **program.cs** você deve ter reparado o método:

```csharp
builder.Services.AddProblemDetails();
```
Este método adiciona os dados necessários para trabalharmos com o ProblemDetails. Veja agora um novo método para tratamento de exceção:


```csharp
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using static System.Net.Mime.MediaTypeNames;
using System.Net;

namespace CapturaErros.ExceptionHandler
{
    public class GlobalExceptionHandlerProblemDetail(ILogger<GlobalExceptionHandlerProblemDetail> logger) : IExceptionHandler
    {
        public async ValueTask<bool> TryHandleAsync(HttpContext httpContext, Exception exception, CancellationToken cancellationToken)
        {
            var _pd = new List<ProblemDetails>();
            MontaMensagemErroPD(_pd, httpContext.Request.Path.ToString(), exception);
            var errorJson = System.Text.Json.JsonSerializer.Serialize(_pd);
            logger.LogError("{ProblemDetails}", errorJson);
            httpContext.Response.ContentType = Application.Json;
            httpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;
            await httpContext.Response.WriteAsJsonAsync(errorJson, cancellationToken).ConfigureAwait(false);
            return true;
        }

        private void MontaMensagemErroPD(List<ProblemDetails> _pd, string pathString, Exception ex)
        {
            // aqui montamos o ProblemDetails
            _pd.Add(new ProblemDetails{ Instance = pathString, Title = ex.Message, Detail = ex.StackTrace });
            if (ex.InnerException != null)
            {
                MontaMensagemErroPD(_pd, pathString, ex.InnerException);
            }
        }
    }
}
```
Você deve notar que estamos preenchendo a classe ProblemDetails com 3 informações: 
* Instance = local onde ocorreu o erro
* Title = título do erro, no nosso caso, a exceção
* Details = detalhes, aqui eu coloquei o stackTrace do código, mas você pode colocar qualquer outra informação.

Por fim, o resultado final não muda muito, pois continuamos tratando as exceções no método **MontaMensagemErroPD** para pegar toda a árvore de exceções.

Para usar esta nova classe de erros, no nosso **program.cs**, precisamos modificar o Exception Handler para este novo:

```csharp
builder.Services.AddControllers();
builder.Services.AddSerilog(s => s.WriteTo.Console());
builder.Services.AddExceptionHandler<GlobalExceptionHandlerProblemDetail>(); // aqui
builder.Services.AddProblemDetails();
```

*PS: Aqui eu usei o ProblemDetails da mesma maneira que a classe ModelErrors, pois eu quero pegar o StackTrace, mas você pode simplificar o código, eliminando esta última parte (StackTrace), deixando o retorno mais parecido com o informado na documentação.*

### Considerações
Este novo modelo de tratamento de erros deixa o código mais simples e permite vários outras maneiras de gerenciar os erros da nossa aplicação!

Vale a pena ler cuidadosamente a [documentação oficial da Microsoft.](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/error-handling?view=aspnetcore-8.0)

O código fonte completo da aplicaçao está no meu [GitHub](https://github.com/carloscds/CSharpSamples/tree/master/CapturaErrosGlobalException).

Abraços e até a próxima!

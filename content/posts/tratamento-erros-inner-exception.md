---
title: 'Você está tratando corretamente os erros na sua aplicação ?'
date: 2024-07-25
author: carloscds
layout: post
categories:
  - C Sharp 
  - ASP.NET 
---
Aplicações apresentam erros, isto é um fato inegável. Por mais que você teste, automatize, verifique, em algum momento algum código poderá causar um erro na sua aplicação!

A partir daí como você pega e trata este erro é o que vai indicar quando e como você poderá resolver o problema.

## Como assim tratar corretamente o erro ?

É muito comum em aplicações estes tipos de abordagem:

```csharp
try
{
    // algum código
}
catch (Exception ex)
{

}
```
Sim, você nao está vendo errado, o bloco exception nao tem nada!

Ou este outro aqui:
```csharp
try
{
    // algum código
}
catch
{

}
```

Ou ainda este:
```csharp
try
{
    // algum código
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message)
}
```
Ok, você está exagerando, isto não existe! Lamento muito meu caro desenvolvedor, mas isto é mais comum do que você imagina!

Existe um uso muito excessivo, as vezes abusivo de **try..catch** onde um simples **if** resolveria a situação. Mas talvez pode ser "mais seguro" usamos o tratamento de exceção!

Vamos olhar o terceiro exemplo, onde existe um tratamento do erro dentro do catch. A grande pergunta é onde este erro irá aparecer, por exemplo se for uma aplicaçao web ? Simples, na console do servidor, mas quem vai ver isto ? Provavelmente ninguém, não é ?

Então como uma boa prática, ou melhor, uma prática essencial para um bom software, você precisa enviar este erro para agum local centralizado, onde alguém tenha acesso e verifique isto. Você pode enviar para seu banco de dados ? Para um arquivo em disco ? Um banco NoSQL ? 

### Para onde envio meu erro ?

* Gravar no seu banco de dados pode ser interessante, mas poderá concorrer com sua aplicação e também poderá gerar muitos registros, mas é uma opção!
* Gravar o disco nem sempre é uma boa idéia, pois você pode escalar sua aplicação e para cada nova instância teremos um novo log, e isto não é sustentáve!
* Enviar para um banco NoSQL, como o Elastic ou Mongo pode ser uma alternativa mais viável e mais isolada de sua aplicação, e você pode colocar até uma ferramenta gráfica como Grafana ou Kibana para ver algumas estatísticas.

Mas em todos estes cenários a grande pergunta é: O erro gravado será suficiente para você resolver o problema ?

### Capturando corretamente o erro

Vamos então pegar o exemplo abaixo novamente:
```csharp
try
{
    // algum código
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message)
}
```
O que vem na variável **ex.Message** ? Provavelmente a primeira mensagem de erro da pilha do erro, e isto pode não resolver o problema, pois o erro pode ter acontecido em outro local. 

Precisamos então olhar para todas as **InnerExceptions** e principalmente para o ***StackTrace***.

O StackTrace mostra toda a sequência de chamadas no seu código que provocaram o erro, desde a origem até o pronto mais alto. E olhar todas as Exceptions internas (InnerExceptions) e seus StackTraces, consegue nos dar uma visão bem mais ampla de onde o erro aconteceu.

Vamos pegar o exemplo abaixo:
```csharp
public void ChamadaErro()
{
    try
    {
        throw new Exception("Erro na chamada");
    }
    catch (Exception ex)
    {
        throw new Exception("Erro na chamada - Inner", ex);
    }
}
```
Aqui temos, de maneira bem simplificada, um erro dentro de outro erro, um exemplo de InnerException, mas pense em uma aplicação complexa, com muitas camadas. Neste caso precisamos inspecionar todos os níveis do erro e armazenar o máximo de informações possíveis para nos ajudar a corrigir o problema de maneira mais eficiente.

### Captura Recursiva do Erro

Para realizar a captura do erro de maneira mais abrangente, vamos usar uma função recursiva (uma função que chama ela mesma), que no meu exemplo está implementada dentro do Middleware de Exceções de uma aplicação ASP.NET, veja o código abaixo:
```csharp
public class MiddlewareException
{
    private readonly RequestDelegate _next;

    public MiddlewareException(RequestDelegate next)
    {
        _next = next;
    }

    public async Task Invoke(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            await HandleExceptionAsync(context, ex);
        }
    }

    private static Task HandleExceptionAsync(HttpContext context, Exception ex)
    {
        var _modelErros = new List<ModelErrors>();
        MontaMensagemErro(_modelErros, ex);
        var result = System.Text.Json.JsonSerializer.Serialize(_modelErros);
        context.Response.ContentType = "application/json";
        context.Response.StatusCode = (int)HttpStatusCode.InternalServerError; ;
        return context.Response.WriteAsync(result);
    }

    private static void MontaMensagemErro(List<ModelErrors> _modelErros, Exception ex)
    {
        _modelErros.Add(new ModelErrors { Mensagem = ex.Message, CodeTrace = ex.StackTrace });
        if (ex.InnerException != null)
        {
            MontaMensagemErro(_modelErros, ex.InnerException);
        }
    }
}
```
Veja o método **HandleExceptionAsync()**, nele temos uma chamada ao método **MontaMensagemErro()**, uma função recursiva que percorre todas as Exceptions e armazena em uma lista a *Mensagem do Erro* e o *StackTrace*.
Esta lista é retornada ao final do processo recursivo, e assim criamos um objeto Json que é retornado. Neste ponto você poderia enviar o erro para uma base externa, como explicado anteriormente, até mesmo usando o **Serilog** e algum de seus [Skins](https://github.com/serilog/serilog/wiki/Provided-Sinks).

Um detatlhe bem interessante sobre o uso do Middleware de Exceção é reduzir *drasticamente* o numero de **try...catchs** em sua aplicação, pois você centraliza o tratamento dos erros em um único ponto. Obviamente que existem "exceções" a esta abordagem e precisamos tratar localmente o erro.

### O resultado da captura do erro
Finalmente, caso tenhamos um erro em nossa aplicação, teremos um erro bem mais completo, como no exemplo abaixo:
```json
[
  {
    "Mensagem": "Erro na chamada - Inner",
    "CodeTrace": "   at CapturaErros.Services.Chamada.ChamadaErro() in D:\\cds\\git\\github\\carloscds\\CSharpSamples\\CapturaErros\\Services\\Chamada.cs:line 13\r\n   at CapturaErros.Services.SimulacaoErro.SimulaErro() in D:\\cds\\git\\github\\carloscds\\CSharpSamples\\CapturaErros\\Services\\SimulacaoErro.cs:line 8\r\n   at CapturaErros.Controllers.ErrorController.Get() in D:\\cds\\git\\github\\carloscds\\CSharpSamples\\CapturaErros\\Controllers\\ErrorController.cs:line 21\r\n   at lambda_method1(Closure, Object, Object[])\r\n   at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.SyncActionResultExecutor.Execute(ActionContext actionContext, IActionResultTypeMapper mapper, ObjectMethodExecutor executor, Object controller, Object[] arguments)\r\n   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeActionMethodAsync()\r\n   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)\r\n   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeNextActionFilterAsync()\r\n--- End of stack trace from previous location ---\r\n   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Rethrow(ActionExecutedContextSealed context)\r\n   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.Next(State& next, Scope& scope, Object& state, Boolean& isCompleted)\r\n   at Microsoft.AspNetCore.Mvc.Infrastructure.ControllerActionInvoker.InvokeInnerFilterAsync()\r\n--- End of stack trace from previous location ---\r\n   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeFilterPipelineAsync\u003Eg__Awaited|20_0(ResourceInvoker invoker, Task lastTask, State next, Scope scope, Object state, Boolean isCompleted)\r\n   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeAsync\u003Eg__Logged|17_1(ResourceInvoker invoker)\r\n   at Microsoft.AspNetCore.Mvc.Infrastructure.ResourceInvoker.\u003CInvokeAsync\u003Eg__Logged|17_1(ResourceInvoker invoker)\r\n   at Microsoft.AspNetCore.Routing.EndpointMiddleware.\u003CInvoke\u003Eg__AwaitRequestTask|7_0(Endpoint endpoint, Task requestTask, ILogger logger)\r\n   at CapturaErros.Middleware.MiddlewareException.Invoke(HttpContext context) in D:\\cds\\git\\github\\carloscds\\CSharpSamples\\CapturaErros\\Middleware\\MiddlewareException.cs:line 20"
  },
  {
    "Mensagem": "Erro na chamada",
    "CodeTrace": "   at CapturaErros.Services.Chamada.ChamadaErro() in D:\\cds\\git\\github\\carloscds\\CSharpSamples\\CapturaErros\\Services\\Chamada.cs:line 9"
  }
]
```
Isto com certeza irá facilitar muito a resolução do problema!

### Considerações
Tratar erros de aplicações corretamente faz parte das características de um bom desenvolvedor, então verifique seus códigos atuais e comece a dar a devida importância para isto!

O código fonte da aplicação com o Middleware de tratramento de erro está no meu [GitHub](https://github.com/carloscds/CSharpSamples/tree/master/CapturaErros).

Abraços e até a próxima!

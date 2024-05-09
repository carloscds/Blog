---
id: 10427
title: 'ASP.NET (Core) KeyedServices - uma interface, várias implementações'
date: 2024-05-09
author: carloscds
layout: post
categories:
  - C Sharp 
  - ASP.NET 
---
Recentemente tive que fazer uma mudança em um projeto ASP.NET que envolvia usar repositório para acesso ao Azure Storage. Este projeto ja tinha uma storage funcionando, mas o cliente precisava usar uma segunda storage para um endpoint específico na aplicação. Ok, nada que um IF não resolva certo ?

Não gosto muito deste tipo de solução, então verifiquei a documentação do ASP.NET 8 e temos um novo recurso chamado [KeyedServices](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-8.0).

## Como funciona ?

Se você ainda não entende bem como funciona a injeção de dependência no ASP.NET recomendo que você veja [este outro artigo meu](http://localhost:1313/2020/02/injecao-de-dependencia-em-c-parte-2/).

A injeção de dependência é baseada em **interfaces**, onde você indica uma interface, o modo (Singleton, Transient, Scoped) e qual classe deve ser iniciada. Isto elimina um grande trabalho do desenvolvedor de ficar instanciando e gerenciando a objetos, pois ao *invocar* uma interface, o mecanismo de injeção retorna para nós o objeto.

Veja este exemplo simples aqui:
```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllers();

    services.AddScoped<IServico, Servico>();
}
```
Temos a interface *IServico* e a classe *Servico*, então ao colocarmos a *interface* em um construtor, como abaixo:

```csharp
[ApiController]
[Route("[controller]")]
public class HomeController : ControllerBase
{
    private readonly IServico _servico;
    public HomeController(IServico servico)
    {
        _servico = servico;
    }
}
```
Temos o objeto instanciado e carregado! 

Ok, mas e quanto ao problema proposto ? Tenho uma *interface* e duas classes, como resolver ?

### KeyedServices

O ASP.NET 8 introduziu um novo conceito na injeção de dependência, onde agora eu posso ter uma *interface* e várias classes, o que deixa o código mais simples e mais limpo.

#### Vamos a um exemplo

Tenho uma interface IMessage e vou implementar diferentes classes para esta mesma interface: MensagemA e MensagemB, veja:

```csharp
public interface IMessage
{
    string Send();
}
```

Agora as implementações:
```csharp
public class MensagemA : IMessage
{
    public string Send()
    {
        return "MENSAGEM A";
    }
}
```
```csharp
public class MensagemB : IMessage
{
    public string Send()
    {
        return "MENSAGEM B";
    }
}
```

Agora como eu resolvo isto na configuração da injeção de dependência ?

```csharp
builder.Services.AddKeyedScoped<IMessage, MensagemA>("A");
builder.Services.AddKeyedScoped<IMessage, MensagemB>("B");
```
Veja como ficou simples, você usa o **AddKeyed[Scope,Transient,Singleton]** e no final da linha, cria uma identificacão para aquela injeção, no meu caso "A" e "B".
Assim nós temos a mesma interface e duas implementações diferentes! Ok, mas como usar isto ? 

Simplesmente adicionando **[FromKeyedServices]** antes da interface!

```charp
[ApiController]
[Route("[controller]")]
public class TesteController : ControllerBase
{
    private readonly IMessage _msgA;
    private readonly IMessage _msgB;
    public TesteController([FromKeyedServices("A")] IMessage mensagemA,
                           [FromKeyedServices("B")] IMessage mensagemB)
    {
        _msgA = mensagemA;
        _msgB = mensagemB;
    }

    [HttpGet("A")]
    public IActionResult GetA()
    {
        return Ok(_msgA.Send());
    }

    [HttpGet("B")]
    public IActionResult GetB()
    {
        return Ok(_msgB.Send());
    }
}
```
Agora você pode atribuir as variáveis a cada uma das interface e usar!

### Mas espera um pouco!

Eu não poderia fazer isto usando uma [Factory](https://refactoring.guru/design-patterns/factory-method/csharp/example) ? sim, Você poderia, ma criar uma factory pode ser um trabalho um tanto complexo e esta nova funcionalidade resolve muito bem o problema. 

### Considerações
Existe muitos cenários onde temos uma interface e diversas implementações. Este recurso permite que possamos simplificar o nosso código e torná-lo mais eficiente!

Mas lembre-se que cada solução pode exigir um tipo de abordagem, então estude bem o seu cenário e veja o que mais se adequa a ele!

O código fonte deste exemplo pode ser encontrado no meu GitHub: https://github.com/carloscds/CSharpSamples/tree/master/InjecaoDependencia-KeyedServices

Abraços e até a próxima!

---
title: 'ASP.NET Worker - Criando jobs dentro da sua aplicação'
date: 2025-06-03
author: carloscds
layout: post
categories:
  - C Sharp
  - ASP.NET
---
Vamos começar este artigo explicando o que é um "job". Um job é um serviço que vai rodar de forma autônoma na nossa aplicação, sem a interferência de nenhuma chamada ou usuário, apenas respeitando uma regra básica, que pode ser um timer, um loop, etc.

Então podemos criar em uma aplicação ASP.NET, um código que é sempre executado em um determinado tempo, com um timer, e o melhor, este mecanismo é nativo da plataforma, não precisamos instalar nenhum pacote adicional.

## Antes de iniciarmos, vamos criar um projeto base para os nossos testes

Neste exemplo estou criando um projeto console ASP.NET 9, do tipo "ASP.NET Core Web Api", bem padrão do Visual Studio, deixando o Top Level e sem Controllers.

Após criarmos o projeto teremos a seguinte estrutura:

![]( wp-content/uploads/2025/06/ASPNETCore-Worker-ProjetoBasico.png)

E o código do Program.cs:


```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddOpenApi();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();
app.MapGet("/", () => "Exemplo de API com Worker");
app.Run();
```

Até aqui temos o famoso "Hello World".

## Agora vamos colocar um Worker

Para adicionar um Worker, vou criar uma pasta "Workers" no projeto e dentro dela vou criar um arquivo chamado "TimerWorker.cs", que terá este conteúdo:

```csharp
namespace ExemploWorker.Workers
{
    public class TimerWorker : IHostedService
    {
        private readonly ILogger<TimerWorker> _logger;
        private Timer? _timer;

        public TimerWorker(ILogger<TimerWorker> logger)
        {
            _logger = logger;
        }
        public Task StartAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("Iniciando o Timer Worker.");
            _timer = new Timer(DoWork, null, TimeSpan.Zero, TimeSpan.FromSeconds(1));
            return Task.CompletedTask;
        }
        private void DoWork(object? state)
        {
            _logger.LogInformation("Tempo contando: {time}", DateTimeOffset.Now);
        }
        public Task StopAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("Parando o Timer Worker.");
            _timer?.Change(Timeout.Infinite, 0);
            return Task.CompletedTask;
        }
    }
}
```

Um worker basicamente herda a clase **IHostedService**, que implementa o *StartAsync()* e o *StopAsync()*, que são chamados no inicio da execução e ao término.

O nosso exemplo é um worker baseado em um timer, e sendo assim, temos uma classe **Timer** que estsá configurada para disparar a cada 1 segundo, e executar o método **DoWork**, que é quem de fato irá realizar o trabalho.

No exemplo estou usando a interface padrão **ILogger** para mostrar várias mensagens na console da aplicação, sendo uma delas a execução do timer a cada segundo.

**Resumindo:** temos uma classe que tem um timer, que é disparado a cada segundo e executa uma ação!

Mas veja que não é somente criar a classe do Worker, você também precisa adicionar o *middleware* para iniciar este código, e isto nós fazemos no *Program.cs* colocando a linha abaixo:

```csharp
builder.Services.AddHostedService<TimerWorker>();
```
Agora temos o TimerWorker adicionado ao nosso pipeline de execução, e ao rodar a aplicação temos a seguinte saída:

![]( wp-content/uploads/2025/06/ASPNETCore-Worker-SaidaTela.png)

Viram como é bem simples!

## Dica valiosa para injeção de dependência no Worker

Provavelmente você irá usar a injeção de dependência dentro do seu worker (não sabe o que é isto, tenho vários artigos sobre o tema aqui no blog), mas um worker funciona como uma classe estática e tem uma maneira um pouco diferente para fazermos a injeção.

Para ilustrar uma injeção de dependência eu vou adicionar uma interface *ISendEmail.cs* e uma classe *SendEmail.cs*, que vão simular um código para envio de email.

Primeiro a interface:

```csharp
namespace ExemploWorker.Services
{
    public interface ISendEmail
    {
        void Enviar();
    }
}
```

E agora a classe:

```csharp
namespace ExemploWorker.Services
{
    public class SendEmail : ISendEmail
    {
        private readonly ILogger<SendEmail> _logger;
        public SendEmail(ILogger<SendEmail> logger)
        {
            _logger = logger;
        }
        public void Enviar()
        {
            _logger.LogInformation("E-mail enviado com sucesso!");
        }
    }
}
```
Por fim, vamos adicionar ao DI (Dependency Injection) no *Program.cs*


```csharp
builder.Services.AddScoped<ISendEmail, SendEmail>();
```

Até agora tudo normal, então vamos usar o *SendEmail* no nosso worker através da DI:

```csharp
using ExemploWorker.Services;

namespace ExemploWorker.Workers
{
    public class TimerWorker : IHostedService
    {
        private readonly ILogger<TimerWorker> _logger;
        private Timer? _timer;
        private readonly ISendEmail _sendEmail; // enviar email

        public TimerWorker(ILogger<TimerWorker> logger, ISendEmail sendEmail)
        {
            _logger = logger;
            _sendEmail = sendEmail; // enviar email 
        }
        public Task StartAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("Iniciando o Timer Worker.");
            _timer = new Timer(DoWork, null, TimeSpan.Zero, TimeSpan.FromSeconds(1));
            return Task.CompletedTask;
        }
        private void DoWork(object? state)
        {
            _logger.LogInformation("Tempo contando: {time}", DateTimeOffset.Now);
            _sendEmail.Enviar(); // enviar email
        }
        public Task StopAsync(CancellationToken cancellationToken)
        {
            _logger.LogInformation("Parando o Timer Worker.");
            _timer?.Change(Timeout.Infinite, 0);
            return Task.CompletedTask;
        }
    }
}
```

Vamos executar e ver resultado!

![]( wp-content/uploads/2025/06/ASPNETCore-Worker-ErroDI.png)

Um belo de um erro! Mas por que ?

Simples, o Worker funciona como uma classe estática, um Singleton, e assim, não é possivel pegar um objeto instanciado.

Como resolvemos isto ???

### Injeção de dependências com Scoped

Vamos buscar a classe de email de uma outra maneira, usando o ServiceProvider, veja:

```csharp
private Timer? _timer;
private readonly ISendEmail _sendEmail; // enviar email

public TimerWorker(ILogger<TimerWorker> logger, IServiceProvider service)
{
    _logger = logger;
    var scope = service.CreateScope().ServiceProvider; // criar escopo para injeção de dependência
    _sendEmail = scope.GetRequiredService<ISendEmail>(); // enviar email
}
```

Mudamos apenas o construtor do Worker, nele criamos o *scope*  com o *ServiceProvider* e depois buscamos a instância da classe que queremos!

Pronto, agora você tem uma API em ASP.NET com um Worker funcionando:

![]( wp-content/uploads/2025/06/ASPNETCore-Worker-EmailEnviado.png)


### Considerações
As vezes é necessário criarmos um job dentro de uma aplicação web e neste cenário, o Worker pode ser bastante útil!

O código fonte do exemplo está no meu [GitHub](https://github.com/carloscds/CSharpSamples/tree/master/ASPNET-Worker/ExemploWorker).

Abraços e até a próxima!

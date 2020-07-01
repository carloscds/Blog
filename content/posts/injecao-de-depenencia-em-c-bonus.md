---
id: 10426
title: 'Injeção de Dependência em C# - Bônus'
date: 2020-02-27
author: carloscds
layout: post
categories:
  - DotNet Core
  - Asp.Net
  - C Sharp
  - EntityFramework Core
---
No último artigo desta série, vou mostrar duas coisas bem simples: primeiro como usar o EntityFramework Core em memória e como invocar uma dependência injetada sem usar o construtor da classe!

Mas porque você não iria injetar a dependência no construtor, como eu mostrei nos artigos anteriores? Bom, as vezes é necessário usarmos mecanismo alternativos para simplificar o desenvolvimento e termos acesso aos objetos!!!

#### EntityFramework Core

Durante muitos anos eu escrevi sobre EF, mas como houve um atraso muito grande no desenvolvimento do EF Core, eu acabei utilizando outros ORMs em projetos. Mas agora o EF Core está bem interessante e voltei a utilizá-lo em um projeto bem grande!

Assim, resolvi complementar esta série mostrando um recurso extremamente útil do EF Core que é o banco de dados em memória.

Mas porque tão util? Bem imagino que você desenvolva usando um banco de dados de "desenvolvimento" ou até mesmo local na sua máquina, o que é perfeitamente normal, mas com o tempo este banco pode ficar "sujo"8221; ou com dados "viciados", aí temos que limpar e começar tudo de novo.

Pense então que você pode manter um banco inteiro em memória, realizando as mesmas operações que faria no banco normal, mas sem gravar nada em lugar algum, a não ser na memória.

Este recurso é muito valioso para testes unitários, e eu espero realmente que você esteja escrevendo testes hein!!!

_Para este exemplo vamos criar um projeto ASP.NET Core WebAPI._ 

#### Criando o Contexto do EF Core

A primeira coisa que faremos será criar uma classe (tabela) e o contexto do Entity. Teremos uma classe simples de _Cliente_:<figure class="wp-block-embed">

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InjecaoDependenciaDiretaEF.Models
{
    public class Cliente
    {
        public int Id { get; set; }
        public string Nome { get; set; }
        public decimal LimiteCredito { get; set; }
    }
}
```

Agora vamos ao contexto:

```csharp
using InjecaoDependenciaDiretaEF.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InjecaoDependenciaDiretaEF.Data
{
    public class AplicacaoContext : DbContext
    {
        public AplicacaoContext(DbContextOptions<AplicacaoContext> options) : base(options) 
        {
            SeedData();
        }
    
        public DbSet<Cliente> Cliente { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Entity<Cliente>()
                .Property(p => p.Id)
                .IsRequired();
            builder.Entity<Cliente>()
                .Property(p => p.Nome)
                .HasMaxLength(100);

            base.OnModelCreating(builder);
        }

        private void SeedData()
        {
            Cliente.Add(new Models.Cliente { Nome = "Carlos", LimiteCredito = 1000 });
            Cliente.Add(new Models.Cliente { Nome = "Maria", LimiteCredito = 5000 });
            Cliente.Add(new Models.Cliente { Nome = "Jose", LimiteCredito = 500 });
            Cliente.Add(new Models.Cliente { Nome = "Joana", LimiteCredito = 600 });
            SaveChanges();
        }

    }
}
``` 

Nosso contexto não tem nada demais, a não ser um método SeedData() que estou usando para preencher a classe _Cliente_ em memória.

Lembre-se que estou usando um banco em memória, então para ter dados, preciso preencher este banco quando inicializo o contexto!

#### Configurando o Startup.cs

Agora vamos configurar os serviços na classe Startup:

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllers();

    services.AddDbContext<AplicacaoContext>(options =>
        options.UseInMemoryDatabase("DBMemory"));

    services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
    services.AddScoped<IEnvioEmail, EnvioEmail>();
}
```

Veja que estamos adicionando um contexto com a opção "UseInMemoryDataBase()"

Para utilizar este método você vai precisar dos seguintes pacotes do Entity:

**Microsoft.EntityFrameworkCore  
Microsoft.EntityFrameworkCore.InMemory**

O pacote InMemory é o responsável por permitir o banco de dados em memória. Veja que você pode simplesmente trocar o "UseInMemoryDataBase()" por "UseSqlServer()" ou qualquer outro banco e tudo continua funcionando!

Quando eu escrevo testes unitários, crio um contexto InMemory() e na aplicação real uso um banco de dados! Isto facilita muito o meu trabalho!

Então estamos injetando um contexto de EntityFramework no nosso projeto através do _AddDbContext()_ , e também duas outras classes: _IHttpContextAccessor_ e _IEnvioEmail_, usando Singleton e Scoped, que mostrei no [artigo anterior](http://carloscds.net/2020/02/injecao-de-dependencia-em-c-parte-2/).

O IHttpContextAccessor nos permite acessar o contexto Http do ASP.NET Core em qualquer lugar onde ele for injetado e o _IEnvioEmail_ é uma classe exemplo que criei para simular o envio de email.

Veja aqui a interface _IEnvioEmail_ e a classe _EnvioEmail_:

***Interface***
```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InjecaoDependenciaDiretaEF.Services
{
    public interface IEnvioEmail
    {
        string Enviar();
    }
}
```

***Classe***
```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InjecaoDependenciaDiretaEF.Services
{
    public class EnvioEmail : IEnvioEmail
    {
        public string Enviar() => "Email Enviado";
    }
}
```

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InjecaoDependenciaDiretaEF.Services
{
    public class EnvioEmail : IEnvioEmail
    {
        public string Enviar() => "Email Enviado";
    }
}
``` 

Esta classe apenas "simula" o envio de um email, imagino que você irá implementar uma classe real para isto!

#### Trabalhando a injecão na Controller

Agora que temos o nosso ambiente montado, vamos a criar uma controller para trabalhar estes dados. Iremos criar a _ClienteController.cs_ que terá duas actions: _Get()_ para trazer todos os clientes e _Email()_ para "simular" o envio de email.

Vamos ao código:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using InjecaoDependenciaDiretaEF.Data;
using InjecaoDependenciaDiretaEF.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.DependencyInjection;
using InjecaoDependenciaDiretaEF.Services;

namespace InjecaoDependenciaDiretaEF.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ClientesController : ControllerBase
    {
        private readonly ILogger<ClientesController> _logger;
        private readonly AplicacaoContext _db;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public ClientesController(
            ILogger<ClientesController> logger,
            AplicacaoContext db,
            IHttpContextAccessor httpContextAccessor)
        {
            _logger = logger;
            _db = db;
            _httpContextAccessor = httpContextAccessor;
        }

        [HttpGet]
        public IEnumerable<Cliente> Get()
        {
            return _db.Cliente;
        }

        [HttpGet]
        [Route("Email")]
        public string Email()
        {
            var email = _httpContextAccessor.HttpContext.RequestServices.GetService<IEnvioEmail>();
            return email.Enviar();
        }

    }
}
```

Muito bem, temos muitas coisas acontecendo aqui e vamos explicá-las:

No construtor da Controller estamos recebendo alguns objetos por injeção:

***
_ILogger logger_; //log do ASP.NET Core  
_AplicacaoContext db_ = nosso contexto do Entity Framework  
_IHttpContextAccessor_ httpContextAccessor = HttpContext da aplicação
***

Todos estão atribuídos a variáveis dentro da controller. Então vamos aos métodos que nos interessam.

O método _Get()_ simplesmente retorna todos os clientes do banco, que no nosso caso estão na memória apenas!

O outro método, _Email()_, é o que vamos mostrar a "invocação" de uma dependência sem o contrutor.

#### Entendendo o cenário

Isto é mais comum do que você pensa! Neste nosso projeto, precisamos enviar um email e a classe email está na injeção de dependência (configuramos no Startup.cs), mas não colocamos no construtor da controller pois é um método pouco usado e não justifica neste caso, hipoteticamente! Ou ela simplesmente está "injetada dentro de uma outra classe, o que é mais comum ainda! De qualaquer maneira, não temos esta classe diretamente disponível.

Sendo assim, vamos "materializar" o objeto, buscando-o no injetor de dependências, veja como é simples:

```csharp
_var email = _httpContextAccessor.HttpContext.RequestServices.GetService<IEnvioEmail>();_
```

Vamos entender:  
__httpContextAccessor_ é o contexto Http da aplicação, que tem o _HttpContext_ e o _Request_, que é a requisição para a página.

Usamos o _RequestServices.GetServices<IEnvioEmail>()_ que basicamente "pede" para o injetor de dependências nos "dar" o objeto correspondente a interface _IEnvioEmail_.

Isto é muito legal, pois você está "injetando" um objeto na mão, ou seja, está pegando um objeto que já está criado e trazendo para a variável "_email_".

E agora é só usar o email!

Executando a aplicação teremos o seguinte resultado: 

![]( wp-content/uploads/2020/02/image-6.png)

Agora chamando o email: 

![]( wp-content/uploads/2020/02/image-7.png)

#### Conclusão

O mecanismo de injeção de dependência nos permite simplificar muito o desenvolvimento! Mas use com cuidado, pois tudo em excesso é prejudicial!

Um agradecimento especial ao meu amigo [Rafael Almeida](http://ralms.net/), com quem "discuto" frequentemente sobre EntityFramework!!! Alias estas discussões ja geraram melhorias no EF Core, como por exemplo "WithNoLock()".

Como sempre, o código do exemplo está no meu [Github](https://github.com/carloscds/CSharpSamples/tree/master/InjecaoDependenciaDiretaEF). 

Abraços e até a próxima!
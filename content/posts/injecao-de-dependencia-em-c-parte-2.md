---
id: 10414
title: 'Injeção de Dependência em C# – Parte 2'
date: 2020-02-25T01:10:29-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10414
permalink: /2020/02/injecao-de-dependencia-em-c-parte-2/
image:  wp-content/uploads/2020/02/Dependency-Injection-ASP.NET-Core-175x131.png
categories:
  - .Net Core
  - Asp.Net
  - 'C#'
---
Na [parte 1 desta série](http://carloscds.net/2020/02/injecao-de-dependencia-em-c-parte-1/) falamos sobre como funciona a injeção de dependência e até criamos um exemplo usando NInject. um famoso mecanismo de DI (depency injection).

Neste artigo vamos falar como o ASP.NET Core revolucionou a injeção de dependência, incorporando este mecanismo ao seu núcleo. Isto significa que agora já temos o mecanismo nativamente implementado, sem a necessidade de uma ferramenta de terceiros.

Uma outra coisa interessante sobre este mecanismo no ASP.NET Core é que ele ficou muito mais simples e dinâmico, tornando o código mais legível.

#### Alguns conceitos importantes

Injetar dependências significa que podemos ter acesso a um objeto sem, necessariamente, instanciar diretamente este objeto, e também compartilhar a mesma instância deste objeto dentro de uma chamada (Request). Quem irá instanciar e gerenciar o objeto para nós é o mecanismo de injeção de dependência do ASP.NET Core. Confuso??? Pera, vamos melhorar um pouco!

Ter acesso a um objeto gerenciado pelo mecanismo de injeção significa que deixamos por conta dele a criação e destruição deste objeto e nos preocupamos apenas em consumi-lo.

E o que significa isto? É simples, iremos "indicar" o objeto e receberemos a instância deste objeto dentro da classe onde vamos utilizá-lo. 

E para esclarecer, uma chamada (request) é cada vez que você aciona algo dentro da sua aplicacão, ou seja, cada POST, GET, PUT, DELETE que é executado. 

Ok, então eu digo ao ASP.NET Core para criar e apagar meus objetos? Como ele faz isto?

#### Tipos de injeção de Dependência do ASP.NET Core

Existem três maneiras diferentes do ASP.NET Core criar e manter objetos na injeç!ao de dependência:

  * Transient
  * Scoped
  * Singleton

**Transient**  
A cada chamada todos os objetos são criados novamente, ou seja, cada vez que chamamos a nossa aplicação, tudo é instanciado de novo, nenhum estado é mantido.

**Scoped**  
Os objetos são compartilhados dentro de uma mesma chamada, ou seja, todas as instâncias do objeto serão mantidas enquanto durar a chamada. Isto significa que se você usa um mesmo objeto em vários momentos do código, dentro de um mesmo fluxo de chamada, este objeto poderá manter a mesma instância.

**Singleton**  
Os objetos serão compartilhados por todas a aplicação, independente da chamada, ou seja, sempre iremos acessar o mesmo objeto, incusive independente do usuário. Então cuidado com isto!

#### Vamos a um exemplo prático

Iremos criar uma aplicação ASP.NET Core API usando o .NET Core 3.1 (o mesmo pode ser feito com uma asplicação MVC). 

Então para tornar o exemplo bem simples, vou criar uma interface chamada _IServico_ com um método _RetornaValor()_. Vou criar também uma classe chamada _Servico_, que irá implementar esta interface: 

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InjecaoDependenciaASPNETCore
{
    public interface IServico
    {
        string RetornaValor();
    }
}
```

E agora a implementação da classe Servico.cs:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InjecaoDependenciaASPNETCore
{
    public class Servico : IServico
    {
        private int contador;
        public Servico()
        {
            contador = 0;
        }
        public string RetornaValor()
        {
            contador++;
            return $"Servico: {contador}";
        }
    }
}
```

A idéia é mostrarmos o valor do "contador" de acordo com o tipo de dependência.

Agora imagine que esta classe _Servico_ esteja sendo utilizada em várias partes da aplicação, e que dentro de uma mesma chamada, você irá acessar dados desta classe mais de uma vez.

Para exemplificar isto, vou criar uma classe _ExecutaServico_, que também irá usar a classe _Servico_, mas receberá esta classe por injeção de dependência, veja:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InjecaoDependenciaASPNETCore
{
    public class ExecutaServico
    {
        private readonly IServico _servico;
        public ExecutaServico(IServico servico)
        {
            _servico = servico;
        }

        public string RetornaServicoExecutado() => _servico.RetornaValor();
    }
}
```

Este classe recebe uma interface _IServico_ no seu construtor, que é atribuída a uma variável e depois chamada no método _RetornaServicoExecutado()_.

O mecanismo de injeção de dependência se encarregará de criar o objeto e passar para o construtor da classe.

Agora vamos colocar o código na nossa controller Home:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace InjecaoDependenciaASPNETCore.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class HomeController : ControllerBase
    {
        private readonly IServico _servico;
        private readonly ExecutaServico _executaServico;
        public HomeController(IServico servico, ExecutaServico executaServico)
        {
            _servico = servico;
            _executaServico = executaServico;
        }

        [HttpGet]
        public string Get()
        {
            var textoServico = _servico.RetornaValor();
            var textoExecutaServico = _executaServico.RetornaServicoExecutado();
            return $"Servico: {textoServico} - ExecutaServico: {textoExecutaServico}";
        }
    }
}
```

A nossa controller recebe dois objetos por injeção: _IServico_ e ExecutaServico, mas a classe _ExecutaServico_ também recebe um _IServico_. Isto quer dizer que temos dois locais na nossa aplicação exemplo que usam o objeto _Servico_.

Para você entender melhor, veja que o construtor da classe recebe as instâncias (variáveis _servico_ e _executaServico_) e estas são armazenadas em variáveis dentro da própria classe _(_servico_ e __executaServico_), no construtor. Quem instancia e passa estes parâmetros é o mecanismo de injeção de dependência.

#### Agora vamos configurar a injeção de dependência

Um projeto ASP.NET Core possui uma classe chamada **Startup.cs**, e é nela que fazemos as configurações da nossa aplicação, incluindo a injeção de dependência. Nesta classe existe o método **ConfigureServices()**, onde fazemos estas configurações.

Vale lembrar também que existe um objeto Configuration na nossa aplicação ASP.NET Core, que traz os dados do arquivo "appsettings.json" por injeção de dependência, ou seja, em qualquer classe que você colocar o IConfiguration, terá acesso as estas configurações.

Seguindo com o exemplo, vamos primeiro colocar a injeção de dependência como "Transient":

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllers();

    services.AddTransient<IServico, Servico>();
    services.AddTransient<ExecutaServico, ExecutaServico>();
}
``` 

Ao executar a nossa aplicação pela primeira vez temos o seguinte resultado: 

![]( wp-content/uploads/2020/02/image-1.png)

Veja que temos o mesmo resultado tanto para "Serviço", quanto para "ExecutaServico", isto porque o "Transient" diz para instanciar todos os objetos na chamada, então temos DUAS instâncias de Servico()

Agora vamos mudar para "Scoped":

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllers();

    services.AddScoped<IServico, Servico>();
    services.AddScoped<ExecutaServico, ExecutaServico>();
}
```

E novamente vamos executar a aplicação:

![]( wp-content/uploads/2020/02/image-2.png)

Agora temos dois valores diferentes, porque se trata do mesmo objeto durante a chamada, ou seja, é a mesma classe Servico(), uma única instância! Assim no primeiro retorno o valor é 1 e no segundo é 2, pois o contador foi incrementado.

Por fim, vamos colocar o Singleton:

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllers();

    services.AddSingleton<IServico, Servico>();
    services.AddSingleton<ExecutaServico, ExecutaServico>();
}
```

E vamos executar novamente:

![]( wp-content/uploads/2020/02/image-3.png)

A primeira execução é igual ao Scoped, mas veja a segunda:

![]( wp-content/uploads/2020/02/image-4.png)

O valores continuam mudando, pois a instância agora é para TODAS as chamadas da aplicação, e isto independente do usuário ou browser. Veja uma chamada de outro browser:

![]( wp-content/uploads/2020/02/image-5.png)

O valores vão mudando a cada chamada, pois o Singleton diz que "existirá" somente um objeto e ele será público para toda a aplicação.

#### Conclusão

O tipo de injeção de dependência ue você irá usar depende do tempo de vida do seu objeto, por exemplo:

  * Se você nao precisa manter o estado do objeto, use TRANSIENT
  * Se precisa compatilhar dados dentro da mesma chamada, use SCOPED
  * E se precisar manter os "mesmos" dados durante toda a aplicação, use SINGLETON.

Espero ter ajudado a entender um pouco mais deste fantástico mecanismo!

Como sempre, o código do exemplo está no meu [Github](https://github.com/carloscds/CSharpSamples/tree/master/InjecaoDependenciaASPNETCore).

[Veja a teceira parte desta série!](http://carloscds.net/2020/02/injecao-de-depenencia-em-c-bonus/)

Abraços e até a próxima!
---
id: 10403
title: 'Injeção de Dependência em C# - Parte 1'
date: 2020-02-13T23:16:24-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10403
permalink: /2020/02/injecao-de-dependencia-em-c-parte-1/
image:  wp-content/uploads/2020/02/di-175x131.jpg
categories:
  - DotNet
  - DotNet Core
  - C Sharp
---
Olá,

Hoje em dia muito se tem se falado muito em injeção de dependência, principalmente se você desenvolve ou está começando a desenvolver com ASP.NET Core.

Mas que realmente significa "injetar" uma dependência e o que é a tal dependência?

#### Conceito

Injeção de dependência é um padrão de projeto que permite baixo acoplamento do código!

Ai você se pergunta, mas o que é acoplamento do código? Sendo bem simplista, é um código que possui uma alta dependência de um outro código, onde o relacionamento entre os dois é muito forte!

Por exemplo, você tem uma classe de acesso a banco de dados como o código abaixo:

```charp
public class AcessoBanco
{
    SqlConnection _conexao;
    public AcessoBanco(SqlConnection conexao)
    {
        _conexao = conexao;
    }
}
```

No exemplo acima este código só funciona com SqlConnection! Então se você precisar mudar de banco de dados, terá que reescrever o código.

Agora vamos a um exemplo com baixo acoplamento:

```csharp
public class AcessoBanco
{
   IDbConnection _conexao;
   public AcessoBanco(IDbConnection conexao)
   {
       _conexao = conexao;
   }
}
```

Agora estamos implementando IDbConnection, que é a interface implementada pelo SqlConnection. Então temos um código desacoplado do banco, pois qualquer conexão que implemente IDbConnection poderá ser passada para nossa classe!

Este é o princípio da injeção de dependência!

#### Um exemplo básico de injeção de dependência

Vamos escrever um código bem simples em C# para entendermos como este mecanismo da interface funciona!

Lembre-se que ao referenciar uma Interface você precisa implementar todos os seus métodos!

PS: Somente para tornar mais didático, vou colocar as classes e a interface em um único arquivo, mas em seu projeto coloque-os separadamente!

```charp
using System;

public interface IServico
{
    public void Executa();
}

public class ServicoCarro : IServico
{
    public void Executa()
    {
        System.Console.WriteLine("Serviço executado no carro!");  
    }
}

public class ServicoMoto : IServico
{
    public void Executa()
    {
        System.Console.WriteLine("Serviço executado na moto!");
    }
}
```

Muito bem, temos uma interface IServico que possui um método Executa()

Temos duas classes: ServicoCarro e ServicoMoto que implementam a interface IServico, cada uma resolvendo seu problema.

Agora vamos criar a classe executora, que receberá a interface:

```csharp
using System;

namespace BasicDI
{
    public class ExecutaServico
    {
        private IServico _servico;
        public ExecutaServico(IServico servico)
        {
            _servico = servico;
        }

        public void Executa()
        {
            _servico.Executa();
        }
    }
}
```

Veja que nossa classe recebe a interface e depois chama o método Executa(). Agora temos um desacoplamento, pois podemos passar para a classe qualquer objeto que implemente a interface, mudando o objeto a ser executado, sem modificar o nosso código!

Vejam a execução:

```csharp
using System;
using System.Data;
using Microsoft.Data.SqlClient;

namespace BasicDI
{
    class Program
    {
        static void Main(string[] args)
        {
            var execCarro = new ExecutaServico(new ServicoCarro());
            execCarro.Executa();
            
            var execMoto = new ExecutaServico(new ServicoMoto());
            execMoto.Executa();

        }
    }

}
```


Na execução estamos passando duas classes diferentes para o mesmo executor, chamando o mesmo método, pois ambas implementam a mesma interface!

#### Mecanismos de injeção de dependência

Agora que você entendeu o princípio básico da injeção, deve estar pensando: O ASP.NET Core não faz isto e também no ASP.NET não era bem assim que se fazia! E você está certo! Este é o conceito!

O que se usa são os frameworks de injeção de dependência, que facilitam a vida para você, implementando este controle automaticamente.

Alguns dos frameworks mais conhecidos são:

  * NInject
  * SimpleInjector
  * Windsor

#### Exemplo com NInject

Como o NInject é um dos mais conhecidos, vamos montar um exemplo com ele. A idéia é basicamente a mesma, teremos uma Interface e uma classe que implementa esta interface.

A grande diferença agora é que não precisamos mais instanciar a classe! Opa como assim!

Isto mesmo, o mecanisco de injeção de dependência, neste caso o NInject, fará isto para nós "magicamente"!

Vamos ao exemplo!

Eu criei um projeto console com .NET Core 3.1, mas você pode usar outra versão do .NET caso prefira!

Primeiro precisamos adicionar o pacote do NInject:

![]( wp-content/uploads/2020/02/image.png) 

Agora temos a Interface e a Classe:

```csharp
using System;

namespace ExemploNInject
{
    public interface IServico
    {
        public void Executa();
    }

    public class MeuServico : IServico
    {
        public void Executa()
        {
            System.Console.WriteLine("Servico Executado!");
        }
    }
}
```

Agora vamos implementar a classe executora:

```csharp
using System;

namespace ExemploNInject
{
    public class ExecutaDI 
    {
        private IServico _servico;
        public ExecutaDI(IServico servico)
        {
            _servico = servico;
        }
        public void Executa()
        {
            _servico.Executa();
        }
    }
}
```

Por fim, vamos implementar o NInject:

```csharp
using System;
using Ninject;

namespace ExemploNInject
{
    class Program
    {
        static void Main(string[] args)
        {
            Ninject.IKernel inject = new StandardKernel();  
            inject.Bind<IServico>().To<MeuServico>();  
            var obj = inject.Get<ExecutaDI>();  
            obj.Executa();   
        }
    }
}
```

Primeiro criamos o objeto "inject" que contém o mecanismo do NInject.

Depois informamos ao NInject quem será injetado, ou seja, toda vez que a interface IServico for utilizada a classe MeuServico será criada e passada!

No construtor da classe executora nós colocamos a interface:

***
 _public ExecutaDI(IServico servico)_
***

Por último criamos a instância da classe executora e chamamos o método:

***
_var obj = inject.Get<ExecutaDI>();  
obj.Executa();_
***

Neste caso quem instanciou o objeto foi o NInject quando chamamos o "Get".

Assim não precisamos nos preocupar com a criação dos objetos! 

Então o NInject "injeta" um objeto da classe MeuServico toda vez que encontra uma interface IServico.

#### Conclusão

O injeção de dependência pode reduzir muito código da sua aplicação, deixando-a mais simples!

No próximo artigo vou mostrar o mecanismo de injeção de dependência do ASP.NET Core, que é simplesmente fantástico!

Os exemplos estão no meu Git: <https://github.com/carloscds/CSharpSamples> 

[Veja a segunda parte desta série!](http://carloscds.net/2020/02/injecao-de-dependencia-em-c-parte-2/)

Abraços e até a próxima!
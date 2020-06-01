---
id: 10248
title: 'EntityFramework asNoTracking - Por que preciso saber disto ?'
date: 2018-12-02T19:05:49-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10248
permalink: /2018/12/entityframework-asnotracking-por-que-preciso-saber-disto/
image:  wp-content/uploads/2018/12/AsNoTracking-175x131.jpg
categories:
  - Entity Framework
---
Fala pessoal,

Esta semana me deparei com um problema em um cliente que é bem comum, e causa muito transtorno, pois envolve muito o conceito de como o EF trabalha.

Quando você cria um contexto para o EF e indica as classes do mapeamento, basicamente diz a ele que todos os objetos deverão ser rastreados, ou seja, o simples fato de você criar um objeto ou ler a partir do contexto, coloca este objeto sobre o controle do EF.

**Vamos considerar o seguinte contexto:**

```csharp
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFAsNoTracking
{
    public class Contexto : DbContext
    {
        public DbSet<Categories> Categories { get; set; }
        public DbSet<Products> Products { get; set; }
    }
}
```

Agora vamos simular uma injeção de dependência, onde temos uma classe Dados que recebe o contexto:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFAsNoTracking
{
    public class Dados
    {
        private Contexto _contexto;
        public Dados(Contexto contexto)
        {
            _contexto = contexto;
        }

        public Categories GetCategory(int id) => _contexto.Categories.First(c => c.CategoryID == id);
    }
}
```

Vamos lembrar que o princípio básico da injeção de dependência é a propagação do objeto, neste caso temos apenas um Contexto, que é utilizado por todas classes através do mecanismo de injeção!

Vamos agora consultar o banco e trazer uma categoria:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFAsNoTracking
{
    class Program
    {
        static void Main(string[] args)
        {
            var db = new Contexto();

            var dados1 = new Dados(db);
            var cat = dados1.GetCategory(1);
            Console.WriteLine(cat.CategoryName);

        }
    }
}
```

A partir deste momento o objeto "cat" faz parte do mapeamento do EF, ou seja, ele irá fazer o tracker deste objeto, ou seja, controlar o status deste objeto perante o EF (novo, modificado, deletado, etc). Bom, até aí tudo bem, pois é exatamente isto que esperamos que ele faça.

O problema começa quando instanciamos outros objetos, lembrando que estamos em uma ambiente de injeção de dependência. Vamos então realizar uma nova consulta e também vamos listar os objetos que estão no tracker do EF:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFAsNoTracking
{
    class Program
    {
        static void Main(string[] args)
        {
            var db = new Contexto();

            var dados1 = new Dados(db);
            var cat = dados1.Get(1);
            Console.WriteLine(cat.CategoryName);

            var dados2 = new Dados(db);
            var cat2 = dados2.Get(2);
            cat2.CategoryName += " 2";

            var tracker = db.ChangeTracker.Entries();
            foreach(var t in tracker)
            {
                Console.WriteLine($"{t.Entity.ToString()}, {t.State}");
            }

        }
    }
}
```

Ao executar este código temos o seguinte resultado:

```shell
_Beverages_ 
_System.Data.Entity.DynamicProxies.
Categories_58C84246D9EE9DEB30950140620833728474B6132D2BC59BD4306359B33CE2A1, Modified_
_System.Data.Entity.DynamicProxies.
Categories_58C84246D9EE9DEB30950140620833728474B6132D2BC59BD4306359B33CE2A1, Unchanged_
```

Isto indica que o EF está mapeando os dois objetos, mesmo eles tendo sido consultados em diferentes instâncias da classe Dados, pois compartilham o mesmo contexto.

Sendo assim, se enviarmos um comando SaveChanges() e tivermos mudados os dois objetos, mesmo "sem querer", este serão enviados para o banco!

**E como resolvemos isto ???**

Exitem várias maneiras de resolvermos, e talvez a primeira que vem a sua cabeça é "vamos instanciar outro contexto", mas se eu fizer isto, qual o benefício da injeção de dependência neste caso ?

Para este tipo de situação temos o método "AsNoTracking()", que em termos bem simples diz ao contexto para não mapear o objeto!

Então vamos criar um outro método GetNoTracking() implementando esta chamada:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFAsNoTracking
{
    public class Dados
    {
        private Contexto _contexto;
        public Dados(Contexto contexto)
        {
            _contexto = contexto;
        }

        public Categories Get(int id) => _contexto.Categories.First(c => c.CategoryID == id);
        public Categories GetNoTracking(int id) => _contexto.Categories.AsNoTracking().First(c => c.CategoryID == id);
    }
}
```

Veja que somente adicionamos o AsNoTracking() após o objeto na consulta!

Agora vamos mudar a chamada do primeiro objecto, que neste exemplo é somente para leitura, ou seja, não iremos modificar nada nele:

```csharp
var db = new Contexto();

var dados1 = new Dados(db);
var cat = dados1.GetNoTracking(1);
Console.WriteLine(cat.CategoryName);
}
```

Executando novamente o código teremos um resultado diferente, ou seja, somente um objeto está mapeado pelo EF:

```shell
_Beverages_  
_System.Data.Entity.DynamicProxies.Categories_58C84246D9EE9DEB30950140620833728474B6132D2BC59BD4306359B33CE2A1, Modified_
```

**Resumindo:**

Se você está apenas consultando um objeto no EF, ou seja, não vai modificar e gravar, use AsNoTracking() sempre que possível.

Isto não quer dizer que você não possa instanciar outro contexto, mas evitar isto pode lhe dar um ganho de performance!

O código fonte esta no meu GitHub: <https://github.com/carloscds/CSharpSamples/tree/master/EFAsNoTracking>

E isto aí pessoal e até a próxima!  
Carlos dos Santos.
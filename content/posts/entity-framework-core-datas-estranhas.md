---
id: 9643
title: Datas Estranhas no Entity Framework Core
date: 2021-03-22T21:30:00-00:00
author: carloscds
layout: post
categories:
  - DotNet Core
  - EntityFramework Core
  - C Sharp
tags:
  - publish
---
Olá pessoal,

Quando trabalhamos com bancos de dados e aplicações em fusos horários diferentes, é normal que façamos uma configuração no nosso código para ajustar a data e hora, certo ?

### Problema

O que acontece se você submeter uma consulta do tipo:

```SQL

select numero,data,valor 
      from pedido 
      where cast(data as date) = cast(getdate() as date)

```

A data utilizada aqui será a do bando de dados, não da sua aplicação. Ora, mas isto está na cara, não é ?

Vamos então criar a mesma consulta com EntityFramework Core

```CSharp

var dados = db.Pedido.Where(w => w.Data == DateTime.Now);

```

E agora, que data será enviada para o banco de dados ? A da aplicação ou a do banco ?

Neste caso o EntityFramework "traduz" a nossa consulta para:

```SQL

SELECT [p].[Numero], [p].[Data], [p].[Valor]
      FROM [Pedido] AS [p]
      WHERE [p].[Data] = GETDATE()

```

E temos um problema caso o banco esteja com o horário diferente da aplicação, pois para nós, a data enviada é a do DateTime.Now, quando na verdade foi pego a data do banco, dentro da query do SQL.

## Solução

Para resolver o problema é simples, criamos uma variável e passamos no Where: 

```CSharp

var hoje = DateTime.Now;
var dados = db.Pedido.Where(w => w.Data == hoje);

```

A diferença aqui é bem sutil, pois o EntityFramework pega uma variável pronta, com o valor e passa para o banco:

```SQL

SELECT [p].[Numero], [p].[Data], [p].[Valor]
      FROM [Pedido] AS [p]
      WHERE [p].[Data] = @__hoje_0

```
Veja que agora temos um "parametro" e não mais "getdate()"

#### Mas na inserção funciona normal

Verdade, quando você insere um objeto ele fica com a data da aplicação, pois você criou um objeto e mandou para o EntityFramework Core, neste caso o código abaixo em C#:

```CSharp

var novoPedido = new Pedido { Data = DateTime.Now, Valor = 400 };
db.Pedido.Add(novoPedido);
db.SaveChanges();

```

Se transforma neste código SQL:

```SQL

INSERT INTO [Pedido] ([Data], [Valor])
      VALUES (@p0, @p1);
      SELECT [Numero]
      FROM [Pedido]
      WHERE @@ROWCOUNT = 1 AND [Numero] = scope_identity();

```

Novamente os valores são passados como parâmetros para o banco.

### Concluindo

Isto pode parecer obvio se você trabalha com aplicação e bancos na mesma rede ou mesmo fuso horário, mas quando falamos de nuvem, isto pode mudar bastante e este cenário é mais comum do que parece!

Abraços e até a próxima,  
Carlos dos Santos.

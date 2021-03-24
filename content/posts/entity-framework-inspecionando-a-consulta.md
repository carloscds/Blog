---
id: 9643
title: Inspecionando as Consultas do Entity Framework Core
date: 2021-03-23T22:00:00-00:00
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

Você que é um usuário de EntityFramework, já parou para olhar as queries que são geradas no banco ? Eu sempre faço esta pergunta em empresas que atendo e a resposta na grande maioria das vezes é: NÃO.

Sempre ouço: o EntityFramework resolve isto para mim! Ele sabe como criar o melhor comando SQL para o banco, e muitas outras respostas!

Mas a grande verdade é que o EntityFramework não faz milagres!!!

Então o que fazer ?

### Começe a ver as queries geradas pelo EF

Você pode habilitar, de maneira muito simples, o LOG do EF Core e validar todas as queries que são enviadas para o banco.

Ao habilitar este log, você verá tudo que é submetido ao banco, cada comando SQL gerado pelo EF.

No nosso exemplo, vou mostrar as queries diretamente na console, pois acho mais simples para validar durante o desenvolvimento.

Uma coisa importante: Normalmente não mantemos estes logs ligados em produção, a não ser para identificar problemas, então é importante que você crie um mecanismo que pode ser ativado/desativado de acordo com o seu arquivo de configurações.

### Instalando os pacotes para o Log

Para ativarmos o Log, precisamos adicionar a referência para "Microsoft.Extensions.Logging;" e também o pacote abaixo:

```xml
<PackageReference Include="Microsoft.Extensions.Logging.Console" Version="3.1.13" />
```

No texto acima temos o pacote para o Log na Console. A versão pode mudar dependendo da versão do .NET que você está utilizando

### Configurando o uso do Log no EF

Para "ligar" o log no EF, precisamos adicionar a configuração do log no contexto, usando o comando abaixo:

```csharp
protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
{
      optionsBuilder.UseSqlServer("data source=(local); initial catalog=EFCoreSample; user id=teste; password=teste;")
                  .EnableSensitiveDataLogging()
                  .UseLoggerFactory(LoggerFactory.Create(builder => builder.AddConsole()));
}
```

Primeiramente estamos configurando o banco de dados, e vale ressaltar que este é um exemplo didático e a colocação da string diretamente no código não é recomendada. Coloque em um local externo, como um arquivo de configurações, por exemplo.

O comando "UseLoggerFactory()" informa ao EF para ligar o log e a classe LoggerFactory indica que vamos usar o Log na Console, e o "EnableSensitiveDataLogging()" inclui dados dos parâmetros no texto.

Você pode também enviar o Log para um arquivo, adicionando outros pacotes para o Log.

### Executando a aplicação

Vamos agora vamo executar um comando usando EF:

```csharp
var db = new Contexto();
var hoje = DateTime.Now;
var dados = db.Pedido.Where(w => w.Data == hoje).ToList();
```

Estas linhas produzem o seguinte texto na console:

```csharp
info: Microsoft.EntityFrameworkCore.Infrastructure[10403]
      Entity Framework Core 3.1.13 initialized 'Contexto' using provider 'Microsoft.EntityFrameworkCore.SqlServer' with options: SensitiveDataLoggingEnabled
info: Microsoft.EntityFrameworkCore.Database.Command[20101]
      Executed DbCommand (67ms) [Parameters=[@__hoje_0='2021-03-23T23:18:11'], CommandType='Text', CommandTimeout='30']
      SELECT [p].[Numero], [p].[Data], [p].[Valor]
      FROM [Pedido] AS [p]
      WHERE [p].[Data] = @__hoje_0
```

Veja que além do comando SQL, temos o valor que foi enviado como parâmetro para "hoje".

Então agora podemos "ver" o que o EF gerou e enviou para o banco de dados. Assim podemos ajustar nosso código para melhorar as queries enviadas.

### Concluindo

O uso de logs na aplicação ajuda a identificar problemas, melhorar a performance e também a qualidade do seu código, pois mostra o que está de fato acontecendo no seu ambiente.

Use logs com sabedoria e faça um DBA feliz! 

O exemplo deste post está no meu [Github](https://github.com/carloscds/CSharpSamples/tree/master/EFLog). 

Abraços e até a próxima,  
Carlos dos Santos.

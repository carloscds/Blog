---
title: '.NET 11 RC 1: como começar a testar sua aplicação'
date: 2026-10-05
author: carloscds
layout: post
categories:
  - C Sharp
  - ASPNET
---
O .NET 11 chegou ao **Release Candidate 1**! No post sobre o [Preview 6](/2026/08/dotnet11preview6novidades/), vimos algumas novidades da plataforma. Agora vamos preparar um ambiente para testar uma API e organizar a avaliação de uma aplicação que você já tem.

### O que muda com o RC 1?

Segundo o [anúncio oficial da Microsoft](https://devblogs.microsoft.com/dotnet/dotnet-11-rc-1/), esta versão tem **licença de suporte go-live**, permitindo seu uso em aplicações de produção com suporte. Ela continua sendo uma candidata a lançamento; isso não elimina a necessidade de validar suas dependências e os fluxos da aplicação.

### Preparando o SDK

Instale o SDK indicado no anúncio e confira o que está disponível na sua máquina:

```bash
dotnet --list-sdks
```

O exemplo deste post foi validado no Windows com o SDK **11.0.100-rc.1.26425.128**. A versão completa importa: ter apenas o runtime instalado não é suficiente para compilar o projeto.

Crie uma pasta para o experimento:

```bash
mkdir TesteDotNet11
cd TesteDotNet11
```

Dentro dela, crie um arquivo `global.json`:

```json
{
  "sdk": {
    "version": "11.0.100-rc.1.26425.128",
    "rollForward": "disable",
    "allowPrerelease": true
  }
}
```

O `global.json` seleciona o SDK usado pelos comandos. Com `rollForward` igual a `disable`, exigimos exatamente essa versão; `allowPrerelease` permite considerar versões de pré-lançamento. Isso ajuda a repetir o experimento mesmo quando há vários SDKs instalados. A [documentação do global.json](https://learn.microsoft.com/en-us/dotnet/core/tools/global-json) explica essas opções.

Confira a seleção ainda dentro da pasta:

```bash
dotnet --version
```

O resultado deve ser `11.0.100-rc.1.26425.128`. Se você estiver usando uma versão posterior, ajuste o arquivo e registre a versão usada nos testes.

### Criando uma API pequena

Vamos começar com o template vazio do ASP.NET Core:

```bash
dotnet new web -n MinhaApiRc1 -f net11.0 --no-restore
cd MinhaApiRc1
```

No `MinhaApiRc1.csproj`, o framework de destino será:

```xml
<TargetFramework>net11.0</TargetFramework>
```

Repare na diferença: o `global.json` escolhe o **SDK**, enquanto o `TargetFramework` define o **framework de destino** do projeto. Um não substitui o outro.

Substitua o conteúdo de `Program.cs` por:

```csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/status", () => Results.Ok(new
{
    aplicacao = "MinhaApiRc1",
    status = "ok",
    framework = System.Runtime.InteropServices.RuntimeInformation.FrameworkDescription
}));

app.Run();
```

Esse endpoint serve para conferir a execução do exemplo e a versão do runtime carregada. Em uma aplicação real, uma verificação de saúde também precisaria considerar os serviços dos quais ela depende.

### Compilando e executando o resultado publicado

Na pasta do projeto, execute:

```bash
dotnet restore
dotnet build -c Release --no-restore
dotnet publish -c Release --no-restore -o ./publicacao
dotnet ./publicacao/MinhaApiRc1.dll --urls http://127.0.0.1:5111
```

Abra `http://127.0.0.1:5111/status` no navegador. No teste deste exemplo, o build terminou sem erros ou warnings, a publicação foi gerada e a requisição retornou **HTTP 200** com este conteúdo:

```json
{
  "aplicacao": "MinhaApiRc1",
  "status": "ok",
  "framework": ".NET 11.0.0-rc.1.26425.128"
}
```

O SDK também exibiu a mensagem informativa `NETSDK1057`, indicando o uso de uma versão de pré-lançamento. Ela não impediu o build.

Use `Ctrl+C` no terminal para encerrar a API. Até aqui, verificamos criação, compilação, publicação e execução de um projeto pequeno. Esse é o ponto de partida para investigar uma aplicação maior.

### E na aplicação que já está em produção?

Minha sugestão é fazer a avaliação em uma branch própria e anotar o resultado de cada etapa:

1. **Registre a situação atual.** Execute o build e os testes na versão que a aplicação já usa. Guarde falhas existentes, tempos e respostas dos endpoints mais importantes para comparar depois.
2. **Revise SDK e frameworks.** Ajuste o `global.json` e os projetos que participarão do experimento. Inclua projetos de testes e confira referências entre projetos antes de alterar toda a Solution.
3. **Verifique dependências.** Confira a compatibilidade dos pacotes e faça atualizações de forma controlada, registrando quais versões mudaram.
4. **Execute os testes da aplicação.** Valide autenticação, consultas, gravações, serialização e integrações externas. Para cada falha, tente reduzir o cenário até identificar a mudança responsável.
5. **Publique em homologação.** Confira o SDK do agente de build, o runtime do servidor e as imagens de container usadas pela aplicação. Repita os fluxos principais no ambiente de destino.

Consulte também a lista de [breaking changes do .NET 11](https://learn.microsoft.com/en-us/dotnet/core/compatibility/11). Ela inclui mudanças de compilação e de comportamento: um projeto pode compilar e ainda apresentar diferenças durante a execução.

### Considerações

Começar com um projeto pequeno ajuda a confirmar que o ambiente está funcionando antes de investigar dependências e configurações de uma Solution inteira. Depois disso, você consegue comparar a aplicação atual com a versão em avaliação e transformar cada incompatibilidade encontrada em uma tarefa concreta.

Abraços e até a próxima!

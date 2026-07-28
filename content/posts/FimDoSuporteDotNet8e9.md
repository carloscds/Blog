---
title: '.NET 8 e 9 chegam ao fim do suporte: como planejar a migração para o .NET 10'
date: 2026-08-03
author: carloscds
layout: post
categories:
  - C Sharp
  - ASPNET
---
Você sabia que o **.NET 8** e o **.NET 9** vão parar de receber atualizações de segurança no dia **10 de novembro de 2026** ? Pois é, a Microsoft já confirmou o fim do suporte para as duas versões, e se você ainda tem aplicações rodando nelas, já passou da hora de começar a planejar a migração.

### Por que isto importa ?

O .NET 8 é uma versão **LTS (Long Term Support)**, então normalmente teria suporte por 3 anos. Já o .NET 9 é uma versão **STS (Standard Term Support)**, com ciclo mais curto, de 18 meses. O detalhe é que as duas datas de fim de suporte acabaram coincidindo, então quem está no 8 ou no 9 tem o mesmo prazo pela frente.

Depois dessa data, nenhuma das duas versões recebe mais:

* Patches de segurança;
* Correções de bugs;
* Suporte oficial da Microsoft.

Ou seja, continuar em produção com .NET 8 ou 9 depois de novembro é rodar sem rede de proteção.

### Para onde migrar ?

A recomendação é migrar direto para o **.NET 10**, que é a versão LTS mais recente (suporte até 2028). Se você está no .NET 9, o caminho é direto. Se está no .NET 8, também dá para pular direto para o 10, sem precisar passar pelo 9.

### Checando a versão atual do projeto

O primeiro passo é simplesmente olhar o `TargetFramework` no `.csproj`:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

Se você tem vários projetos na Solution (API, Core, Domain, Infra, como vimos [aqui](/2026/01/melhorandoorganizacaoprojeto/)), vale a pena listar todos antes de começar, para não esquecer nenhum projeto satélite (biblioteca, worker, testes).

### Migrando o TargetFramework

O update em si costuma ser tranquilo:

```xml
<PropertyGroup>
  <TargetFramework>net10.0</TargetFramework>
</PropertyGroup>
```

E depois rodar o update dos pacotes NuGet, principalmente os da própria Microsoft (`Microsoft.AspNetCore.*`, `Microsoft.EntityFrameworkCore.*`), que precisam acompanhar a versão do runtime:

```bash
dotnet outdated
dotnet add package Microsoft.EntityFrameworkCore --version 10.*
```

### O que mais observar

* **Breaking changes**: sempre existem, mesmo que poucos. Vale conferir a lista oficial de breaking changes do .NET 10 antes de subir para produção;
* **Dependências de terceiros**: bibliotecas que você usa (ex: geração de PDF, QRCode, etc) precisam ter build compatível com net10.0. Se lembra do meu post sobre [migração com Copilot](/2026/04/migreiumprojetocomcopilot/)? Foi exatamente esse tipo de dependência que deu mais trabalho;
* **Imagens de container**: se você publica em Docker, atualize a tag da imagem base (`mcr.microsoft.com/dotnet/aspnet:10.0`);
* **Pipelines de CI/CD**: confira se o agente de build já tem o SDK do .NET 10 instalado.

### Não dá para migrar agora, e daí ?

Se por algum motivo você não conseguir migrar antes de novembro, o ideal é pelo menos ter um plano documentado e uma data definida. Ficar parado em uma versão sem suporte, sem previsão de migração, é o pior cenário: nenhuma correção de segurança chega até você.

### Considerações

Migração de versão do .NET costuma ser mais simples do que parece, principalmente quando o projeto já está bem organizado e as dependências estão atualizadas. O prazo de novembro dá tempo de sobra para planejar com calma, então comece já revisando quais projetos estão em .NET 8 ou 9 na sua empresa.

Abraços e até a próxima!

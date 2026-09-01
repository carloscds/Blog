---
title: 'Analisando falhas de build com Copilot direto no VS Code (MSBuild Binlog)'
date: 2026-08-31
author: carloscds
layout: post
categories:
  - C Sharp
  - ASPNET
  - Copilot
---
Quem nunca ficou preso olhando um log de build gigante do MSBuild tentando entender por que um projeto quebrou? Pois a Microsoft lançou uma extensão para o VS Code, ainda em Preview, que coloca o Copilot para fazer esse trabalho de detetive por você: o **MSBuild Binlog Analyzer**.

### O problema que ela resolve

O `.binlog` (Binary Log) do MSBuild guarda tudo que aconteceu durante o build: cada target executado, cada task, tempos, erros e warnings. O problema é que analisar esse arquivo manualmente, mesmo com o Structured Log Viewer, exige um certo treino. A ideia da extensão é simples: em vez de você vasculhar o log, você pergunta para o Copilot.

### Instalando

A extensão está na Visual Studio Marketplace (`ms-dotnettools.msbuild-binlog-analyzer`). Os requisitos são:

* VS Code 1.99 ou superior;
* Assinatura do GitHub Copilot;
* .NET SDK instalado.

Por baixo dos panos ela conversa com um servidor MCP chamado **Microsoft.AITools.BinlogMcp**, que é instalado automaticamente no primeiro uso. Esse servidor expõe dezenas de ferramentas de análise de build via **Model Context Protocol**, e é isso que garante que as respostas do Copilot sejam baseadas no log de verdade, e não em achismo.

### Carregando um binlog

Tem três formas de carregar o log no VS Code:

* Command Palette → `Binlog: Load File`, apontando para um `.binlog` já gerado (`dotnet build -bl`);
* `Build & Collect Binlog`, que builda o projeto e já captura o log em um único passo;
* `Open in VS Code`, direto do Structured Log Viewer.

Se você optar por gerar o log manualmente com `dotnet build -bl`, ele é salvo por padrão como `msbuild.binlog` na pasta onde o comando foi executado (geralmente a raiz do projeto ou da Solution). Se preferir escolher o nome e o caminho, dá para passar explicitamente:

```bash
dotnet build -bl:build.binlog
```

Vale lembrar que o arquivo pode crescer bastante em builds grandes, então não custa colocar `*.binlog` no `.gitignore` para não versionar esse log sem querer.

### Perguntando para o Copilot

Com o log carregado, a extensão registra o participante `@binlog` no Copilot Chat, com alguns comandos prontos:

```
@binlog /errors       -> lista as falhas do build
@binlog /perf         -> aponta os gargalos de performance
@binlog /timeline     -> mostra a sequência de tasks executadas
@binlog /compare      -> compara dois builds
@binlog /summary      -> resumo geral do build
@binlog /incremental  -> explica o que disparou um rebuild
@binlog /buildcheck   -> roda diagnósticos adicionais
```

E também dá pra simplesmente perguntar em linguagem natural:

```
@binlog por que esse build falhou?
```

O Copilot responde com a causa raiz em português claro, sem você precisar rolar centenas de linhas de log. E tem mais: o botão **"Fix all issues"** deixa o Copilot alterar o projeto com problema, rebuildar e comparar o log de antes e depois do fix, tudo sem sair do editor.

### Comparando builds e pegando regressões

Um recurso que achei bem interessante é marcar um binlog como **baseline**. A partir daí, todo novo build é comparado automaticamente contra ele, e a barra de status mostra algo como `Build: +12% vs baseline`. Se algo piorou, aparece um node de **Regressions** detalhando:

* targets que ficaram mais lentos;
* diagnósticos (erros/warnings) que apareceram ou sumiram;
* diferenças de propriedades do MSBuild;
* mudanças de versão de pacotes NuGet.

Isso tira a análise do campo do "acho que ficou mais lento" e coloca em números concretos.

### Build Timeline e integração com CI/CD

A extensão também mostra um **Build Timeline**, com gráfico de barras da duração de cada target e task, permitindo clicar para investigar o que demorou mais. E para quem não gera o binlog localmente, dá para baixar logs direto de pipelines do **Azure DevOps** e do **GitHub Actions**, filtrando por branch ou PR.

### Veja o resultado de um arquivo analisado

![]( wp-content/uploads/2026/08/MSBuildBinlog.png)

### Vale a pena testar?

Como é Preview, ainda vale testar em projetos menos críticos antes de depender dela no dia a dia. Mas para quem lida com builds grandes, com múltiplos projetos na Solution, ter o Copilot já "grounded" no log real do MSBuild economiza bastante tempo comparado a garimpar o Structured Log Viewer na mão. O feedback do projeto é coletado no repositório [dotnet/skills](https://github.com/dotnet/skills/issues), caso você encontre algum problema ou queira sugerir algo.

### Considerações

Ferramentas de IA aplicadas a diagnóstico de build são um passo natural depois do que já vimos em posts anteriores sobre o Copilot ajudando em [migração de projetos](/2026/04/migreiumprojetocomcopilot/). A diferença aqui é o foco: em vez de reescrever código, o Copilot vira um assistente de troubleshooting de build, algo que todo mundo que já sofreu com um `dotnet build` quebrado vai apreciar.

Abraços e até a próxima!

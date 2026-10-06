# Plano de publicação quinzenal

Revisado em 05/10/2026 com base no anúncio [Announcing .NET 11 Release Candidate 1](https://devblogs.microsoft.com/dotnet/dotnet-11-rc-1/), publicado em 08/09/2026.

Os itens 1 a 3 permanecem como histórico concluído. Os itens pendentes foram substituídos por uma sequência sobre .NET 11, priorizando C#, ASP.NET Core e ferramentas usadas no dia a dia do blog.

Cadência: quinzenal, às segundas-feiras (intervalo de 14 dias), retomando em 12/10/2026. As datas do histórico foram preservadas conforme o plano anterior; as próximas são propostas editoriais.

## Histórico concluído

| Item | Data | Título sugerido | Fonte no devblogs | Arquivo |
|---|---|---|---|---|
| ~~1~~ | ~~03/08~~ | ~~".NET 8 e 9 chegam ao fim do suporte: como planejar a migração para o .NET 10"~~ | ~~.NET 8 and .NET 9 Will Reach End of Support on Nov 10, 2026~~ | ~~`content/posts/FimDoSuporteDotNet8e9.md`~~ ✅ |
| ~~2~~ | ~~17/08~~ | ~~"Novidades do .NET 11 Preview 6 para quem já usa .NET 10 em produção"~~ | ~~.NET 11 Preview 6 is Now Available~~ | `content/posts/DotNet11Preview6Novidades.md` ✅ |
| ~~3~~ | ~~31/08~~ | ~~"Analisando falhas de build com Copilot direto no VS Code (MSBuild Binlog)"~~ | ~~Analyze MSBuild Binary Logs with Copilot in VS Code~~ | `content/posts/AnalisandoBuildsComCopilotVSCode.md` ✅ |

## Próximas publicações

O item 4 está escrito, com data de publicação prevista para 12/10/2026. Os itens 5 a 8 permanecem pendentes, com arquivos ainda não criados. A coluna de referência aponta para as seções do anúncio-base; as notas de versão vinculadas ali devem orientar os exemplos.

| Item | Data | Título sugerido | Recorte prático | Referência no anúncio | Arquivo planejado |
|---|---|---|---|---|---|
| ~~4~~ | 12/10/2026 | ~~".NET 11 RC 1: como começar a testar sua aplicação"~~ | API validada com o SDK RC 1, roteiro de avaliação e suporte go-live. | Introdução e Get started | `content/posts/DotNet11RC1.md` ✅ Escrito |
| 5 | 26/10/2026 | "C# 15: unions e serialização JSON na prática" | Modelar resultados de uma operação e explorar polimorfismo de tipos fechados no JSON. | C# e Libraries | `content/posts/CSharp15UnionsJson.md` |
| 6 | 09/11/2026 | "ASP.NET Core 11: renovando autenticação no SignalR e no Blazor" | Demonstrar renovação de autenticação e atualização de circuitos do Blazor Server. | ASP.NET Core | `content/posts/ASPNETCore11Autenticacao.md` |
| 7 | 23/11/2026 | "OpenAPI no ASP.NET Core 11: APIs obsoletas e ambientes de geração" | Marcar endpoints obsoletos e selecionar o ambiente ao gerar o documento durante o build. | ASP.NET Core | `content/posts/ASPNETCore11OpenAPI.md` |
| 8 | 07/12/2026 | "Publicando containers com .NET 11: imagens reproduzíveis" | Comparar duas publicações e investigar uploads redundantes. | SDK | `content/posts/DotNet11Containers.md` |

## Diretrizes para escrever os artigos

- Usar o RC 1 como ponto de partida e conferir a versão disponível na data de cada publicação. Atualizar exemplos e títulos quando necessário, informando o SDK efetivamente testado.
- No item 4, fazer referência ao post sobre Preview 6, concentrando o novo texto na preparação e validação de um projeto.
- Nos tutoriais, incluir pré-requisitos, código reproduzível e resultado observado. Não apresentar código apenas ilustrativo como exemplo executado.
- Manter o tom dos posts existentes, com introdução direta, exemplos em C# quando aplicáveis e links para as fontes oficiais.

## Pautas anteriores em reserva

Modernização com Copilot, diagnóstico de builds com MCP no GitHub Actions, canvas de upgrade, runtimes do MAUI e SkiaSharp ficam sem data. O antigo item 5 sobre MCP permanece em reserva; nesta revisão, o número 5 passa a identificar o artigo sobre C# 15 e JSON.

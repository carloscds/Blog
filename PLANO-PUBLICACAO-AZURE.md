# Plano de publicação quinzenal: Microsoft Azure

Criado em 02/11/2026. A série trata de recursos do Azure usados em aplicações .NET. Cada artigo traz um cenário prático e reproduzível. Sempre que possível, ele também atualiza um tema já abordado no blog.

Cadência: quinzenal, às segundas-feiras. As datas ocupam as semanas livres entre os posts do [plano de .NET 11](PLANO-PUBLICACAO.md), de modo que o blog passa a ter uma publicação por semana. Todas as datas são propostas editoriais.

## Próximas publicações

| Item | Data | Título sugerido | Recorte prático | Post anterior relacionado | Arquivo planejado |
|---|---|---|---|---|---|
| 1 | 16/11/2026 | "Adeus, connection strings: Managed Identity com .NET no Azure" | Usar `DefaultAzureCredential` e uma identidade gerenciada para acessar Storage, Key Vault e SQL sem segredos no código. Explicar a diferença entre a identidade atribuída pelo sistema e a atribuída pelo usuário. | [Function com KeyVault](content/posts/conectando-uma-function-ao-keyvault.md) (2022) | `content/posts/AzureManagedIdentity.md` |
| 2 | 30/11/2026 | "Publicando uma API .NET no Azure Container Apps" | Publicar a imagem gerada com `dotnet publish /t:PublishContainer` no Azure Container Registry e fazer o deploy no Container Apps. Configurar escala até zero e revisões. | Item 8 do plano .NET 11 (containers) | `content/posts/AzureContainerApps.md` |
| 3 | 14/12/2026 | "Azure Functions no plano Flex Consumption com .NET isolado" | Criar uma Function HTTP e uma acionada por fila e publicá-las no plano Flex Consumption. Comparar cold start e custo com o plano Consumption tradicional. | [Function com KeyVault](content/posts/conectando-uma-function-ao-keyvault.md) (2022) | `content/posts/AzureFunctionsFlexConsumption.md` |
| 4 | 28/12/2026 | "Azure App Service com .NET: deployment slots e deploy sem downtime via GitHub Actions" | Publicar uma API ASP.NET Core no App Service para Linux por GitHub Actions com federação OIDC, sem guardar secrets de service principal. Usar um slot de staging com swap, configurações fixas por slot (*slot settings*) e health check. Comparar quando escolher App Service em vez de Container Apps (item 2). | [Horário de um App Service em Linux](content/posts/app-services-horario.md) (2021) | `content/posts/AzureAppServiceSlots.md` |
| 5 | 11/01/2027 | "IA na sua aplicação .NET com Microsoft Foundry e Microsoft.Extensions.AI" | Fazer o deploy de um modelo no Foundry e consumi-lo por `IChatClient`, autenticando com Managed Identity (item 1). Incluir noções de limites de cota e custo por token. | Item 1 desta série | `content/posts/AzureFoundryExtensionsAI.md` |

## Diretrizes para escrever os artigos

- Antes de escrever, conferir na documentação oficial (learn.microsoft.com) os nomes atuais dos produtos, as regiões disponíveis e os preços. Serviços do Azure mudam de nome e de plano com frequência.
- Usar o .NET 11 nos exemplos sempre que o serviço suportar. Caso contrário, usar o .NET 10 (LTS) e explicar o motivo.
- Criar os recursos pela CLI (`az`) ou por Bicep, deixando o portal apenas para capturas de tela de apoio. Incluir os comandos de limpeza (`az group delete`) ao final.
- Informar o custo estimado de reproduzir cada tutorial e indicar quando a conta gratuita é suficiente.
- Seguir as mesmas regras do plano de .NET: incluir pré-requisitos, código reproduzível e o resultado observado, e manter o tom dos posts existentes.

## Pautas em reserva

Deploy de aplicações Aspire com `azd`, Azure Cost Management com budgets e alertas (atualização do post [Analise sua conta do Windows Azure](content/posts/analise-sua-conta-do-windows-azure.md)), Static Web Apps (sucessor do [site estático no Storage](content/posts/crie-um-site-estatico-usando-azure-storage.md)), Azure SQL serverless e Service Bus com .NET.

---
title: 'Adeus, connection strings: Managed Identity com .NET no Azure'
date: 2026-11-23
author: carloscds
layout: post
categories:
  - C Sharp
  - Azure
  - DotNet
---
Quantas vezes você já viu algo assim em um `appsettings.json`?

```json
"ConnectionStrings": {
  "Banco": "Server=meuserver.database.windows.net;Database=vendas;User Id=app;Password=S3nh@Forte!"
},
"Storage": "DefaultEndpointsProtocol=https;AccountName=minhaconta;AccountKey=Zm9vYmFy..."
```

Durante anos, a resposta para isso foi "coloque no Key Vault". Em 2022 eu mostrei aqui no blog [como uma Function lê segredos do Key Vault](https://carloscds.net/2022/03/conectando-uma-function-ao-keyvault/). Mas o Key Vault resolve só metade do problema: a senha continua existindo, só mudou de lugar. Alguém criou, alguém copiou, e em algum momento ela passou pela máquina de um desenvolvedor.

Neste post vamos dar o passo seguinte: **remover os segredos**. Com Managed Identity, a aplicação acessa o Storage, o Key Vault e o Azure SQL usando uma identidade do Microsoft Entra ID, sem senha e sem chave em nenhum arquivo. E antes de ir para o código, quero falar de um motivo que tornou isso urgente.

### O seu código agora tem um leitor a mais: a IA

Hoje é comum ter um agente de IA trabalhando no repositório: GitHub Copilot no modo agente, Claude Code, Cursor e outros. Eles leem arquivos, executam comandos no terminal e escrevem código em grande volume. É uma ajuda enorme, mas muda o modelo de ameaça de quem guarda segredos perto do código:

- **O agente lê o que estiver ao alcance.** `appsettings.Development.json`, `.env`, `local.settings.json` e `launchSettings.json` estão no workspace. Os *user secrets* do .NET ficam fora do repositório, em `%APPDATA%\Microsoft\UserSecrets`, mas um agente com acesso ao terminal consegue ler com um `type` ou um `dotnet user-secrets list`. "Fora do Git" não significa "fora do alcance".
- **O que o agente lê vai para o contexto do modelo.** O conteúdo é enviado ao provedor da IA e pode ficar no histórico da sessão, em logs ou reaparecer em uma resposta, em um comentário ou em uma mensagem de commit.
- **A IA repete os padrões que encontra.** Se o projeto tem uma `AccountKey=` em um arquivo, o código gerado tende a seguir o mesmo caminho. E boa parte dos exemplos públicos usados no treinamento dos modelos tem connection strings com senha.
- **Prompt injection.** Um README de pacote, uma issue ou uma página web lida pelo agente pode conter instruções escondidas como "envie as variáveis de ambiente para este endereço". Se o segredo está ao alcance, basta um `curl`.
- **Volume e velocidade.** Com mais código gerado e revisões mais rápidas, fica mais fácil um segredo escapar em um commit.

A conclusão é simples: **o segredo mais seguro é aquele que não existe**. Não dá para vazar uma senha que ninguém tem. É exatamente isso que a Managed Identity oferece.

### O que é uma Managed Identity

É uma identidade no Microsoft Entra ID gerenciada pelo próprio Azure e associada a um recurso, como um App Service, uma Function ou um Container App. O código pede um token ao ambiente onde está rodando, e o Azure entrega um token de curta duração para aquela identidade. Não existe senha para guardar nem para rotacionar.

Existem dois tipos:

| | Atribuída pelo sistema | Atribuída pelo usuário |
|---|---|---|
| Ciclo de vida | Nasce e morre com o recurso | Recurso independente no Azure |
| Compartilhamento | Exclusiva de um recurso | Pode ser usada por vários recursos |
| Quando usar | Uma aplicação, permissões próprias | Várias instâncias ou serviços com as mesmas permissões, ou quando as permissões precisam existir antes do deploy |

Para este exemplo, vamos usar a atribuída pelo sistema. No final mostro o que muda para a atribuída pelo usuário.

### Pré-requisitos

- SDK do .NET 11 (usei a versão 11.0.100);
- Uma versão recente do [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) e uma assinatura do Azure;
- Permissão para criar recursos e atribuir papéis (*roles*) na assinatura.

### Criando os recursos

Vou usar o Azure CLI em bash. Como os nomes de Storage, Key Vault, SQL e App Service precisam ser únicos, uso um sufixo aleatório:

```bash
az login

RG=rg-semsegredos
LOCAL=brazilsouth
SUFIXO=$RANDOM
ST=stsemsegredos$SUFIXO
KV=kv-semsegredos-$SUFIXO
SQL=sql-semsegredos-$SUFIXO
APP=app-semsegredos-$SUFIXO
EU=$(az ad signed-in-user show --query id -o tsv)
EU_NOME=$(az ad signed-in-user show --query userPrincipalName -o tsv)

az group create -n $RG -l $LOCAL
```

**Storage, com autenticação por chave desligada.** O parâmetro `--allow-shared-key-access false` faz a conta recusar qualquer acesso por `AccountKey` ou SAS assinado com a chave. Mesmo que uma chave antiga apareça em algum código, ela não funciona:

```bash
az storage account create -n $ST -g $RG -l $LOCAL --sku Standard_LRS \
  --allow-shared-key-access false --allow-blob-public-access false

ST_ID=$(az storage account show -n $ST -g $RG --query id -o tsv)

# Você também precisa de permissão para criar o container e enviar um arquivo
az role assignment create --assignee $EU --role "Storage Blob Data Contributor" --scope $ST_ID

az storage container create --account-name $ST -n documentos --auth-mode login
echo "teste" > exemplo.txt
az storage blob upload --account-name $ST -c documentos -f exemplo.txt -n exemplo.txt --auth-mode login
```

A atribuição de papel pode levar alguns minutos para valer. Se o comando `container create` falhar com erro de autorização, espere um pouco e tente de novo.

**Key Vault com RBAC.** Algumas APIs de terceiros ainda só aceitam chave. Para esses casos o Key Vault continua sendo o lugar certo, mas agora a aplicação entra no cofre sem senha:

```bash
az keyvault create -n $KV -g $RG -l $LOCAL --enable-rbac-authorization true
KV_ID=$(az keyvault show -n $KV --query id -o tsv)

az role assignment create --assignee $EU --role "Key Vault Secrets Officer" --scope $KV_ID
```

Para criar o segredo, evite passar o valor direto na linha de comando: ele fica gravado no histórico do shell, e esse histórico é mais um arquivo que um agente de IA consegue ler. Prefira o portal ou um arquivo temporário que você apaga em seguida:

```bash
az keyvault secret set --vault-name $KV -n ChaveApiParceiro --file chave.txt
rm chave.txt
```

**Azure SQL somente com Entra ID.** O parâmetro `--enable-ad-only-auth` desliga a autenticação por usuário e senha do SQL. Você vira o administrador Entra do servidor:

```bash
az sql server create -n $SQL -g $RG -l $LOCAL --enable-ad-only-auth \
  --external-admin-principal-type User --external-admin-name $EU_NOME --external-admin-sid $EU

az sql db create -g $RG -s $SQL -n dbdemo --edition GeneralPurpose --compute-model Serverless \
  --family Gen5 --capacity 1 --use-free-limit --free-limit-exhaustion-behavior AutoPause

# Libera os serviços do Azure e o seu IP
az sql server firewall-rule create -g $RG -s $SQL -n AzureServices --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
MEU_IP=$(curl -s https://api.ipify.org)
az sql server firewall-rule create -g $RG -s $SQL -n MeuIP --start-ip-address $MEU_IP --end-ip-address $MEU_IP
```

**App Service com identidade gerenciada:**

```bash
az appservice plan create -n plan-semsegredos -g $RG -l $LOCAL --is-linux --sku B1
az webapp create -n $APP -g $RG -p plan-semsegredos --runtime "DOTNETCORE:11.0"

APP_PRINCIPAL=$(az webapp identity assign -n $APP -g $RG --query principalId -o tsv)
```

Se o runtime `DOTNETCORE:11.0` ainda não aparecer em `az webapp list-runtimes --os linux`, use o .NET 10 ou publique a aplicação como *self-contained*.

O `principalId` é a identidade da aplicação. Agora damos a ela **somente** o que ela precisa, que é ler segredos e ler blobs:

```bash
az role assignment create --assignee-object-id $APP_PRINCIPAL --assignee-principal-type ServicePrincipal \
  --role "Key Vault Secrets User" --scope $KV_ID
az role assignment create --assignee-object-id $APP_PRINCIPAL --assignee-principal-type ServicePrincipal \
  --role "Storage Blob Data Reader" --scope $ST_ID
```

No banco, a permissão é dada com T-SQL. Abra o *Query editor* do banco `dbdemo` no portal, entre com a sua conta e execute, trocando pelo nome do seu App Service:

```sql
CREATE USER [app-semsegredos-12345] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [app-semsegredos-12345];
```

### A aplicação

Crie uma API vazia e adicione os pacotes:

```bash
dotnet new web -n ApiSemSegredos -f net11.0
cd ApiSemSegredos
dotnet add package Azure.Identity
dotnet add package Azure.Extensions.AspNetCore.Configuration.Secrets
dotnet add package Azure.Storage.Blobs
dotnet add package Microsoft.Extensions.Azure
dotnet add package Microsoft.Data.SqlClient
```

As versões que usei foram: Azure.Identity 1.21.0, Azure.Extensions.AspNetCore.Configuration.Secrets 1.5.2, Azure.Storage.Blobs 12.30.2, Microsoft.Extensions.Azure 1.14.1 e Microsoft.Data.SqlClient 7.1.2.

O `appsettings.json` só tem endereços. Nenhum deles é segredo:

```json
{
  "Azure": {
    "KeyVaultUri": "https://kv-semsegredos-12345.vault.azure.net/",
    "StorageUri": "https://stsemsegredos12345.blob.core.windows.net/"
  },
  "ConnectionStrings": {
    "Banco": "Server=tcp:sql-semsegredos-12345.database.windows.net,1433;Database=dbdemo;Encrypt=True;"
  }
}
```

Repare na connection string: ela não tem `User Id`, `Password` nem `Authentication`. Ela ainda existe, mas só diz **onde** está o banco, e não **como entrar**.

E o `Program.cs`:

```csharp
using Azure.Core;
using Azure.Identity;
using Azure.Storage.Blobs;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Azure;

var builder = WebApplication.CreateBuilder(args);

// Em produção: a identidade gerenciada do serviço.
// Em desenvolvimento: o usuário logado no Azure CLI (az login).
var clientId = builder.Configuration["Azure:ManagedIdentityClientId"];
TokenCredential credencial = builder.Environment.IsDevelopment()
    ? new AzureCliCredential()
    : new ManagedIdentityCredential(string.IsNullOrEmpty(clientId)
        ? ManagedIdentityId.SystemAssigned
        : ManagedIdentityId.FromUserAssignedClientId(clientId));

// Os segredos do Key Vault passam a fazer parte do IConfiguration
builder.Configuration.AddAzureKeyVault(
    new Uri(builder.Configuration["Azure:KeyVaultUri"]!), credencial);

builder.Services.AddAzureClients(clients =>
{
    clients.AddBlobServiceClient(new Uri(builder.Configuration["Azure:StorageUri"]!));
    clients.UseCredential(credencial);
});

var app = builder.Build();

app.MapGet("/segredo", (IConfiguration config) =>
    Results.Ok(new { carregado = !string.IsNullOrEmpty(config["ChaveApiParceiro"]) }));

app.MapGet("/arquivos", async (BlobServiceClient blobs) =>
{
    var container = blobs.GetBlobContainerClient("documentos");
    var nomes = new List<string>();
    await foreach (var blob in container.GetBlobsAsync())
        nomes.Add(blob.Name);
    return Results.Ok(nomes);
});

app.MapGet("/banco", async (IConfiguration config) =>
{
    await using var conexao = new SqlConnection(config.GetConnectionString("Banco"))
    {
        // O token do Entra ID é obtido pela mesma credencial usada acima
        AccessTokenCallback = async (contexto, cancelamento) =>
        {
            var token = await credencial.GetTokenAsync(
                new TokenRequestContext(["https://database.windows.net/.default"]), cancelamento);
            return new SqlAuthenticationToken(token.Token, token.ExpiresOn);
        }
    };
    await conexao.OpenAsync();
    await using var comando = new SqlCommand("SELECT SUSER_SNAME()", conexao);
    return Results.Ok(new { usuario = await comando.ExecuteScalarAsync() });
});

app.Run();
```

Alguns pontos importantes:

- **Uma credencial para tudo.** Key Vault, Storage e SQL usam o mesmo objeto `credencial`. O Azure SDK pede os tokens e os renova antes de expirarem.
- **Por que não `DefaultAzureCredential`?** Ela funciona e é ótima para começar, mas testa uma cadeia de credenciais até achar uma que funcione. Em produção a Microsoft recomenda usar a credencial específica: é mais rápido e evita que a aplicação acabe usando uma identidade diferente da que você esperava.
- **O endpoint `/segredo` não devolve o segredo**, só informa se ele foi carregado. Parece óbvio, mas endpoints de diagnóstico e logs que imprimem a configuração inteira são uma fonte clássica de vazamento.
- **Mudança no SqlClient 7.** A partir da versão 7, a autenticação Entra pela connection string (`Authentication=Active Directory Managed Identity`, `Active Directory Default` etc.) foi movida para o pacote separado `Microsoft.Data.SqlClient.Extensions.Azure`. Aqui usei o `AccessTokenCallback`, que está no pacote principal e reaproveita a mesma credencial. Se preferir o formato antigo, adicione esse pacote.

### Publicando e testando

```bash
dotnet publish -c Release -o publish
cd publish && zip -r ../app.zip . && cd ..
az webapp deploy -n $APP -g $RG --src-path app.zip --type zip
```

No Windows, troque o `zip` por `Compress-Archive -Path publish\* -DestinationPath app.zip`.

Acesse `https://<seu-app>.azurewebsites.net/segredo`, `/arquivos` e `/banco`. A resposta esperada é `{"carregado":true}` no primeiro, `["exemplo.txt"]` no segundo e, no terceiro, o usuário com que o SQL enxergou a conexão. Esse último é o teste mais interessante: em nenhum lugar existe uma senha, e o banco sabe exatamente quem está conectando.

Se algo falhar, a mensagem costuma ser clara: `403 Forbidden` no Storage ou no Key Vault indica que falta a atribuição de papel (ou que ela ainda está propagando), e `Login failed for user '<token-identified principal>'` no SQL indica que faltou o `CREATE USER`.

### E na máquina do desenvolvedor?

Em desenvolvimento, o código usa a `AzureCliCredential`, ou seja, o seu `az login`. Você precisa ter os mesmos papéis que a aplicação (`Key Vault Secrets User` e `Storage Blob Data Reader`) e um usuário no banco. Como administrador do servidor, você já tem acesso ao banco. Depois é só rodar:

```bash
dotnet run --environment Development
```

Aqui volta a questão da IA, e é um ponto que pouca gente percebe: **a sua sessão do Azure CLI também é uma credencial**. Qualquer processo rodando com o seu usuário consegue pedir um token a ela, e isso inclui o agente de IA que executa comandos no seu terminal. Se você é *Owner* da assinatura de produção e deixa um agente rodar `az` livremente, ele tem o mesmo poder que você.

A Managed Identity tira os segredos do código, mas o acesso do desenvolvedor também precisa de cuidado:

- **Privilégio mínimo para o seu usuário também.** No dia a dia, use uma conta ou assinatura de desenvolvimento, com papéis de dados (*Data Reader*, *Secrets User*) e não *Owner*. Para produção, use o [Privileged Identity Management](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-configure) e eleve o acesso apenas quando precisar, por tempo limitado.
- **Exija aprovação para comandos.** Configure o agente para pedir confirmação antes de executar `az`, `curl` e comandos de rede, em vez de liberar o terminal inteiro.
- **Isole quando fizer sentido.** Um dev container ou uma sandbox sem o seu login no Azure limita o que um agente comprometido consegue fazer.
- **Faça `az logout`** quando terminar de trabalhar com recursos sensíveis.

### Um checklist para projetos com IA

Juntando tudo, algumas regras que passei a seguir:

1. **Desligue a autenticação por chave nos recursos** (`--allow-shared-key-access false`, `--enable-ad-only-auth`). Uma chave vazada que não funciona não é um incidente.
2. **Diga ao agente o padrão do projeto.** Arquivos de instruções como `.github/copilot-instructions.md`, `CLAUDE.md` ou `AGENTS.md` com uma regra do tipo "nunca escreva senhas ou chaves; use `ManagedIdentityCredential` e o Key Vault" fazem o código gerado seguir o caminho certo.
3. **Bloqueie a leitura de arquivos sensíveis.** As ferramentas de IA têm configurações para excluir ou negar acesso a arquivos como `.env` e `*.pfx`. Use-as para o que ainda não deu para eliminar.
4. **Ligue o secret scanning com push protection** no GitHub. Ele barra o push quando encontra um padrão conhecido de chave.
5. **Revise os diffs gerados procurando `Password=`, `AccountKey=`, `SharedAccessSignature` e tokens.** É uma busca de dez segundos que evita muita dor de cabeça.
6. **Não registre a configuração em logs nem a devolva em endpoints**, como fizemos no `/segredo`.

### E a identidade atribuída pelo usuário?

O código já está preparado. Crie a identidade, associe ao App Service e informe o `clientId`:

```bash
az identity create -n id-semsegredos -g $RG
ID_ID=$(az identity show -n id-semsegredos -g $RG --query id -o tsv)
ID_CLIENT=$(az identity show -n id-semsegredos -g $RG --query clientId -o tsv)
ID_PRINCIPAL=$(az identity show -n id-semsegredos -g $RG --query principalId -o tsv)

az webapp identity assign -n $APP -g $RG --identities $ID_ID
az webapp config appsettings set -n $APP -g $RG --settings Azure__ManagedIdentityClientId=$ID_CLIENT
```

As atribuições de papel passam a usar o `$ID_PRINCIPAL`, e o usuário do banco é criado com o nome da identidade (`CREATE USER [id-semsegredos] FROM EXTERNAL PROVIDER`). A vantagem é que as permissões existem antes da aplicação e podem ser reaproveitadas por vários serviços.

### Custos e limpeza

O item que mais pesa é o plano B1 do App Service, cobrado por hora; algumas horas de teste custam centavos de dólar. O Key Vault e o Storage cobram por operação e volume, valores irrisórios para este exemplo, e o banco usa a [oferta gratuita do Azure SQL Database](https://learn.microsoft.com/azure/azure-sql/database/free-offer), que pausa ao atingir o limite mensal. Confira os valores atuais na [calculadora de preços](https://azure.microsoft.com/pricing/calculator/).

Ao terminar, apague tudo:

```bash
az group delete -n $RG --yes
az keyvault purge -n $KV
```

O `purge` é necessário porque o Key Vault fica em *soft delete* por alguns dias e reserva o nome.

### Conclusão

Durante muito tempo, proteger segredos significava escondê-los melhor. Com a Managed Identity, a pergunta passa a ser outra: **por que essa senha existe?** Na maioria dos casos, ela não precisa existir.

E com agentes de IA lendo, executando e escrevendo código no nosso repositório, essa mudança deixou de ser uma boa prática para virar necessidade. Tudo o que está ao alcance do agente pode acabar no contexto de um modelo, em um log ou em um commit. A melhor defesa é não ter nada sensível para ele encontrar e garantir que o seu próprio login tenha apenas as permissões necessárias.

O código fonte deste exemplo está no meu GitHub: https://github.com/carloscds/CSharpSamples/tree/master/ApiSemSegredos

Referências:
- [Identidades gerenciadas para recursos do Azure](https://learn.microsoft.com/entra/identity/managed-identities-azure-resources/overview)
- [Autenticação de aplicativos .NET em serviços do Azure](https://learn.microsoft.com/dotnet/azure/sdk/authentication/)
- [Credenciais da biblioteca Azure.Identity](https://learn.microsoft.com/dotnet/azure/sdk/authentication/credential-chains)

Abraços e até a próxima!

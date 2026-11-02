---
title: 'Publicando containers com .NET 11: imagens reproduzíveis'
date: 2026-11-02
author: carloscds
layout: post
categories:
  - C Sharp
  - DotNet
  - DevOps
---
Desde o .NET 7, o SDK consegue gerar imagens de container sem precisar de um `Dockerfile`: basta um `dotnet publish`. Mas havia um detalhe incômodo: publicar **o mesmo código duas vezes** gerava imagens com digests diferentes.
Para o registry, eram duas imagens distintas, e o pipeline enviava tudo de novo. 
No .NET 11 isso mudou: agora é possível gerar imagens reproduzíveis, e o SDK deixa de enviar o que o registry já tem.

Vamos comparar algumas publicações e ver o que realmente acontece.

### Pré-requisitos

Para este teste, usei o RC 3, a versão disponível no momento do teste. Crie uma pasta com o `global.json`, ajustando a versão:

```json
{
  "sdk": {
    "version": "11.0.100-rc.3.26522.148",
    "rollForward": "disable",
    "allowPrerelease": true
  }
}
```

Dentro dela, crie uma API com o template vazio:

```bash
dotnet new web -n ApiContainer -f net11.0
cd ApiContainer
```

Para não depender de um registry na nuvem, vamos subir um registry local na porta 5000:

```bash
docker run -d -p 5000:5000 --name registry-teste registry:2
```

### Publicando a mesma imagem duas vezes

Publique a aplicação no registry local com a tag `sem1`:

```bash
dotnet publish /t:PublishContainer -p:ContainerRegistry=localhost:5000 -p:ContainerImageTag=sem1
```

O SDK usa a imagem base `mcr.microsoft.com/dotnet/aspnet:11.0.0-rc.3`, adiciona uma camada com a aplicação e envia o resultado:

```text
Building image 'apicontainer' with tags 'sem1' on top of base image 'mcr.microsoft.com/dotnet/aspnet:11.0.0-rc.3'.
Pushed image 'apicontainer:sem1' to registry 'localhost:5000'.
```

Agora apague as pastas `bin` e `obj`, simulando um novo agente de build, e publique de novo com a tag `sem2`, sem mudar nenhuma linha de código. Para descobrir o digest de cada tag, consulte o registry:

```bash
curl -s -I -H "Accept: application/vnd.docker.distribution.manifest.v2+json" http://localhost:5000/v2/apicontainer/manifests/sem1
```

O resultado no meu teste:

```text
sem1 => sha256:ce1b62da35fd5c13674b12d9f7e8ab63e698abd2405eeec07a808554f825bc06
sem2 => sha256:827a927de71f19836b64bf9ec8814a1a022651ef7afef402cd2256d69fc7ef9c
```

Mesmo código, digests diferentes. Comparando os manifestos, as sete camadas da imagem base eram idênticas. A diferença estava em dois pontos:

- a **camada da aplicação**, que mudou de `sha256:dca47a83...` para `sha256:f9fbbb1a...`, porque os arquivos dentro do pacote carregam a data em que foram gerados;
- a **configuração da imagem**, cujo campo `created` registra o horário da publicação.

Na prática, cada publicação produz uma imagem "nova", mesmo que nada tenha mudado.

### Fixando a data com SOURCE_DATE_EPOCH

O .NET 11 passou a respeitar a variável `SOURCE_DATE_EPOCH`, uma [convenção de builds reproduzíveis](https://reproducible-builds.org/docs/source-date-epoch/) usada por várias ferramentas. Ela informa um horário fixo, em segundos desde 01/01/1970, que o SDK passa a usar no lugar do horário atual. Ele também padroniza os cabeçalhos do arquivo e a ordem dos arquivos dentro da camada.

Repita o teste passando um valor fixo:

```bash
dotnet publish /t:PublishContainer -p:ContainerRegistry=localhost:5000 -p:ContainerImageTag=com1 -p:SOURCE_DATE_EPOCH=1793577600
```

Apague novamente `bin` e `obj` e publique como `com2`, com o mesmo valor. Desta vez:

```text
com1 => sha256:269b53040ed58052599fd526fc9d147182431d9c402c75a4f72147c8f9bca316
com2 => sha256:269b53040ed58052599fd526fc9d147182431d9c402c75a4f72147c8f9bca316
```

As duas publicações geraram exatamente a mesma imagem. O campo `created` da configuração ficou com `2026-11-02T00:00:00Z`, que corresponde ao valor `1793577600`.

### E o upload?

O mais interessante apareceu no log da segunda publicação:

```text
Manifest 'sha256:269b53040ed58052599fd526fc9d147182431d9c402c75a4f72147c8f9bca316' already exists in repository 'apicontainer'. Skipping layer and configuration uploads.
Pushed image 'apicontainer:com2' to registry 'localhost:5000'.
```

Antes de enviar qualquer coisa, o SDK calcula o manifesto e pergunta ao registry se ele já existe no repositório. Como existia, ele pulou as camadas e a configuração e **só aplicou a nova tag**. Esse comportamento é padrão; não precisei configurar nada.

Compare com a publicação `sem2`: lá o SDK precisou verificar camada por camada, encontrou as sete da imagem base (`Layer '...' already exists.`) e enviou a camada da aplicação e a configuração, que eram novas.

Se precisar desligar a verificação do manifesto, use `ContainerPushNoCache`:

```bash
dotnet publish /t:PublishContainer -p:ContainerRegistry=localhost:5000 -p:ContainerImageTag=com3 -p:SOURCE_DATE_EPOCH=1793577600 -p:ContainerPushNoCache=true -v:n
```

Com a verbosidade normal (`-v:n`), o log mostra o SDK voltando ao caminho antigo. Um ponto que me confundiu no início: as mensagens `Uploading layer` aparecem para **todas** as camadas, mas são seguidas por `Layer '...' already exists.` Ou seja, a mensagem indica o início do processo, não um envio de fato. O digest final foi o mesmo `sha256:269b5304...`, e nenhuma camada foi transferida, porque a verificação individual continua ativa mesmo com o `ContainerPushNoCache`.

### Quando o código muda

Por fim, alterei o retorno do endpoint em `Program.cs`:

```csharp
app.MapGet("/", () => "Olá, .NET 11!");
```

E publiquei como `v2`, com o mesmo `SOURCE_DATE_EPOCH` e `-v:n`. As sete camadas da base foram reaproveitadas, e só a camada nova da aplicação foi enviada:

```text
Finished uploading layer 'sha256:33127133ab3f47d02049f89acfca73af74cb2e75ccdc5db8cb84b842057d97bd' to 'localhost:5000'.
Uploading config to registry at blob 'sha256:6498e1b4f52a7ef3d2541e8dcb350186823394df2f2b836dd354e253b44ca207',
Uploaded config to registry.
Uploading tag 'v2' to 'localhost:5000'.
```

A imagem funciona normalmente:

```bash
docker run -d --rm -p 8080:8080 --name api-teste localhost:5000/apicontainer:v2
curl http://localhost:8080/
```

```text
Olá, .NET 11!
```

### Qual data usar?

Um valor fixo no código serve para o teste, mas tem um problema: todas as versões da aplicação ficam com a mesma data de criação. O mais comum é usar a data do último commit, que muda a cada alteração e é a mesma em qualquer máquina que faça o build daquele commit. No Bash:

```bash
dotnet publish /t:PublishContainer -p:ContainerRegistry=localhost:5000 -p:SOURCE_DATE_EPOCH="$(git log -1 --pretty=%ct)"
```

No PowerShell, a sintaxe `$(...)` também funciona. Repeti o teste duas vezes a partir do mesmo commit, apagando `bin` e `obj` entre as execuções, e a segunda publicação foi reconhecida como já existente, com o mesmo digest.

Em um pipeline, lembre-se de que alguns serviços fazem checkout com histórico raso. Isso não atrapalha, porque o comando só precisa do último commit.

Para limpar o ambiente de teste:

```bash
docker rm -f registry-teste
```

### Considerações

Imagens reproduzíveis ajudam em mais coisas do que economizar upload. Se o mesmo commit sempre gera o mesmo digest, você consegue conferir que a imagem em produção foi gerada a partir daquele código, e reexecutar um pipeline deixa de criar imagens "fantasmas" no registry. Em registries cobrados por armazenamento ou tráfego, isso também pesa no custo.

Minha sugestão é adotar o `SOURCE_DATE_EPOCH` com a data do commit em todos os pipelines que publicam containers com o SDK. É uma mudança de uma linha.

Os detalhes estão nas [notas de versão do SDK no RC 1](https://github.com/dotnet/core/blob/main/release-notes/11.0/preview/rc1/sdk.md#container-publishing-produces-reproducible-images-and-skips-redundant-uploads) e no [anúncio do .NET 11 RC 1](https://devblogs.microsoft.com/dotnet/dotnet-11-rc-1/). Para conhecer as demais opções de publicação, veja a [documentação de containers do .NET](https://learn.microsoft.com/en-us/dotnet/core/containers/sdk-publish).

Abraços e até a próxima!

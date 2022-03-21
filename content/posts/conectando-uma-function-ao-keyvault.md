---
id: 10426
title: 'Como configurar uma Function para acessar dados no KeyVault'
date: 2022-03-20
author: carloscds
layout: post
categories:
  - Azure 
---
Você já esta usando o conceito de Serverless em suas aplicações ? Se ainda não está, recomendo que dê uma olhada no Azure Functions, uma funcionalidade do Azure que permite trabalhar com o conceito de programação orientada a eventos, ou seja, seu código pode ser acionado por um serviço externo, através de mensagens, arquivos no blob, entre outros. 
Mais detalhes sobre Functions você encontra aqui: https://docs.microsoft.com/pt-br/azure/azure-functions/functions-overview.

### Azure KeyVault
Agora vamos pensar em segurança, onde guardamos as configurações da nossa aplicação ? Por exemplo: string do banco, senha do email. Provavelmente você guarda no arquivo de configuração, certo ? 
Isto não está errado, mas você pode ter um problema de segurança se tiver mais de um ambiente, por exemplo: Desenvolvimento, Homologação e Produção. 
Todo mundo pode ver as configurações do ambiente de produção ? Isto deveria mesmo estar em um arquivo de configuração ?

Aqui entra o Azure KeyVault, um cofre virtual onde podemos guardar diversas informações, como por exemplo nossas configurações de aplicações. 

Mas quais as vantagens do KeyVault ? A principal delas é a segurança, mas vamos enumerar mais algumas:
* Centralização da configuração - podemos guardar a configuração de vários ambientes no KeyVault
* Versionamento da configuração - todas as mudanças em chaves do KeyVault são armazenadas, então você tem um histórico dos valores
* Acesso restrito - permita somente leitura no KeyVault para suas aplicações

Você pode pegar mais detalhes do Azure KeyVault aqui: https://docs.microsoft.com/pt-br/azure/key-vault/

### Permitindo acesso ao KeyVault através do Identity da Function

Para que a function possa acessar o KeyVault precisamos permitir o acesso através da configuração do Identity. Assim vamos acessar a nossa function no portal do Azure e habilitar a opção:

![](wp-content/uploads/2022/03/function-enable-indentity.png)


Clicando em Salvar teremos nosso ID criado:

![](wp-content/uploads/2022/03/function-enable-indentity-done.png)


Vamos copiar este ID e habilitar o acesso no KeyVault.

#### Habiltando a function dentro do KeyVault

Dentro do KeyVault vamos em "Access policies" e depois em "Add Access Policy"

![](wp-content/uploads/2022/03/keyvault-add-access-policies.png)


Dentro da Access Policy vamos colocar acesso somente para Leitura da Secret:

![](wp-content/uploads/2022/03/keyvault-add-access-policies-permission.png)


E agora vamos pegar o ID da function que geramos no Identity e permitir o acesso:

![](wp-content/uploads/2022/03/keyvault-add-access-policies-app.png)


Por fim clicamos no botão "Add" e confirmamos o acesso.

#### Crie suas chaves nas Secrets do KeyVault

Não se esqueca de criar as Secrets dentro do KeyVault. No nosso exemplo teremos uma Secret com o nome de "valorCofre".

### Criando uma function de exemplo para acessar o KeyVault

Para este exemplo estamos usando uma Function de HTTP Trigger, que permite o acesso a function através de um endereço HTTP.

A Secret dentro da function funciona como uma variável de ambiente, então podemos configurar esta variável no portal do Azure, dentro das configurações da Function.

Veja abaixo o código para lermos a variável de ambiente e retornar:

```csharp
public static class FunctionCofre
    {
        [FunctionName("FunctionCofre")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            return new OkObjectResult($"Valor da Secret: {Environment.GetEnvironmentVariable("valorCofre")}");
        }
    }
```
Como a function e o KeyVault estão conectados o valor da Secret dentro da Function será passado como uma variável de ambiente.

Se você estiver executando o código localmente, o valor não vai existir, mas caso precise do valor para debug, uma maneira simples é colocar no arquivo "local.settings.json". Este arquivo não é enviado na publicação para o Azure.

Para o teste, você precisa publicar a function no Azure!

#### Criando a variável na Function

Agora dentro da Function no Portal do Azure vamos criar a variável em "Configuration", adicionando um novo Application Settings com os seguintes dados:

**Name**: valorCofre

**Value**: @Microsoft.KeyVault(VaultName=cdsv;SecretName=valorCofre)

O value indica para pegar o valor do Keyvault com nome de "cdsv" e a secret com nome de "valorCofre" 

Salvamos e pronto! Agora nossa function busca valores no Azure KeyVault!

Veja o resultado da chamada HTTP a function:

![](wp-content/uploads/2022/03/function-executada.png)


O codigo fonte deste exemplo esta no meu GitHub: https://github.com/carloscds/CSharpSamples/tree/master/FunctionAcessandoKeyVault

Este post, como muitos outros, são o resultado de problemas reais que enfrentamos diariamente. Um especial agradecimento ao meu amigo [Thiago Custodio](https://twitter.com/thdotnet) pela colaboração na resolução do problema que originou este post.

Abraços e até a próxima!

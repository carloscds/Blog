---
id: 4891
title: Melhorando a performance do Entity Framework com NGen
date: 2014-04-21T18:32:40-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=4891
permalink: /2014/04/melhorando-a-performance-do-entity-framework-com-ngen/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'msdn;c#;ef codefirst; ef'
---
Olá pessoal,

Em um outro post eu falei bem rapidamente sobre o [NGen](http://carloscds.net/2013/11/melhorando-o-tempo-de-carga-do-entity-framework-com-ngen/), que serve para pré-compilar os assemblies de um aplicação, fazendo antecipadamente o trabalho do JIT (Just in Time Compiler).

Só para relembrar um pouco, a figura abaixo mostra o processo de execução de uma aplicação em .Net:

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb5.png" alt="image" width="612" height="455" border="0" />](http://carloscds.net/wp-content/uploads/2014/04/image5.png)

Em um processo natural de desenvolvimento em .Net, o que acontece é basicamente o que está na figura acima, ou seja, você escreve seu código, compila e depois executa. Mas na execução entra em ação o JIT, que pega o código gerado (Assembly) e traduz para código nativo, ou linguagem de máquina, que então será executado pelo processador.

Durante a instalação do .Net Framework em um computador, este processo é executado para todos os componmentes do .Net, ou seja, o núcleo doi .Net é automaticamente pré-compilado em seu computador, mas todo o código que você produz não passa por este processo.

Como eu já falei no [post anterior](http://carloscds.net/2013/11/melhorando-o-tempo-de-carga-do-entity-framework-com-ngen/), desde a versão 6 o Entity Framework funciona separado do .Net, através da EntityFramework.Dll, que normalmente é baixada pelo NuGet dentro do Visual Studio. Este processo simplesmente baixa a DLL do repositório do NuGet e copia para uma pasta do seu projeto. Isto é ótimo e funciona muito bem!

Muitas pessoas reclamam em fóruns e blogs sobre o tempo de carga inicial do Entity Framework, ou seja, o primeiro comando executado, seja ela qual for, demora um pouco, mas todas as instruções subsequentes são muito rápidas. Logicamente que o desenho do modelo e o comando podem influenciar neste tempo, mas uma coisa que influencia muito é a falta da pré-compilação.

Vamos ver um exemplo bem simples. Vou criar um projeto Console em C# e fazer engenharia reversa usando o Entity Framework PowerTools, que já expliquei em alguns posts anteriores. Então para me acompanhar, crie um projeto do tipo Console no Visual Studio, conforme a figura abaixo:

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTML4098cce" src="http://carloscds.net/wp-content/uploads/2014/04/SNAGHTML4098cce_thumb1.png" alt="SNAGHTML4098cce" width="836" height="479" border="0" />](http://carloscds.net/wp-content/uploads/2014/04/SNAGHTML4098cce1.png)

Agora vamos fazer engenharia reversa no banco de dados [Northwind](http://northwinddatabase.codeplex.com/), mas você pode utilizar qualquer outro banco de dados que tenha. PS: não esqueça de instalar o EntityFramework usando NuGet: Install-Package EntityFramework.

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb6.png" alt="image" width="830" height="238" border="0" />](http://carloscds.net/wp-content/uploads/2014/04/image6.png)

Agora vou escolher o banco de dados e gerar as classes.

Para mostrar a diferença de performance, vou criar uma simples consulta no EF e para marcar o tempo utilizaremos a classe StopWatch(). Veja abaixo:

<div class="oembed-gist">
  <noscript>
    View the code on <a href="https://gist.github.com/carloscds/15e628dba89c668d7fa30029780706be">Gist</a>.
  </noscript>
</div>

<span style="font-size: inherit; white-space: pre-wrap;">Veja o resultado:</span>

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb2.png" alt="image" width="716" height="191" border="0" />](http://carloscds.net/wp-content/uploads/2014/04/image2.png)

Agora vamos utilizar o NGen neste projeto e refazer o teste. Para isto abra um prompt de comando do Visual Studio (como administrador) e execute o comando abaixo:

**ngen Install EFPerformance.exe**

Você ver algo assim:

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb7.png" alt="image" width="885" height="206" border="0" />](http://carloscds.net/wp-content/uploads/2014/04/image7.png)

Repare que além do nosso projeto (EFPerformance.exe) a dll do EntityFramework também foi compilada.

Agora vamos executar o programa novamente, direto da linha de comandos e olhem a diferença de velocidade:

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2014/04/image_thumb4.png" alt="image" width="655" height="194" border="0" />](http://carloscds.net/wp-content/uploads/2014/04/image4.png)

Perceba que ficou extremamente mais rápido!!!

Agora se você tem uma aplicação web, você pode melhorar a performance usando comando é **[aspnet_compiler](http://msdn.microsoft.com/en-us/library/ms229863(v=vs.100).aspx),** mas ele não gera imagens nativas como o NGen, apesar de incrementar a performance através da pré-compilação de alguns arquivos do projeto (.aspx, .ascx, app_code, etc). Se preferir, a IDE do Visual Studio tem esta opção na publicação da aplicação web:

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTML41af2f8" src="http://carloscds.net/wp-content/uploads/2014/04/SNAGHTML41af2f8_thumb.png" alt="SNAGHTML41af2f8" width="660" height="518" border="0" />](http://carloscds.net/wp-content/uploads/2014/04/SNAGHTML41af2f8.png)

Espero que tenham gostado das dicas!

Abraços e até a próxima.

Carlos dos Santos.
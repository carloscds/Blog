---
id: 813
title: Melhorando o tempo de carga do Entity Framework com NGEN
date: 2013-11-03T21:49:43-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2013/11/melhorando-o-tempo-de-carga-do-entity-framework-com-ngen/
permalink: /2013/11/melhorando-o-tempo-de-carga-do-entity-framework-com-ngen/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'msdn;c#;ef codefirst'
---
A partir do Entity Framework 6, todos os componentes do EF estão dentro da DLL EntityFramework.dll e não mais divididas entre vários componentes do .Net Framework. Sendo assim, a DLL do EF não está otimizada para o JIT (Just in Time) do computador onde está sendo rodado, assim como o .Net está.

Nós podemos melhorar isto executando o comando [Ngen.exe](http://msdn.microsoft.com/en-us/library/6t9t5wcf.aspx), que pré-compila a DLL e elimina este processo durante a carga da DLL. Assim o tempo de carga fica menor e podemos ganhar alguns segundos na carga da nossa aplicação.

Para fazer isto, abra um prompt de comandos do Visual Studio Studio, ele fica dentro das opções de instalação do Visual Studio, com um nome parecido com este: “Developer Command Prompt for VS 20xx”. No meu caso estou usando o VS 2013, então o prompt está como “Developer Command Prompt for VS2013”.

Abra este prompt como administrador, vá até o diretório da sua aplicação e execute o comando NGen, como abaixo:

**C:Meu Projeto>ngen install EntityFramework.dll**

Após isto você verá uma tela parecida como esta:

![](/wp-content/uploads/2013/11/image1.png)

Valeu pessoal e até a próxima,  
Carlos dos Santos.
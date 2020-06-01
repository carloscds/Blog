---
id: 10359
title: Qual é a versão do framework de um EXE ou DLL ?
date: 2019-06-02T22:18:30-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10359
permalink: /2019/06/qual-e-a-versao-do-framework-de-um-exe-ou-dll/
image:  wp-content/uploads/2019/06/TargetFramework-175x131.png
categories:
  - .Net
  - .Net Core
---
Nestes tempos de migrações e vários Frameworks, é comum termos aplicações feitas em várias versões, desde o .NET Framework até as mais recentes versões do .NET Core.

Em um cenário ainda mais complicado, temos códigos produzidos em varias versões do mesmo framework, por exemplo: 3.0, 3.5,4.0, 4.5, etc. Mas e quando precisamos verificar se uma determinada DLL ou até mesmo um EXE estão na versão do framework que precisamos ? Qual o caminho ? Para alguns pode ser tentando adicionar na Solution e recebendo um erro de incompatibilidade, para outros usar algo como o utilitário ILDASM para inspecionar o assembly.

Para resolver um pouco deste cenário, eu criei um pequeno utilitário de linha de comandos, em .NET 4.7.2 que lista todos os arquivos EXE e DLL, informando a sua versão e também o framework para o qual foi compilado. Veja um exemplo:

![]( wp-content/uploads/2019/06/image.png)

Agora informando um diretório:

![]( wp-content/uploads/2019/06/image-3.png) 

Muito simples!

O código fonte está no meu [GitHub](https://github.com/carloscds/CSharpSamples) e o executável está disponibilizado como uma [release](https://github.com/carloscds/CSharpSamples/releases/tag/1.0) no mesmo GitHub.

Até mais!
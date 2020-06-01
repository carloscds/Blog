---
id: 10210
title: EF Core Powertools
date: 2018-05-28T15:14:26-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10210
permalink: /2018/05/ef-core-powertools/
image:  wp-content/uploads/2018/05/efcreveng0-175x131.png
categories:
  - EntityFramework Core
tags:
  - efcore; dotnetcore;
---
Olá pessoal,

Já utilizando Asp.Net Core ? Entity Framework Core ? Esta nova versão do EF Core está muito boa e para ajudar no processo de desenvolvimento, hoje vou falar da ferramenta EF Core PowerTools.

Mas em que esta ferramenta me ajuda ? Simples, com ela você pode pegar um banco existente e fazer engenharia reversa, o que significa gerar todas as classes do EntityFramerwork a partir do seu banco de dados. Produtividade!!!

Vale lembrar que para utilizar o EF Core você precisa do [Visual Studio 2017](https://www.visualstudio.com/pt-br/vs/).

**<u>Instalando o componente:</u>**

Vamos iniciar baixando o EF Core Powertools a partir deste endereço: <https://github.com/ErikEJ/EFCorePowerTools/wiki>

**Uma dica**: Até o momento que estou escrevendo este artigo, a versão padrão está com um bug na geração do modelo visual, então sugiro que você pegue a versão [daily build](http://vsixgallery.com/extensions/f4c4712c-ceae-4803-8e52-0e2049d5de9f/extension.vsix).

O Powertools é uma extensão para o Visual Studio, então após o download é só clicar e instalar. Não esqueça de reiniciar o Visual Studio para concluir a instalação!

![]( wp-content/uploads/2018/05/image.png)

No meu caso tenho o Visual Studio 2017 Preview também.

**<u>Criando nosso projeto de exemplo:</u>**

Depois de instalado, vamos criar um projeto .Net Core Console:

![]( wp-content/uploads/2018/05/image-1.png)

Agora precisamos adicionar o EntityFramework Core ao nosso projeto. Vamos fazer isto usando o NuGet Package Manager Console, com o comando:

**Install-Package Microsoft.EntityFrameworkCore.SqlServer**

![]( wp-content/uploads/2018/05/image-2.png)

Agora podemos usar o EF Core PowerTools clicando com o botão direito do mouse no projeto, onde veremos o menu abaixo:

![]( wp-content/uploads/2018/05/image-3.png)

Vamos então escolher a opção Reverse Engineer e clicando no botão Add você pode escolher o banco de dados: (no meu exemplo vou utilizar o NorthWind):

![]( wp-content/uploads/2018/05/image-4.png)

Selecione as tabelas/views e clique OK:

![]( wp-content/uploads/2018/05/image-5.png)

Finalmente, você pode ajustar as configurações do seu modelo, como nome do Contexto, NameSpace, etc:

![]( wp-content/uploads/2018/05/image-6.png)

Feito isto, teremos nossas classes e o contexto no projeto:

![]( wp-content/uploads/2018/05/image-7.png)

Agora só utilizar, mas antes verifique o seu contexto, pois a string de conexão com o banco foi colocada lá no código (no meu exemplo NorthwindContext.cs), o que não é uma boa prática:

![]( wp-content/uploads/2018/05/image-8.png)

Um funcionalidade bem legal desta ferramenta é o digrama do banco, que você gera no menu de contexto:

![]( wp-content/uploads/2018/05/image-9.png)

Esta opção gera um arquivo .dgml com o diagrama:

![]( wp-content/uploads/2018/05/image-10.png)

Lebrando que esta ferramenta é open source e está no GitHub: <https://github.com/ErikEJ/EFCorePowerTools>

Abraços e até a próxima,  
Carlos dos Santos.
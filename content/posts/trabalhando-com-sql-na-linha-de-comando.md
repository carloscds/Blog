---
id: 10083
title: Trabalhando com SQL na linha de comando
date: 2017-12-25T21:42:46-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10083
permalink: /2017/12/trabalhando-com-sql-na-linha-de-comando/
categories:
  - Linux
  - Open Source
  - SQL
---
Olá pessoal,

Hoje em dia, apesar de IDEs super poderosas, com milhares de funcionalidades, às vezes nos deparamos com procedimentos que são necessários na linha de comandos, nosso bom e velho Command Prompt.

Mas porque eu teria que usar uma ferramenta de linha de comando se tenho o Management Studio, o Visual Studio e agora também o Operations Studio ? Isto é simples, você pode estar em um ambiente onde não existe sequer um modo gráfico, o que é muito comum em servidores, principalmente Linux. Lembre-se que o [SQL Server também roda no Linux](https://docs.microsoft.com/pt-br/sql/linux/sql-server-linux-setup) agora!

Sendo assim, a Microsoft tem investido cada vez mais em ferramentas de linha de comando, e o SQL Server não é uma exceção a esta regra, pois isto foi criado o mssql-cli, que permite trabalharmos com o SQL Server usando apenas a linha e comandos.

Uma curiosidade, é que esta ferramenta, como algumas outras da Microsoft, foi desenvolvida com a linguagem Python. Então para você que acreditava que só existia .Net, as coisas estão realmente mudando!!!

Vamos iniciar instalando a ferramenta e para isto, precisamos instalar o [Python](https://www.python.org/downloads/) para o sistema operacional da sua preferência, no meu caso vou instalar no Windows.

![]( wp-content/uploads/2017/12/image.png)

Depois de instalado, vamos instalar o mssql-cli, usando o&#160; comando:

```shell
pip install mssql-cli
```

Agora, vamos acessar a ferramenta com o comando:

```shell
mssql-cli –S <servidor>
```

E teremos a tela abaixo:

![]( wp-content/uploads/2017/12/image-1.png)

Agora podemos conectar no nosso banco de dados e executar comandos SQL em um ambiente modo texto apenas, inclusive com intellisense!

Veja o intellisense funcionando na escolha do banco de dados:

![]( wp-content/uploads/2017/12/SNAGHTML6edc042.png)

E agora em um comando select dentro do banco de dados NorthWind:

![]( wp-content/uploads/2017/12/image-2.png)

Bem simples e prático!

Ah, lembre-se que a ferramenta ainda está em public preview, ou seja, é beta! Também é open Source!

Mais informações podem ser obtidas [nesta página do Github](https://github.com/dbcli/mssql-cli/blob/master/doc/installation_guide.md#windows-installation).

Até a próxima,  
Carlos dos Santos.
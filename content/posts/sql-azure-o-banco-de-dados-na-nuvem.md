---
id: 35
title: SQL Azure – O banco de dados na nuvem
date: 2009-10-09T11:36:00-03:00
author: carloscds
layout: post
guid: /post/2009/10/09/SQL-Azure-e28093-O-banco-de-dados-na-nuvem.aspx
permalink: /2009/10/sql-azure-o-banco-de-dados-na-nuvem/
categories:
  - Azure
---
Pessoal,

Acho que a maioria de vocês já ouvir falar com Cloud Computing, ou Computação na Nuvem, pois isto está sendo falado e muito nos canais de tecnologia.

Mas o que vem a ser isto e como eu posso colocar isto na minha empresa, é o que todos querem saber!

As grandes vantagens da computação na nuvem, na minha opnião são principalmente duas: segurança e escalabilidade, ou seja, usar um ambiente altamente seguro, com replicação de dados em vários servidores é certamente o sonho de todo gerente de TI e este tipo de computação nos proporciona isto. Outra grande vantagem é a capacidade de poder aumentar o poder de processamento contratato, a qualquer momento e acordo com a sua necessidade, sem grandes investimentos, o que, novamente, no mundo real, das redes corporativas, nem sempre é fácil.

Neste cenário, a Microsoft lançou o Windows Azure, a plataforma de cloud computing baseada em Windows ([www.azure.com](http://www.azure.com)), que permite o desenvolvimento de aplicações usando o Visual Studio, excelente vantagem para nós desenvolvedores, pois continuamos a usar a mesma ferramente de desenvolvimento.

Falando especificamente em banco de dados, recentemente a Microsoft lancou o SQL Azure (<http://sql.azure.com>), que é basicamente o SQL Server na nuvem. O mais interessante disto é que você vai desenvolver da mesma maneira que fazia antes, mudando apenas a string de conexão da aplicação. Logicamente que trabalhar com um banco de dados sendo acessado via internet requer alguns refinamentos no desenvolvimento, como por exemplo, não trafegar dados desnecessariamente, o que pode gerar uma lentidão na aplicação.

Vejamos o seguinte exemplo:

No SQL local, que todos estamos acostumados, para acessar um BD basta criar uma string de conexão assim:

![]( wp-content/uploads/image_thumb6.png)

Para conectar no SQL Azure:

![]( wp-content/uploads/image_thumb16.png)

Veja a diferença: você apenas mudou o datasource para o endereço do Azure, o usuário e a senha. Todos os outros comandos são os mesmos, ou seja: SqlCommand, SqlDataAdapter, SqlDataReader, etc. Tudo exatamente igual.

Aqui na empresa fizemos um teste interessante, pegamos nosso ERP e criamos toda a estrutura do BD no Azure, e mesmo estando o SQL Azure em um DataCenter da Microsoft nos Estados Unidos, sendo acessado via internet, a velocidade se equipara a muitas redes VPNs que tenho visto por aí.

O SQL Azure está em fase Beta e pode ser acessado no endereço: <http://sql.azure.com>. Basta entrar com seu Windows Live ID e solicitar um convite (invite), por enquanto ainda existem. Depois disto é só logar na ferramenta web e criar o seu banco de dados, veja:

[![]( wp-content/uploads/image_thumb10.png)

Aqui você tem acesso aos seus servidores de SQL e clicando em <span style="color: #ff0000;">Manage</span> você tem acesso a administração dos seus bancos de dados:

![]( wp-content/uploads/image_thumb14.png)

Clicando no botão “Connection Strings” o Azure mostra a string de conexão que você deverá usar na sua aplicação, e depois é só acessar o BD e começar os testes!

A computação na nuvem veio para ficar e o Windows Azure, em especial o SQL Azure, tem se mostrado uma plataforma robusta e com excelentes recursos para o desenvolvimento de aplicações.

Acesse agora mesmo e faça muitos testes!

[]s,

Carlos dos Santos.
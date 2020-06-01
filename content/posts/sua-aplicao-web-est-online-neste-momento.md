---
id: 7221
title: 'Sua aplicação web está online neste momento ?'
date: 2016-03-28T11:52:44-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=7221
permalink: /2016/03/sua-aplicao-web-est-online-neste-momento/
categories:
  - Azure
---
Esta é realmente uma pergunta complicada não acham ? Como determinar se minha aplicação está funcionando, sem ficar olhando para ela ?

Existem várias maneiras de resolver este problema, mas vou mostrar como monitorar isto usando o [Application Insights do Microsoft Azure](https://azure.microsoft.com/en-us/services/application-insights/).

É bem simples, vamos lá! Abra o portal do Azure: <http://portal.azure.com> com seu usuário e senha, caso não tenha um, basta criar uma conta trial.

Dentro do portal, vá em Application Insights:

![]( wp-content/uploads/2016/03/image.png)

E depois clique em Add. Na tla seguinte preencha com o nome do seu monitoramento e no tipo de aplicação selecione o que se encaixa melhor. No nosso exemplo, vou escolher “Asp.Net web application”. Existem vários tipo de aplicação pois além de monitorar se sua aplicação está no ar, você pode colher dados valiosos de telemetria sobre o uso e comportamento de sua aplicação, mas isto fica para outro post. Dados preenchidos, clique em “Create”.

![]( wp-content/uploads/2016/03/image1.png)

Em alguns instantes o portal será criado e listado:

![]( wp-content/uploads/2016/03/SNAGHTML552d3c.png)

Veja que temos muitas opções de monitoramento:

![]( wp-content/uploads/2016/03/image2.png)

Mas vamos nos concentrar no Availability:

![]( wp-content/uploads/2016/03/image3.png)

E agora vamos adicionar um Web Test bem simples fazendo um ping:

![]( wp-content/uploads/2016/03/image4.png)

Veja que podemos fazer “ping” de várias localidades, o que é bastante útil. E além do ping, podemos enviar notificações por email, configurando os Alertas:

![]( wp-content/uploads/2016/03/image5.png)

Feito isto, confirme as opçòes e já podemos testar o serviço! Se a sua aplicação apresentar indisponibilidade, um email será enviado para você e todos estes dados serão armazenados no portal do Azure, o que permite fazermos muitas análises destas informações!

Aqui está um exemplo do portal:

![]( wp-content/uploads/2016/03/image6.png)

E do email:

![]( wp-content/uploads/2016/03/image7.png)

Aqui tivemos apenas uma pequena amostra do que é possível fazer com o Application Insights, mas posso garantir que existem dezenas de outras telemetrias que podem ser feitas. Aproveite e começe a explorar agora mesmo!

Abraços e até a próxima,  
Carlos dos Santos.
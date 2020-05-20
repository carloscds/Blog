---
id: 7221
title: 'Sua aplica&ccedil;&atilde;o web est&aacute; online neste momento ?'
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

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/03/image_thumb.png" width="161" height="385" />](http://carloscds.net/wp-content/uploads/2016/03/image.png)

E depois clique em Add. Na tla seguinte preencha com o nome do seu monitoramento e no tipo de aplicação selecione o que se encaixa melhor. No nosso exemplo, vou escolher “Asp.Net web application”. Existem vários tipo de aplicação pois além de monitorar se sua aplicação está no ar, você pode colher dados valiosos de telemetria sobre o uso e comportamento de sua aplicação, mas isto fica para outro post. Dados preenchidos, clique em “Create”.

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/03/image_thumb1.png" width="190" height="536" />](http://carloscds.net/wp-content/uploads/2016/03/image1.png)

Em alguns instantes o portal será criado e listado:

[<img title="SNAGHTML552d3c" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="SNAGHTML552d3c" src="http://carloscds.net/wp-content/uploads/2016/03/SNAGHTML552d3c_thumb.png" width="533" height="385" />](http://carloscds.net/wp-content/uploads/2016/03/SNAGHTML552d3c.png)

Veja que temos muitas opções de monitoramento:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/03/image_thumb2.png" width="666" height="401" />](http://carloscds.net/wp-content/uploads/2016/03/image2.png)

Mas vamos nos concentrar no Availability:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/03/image_thumb3.png" width="596" height="463" />](http://carloscds.net/wp-content/uploads/2016/03/image3.png)

E agora vamos adicionar um Web Test bem simples fazendo um ping:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/03/image_thumb4.png" width="415" height="492" />](http://carloscds.net/wp-content/uploads/2016/03/image4.png)

Veja que podemos fazer “ping” de várias localidades, o que é bastante útil. E além do ping, podemos enviar notificações por email, configurando os Alertas:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/03/image_thumb5.png" width="248" height="432" />](http://carloscds.net/wp-content/uploads/2016/03/image5.png)

Feito isto, confirme as opçòes e já podemos testar o serviço! Se a sua aplicação apresentar indisponibilidade, um email será enviado para você e todos estes dados serão armazenados no portal do Azure, o que permite fazermos muitas análises destas informações!

Aqui está um exemplo do portal:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/03/image_thumb6.png" width="488" height="588" />](http://carloscds.net/wp-content/uploads/2016/03/image6.png)

E do email:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/03/image_thumb7.png" width="566" height="266" />](http://carloscds.net/wp-content/uploads/2016/03/image7.png)

Aqui tivemos apenas uma pequena amostra do que é possível fazer com o Application Insights, mas posso garantir que existem dezenas de outras telemetrias que podem ser feitas. Aproveite e começe a explorar agora mesmo!

Abraços e até a próxima,  
Carlos dos Santos.
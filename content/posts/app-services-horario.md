---
id: 9643
title: Configurando o horário de um App Service em Linux no Azure
date: 2021-06-08T22:00:00-00:00
author: carloscds
layout: post
categories:
  - Azure
tags:
  - time zone
  - fuso horário
  - appservice
---
Olá pessoal,

Estes dias estava configurando um App Service para uma nova API que construimos e precisava deixar o fuso horario do Brasil (GMT -3), lembrando que o Azure trabalha no GMT 0. 

Até aí tudo bem, existem vários tutoriais na web explicando isto, mas problema é que existe uma diferença entre um App Service rodando em Windows e outro rodando em Linux.

### Configuração muda de acordo com o Sistema Operacional

Quando o App Service esta configurado para Windows, você ajusta a seguinte propriedade na Configuracação do servico.

#### Configuração em Windows

*WEBSITE_TIME_ZONE = E. South America Standard Time*   

![](wp-content/uploads/2021/06/ConfigurandoAppServicesWindows.png)

(Confira a lista das configurações de Fuso Horário [aqui](https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/))

Esta configuração resolve o nosso problema no App Service em Windows, mas se o nosso serviço for configurado em um servidor Linux, não funciona!

#### Configuração em Linux

Para App Service baseado em Linux, você usa a mesma variável WEBSITE_TIME_ZONE, mas os nomes são baseados no TZ (Time Zone) do Linux, que é totalmente diferente:

*WEBSITE_TIME_ZONE = America/Sao_Paulo*

![](wp-content/uploads/2021/06/ConfigurandoAppServicesLinux.png)

(confira a lista das configurações de Fuso Horário para Linux [aqui](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones))

### Conclusão

Pode parecer simples, mas já perdi algum tempo neste tipo de configuração, chegando ao ponto de deletar o App Service em Linux e criar em Windows. Mas agora você já sabe como resolver isto!

Abraços e até a próxima,  
Carlos dos Santos.

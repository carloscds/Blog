---
id: 325
title: Integrando Apple XCode com TFS 2010
date: 2010-12-29T11:01:48-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2010/12/integrando-apple-xcode-com-tfs-2010/
permalink: /2010/12/integrando-apple-xcode-com-tfs-2010/
aktt_notify_twitter:
  - 'yes'
aktt_tweeted:
  - "1"
categories:
  - ALM
tags:
  - msdn
---
Pessoal,

Para quem está desenvolvendo para IPhone/IPad com XCode e precisa de uma ferramenta de ALM completa, é possível fazer a integração com o Team Foundation Server 2010 usando o <a href="http://svnbridge.codeplex.com/" target="_blank">SVNBridge</a>, um projeto OpenSource que está no <a href="http://www.codeplex.com" target="_blank">CodePlex</a>.

Basicamente o SVNBridge cria uma ponte entre o client do Subversion (SVN) e o Team Foundation Server, e para configurar o serviço, basta seguir <a href="http://jefferytay.wordpress.com/2010/11/25/xcode-and-tfs-2010-part-1-setting-up-tfs-2010/" target="_blank">este tutorial</a>. Uma maneira simples de testar todo o processo é usar o <a href="http://tortoisesvn.tigris.org/" target="_blank">TortoiseSVN</a>, que é um client para SVN que se integra ao Windows Explorer.

É isto aí pessoal, integração da ferramenta de ALM e melhoria do processo de desenvolvimento de software.

Veja a tela no MAC OS:

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="Screen shot 2010-12-29 at 5.04.14 PM" border="0" alt="Screen shot 2010-12-29 at 5.04.14 PM" src="http://carloscds.net/wp-content/uploads/2010/12/Screen-shot-2010-12-29-at-5.04.14-PM_thumb.png" width="564" height="300" />](http://carloscds.net/wp-content/uploads/2010/12/Screen-shot-2010-12-29-at-5.04.14-PM.png)

Veja a tela no Windows:

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2010/12/image_thumb.png" width="575" height="275" />](http://carloscds.net/wp-content/uploads/2010/12/image.png)

Esta integração foi feita com a empresa <a href="http://www.viewt.com.br/" target="_blank">ViewT</a> que é especializada no desenvolvimento de softwares para IPhone e IPad.

Abraços,  
Carlos dos Santos.
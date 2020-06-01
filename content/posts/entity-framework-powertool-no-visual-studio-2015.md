---
id: 6871
title: Entity Framework PowerTool no Visual Studio 2015
date: 2015-12-21T20:35:17-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=6871
permalink: /2015/12/entity-framework-powertool-no-visual-studio-2015/
categories:
  - .Net
  - 'C#'
  - Entity Framework
---
Olá,

Se você usa bastante o EF CodeFirst como eu e já está no Visual Studio 2015, deve ter sentido falta do EF PowerTools. Infelizmente ele ainda não foi portado para esta versão do Visual Studio.

Mas calma aí, existe uma maneira de instalar a versão atual no VS 2015. Para isto, primeiro baixe o componente da [Visual Studio Galery](https://visualstudiogallery.msdn.microsoft.com/72a60b14-1581-4b9b-89f2-846072eff19d/). Veja na imagem abaixo que ele não suporta o VS 2015:

![]( wp-content/uploads/2015/12/image.png)

Agora vem o truque…

Não sei se vocês sabem, mas o aqrquivo VSIX é na verdade um arquivo ZIP, então vamos renomear o arquivo baixado para .ZIP e depois vamos extair o conteúdo no mesmo diretório, ficando assim:

[](http://carloscds.net wp-content/uploads/2015/12/image1.png)

Agora vamos abrir o aqrquivo “extension.vsixmanifest”, pois é nele que estão as versões suportadas do Visual Studio. Com o arquivo aberto vamos adicionar as linhas, logo abaixo do bloco da versão 12.0:

```xml
<VisualStudio Version="14.0">  
<Edition>Pro</Edition>  
</VisualStudio>
```

Altere o arquivo e salve-o, ele vai ficar assim:

![]( wp-content/uploads/2015/12/image2.png)

Agora só precisamos compactar tudo novamente. Vamos fazer isto colocando o nome de EFPowerToolsVS2015.zip. Não se esqueca de apagar o arquivo original antes (o que renomeamos para ZIP). Agora teremos a seguinte lista de arquivos:

![]( wp-content/uploads/2015/12/image3.png)

Para finalizar renomeie o arquivo .ZIP para .VSIX e clique para instalar!

Pronto, agora você tem o Entity Framework PowerTools funcionando no seu Visual Studio 2015!

Se você não quiser realizar os passos acima, cliquei [aqui](https://github.com/carloscds/Palestras/blob/master/Tools/EFPowerToolsVS2015.zip) e baixe o arquivo VSIX pronto!

Abraços e até a próxima,  
Carlos dos Santos.
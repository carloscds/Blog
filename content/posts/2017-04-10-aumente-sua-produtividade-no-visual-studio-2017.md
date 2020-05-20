---
id: 8781
title: Aumente sua produtividade no Visual Studio 2017
date: 2017-04-10T22:15:14-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=8781
permalink: /2017/04/aumente-sua-produtividade-no-visual-studio-2017/
categories:
  - 'C#'
  - Visual Studio
tags:
  - prodividade
---
Ola pessoal,

Veja aqui algumas dicas bem legais para configurar o Visual Studio 2017 e aumentar a sua produtividade?

• **Análise completa da solução** &#8211; Mostra erros / avisos na lista de erros para toda a sua solução. No VS2015 Update 3 e VS2017 isso foi desativado por padrão, de modo que, por padrão, agora você só vê erros / avisos em seus arquivos abertos. Para ativar a Análise de solução completa, acesse Tools/Options/Text Editor/C#/Advanced/Enable Full Solution Analysis.  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb.png" width="535" height="314" />](http://carloscds.net/wp-content/uploads/2017/04/image.png)

• **Lightweight Solution Load** – ativa a carga rápida do projeto  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-1.png" width="546" height="320" />](http://carloscds.net/wp-content/uploads/2017/04/image-1.png) 

• **Live Unit Test** &#8211; Indica quais testes de unidade são impactados por qualquer uma das alterações de código e apenas executa novamente esse conjunto. Ele irá atualizar ícones no editor para que você saiba o status do seu código. Você também pode incluir/excluir testes específicos, projetos de teste ou classes. Você também pode executá-lo em "modo de economia de bateria", indo para Tools/Options/Live Unit Testing. Para ativá-lo, vá para Test/Live Unit Testing/Start. A janela Outupt também é um local útil para diagnosticar por que o Live Unit Testing não está sendo executado.  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-2.png" width="558" height="327" />](http://carloscds.net/wp-content/uploads/2017/04/image-2.png) 

• **Sugerir usings para tipos no NuGet** &#8211; Sugere a instalação de um pacote NuGet para resolver um tipo não reconhecido no editor (via lightbulb). Este recurso é off-by-default em ambos VS2015 Atualização 2+ e VS2017. Você pode ativá-lo em Tools/Options/Text Editor/C#/Advanced/Suggest usings for types in NuGet packages.  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-3.png" width="557" height="327" />](http://carloscds.net/wp-content/uploads/2017/04/image-3.png)

Sabe quando você precisa instalar um pacote por causa de uma referência ? Agora o VS vai te mostrar isto:  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-4.png" width="571" height="158" />](http://carloscds.net/wp-content/uploads/2017/04/image-4.png) 

**• Editar um arquivo EditorConfig para reforçar o estilo de código** &#8211; você pode instalar a extensão de serviço de linguagem do [EditorConfig](https://marketplace.visualstudio.com/items?itemName=MadsKristensen.EditorConfig) para obter a conclusão do estilo de código do EditorConfig para .NET e uma experiência para adicionar um arquivo EditorConfig à sua solução ou projeto. Há também documentação aqui: <https://docs.microsoft.com/en-us/visualstudio/ide/editorconfig-code-style-settings-reference>  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-5.png" width="573" height="419" />](http://carloscds.net/wp-content/uploads/2017/04/image-5.png)

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-6.png" width="578" height="556" />](http://carloscds.net/wp-content/uploads/2017/04/image-6.png) 

• **Code Suggestion** &#8211; um novo conceito no VS2017 onde você pode sugerir práticas recomendadas ou dicas para desenvolvedores. Estes são simbolizados com pontos cinzentos sublinhando os dois primeiros caracteres de uma expressão. Acho essa cor muito fácil de ignorar, então você pode mudar a cor indo para Tools/Options;Environment/Font and Colors  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-7.png" width="581" height="341" />](http://carloscds.net/wp-content/uploads/2017/04/image-7.png)

Neste imagem os tres ponto em verde indicam a sugestão:  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-8.png" width="355" height="185" />](http://carloscds.net/wp-content/uploads/2017/04/image-8.png)  
E quando clicamos no LightBuilb:  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-9.png" width="573" height="203" />](http://carloscds.net/wp-content/uploads/2017/04/image-9.png)

**• Salvar resultados em Localizar todas as referências/Ir para implementação** &#8211; você pode "bloquear" os resultados de pesquisa de uma pesquisa Localizar todas as referências ou Ir para a implementação pressionando o ícone "Manter resultados" na janela de resultados.  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-10.png" width="575" height="206" />](http://carloscds.net/wp-content/uploads/2017/04/image-10.png)

• **Consulta de sintaxe em Go to All&#160; (Ctrl + T) &#8211;** você pode pesquisar rapidamente por qualquer arquivo/tipo/membro/declaração de símbolo, prefaciando seu termo de pesquisa com &#8216;f&#8217; para arquivo, &#8216;t&#8217; para tipo, &#8216;M&#8217; para membro ou &#8216;#&#8217; para símbolo.  
[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-11.png" width="572" height="340" />](http://carloscds.net/wp-content/uploads/2017/04/image-11.png)

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2017/04/image_thumb-12.png" width="581" height="124" />](http://carloscds.net/wp-content/uploads/2017/04/image-12.png) 

**• Atalhos de teclado** &#8211; se você estiver migrando para VS de IntelliJ, Eclipse, ReSharper, você provavelmente está acostumado a um certo conjunto de atalhos de teclado. Existe uma extensão para ajudar a redefinir as ligações de chaves para se adequar aos ambientes passados: <https://marketplace.visualstudio.com/items?itemName=JustinClareburtMSFT.HotKeys2017-KeyboardShortcuts>. 

Mais dicas em: <https://blogs.msdn.microsoft.com/visualstudio/2017/03/08/optimize-your-productivity-with-net-in-visual-studio-2017-2/>. 

Abraços e até a próxima!  
Carlos dos Santos
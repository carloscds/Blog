---
id: 4441
title: Capturando a tela em Windows Forms
date: 2014-01-08T21:55:40-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=4441
permalink: /2014/01/capturando-a-tela-em-windows-forms/
categories:
  - 'C#'
tags:
  - 'c#; msdn'
---
Olá pessoal,

Hoje vou demonstrar como é possível capturar a tela ou até mesmo o conteúdo de um controle e salvá-lo como um Bitmap. Imagine que você tem uma solução de atendimento ao cliente e em algum momento precise capturar a tela do seu usuário e depois anexá-la a algum requisito do software ou tratamento de um bug.

Claro que existem várias ferramentas prontas para captura de tela, mas vamos ver como é possível, através de um código em C# usando o recurso de Interop e acessando a API do Windows, criar um método reusável que pode ser utilizado para capturar vários tipos de tela no Windows.

**<span style="text-decoration: underline;">Criando o projeto</span>**

Vamos criar um projeto no Visual Studio 2013 do tipo Windows Forms (você pode utilizar qualquer outra versão do Visual Studio):

<a href="http://carloscds.net/wp-content/uploads/2014/01/SNAGHTML29cbc21f.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTML29cbc21f" alt="SNAGHTML29cbc21f" src="http://carloscds.net/wp-content/uploads/2014/01/SNAGHTML29cbc21f_thumb.png" width="870" height="498" border="0" /></a>

Para deixar o nosso código de captura reutilizável, vamos criar uma nova classe chamada Tela.cs. Nesta classe iremos criar todo o código de captura, iniciando pelas referências a API do Windows. Esta API é muito rica e possui centenas de métodos muito interessantes, mas vamos nos concentrar basicamente nas rotinas de captura de tela.

Só para conhecimento, todos os controle do Windows são tratados como uma janela e como tal, possuem um identificador único de janela, ou um WindowsHandle. Para acessarmos qualquer informação de uma janela ou controle usando a API do Windows, precisamos deste identificador.

**<span style="text-decoration: underline;">Trabalhando com Interop</span>**

Para começar a nossa classe, vamos colocar todo o código de Interop com a API do Windows. Eu não vou explicar em detalhes o que cada método faz, mas você pode acessar um site muito bom chamado [PInvoke.net](http://www.pinvoke.net/) que contém referências, explicações e exemplos para a API do Windows.

O código abaixo faz uma referência para um método da API do Windows e o deixa acessível para nós no C#:

<div id="codeSnippetWrapper" style="overflow: auto; cursor: text; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 97.5%; direction: ltr; text-align: left; margin: 20px 0px 10px; line-height: 12pt; max-height: 5200px; background-color: #f4f4f4; border: silver 1px solid; padding: 4px;">
  <div id="codeSnippet" style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;">
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">class</span> Tela</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span>     {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>         [DllImport(<span style="color: #006080;">"user32.dll"</span>, EntryPoint = <span style="color: #006080;">"GetDC"</span>)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>         <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">extern</span> IntPtr GetDC(IntPtr ptr);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span>         [DllImport(<span style="color: #006080;">"user32.dll"</span>, EntryPoint = <span style="color: #006080;">"ReleaseDC"</span>)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum6" style="color: #606060;">   6:</span>         <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">extern</span> IntPtr ReleaseDC(IntPtr hWnd, IntPtr hDc);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum7" style="color: #606060;">   7:</span>         [DllImport(<span style="color: #006080;">"gdi32.dll"</span>, EntryPoint = <span style="color: #006080;">"DeleteDC"</span>)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum8" style="color: #606060;">   8:</span>         <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">extern</span> IntPtr DeleteDC(IntPtr hDc);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum9" style="color: #606060;">   9:</span>         [DllImport(<span style="color: #006080;">"gdi32.dll"</span>, EntryPoint = <span style="color: #006080;">"CreateCompatibleDC"</span>)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum10" style="color: #606060;">  10:</span>         <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">extern</span> IntPtr CreateCompatibleDC(IntPtr hdc);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum11" style="color: #606060;">  11:</span>         [DllImport(<span style="color: #006080;">"gdi32.dll"</span>, EntryPoint = <span style="color: #006080;">"CreateCompatibleBitmap"</span>)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum12" style="color: #606060;">  12:</span>         <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">extern</span> IntPtr CreateCompatibleBitmap(IntPtr hdc, <span style="color: #0000ff;">int</span> nWidth, <span style="color: #0000ff;">int</span> nHeight);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum13" style="color: #606060;">  13:</span>         [DllImport(<span style="color: #006080;">"gdi32.dll"</span>, EntryPoint = <span style="color: #006080;">"SelectObject"</span>)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum14" style="color: #606060;">  14:</span>         <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">extern</span> IntPtr SelectObject(IntPtr hdc, IntPtr bmp);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum15" style="color: #606060;">  15:</span>         [DllImport(<span style="color: #006080;">"gdi32.dll"</span>, EntryPoint = <span style="color: #006080;">"BitBlt"</span>)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum16" style="color: #606060;">  16:</span>         <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">extern</span> <span style="color: #0000ff;">bool</span> BitBlt(IntPtr hdcDest, <span style="color: #0000ff;">int</span> xDest, <span style="color: #0000ff;">int</span> yDest, <span style="color: #0000ff;">int</span> wDest, <span style="color: #0000ff;">int</span> hDest, IntPtr hdcSource, <span style="color: #0000ff;">int</span> xSrc, <span style="color: #0000ff;">int</span> ySrc, <span style="color: #0000ff;">int</span> RasterOp);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum17" style="color: #606060;">  17:</span>         [DllImport(<span style="color: #006080;">"user32.dll"</span>, EntryPoint = <span style="color: #006080;">"GetDesktopWindow"</span>)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum18" style="color: #606060;">  18:</span>         <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">extern</span> IntPtr GetDesktopWindow();</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum19" style="color: #606060;">  19:</span>         [DllImport(<span style="color: #006080;">"gdi32.dll"</span>, EntryPoint = <span style="color: #006080;">"DeleteObject"</span>)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum20" style="color: #606060;">  20:</span>         <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">extern</span> IntPtr DeleteObject(IntPtr hDc);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum21" style="color: #606060;">  21:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum22" style="color: #606060;">  22:</span>         <span style="color: #0000ff;">const</span> <span style="color: #0000ff;">int</span> SRCCOPY = 13369376;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum23" style="color: #606060;">  23:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">struct</span> SIZE</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum24" style="color: #606060;">  24:</span>         {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum25" style="color: #606060;">  25:</span>             <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">int</span> cx;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum26" style="color: #606060;">  26:</span>             <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">int</span> cy;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum27" style="color: #606060;">  27:</span>         }</pre>
    
    <p>
      <!--CRLF-->
    </p>
  </div>
</div>

**<span style="text-decoration: underline;">Entendo um pouco a API do Windows</span>**

DC – Device Context, ou Dispositovo de Contexto, é um identificador para um objeto no Windows, por exemplo uma janela ou controle.

GetDC() – devolve o identificador para uma janela.

ReleaseDC() – restaura o identificador para o Windows. Isto é muito importante, todo identificador que for utilizado, deve ser devolvido.

DeleteDC() – quando nós criamos o DC, ao invés de pegá-lo do Windows, precisamos deletá-lo para liberar o recurso.

CreateCompatibleDC() – cria um DC, no nosso caso iremos criar para manipular o Bitmap.

CreateCompatibleBitmap() – cria um Bitmap compatível com um DC.

SelectObjec() – seleciona um objeto, no nosso caso vincula o DC ao Bitmap.

BitBlt() – faz a cópia do conteúdo de um identificador para outro, e no nosso caso, o identificador de destino será um Bitmap.

GetDesktopWindow() – retorna um identificador para a janela principal do Windows (Desktop).

DeleteObject() – deleta um objeto, liberando o recurso alocado.

**<span style="text-decoration: underline;">Criando a rotina que captura a tela</span>**

Agora que já entendemos um pouco da API do Window, vamos criar o método da nossa classe que irá fazer as capturas de tela. Para isto vamos adicionar o código abaixo a nossa classe Tela.cs:

<div id="codeSnippetWrapper" style="overflow: auto; cursor: text; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 97.5%; direction: ltr; text-align: left; margin: 20px 0px 10px; line-height: 12pt; max-height: 5200px; background-color: #f4f4f4; border: silver 1px solid; padding: 4px;">
  <div id="codeSnippet" style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;">
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">static</span> Bitmap RetornaImagemControle(IntPtr controle, Rectangle area)</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span>         {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>             SIZE size;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>             IntPtr hBitmap;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum6" style="color: #606060;">   6:</span>             IntPtr hDC = GetDC(controle);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum7" style="color: #606060;">   7:</span>             IntPtr hMemDC = CreateCompatibleDC(hDC);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum8" style="color: #606060;">   8:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum9" style="color: #606060;">   9:</span>             size.cx = area.Width - area.Left;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum10" style="color: #606060;">  10:</span>             size.cy = area.Bottom - area.Top;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum11" style="color: #606060;">  11:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum12" style="color: #606060;">  12:</span>             hBitmap = CreateCompatibleBitmap(hDC, size.cx, size.cy);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum13" style="color: #606060;">  13:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum14" style="color: #606060;">  14:</span>             <span style="color: #0000ff;">if</span> (hBitmap != IntPtr.Zero)</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum15" style="color: #606060;">  15:</span>             {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum16" style="color: #606060;">  16:</span>                 IntPtr hOld = (IntPtr)SelectObject(hMemDC, hBitmap);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum17" style="color: #606060;">  17:</span>                 BitBlt(hMemDC, 0, 0, size.cx, size.cy, hDC, 0, 0, SRCCOPY);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum18" style="color: #606060;">  18:</span>                 SelectObject(hMemDC, hOld);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum19" style="color: #606060;">  19:</span>                 DeleteDC(hMemDC);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum20" style="color: #606060;">  20:</span>                 ReleaseDC(GetDesktopWindow(), hDC);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum21" style="color: #606060;">  21:</span>                 Bitmap bmp = System.Drawing.Image.FromHbitmap(hBitmap);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum22" style="color: #606060;">  22:</span>                 DeleteObject(hBitmap);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum23" style="color: #606060;">  23:</span>                 <span style="color: #0000ff;">return</span> bmp;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum24" style="color: #606060;">  24:</span>             }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum25" style="color: #606060;">  25:</span>             <span style="color: #0000ff;">else</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum26" style="color: #606060;">  26:</span>             {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum27" style="color: #606060;">  27:</span>                 <span style="color: #0000ff;">return</span> <span style="color: #0000ff;">null</span>;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum28" style="color: #606060;">  28:</span>             }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum29" style="color: #606060;">  29:</span>         }</pre>
    
    <p>
      <!--CRLF-->
    </p>
  </div>
</div>

O nosso método recebe como parâmetro um IntPtr, que pode representar qualquer controle ou janela do Windows, e recebe também uma estrutura que representa a área que iremos capturar, pois poderemos querer apenas uma parte do nosso controle transformado em uma imagem.

Iniciamos pegando os identificadores necessários (linhas 6 e 7) e em seguida calculamos o tamanho do nosso Bitmap de captura (linhas 9 e 10), para depois já criarmos este Bitmap (linha 12). Caso consigamos criar o Bitmap, então vamos fazer o vínculo do Bitmap (linha 16), e finalmente iremos executar o método que faz toda a mágica, ou seja, que copia o conteúdo do controle para o nosso Bitmap (linha 17).

Após isto iremos liberar os recursos utilizados (linhas 19 e 20), criamos finalmente o nosso Bitmap (linha 21) e liberamos o último recurso alocado. Ufa! Agora é só retornar o Bitmap com o resultado.

**<span style="text-decoration: underline;">Utilizando a classe para capturar uma informação:</span>**

Agora que já temos a classe, vamos voltar para o nosso Windows Forms e mostrar como ele irá funcionar. Para isto adicione um controle Button e também um PictureBox, de maneira que a tela fique parecida com a seguinte:

<a href="http://carloscds.net/wp-content/uploads/2014/01/image.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" alt="image" src="http://carloscds.net/wp-content/uploads/2014/01/image_thumb.png" width="1009" height="611" border="0" /></a>

Vamos adicionar o código para o botão “Capturar Desktop”:

<div id="codeSnippetWrapper" style="overflow: auto; cursor: text; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 97.5%; direction: ltr; text-align: left; margin: 20px 0px 10px; line-height: 12pt; max-height: 200px; background-color: #f4f4f4; border: silver 1px solid; padding: 4px;">
  <div id="codeSnippet" style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;">
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> <span style="color: #0000ff;">private</span> <span style="color: #0000ff;">void</span> btnCapturaDesktop_Click(<span style="color: #0000ff;">object</span> sender, EventArgs e)</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span>         {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>             imagemCapurada.Image = Tela.RetornaImagemControle(IntPtr.Zero, Screen.PrimaryScreen.WorkingArea);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>         }</pre>
    
    <p>
      <!--CRLF-->
    </p>
  </div>
</div>

Este código tem um truque bem interessante. Como eu falei no início deste post, iríamos capturar uma tela e toda tela no Windows possui um identificador, sendo assim, o nosso Desktop tem a identificação ZERO, ou seja, informando IntPtr.Zero como o nosso controle a ser capturado, iremos capturar o Desktop do Windows, e para conseguirmos capturar toda a tela, eu utilizei a propriedade PrimaryScreen.WorkingArea, que retorna o tamanho do nosso Desktop.

Para finalizar, iremos implementar um outro botão que irá capturar a nossa própria tela, para isto adicione um novo botão ao formulário e acrescente o código a seguir:

<div id="codeSnippetWrapper" style="overflow: auto; cursor: text; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 97.5%; direction: ltr; text-align: left; margin: 20px 0px 10px; line-height: 12pt; max-height: 200px; background-color: #f4f4f4; border: silver 1px solid; padding: 4px;">
  <div id="codeSnippet" style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;">
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> <span style="color: #0000ff;">private</span> <span style="color: #0000ff;">void</span> btnCapturaTela_Click(<span style="color: #0000ff;">object</span> sender, EventArgs e)</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span>         {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>             imagemCapurada.Image = Tela.RetornaImagemControle(<span style="color: #0000ff;">this</span>.Handle, <span style="color: #0000ff;">new</span> Rectangle(0,0,<span style="color: #0000ff;">this</span>.Width,<span style="color: #0000ff;">this</span>.Height));</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>         }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
  </div>
</div>

Veja que agora estamos informando o identificador do nosso form e também o seu tamanho, mas você pode informar o identificador de qualquer controle e qualquer tamanho, e talvez capturar uma parte do controle original.

**<span style="text-decoration: underline;">Veja como fica a tela capturada:</span>**

<a href="http://carloscds.net/wp-content/uploads/2014/01/image1.png" rel="lightbox"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border: 0px;" title="image" alt="image" src="http://carloscds.net/wp-content/uploads/2014/01/image_thumb1.png" width="926" height="668" border="0" /></a>

**<span style="text-decoration: underline;">Conclusão:</span>**

Este post mostra duas coisas bem interessantes: como interoperar com a API do Windows e como capturar o conteúdo de uma janela do Windows.

Espero que tenham gostado e que principalmente seja útil no seu dia a dia.

Um grande abraço e até a próxima.

Carlos dos Santos.

<div id='wpba_attachment_list' class='wpba wpba-wrap'>
  <ul class='wpba-attachment-list unstyled'>
    <li id='wpba_attachment_list_4571' class='wpba-list-item pull-left'>
      <img src='http://carloscds.net/wp-content/plugins/wp-better-attachments/assets/img/icons/file-icon.png' width='16' height='20' class='wpba-icon pull-left' /><a href='http://carloscds.net/wp-content/uploads/2014/01/CapturaTela.zip' title='CapturaTela' class='wpba-link pull-left' target="_self">CapturaTela</a>
    </li>
  </ul>
</div></span>
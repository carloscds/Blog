---
id: 212
title: EFProfiler– Entity Framework Profiler
date: 2010-08-20T15:31:27-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2010/08/efprofiler-entity-framework-profiler/
permalink: /2010/08/efprofiler-entity-framework-profiler/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'c#; msdn'
---
Se você está trabalhando com EF4, provavelmente já se perguntou se os comandos SQL gerados estão realmente otimizados, ou talvez quando você tem algum problema de performance. Para responder a isto existem várias ferramentas de análise, ou profilers, e um destes é o EFProfiler.

A ferramenta é bastante simples, você baixa um executável do site [www.efprof.com](http://www.efprof.com) e segue as instruções contidas no arquivo “How to use.txt”.

Para o profiler funciona, você precisa adicionar a referência de um DLL do Profiler ao seu projeto: 

[<img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2010/08/image_thumb2.png" width="339" height="206" />](http://carloscds.net/wp-content/uploads/2010/08/image2.png)

Depois, no arquivo principal do projeto, você executa o inicializador do profiler:

<div id="codeSnippetWrapper">
  <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px" id="codeSnippet">
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum1">   1:</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> Main(<span style="color: #0000ff">string</span>[] args)</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum2">   2:</span> {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum3">   3:</span>     <span style="color: #008000">// Profiler</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum4">   4:</span>     HibernatingRhinos.Profiler.Appender.EntityFramework.EntityFrameworkProfiler.Initialize();</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum5">   5:</span>&#160; </pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum6">   6:</span>     TesteEntities dc = <span style="color: #0000ff">new</span> TesteEntities();</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum7">   7:</span>&#160; </pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum8">   8:</span>     var dados = from c <span style="color: #0000ff">in</span> dc.Cliente</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum9">   9:</span>                 select c;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum10">  10:</span>     <span style="color: #0000ff">foreach</span> (var linha <span style="color: #0000ff">in</span> dados)</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum11">  11:</span>     {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum12">  12:</span>         Console.WriteLine(linha.Nome);</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: white; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum13">  13:</span>     }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; border-right-style: none; background-color: #f4f4f4; margin: 0em; padding-left: 0px; width: 100%; padding-right: 0px; font-family: &#39;Courier New&#39;, courier, monospace; direction: ltr; border-top-style: none; color: black; font-size: 8pt; border-left-style: none; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum14">  14:</span> }</pre>
    
    <p>
      <!--CRLF--></div> </div> 
      
      <p>
        No exemplo acima, temos uma simples consulta ao banco de dados.
      </p>
      
      <p>
        Agora abra o profiler e execute sua aplicação, os resultados irão aparecer na tela:
      </p>
      
      <p>
        <a href="http://carloscds.net/wp-content/uploads/2010/08/image4.png"><img style="background-image: none; border-bottom: 0px; border-left: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top: 0px; border-right: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2010/08/image_thumb4.png" width="883" height="469" /></a>
      </p>
      
      <p>
        É isto aí pessoal, bom profiler para vocês!
      </p>
      
      <p>
        []s,<br /> <br />Carlos dos Santos.
      </p>
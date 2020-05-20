---
id: 7781
title: Serializando JSon com JIL
date: 2016-07-30T17:34:11-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=7781
permalink: /2016/07/serializando-json-com-jil/
categories:
  - .Net
  - 'C#'
  - Open Source
tags:
  - json
---
Fala pessoal, tudo bem!

Hoje vou falar sobre uma biblioteca muito legal para serializar e deserializar objetos Json, pois este tipo de dados está cada vez mais comum com o advento das APIs web.

Um exemplo de dado em Json é o próprio WebAPI que faz parte do Asp.Net MVC, pois ele retorna basicamente dados em Json. Então qual o problema a ser resolvido ? 

Você recebe um dado em Json, que é basicamente um texto, e precisa manipular seu conteúdo através de uma classe! E é aí que entra o JIL !!!

A biblioteca [JIL](https://github.com/kevin-montrose/Jil), criada pela equipe do site StackExchange desempenha este trabalho com muita rapidez e simplicidade! Esta biblioteca está disponível através do [NuGet](https://www.nuget.org/packages/Jil/).

Vamos codificar para ver!

Vou criar um projeto bem simples do tipo Console Application no Visual Studio 2015, mas você pode usar outras versões do Visual Studio também:

[<img title="image_thumb1" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image_thumb1" src="http://carloscds.net/wp-content/uploads/2016/07/image_thumb1_thumb.png" width="560" height="389" />](http://carloscds.net/wp-content/uploads/2016/07/image_thumb1.png)

E vamos instalar o JIL usando o NuGet Package Manager Console (Tools/NuGet Packager Manager/Packager Manager Console):

[<img title="image_thumb3" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image_thumb3" src="http://carloscds.net/wp-content/uploads/2016/07/image_thumb3_thumb.png" width="532" height="72" />](http://carloscds.net/wp-content/uploads/2016/07/image_thumb3.png)

Vamos agora criar um classe e trabalhar com a serialização e deserialização:

<div id="codeSnippetWrapper" style="font-size: 8pt; overflow: auto; cursor: text; border-top: silver 1px solid; font-family: &#39;Courier New&#39;, courier, monospace; border-right: silver 1px solid; width: 97.5%; border-bottom: silver 1px solid; padding-bottom: 4px; direction: ltr; text-align: left; padding-top: 4px; padding-left: 4px; border-left: silver 1px solid; margin: 20px 0px 10px; line-height: 12pt; padding-right: 4px; max-height: 200px; background-color: #f4f4f4">
  <div id="codeSnippet" style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4">
    <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum1" style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Cliente</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum2" style="color: #606060">   2:</span> {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum3" style="color: #606060">   3:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> ID { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum4" style="color: #606060">   4:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Nome { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum5" style="color: #606060">   5:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Cidade { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum6" style="color: #606060">   6:</span> }</pre>
    
    <p>
      <!--CRLF--></div> </div> 
      
      <p>
        Agora vamos trabalhar com o JIL, veja como é simples:
      </p>
      
      <p>
        Vamos criar um objeto do tipo cliente e serializar:
      </p>
      
      <div id="codeSnippetWrapper" style="font-size: 8pt; overflow: auto; cursor: text; border-top: silver 1px solid; font-family: &#39;Courier New&#39;, courier, monospace; border-right: silver 1px solid; width: 97.5%; border-bottom: silver 1px solid; padding-bottom: 4px; direction: ltr; text-align: left; padding-top: 4px; padding-left: 4px; border-left: silver 1px solid; margin: 20px 0px 10px; line-height: 12pt; padding-right: 4px; max-height: 200px; background-color: #f4f4f4">
        <div id="codeSnippet" style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4">
          <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum1" style="color: #606060">   1:</span> var cli = <span style="color: #0000ff">new</span> Cliente() { ID = 1, Nome = <span style="color: #006080">"Carlos"</span>, Cidade = <span style="color: #006080">"CPP"</span> };</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum2" style="color: #606060">   2:</span>&#160; </pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum3" style="color: #606060">   3:</span> var json = JSON.Serialize&lt;Cliente&gt;(cli);</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum4" style="color: #606060">   4:</span>&#160; </pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum5" style="color: #606060">   5:</span> Console.WriteLine(json);</pre>
          
          <p>
            <!--CRLF--></div> </div> 
            
            <p>
              Criamos o objeto e passamos como parâmetro para a classe JSON.Serialize()
            </p>
            
            <p>
              O retorno é este:
            </p>
            
            <p>
              <a href="http://carloscds.net/wp-content/uploads/2016/07/image.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/07/image_thumb.png" width="620" height="189" /></a>
            </p>
            
            <p>
              Agora vamos fazer o inverso, pegar uma string Json e converter para um objeto:
            </p>
            
            <div id="codeSnippetWrapper" style="font-size: 8pt; overflow: auto; cursor: text; border-top: silver 1px solid; font-family: &#39;Courier New&#39;, courier, monospace; border-right: silver 1px solid; width: 97.5%; border-bottom: silver 1px solid; padding-bottom: 4px; direction: ltr; text-align: left; padding-top: 4px; padding-left: 4px; border-left: silver 1px solid; margin: 20px 0px 10px; line-height: 12pt; padding-right: 4px; max-height: 200px; background-color: #f4f4f4">
              <div id="codeSnippet" style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4">
                <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum1" style="color: #606060">   1:</span> var jsonData = <span style="color: #006080">"{\"ID\":1,\"Nome\":\"João\",\"Cidade\":\"SP\"}"</span>;</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum2" style="color: #606060">   2:</span> var cliente = JSON.Deserialize&lt;Cliente&gt;(jsonData);</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum3" style="color: #606060">   3:</span>&#160; </pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum4" style="color: #606060">   4:</span> Console.WriteLine(<span style="color: #006080">"ID: {0}\nNome: {1}\nCidade: {2}\n"</span>, cliente.ID, cliente.Nome, cliente.Cidade);</pre>
                
                <p>
                  <!--CRLF--></div> </div> 
                  
                  <p>
                    Temos o dado jsonData, que poderia ter vindo de qualquer serviço na web, e depois chamamos o método JSON.Deserialize(). Pronto, temos nosso objeto cliente!
                  </p>
                  
                  <p>
                    Veja o retorno:
                  </p>
                  
                  <p>
                    <a href="http://carloscds.net/wp-content/uploads/2016/07/image-1.png"><img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/07/image_thumb-1.png" width="404" height="182" /></a>
                  </p>
                  
                  <p>
                    Veja o código todo aqui:
                  </p>
                  
                  <div id="codeSnippetWrapper" style="font-size: 8pt; overflow: auto; cursor: text; border-top: silver 1px solid; font-family: &#39;Courier New&#39;, courier, monospace; border-right: silver 1px solid; width: 97.5%; border-bottom: silver 1px solid; padding-bottom: 4px; direction: ltr; text-align: left; padding-top: 4px; padding-left: 4px; border-left: silver 1px solid; margin: 20px 0px 10px; line-height: 12pt; padding-right: 4px; max-height: 200px; background-color: #f4f4f4">
                    <div id="codeSnippet" style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4">
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum1" style="color: #606060">   1:</span> <span style="color: #0000ff">using</span> Jil;</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum2" style="color: #606060">   2:</span> <span style="color: #0000ff">using</span> System;</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum3" style="color: #606060">   3:</span>&#160; </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum4" style="color: #606060">   4:</span> <span style="color: #0000ff">namespace</span> ConsoleApplication2</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum5" style="color: #606060">   5:</span> {</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum6" style="color: #606060">   6:</span>     <span style="color: #0000ff">class</span> Program</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum7" style="color: #606060">   7:</span>     {</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum8" style="color: #606060">   8:</span>         <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> Main(<span style="color: #0000ff">string</span>[] args)</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum9" style="color: #606060">   9:</span>         {</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum10" style="color: #606060">  10:</span>             var cli = <span style="color: #0000ff">new</span> Cliente() { ID = 1, Nome = <span style="color: #006080">"Carlos"</span>, Cidade = <span style="color: #006080">"CPP"</span> };</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum11" style="color: #606060">  11:</span>             var json = JSON.Serialize&lt;Cliente&gt;(cli);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum12" style="color: #606060">  12:</span>             Console.WriteLine(json);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum13" style="color: #606060">  13:</span>&#160; </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum14" style="color: #606060">  14:</span>             var jsonData = <span style="color: #006080">"{\"ID\":1,\"Nome\":\"João\",\"Cidade\":\"SP\"}"</span>;</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum15" style="color: #606060">  15:</span>             var cliente = JSON.Deserialize&lt;Cliente&gt;(jsonData);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum16" style="color: #606060">  16:</span>&#160; </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum17" style="color: #606060">  17:</span>             Console.WriteLine(<span style="color: #006080">"ID: {0}\nNome: {1}\nCidade: {2}\n"</span>, cliente.ID, cliente.Nome, cliente.Cidade);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum18" style="color: #606060">  18:</span>&#160; </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum19" style="color: #606060">  19:</span>&#160; </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum20" style="color: #606060">  20:</span>         }</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum21" style="color: #606060">  21:</span>     }</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum22" style="color: #606060">  22:</span>&#160; </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum23" style="color: #606060">  23:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Cliente</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum24" style="color: #606060">  24:</span>     {</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum25" style="color: #606060">  25:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> ID { get; set; }</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum26" style="color: #606060">  26:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Nome { get; set; }</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum27" style="color: #606060">  27:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Cidade { get; set; }</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: #f4f4f4"><span id="lnum28" style="color: #606060">  28:</span>     }</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-top-style: none; font-size: 8pt; overflow: visible; border-left-style: none; font-family: &#39;Courier New&#39;, courier, monospace; width: 100%; border-bottom-style: none; color: black; padding-bottom: 0px; direction: ltr; text-align: left; padding-top: 0px; border-right-style: none; padding-left: 0px; margin: 0em; line-height: 12pt; padding-right: 0px; background-color: white"><span id="lnum29" style="color: #606060">  29:</span> }</pre>
                      
                      <p>
                        <!--CRLF--></div> </div> 
                        
                        <p>
                          <br />Abraços e até a próxima,
                        </p>
                        
                        <p>
                          Carlos dos Santos.
                        </p>
---
id: 568
title: EntityFramework CodeFirst
date: 2012-01-07T23:31:48-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2012/01/entityframework-codefirst/
permalink: /2012/01/entityframework-codefirst/
categories:
  - 'C#'
  - Entity Framework
tags:
  - 'msdn;c#;ef codefirst; ef'
---
No <a href="http://carloscds.net/2012/01/trabalhando-com-entity-framework-designer/" target="_blank">post anterior</a>, eu falei em como trabalhar com Entity Framework usando o Designer, ou seja, um modelo de classes criado a partir de um arquivo EDMX. Este modelo funciona perfeitamente em diversos tipos de projetos, mas o grande incoveniente é ter um arquivo EDMX para cada tipo de banco de dados do seu projeto.

Então vamos agora usar uma abordagem diferente, mas nem tão diferente assim do artigo anterior. Nossa necessidade ainda é manter o isolamento do banco de dados e trabalhar somente com objetos. O CodeFirst, como o próprio nome sugere, nos leva a criar primeiramente as classes POCO e depois o banco de dados, mas é possível também pegar um banco de dados existente e gerar o CodeFirst.

O Entity Framework faz uma ponte entre as classes POCO e o banco de dados utilizando um container que chamamos de <u>Contexto</u>. O contexto é o responsável por mapear as nossas classes com o banco de dados e também por informar ao engine quem é o banco de dados, através da string de conexão, e isto é o que mais me agrada no Code First, você precisa trocar somente a string de conexão para mudar de banco. Nenhum tipo de alteração no código é necessária.

**<u>Instalando o Entity Framework Code First:</u>**

Antes de começarmos a escrever as classes, precisamos instalar o Entity Framework CodeFirst, que é basicamente composto pela EntityFramework.DLL. Faremos isto isando o NuGet, que é um instalador de pacotes para o Visual Studio. Se você ainda não o possui, vá até o Extension Manager do Visual Studio (Tools/Extension Manager) e instale:

<a href="http://carloscds.net/wp-content/uploads/2012/01/SNAGHTMLa23ac4a_thumb1_thumb8.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="SNAGHTMLa23ac4a_thumb1_thumb" border="0" alt="SNAGHTMLa23ac4a_thumb1_thumb" src="http://carloscds.net/wp-content/uploads/2012/01/SNAGHTMLa23ac4a_thumb1_thumb_thumb7.png" width="576" height="352" /></a>

Depois de instalado o NuGet, vá em Tools/Library Package Manager/Package Manager Console. Isto vai abrir o gerenciador do NuGet:

<a href="http://carloscds.net/wp-content/uploads/2012/01/image_thumb1_thumb8.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image_thumb1_thumb" border="0" alt="image_thumb1_thumb" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb1_thumb_thumb7.png" width="621" height="115" /></a>

Agora digite o comando: **Install-Package EntityFramework** dentro do console, isto irá instalara o EF CodeFirst e suas dependências:

**<u>Criando um projeto com o EntityFramework CodeFirst:</u>**

Vamos criar uma classe de contexto que chamaremos de Contexto.cs, esta classe irá herdar de DbContext e nela iremos mapear nossas tabelas:

<div id="codeSnippetWrapper">
  <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px" id="codeSnippet">
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum1">   1:</span> <span style="color: #0000ff">using</span> System;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum2">   2:</span> <span style="color: #0000ff">using</span> System.Collections.Generic;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum3">   3:</span> <span style="color: #0000ff">using</span> System.Linq;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum4">   4:</span> <span style="color: #0000ff">using</span> System.Text;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum5">   5:</span> <span style="color: #0000ff">using</span> System.Data.Entity;</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum6">   6:</span>  </pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum7">   7:</span> <span style="color: #0000ff">namespace</span> EFCodeFirst</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum8">   8:</span> {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum9">   9:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Contexto : DbContext</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum10">  10:</span>     {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum11">  11:</span>         <span style="color: #0000ff">public</span> DbSet&lt;Grupo&gt; Grupo { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum12">  12:</span>         <span style="color: #0000ff">public</span> DbSet&lt;Produto&gt; Produto { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum13">  13:</span>     }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum14">  14:</span> }</pre>
    
    <p>
      <!--CRLF--></div> </div> 
      
      <p>
        O segredo aqui é o DBSet<>, pois ele faz o mapeamento da nossa classe para o banco e vincula a um objeto, que utilizaremos para fazer as operações com o BD.
      </p>
      
      <p>
        Veja o código da classe Grupo:
      </p>
      
      <div id="codeSnippetWrapper">
        <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px" id="codeSnippet">
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum1">   1:</span> <span style="color: #0000ff">using</span> System;</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum2">   2:</span> <span style="color: #0000ff">using</span> System.Collections.Generic;</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum3">   3:</span> <span style="color: #0000ff">using</span> System.Linq;</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum4">   4:</span> <span style="color: #0000ff">using</span> System.Text;</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum5">   5:</span> <span style="color: #0000ff">using</span> System.ComponentModel.DataAnnotations;</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum6">   6:</span>  </pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum7">   7:</span> <span style="color: #0000ff">namespace</span> EFCodeFirst</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum8">   8:</span> {</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum9">   9:</span>     [Table(<span style="color: #006080">"Grupo"</span>)]</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum10">  10:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Grupo</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum11">  11:</span>     {</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum12">  12:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> ID { get; set; }</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum13">  13:</span>         [Required(ErrorMessage=<span style="color: #006080">"Nome não pode ser branco."</span>)]</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum14">  14:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Nome { get; set; }</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum15">  15:</span>  </pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum16">  16:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">virtual</span> IQueryable&lt;Produto&gt; Produtos { get; set; }</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum17">  17:</span>     }</pre>
          
          <p>
            <!--CRLF-->
          </p>
          
          <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum18">  18:</span> }</pre>
          
          <p>
            <!--CRLF--></div> </div> 
            
            <p>
              E da classe Produto:
            </p>
            
            <div id="codeSnippetWrapper">
              <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px" id="codeSnippet">
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum1">   1:</span> <span style="color: #0000ff">using</span> System;</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum2">   2:</span> <span style="color: #0000ff">using</span> System.Collections.Generic;</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum3">   3:</span> <span style="color: #0000ff">using</span> System.Linq;</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum4">   4:</span> <span style="color: #0000ff">using</span> System.Text;</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum5">   5:</span> <span style="color: #0000ff">using</span> System.ComponentModel.DataAnnotations;</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum6">   6:</span>  </pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum7">   7:</span> <span style="color: #0000ff">namespace</span> EFCodeFirst</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum8">   8:</span> {</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum9">   9:</span>     [Table(<span style="color: #006080">"Produto"</span>)]</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum10">  10:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Produto</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum11">  11:</span>     {</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum12">  12:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> ID { get; set; }</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum13">  13:</span>         [Required(ErrorMessage=<span style="color: #006080">"Nome não pode ser branco."</span>)]</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum14">  14:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Descricao { get; set; }</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum15">  15:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> GrupoID { get; set; }</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum16">  16:</span>  </pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum17">  17:</span>         [ForeignKey(<span style="color: #006080">"GrupoID"</span>)]</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum18">  18:</span>         <span style="color: #0000ff">public</span> <span style="color: #0000ff">virtual</span> Grupo Grupo { get; set; }</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum19">  19:</span>     }</pre>
                
                <p>
                  <!--CRLF-->
                </p>
                
                <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum20">  20:</span> }</pre>
                
                <p>
                  <!--CRLF--></div> </div> 
                  
                  <p>
                    No CodeFirst podemos controlar todos os aspectos do mapeamento das classes com o banco de dados, desde o nome da tabela no banco, obrigatoriedade dos campos, tamanho, etc.
                  </p>
                  
                  <p>
                    Na classe Grupo, eu determinei o nome da tabela no banco de dados (linha 9), ou seja, podemos ter um nome para a classes e outro para a tabela no banco de dados. Informei também que o nome não pode ser banco e vinculei uma mensagem, que pode ser usada em projetos MVC e WPF (linha 13). Finalmente criei o relacionamento entre Grupo e Produto (linha 16).
                  </p>
                  
                  <p>
                    Na classe Produto, eu determinei também o nome da tabela no banco de dados, e o campo obrigatório. Fiz também o relacionamento com a tabela grupo através do campo GrupoID (linhas 15 e 17,18).
                  </p>
                  
                  <p>
                    O EF identifica também automaticamente as <strong>chaves primárias</strong> das tabelas, desde que você as chame por <strong>ID</strong> ou <strong>nome_da_tabelaID</strong>, exemplo: GrupoID ou ProdutoID.
                  </p>
                  
                  <p>
                    Um coisa muito legal que o EF CodeFirst faz para nós é criar o banco de dados, mas isto depende do provider do seu banco de dados, nem todos aceitam a criação do banco.
                  </p>
                  
                  <p>
                    Vamos agora montar um exemplo para carregar dados no nosso banco:
                  </p>
                  
                  <div id="codeSnippetWrapper">
                    <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px" id="codeSnippet">
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum1">   1:</span> <span style="color: #0000ff">using</span> System;</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum2">   2:</span> <span style="color: #0000ff">using</span> System.Collections.Generic;</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum3">   3:</span> <span style="color: #0000ff">using</span> System.Linq;</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum4">   4:</span> <span style="color: #0000ff">using</span> System.Text;</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum5">   5:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum6">   6:</span> <span style="color: #0000ff">namespace</span> EFCodeFirst</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum7">   7:</span> {</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum8">   8:</span>     <span style="color: #0000ff">class</span> Program</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum9">   9:</span>     {</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum10">  10:</span>         <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> Main(<span style="color: #0000ff">string</span>[] args)</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum11">  11:</span>         {</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum12">  12:</span>             var db = <span style="color: #0000ff">new</span> Contexto();</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum13">  13:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum14">  14:</span>             db.Database.CreateIfNotExists();</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum15">  15:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum16">  16:</span>             var g1 = <span style="color: #0000ff">new</span> Grupo() { Nome = <span style="color: #006080">"Peças"</span> };</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum17">  17:</span>             var g2 = <span style="color: #0000ff">new</span> Grupo() { Nome = <span style="color: #006080">"Serviços"</span> };</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum18">  18:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum19">  19:</span>             db.Grupo.Add(g1);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum20">  20:</span>             db.Grupo.Add(g2);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum21">  21:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum22">  22:</span>             var p1 = <span style="color: #0000ff">new</span> Produto() { Descricao = <span style="color: #006080">"Pneu"</span>, Grupo = g1 };</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum23">  23:</span>             var p2 = <span style="color: #0000ff">new</span> Produto() { Descricao = <span style="color: #006080">"Roda"</span>, Grupo = g1 };</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum24">  24:</span>             var p3 = <span style="color: #0000ff">new</span> Produto() { Descricao = <span style="color: #006080">"Alinhamento"</span>, Grupo = g2 };</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum25">  25:</span>             var p4 = <span style="color: #0000ff">new</span> Produto() { Descricao = <span style="color: #006080">"Balanceamento"</span>, Grupo = g2 };</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum26">  26:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum27">  27:</span>             db.Produto.Add(p1);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum28">  28:</span>             db.Produto.Add(p2);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum29">  29:</span>             db.Produto.Add(p3);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum30">  30:</span>             db.Produto.Add(p4);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum31">  31:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum32">  32:</span>             db.SaveChanges();</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum33">  33:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum34">  34:</span>             var dados = from p <span style="color: #0000ff">in</span> db.Produto</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum35">  35:</span>                         select p;</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum36">  36:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum37">  37:</span>             <span style="color: #0000ff">foreach</span> (var linha <span style="color: #0000ff">in</span> dados)</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum38">  38:</span>             {</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum39">  39:</span>                 Console.WriteLine(<span style="color: #006080">"{0,-30} - {1}"</span>, linha.Grupo.Nome, linha.Descricao);</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum40">  40:</span>             }</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum41">  41:</span>  </pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum42">  42:</span>         }</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum43">  43:</span>     }</pre>
                      
                      <p>
                        <!--CRLF-->
                      </p>
                      
                      <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum44">  44:</span> }</pre>
                      
                      <p>
                        <!--CRLF--></div> </div> 
                        
                        <p>
                          O código acima cria o nosso banco de dados no SQL, caso ele não exista (linha 14). Após isto eu inseri os dados em Grupo e Produto, mas percebam que eu simplesmente vinculei os objetos, sem me preocupar com as chaves primárias ou estrangeiras, pois o EF resolve isto para nós desde que seu mapeamento esteja correto.
                        </p>
                        
                        <p>
                          Assim ao final do código temos o banco de dados criado e os dados inseridos. Veja como ficou o banco de dados no Management Studio:
                        </p>
                        
                        <p>
                          <a href="http://carloscds.net/wp-content/uploads/2012/01/image_thumb3_thumb17.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image_thumb3_thumb1" border="0" alt="image_thumb3_thumb1" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb3_thumb1_thumb6.png" width="266" height="219" /></a>
                        </p>
                        
                        <p>
                          Veja que o nome do banco de dados é o nome da aplicação mais o nome do Contexto, mas podemos resolver isto adicionando um arquivo App.Config e informando os dados do banco, então vamos adicionar um arquivo de configuração ao nosso exemplo e colocar a seguinte linha:
                        </p>
                        
                        <div id="codeSnippetWrapper">
                          <div style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px" id="codeSnippet">
                            <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum1">   1:</span> &lt;?xml version=<span style="color: #006080">"1.0"</span> encoding=<span style="color: #006080">"utf-8"</span> ?&gt;</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum2">   2:</span> &lt;configuration&gt;</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum3">   3:</span>   &lt;connectionStrings&gt;</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum4">   4:</span>     &lt;add name =<span style="color: #006080">"Contexto"</span> providerName=<span style="color: #006080">"System.Data.SqlClient"</span> connectionString=<span style="color: #006080">"data source=(local); initial catalog=ExemploEF; user id=teste; password=teste;"</span>/&gt;</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: white; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum5">   5:</span>   &lt;/connectionStrings&gt;</pre>
                            
                            <p>
                              <!--CRLF-->
                            </p>
                            
                            <pre style="border-bottom-style: none; text-align: left; padding-bottom: 0px; line-height: 12pt; background-color: #f4f4f4; margin: 0em; border-left-style: none; padding-left: 0px; width: 100%; padding-right: 0px; font-family: 'Courier New', courier, monospace; direction: ltr; border-top-style: none; color: black; border-right-style: none; font-size: 8pt; overflow: visible; padding-top: 0px"><span style="color: #606060" id="lnum6">   6:</span> &lt;/configuration&gt;</pre>
                            
                            <p>
                              <!--CRLF--></div> </div> 
                              
                              <p>
                                O nome da string de conexão é o mesmo nome da nossa classe de Contexto. O providerName indica que usamos SQL Server e a string de conexão é padrão de ADO.Net, informando Servidor/Banco de Dados/Usuário. Eu já fiz outro post falando só sobre <a href="http://carloscds.net/2011/08/ef-codefirstgerenciando-as-strings-de-conexo/" target="_blank">Gerenciamento de Strings de Conexão</a>.
                              </p>
                              
                              <p>
                                Executando nosso código novamente o banco chamado EFExemplo será criado e preenchido com os dados.
                              </p>
                              
                              <p>
                                <strong><u>Visualizando o modelo do CodeFirst:</u></strong>
                              </p>
                              
                              <p>
                                Mas e se você quiser ver como está ficando seu modelo se você está usando somente código ? Para isto existe o <a href="http://visualstudiogallery.msdn.microsoft.com/72a60b14-1581-4b9b-89f2-846072eff19d" target="_blank">Entity Framework PowerTools</a> que permite visualizar o modelo a partir das classes e também gerar um script para o banco de dados. Vejamos como ver o modelo visual do nosso exempo.
                              </p>
                              
                              <p>
                                Após instalar o PowerTools, clique com o botão direito do mouse sobre a classe Contexto.cs no seu projeto, irá aparecer um menu de contexto EntityFramework, com várias opções:
                              </p>
                              
                              <p>
                                <a href="http://carloscds.net/wp-content/uploads/2012/01/image_thumb5_thumb17.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image_thumb5_thumb1" border="0" alt="image_thumb5_thumb1" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb5_thumb1_thumb6.png" width="516" height="240" /></a>
                              </p>
                              
                              <p>
                                A primeira opção é justamente a que mostra o modelo gráfico, vamos vê-lo então:
                              </p>
                              
                              <p>
                                <a href="http://carloscds.net/wp-content/uploads/2012/01/image_thumb316.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image_thumb3[1]" border="0" alt="image_thumb3[1]" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb31_thumb6.png" width="235" height="257" /></a>
                              </p>
                              
                              <p>
                                <strong><u>Já tenho um banco de dados e quero usar o CodeFirst:</u></strong>
                              </p>
                              
                              <p>
                                Se você já tiver um banco de dados, o EF PowerTools permite que você faça engenharia reversa e gere o contexto e as classes, para isto clique com o botão direito do mouse em sua Solution no Visual Studio e escolhar Entity Framework no menu:
                              </p>
                              
                              <p>
                                <a href="http://carloscds.net/wp-content/uploads/2012/01/image_thumb9_thumb17.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image_thumb9_thumb1" border="0" alt="image_thumb9_thumb1" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb9_thumb1_thumb6.png" width="442" height="202" /></a>
                              </p>
                              
                              <p>
                                Esta opção gera todas as classes e relacionamentos do seu modelo, basta informar qual o banco de dados e o servidor na janela abaixo:
                              </p>
                              
                              <p>
                                <a href="http://carloscds.net/wp-content/uploads/2012/01/SNAGHTMLa560840_thumb1_thumb17.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; margin: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="SNAGHTMLa560840_thumb1_thumb1" border="0" alt="SNAGHTMLa560840_thumb1_thumb1" src="http://carloscds.net/wp-content/uploads/2012/01/SNAGHTMLa560840_thumb1_thumb1_thumb6.png" width="240" height="349" /></a>
                              </p>
                              
                              <p>
                                Não se esquece de adicionar o EntityFramework CodeFirst com o NuGet antes de fazer a engenharia reversa.
                              </p>
                              
                              <p>
                                <strong><u>Quando usar Designer ou CodeFirst:</u></strong>
                              </p>
                              
                              <p>
                                Esta é um pergunta bem complicada, eu diria que se você usa somente um banco de dados e precisa trabalhar com Stored Procedures é melhor usar o Designer, principalmenet porquê o CodeFirst ainda não suporta procedures nativamente.
                              </p>
                              
                              <p>
                                Se você quer criar uma aplicação multibanco, de maneira mais rápida e simples através de classes POCO, então o CodeFirst é sua escolha.
                              </p>
                              
                              <p>
                                Muito importante saber também que o Entity Framework Designer e o CodeFirst são independentes e podem não compartilhar alguns recursos.
                              </p>
                              
                              <p>
                                Espero que o artigo seja útil para vocês e se assim desejarem façam seus comentários ou sugestões.
                              </p>
                              
                              <p>
                                Até a próxima, <br />Carlos dos Santos.
                              </p>
---
id: 5341
title: 'Criando &Iacute;ndices no Entity Framework CodeFirst'
date: 2014-07-01T23:51:36-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=5341
permalink: /2014/07/criando-ndices-no-entity-framework-codefirst/
categories:
  - 'C#'
  - Entity Framework
---
<p align="left">
  <p>
    Olá pessoal,
  </p>
  
  <p>
    A partir da versão 6.1 do EntityFramework é possível criar índices no banco de dados, especificando isto diretamente nas classes no código fonte. Esta criação dos índices é feira através do atributo <strong>Index</strong> diretamente sobre o campo da classe. <u>Mas atenção</u>: isto só é possível utilizando o recurso Migrations do EntityFramework.
  </p>
  
  <p>
    Para demonstrar este recurso, vamos criar um projeto do tipo Console no Visual Studio e vamos adicionar o EntityFramework CodeFirst usando o pacote NuGet.
  </p>
  
  <p>
    Criando o Projeto Console:
  </p>
  
  <p>
    <a href="http://carloscds.net/wp-content/uploads/2014/07/SNAGHTML4fb2cd3.png"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTML4fb2cd3" src="http://carloscds.net/wp-content/uploads/2014/07/SNAGHTML4fb2cd3_thumb.png" alt="SNAGHTML4fb2cd3" width="836" height="479" border="0" /></a>
  </p>
  
  <p>
    Adicionando o EntityFramework CodeFirst com o NuGet Package (Tools/Nuget Package Manager/Package Manager Console) e iremos adicionar o pacote com o comando abaixo:
  </p>
  
  <p>
    <strong>P</strong><strong>M> Install-Package EntityFramework</strong>
  </p>
  
  <p>
    Vamos agora adicionar a nossa classe de Contexto:
  </p>
  
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/4c28f162aec0c21b4818513d5d0dec21">Gist</a>.
    </noscript>
  </div>
  
  <div id="codeSnippetWrapper" class="csharpcode-wrapper">
    <div id="codeSnippetWrapper" class="csharpcode-wrapper">
      <div id="codeSnippet" class="csharpcode">
        <pre class="alteven"></pre>
        
        <p>
          <!--CRLF-->
        </p>
      </div>
      
      <p>
        <span style="font-size: inherit;">E na sequência a classe Cliente:</span>
      </p>
      
      <div class="oembed-gist">
        <noscript>
          View the code on <a href="https://gist.github.com/carloscds/2107e205e7ac0704b6dcc8177efa345c">Gist</a>.
        </noscript>
      </div>
    </div>
  </div>
  
  <div id="codeSnippetWrapper" class="csharpcode-wrapper">
    <div id="codeSnippet" class="csharpcode">
      <pre class="alt"><strong style="font-size: inherit; color: #191e23; font-family: 'Noto Serif';"><u>Criando os índices:</u></strong></pre>
    </div>
  </div>
  
  <p>
    Vamos imaginar que você precise criar um índice para o campo Nome classe Cliente. Iremos usar então o atributo Index e também o MaxLength para determinarmos o tamanho máximo do campo. O atributo Index está no NameSpace: System.ComponentModel.DataAnnotations.Schema
  </p>
  
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/e9d5029b5cf331624e3bd0779792290f">Gist</a>.
    </noscript>
  </div>
  
  <div id="codeSnippetWrapper" class="csharpcode-wrapper">
    <div id="codeSnippet" class="csharpcode">
      <pre class="alt"></pre>
    </div>
  </div>
  
  <p>
    Veja que é bem simples, basta adicionar o atributo Index em cima do campo que você quer o índice! Você pode também dar um nome para o índice e, caso seja um índice composto (mais de um campo) indicar qual a posição do campo no índice.
  </p>
  
  <p>
    Para nomear o índice, basta informar, por exemplo: <strong>[Index(“MeuIndice”)]</strong> e se você quiser informar também a posição, basta adicionar logo após o nome. Você ainda pode indicar se o índice é Clustered ou Unique. O nome do índice não é obrigatório.
  </p>
  
  <p>
    Lembrando o que falei no início do post, a criação do índice é feita usando o Migrations e agora vamos adicioná-lo ao nosso projeto utilizando a Package Manager Console novamente:
  </p>
  
  <p>
    <strong>PM> Enable-Migrations</strong>
  </p>
  
  <p>
    Agora já podemos começar a enviar os comandos do migrations para criar ou atualizar nosso banco de dados. Começamos então adicionando um checkpoint para o migrations:
  </p>
  
  <p>
    <strong>PM> Add-Migration CriacaoBanco</strong>
  </p>
  
  <p>
    Se você verificar o código gerado pelo Migrations, verá a criação do índice (neste exemplo eu dei o nome “MeuIndice” para o índice):
  </p>
  
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/eabc79f87d6abbda10a6c5b629ac4664">Gist</a>.
    </noscript>
  </div>
  
  <div id="codeSnippetWrapper" class="csharpcode-wrapper">
    <div id="codeSnippet" class="csharpcode">
      <p>
        <!--CRLF-->
      </p>
    </div>
  </div>
  
  <p>
    Veja o comando .Index(t => t.nome, name: “Meu_Indice”). Ele é quem irá criar o índice quando aplicarmos a alteração no banco de dados, mas antes de criarmos o banco de dados não podemos esquecer da string de conexão de deve estar no app.config ou web.config (no caso de aplicações web). Vamos adicionar a linha com a conexão:
  </p>
  
  <div class="oembed-gist">
    <noscript>
      View the code on <a href="https://gist.github.com/carloscds/de567d7cd80c3d529a86506841ee12d6">Gist</a>.
    </noscript>
  </div>
  
  <div id="codeSnippetWrapper" class="csharpcode-wrapper">
    <div id="codeSnippet" class="csharpcode">
      <pre class="alt"></pre>
      
      <p>
        <!--CRLF-->
      </p>
    </div>
  </div>
  
  <p>
    Agora vamos criar o banco de dados com o índice executando o comando Update-Database:
  </p>
  
  <p>
    <strong>PM> Update-DataBase</strong>
  </p>
  
  <p>
    Pronto, nosso banco foi criado com o índice que determinamos. Vejam a tela do Management Studio:
  </p>
  
  <p>
    <a href="http://carloscds.net/wp-content/uploads/2014/07/image.png"><img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/2014/07/image_thumb.png" alt="image" width="465" height="407" border="0" /></a>
  </p>
  
  <p>
    Ao invés de criar o banco diretamente, você também pode adicionar o parametro –Script ao Update-Database para assim, gerar o script do seu bando de dados.
  </p>
  
  <p>
    Agora você já pode adicionar a criação de índices ao seus projetos do EntityFramework e assim, melhorar a performance de suas consultas.
  </p>
  
  <p>
    Abraços e até a próxima,
  </p>
  
  <p>
    Carlos dos Santos.
  </p>
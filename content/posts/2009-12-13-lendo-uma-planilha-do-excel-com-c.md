---
id: 22
title: 'Lendo uma Planilha do Excel com C#'
date: 2009-12-13T11:47:07-03:00
author: carloscds
layout: post
guid: /post/2009/12/13/Lendo-uma-Planilha-do-Excel-com-C.aspx
permalink: /2009/12/lendo-uma-planilha-do-excel-com-c/
categories:
  - 'C#'
  - Visual Studio
tags:
  - 'c#; msdn'
---
Hoje em dia é muito comum recebermos dados em planilhas do Excel e ter que importar ou analisar estes dados em nossas aplicações.

Com a ajuda do .Net Framework esta tarefa fica muito fácil e vou demonstrar como você pode abrir um arquivo do Excel e executar um comando Select em uma planilha simplesmente usando Ado.Net.

Para começar, vamos mostrar como está a nossa planilha no Excel e quais as informações importantes para o nosso programa em .Net.

Nossa planilha tem estes dados:

[<img style="display: inline; border: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/image_thumb_10.png" border="0" alt="image" width="523" height="393" />](http://carloscds.net/wp-content/uploads/image_10.png)

Vejam que a planilha tem os títulos das colunas na primeira linha. Estes serão os nomes dos campos para o nosso comando Select, e também o nome da planilha, que é Sheet1, será o nome da nossa tabela.

Agora vamos criar um projeto do tipo Console no Visual Studio:

[<img style="display: inline; border: 0px;" title="image" src="http://carloscds.net/wp-content/uploads/image_thumb_11.png" border="0" alt="image" width="502" height="201" />](http://carloscds.net/wp-content/uploads/image_11.png)

Obs: no meu exemplo estou usando o Visual Studio 2010, mas vocês podem usar o Visual Studio 2008 com .Net Framework 2.0 sem problemas.

Criada nossa solução, vamos agora escrever o código. Para acessar os dados na planilha, vamos usar o Ado.Net e DataSet, para ser mais fácil de entender, e sendo assim precisamos incluir os namespaces apropriados:

<p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
  <span style="font-family: consolas; color: blue; font-size: 9.5pt;"><br /> using</span><span style="font-family: consolas; font-size: 9.5pt;"> System.Data;<br /> </span><span style="font-family: consolas; color: blue; font-size: 9.5pt;">using</span>
</p>

<div class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
  <span style="font-family: consolas; font-size: 9.5pt;"> System.Data.OleDb;<br /> </span>
</div>

<span style="font-family: consolas; font-size: 9.5pt;"> </p> 

<p>
  </span>
</p>

<p>
  Após isto, precisamos criar a conexão com a planilha, usando OleDB:
</p>

<p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
  <span style="font-family: consolas; font-size: 9.5pt;"><span style="color: #2b91af;"><br /> OleDbConnection</span> conexao = <span style="color: blue;">new</span> <span style="color: #2b91af;">OleDbConnection</span>(<span style="color: #a31515;">@&#8221;Provider=Microsoft.ACE.OLEDB.12.0;Data Source=<strong>c:tempplanilha.xlsx</strong>;Extended Properties=&#8217;Excel 12.0 Xml;HDR=YES&#8217;;&#8221;</span>);</span>
</p>

<p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
  <span style="font-family: consolas; font-size: 9.5pt;"><br /> Nesta conexão, usamos o provider Microsoft.ACE.OLEDB e indicamos o noem da planilha, bem como a versão do Excel.</span>
</p>

<p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
  <span style="font-family: consolas; font-size: 9.5pt;">Criaremos agora um Adapter para executar o comando Select, e também um DataSet para armazenar os dados da consulta:</span>
</p>

<p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
  <span style="font-family: consolas; font-size: 9.5pt;"><span style="color: #2b91af;"><br /> OleDbDataAdapter</span> adapter = <span style="color: blue;">new</span> <span style="color: #2b91af;">OleDbDataAdapter</span>(<span style="color: #a31515;">&#8220;select * from [Sheet1$]&#8221;</span>, conexao);<br /> </span><span style="font-family: consolas; font-size: 9.5pt;"><span style="color: #2b91af;">DataSet</span> ds = <span style="color: blue;">new</span> <span style="color: #2b91af;">DataSet</span>();</span>
</p>

<p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
  <span style="font-family: consolas; font-size: 9.5pt;"><br /> Observem que o nome da planilha tem um símbolo ‘$’ ao final e está entre colchetes ‘[]’.</span>
</p>

<p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
  <span style="font-family: consolas; font-size: 9.5pt;">Agora vamos abrir a conexão, preencher o DataSet e exibir os dados da planilha:</span>
</p>

<p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
  <span style="font-family: consolas; font-size: 9.5pt;"><span style="color: blue;"><br /> try<br /> </span></span><span style="font-family: consolas; font-size: 9.5pt;">{<br /> </span><span style="font-family: consolas; font-size: 9.5pt;">   conexao.Open();<br /> </span>
</p>

<div class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
  <span style="font-family: consolas; font-size: 9.5pt;">   adapter.Fill(ds); </span>
</div>

<p>
  <span style="font-family: consolas; font-size: 9.5pt;"><span style="font-family: consolas; font-size: 9.5pt;"><span style="color: blue;">   foreach</span> (<span style="color: #2b91af;">DataRow</span> linha <span style="color: blue;">in</span> ds.Tables[<span style="color: brown;"></span>].Rows)<br /> </span><span style="font-family: consolas; font-size: 9.5pt; mso-ansi-language: pt-br;" lang="PT-BR">   {<br /> </span><span style="font-family: consolas; font-size: 9.5pt; mso-ansi-language: pt-br;" lang="PT-BR"><span style="color: #2b91af;">     Console</span>.WriteLine(<span style="color: #a31515;">&#8220;Nome: {0} &#8211; Cargo: {1} &#8211; Salario: {2}&#8221;</span>, linha[<span style="color: #a31515;">&#8220;nome&#8221;</span>].ToString(),<br /> </span><span style="font-family: consolas; font-size: 9.5pt; mso-ansi-language: pt-br;" lang="PT-BR">                        linha[<span style="color: #a31515;">&#8220;cargo&#8221;</span>].ToString(), linha[<span style="color: #a31515;">&#8220;salario&#8221;</span>].ToString());<br /> </span><span style="font-family: consolas; font-size: 9.5pt; mso-ansi-language: pt-br;" lang="PT-BR">   }<br /> </span><span style="font-family: consolas; font-size: 9.5pt; mso-ansi-language: pt-br;" lang="PT-BR">}<br /> </span><span style="font-family: consolas; font-size: 9.5pt; mso-ansi-language: pt-br;" lang="PT-BR"><span style="color: blue;">catch</span> (<span style="color: #2b91af;">Exception</span> ex)<br /> </span><span style="font-family: consolas; font-size: 9.5pt; mso-ansi-language: pt-br;" lang="PT-BR">{<br /> </span><span style="font-family: consolas; font-size: 9.5pt; mso-ansi-language: pt-br;" lang="PT-BR"><span style="color: #2b91af;">   Console</span>.WriteLine(<span style="color: #a31515;">&#8220;Erro ao acessar os dados: &#8220;</span> + ex.Message);<br /> </span><span style="font-family: consolas; font-size: 9.5pt;">}<br /> </span><span style="font-family: consolas; font-size: 9.5pt;"><span style="color: blue;">finally<br /> </span></span><span style="font-family: consolas; font-size: 9.5pt;">{<br /> </span><span style="font-family: consolas; font-size: 9.5pt;">   conexao.Close();<br /> </span></p> 
  
  <div>
    <span style="font-family: consolas; font-size: 9.5pt;">} </span>
  </div>
  
  <p>
    </span><span style="font-family: consolas; font-size: 9.5pt;"> </p> 
    
    <p>
      </span>
    </p>
    
    <p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
      <span style="font-family: consolas; font-size: 9.5pt;">Entendendo o código, abrimos a conexão, preenchemos o DataSet com o método Fill() do Adapter e depois executamos um ForEach para exibir os dados. Fazemos também o tratamento de exceção caso ocorra algum erro.</p> 
      
      <p>
        </span>
      </p>
      
      <p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
        <span style="font-family: consolas; font-size: 9.5pt;">Vocês devem ter percebido que é um código bastante simples, mas de grande ajuda.</p> 
        
        <p>
          </span>
        </p>
        
        <p class="MsoNormal" style="line-height: normal; margin-bottom: 0pt; mso-layout-grid-align: none;">
          []s,<br /> <span style="font-family: consolas; font-size: 9.5pt;">Carlos.</p> 
          
          <p>
            </span>
          </p>
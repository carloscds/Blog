---
id: 6231
title: 'Visual Studio 2015 e C# 6&ndash;Algumas Novidades'
date: 2014-11-16T18:02:58-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=6231
permalink: /2014/11/visual-studio-2015-e-c-6algumas-novidades/
categories:
  - 'C#'
tags:
  - 'msdn;c#'
---
Olá, como todos já devem saber a Microsoft liberou na última quarta-feira (12/11) a versão Public Preview do [Visual Studio 2015](http://www.visualstudio.com/en-us/downloads/visual-studio-2015-downloads-vs.aspx) e também uma versão free agora chamada de [Visual Studio 2013 Community](http://www.visualstudio.com/en-us/downloads/download-visual-studio-vs#d-community). Junto com o Visual Studio 2015 temos agora o novo C# 6. Neste post vou falar sobre algumas das novidades da IDE e também do C# 6.

**<font size="4"><u>Novidades da IDE:</u></font>**

**<u>Code Fixer:</u>** identifica problemas no código e mostrar possíveis soluções:

[<img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/11/image_thumb3.png" width="790" height="240" />](http://carloscds.net/wp-content/uploads/2014/11/image3.png)

Ao encontrar um possível problema no código, é mostrada uma pequena “lâmpada amarela” que ao ser clicada mostra os fixers disponíveis. O mais interessante é que você tem um preview do seu código com a aplição do Fixer:

[<img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/11/image_thumb4.png" width="980" height="289" />](http://carloscds.net/wp-content/uploads/2014/11/image4.png)

Após isto é só escolher o fixer que mais lhe agrada e aplicá-lo. Nem precis dizer que isto aumenta exponencialmente a sua produtvidade!!!

**<u>InLine Rename:</u>** renomeia o seu código e mostrando o que será modificado em destaque

[<img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/11/image_thumb5.png" width="547" height="359" />](http://carloscds.net/wp-content/uploads/2014/11/image5.png)

Ao clicar com o botão direito do mouse sobre o nome “Funcao” e escolher Rename, todas os locais já são identificados e o rename é feito diretamente no editor, digitando sobre o nome em destaque e tem mais, você pode renomear até o que em comentários, basta configurar a janela abaixo, que aparece no canto direito do seu editor.

[<img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/11/image_thumb6.png" width="345" height="258" />](http://carloscds.net/wp-content/uploads/2014/11/image6.png)

**<u>Novo Gerenciador de Pacotes NuGet:</u>**

Você já deve utilizar o NuGet para instalaer componentes em seus projetos, eu mesmo já demonstrei isto em vários outros posts aqui no blog. Mas agora é possível gerenciar e instalar os pacotes através de uma nova janela bem mais simples, que você abre clicando com o botão direito do mouse em Referentes na sua Solution:

[<img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/11/image_thumb7.png" width="560" height="257" />](http://carloscds.net/wp-content/uploads/2014/11/image7.png)

Isto abre a nova janela o NuGet:

[<img title="image" style="border-left-width: 0px; border-right-width: 0px; background-image: none; border-bottom-width: 0px; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-top-width: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2014/11/image_thumb8.png" width="967" height="587" />](http://carloscds.net/wp-content/uploads/2014/11/image8.png)

Esta janela tem uma grande novidade que é permitir você escolher a versão do pacote que quer instalar. Mas você ainda pode continuar instalando seus pacotes pelo gerenciador de linha de comando.

**<u><font size="4">Novidades do C# 6:</font></u>**

**<u>Formatando Strings:</u>**

Hoje para formatarmos uma string, utilizamos String.Format():

<pre class="brush: c-sharp; showcolumns: true">var X = 10; 
<br />var Y = 20; 
<br />
<br />var str0 = string.Format("Valor de X: {0} e Y: {1}", X,Y); 
<br /></pre>

Mas com o C# 6, podemos fazer isto desta forma:

<pre class="brush: c-sharp; toolbar: false">var X = 10; 
var Y = 20; 

var str1 = "Valor de X: \{X} e Y: \{Y}";</pre>

Aqui nos simplesente montamos a string e no local onde queremos os valores, nós os colocamos precedidos de uma barra invertida e dentro de colchetes.

**<u>Usando operadores nulos (?.):</u>**

É muito comum durante o desenvolvimento você verificar se algum tipo objeto não é nulo, para assim chamar algum método ou valor. Normalmente faríamos assim:

<pre class="brush: c-sharp; toolbar: false">var conexao = new SqlConnection("data source=(local); initial catalog=northwind; integrated security=true"); 
var cmd = new SqlCommand("select CompanyName from customers where CustomerID='AAAA'", conexao); 
conexao.Open(); 

var retorno = cmd.ExecuteScalar(); 
if(retorno != null) 
{    
     var dados = retorno.ToString(); 
} 
conexao.Close(); 
 </pre>

Agora podemos fazer assim:

<pre class="brush: c-sharp; toolbar: false">dados = retorno?.ToString(); 
 </pre>

Isto informa ao compilador que é para ele executar o ToString() somente se a variável retorno for diferente de null. Simples não!!!

<u><strong>Exception Filters:</strong></u>

Você certamente trata os erros em sua aplicaçao através de Try…Catch…Finally, algo como o código abaixo:

<pre class="brush: c-sharp; toolbar: false">try 
{
}
catch (SqlException ex)
{
}
finally 
{ 
} </pre>

Agora imagine que você queira que a excecão SqlException disparasse somente se houvesse uma condição para isto acontecer:

<pre class="brush: c-sharp; toolbar: false">try 
{ 
} 
catch (SqlException ex) if(ex.Server == "MeuServidorLocal") 
{ 
} 
finally 
{ 
} </pre>

No nosso exemplo, a exceção só dispara se o nome do servidor for “MeuServidorLocal”

Novo compilador Roslyn (.Net Compiler Platform)

Esta é sem dúvida alguma a maior de todas as novidades, pois muito do quev acabei de escrever acima só é possível graças ao novo compilador. No [meu post anterior](http://carloscds.net/2014/11/c-roslyn-e-projeto-open-sourcecodecracker-2/) eu falei brevemente sobre o novo compilador e também sobre um projeto Open Source da qual eu estou fazendo parte. 

É isto aí pessoal, a idéia deste primeiro post sobre o Visual Studio 2015 e C# 6 é só para você sentirem o que está vindo por aí! Leiam, estudem, aproveitem!!!

Um grande abraço e até a próxima,  
  
Carlos dos Santos
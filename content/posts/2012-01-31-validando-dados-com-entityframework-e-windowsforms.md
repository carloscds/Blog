---
id: 710
title: Validando Dados com EntityFramework e WindowsForms
date: 2012-01-31T00:20:00-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2012/01/validando-dados-com-entityframework-e-windowsforms/
permalink: /2012/01/validando-dados-com-entityframework-e-windowsforms/
categories:
  - Uncategorized
---
Pessoal,

Hoje vou mostrar uma maneira bem simples e interessante de fazer validação de dados com EntityFramework, classes POCO e uma aplicação Windows Forms.

Como eu já comentei em outros posts, quando você utiliza DataAnnotations em classes POCO na sua camada de dados e faz a camada de apresentação com WPF/Silverlight ou MVC, o tratamento dos campos é feito automaticamente, praticamente sem nenhum tipo de código. Mas e se você ainda programa para WindowsForms ou precisa validar os dados da classe em uma camada e retornar o erro para outra camada, como fazer ? Isto é o que veremos a seguir.

Primeiro vamos criar um projeto Windows Forms no Visual Studio 2010:  
<a href="http://carloscds.net/wp-content/uploads/2012/01/image14.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb16.png" width="426" height="401" /></a>

Agora vamos adicionoar o EntityFramework CodeFirst usando o NuGet, como eu expliquei <a href="http://carloscds.net/2012/01/entityframework-codefirst/" target="_blank">neste post</a>. E logo após vamos criar uma classes chamada Produto e vamos adicionar os <a href="http://msdn.microsoft.com/en-us/data/gg193958" target="_blank">annotations</a> nela. Annotations são marcações acima dos campos que definem várias informações ao engine do Entitu Framework, como por exemplo, os valores permitidos no campo.

Nossa classe produto ficará da seguinte maneira: 

<pre style="border-bottom: #cecece 1px solid; border-left: #cecece 1px solid; padding-bottom: 5px; background-color: #fbfbfb; min-height: 40px; padding-left: 5px; width: 650px; padding-right: 5px; overflow: auto; border-top: #cecece 1px solid; border-right: #cecece 1px solid; padding-top: 5px"><pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  1: <span style="color: #0000ff">using</span> System;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  2: <span style="color: #0000ff">using</span> System.Collections.Generic;
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  3: <span style="color: #0000ff">using</span> System.Linq;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  4: <span style="color: #0000ff">using</span> System.Text;
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  5: <span style="color: #0000ff">using</span> System.ComponentModel.DataAnnotations;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  6: 
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  7: <span style="color: #0000ff">namespace</span> WindowsFormsValidacao
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  8: {
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  9:     [Table("<span style="color: #8b0000">Produto</span>")]
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 10:     <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Produto : ValidacaoEntidade 
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 11:     {
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 12:         <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> ID { <span style="color: #0000ff">get</span>; <span style="color: #0000ff">set</span>; }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 13:         [Required(ErrorMessage="<span style="color: #8b0000">Descrição em branco</span>"])
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 14:         <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Descricao { <span style="color: #0000ff">get</span>; <span style="color: #0000ff">set</span>; }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 15:         [Range(1,10000,ErrorMessage="<span style="color: #8b0000">Valor deve estar entre 1 e 10000</span>")]
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 16:         <span style="color: #0000ff">public</span> <span style="color: #0000ff">double</span> SaldoMinimo { <span style="color: #0000ff">get</span>; <span style="color: #0000ff">set</span>; }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 17:         [Required(ErrorMessage="<span style="color: #8b0000">Custo em branco</span>")]
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 18:         <span style="color: #0000ff">public</span> <span style="color: #0000ff">decimal</span> Custo { <span style="color: #0000ff">get</span>; <span style="color: #0000ff">set</span>; }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 19:         <span style="color: #0000ff">public</span> <span style="color: #0000ff">decimal</span> Venda { <span style="color: #0000ff">get</span>; <span style="color: #0000ff">set</span>; }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 20:         [MaxLength(20,ErrorMessage="<span style="color: #8b0000">Tamanho máximo = 20</span>")]
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 21:         <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Localizacao { <span style="color: #0000ff">get</span>; <span style="color: #0000ff">set</span>; }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 22:     }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 23: }</pre>


<p>
  
</p>


<p>
  Veja que a nossa classe está herdando de ValidacaoEntidade, que é onde iremos fazer o método de validaçao dos campos, veja abaixo:<br />
    
</p>


<pre style="border-bottom: #cecece 1px solid; border-left: #cecece 1px solid; padding-bottom: 5px; background-color: #fbfbfb; min-height: 40px; padding-left: 5px; width: 650px; padding-right: 5px; overflow: auto; border-top: #cecece 1px solid; border-right: #cecece 1px solid; padding-top: 5px"><pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  1: <span style="color: #0000ff">using</span> System;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  2: <span style="color: #0000ff">using</span> System.Collections.Generic;
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  3: <span style="color: #0000ff">using</span> System.Linq;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  4: <span style="color: #0000ff">using</span> System.Text;
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  5: <span style="color: #0000ff">using</span> System.ComponentModel;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  6: <span style="color: #0000ff">using</span> System.ComponentModel.DataAnnotations;
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  7: <span style="color: #0000ff">using</span> System.Xml.Serialization;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  8: 
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  9: <span style="color: #0000ff">namespace</span> WindowsFormsValidacao
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 10: {
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 11:     <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> ValidacaoEntidade : IDataErrorInfo
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 12:     {
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 13:         [NotMapped]
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 14:         <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Error
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 15:         {
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 16:             <span style="color: #0000ff">get</span> { <span style="color: #0000ff">return</span> "<span style="color: #8b0000"></span>"; }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 17:         }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 18: 
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 19:         [NotMapped]
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 20:         <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> <span style="color: #0000ff">this</span>[<span style="color: #0000ff">string</span> columnName]
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 21:         {
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 22:             <span style="color: #0000ff">get</span>
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 23:             {
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 24:                 <span style="color: #0000ff">return</span> ValidateProperty(columnName);
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 25:             }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 26:         }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 27: 
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 28:         <span style="color: #0000ff">protected</span> <span style="color: #0000ff">string</span> ValidateProperty(<span style="color: #0000ff">string</span> propertyName)
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 29:         {
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 30:             var info = <span style="color: #0000ff">this</span>.GetType().GetProperty(propertyName);
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 31: 
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 32:             <span style="color: #0000ff">if</span> (!info.CanWrite)
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 33:             {
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 34:                 <span style="color: #0000ff">return</span> <span style="color: #0000ff">null</span>;
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 35:             }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 36: 
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 37:             var <span style="color: #0000ff">value</span> = info.GetValue(<span style="color: #0000ff">this</span>, <span style="color: #0000ff">null</span>);
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 38:             IEnumerable&lt;<span style="color: #0000ff">string</span>&gt; errorInfos =
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 39:                   (from va <span style="color: #0000ff">in</span> info.GetCustomAttributes(<span style="color: #0000ff">true</span>).OfType&lt;ValidationAttribute&gt;()
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 40:                    where !va.IsValid(<span style="color: #0000ff">value</span>)
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 41:                    select va.FormatErrorMessage(<span style="color: #0000ff">string</span>.Empty)).ToList();
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 42: 
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 43: 
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 44:             <span style="color: #0000ff">if</span> (errorInfos.Count() &gt; 0)
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 45:             {
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 46:                 <span style="color: #0000ff">return</span> errorInfos.FirstOrDefault&lt;<span style="color: #0000ff">string</span>&gt;();
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 47:             }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 48:             <span style="color: #0000ff">return</span> <span style="color: #0000ff">null</span>;
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 49:         }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 50: 
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 51:         <span style="color: #0000ff">public</span> IEnumerable&lt;<span style="color: #0000ff">string</span>&gt; Validate(<span style="color: #0000ff">bool</span> Formatar=<span style="color: #0000ff">false</span>)
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 52:         {
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 53:             <span style="color: #0000ff">foreach</span> (var prop <span style="color: #0000ff">in</span> <span style="color: #0000ff">this</span>.GetType().GetProperties())
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 54:             {
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 55:                 <span style="color: #0000ff">string</span> err = ValidateProperty(prop.Name);
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 56:                 <span style="color: #0000ff">if</span> (!String.IsNullOrWhiteSpace(err))
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 57:                 {
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 58:                     yield <span style="color: #0000ff">return</span> prop.Name + "<span style="color: #8b0000">: </span>" + err + ((Formatar) ? "<span style="color: #8b0000">&lt;br&gt;</span>" : "<span style="color: #8b0000"></span>").ToString();
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 59:                 }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 60:             }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 61:         }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 62:     }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 63: }</pre>


<p>
  
</p>


<p>
  Nesta classe está o segredo da validação, o método Validate(). Este método percorre todos os campos da nossa classe e verifica seu CustomAttribute(), procurando pelo ValidationAttribute, que é o nosso DataAnnotations, se o valor não for for válido, ele retorna a mensagem de erro que atribuímos ao campos e vai adicionando a uma lista, que poderemos usar em nossa camada de apresentação.
</p>


<p>
  Adicionamos agora vamos adicionar a nossa classe de contexto:<br />
    
</p>


<pre style="border-bottom: #cecece 1px solid; border-left: #cecece 1px solid; padding-bottom: 5px; background-color: #fbfbfb; min-height: 40px; padding-left: 5px; width: 650px; padding-right: 5px; overflow: auto; border-top: #cecece 1px solid; border-right: #cecece 1px solid; padding-top: 5px"><pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  1: <span style="color: #0000ff">using</span> System;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  2: <span style="color: #0000ff">using</span> System.Collections.Generic;
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  3: <span style="color: #0000ff">using</span> System.Linq;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  4: <span style="color: #0000ff">using</span> System.Text;
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  5: <span style="color: #0000ff">using</span> System.Data.Entity;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  6: 
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  7: <span style="color: #0000ff">namespace</span> WindowsFormsValidacao
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  8: {
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  9:     <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> Contexto : DbContext
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 10:     {
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 11:         <span style="color: #0000ff">public</span> DbSet&lt;Produto&gt; Produto { <span style="color: #0000ff">get</span>; <span style="color: #0000ff">set</span>; }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 12:     }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 13: }</pre>


<p>
  
</p>


<p>
  Agora vamos adicionar os campos em nosso formulário, que ficará desta forma:<br />
    <br /><a href="http://carloscds.net/wp-content/uploads/2012/01/image15.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb17.png" width="565" height="408" /></a>
</p>


<p>
  O TextBox (txtErros) abaixo do botão Salvar é onde iremos mostrar os erros.
</p>


<p>
  Vamos adicionar um DataSource para podermos trabalhar com nossa classe Produto, para isto vá no menu Data/Add New DataSource e escolha Object:<br />
    <br /><a href="http://carloscds.net/wp-content/uploads/2012/01/image17.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb18.png" width="598" height="348" /></a>
</p>


<p>
  Depois escolha a classe produto:<br />
    <br /><a href="http://carloscds.net/wp-content/uploads/2012/01/image18.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb19.png" width="598" height="457" /></a>
</p>


<p>
  Agora você precisa ligar todos os campos TextBox do formulário aos campos da classe. Para fazer isto, clique sobre o TextBox, vá em propriedades/DataBindings/Text e escolha o campo correspondente ao controle. Faça isto para todos os controles:
</p>


<p>
  <a href="http://carloscds.net/wp-content/uploads/2012/01/image19.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb20.png" width="389" height="560" /></a> 
</p>


<p>
  Após o primeiro campo, escolha os campos sempre a partir do bindingsource: 
</p>


<p>
  <a href="http://carloscds.net/wp-content/uploads/2012/01/image20.png" rel="lightbox"><img style="background-image: none; border-right-width: 0px; padding-left: 0px; padding-right: 0px; display: inline; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px; padding-top: 0px" title="image" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2012/01/image_thumb21.png" width="381" height="254" /></a>
</p>


<p>
  Agora vamos ao código do botão incluir, que simplesmente adiciona um novo objeto Produto vinculado a tela:<br />
    
</p>


<pre style="border-bottom: #cecece 1px solid; border-left: #cecece 1px solid; padding-bottom: 5px; background-color: #fbfbfb; min-height: 40px; padding-left: 5px; width: 650px; padding-right: 5px; overflow: auto; border-top: #cecece 1px solid; border-right: #cecece 1px solid; padding-top: 5px"><pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  1: <span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> btnNovo_Click(<span style="color: #0000ff">object</span> sender, EventArgs e)
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  2:         {
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  3:             produtoBindingSource.AddNew();
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  4:         }</pre>


<p>
  
</p>


<p>
  E por fim vamos ao código que valida os dados e depois insere no BD:<br />
    
</p>


<pre style="border-bottom: #cecece 1px solid; border-left: #cecece 1px solid; padding-bottom: 5px; background-color: #fbfbfb; min-height: 40px; padding-left: 5px; width: 650px; padding-right: 5px; overflow: auto; border-top: #cecece 1px solid; border-right: #cecece 1px solid; padding-top: 5px"><pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  1:  <span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> btnSalvar_Click(<span style="color: #0000ff">object</span> sender, EventArgs e)
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  2:         {
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  3:             var db = <span style="color: #0000ff">new</span> Contexto();
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  4:             db.Database.CreateIfNotExists();
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  5: 
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  6:             var pro = (Produto)produtoBindingSource.Current;
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  7:             var erros = pro.Validate();
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  8:             <span style="color: #0000ff">if</span> (erros.Count() &gt; 0)
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px">  9:             {
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 10:                 txtErros.Text = "<span style="color: #8b0000"></span>";
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 11:                 <span style="color: #0000ff">foreach</span> (var err <span style="color: #0000ff">in</span> erros)
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 12:                 {
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 13:                     txtErros.Text += err + Environment.NewLine;
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 14:                 }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 15:             }
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 16:             <span style="color: #0000ff">else</span>
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 17:             {
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 18:                 db.Produto.Add(pro);
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 19:                 db.SaveChanges();
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 20:                 MessageBox.Show("<span style="color: #8b0000">Produto inserido!</span>");
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 21:                 produtoBindingSource.ResetCurrentItem();
</pre>


<pre style="background-color: #ffffff; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 22:             }
</pre>


<pre style="background-color: #fbfbfb; margin: 0em; width: 100%; font-family: consolas,&#39;Courier New&#39;,courier,monospace; font-size: 11px"> 23:         }</pre>
</p>


<p>
  <u>Observação:</u> A criação do banco de dados neste ponto é meramente didática, para facilitar o exemplo e não é uma prática recomendável em uma aplicação em produção. 
</p>


<p>
  Agora vamos recuperar o produto que está vinculado a tela e logo após vamos chamar o método Validate() que irá retornar a lista de erros que vamos exibir. . Recuperamos o Produto acessando a propriedade Current do BindingSource, mas como ela armazena somente objetos, precisamos converter o valor de Current para o tipo Produto e logo após isto chamamos a validação e caso não exista erros, inserimos o Produto no BD e atualizamos a tela. Os erros são mostrados no campo txtErros na tela. 
</p>


<p>
  Você pode formatar a saída do erro modificando o método Validate() na classe ValidacaoEntidade.
</p>


<p>
  Espero que este pequeno exemplo tenha mostrado o quanto é simples fazer validações mesmo em plataformas não tão novas, como o Windows Forms, e isto pode também ser utilizado para validar objetos em camadas separadas da aplicação.
</p>


<p>
  Você pode baixar o código fonte deste exemplo <a href="http://carloscds.net/artigos/WindowsFormsValidacao.zip" target="_blank">aqui</a>.
</p>


<p>
  Abraços e até a próxima.<br />
    <br />Carlos dos Santos.
</p>
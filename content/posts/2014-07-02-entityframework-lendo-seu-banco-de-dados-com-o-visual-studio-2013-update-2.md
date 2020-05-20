---
id: 5481
title: EntityFramework-Lendo seu banco de dados com o Visual Studio 2013 Update 2
date: 2014-07-02T09:02:31-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=5481
permalink: /2014/07/entityframework-lendo-seu-banco-de-dados-com-o-visual-studio-2013-update-2/
categories:
  - 'C#'
  - Entity Framework
---
<pre><span style="font-family: Georgia, 'Times New Roman', 'Bitstream Charter', Times, serif; font-size: 14px; line-height: 1.5em;">Olá pessoal,</span></pre>

Há algum tempo atrás eu fiz um post falando sobre como <a href="http://carloscds.net/2014/04/entityframeworkapoveitando-seu-banco-de-dados-com-powertools/" target="_blank">aproveitar seu banco de dados existente com o EntityFramework PowerTools</a>, mas o modelo do PowerTools não permite escolher as tabelas ou views que você quer ler, e ás vezes isto é bem útil.

Com o lançamento do Update 2 do Visual Studio 2013 e também do EntityFramework 6.1, foi adicionada uma nova opção nas fontes de dados, que agora permite também fazer engenharia reversa com CodeFirst escolhendo quais tabelas e views serão lidas, a exemplo do que já era possível com o EntityFramework Designer.

Para demonstrar isto, vamos criar um novo projeto do tipo Console no Visual Studio 2013:

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTMLa64a79f" alt="SNAGHTMLa64a79f" src="http://carloscds.net/wp-content/uploads/2014/07/SNAGHTMLa64a79f_thumb.png" width="625" height="434" border="0" />](http://carloscds.net/wp-content/uploads/2014/07/SNAGHTMLa64a79f.png)

Agora vamos fazer a engenharia reversa, mas utilizando o novo recurso do Visual Studio 2013. Para isto, no seu projeto clique com o botão direito do mouse na solution e depois vá em Add/New Item:

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="image" alt="image" src="http://carloscds.net/wp-content/uploads/2014/07/image_thumb1.png" width="538" height="240" border="0" />](http://carloscds.net/wp-content/uploads/2014/07/image1.png)

Agora vamos adicionar um ADO.NET Entity Data Mode:

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTMLa676ebe" alt="SNAGHTMLa676ebe" src="http://carloscds.net/wp-content/uploads/2014/07/SNAGHTMLa676ebe_thumb.png" width="548" height="380" border="0" />](http://carloscds.net/wp-content/uploads/2014/07/SNAGHTMLa676ebe.png)

E veja que agora existe uma nova opção chamada “Code First from database” e com ela iremos ler um banco de dados já existente e criar todo o código para o CodeFirst.

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTMLa69ebd4" alt="SNAGHTMLa69ebd4" src="http://carloscds.net/wp-content/uploads/2014/07/SNAGHTMLa69ebd4_thumb.png" width="509" height="456" border="0" />](http://carloscds.net/wp-content/uploads/2014/07/SNAGHTMLa69ebd4.png)

Vamos então escolher esta opção e colocar a conexão para o nosso banco de dados existente: (no meu exemplo estou usando o banco da Microsoft chamado Northwind)

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTMLa69538c" alt="SNAGHTMLa69538c" src="http://carloscds.net/wp-content/uploads/2014/07/SNAGHTMLa69538c_thumb.png" width="507" height="455" border="0" />](http://carloscds.net/wp-content/uploads/2014/07/SNAGHTMLa69538c.png)

Agora você pode escolher as tabelas e views que quiser para o seu projeto do CodeFirst:

[<img style="background-image: none; padding-top: 0px; padding-left: 0px; display: inline; padding-right: 0px; border-width: 0px;" title="SNAGHTMLa6b3694" alt="SNAGHTMLa6b3694" src="http://carloscds.net/wp-content/uploads/2014/07/SNAGHTMLa6b3694_thumb.png" width="502" height="450" border="0" />](http://carloscds.net/wp-content/uploads/2014/07/SNAGHTMLa6b3694.png)

Feito isto, todas as classe serão geradas no CodeFirst, mas com uma grande diferença em relação ao PowerTools: as informações de mapeamento são geradas como DataAnnotations ao invés de FluentApi. Veja o exemplo da classe Products:

<div id="codeSnippetWrapper" style="overflow: auto; cursor: text; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 97.5%; direction: ltr; text-align: left; margin: 20px 0px 10px; line-height: 12pt; max-height: 200px; background-color: #f4f4f4; border: silver 1px solid; padding: 4px;">
  <div id="codeSnippet" style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;">
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum1" style="color: #606060;">   1:</span> <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">partial</span> <span style="color: #0000ff;">class</span> Products</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum2" style="color: #606060;">   2:</span>     {</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum3" style="color: #606060;">   3:</span>         [Key]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum4" style="color: #606060;">   4:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">int</span> ProductID { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum5" style="color: #606060;">   5:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum6" style="color: #606060;">   6:</span>         [Required]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum7" style="color: #606060;">   7:</span>         [StringLength(40)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum8" style="color: #606060;">   8:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">string</span> ProductName { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum9" style="color: #606060;">   9:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum10" style="color: #606060;">  10:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">int</span>? SupplierID { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum11" style="color: #606060;">  11:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum12" style="color: #606060;">  12:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">int</span>? CategoryID { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum13" style="color: #606060;">  13:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum14" style="color: #606060;">  14:</span>         [StringLength(20)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum15" style="color: #606060;">  15:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">string</span> QuantityPerUnit { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum16" style="color: #606060;">  16:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum17" style="color: #606060;">  17:</span>         [Column(TypeName = <span style="color: #006080;">"money"</span>)]</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum18" style="color: #606060;">  18:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">decimal</span>? UnitPrice { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum19" style="color: #606060;">  19:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum20" style="color: #606060;">  20:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">short</span>? UnitsInStock { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum21" style="color: #606060;">  21:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum22" style="color: #606060;">  22:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">short</span>? UnitsOnOrder { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum23" style="color: #606060;">  23:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum24" style="color: #606060;">  24:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">short</span>? ReorderLevel { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum25" style="color: #606060;">  25:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum26" style="color: #606060;">  26:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">bool</span> Discontinued { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum27" style="color: #606060;">  27:</span></pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: #f4f4f4; border-style: none; padding: 0px;"><span id="lnum28" style="color: #606060;">  28:</span>         <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">virtual</span> Categories Categories { get; set; }</pre>
    
    <p>
      <!--CRLF-->
    </p>
    
    <pre style="overflow: visible; font-size: 8pt; font-family: 'Courier New', courier, monospace; width: 100%; color: black; direction: ltr; text-align: left; margin: 0em; line-height: 12pt; background-color: white; border-style: none; padding: 0px;"><span id="lnum29" style="color: #606060;">  29:</span>     }</pre>
    
    <p>
      <!--CRLF-->
    </p>
  </div>
</div>

Veja que a classe foi gerada e o DataAnnotations foi criado.

Agora é só utilizar o EntityFramework CodeFirst!

Abraços e até a próxima,

Carlos dos Santos.
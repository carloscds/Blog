---
id: 5481
title: EntityFramework-Lendo seu banco de dados com o Visual Studio 2013 Update 2
date: 2014-07-02T09:02:31-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=5481
permalink: /2014/07/entityframework-lendo-seu-banco-de-dados-com-o-visual-studio-2013-update-2/
categories:
  - C Sharp
  - EntityFramework
---
Olá pessoal,

Há algum tempo atrás eu fiz um post falando sobre como [proveitar seu banco de dados existente com o EntityFramework PowerTools](http://carloscds.net/2014/04/entityframeworkapoveitando-seu-banco-de-dados-com-powertools), mas o modelo do PowerTools não permite escolher as tabelas ou views que você quer ler, e ás vezes isto é bem útil.

Com o lançamento do Update 2 do Visual Studio 2013 e também do EntityFramework 6.1, foi adicionada uma nova opção nas fontes de dados, que agora permite também fazer engenharia reversa com CodeFirst escolhendo quais tabelas e views serão lidas, a exemplo do que já era possível com o EntityFramework Designer.

Para demonstrar isto, vamos criar um novo projeto do tipo Console no Visual Studio 2013:

![]( wp-content/uploads/2014/07/SNAGHTMLa64a79f.png)

Agora vamos fazer a engenharia reversa, mas utilizando o novo recurso do Visual Studio 2013. Para isto, no seu projeto clique com o botão direito do mouse na solution e depois vá em Add/New Item:

![]( wp-content/uploads/2014/07/image1.png)

Agora vamos adicionar um ADO.NET Entity Data Mode:

![]( wp-content/uploads/2014/07/SNAGHTMLa676ebe.png)

E veja que agora existe uma nova opção chamada “Code First from database” e com ela iremos ler um banco de dados já existente e criar todo o código para o CodeFirst.

![]( wp-content/uploads/2014/07/SNAGHTMLa69ebd4.png)

Vamos então escolher esta opção e colocar a conexão para o nosso banco de dados existente: (no meu exemplo estou usando o banco da Microsoft chamado Northwind)

![]( wp-content/uploads/2014/07/SNAGHTMLa69538c.png)

Agora você pode escolher as tabelas e views que quiser para o seu projeto do CodeFirst:

![]( wp-content/uploads/2014/07/SNAGHTMLa6b3694.png)

Feito isto, todas as classe serão geradas no CodeFirst, mas com uma grande diferença em relação ao PowerTools: as informações de mapeamento são geradas como DataAnnotations ao invés de FluentApi. Veja o exemplo da classe Products:

```csharp
 public partial class Products
 {
  [Key]
  public int ProductID { get; set; }

  [Required]
  [StringLength(40)]
  public string ProductName { get; set; }

  public int? SupplierID { get; set; }

  public int? CategoryID { get; set; }
 }  
```

Veja que a classe foi gerada e o DataAnnotations foi criado.

Agora é só utilizar o EntityFramework CodeFirst!

Abraços e até a próxima,

Carlos dos Santos.
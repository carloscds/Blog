---
title: 'Gerar uma classe a partir de um Json no Visual Studio'
date: 2020-06-28
author: carloscds
layout: post
categories:
  - 'Visual Studio'
  - 'C#'
---
Fala pessoal,

Hoje é muito comum trabalharmos com APIs e sempre precisamos criar classes para receber os dados serializados. A dica então é bem simples!

O Visual Studio tem um recurso chamado "Paste JSON as Classes" que pega o conteúdo da area de transferência e cola como uma classe:

![](img/2020/06/past-json-01.png)

Agora vamos acessar uma API que retorna dados em Json, por exemplo esta API que retorna a previão do tempo: [http://worldtimeapi.org/api/timezone/America/Sao_Paulo](http://worldtimeapi.org/api/timezone/America/Sao_Paulo)

Vou usar o [Insomnia](https://insomnia.rest/download/) para visualizar os dados e copia:

![](img/2020/06/past-json-02.png)

Agora copiamos o conteúdo mostrado na tela e depois dentro do Visual Studio usamos o "Paste JSON as Classes"

Aqui temos a nossa classe:

```csharp
public class Rootobject
{
    public string abbreviation { get; set; }
    public string client_ip { get; set; }
    public DateTime datetime { get; set; }
    public int day_of_week { get; set; }
    public int day_of_year { get; set; }
    public bool dst { get; set; }
    public object dst_from { get; set; }
    public int dst_offset { get; set; }
    public object dst_until { get; set; }
    public int raw_offset { get; set; }
    public string timezone { get; set; }
    public int unixtime { get; set; }
    public DateTime utc_datetime { get; set; }
    public string utc_offset { get; set; }
    public int week_number { get; set; }
}
```
Agora é so usar a classe!

Abraços e até a próxima.  
Carlos dos Santos.
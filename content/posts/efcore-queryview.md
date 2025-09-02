---
title: 'EFCore.Visualizer - veja a sua query produzida pelo EF Core'
date: 2025-09-01
author: carloscds
layout: post
categories:
  - C Sharp
  - EntityFramework Core
  - EF Core
---
Você ja precisou ver como a consulta do EntityFramework Core é traduzida para o banco de dados ? Já teve aquela sensação de "será que a query ficou boa?"

Isto é um grande dilema para quem usa algum tipo de ORM, certo ? Você manipula classes e não tem muito controle sobre as queries que vão para o banco. 
Logicamente que você pode ativar algum tipo de LOG, mostrar na console, etc. Mas e debugando o código ? como fazer ?

## Melhorando a experiência durante o desenvolvimento

Usando um componentes simples e fácil de instalar, podemos ver as queries durante o debug no Visual Studio, e isto é bem interessante!

Você pode ter esta facilidade instalando o componente EFCore.Visualizer, que pode ser baixado do [Visual Studio MarketPlace.](https://marketplace.visualstudio.com/items?itemName=GiorgiDalakishvili.EFCoreVisualizer)

E o que ele faz ? Simples, enquanto você debuga uma query do EF, ele consegue mostrar o código SQL dela, veja:

![]( wp-content/uploads/2025/09/efcorevisualizer-option.png)

E clicando na opção "Query Plan Visualizer":
![]( wp-content/uploads/2025/09/efcorevisualizer-view.png)

Agora você pode analisar a query e dependendo do contexto do debug, ajustar e ver novamente!

### Considerações
Com certeza é um tipo de componente que todo desenvolvedor EF Core deveria ter instalado!

Aproveitando: O exemplo que estou usando é um MasterDetail em EF Core!

O código fonte do exemplo está no meu [GitHub](https://github.com/carloscds/CSharpSamples/tree/master/ASPNET-Worker/ExemploWorker).

Abraços e até a próxima!

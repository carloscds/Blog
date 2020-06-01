---
id: 22
title: 'Lendo uma Planilha do Excel com C#'
date: 2009-12-13T11:47:07-03:00
author: carloscds
layout: post
guid: /post/2009/12/13/Lendo-uma-Planilha-do-Excel-com-C.aspx
permalink: /2009/12/lendo-uma-planilha-do-excel-com-c/
categories:
  - CSharp
  - Visual Studio
tags:
  - csharp
  - excel
---
Hoje em dia é muito comum recebermos dados em planilhas do Excel e ter que importar ou analisar estes dados em nossas aplicações.

Com a ajuda do .Net Framework esta tarefa fica muito fácil e vou demonstrar como você pode abrir um arquivo do Excel e executar um comando Select em uma planilha simplesmente usando Ado.Net.

Para começar, vamos mostrar como está a nossa planilha no Excel e quais as informações importantes para o nosso programa em .Net.

Nossa planilha tem estes dados:

![]( wp-content/uploads/image_10.png)

Vejam que a planilha tem os títulos das colunas na primeira linha. Estes serão os nomes dos campos para o nosso comando Select, e também o nome da planilha, que é Sheet1, será o nome da nossa tabela.

Agora vamos criar um projeto do tipo Console no Visual Studio:

![]( wp-content/uploads/image_11.png)

Obs: no meu exemplo estou usando o Visual Studio 2010, mas vocês podem usar o Visual Studio 2008 com .Net Framework 2.0 sem problemas.

Criada nossa solução, vamos agora escrever o código. Para acessar os dados na planilha, vamos usar o Ado.Net e DataSet, para ser mais fácil de entender, e sendo assim precisamos incluir os namespaces apropriados:

```csharp
using System.Data;
using System.Data.OleDb
```

Após isto, precisamos criar a conexão com a planilha, usando OleDB:

```csharp
OleDbConnection conexao = new OleDbConnection(@”Provider=Microsoft.ACE.OLEDB.12.0;Data Source=c:tempplanilha.xlsx;Extended Properties=’Excel 12.0 Xml;HDR=YES’;”);
```

Nesta conexão, usamos o provider Microsoft.ACE.OLEDB e indicamos o noem da planilha, bem como a versão do Excel.

Criaremos agora um Adapter para executar o comando Select, e também um DataSet para armazenar os dados da consulta:

```csharp
OleDbDataAdapter adapter = new OleDbDataAdapter(“select * from [Sheet1$]”, conexao);
DataSet ds = new DataSet();
```

Observem que o nome da planilha tem um símbolo ‘$’ ao final e está entre colchetes ‘[]’.

Agora vamos abrir a conexão, preencher o DataSet e exibir os dados da planilha:

```csharp
try
{
   conexao.Open();

   adapter.Fill(ds);
   foreach (DataRow linha in ds.Tables[0].Rows)
   {
     Console.WriteLine(“Nome: {0} – Cargo: {1} – Salario: {2}”, linha[“nome”].ToString(),
                        linha[“cargo”].ToString(), linha[“salario”].ToString());
   }
}
catch (Exception ex)
{
   Console.WriteLine(“Erro ao acessar os dados: “ + ex.Message);
}
finally
{
   conexao.Close();

}
``` 

Entendendo o código, abrimos a conexão, preenchemos o DataSet com o método Fill() do Adapter e depois executamos um ForEach para exibir os dados. Fazemos também o tratamento de exceção caso ocorra algum erro.

Vocês devem ter percebido que é um código bastante simples, mas de grande ajuda.

[]s,

Carlos.
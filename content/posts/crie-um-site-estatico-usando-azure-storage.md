---
id: 10307
title: Crie um site estático usando Azure Storage
date: 2019-01-21T22:40:56-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10307
permalink: /2019/01/crie-um-site-estatico-usando-azure-storage/
image:  wp-content/uploads/2019/01/static-website-175x131.png
categories:
  - Azure
tags:
  - azure
  - storage
  - website
---
Olá, é isto mesmo que você leu! Agora é possível criar um site estático a partir de uma Storage no Azure.

Sem dúvida você já precisou colocar apenas arquivos HTML, Javacript, CSS e Imagens para subir um site, certo! Agora isto é possível com este novo recurso, ainda em Preview!

**Criando uma Storage:**

O primeiro passo é você criar uma Storage. Para isto vá até o portal do Azure em Create Resource (Criar Recurso). 

![]( wp-content/uploads/2019/01/image.png)

Preencha com os dados da sua Storage e confirme a criação!

**Configurando o Site Estático na Storage:**

Agora você só precisa habilitar o site estático e indicar o arquivo Index e de Erro, conforme a imagem acima! Depois clique em Save (Salvar).  

![]( wp-content/uploads/2019/01/2019-01-21_22-19-29.png)

Feito isto a mágica acontece, veja na imagem abaixo, que foi criado uma URL e também uma pasta chamada $web na sua storage, onde iremos copiar os arquivos: 

![]( wp-content/uploads/2019/01/2019-01-21_22-21-19.png) 

**Copiando os arquivos para o site:**

Clicando no link do $web temos a pasta da storage para nossos arquivos. Neste exemplo eu criei um arquivo HTML bem simples e vou colocar na pasta, usando o botão Upload: 

![]( wp-content/uploads/2019/01/2019-01-21_22-24-59-1024x399.png)

Agora podemos acessar a URL que foi criada e pronto! Temos nosso site:

![]( wp-content/uploads/2019/01/2019-01-21_22-26-03.png)

Você pode também utilizar o Editor para modificar seus arquivos diretamente no portal:

![]( wp-content/uploads/2019/01/2019-01-21_22-26-50-1024x403.png)

Sem dúvida um recurso muito útil e muito simples de usar!

E se você quiser usar algo do tipo: www.meuwebsite.com.br, é possível configurando o Custom Domain da Storage.

Se você quiser mais informações sobre o que dá para rodar com Static WebSites, acesse aqui: <https://azure.microsoft.com/pt-br/blog/azure-storage-static-web-hosting-public-preview/>

Abraços e até a próxima!  
Carlos dos Santos.
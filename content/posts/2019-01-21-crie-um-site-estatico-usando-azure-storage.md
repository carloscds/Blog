---
id: 10307
title: Crie um site estático usando Azure Storage
date: 2019-01-21T22:40:56-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10307
permalink: /2019/01/crie-um-site-estatico-usando-azure-storage/
image: /wp-content/uploads/2019/01/static-website-175x131.png
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

O primeiro passo é você criar uma Storage. Para isto vá até o portal do Azure em Create Resource (Criar Recurso).<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2019/01/image.png" alt="" class="wp-image-10309" srcset="http://carloscds.net/wp-content/uploads/2019/01/image.png 820w, http://carloscds.net/wp-content/uploads/2019/01/image-300x252.png 300w, http://carloscds.net/wp-content/uploads/2019/01/image-768x645.png 768w, http://carloscds.net/wp-content/uploads/2019/01/image-595x500.png 595w" sizes="(max-width: 820px) 100vw, 820px" /> </figure> 

Preencha com os dados da sua Storage e confirme a criação!

**Configurando o Site Estático na Storage:**

Agora você só precisa habilitar o site estático e indicar o arquivo Index e de Erro, conforme a imagem acima! Depois clique em Save (Salvar). <figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-19-29.png" alt="" class="wp-image-10311" srcset="http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-19-29.png 693w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-19-29-300x274.png 300w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-19-29-547x500.png 547w" sizes="(max-width: 693px) 100vw, 693px" /> </figure> 

Feito isto a mágica acontece, veja na imagem abaixo, que foi criado uma URL e também uma pasta chamada $web na sua storage, onde iremos copiar os arquivos:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-21-19.png" alt="" class="wp-image-10312" srcset="http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-21-19.png 686w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-21-19-300x175.png 300w" sizes="(max-width: 686px) 100vw, 686px" /> </figure> 

**Copiando os arquivos para o site:**

Clicando no link do $web temos a pasta da storage para nossos arquivos. Neste exemplo eu criei um arquivo HTML bem simples e vou colocar na pasta, usando o botão Upload:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-24-59-1024x399.png" alt="" class="wp-image-10313" srcset="http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-24-59-1024x399.png 1024w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-24-59-300x117.png 300w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-24-59-768x299.png 768w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-24-59-1025x399.png 1025w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-24-59.png 1034w" sizes="(max-width: 1024px) 100vw, 1024px" /> </figure> 

Agora podemos acessar a URL que foi criada e pronto! Temos nosso site:<figure class="wp-block-image is-resized">

<img src="http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-26-03.png" alt="" class="wp-image-10314" width="585" height="112" srcset="http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-26-03.png 771w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-26-03-300x58.png 300w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-26-03-768x147.png 768w" sizes="(max-width: 585px) 100vw, 585px" /> </figure> 

Você pode também utilizar o Editor para modificar seus arquivos diretamente no portal:<figure class="wp-block-image">

<img src="http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-26-50-1024x403.png" alt="" class="wp-image-10315" srcset="http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-26-50-1024x403.png 1024w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-26-50-300x118.png 300w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-26-50-768x302.png 768w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-26-50-1025x403.png 1025w, http://carloscds.net/wp-content/uploads/2019/01/2019-01-21_22-26-50.png 1063w" sizes="(max-width: 1024px) 100vw, 1024px" /> </figure> 

Sem dúvida um recurso muito útil e muito simples de usar!

E se você quiser usar algo do tipo: www.meuwebsite.com.br, é possível configurando o Custom Domain da Storage.

Se você quiser mais informações sobre o que dá para rodar com Static WebSites, acesse aqui: <https://azure.microsoft.com/pt-br/blog/azure-storage-static-web-hosting-public-preview/>

Abraços e até a próxima!  
Carlos dos Santos.
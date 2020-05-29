---
id: 10332
title: IT Pros, onde vocês guardam os seus scripts ?
date: 2019-04-29T23:01:15-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10332
permalink: /2019/04/it-pros-onde-voces-guardam-os-seus-scripts/
image: /wp-content/uploads/2019/04/image-10-175x131.png
categories:
  - DevOps
  - Git
---
Sempre que vou falar sobre versionamento de código em alguma empresa ou evento, eu pergunto para os "caras do TI" (IT Pros), como eles guardam os scripts para trabalhar em servidor, banco de dados, etc. A resposta é muito parecida e sempre curiosa: "Eu guardo lá em um HD no meu PC", ou seja, tá na minha máquina de trabalho, no máximo em um Drive de Nuvem.

Pergunto também se eles controlam as mudanças feitas nestes scripts e outro dia recebi uma resposta curiosa: "Eu controlo as mudanças em uma planilha!".

Ok, mas vamos pensar uma coisa. A equipe de desenvolvimento usa um versionador de código, certo? Então por quê o TI não pode também versionar seus scripts ?

Script é código fonte, assim como o código fonte de uma aplicação, certo! Então podemos guardar em um versionador de código, como Git, por exemplo. Mas vamos fazer melhor, vamos guardar no Azure DevOps, que é GRATUITO para até 5 usuários, e protegido com usuário/senha, e também pode se integrar com seu Active Directory da Nuvem (Azure). Se o seu time desenvolvimento já usa o Azure DevOps, melhor ainda!!!

Se você ainda não tem uma conta no Azure DevOps, é bem simples, acesse <http://dev.azure.com> e crie uma conta gratuita.

Depois de criada a conta, vamos criar um projeto, pois o DevOps é baseado em projetos, que são um conjuntos de funcionalidades: Dashboards, Código, Build, Indicadores e muito mais.

Clique no botão "Create Project" no canto superior direito da tela do Azure DevOps:<figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image.png" alt="" class="wp-image-10333" srcset="http://carloscds.net/wp-content/uploads/2019/04/image.png 636w, http://carloscds.net/wp-content/uploads/2019/04/image-206x300.png 206w, http://carloscds.net/wp-content/uploads/2019/04/image-343x500.png 343w" sizes="(max-width: 636px) 100vw, 636px" /> <figcaption>  
</figcaption></figure> 

Depois clique em Create e aguarde a criação do pojeto.

Projeto criado, esta é a estrutura:<figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image-1.png" alt="" class="wp-image-10334" srcset="http://carloscds.net/wp-content/uploads/2019/04/image-1.png 869w, http://carloscds.net/wp-content/uploads/2019/04/image-1-300x210.png 300w, http://carloscds.net/wp-content/uploads/2019/04/image-1-768x537.png 768w, http://carloscds.net/wp-content/uploads/2019/04/image-1-715x500.png 715w" sizes="(max-width: 869px) 100vw, 869px" /> <figcaption>  
</figcaption></figure> 

Vamos focar em guardar os scripts, então clique em "Repos":<figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image-3.png" alt="" class="wp-image-10336" srcset="http://carloscds.net/wp-content/uploads/2019/04/image-3.png 987w, http://carloscds.net/wp-content/uploads/2019/04/image-3-300x214.png 300w, http://carloscds.net/wp-content/uploads/2019/04/image-3-768x547.png 768w, http://carloscds.net/wp-content/uploads/2019/04/image-3-702x500.png 702w" sizes="(max-width: 987px) 100vw, 987px" /> </figure> 

Vamos clicar no botão "Initialize" para ele adicionar o README e começarmos! 

O Azure DevOps, por padrão cria o repositório de códigos com o formato Git. (Aqui vale a pena você estudar um pouco sobre uso do Git). Mas eu vou mostrar como usar direto no browser e também localmente.

**Vou trabalhar direto no browser:**

Neste caso é muito simples, dentro do item Repos do DevOps, você pode criar um arquivo novo "New", fazer um "Upload" e também um Download", muito simples! <figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image-4-1024x225.png" alt="" class="wp-image-10337" srcset="http://carloscds.net/wp-content/uploads/2019/04/image-4-1024x225.png 1024w, http://carloscds.net/wp-content/uploads/2019/04/image-4-300x66.png 300w, http://carloscds.net/wp-content/uploads/2019/04/image-4-768x169.png 768w, http://carloscds.net/wp-content/uploads/2019/04/image-4-1025x225.png 1025w, http://carloscds.net/wp-content/uploads/2019/04/image-4.png 1193w" sizes="(max-width: 1024px) 100vw, 1024px" /> </figure> 

Vou criar um arquivo chamado "lista.cmd", clicando em New, depois File e colocando o nome. Depois digitando conteúdo. Terminado, clique em Commit para salvar:<figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image-5.png" alt="" class="wp-image-10338" srcset="http://carloscds.net/wp-content/uploads/2019/04/image-5.png 883w, http://carloscds.net/wp-content/uploads/2019/04/image-5-300x121.png 300w, http://carloscds.net/wp-content/uploads/2019/04/image-5-768x309.png 768w" sizes="(max-width: 883px) 100vw, 883px" /> <figcaption>  
O comando "commit" sempre pede um comentário, utilize isto para documentar suas atualizações e assim, controlar as mudanças no seu Script!</figcaption></figure> 

Se você precisar do arquivo, basta acessar e pronto!

**Vou trabalhar no computador, com uma cópia do repositório:**

Neste caso, você trabalha "desconectado" do servidor, e precisa copiar o repositório para o seu computador. Chamamos isto de "clonar". Uma vez clonado, podemos fazer as mudanças: alterar, criar, deletar. E depois enviamos de volta para o servidor.

Para isto precisaremos instalar o client do Git, que roda em Windows, Linux e Mac: <https://git-scm.com/downloads> 

Agora que você instalou o Git, vamos clonar o repositório. Para isto clique no botão "Clone", no canto superior direito e copie a URL:<figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image-6.png" alt="" class="wp-image-10339" srcset="http://carloscds.net/wp-content/uploads/2019/04/image-6.png 659w, http://carloscds.net/wp-content/uploads/2019/04/image-6-300x215.png 300w" sizes="(max-width: 659px) 100vw, 659px" /> </figure> 

Agora, no seu computador, crie uma pasta, por exemplo C:\Scripts e digite o seguinte:

git clone <url copiada><figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image-7-1024x101.png" alt="" class="wp-image-10340" srcset="http://carloscds.net/wp-content/uploads/2019/04/image-7-1024x101.png 1024w, http://carloscds.net/wp-content/uploads/2019/04/image-7-300x30.png 300w, http://carloscds.net/wp-content/uploads/2019/04/image-7-768x76.png 768w, http://carloscds.net/wp-content/uploads/2019/04/image-7-1025x101.png 1025w, http://carloscds.net/wp-content/uploads/2019/04/image-7.png 1108w" sizes="(max-width: 1024px) 100vw, 1024px" /> </figure> 

Coloque seu login/senha, caso seja necessário!

O git clone sempre cria uma pasta com o nome do Projeto, então o resultado final será C:\Scripts\Scripts, mas você pode mudar conforme sua preferência:<figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image-8.png" alt="" class="wp-image-10341" srcset="http://carloscds.net/wp-content/uploads/2019/04/image-8.png 649w, http://carloscds.net/wp-content/uploads/2019/04/image-8-300x184.png 300w" sizes="(max-width: 649px) 100vw, 649px" /> <figcaption>Projeto Clonado</figcaption></figure> 

Agora temos todo o conteúdo do projeto no computador local, vamos então adicionar um novo arquivo em PowerShell chamado "diretorioatual.ps1"<figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image-9.png" alt="" class="wp-image-10342" srcset="http://carloscds.net/wp-content/uploads/2019/04/image-9.png 674w, http://carloscds.net/wp-content/uploads/2019/04/image-9-300x83.png 300w" sizes="(max-width: 674px) 100vw, 674px" /> </figure> 

Este arquivo só existe localmente, então agora vamos enviá-lo para o servidor na nuvem. Para isto vamos usar os comandos:

git add .  
git commit -m "Arquivo para lista o diretorio atual"  
git push

Você verá algo assim:<figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image-10.png" alt="" class="wp-image-10343" srcset="http://carloscds.net/wp-content/uploads/2019/04/image-10.png 988w, http://carloscds.net/wp-content/uploads/2019/04/image-10-300x165.png 300w, http://carloscds.net/wp-content/uploads/2019/04/image-10-768x422.png 768w, http://carloscds.net/wp-content/uploads/2019/04/image-10-910x500.png 910w" sizes="(max-width: 988px) 100vw, 988px" /> </figure> 

Explicando os comandos:

**git add .** // adiciona todos os novos arquivos para o commit  
**git commit -m "Arquivo para lista o diretorio atual"** // grava commit com a mensagem  
**git push** // envia para o servidor na nuvem

Um outro comando muito útil é o "git pull" que traz as atualizações do repositório da nuvem para o computador local. Então se você fez algo na nuvem, ou em outro computador, lembre-se de executar o pull:<figure class="wp-block-image">

![](/wp-content/uploads/2019/04/image-11.png" alt="" class="wp-image-10344" srcset="http://carloscds.net/wp-content/uploads/2019/04/image-11.png 436w, http://carloscds.net/wp-content/uploads/2019/04/image-11-300x114.png 300w" sizes="(max-width: 436px) 100vw, 436px" /> <figcaption>Neste caso não havia nada para atualizar!</figcaption></figure> 

Lembrando que não estou ensinando a usar o Git completamente, isto é apenas um básico! Para aprender mais sobre o Git e versionamento de código, veja a documentação em <https://git-scm.com/docs/gittutorial> 

Pronto! Seus scripts estão salvos e versionados! 

**Resumindo&#8230;**

Como um IT Pro, sim, você pode também usar um controle de versão e guardar seus scripts na nuvem! Então use!!!

Mantenha seus scripts "guardados" e seguros, com controle de versão, e acessíveis de qualquer lugar!

Espero que eu tenha te motivado a começar com o versionamento dos seus scripts! Me diga como foi a experiência!!!

Abraços e até a próxima!  
Carlos dos Santos
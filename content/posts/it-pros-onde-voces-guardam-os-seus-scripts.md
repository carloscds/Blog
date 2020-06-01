---
id: 10332
title: IT Pros, onde vocês guardam os seus scripts ?
date: 2019-04-29T23:01:15-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=10332
permalink: /2019/04/it-pros-onde-voces-guardam-os-seus-scripts/
image:  wp-content/uploads/2019/04/image-10-175x131.png
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

Clique no botão "Create Project" no canto superior direito da tela do Azure DevOps:

![]( wp-content/uploads/2019/04/image.png)

Depois clique em Create e aguarde a criação do pojeto.

Projeto criado, esta é a estrutura:

![]( wp-content/uploads/2019/04/image-1.png) 

Vamos focar em guardar os scripts, então clique em "Repos":
 
![]( wp-content/uploads/2019/04/image-3.png) 

Vamos clicar no botão "Initialize" para ele adicionar o README e começarmos! 

O Azure DevOps, por padrão cria o repositório de códigos com o formato Git. (Aqui vale a pena você estudar um pouco sobre uso do Git). Mas eu vou mostrar como usar direto no browser e também localmente.

**Vou trabalhar direto no browser:**

Neste caso é muito simples, dentro do item Repos do DevOps, você pode criar um arquivo novo "New", fazer um "Upload" e também um Download", muito simples! 

![]( wp-content/uploads/2019/04/image-4-1024x225.png)

Vou criar um arquivo chamado "lista.cmd", clicando em New, depois File e colocando o nome. Depois digitando conteúdo. Terminado, clique em Commit para salvar:

![]( wp-content/uploads/2019/04/image-5.png)

O comando "commit" sempre pede um comentário, utilize isto para documentar suas atualizações e assim, controlar as mudanças no seu Script!

Se você precisar do arquivo, basta acessar e pronto!

**Vou trabalhar no computador, com uma cópia do repositório:**

Neste caso, você trabalha "desconectado" do servidor, e precisa copiar o repositório para o seu computador. Chamamos isto de "clonar". Uma vez clonado, podemos fazer as mudanças: alterar, criar, deletar. E depois enviamos de volta para o servidor.

Para isto precisaremos instalar o client do Git, que roda em Windows, Linux e Mac: <https://git-scm.com/downloads> 

Agora que você instalou o Git, vamos clonar o repositório. Para isto clique no botão "Clone", no canto superior direito e copie a URL:

![]( wp-content/uploads/2019/04/image-6.png) 

Agora, no seu computador, crie uma pasta, por exemplo C:\Scripts e digite o seguinte:

**git clone <url copiada>**

![]( wp-content/uploads/2019/04/image-7-1024x101.png)

Coloque seu login/senha, caso seja necessário!

O git clone sempre cria uma pasta com o nome do Projeto, então o resultado final será C:\Scripts\Scripts, mas você pode mudar conforme sua preferência:

![]( wp-content/uploads/2019/04/image-8.png)

Agora temos todo o conteúdo do projeto no computador local, vamos então adicionar um novo arquivo em PowerShell chamado "diretorioatual.ps1"

![]( wp-content/uploads/2019/04/image-9.png)

Este arquivo só existe localmente, então agora vamos enviá-lo para o servidor na nuvem. Para isto vamos usar os comandos:

**git add .** 

**git commit -m "Arquivo para lista o diretorio atual"** 

**git push** 

Você verá algo assim:

![]( wp-content/uploads/2019/04/image-10.png)

Explicando os comandos:

**git add .** // adiciona todos os novos arquivos para o commit  
**git commit -m "Arquivo para lista o diretorio atual"** // grava commit com a mensagem  
**git push** // envia para o servidor na nuvem

Um outro comando muito útil é o "git pull" que traz as atualizações do repositório da nuvem para o computador local. Então se você fez algo na nuvem, ou em outro computador, lembre-se de executar o pull:

![]( wp-content/uploads/2019/04/image-11.png)

Lembrando que não estou ensinando a usar o Git completamente, isto é apenas um básico! Para aprender mais sobre o Git e versionamento de código, veja a documentação em <https://git-scm.com/docs/gittutorial> 

Pronto! Seus scripts estão salvos e versionados! 

**Resumindo**

Como um IT Pro, sim, você pode também usar um controle de versão e guardar seus scripts na nuvem! Então use!!!

Mantenha seus scripts "guardados" e seguros, com controle de versão, e acessíveis de qualquer lugar!

Espero que eu tenha te motivado a começar com o versionamento dos seus scripts! Me diga como foi a experiência!!!

Abraços e até a próxima!  
Carlos dos Santos
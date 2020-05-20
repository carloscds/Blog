---
id: 7991
title: Tem um Linux no meu Windows 10!
date: 2016-08-07T21:38:20-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=7991
permalink: /2016/08/tem-um-linux-no-meu-windows-10/
categories:
  - Linux
  - Open Source
  - Windows 10
---
Fala pessoal,

É isto mesmo que você leu, tem um Linux dentro do Window 10, e não é uma máquina virtual, como muitos estão pensando, é um sub-sistema baseado no Ubuntu.

Se alguém falasse isto há alguns anos atrás, eu provevalmente diria que é loucura, mas o mundo mudou e a Microsoft também. Nós últimos anos a Microsoft vem trabalhando mais fortemente com comunidades open source, e o Linux é uma delas.

Em um mundo voltado para nuvem, não faz mais sentido a Microsoft focar somente no Windows e prova disto é que o Linux é muito utilizado nas máquinas virtuais do Azure, isto mesmo, na nuvem Microsoft, existe Linux.

Noticias como a “Microsoft Ama o Linux”:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/08/image_thumb.png" width="348" height="99" />](http://carloscds.net/wp-content/uploads/2016/08/image.png)

E o “SQL Server Ama o Linux”:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/08/image_thumb-1.png" width="353" height="84" />](http://carloscds.net/wp-content/uploads/2016/08/image-1.png)

Talvez soem um tanto estranho para quem utiliza somente o Windows no dia a dia, mas como eu disse antes, o mundo está mudando e principalmente, está se tornando multi plataforma&#160; “de verdade”. De verdade, quero dizer que você consegue construir um software realmente multiplataforma, onde o mesmo código roda, por exemplo, no Windows, Linux e Mac. Isto pode ser feito com o .Net Core/Asp.Net Core e Xamarin, só para citar alguns exemplos.

Mas voltando ao título do artigo, como assim tem um Linux dentro do meu Windows ? Simples, meu caro leitor, a Microsoft colocou um sistema Linux junto com o seu Windows 10, não uma máquina virtual, mas um sistema nativo Linux, baseado no Ubuntu.

O que vamos mostrar agora vale para quem já instalou a versão de aniversário do Windows 10 ou está no Programa Insiders.

Então vamos lá:&#160; para instalar o Linux no seu Windows, abra o “Painel de Controle” e vá em Programas, e depois em “Ativar ou Desativar Rescursos do Windows”:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/08/image_thumb-2.png" width="487" height="119" />](http://carloscds.net/wp-content/uploads/2016/08/image-2.png)

Agora selecione a opção “Windows Subsystem for Linux”:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/08/image_thumb-3.png" width="438" height="131" />](http://carloscds.net/wp-content/uploads/2016/08/image-3.png)

Clique em OK para instalar! Provavelmente você terá que reiniciar a máquina!

Depois de instalado, você abre o Prompt de Comandos e digita “bash”: 

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/08/image_thumb-4.png" width="444" height="132" />](http://carloscds.net/wp-content/uploads/2016/08/image-4.png)

Agora a mágica acontece, você está de fato em um Linux, mas compartilhando os seus discos e pastas, veja por exemplo o comando ls:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/08/image_thumb-5.png" width="730" height="210" />](http://carloscds.net/wp-content/uploads/2016/08/image-5.png)

Vamos ver a versão do Linux, usando o comando “lsb_release –a”:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/08/image_thumb-6.png" width="535" height="179" />](http://carloscds.net/wp-content/uploads/2016/08/image-6.png)

Vamos por exemplo instalar o editor de textos nano. Assim como no Ubuntu Linux, vamos usar o comando apt-get:

apt-get update  
apt-get install nano

Mas antes de criar um arquivo e mostar no windows, vou mudar de diretório no Linux. Veja que estamos em /mnt/c e agora vou para o meu Temp:

cd /mnt/c/Temp

nano teste.txt

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/08/image_thumb-7.png" width="628" height="287" />](http://carloscds.net/wp-content/uploads/2016/08/image-7.png)

Agora vamos salvar o arquivo e verificar no Windows:

[<img title="image" style="border-top: 0px; border-right: 0px; background-image: none; border-bottom: 0px; padding-top: 0px; padding-left: 0px; border-left: 0px; display: inline; padding-right: 0px" border="0" alt="image" src="http://carloscds.net/wp-content/uploads/2016/08/image_thumb-8.png" width="463" height="188" />](http://carloscds.net/wp-content/uploads/2016/08/image-8.png)

O sub-sistema ainda está em beta, mas muitos programas linux funcionam e muitos mais irão funcionar em novas versões, isto é só o começo de uma grande resolução e eu espero que você fique antenado nas mudanças!

Abraços e até a próxima,  
Carlos dos Santos.
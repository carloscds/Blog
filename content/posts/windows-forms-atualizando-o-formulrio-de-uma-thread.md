---
id: 205
title: Windows Forms – atualizando o formulário de dentro de uma Thread
date: 2010-08-02T21:44:53-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2010/08/windows-forms-atualizando-o-formulrio-de-uma-thread/
permalink: /2010/08/windows-forms-atualizando-o-formulrio-de-uma-thread/
categories:
  - 'C#'
  - Visual Studio
tags:
  - 'c#; msdn'
---
É relativamente comum termos uma aplicação que precise usar uma ou mais threads para realizar algum processo demorado onde o usuário não precise ficar esperando, mas às vezes é necessário também que esta thread faça algum tipo de interação com a tela, talvez atualizando alguma informação, barra de progresso, enfim, mostrar ao usuário que algo está acontecendo.

Uma tarefa relativamente simples, mas que pode causar um certo transtorno justamente por ser uma thread. Veja a aplicação abaixo em Windows Forms:

![](/wp-content/uploads/2010/08/image.png)

É uma tela bem simples, com um botão e uma barra de progresso. Agora vamos imaginar que este form tenha o código abaixo, que cria uma thread que atualiza a progressBar1:

```csharp
public partial class Form1 : Form
{
    private bool threadAtiva = false;

    public Form1()
    {
        InitializeComponent();
    }

    private void btnIniciar_Click(object sender, EventArgs e)
    {
        
        Thread processo = new Thread(new ThreadStart(ExecutaThread));
        processo.Start();

        progressBar1.Maximum = 100;
        progressBar1.Value = 0;

        threadAtiva = true;
    }

    void ExecutaThread()
    {
        while (threadAtiva)
        {
              if (progressBar1.Value > 99)
              {
                  threadAtiva = false;
                  return;
              }
              progressBar1.Value++;
              progressBar1.Refresh();
          }
      }
  }
}
```
O código acima está correto, mas ao executar e clicar no botão iniciar, aparece o seguinte erro:

![](/wp-content/uploads/2010/08/image_thumb1.png)

O erro acontece porquê a janela da aplicacação (UI) está executando em uma thread e agora nós temos outra thread executando o nosso processo e tentando atualizar a tela. Então como resolver isto ?

Simplesmente usando um Invoker:

```csharp
void ExecutaThread()
{
    while (threadAtiva)
    {
        if (progressBar1.Value > 99)
        {
            threadAtiva = false;
            return;
        }
        this.Invoke(new MethodInvoker(delegate()
        {
            progressBar1.Value++;
            progressBar1.Refresh();
        }));
    }
}
```

Agora estamos atualizando a tela ou seja, o progressBar1 usando um Invoker que está sendo executando sob a thread principal, ou seja, o formulário. Neste exemplo eu usei o MethodInvoker() com um método anônimo, mas você poderia ter criado um método e chamado sem problemas e com isto você pode ter várias thread rodando e atualizando a interface do usuário.

É isto aí pessoal, espero que dica seja útil para vocês.

Um abraço e até a próxima.

---
id: 240
title: Passando parâmetros para uma aplicação .Net
date: 2010-09-12T21:17:01-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2010/09/passando-parmetros-para-uma-aplicao-net/
permalink: /2010/09/passando-parmetros-para-uma-aplicao-net/
aktt_notify_twitter:
  - 'no'
categories:
  - 'C#'
  - Visual Studio
tags:
  - 'c#; msdn'
---
Pessoal, seguindo com os posts sobre C# básico, vou mostrar como passar parâmetros para uma aplicação em .Net usando C# em um Windows Forms. 

Primeiramente crie uma aplicação Windows Forms:

![]( wp-content/uploads/2010/09/image2.png)

Eu estou usando o Visual Studio 2010 e o Framework 4, mas você pode usar qualquer versão do Visual Studio para executar este exemplo.

Após criar a aplicação vamos ao arquivo Program.cs, onde vamos colocar a variável que irá receber os parâmetros:
```csharp
[STAThread]
static void Main(string[] parametros)
{
    Application.EnableVisualStyles();
    Application.SetCompatibleTextRenderingDefault(false);
    Application.Run(new frmPrincipal());
}
```   

Neste exemplo eu criei uma variável chamada parametros que irá receber os argumentos da linha de comando. Se você precisa usar o parâmetro somente para acionar alguma parte do seu programa, pode fazer assim:

```csharp
 static void Main(string[] parametros)
 {
    if(parametros.Length > 0)
    {
        if(parametros[0].ToUpper() == "/CONFIG")
        {
            frmConfig config = new frmConfig();
            config.ShowDialog();
            Application.Exit();
            return;
        }
    }
 }
 ```

Primeiro você testa se recebeu algum parâmetro e depois faz a verificação. Eu fiz a conversão para Upper() fica mais simples a verificação. Agora você pode estar se perguntando, como vou fazer debug da aplicação e passar o parâmetro ? Isto você pode configurar na janela de propriedades do projeto em Project/Properties/Debug:

![]( wp-content/uploads/2010/09/image_thumb3.png)

Se você precisar testar mais de um parâmetro ao mesmo tempo, basta colocá-los separados por espaços, do mesmo modo que faria no prompt de comandos. Agora para finalizar, vou mostrar como passar o parâmetro para o form principal da aplicação. Para isto teremos que modificar o construtor do form, veja:

```csharp
public partial class frmPrincipal : Form
{
    public frmPrincipal(string[] parametros)
    {
        InitializeComponent();
    }
}
```

Na verdade acrescentamos o parâmetro no construtor do form, mas se você precisar passar qualquer outra informação, basta modificar o construtor. Agora vamos voltar no program.cs e passar o parâmetro:

```csharp
Application.Run(new frmPrincipal(parametros));
```


É isto aí pessoal, um abraço e até a próxima.
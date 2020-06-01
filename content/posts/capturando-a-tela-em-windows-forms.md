---
id: 4441
title: Capturando a tela em Windows Forms
date: 2014-01-08T21:55:40-03:00
author: carloscds
layout: post
guid: http://carloscds.net/?p=4441
permalink: /2014/01/capturando-a-tela-em-windows-forms/
categories:
  - 'C#'
tags:
  - 'c#; msdn'
---
Olá pessoal,

Hoje vou demonstrar como é possível capturar a tela ou até mesmo o conteúdo de um controle e salvá-lo como um Bitmap. Imagine que você tem uma solução de atendimento ao cliente e em algum momento precise capturar a tela do seu usuário e depois anexá-la a algum requisito do software ou tratamento de um bug.

Claro que existem várias ferramentas prontas para captura de tela, mas vamos ver como é possível, através de um código em C# usando o recurso de Interop e acessando a API do Windows, criar um método reusável que pode ser utilizado para capturar vários tipos de tela no Windows.

**<span style="text-decoration: underline;">Criando o projeto</span>**

Vamos criar um projeto no Visual Studio 2013 do tipo Windows Forms (você pode utilizar qualquer outra versão do Visual Studio):

![]( wp-content/uploads/2014/01/SNAGHTML29cbc21f.png)

Para deixar o nosso código de captura reutilizável, vamos criar uma nova classe chamada Tela.cs. Nesta classe iremos criar todo o código de captura, iniciando pelas referências a API do Windows. Esta API é muito rica e possui centenas de métodos muito interessantes, mas vamos nos concentrar basicamente nas rotinas de captura de tela.

Só para conhecimento, todos os controle do Windows são tratados como uma janela e como tal, possuem um identificador único de janela, ou um WindowsHandle. Para acessarmos qualquer informação de uma janela ou controle usando a API do Windows, precisamos deste identificador.

**<span style="text-decoration: underline;">Trabalhando com Interop</span>**

Para começar a nossa classe, vamos colocar todo o código de Interop com a API do Windows. Eu não vou explicar em detalhes o que cada método faz, mas você pode acessar um site muito bom chamado [PInvoke.net](http://www.pinvoke.net/) que contém referências, explicações e exemplos para a API do Windows.

O código abaixo faz uma referência para um método da API do Windows e o deixa acessível para nós no C#:

```csharp
public class Tela
{
  [DllImport("user32.dll", EntryPoint = "GetDC")]
  static extern IntPtr GetDC(IntPtr ptr);
  [DllImport("user32.dll", EntryPoint = "ReleaseDC")]
  static extern IntPtr ReleaseDC(IntPtr hWnd, IntPtr hDc);
  [DllImport("gdi32.dll", EntryPoint = "DeleteDC")]
  static extern IntPtr DeleteDC(IntPtr hDc);
  [DllImport("gdi32.dll", EntryPoint = "CreateCompatibleDC")]
  static extern IntPtr CreateCompatibleDC(IntPtr hdc);
  [DllImport("gdi32.dll", EntryPoint = "CreateCompatibleBitmap")]
  static extern IntPtr CreateCompatibleBitmap(IntPtr hdc, int nWidth, int nHeight);
  [DllImport("gdi32.dll", EntryPoint = "SelectObject")]
  static extern IntPtr SelectObject(IntPtr hdc, IntPtr bmp);
  [DllImport("gdi32.dll", EntryPoint = "BitBlt")]
  static extern bool BitBlt(IntPtr hdcDest, int xDest, int yDest, int wDest, int hDest, IntPtr hdcSource, int xSrc, int ySrc, int RasterOp);
  [DllImport("user32.dll", EntryPoint = "GetDesktopWindow")]
  static extern IntPtr GetDesktopWindow();
  [DllImport("gdi32.dll", EntryPoint = "DeleteObject")]
  static extern IntPtr DeleteObject(IntPtr hDc);

  const int SRCCOPY = 13369376;
  public struct SIZE
  {
      public int cx;
      public int cy;
  }
}
```

**<span style="text-decoration: underline;">Entendo um pouco a API do Windows</span>**

DC – Device Context, ou Dispositovo de Contexto, é um identificador para um objeto no Windows, por exemplo uma janela ou controle.

GetDC() – devolve o identificador para uma janela.

ReleaseDC() – restaura o identificador para o Windows. Isto é muito importante, todo identificador que for utilizado, deve ser devolvido.

DeleteDC() – quando nós criamos o DC, ao invés de pegá-lo do Windows, precisamos deletá-lo para liberar o recurso.

CreateCompatibleDC() – cria um DC, no nosso caso iremos criar para manipular o Bitmap.

CreateCompatibleBitmap() – cria um Bitmap compatível com um DC.

SelectObjec() – seleciona um objeto, no nosso caso vincula o DC ao Bitmap.

BitBlt() – faz a cópia do conteúdo de um identificador para outro, e no nosso caso, o identificador de destino será um Bitmap.

GetDesktopWindow() – retorna um identificador para a janela principal do Windows (Desktop).

DeleteObject() – deleta um objeto, liberando o recurso alocado.

**<span style="text-decoration: underline;">Criando a rotina que captura a tela</span>**

Agora que já entendemos um pouco da API do Window, vamos criar o método da nossa classe que irá fazer as capturas de tela. Para isto vamos adicionar o código abaixo a nossa classe Tela.cs:

```csharp
public static Bitmap RetornaImagemControle(IntPtr controle, Rectangle area)
{
    SIZE size;
    IntPtr hBitmap;

    IntPtr hDC = GetDC(controle);
    IntPtr hMemDC = CreateCompatibleDC(hDC);

    size.cx = area.Width - area.Left;
    size.cy = area.Bottom - area.Top;

    hBitmap = CreateCompatibleBitmap(hDC, size.cx, size.cy);

    if (hBitmap != IntPtr.Zero)
    {
        IntPtr hOld = (IntPtr)SelectObject(hMemDC, hBitmap);
        BitBlt(hMemDC, 0, 0, size.cx, size.cy, hDC, 0, 0, SRCCOPY);
        SelectObject(hMemDC, hOld);
        DeleteDC(hMemDC);
        ReleaseDC(GetDesktopWindow(), hDC);
        Bitmap bmp = System.Drawing.Image.FromHbitmap(hBitmap);
        DeleteObject(hBitmap);
        return bmp;
    }
    else
    {
        return null;
    }
}
```

O nosso método recebe como parâmetro um IntPtr, que pode representar qualquer controle ou janela do Windows, e recebe também uma estrutura que representa a área que iremos capturar, pois poderemos querer apenas uma parte do nosso controle transformado em uma imagem.

Iniciamos pegando os identificadores necessários (linhas 6 e 7) e em seguida calculamos o tamanho do nosso Bitmap de captura (linhas 9 e 10), para depois já criarmos este Bitmap (linha 12). Caso consigamos criar o Bitmap, então vamos fazer o vínculo do Bitmap (linha 16), e finalmente iremos executar o método que faz toda a mágica, ou seja, que copia o conteúdo do controle para o nosso Bitmap (linha 17).

Após isto iremos liberar os recursos utilizados (linhas 19 e 20), criamos finalmente o nosso Bitmap (linha 21) e liberamos o último recurso alocado. Ufa! Agora é só retornar o Bitmap com o resultado.

**<span style="text-decoration: underline;">Utilizando a classe para capturar uma informação:</span>**

Agora que já temos a classe, vamos voltar para o nosso Windows Forms e mostrar como ele irá funcionar. Para isto adicione um controle Button e também um PictureBox, de maneira que a tela fique parecida com a seguinte:

![]( wp-content/uploads/2014/01/image.png)

Vamos adicionar o código para o botão “Capturar Desktop”:

```csharp
private void btnCapturaDesktop_Click(object sender, EventArgs e)
{
    imagemCapurada.Image = Tela.RetornaImagemControle(IntPtr.Zero, Screen.PrimaryScreen.WorkingArea);
}
```

Este código tem um truque bem interessante. Como eu falei no início deste post, iríamos capturar uma tela e toda tela no Windows possui um identificador, sendo assim, o nosso Desktop tem a identificação ZERO, ou seja, informando IntPtr.Zero como o nosso controle a ser capturado, iremos capturar o Desktop do Windows, e para conseguirmos capturar toda a tela, eu utilizei a propriedade PrimaryScreen.WorkingArea, que retorna o tamanho do nosso Desktop.

Para finalizar, iremos implementar um outro botão que irá capturar a nossa própria tela, para isto adicione um novo botão ao formulário e acrescente o código a seguir:

```csharp
private void btnCapturaTela_Click(object sender, EventArgs e)
{
    imagemCapurada.Image = Tela.RetornaImagemControle(this.Handle, new Rectangle(0,0,this.Width,this.Height));
}
```

Veja que agora estamos informando o identificador do nosso form e também o seu tamanho, mas você pode informar o identificador de qualquer controle e qualquer tamanho, e talvez capturar uma parte do controle original.

**<span style="text-decoration: underline;">Veja como fica a tela capturada:</span>**

![]( wp-content/uploads/2014/01/image1.png)

**<span style="text-decoration: underline;">Conclusão:</span>**

Este post mostra duas coisas bem interessantes: como interoperar com a API do Windows e como capturar o conteúdo de uma janela do Windows.

Espero que tenham gostado e que principalmente seja útil no seu dia a dia.

Um grande abraço e até a próxima.

Carlos dos Santos.

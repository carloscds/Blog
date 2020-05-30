---
id: 710
title: Validando Dados com EntityFramework e WindowsForms
date: 2012-01-31T00:20:00-03:00
author: carloscds
layout: post
guid: http://carloscds.net/2012/01/validando-dados-com-entityframework-e-windowsforms/
permalink: /2012/01/validando-dados-com-entityframework-e-windowsforms/
categories:
  - entity-framework
---
Pessoal,

Hoje vou mostrar uma maneira bem simples e interessante de fazer validação de dados com EntityFramework, classes POCO e uma aplicação Windows Forms.

Como eu já comentei em outros posts, quando você utiliza DataAnnotations em classes POCO na sua camada de dados e faz a camada de apresentação com WPF/Silverlight ou MVC, o tratamento dos campos é feito automaticamente, praticamente sem nenhum tipo de código. Mas e se você ainda programa para WindowsForms ou precisa validar os dados da classe em uma camada e retornar o erro para outra camada, como fazer ? Isto é o que veremos a seguir.

Primeiro vamos criar um projeto Windows Forms no Visual Studio 2010:  
![](http://carloscds.net/wp-content/uploads/2012/01/image14.png)

Agora vamos adicionoar o EntityFramework CodeFirst usando o NuGet, como eu expliquei [neste post](http://carloscds.net/2012/01/entityframework-codefirst). E logo após vamos criar uma classes chamada Produto e vamos adicionar os [annotations](http://msdn.microsoft.com/en-us/data/gg193958) nela. Annotations são marcações acima dos campos que definem várias informações ao engine do Entitu Framework, como por exemplo, os valores permitidos no campo.

Nossa classe produto ficará da seguinte maneira: 

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace WindowsFormsValidacao
{
    [Table("Produto")]
    public class Produto : ValidacaoEntidade 
    {
        public int ID { get; set; }
        [Required(ErrorMessage="Descrição em branco"])
        public string Descricao { get; set; }
        [Range(1,10000,ErrorMessage="Valor deve estar entre 1 e 10000")]
        public double SaldoMinimo { get; set; }
        [Required(ErrorMessage="Custo em branco")]
        public decimal Custo { get; set; }
        public decimal Venda { get; set; }
        [MaxLength(20,ErrorMessage="Tamanho máximo = 20")]
        public string Localizacao { get; set; }
    }
}
```

Veja que a nossa classe está herdando de ValidacaoEntidade, que é onde iremos fazer o método de validaçao dos campos, veja abaixo:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Xml.Serialization;

namespace WindowsFormsValidacao
{
    public class ValidacaoEntidade : IDataErrorInfo
    {
        [NotMapped]
        public string Error
        {
            get { return ""; }
        }

        [NotMapped]
        public string this[string columnName]
        {
            get
            {
                return ValidateProperty(columnName);
            }
        }

        protected string ValidateProperty(string propertyName)
        {
            var info = this.GetType().GetProperty(propertyName);

            if (!info.CanWrite)
            {
                return null;
            }

            var value = info.GetValue(this, null);
            IEnumerable<string> errorInfos =
                  (from va in info.GetCustomAttributes(true).OfType<ValidationAttribute>()
                  where !va.IsValid(value)
                  select va.FormatErrorMessage(string.Empty)).ToList();

            if (errorInfos.Count() > 0)
            {
                return errorInfos.FirstOrDefault<string>();
            }
            return null;
        }

        public IEnumerable<string> Validate(bool Formatar=false)
        {
            foreach (var prop in this.GetType().GetProperties())
            {
                string err = ValidateProperty(prop.Name);
                if (!String.IsNullOrWhiteSpace(err))
                {
                    yield return prop.Name + ": " + err + ((Formatar) ? "<br>" : "").ToString();
                }
            }
        }
    }
}
```

Nesta classe está o segredo da validação, o método Validate(). Este método percorre todos os campos da nossa classe e verifica seu CustomAttribute(), procurando pelo ValidationAttribute, que é o nosso DataAnnotations, se o valor não for for válido, ele retorna a mensagem de erro que atribuímos ao campos e vai adicionando a uma lista, que poderemos usar em nossa camada de apresentação.

Adicionamos agora vamos adicionar a nossa classe de contexto:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;

namespace WindowsFormsValidacao
{
    public class Contexto : DbContext
    {
        public DbSet<Produto> Produto { get; set; }
    }
}
```

Agora vamos adicionar os campos em nosso formulário, que ficará desta forma:

![](/wp-content/uploads/2012/01/image_thumb17.png)

O TextBox (txtErros) abaixo do botão Salvar é onde iremos mostrar os erros.

Vamos adicionar um DataSource para podermos trabalhar com nossa classe Produto, para isto vá no menu Data/Add New DataSource e escolha Object:
  
![](/wp-content/uploads/2012/01/image_thumb18.png)

Depois escolha a classe produto:
  
![](/wp-content/uploads/2012/01/image_thumb19.png)

Agora você precisa ligar todos os campos TextBox do formulário aos campos da classe. Para fazer isto, clique sobre o TextBox, vá em propriedades/DataBindings/Text e escolha o campo correspondente ao controle. Faça isto para todos os controles:

![](/wp-content/uploads/2012/01/image_thumb20.png)

Após o primeiro campo, escolha os campos sempre a partir do bindingsource: 

![](/wp-content/uploads/2012/01/image_thumb21.png)

Agora vamos ao código do botão incluir, que simplesmente adiciona um novo objeto Produto vinculado a tela:

```csharp
private void btnNovo_Click(object sender, EventArgs e)
{
    produtoBindingSource.AddNew();
}
```

E por fim vamos ao código que valida os dados e depois insere no BD:

```csharp
private void btnSalvar_Click(object sender, EventArgs e)
{
    var db = new Contexto();
    db.Database.CreateIfNotExists();

    var pro = (Produto)produtoBindingSource.Current;
    var erros = pro.Validate();
    if (erros.Count() > 0)
    {
        txtErros.Text = "";
        foreach (var err in erros)
        {
            txtErros.Text += err + Environment.NewLine;
        }
    }
    else
    {
        db.Produto.Add(pro);
        db.SaveChanges();
        MessageBox.Show("Produto inserido!");
        produtoBindingSource.ResetCurrentItem();
    }
}
```

**Observação**: A criação do banco de dados neste ponto é meramente didática, para facilitar o exemplo e não é uma prática recomendável em uma aplicação em produção. 

Agora vamos recuperar o produto que está vinculado a tela e logo após vamos chamar o método Validate() que irá retornar a lista de erros que vamos exibir. . Recuperamos o Produto acessando a propriedade Current do BindingSource, mas como ela armazena somente objetos, precisamos converter o valor de Current para o tipo Produto e logo após isto chamamos a validação e caso não exista erros, inserimos o Produto no BD e atualizamos a tela. Os erros são mostrados no campo txtErros na tela. 

Você pode formatar a saída do erro modificando o método Validate() na classe ValidacaoEntidade.

Espero que este pequeno exemplo tenha mostrado o quanto é simples fazer validações mesmo em plataformas não tão novas, como o Windows Forms, e isto pode também ser utilizado para validar objetos em camadas separadas da aplicação.

Abraços e até a próxima.

  
Carlos dos Santos.
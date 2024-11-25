---
title: '.NET 9 agora suporta o OpenAPI nativamente'
date: 2024-11-25
author: carloscds
layout: post
categories:
  - C Sharp 
  - ASP.NET 
---
Na última semana foi lançado o .NET 9 durante o [.NET Conf 2024](https://www.dotnetconf.net/) e com ele muitas e muitas novidades na plataforma que renderiam facilmente diversos posts, mas dentre os muitos recursos anunciados, hoje vamos falar sobre documentação de APIs e suporte a Open API.

## Mas o que é o OpenAPI ?

É um padrão aberto para documentação de APIs, e é claro que você, como um bom desenvolvedor, quer documentar muito bem a sua API. Mas você pode estar pensando... Mas e o Swagger e o Scalar ? Ambos ainda são suportados, mas a Microsoft adotou o padrão da OpenAPI nos templates dos projetos.

No site oficial do projeto [OpenAPI](https://www.openapis.org/what-is-openapi) você pode entender melhor as motivações do padrão e como está o projeto. Mas entenda que a ideia basica é ter um mecanismo robusto para documentação de APIs, independente de linguagem.

### Vamos criar um projeto novo de WebAPI em .NET 9 

Primeiro você precisa atualizar seu Visual Studio ou baixar o .NET 9 do [site oficial do .Net](https://dotnet.microsoft.com/pt-br/).

Depois crie um projeto do tipo ASP.NET Core Web API e indique o .NET 9 como Framework. Não esqueça de marcar o suporte a OpenAPI:

![]( wp-content/uploads/2024/11/OpenAPI-CriandoProjeto.png)

Veja o código criado:

```csharp
public static void Main(string[] args)
{
    var builder = WebApplication.CreateBuilder(args);

    builder.Services.AddControllers();
    builder.Services.AddOpenApi(); // aqui adicionamos o suporte a OpenAPI

    var app = builder.Build();
    if (app.Environment.IsDevelopment())
    {
        app.MapOpenApi();
    }
    app.UseHttpsRedirection();
    app.UseAuthorization();
    app.MapControllers();
    app.Run();
}
```

Agora temos um novo Middleware chamado **AddOpenApi()**

Ao executar o projeto e adicionar ao final da URL: */openapi/v1.json*, no nosso caso: *https://localhost:7167/openapi/v1.json* você verá o mapeamento feito pelo OpenAPI.

```json
{
  "openapi": "3.0.1",
  "info": {
    "title": "SuporteOpenAPI | v1",
    "version": "1.0.0"
  },
  "servers": [
    {
      "url": "https://localhost:7167"
    },
    {
      "url": "http://localhost:5115"
    }
  ],
  "paths": {
    "/WeatherForecast": {
      "get": {
        "tags": [
          "WeatherForecast"
        ],
        "operationId": "GetWeatherForecast",
        "responses": {
          "200": {
            "description": "OK",
            "content": {
              "text/plain": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/WeatherForecast"
                  }
                }
              },
              "application/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/WeatherForecast"
                  }
                }
              },
              "text/json": {
                "schema": {
                  "type": "array",
                  "items": {
                    "$ref": "#/components/schemas/WeatherForecast"
                  }
                }
              }
            }
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "WeatherForecast": {
        "type": "object",
        "properties": {
          "date": {
            "type": "string",
            "format": "date"
          },
          "temperatureC": {
            "type": "integer",
            "format": "int32"
          },
          "temperatureF": {
            "type": "integer",
            "format": "int32"
          },
          "summary": {
            "type": "string",
            "nullable": true
          }
        }
      }
    }
  },
  "tags": [
    {
      "name": "WeatherForecast"
    }
  ]
}
```

### Mostrando o OpenAPI com Swagger

Ok, muito bom, mas como eu mostro isto de maneira gráfica para quem está consumindo minha API ? 

Existem diversas maneiras, mas vamos fazer com SwaggerUI ? Para isto vamos adicionar o pacote do SwaggerUI:

```cmd
dotnet add package Swashbuckle.AspNetCore.SwaggerUI
```
Veja que estamos adicionando apenas a UI, pois a geração da documentação está sendo feita pelo OpenAPI.

Depois de adicionar o pacote, vamos adicionar o comando para renderizarmos a UI do Swagger:

```csharp
app.UseSwaggerUI(options =>
{
    options.RoutePrefix = "swagger";
    options.SwaggerEndpoint("/openapi/v1.json", "OpenAPI V1");
}); 
```
Aqui o que muda para o Swagger tradicional é o endereço do json que contem a documentação, no caso estamos informando o caminho para o arquivo json do OpenAPI. E pronto!

Agora podemos acessar o endereço */swagger* e teremos a interface:
![]( wp-content/uploads/2024/11/OpenAPI-SwaggerUI.png)

### Considerações
A ideia em adotar o padrão OpenAPI é para padronizar a documentação das aplicações, criando estruturas mais coesas e intercambiáveis!

Aproveite e teste! Lembrando que você pode aplicar o padrão também em suas APIs existentes!

O código fonte completo da aplicaçao está no meu [GitHub](https://github.com/carloscds/CSharpSamples/tree/master/SuporteOpenAPI/SuporteOpenAPI).

Abraços e até a próxima!

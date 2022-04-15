# Busca Cep

Aplicação utilizando Elixir/Phoenix para buscar CEP.

# Rotas:

## Cep

### buscar CEP

- get `http://localhost:4000/api/v1/cep/{CEP}`


### Relatório CSV com CEPs

- POST `http://localhost:4000/api/v1/cep/report/{email}`

<br>


# Utilização

## O Phoenix é necessário para executar a API em modo desenvolvedor

```
mix local.hex

mix archive.install hex phx_new
```

## Instalação do projeto

Após clonar o projeto

```
mix deps.get
mix ecto.create
mix ecto.migrate

mix phx.server
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
